Return-Path: <linux-kselftest+bounces-35998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F739AEBEC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CFC1C62326
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210662EF641;
	Fri, 27 Jun 2025 17:56:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9272EE293;
	Fri, 27 Jun 2025 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046965; cv=none; b=S6EkANBZ25QMhkHSue0/OulzS/AUDuL7mIG01g1jzzu3qE4fm20nhpwAuqLuyGo8LtusBHVbUnxfLTeZrGHfnBiyIkpkMQNhWRGLrOZqIoyNnuxBmAyqq6MT7p3j1/foN5rtOHVFLjX4WPBDPGKHiAoeb3j3EQl4jB0ncPD4huc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046965; c=relaxed/simple;
	bh=D+oRPe93Nm/8lmSF6pVDNA/nCNLjVome6Fp+fkRvNWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ShhYfimZfU5EQsjd7a70dN9VlmoPZyCt7saoDVrPVgMeXEuqKyjXOdfMZZp29mSdlSDtSbd6Bv/R8EhClrVXHsRJmVpkgqGxmFEHMxZsSLOzg0y+ZYjCXGDF26V7/tw2+92MWYXbIoAMIwPIRps9jiaucwiUeb1BQ3NKeov6XBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0b6532345so663435366b.1;
        Fri, 27 Jun 2025 10:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751046961; x=1751651761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omLci4L9HXaOKKQZZQ7UbJZ8uawl1hkgxO5eUGCEDLc=;
        b=ucBCudnZ6pFG0cLFtf8uVPP/ebq/fcX+NRWq4oVChu3TPgqBiYUPm8cXuzWJH3a3Xo
         zY5foxF83BD2sHs2u55RgpPnBMJJgUiowUUWVRfzSFZw5lD0uDJPqJrclsYAQ+zKzqQ4
         2I3FPvcoVk2pcmyr42QQKsPjRh3luaFmY0nPK1JBPd01ORbrlq7nQnWbo4BFHy1QObzq
         xW7VZ63Zat019jPnAomSvfgvbictRbEKgC8ou9K6O9ehqnRu85OGpTrR5deMyFLfswOg
         y5m7m8Ju3mPL2pMbNHRVhJRXsjTO3D/N3FTCI8oehYCPWCi+ZfOB6uhwnRRxPIFmBHId
         rN0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlCkk5qHNKNwFengysdvXE92oiGl40oX11GNaqzFPqgLToVSTYaA6DoVE7/8RVyVQnnhFEFYiyxZ1LtrM=@vger.kernel.org, AJvYcCWtCL0X/Dty9aIer9E24Qc9iwyTPrubQbipF6TabBGQAJMXcbVwu7sm8bpnoQlCKHN8mkhmmq0vnSCn6RwmzeWL@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+bBYjzu71njR2gQ9T9Y919wS+MHuFodENHEn/EFTgURfmPtD
	Cm49pAHlGNYSpMuuhuJ+HOGN5SOpKo8DqPIWu0SxkXJKiu1UBO272HpY
X-Gm-Gg: ASbGncs/Dk/ZFrCm6wLsBRt+Q7LQptf8GmhyX7LIcvEEcjIxHjE+226kxiKFj2r4k3f
	lnmJbPJy3VsKmCsyMbFjJwl16XAq0mqh9Isb8WfBEVn3YkNjO4k1sMryMTH032cem219BGp64kd
	NwKDrTxr/RSGCT7WYSwWObGQYubY2xUaH7cK7R6ThaqB3uwv3IeNxdcLegWmsVFmtb2UaxO5LWr
	Z2RC5bsyBV5tuaMSJySokoAS/5ut6Gw/SZHAlyINxAmVulj96FYriJBjFob07dosys+zoeNEKCO
	3mSkdFYnRO579hSq5wy/APOqP7I+q9aeHRBdFZR3eHY4IPy4AP0faw==
X-Google-Smtp-Source: AGHT+IGrH0QZF2oANW/OIc+COjxvp38jMb0IoxvnRzvKqeOg3r2T0nzkH6r2PKDQkVIC0MkfI1MkYQ==
X-Received: by 2002:a17:906:f414:b0:ae0:ace9:67eb with SMTP id a640c23a62f3a-ae0d27323c7mr839223166b.14.1751046961215;
        Fri, 27 Jun 2025 10:56:01 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c01237sm166279066b.98.2025.06.27.10.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:56:00 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 27 Jun 2025 10:55:53 -0700
Subject: [PATCH net-next 7/7] selftests: net: Add IPv6 support to
 netconsole basic tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-netpoll_untagle_ip-v1-7-61a21692f84a@debian.org>
References: <20250627-netpoll_untagle_ip-v1-0-61a21692f84a@debian.org>
In-Reply-To: <20250627-netpoll_untagle_ip-v1-0-61a21692f84a@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=7410; i=leitao@debian.org;
 h=from:subject:message-id; bh=D+oRPe93Nm/8lmSF6pVDNA/nCNLjVome6Fp+fkRvNWU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoXtslR7u/LQusdmyg8dF/OMCnOd73/s1aQ3pEe
 zPCpHrXc/CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaF7bJQAKCRA1o5Of/Hh3
 bbQzD/9BUUyNWYZrg9sDZmaDAQ4738+rdYp9Ze0IGbN/EFKwm1cIUvJrIyXIrXVCYr/tp0SquM5
 bZW1VyuOTviy/O//9+xUhcQy1u+QmdPYe34Vfc5VvZnaNSORMuWnYrf+dr7F0KvIbJkAVlIwir1
 m7m37HMw0znLggeEY4/gTDrmdCPrrzOs9uY7Kua5Kd5kOF2eYgrGCGqiTyj6H528cVbVpS0LHS6
 MqThfVBmSECddrWKSQ7UcI9EDaK1Tybj84iwF2F9JPOOhxKwT8wrf4TFU6QgO2upbKGbSHj2GXv
 1m5QkLw1qpAhB5+LL05WKlKwYvnGITN8fxjcCcWIJeR0nXAwOApoNU5CGpctuz1s+PKFxRDHF0+
 rzhppeDoPqoCJIOoEb1jrb1EE/zpcV0zyiA0YwOPekv8BS1ZjZVDYOsQkWhbM7S30RIYC38ORFi
 Ev4piQmNCl5Xtln3WqPLIcVRE9R7T+P4oWIMy3JFwFGQytMnFIohXq9/oLwIQ2lCKI3NW1clCeP
 xVZHUnRfl7HHM+sRdlJohhtvqBqgJ7QfQwy1EvKP/gFUGKHSedYksUkRLzzdEGHt9PfWO0NyauC
 X8WECYWtC9MozsGb3f1LqakY+tbP7MPNbQi9rNng75vCxXMVg5//xzXuzv0IrZL1EPf3rJmCwqM
 rL2m/BE6Vt3sudA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add IPv6 support to the netconsole basic functionality tests by:

- Introducing separate IPv4 and IPv6 address variables (SRCIP4/SRCIP6,
  DSTIP4/DSTIP6) to replace the single SRCIP/DSTIP variables
- Adding select_ipv4_or_ipv6() function to choose protocol version
- Updating socat configuration to use UDP6-LISTEN for IPv6 tests
- Adding wait_for_port() wrapper to handle protocol-specific port waiting
- Expanding test matrix to run both basic and extended formats against
  both IPv4 and IPv6 protocols
- Improving cleanup to kill any remaining socat processes
- Adding sleep delays for better IPv6 packet handling reliability

The test now validates netconsole functionality across both IP versions,
improving test coverage for dual-stack network environments.

This test would avoid the regression fixed by commit f59902070269 ("net:
netpoll: Initialize UDP checksum field before checksumming")

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 74 ++++++++++++++++++++--
 .../testing/selftests/drivers/net/netcons_basic.sh | 52 ++++++++-------
 2 files changed, 96 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 3fcf85a345969..60f968713cad7 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -11,9 +11,11 @@ set -euo pipefail
 LIBDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 SRCIF="" # to be populated later
-SRCIP=192.0.2.1
+SRCIP4="192.0.2.1"
+SRCIP6="fc00::1"
 DSTIF="" # to be populated later
-DSTIP=192.0.2.2
+DSTIP4="192.0.2.2"
+DSTIP6="fc00::2"
 
 PORT="6666"
 MSG="netconsole selftest"
@@ -80,7 +82,23 @@ function configure_ip() {
 	ip link set "${SRCIF}" up
 }
 
+function select_ipv4_or_ipv6()
+{
+	local VERSION=${1}
+
+	if [[ "$VERSION" == "ipv6" ]]
+	then
+		DSTIP="${DSTIP6}"
+		SRCIP="${SRCIP6}"
+	else
+		DSTIP="${DSTIP4}"
+		SRCIP="${SRCIP4}"
+	fi
+}
+
 function set_network() {
+	local IP_VERSION=${1:-"ipv4"}
+
 	# setup_ns function is coming from lib.sh
 	setup_ns NAMESPACE
 
@@ -91,6 +109,7 @@ function set_network() {
 	# Link both interfaces back to back
 	link_ifaces
 
+	select_ipv4_or_ipv6 "${IP_VERSION}"
 	configure_ip
 }
 
@@ -119,6 +138,11 @@ function create_dynamic_target() {
 	fi
 
 	echo 1 > "${NETCONS_PATH}"/enabled
+
+	# This will make sure that the kernel was able to
+	# load the netconsole driver configuration. The console message
+	# gets more organized/sequential as well.
+	sleep 1
 }
 
 # Generate the command line argument for netconsole following:
@@ -179,9 +203,18 @@ function set_user_data() {
 
 function listen_port_and_save_to() {
 	local OUTPUT=${1}
+	local IPVERSION=${2:-"ipv4"}
+
+	if [ "${IPVERSION}" == "ipv4" ]
+	then
+		SOCAT_MODE="UDP-LISTEN"
+	else
+		SOCAT_MODE="UDP6-LISTEN"
+	fi
+
 	# Just wait for 2 seconds
 	timeout 2 ip netns exec "${NAMESPACE}" \
-		socat UDP-LISTEN:"${PORT}",fork "${OUTPUT}"
+		socat "${SOCAT_MODE}":"${PORT}",fork "${OUTPUT}"
 }
 
 # Only validate that the message arrived properly
@@ -263,8 +296,13 @@ function check_for_dependencies() {
 		exit "${ksft_skip}"
 	fi
 
-	if ip addr list | grep -E "inet.*(${SRCIP}|${DSTIP})" 2> /dev/null; then
-		echo "SKIP: IPs already in use. Skipping it" >&2
+	if ip addr list | grep -E "inet.*(${SRCIP4}|${DSTIP4})" 2> /dev/null; then
+		echo "SKIP: IPv4s already in use. Skipping it" >&2
+		exit "${ksft_skip}"
+	fi
+
+	if ip addr list | grep -E "inet.*(${SRCIP6}|${DSTIP6})" 2> /dev/null; then
+		echo "SKIP: IPv6s already in use. Skipping it" >&2
 		exit "${ksft_skip}"
 	fi
 }
@@ -278,11 +316,13 @@ function check_for_taskset() {
 
 # This is necessary if running multiple tests in a row
 function pkill_socat() {
-	PROCESS_NAME="socat UDP-LISTEN:6666,fork ${OUTPUT_FILE}"
+	PROCESS_NAME4="socat UDP-LISTEN:6666,fork ${OUTPUT_FILE}"
+	PROCESS_NAME6="socat UDP6-LISTEN:6666,fork ${OUTPUT_FILE}"
 	# socat runs under timeout(1), kill it if it is still alive
 	# do not fail if socat doesn't exist anymore
 	set +e
-	pkill -f "${PROCESS_NAME}"
+	pkill -f "${PROCESS_NAME4}"
+	pkill -f "${PROCESS_NAME6}"
 	set -e
 }
 
@@ -294,3 +334,23 @@ function check_netconsole_module() {
 		exit "${ksft_skip}"
 	fi
 }
+
+# A wrapper to translate protocol version to udp version
+function wait_for_port() {
+	local NAMESPACE=${1}
+	local PORT=${2}
+	IP_VERSION=${3}
+
+	if [ "${IP_VERSION}" == "ipv6" ]
+	then
+		PROTOCOL="udp6"
+	else
+		PROTOCOL="udp"
+	fi
+
+	wait_local_port_listen "${NAMESPACE}" "${PORT}" "${PROTOCOL}"
+	# even after the port is open, let's wait 1 second before writing
+	# otherwise the packet could be missed, and the test will fail. Happens
+	# more frequently on IPv6
+	sleep 1
+}
diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
index 40a6ac6191b8b..c627993dc8605 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -36,30 +36,36 @@ trap cleanup EXIT
 # Run the test twice, with different format modes
 for FORMAT in "basic" "extended"
 do
-	echo "Running with target mode: ${FORMAT}"
-	# Create one namespace and two interfaces
-	set_network
-	# Create a dynamic target for netconsole
-	create_dynamic_target "${FORMAT}"
-	# Only set userdata for extended format
-	if [ "$FORMAT" == "extended" ]
-	then
-		# Set userdata "key" with the "value" value
-		set_user_data
-	fi
-	# Listed for netconsole port inside the namespace and destination interface
-	listen_port_and_save_to "${OUTPUT_FILE}" &
-	# Wait for socat to start and listen to the port.
-	wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
-	# Send the message
-	echo "${MSG}: ${TARGET}" > /dev/kmsg
-	# Wait until socat saves the file to disk
-	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+	for IP_VERSION in "ipv6" "ipv4"
+	do
+		echo "Running with target mode: ${FORMAT} (${IP_VERSION})"
+		# Create one namespace and two interfaces
+		set_network "${IP_VERSION}"
+		# Create a dynamic target for netconsole
+		create_dynamic_target "${FORMAT}"
+		# Only set userdata for extended format
+		if [ "$FORMAT" == "extended" ]
+		then
+			# Set userdata "key" with the "value" value
+			set_user_data
+		fi
+		# Listed for netconsole port inside the namespace and destination interface
+		listen_port_and_save_to "${OUTPUT_FILE}" "${IP_VERSION}" &
+		# Wait for socat to start and listen to the port.
+		wait_for_port "${NAMESPACE}" "${PORT}" "${IP_VERSION}"
+		# Send the message
+		echo "${MSG}: ${TARGET}" > /dev/kmsg
+		# Wait until socat saves the file to disk
+		busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
 
-	# Make sure the message was received in the dst part
-	# and exit
-	validate_result "${OUTPUT_FILE}" "${FORMAT}"
-	cleanup
+		# Make sure the message was received in the dst part
+		# and exit
+		validate_result "${OUTPUT_FILE}" "${FORMAT}"
+		# kill socat in case it is still running
+		pkill_socat
+		cleanup
+		echo "${FORMAT} : ${IP_VERSION} : Test passed" >&2
+	done
 done
 
 trap - EXIT

-- 
2.47.1


