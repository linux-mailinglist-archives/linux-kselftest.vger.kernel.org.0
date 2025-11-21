Return-Path: <linux-kselftest+bounces-46154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC36C76C02
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A55CF35E313
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 00:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B4825A64C;
	Fri, 21 Nov 2025 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="X8WrfrvI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92C722ACEB
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 00:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684470; cv=none; b=Wf2jV7f3Gi1FhU8nMuAaORm0LaqDdkXsEb0yXS7PXOYgum+bZA/gMPdvelZV+u8u9eFnpfpmBSXDovCCAql3THdHwyypwRGOGVvXl9hEZ3fvjw+oJ5Oq0WMB/LS/CGZ1lTlzXpyALuCF4ywNnKPIL3yHMB6cUnTRkSzrQlwCTok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684470; c=relaxed/simple;
	bh=wzIEUuKnv+txbDiQ9t7tAnhQ9PBOxHOG17JNsn7lpOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NweGUgWqD08yhXIcfhBJvxiLxl3Nzkbaz+NY+/Qg3LDQ3myXWKO+pqOTJ5WflCUgMpZhNk86XSD12IQ5WryOih7pMtUEvEZh6R/+hdy2SELkSsMuIRxn4JD3O5QDXmGF8pNiYWIzXJbyT9+zUwfEPscA65fO+DJM4AqUqYcb6hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=X8WrfrvI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47774d3536dso11357725e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 16:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684465; x=1764289265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSNd4Avm6lQwgKm7f/SyOkQJKI4CyWW0ZF3B0N3EbUM=;
        b=X8WrfrvIzIo25oMWZdzb4YR3uHDqfx6+MkS0NQDEHyJ5ZxUg3ZW4Rj+SCrNeooR4Qo
         jnQl1IN+065yEO4xFKYTy6NN4ZIgbR3is8MU3K1PTayTJgHcLJkSXc9DrRBS4t3666q4
         ty0GVceF5Cpzh8STu3IlKaymt3HCWQu6a7udTI/S9MChkXoPonSFXYAXwbN/IyBqPgDM
         fGgAwTH2fV57GuNlv389gpepxKtGGabCNzz0WV+LzeS6vM38Yc21afb/xfbMRC6oKkr5
         PHiOsUBTqAXFaQfo69LfdZMdz2cdEOK6w/4UV2DXhU0gxoDUIesRFe4GAxjlm7uHsVJW
         573Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684465; x=1764289265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QSNd4Avm6lQwgKm7f/SyOkQJKI4CyWW0ZF3B0N3EbUM=;
        b=Xc5goFVPGCr7e3Vl3316YePnYpT9AUJ7vWe/QIGybB9aqMQor4QvAspRZB7Q+pwbeW
         N5TVxJTtUdtc9ZAHEiBMDKnEWv33eKK17SUnApOxXlCmzIx4Wi0OGDytMASFq7OR/h/t
         7/A/s/96HZjmqQH8MwDZn7IsBCvxl+RgkbACvL2qaG/6s2rTu/uLk8Oikv2SMgIPzWAC
         cMURhJU9FE8y7kG0t1I0qhvQvB9GBR7E6PccUFxJ+CHVsNdssblCZOPsoqXS/jWNu4bQ
         K+HN7LlYyxV9UCex3AkNmkXXWYDqasIMGRS0UOwjtOmlrI4XTIiJE247iJnRQTw1ZoqW
         QQfw==
X-Forwarded-Encrypted: i=1; AJvYcCWLEPaHOB9Crz9Ut8XthtEozCbcFicMQCK/FYUw2RV9u8Pz0OIXfhKBRd3Fg5RKh+bPzyVyuK6mU8oiwXZW/o8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPnttWZivMZ7YhsNclFvhQGzarwnOrf6haxiykXkozY++p0LJh
	4lNHEgly8WN54wYAv9a5NqnKw6G6VYM0aWB4VOLZEBgQbO3tQh6TphH63iaAfeaehaj3dfBcVob
	TR4mJjZYabPhggebNWd5/RUfiZaVa/YqMmX8Zkpj3tYlgM7OznsMUnDW4jihlDAs=
X-Gm-Gg: ASbGncs9h8D4alHHlQIGP+5vDL75oM3boKChvOim3b6dIfBoujWFQeTTp8p/wzpHJgz
	AoyM+k7ev40YRDx08IEmAknwastYGBRvM+RnoyDHpEWq5JINDlB9hzRjZpqwF4MzopL7usP7lt/
	WcTqIoIfQUBWq1TT+24Ejbw51n+dL1k7PXLLQlRQJFXB3BUYI4QRZHpftwOeSWGRKbUkCDYkVUp
	jcd9hR9mtZUq2HdiKK4ES6nItLvWG3ygST7yME68bWeB5n/EIvtGTGbb9CwqQEquj8kWJOUVgQ5
	bI0xIxmmX3z8w6s4LY+k3vdZG4kxgiSRGKvqk+gBVVyGUhei5+hn+sApq4QJmTfkeEQ7lFgpY62
	dRZMAMxfHoq45jiAjcWZmK6ANLjiN2Pt+SHII5jvQl4xuLjEDgcQ0rOJPFs6SdugLlUDZQ1tphZ
	eopRpVLVnPWtwJqsLUtNool7F8
X-Google-Smtp-Source: AGHT+IGC1jdJsJUrNBOMdKxWtMSyG3iJx7pb1kHhz4FTvjf68TZcADFqi1SGOQ7fNE2v/Pswen6Hew==
X-Received: by 2002:a05:600c:45ce:b0:46e:3b58:1b40 with SMTP id 5b1f17b1804b1-477c04c36a7mr3706745e9.4.1763684464827;
        Thu, 20 Nov 2025 16:21:04 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:21:04 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [RFC net-next 08/13] selftests: ovpn: add test for the FW mark feature
Date: Fri, 21 Nov 2025 01:20:39 +0100
Message-ID: <20251121002044.16071-9-antonio@openvpn.net>
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

Add a selftest to verify that the FW mark socket option is correctly
supported and its value propagated by ovpn.

The test adds and removes nftables DROP rules based on the mark value,
and checks that the rule counter aligns with the number of lost ping
packets.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/Makefile     |  1 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 26 +++++-
 tools/testing/selftests/net/ovpn/test-mark.sh | 81 +++++++++++++++++++
 3 files changed, 106 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-mark.sh

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index d3a070db0bb5..7c87c95d957e 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -31,6 +31,7 @@ TEST_PROGS := \
 	test-close-socket.sh \
 	test-float.sh \
 	test-large-mtu.sh \
+	test-mark.sh \
 	test-tcp.sh \
 	test.sh \
 # end of TEST_PROGS
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index baabb4c9120e..4df596d29b8c 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -6,6 +6,7 @@
  *  Author:	Antonio Quartulli <antonio@openvpn.net>
  */
 
+#include <stdint.h>
 #include <stdio.h>
 #include <inttypes.h>
 #include <stdbool.h>
@@ -133,6 +134,8 @@ struct ovpn_ctx {
 	enum ovpn_key_slot key_slot;
 	int key_id;
 
+	uint32_t mark;
+
 	const char *peers_file;
 };
 
@@ -521,6 +524,15 @@ static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
 		return ret;
 	}
 
+	if (ctx->mark != 0) {
+		ret = setsockopt(s, SOL_SOCKET, SO_MARK, (void *)&ctx->mark,
+				 sizeof(ctx->mark));
+		if (ret < 0) {
+			perror("setsockopt for SO_MARK");
+			return ret;
+		}
+	}
+
 	if (family == AF_INET6) {
 		opt = 0;
 		if (setsockopt(s, IPPROTO_IPV6, IPV6_V6ONLY, &opt,
@@ -1693,12 +1705,13 @@ static void usage(const char *cmd)
 	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
 
 	fprintf(stderr,
-		"* new_multi_peer <iface> <lport> <peers_file>: add multiple peers as listed in the file\n");
+		"* new_multi_peer <iface> <lport> <peers_file> [mark]: add multiple peers as listed in the file\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr, "\tlport: local UDP port to bind to\n");
 	fprintf(stderr,
 		"\tpeers_file: text file containing one peer per line. Line format:\n");
-	fprintf(stderr, "\t\t<peer_id> <tx_id> <raddr> <rport> <laddr> <lport> <vpnaddr>\n");
+	fprintf(stderr, "\t\t<peer_id> <tx_id> <raddr> <rport> <laddr> <lport> <vpnaddr> [mark]\n");
+	fprintf(stderr, "\tmark: socket FW mark value\n");
 
 	fprintf(stderr,
 		"* set_peer <iface> <peer_id> <keepalive_interval> <keepalive_timeout>: set peer attributes\n");
@@ -2241,6 +2254,15 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		}
 
 		ovpn->peers_file = argv[4];
+
+		ovpn->mark = 0;
+		if (argc > 5) {
+			ovpn->mark = strtoul(argv[5], NULL, 10);
+			if (errno == ERANGE || ovpn->mark > UINT32_MAX) {
+				fprintf(stderr, "mark value out of range\n");
+				return -1;
+			}
+		}
 		break;
 	case CMD_SET_PEER:
 		if (argc < 6)
diff --git a/tools/testing/selftests/net/ovpn/test-mark.sh b/tools/testing/selftests/net/ovpn/test-mark.sh
new file mode 100755
index 000000000000..a4bfe938118d
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -0,0 +1,81 @@
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
+MARK=1056
+
+source ./common.sh
+
+cleanup
+
+modprobe -q ovpn || true
+
+for p in $(seq 0 ${NUM_PEERS}); do
+	create_ns ${p}
+done
+
+for p in $(seq 0 3); do
+	setup_ns ${p} 5.5.5.$((${p} + 1))/24
+done
+
+# add peer0 with mark
+ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 1 ${UDP_PEERS_FILE} ${MARK}
+for p in $(seq 1 3); do
+	ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 ${ALG} 0 data64.key
+done
+
+for p in $(seq 1 3); do
+	add_peer ${p}
+done
+
+for p in $(seq 1 3); do
+	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} $((${p} + 9)) 60 120
+done
+
+sleep 1
+
+for p in $(seq 1 3); do
+	ip netns exec peer0 ping -qfc 500 -s 3000 -w 3 5.5.5.$((${p} + 1))
+done
+
+echo "Adding an nftables drop rule based on mark value ${MARK}"
+ip netns exec peer0 nft flush ruleset
+ip netns exec peer0 nft 'add table inet filter'
+ip netns exec peer0 nft 'add chain inet filter output { type filter hook output priority 0; policy accept; }'
+ip netns exec peer0 nft add rule inet filter output meta mark == ${MARK} counter drop
+
+DROP_COUNTER=$(ip netns exec peer0 nft list chain inet filter output | sed -n 's/.*packets \([0-9]*\).*/\1/p')
+sleep 1
+
+# ping should fail
+for p in $(seq 1 3); do
+	PING_OUTPUT=$(ip netns exec peer0 ping -qfc 500 -w 1 5.5.5.$((p+1)) 2>&1) && exit 1
+	echo "${PING_OUTPUT}"
+	LOST_PACKETS=$(echo "$PING_OUTPUT" | grep 'packets transmitted' | awk '{ print $1 }')
+	# increment the drop counter by the amount of lost packets
+	DROP_COUNTER=$(($DROP_COUNTER+$LOST_PACKETS))
+done
+
+# check if the final nft counter matches our counter
+TOTAL_COUNT=$(ip netns exec peer0 nft list chain inet filter output | sed -n 's/.*packets \([0-9]*\).*/\1/p')
+[ ${DROP_COUNTER} -eq ${TOTAL_COUNT} ] || exit 1
+
+echo "Removing the drop rule"
+ip netns exec peer0 nft flush ruleset
+sleep 1
+
+for p in $(seq 1 3); do
+	ip netns exec peer0 ping -qfc 500 -s 3000 -w 3 5.5.5.$((${p} + 1))
+done
+
+cleanup
+
+modprobe -r ovpn || true
-- 
2.51.2


