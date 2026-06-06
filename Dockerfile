FROM cm2network/steamcmd:root

ENV STEAMAPPID 4940
ENV STEAMAPP ns2
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}"
ENV SERVERDIR "${STEAMAPPDIR}/server"
ENV CONFIGDIR "${STEAMAPPDIR}/config"
ENV LOGDIR "${STEAMAPPDIR}/logs"
ENV MODDIR "${STEAMAPPDIR}/mods"

COPY entry.sh "${HOMEDIR}/entry.sh"

RUN set -x \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.21-1+deb11u1 \
		ca-certificates=20210119 \
		lib32z1=1:1.2.11.dfsg-2+deb11u2 \
		libncurses5:i386=6.2+20201114-2+deb11u1 \
		libbz2-1.0:i386=1.0.8-4 \
		libtinfo5:i386=6.2+20201114-2+deb11u1 \
		libcurl3-gnutls:i386=7.74.0-1.3+deb11u7 \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& mkdir -p "${SERVERDIR}" \
	&& mkdir -p "${CONFIGDIR}" \
	&& mkdir -p "${LOGDIR}" \
	&& mkdir -p "${MODDIR}" \
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" "${CONFIGDIR}" "${SERVERDIR}" "${LOGDIR}" "${MODDIR}" \
	&& rm -rf /var/lib/apt/lists/*

ENV NAME="NS2 Server" \
    PASSWORD="" \
    PORT="27015" \
    LIMIT="24" \
    SPECTATOR_LIMIT="0" \
    MAP="ns2_summit" \
    CONFIG_PATH="${CONFIGDIR}" \
    LOG_DIR="${LOGDIR}" \
    MOD_DIR="${MODDIR}"

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"] 