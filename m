Return-Path: <linux-kselftest+bounces-232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A383A7EE860
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 21:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11755B20462
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 20:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7724645B;
	Thu, 16 Nov 2023 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyxaOChf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9931A7;
	Thu, 16 Nov 2023 12:34:55 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77ba6d5123fso208029585a.0;
        Thu, 16 Nov 2023 12:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700166895; x=1700771695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6g6oaJ0Hm2Vty99oHxK4ej8qfGeT8aSJCQPslFuVsvA=;
        b=IyxaOChfh/67PBZLkB1pfTMVZtnfhN8RAiUl2btlX35j/QST3enXF3kd06adFkWRWy
         PVBOhpURGaR+cO+sSspZ+BO6mQFIEsoTW0ArdsswSyHkcX9P7ASa39vP+8oU0spPrtOz
         zsUxX22o4s2W6q/0oezXRs5y3u0Pu+gmHaXgAUzkkMicjYxYsfXl32EGDJQxisAKI6uT
         YyNjPrFvj70skyKo0jCtej9hCyQl+JZKBNn9Ygm9phAV85OYcOY7EaxNA6VP0sHXLiEl
         D+Sp/kiF8aEVLI7j3w9AR/fe5W6Fpk5I/dVkeythCdVLQ4+qOCFdtm+2601pGdF7WcXn
         gBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700166895; x=1700771695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6g6oaJ0Hm2Vty99oHxK4ej8qfGeT8aSJCQPslFuVsvA=;
        b=PyERnjS4MObvH2Qkxv4V0eBScvINx+405BDEYAMb7vggCNwbwLdZWOXMGEfRQerBD9
         ACuCrBBUTVvO6lFxR4gTAZWOJAtfMDn1waAB/VJ1aqzD4ie8jiCsI+mYEZv1UTr/R7Oq
         E/qZ3sxRq5JNIfkXlQA6ryY2ECNKVbnMrVs14Y7wplo8w9SHz1YPV6dy6F3CQRL8M7gP
         6/qK0dNT5h8zlnbbvlixqxivzSPWNpOvEjZvg9p5lQgQcrBA3FOTytVc2DQ3rlE2iohd
         jEFtN/bWTKiVnyEGWSHBiW/v5khaHr21XbuYUUd6h3B19PKRHXLREcKB7cHyAqQv0j+b
         AZJA==
X-Gm-Message-State: AOJu0YzrwreJPGKqIUGbPLzBX5iWteCeOOFffdNyzIzzP0amUBTWFlBS
	DQzT3dfxsZDEaAjweoKwuG/TA8jHhHI=
X-Google-Smtp-Source: AGHT+IG9hkm2xMBJmOfvTUDgGbGyyb+OE3xQQpu9xsL86OINxvmx3admZ94se6wlBQ+LM019x7OVDQ==
X-Received: by 2002:ad4:4047:0:b0:66d:870:771e with SMTP id r7-20020ad44047000000b0066d0870771emr4372236qvp.13.1700166894600;
        Thu, 16 Nov 2023 12:34:54 -0800 (PST)
Received: from willemb.c.googlers.com.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id eh2-20020a056214186200b0065b22afe53csm52463qvb.94.2023.11.16.12.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 12:34:54 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests: net: verify fq per-band packet limit
Date: Thu, 16 Nov 2023 15:34:43 -0500
Message-ID: <20231116203449.2627525-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Commit 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR
scheduling") introduces multiple traffic bands, and per-band maximum
packet count.

Per-band limits ensures that packets in one class cannot fill the
entire qdisc and so cause DoS to the traffic in the other classes.

Verify this behavior:
  1. set the limit to 10 per band
  2. send 20 pkts on band A: verify that 10 are queued, 10 dropped
  3. send 20 pkts on band A: verify that  0 are queued, 20 dropped
  4. send 20 pkts on band B: verify that 10 are queued, 10 dropped

Packets must remain queued for a period to trigger this behavior.
Use SO_TXTIME to store packets for 100 msec.

The test reuses existing upstream test infra. The script is a fork of
cmsg_time.sh. The scripts call cmsg_sender.

The test extends cmsg_sender with two arguments:

* '-P' SO_PRIORITY
  There is a subtle difference between IPv4 and IPv6 stack behavior:
  PF_INET/IP_TOS        sets IP header bits and sk_priority
  PF_INET6/IPV6_TCLASS  sets IP header bits BUT NOT sk_priority

* '-n' num pkts
  Send multiple packets in quick succession.
  I first attempted a for loop in the script, but this is too slow in
  virtualized environments, causing flakiness as the 100ms timeout is
  reached and packets are dequeued.

Also do not wait for timestamps to be queued unless timestamps are
requested.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/Makefile          |  1 +
 tools/testing/selftests/net/cmsg_sender.c     | 50 ++++++++++------
 .../testing/selftests/net/fq_band_pktlimit.sh | 57 +++++++++++++++++++
 3 files changed, 91 insertions(+), 17 deletions(-)
 create mode 100755 tools/testing/selftests/net/fq_band_pktlimit.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5b2aca4c5f10..9274edfb76ff 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -91,6 +91,7 @@ TEST_PROGS += test_bridge_neigh_suppress.sh
 TEST_PROGS += test_vxlan_nolocalbypass.sh
 TEST_PROGS += test_bridge_backup_port.sh
 TEST_PROGS += fdb_flush.sh
+TEST_PROGS += fq_band_pktlimit.sh
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index 24b21b15ed3f..8d7575389f58 100644
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -45,11 +45,13 @@ struct options {
 	const char *host;
 	const char *service;
 	unsigned int size;
+	unsigned int num_pkt;
 	struct {
 		unsigned int mark;
 		unsigned int dontfrag;
 		unsigned int tclass;
 		unsigned int hlimit;
+		unsigned int priority;
 	} sockopt;
 	struct {
 		unsigned int family;
@@ -72,6 +74,7 @@ struct options {
 	} v6;
 } opt = {
 	.size = 13,
+	.num_pkt = 1,
 	.sock = {
 		.family	= AF_UNSPEC,
 		.type	= SOCK_DGRAM,
@@ -112,7 +115,7 @@ static void cs_parse_args(int argc, char *argv[])
 {
 	int o;
 
-	while ((o = getopt(argc, argv, "46sS:p:m:M:d:tf:F:c:C:l:L:H:")) != -1) {
+	while ((o = getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l:L:H:")) != -1) {
 		switch (o) {
 		case 's':
 			opt.silent_send = true;
@@ -138,7 +141,9 @@ static void cs_parse_args(int argc, char *argv[])
 				cs_usage(argv[0]);
 			}
 			break;
-
+		case 'P':
+			opt.sockopt.priority = atoi(optarg);
+			break;
 		case 'm':
 			opt.mark.ena = true;
 			opt.mark.val = atoi(optarg);
@@ -146,6 +151,9 @@ static void cs_parse_args(int argc, char *argv[])
 		case 'M':
 			opt.sockopt.mark = atoi(optarg);
 			break;
+		case 'n':
+			opt.num_pkt = atoi(optarg);
+			break;
 		case 'd':
 			opt.txtime.ena = true;
 			opt.txtime.delay = atoi(optarg);
@@ -410,6 +418,10 @@ static void ca_set_sockopts(int fd)
 	    setsockopt(fd, SOL_IPV6, IPV6_UNICAST_HOPS,
 		       &opt.sockopt.hlimit, sizeof(opt.sockopt.hlimit)))
 		error(ERN_SOCKOPT, errno, "setsockopt IPV6_HOPLIMIT");
+	if (opt.sockopt.priority &&
+	    setsockopt(fd, SOL_SOCKET, SO_PRIORITY,
+		       &opt.sockopt.priority, sizeof(opt.sockopt.priority)))
+		error(ERN_SOCKOPT, errno, "setsockopt SO_PRIORITY");
 }
 
 int main(int argc, char *argv[])
@@ -421,6 +433,7 @@ int main(int argc, char *argv[])
 	char *buf;
 	int err;
 	int fd;
+	int i;
 
 	cs_parse_args(argc, argv);
 
@@ -480,24 +493,27 @@ int main(int argc, char *argv[])
 
 	cs_write_cmsg(fd, &msg, cbuf, sizeof(cbuf));
 
-	err = sendmsg(fd, &msg, 0);
-	if (err < 0) {
-		if (!opt.silent_send)
-			fprintf(stderr, "send failed: %s\n", strerror(errno));
-		err = ERN_SEND;
-		goto err_out;
-	} else if (err != (int)opt.size) {
-		fprintf(stderr, "short send\n");
-		err = ERN_SEND_SHORT;
-		goto err_out;
-	} else {
-		err = ERN_SUCCESS;
+	for (i = 0; i < opt.num_pkt; i++) {
+		err = sendmsg(fd, &msg, 0);
+		if (err < 0) {
+			if (!opt.silent_send)
+				fprintf(stderr, "send failed: %s\n", strerror(errno));
+			err = ERN_SEND;
+			goto err_out;
+		} else if (err != (int)opt.size) {
+			fprintf(stderr, "short send\n");
+			err = ERN_SEND_SHORT;
+			goto err_out;
+		}
 	}
+	err = ERN_SUCCESS;
 
-	/* Make sure all timestamps have time to loop back */
-	usleep(opt.txtime.delay);
+	if (opt.ts.ena) {
+		/* Make sure all timestamps have time to loop back */
+		usleep(opt.txtime.delay);
 
-	cs_read_cmsg(fd, &msg, cbuf, sizeof(cbuf));
+		cs_read_cmsg(fd, &msg, cbuf, sizeof(cbuf));
+	}
 
 err_out:
 	close(fd);
diff --git a/tools/testing/selftests/net/fq_band_pktlimit.sh b/tools/testing/selftests/net/fq_band_pktlimit.sh
new file mode 100755
index 000000000000..24b77bdf41ff
--- /dev/null
+++ b/tools/testing/selftests/net/fq_band_pktlimit.sh
@@ -0,0 +1,57 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Verify that FQ has a packet limit per band:
+#
+# 1. set the limit to 10 per band
+# 2. send 20 pkts on band A: verify that 10 are queued, 10 dropped
+# 3. send 20 pkts on band A: verify that  0 are queued, 20 dropped
+# 4. send 20 pkts on band B: verify that 10 are queued, 10 dropped
+#
+# Send packets with a 100ms delay to ensure that previously sent
+# packets are still queued when later ones are sent.
+# Use SO_TXTIME for this.
+
+die() {
+	echo "$1"
+	exit 1
+}
+
+# run inside private netns
+if [[ $# -eq 0 ]]; then
+	./in_netns.sh "$0" __subprocess
+	exit
+fi
+
+ip link add type dummy
+ip link set dev dummy0 up
+ip -6 addr add fdaa::1/128 dev dummy0
+ip -6 route add fdaa::/64 dev dummy0
+tc qdisc replace dev dummy0 root handle 1: fq quantum 1514 initial_quantum 1514 limit 10
+
+./cmsg_sender -6 -p u -d 100000 -n 20 fdaa::2 8000
+OUT1="$(tc -s qdisc show dev dummy0 | grep '^\ Sent')"
+
+./cmsg_sender -6 -p u -d 100000 -n 20 fdaa::2 8000
+OUT2="$(tc -s qdisc show dev dummy0 | grep '^\ Sent')"
+
+./cmsg_sender -6 -p u -d 100000 -n 20 -P 7 fdaa::2 8000
+OUT3="$(tc -s qdisc show dev dummy0 | grep '^\ Sent')"
+
+# Initial stats will report zero sent, as all packets are still
+# queued in FQ. Sleep for the delay period (100ms) and see that
+# twenty are now sent.
+sleep 0.1
+OUT4="$(tc -s qdisc show dev dummy0 | grep '^\ Sent')"
+
+# Log the output after the test
+echo "${OUT1}"
+echo "${OUT2}"
+echo "${OUT3}"
+echo "${OUT4}"
+
+# Test the output for expected values
+echo "${OUT1}" | grep -q '0\ pkt\ (dropped\ 10'  || die "unexpected drop count at 1"
+echo "${OUT2}" | grep -q '0\ pkt\ (dropped\ 30'  || die "unexpected drop count at 2"
+echo "${OUT3}" | grep -q '0\ pkt\ (dropped\ 40'  || die "unexpected drop count at 3"
+echo "${OUT4}" | grep -q '20\ pkt\ (dropped\ 40' || die "unexpected accept count at 4"
-- 
2.43.0.rc1.413.gea7ed67945-goog


