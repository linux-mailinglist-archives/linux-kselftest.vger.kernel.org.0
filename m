Return-Path: <linux-kselftest+bounces-36294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F22A9AF113A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BEC1C248A7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95713263C8F;
	Wed,  2 Jul 2025 10:06:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882DB26056A;
	Wed,  2 Jul 2025 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450818; cv=none; b=Miu2RJCJtq3HITrZ55BCz+SZY71zAXOehLcqkKOr5ncLxdQ8BxDXWHmG5XR7LJjTuEm5LpU14L+XD3ZoW/BSz2axkKIKNelNFV6m0pXOGY5M3n2+JKiGZrSPWhaDDndiArkuSnLyW2qrdJkWQEDwi5/WpBLp5jrTFmp7gvNeOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450818; c=relaxed/simple;
	bh=IEN/3Z+UWhk5jMFCChvc7TP1+KKOS3v2GWdCHvOX+KY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L4qiHL4KFQaniLk88OjBoDTAf8lOoSAWwjGuLK14wEAwVA9D6OPpD3stEk/BtfMYM84MUF0jq4lHpI5TzvKth2MLfWCg7jIWFl9hA9eAcNkmv0Y5ALPB6sm6WgcH8Z7oqMXALdIGbiPxUi+J4EtxpCWmRtJiZNXXYuXl7TT3F8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso6826560a12.0;
        Wed, 02 Jul 2025 03:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751450815; x=1752055615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyQkKEuXt0zodu2bhGjSzRNR14sGEqYd0//T8QpmKWk=;
        b=Tytx//JIq5dRdn0MpvJMSryjaQxTUXktyRqaxV1sKErrhaN5TEiLRm+YPuDQgo6GOL
         a1DRPcxkSr8X6/MIbG8nyEO4UHWcLAc1HvOUwZe8X/4OBbhCoSGmr8TeRxxclJxGoJya
         kysMrqFHw0zWtiwwUfDaWAGiIK14rOUuWLaY9dKRrWn/OojqCJlNVyfhuCxsbVKbRq1m
         O3DBqj4wH9jHojjk4GCZdxaYWV14pIpS+rtmUv2ZJU1+51XZt8IxzPgAEH81yNUXz5eK
         FG4qsDHw4pr1nLRFz9K1KBTDMK0ea4hBCFt88jBeTbB0N/NOjdHIllrgI7466xtKginP
         qq9g==
X-Forwarded-Encrypted: i=1; AJvYcCUztaZAw2v8C2RuDg5Hmkcv8M92Mf17cXOta4Z75ydyJ4VZUTBDOYAs0tsnlX5dxNxPndH1vslbRUye5OI=@vger.kernel.org, AJvYcCXk/GWbGesFLXWlwf4/NX5JFSdTjUo1laK86brJGImTbHAJCLuw2XRaz3Itl+q0kbCWmfN8175Xi5qbKiBK2dTK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0AsxTsc5UjK19r+a2m4BrIsdsGwVtu71W/js6hO6abmHREypZ
	sxAcOvjNsTPLjZ55r0qGWuWl8Apv9mxNYRqyWLyFduPReEIZo65mKs5IuOdtpg==
X-Gm-Gg: ASbGncualCushneBSbUSgsCO1HIXbIPgt/6EX4WdKiAAaYLEeeUos1QMrXx7voutnRV
	TB0CGHgPwlm7cC6IRCbmmwyS0Vq4NHX+YuUdhNKUURbKdnKeShv9+MxAxOc68ZksE7NidQS+qAR
	rjuAJAcG6Kez+s8XXJHLna5HRrJcF/qxsa+Yl97tcxypIJY27UflTUUmZ0+xYgmyMqOLf8rbiIq
	JNr2+xnYD5jaoNGtfcsSDIBhK5ljhkqZ9S9xtNhw9gFnFqzMlG4S5EGt/6HfNVyW0lLOs1koxW0
	xyXM5vYubILM+ekvOZbEeC32XYB/dxQNd5lHp5BKp3kaWEe5CuDMV6KCOfDTv/c=
X-Google-Smtp-Source: AGHT+IHVRuZTYecb/ojIzCm6KbwYGWvp3+E8ZT5TXJcKXjI5OfttPdRkBQnK64YkfkrY5Qm+GL0YsA==
X-Received: by 2002:a17:906:5604:b0:ae0:dd95:1991 with SMTP id a640c23a62f3a-ae3c2c37f41mr188044066b.51.1751450814294;
        Wed, 02 Jul 2025 03:06:54 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363a167sm1036631366b.21.2025.07.02.03.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:06:53 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 02 Jul 2025 03:06:39 -0700
Subject: [PATCH net-next v2 7/7] selftests: net: Add IPv6 support to
 netconsole basic tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-netpoll_untagle_ip-v2-7-13cf3db24e2b@debian.org>
References: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
In-Reply-To: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=7464; i=leitao@debian.org;
 h=from:subject:message-id; bh=IEN/3Z+UWhk5jMFCChvc7TP1+KKOS3v2GWdCHvOX+KY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZQSyTcY3cKY0Nh/T8PKgBSSLHVphn1elq+VN6
 HLMeoRIaYWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGUEsgAKCRA1o5Of/Hh3
 bYaCD/9r8SJHY5sP1Ex54og5L6j1zx2NvmEDRT1z7LE7YbNO8oLSgoDiZC1qiSrh2Al5KVHZFCc
 bBdiEt0EU1f2Trv1AkxgSmtrzu4yoCVS96PrRZJoU8gpFta9j5Qx+qHEtkea11G/nOkSvflOM/c
 pjZI3F5RYJQe61WmUDwcW2OGWR8IrDY1hdADFlQab94A/Ngr3M0MyGMSQ7uvAKYWnLG1w692LUU
 hwSqIZbR+ZF7SYlJP0hyxcK6YbhF+jYJ6x7izwQKe3mHYaipvr2sYyxUwCtT5U3beUMCw1WSFRi
 hvAlU7xE0dcCIldMQh1rsJtDib7xTZly/s0E5GTsVnEe094c1bKzI7MH2D0s/c/e5Dq9ERQ5ysm
 zbZDcJxRzWrSp0qAMNpC8eSnE1YXngEY8DJBK2JkRVi4Pv4Fx0WxwucvHLokDRHwoRUUNmMyFEy
 9pmPspm+KyzS9JbdutuDj92m0mPj/DZCOhi0JgbDHX+NYadRxrFGN5CSXdzeBnV+geC+8BfWZgY
 ZJyud33muL+PaCv0+msspl7OtX+OkZbAMqEcQRdyW/z6OiqHYvMUTNgl3tqmbQhNMMijZxeDmae
 YPE1tysAi1hILuhsVDZcKBzE5hfVb3GcoSGtAhPHqMbTs9DZA3vNWVrcDpvHV0POyRE3hYApZcq
 kn1DX2edtu6wb3Q==
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
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 76 ++++++++++++++++++++--
 .../testing/selftests/drivers/net/netcons_basic.sh | 53 ++++++++-------
 2 files changed, 99 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 3fcf85a345969..258af805497b4 100644
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
@@ -263,8 +296,15 @@ function check_for_dependencies() {
 		exit "${ksft_skip}"
 	fi
 
-	if ip addr list | grep -E "inet.*(${SRCIP}|${DSTIP})" 2> /dev/null; then
-		echo "SKIP: IPs already in use. Skipping it" >&2
+	REGEXP4="inet.*(${SRCIP4}|${DSTIP4})"
+	REGEXP6="inet.*(${SRCIP6}|${DSTIP6})"
+	if ip addr list | grep -E "${REGEXP4}" 2> /dev/null; then
+		echo "SKIP: IPv4s already in use. Skipping it" >&2
+		exit "${ksft_skip}"
+	fi
+
+	if ip addr list | grep -E "${REGEXP6}" 2> /dev/null; then
+		echo "SKIP: IPv6s already in use. Skipping it" >&2
 		exit "${ksft_skip}"
 	fi
 }
@@ -278,11 +318,13 @@ function check_for_taskset() {
 
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
 
@@ -294,3 +336,23 @@ function check_netconsole_module() {
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
index 40a6ac6191b8b..a3446b5699764 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -36,30 +36,37 @@ trap cleanup EXIT
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
+		# Listed for netconsole port inside the namespace and
+		# destination interface
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


