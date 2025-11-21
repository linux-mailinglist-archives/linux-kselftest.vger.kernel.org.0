Return-Path: <linux-kselftest+bounces-46158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD510C76C1A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DE43358837
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 00:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46272270557;
	Fri, 21 Nov 2025 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YTq3nnnS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954EA258ECB
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684474; cv=none; b=tTj1fYXPtVRUnlBfcsGWg96AWy8zE3RvtMHY6rm64V6Pkw1rGlVlh4XPXC8mJIf9xG3dtR7eyBIEkDGNxJbJOWAcWdlu5Ht18ncDBdBdx69BPiBfiVVOthgwWyN5BAMUTWbR0e23iKIhnqcgqxuJX4NsM498Q5jeZbX75xZhKJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684474; c=relaxed/simple;
	bh=849WOWRP3JJMleWDPrOiqnQVYYfHzdSA1nMA/fJl50o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuczwBRtf6/GNDyU0dJ9uMZ2mMOev7oGNXRiPzKruWtRaGxsToZ3/sJ04FX/YPR7+CcjUXGzHASzZcdXctVbguPCCwBqyF0ssindKj7dfhTd3RFfrCaLonfWdRhaHiQlpmoJg4WjM0ZVuBuFP1H9MyvPZ8jRVe5dkFhuZ8RTkyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YTq3nnnS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so10341525e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 16:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684470; x=1764289270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWOMK9ygRLLvg/BClbIMmBQZdTSwy/r4SSSXX/AhkSU=;
        b=YTq3nnnSjafI/R/ppROgckuHx2q5wM/uKqIdhiENJCu772QHt3J443VRdFvpt3BQE5
         MoDTm05HaD2wj++d1uxN0hP2yrtD8qW7PTXby/pCFICbsYVI0ujHiT3S+EQWamubFGOR
         L3xZF0vfIUBrxlSOT9SQSLy/X2A2iglRn3IXPwwNRdWEHIGIYw+BP/FTOCAlrkeZWPB8
         1NdJeB8V1PXehI2bayg8bgdov5UNYnJhADGTepGxjwfdhptDX4o9U0gaYa6VLCop//Ak
         +WKsMhy1ChcPaa58O9Ilo0+3vN5ptuc1RqUeIpcokqdNOArvu5ubNyHnZKZTtJDvkJXI
         aSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684470; x=1764289270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yWOMK9ygRLLvg/BClbIMmBQZdTSwy/r4SSSXX/AhkSU=;
        b=wSDVUhDA+6Cwp4J7mp1od3qnnO/X1v1D+5xhTgHpYFnmpvX6Q/8mhtxn9Z43yHJ/5s
         43lTeiSYeSD7OLAb2qmBbsaOGXNQoY8a0lY1kYosyJcvx7ROWUTbzqiQ9R8IEq3qLHHP
         TUVg2kWZOawhFUayGN67fJGiicoVITUL+ab+iJRRi3tM/aCrpdJj0IdEDLtb36zN0323
         o4LZcm10T/zOBDOT/z8294L9fgFRKinuLKh3/paRw2jVwAG/YjLPgueoLWqSC1PlA7ZY
         Q1Uc+aB1R0RQ4Zll9AMDHWsa4k5vuS7+YUlnUUeEAzcxNCuoveF6YxrZA81ZzVsSJPtg
         ukjg==
X-Forwarded-Encrypted: i=1; AJvYcCVTn62cf/ADk+TqYAepeyPMGw26h36HbmrI8GPJnjxboezrh8gWL/hYQpiEQ3x9IPa2heBz73/mNjoRSx1UaCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHkglAt5j4ki8tnFmNIXDNm+qX60YSOtiNnP4EGs2T+27Mo5nj
	uJyvOa3MeQBQK3VWXJVXtyyFG6j9R7U1GV48hGzYVKwmdXKzY9lLPeKmi1wE+QrO3g7hvWmjtPm
	2Aqw8YRs7nJtd1QUInChNcHcmQVLdMJAgfektMJTFuMboCDK3SRiF8rN2PZmanww=
X-Gm-Gg: ASbGncsmLOQtzA2ZOzfFQ3165IBKOaVXqFAZxaycPXwaDlddiLdIZTyiW5UTSovPoAx
	6wuvzcK6yX6RWmSH1RrxLuBFsHMJy+ccoKqkhOwDiFSNJrJJNlivCU1fPfKpDbShx/MgqOgr0Fb
	D6F6XsiI5VL+9G3X662gXbioU18tRbjBPCabsrXKAYwiADd/RdAXaJEvuhwXBmdWVq2zX86w7hS
	KwazcwysdDA/T00r5Nr46/9v0hsGH5bar0rk0xaKw2UHthLFo7DzD8KrxnIjXk7WWJwiIl34xPE
	EczunviH+yv6kAlKzJMdIPh3q70yIZrpOg58EQk2ZYNUzipRflESLPCkwA5eiA8dhZwZRAPNRSj
	YIqt+F7B8MQrCs8BGte1U+jmH66BuoqQIxKJZkmc5HDCZ+QmIsplXNI1CtsX2G3Z8Y2ds02LPpf
	vD2rW23MuhpaMmMX3Vevu5MdD9
X-Google-Smtp-Source: AGHT+IEsGcNz2n1/ubresf7uFbewKrO+sLZ9s6pti8NX7KmSXGXK/667M9/RU64XM7dlQ6m5r1pEJA==
X-Received: by 2002:a05:600c:4685:b0:477:7768:8da4 with SMTP id 5b1f17b1804b1-477c10c84eamr1658275e9.7.1763684469794;
        Thu, 20 Nov 2025 16:21:09 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:21:09 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [RFC net-next 11/13] selftests: ovpn: add test for bound device
Date: Fri, 21 Nov 2025 01:20:42 +0100
Message-ID: <20251121002044.16071-12-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251121002044.16071-1-antonio@openvpn.net>
References: <20251121002044.16071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

Add a selftest to verify that when a socket is bound to a device, UDP
traffic from ovpn is correctly routed through the specified interface.

The test sets up a P2P session between two peers in separate network
namespaces, connected via two veth pairs. It binds to both veth
interfaces and uses tcpdump to confirm that traffic flows through the
expected paths.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/Makefile     |   1 +
 tools/testing/selftests/net/ovpn/common.sh    |   6 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c   |  39 +++++--
 tools/testing/selftests/net/ovpn/test-bind.sh | 103 ++++++++++++++++++
 tools/testing/selftests/net/ovpn/test-mark.sh |   2 +-
 5 files changed, 137 insertions(+), 14 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-bind.sh

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index 7c87c95d957e..f219d87e2c44 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -26,6 +26,7 @@ LDLIBS += $(NL_LDLIBS)
 TEST_FILES = common.sh
 
 TEST_PROGS := \
+	test-bind.sh \
 	test-chachapoly.sh \
 	test-close-socket-tcp.sh \
 	test-close-socket.sh \
diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index d926413c9f16..c802e4e50054 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -66,9 +66,11 @@ setup_listener() {
 }
 
 add_peer() {
+	dev=${2:-"any"}
+
 	if [ "${PROTO}" == "UDP" ]; then
 		if [ ${1} -eq 0 ]; then
-			ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 1 ${UDP_PEERS_FILE}
+			ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 ${dev} 1 ${UDP_PEERS_FILE}
 
 			for p in $(seq 1 ${NUM_PEERS}); do
 				ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 ${ALG} 0 \
@@ -79,7 +81,7 @@ add_peer() {
 			RADDR=$(awk "NR == ${1} {print \$3}" ${UDP_PEERS_FILE})
 			RPORT=$(awk "NR == ${1} {print \$4}" ${UDP_PEERS_FILE})
 			LPORT=$(awk "NR == ${1} {print \$6}" ${UDP_PEERS_FILE})
-			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} ${TX_ID} ${1} \
+			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} ${dev} ${TX_ID} ${1} \
 				${LPORT} ${RADDR} ${RPORT}
 			ip netns exec peer${1} ${OVPN_CLI} new_key tun${1} ${TX_ID} 1 0 \
 				${ALG} 1 data64.key
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 4df596d29b8c..6d84380c76ad 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -135,6 +135,7 @@ struct ovpn_ctx {
 	int key_id;
 
 	uint32_t mark;
+	const char *bind_dev;
 
 	const char *peers_file;
 };
@@ -542,6 +543,14 @@ static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
 		}
 	}
 
+	if (ctx->bind_dev) {
+		if (setsockopt(s, SOL_SOCKET, SO_BINDTODEVICE, ctx->bind_dev,
+			       strlen(ctx->bind_dev) + 1) != 0) {
+			perror("setsockopt for SO_BINDTODEVICE");
+			return -1;
+		}
+	}
+
 	ret = bind(s, (struct sockaddr *)&local_sock, sock_len);
 	if (ret < 0) {
 		perror("cannot bind socket");
@@ -1693,8 +1702,10 @@ static void usage(const char *cmd)
 		"\tkey_file: file containing the symmetric key for encryption\n");
 
 	fprintf(stderr,
-		"* new_peer <iface> <peer_id> <tx_id> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
+		"* new_peer <iface> <dev> <peer_id> <tx_id> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr,
+		"\tdev: transport interface name to bind to, supports 'any'\n");
 	fprintf(stderr, "\tlport: local UDP port to bind to\n");
 	fprintf(stderr,
 		"\tpeer_id: peer ID found in data packets received from this peer\n");
@@ -1705,8 +1716,10 @@ static void usage(const char *cmd)
 	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
 
 	fprintf(stderr,
-		"* new_multi_peer <iface> <lport> <peers_file> [mark]: add multiple peers as listed in the file\n");
+		"* new_multi_peer <iface> <dev> <lport> <peers_file> [mark]: add multiple peers as listed in the file\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr,
+		"\tdev: transport interface name to bind to, supports 'any'\n");
 	fprintf(stderr, "\tlport: local UDP port to bind to\n");
 	fprintf(stderr,
 		"\tpeers_file: text file containing one peer per line. Line format:\n");
@@ -2227,37 +2240,41 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		}
 		break;
 	case CMD_NEW_PEER:
-		if (argc < 7)
+		if (argc < 8)
 			return -EINVAL;
 
-		ovpn->lport = strtoul(argv[5], NULL, 10);
+		ovpn->bind_dev = strcmp(argv[3], "any") == 0 ? NULL : argv[3];
+
+		ovpn->lport = strtoul(argv[6], NULL, 10);
 		if (errno == ERANGE || ovpn->lport > 65535) {
 			fprintf(stderr, "lport value out of range\n");
 			return -1;
 		}
 
-		const char *vpnip = (argc > 8) ? argv[8] : NULL;
+		const char *vpnip = (argc > 9) ? argv[9] : NULL;
 
-		ret = ovpn_parse_new_peer(ovpn, argv[3], argv[4], argv[6], argv[7],
+		ret = ovpn_parse_new_peer(ovpn, argv[4], argv[5], argv[7], argv[8],
 					  vpnip);
 		if (ret < 0)
 			return -1;
 		break;
 	case CMD_NEW_MULTI_PEER:
-		if (argc < 5)
+		if (argc < 6)
 			return -EINVAL;
 
-		ovpn->lport = strtoul(argv[3], NULL, 10);
+		ovpn->bind_dev = strcmp(argv[3], "any") == 0 ? NULL : argv[3];
+
+		ovpn->lport = strtoul(argv[4], NULL, 10);
 		if (errno == ERANGE || ovpn->lport > 65535) {
 			fprintf(stderr, "lport value out of range\n");
 			return -1;
 		}
 
-		ovpn->peers_file = argv[4];
+		ovpn->peers_file = argv[5];
 
 		ovpn->mark = 0;
-		if (argc > 5) {
-			ovpn->mark = strtoul(argv[5], NULL, 10);
+		if (argc > 6) {
+			ovpn->mark = strtoul(argv[6], NULL, 10);
 			if (errno == ERANGE || ovpn->mark > UINT32_MAX) {
 				fprintf(stderr, "mark value out of range\n");
 				return -1;
diff --git a/tools/testing/selftests/net/ovpn/test-bind.sh b/tools/testing/selftests/net/ovpn/test-bind.sh
new file mode 100755
index 000000000000..fd7c3c8fdf63
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-bind.sh
@@ -0,0 +1,103 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020-2025 OpenVPN, Inc.
+#
+#	Author:	Ralf Lici <ralf@mandelbit.com>
+#		Antonio Quartulli <antonio@openvpn.net>
+
+#set -x
+set -e
+
+PROTO=UDP
+source ./common.sh
+
+cleanup
+
+modprobe -q ovpn || true
+
+# setup a P2P session between peer1 and peer2
+
+ip netns add peer1
+ip netns add peer2
+
+ip link add veth1 netns peer1 type veth peer name veth1 netns peer2
+ip link add veth2 netns peer1 type veth peer name veth2 netns peer2
+
+ip -n peer1 addr add 10.10.10.1/24 dev veth1
+ip -n peer1 link set veth1 up
+
+ip -n peer1 addr add 20.20.20.1/24 dev veth2
+ip -n peer1 link set veth2 up
+
+ip -n peer2 addr add 10.10.10.2/24 dev veth1
+ip -n peer2 link set veth1 up
+
+ip -n peer2 addr add 20.20.20.2/24 dev veth2
+ip -n peer2 link set veth2 up
+
+ip netns exec peer1 ${OVPN_CLI} new_iface tun1 P2P
+ip netns exec peer2 ${OVPN_CLI} new_iface tun2 P2P
+
+ip -n peer1 addr add 5.5.5.1 dev tun1
+ip -n peer1 link set tun1 up
+ip -n peer2 addr add 5.5.5.2 dev tun2
+ip -n peer2 link set tun2 up
+
+ip -n peer1 route add 5.5.5.0/24 dev tun1
+ip -n peer2 route add 5.5.5.0/24 dev tun2
+
+run_bind_test() {
+	dev1=${1}
+	dev2=${2}
+	raddr4_peer1=${3}
+	raddr4_peer2=${4}
+
+	touch /tmp/ovpn-bind1.log
+	touch /tmp/ovpn-bind2.log
+
+	ip netns exec peer1 ${OVPN_CLI} del_peer tun1 1 2>/dev/null || true
+	ip netns exec peer2 ${OVPN_CLI} del_peer tun2 10 2>/dev/null || true
+
+	# close any active socket
+	killall $(basename ${OVPN_CLI}) 2>/dev/null || true
+
+	ip netns exec peer1 ${OVPN_CLI} new_peer tun1 ${dev1} 1 10 1 ${raddr4_peer1} 1
+	ip netns exec peer1 ${OVPN_CLI} new_key tun1 1 1 0 ${ALG} 0 data64.key
+	ip netns exec peer2 ${OVPN_CLI} new_peer tun2 ${dev2} 10 1 1 ${raddr4_peer2} 1
+	ip netns exec peer2 ${OVPN_CLI} new_key tun2 10 1 0 ${ALG} 1 data64.key
+
+	ip netns exec peer1 ${OVPN_CLI} set_peer tun1 1 60 120
+	ip netns exec peer2 ${OVPN_CLI} set_peer tun2 10 60 120
+
+	timeout 2 ip netns exec peer1 tcpdump -i veth1 "${PROTO,,}" port 1 -n -q > /tmp/ovpn-bind1.log &
+	tcpdump1_pid=$!
+	timeout 2 ip netns exec peer1 tcpdump -i veth2 "${PROTO,,}" port 1 -n -q > /tmp/ovpn-bind2.log &
+	tcpdump2_pid=$!
+	sleep 0.5
+
+	ip netns exec peer1 ping -qfc 50 -w 1 5.5.5.2
+
+	wait ${tcpdump1_pid} || true
+	wait ${tcpdump2_pid} || true
+}
+
+run_bind_test veth1 any 10.10.10.2 10.10.10.1
+[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -ge 100 ]
+[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -eq 0 ]
+
+run_bind_test veth2 any 20.20.20.2 20.20.20.1
+[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -ge 100 ]
+[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -eq 0 ]
+
+run_bind_test any veth1 10.10.10.2 10.10.10.1
+[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -ge 100 ]
+[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -eq 0 ]
+
+run_bind_test any veth2 20.20.20.2 20.20.20.1
+[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -ge 100 ]
+[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -eq 0 ]
+
+cleanup
+
+modprobe -r ovpn || true
+
diff --git a/tools/testing/selftests/net/ovpn/test-mark.sh b/tools/testing/selftests/net/ovpn/test-mark.sh
index a4bfe938118d..c2600bb22e2c 100755
--- a/tools/testing/selftests/net/ovpn/test-mark.sh
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -26,7 +26,7 @@ for p in $(seq 0 3); do
 done
 
 # add peer0 with mark
-ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 1 ${UDP_PEERS_FILE} ${MARK}
+ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 any 1 ${UDP_PEERS_FILE} ${MARK}
 for p in $(seq 1 3); do
 	ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 ${ALG} 0 data64.key
 done
-- 
2.51.2


