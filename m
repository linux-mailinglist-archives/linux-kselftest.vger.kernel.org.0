Return-Path: <linux-kselftest+bounces-17196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D88BB96CD1A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 05:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFBA2836BB
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 03:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C331148849;
	Thu,  5 Sep 2024 03:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQxSNcux"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDEA42AA2;
	Thu,  5 Sep 2024 03:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505962; cv=none; b=VeT21Z1YvGVjWiB+BnIjf/h/e127kl2o2rYJ7dNFueQY3X34+Nuoo+f/8NcIqCvE3DXGnyNPf9qBnEqe4HmbruW24momOirQ+9o7oBqmSCOIhf44zkf7EssXXqZMhqouxHCKtoaXbUr2KxqOEoBLoIXR+XF4JJXEB1wO79ho8Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505962; c=relaxed/simple;
	bh=e4kqL7Hw0VXuFrEHQ5u5S5s0rxgo03NtGfh4E8DCcSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIpsO3H7T4wjSVuUVavp0qfko9QfHZ/jzIc35uiQmekMaDdLOT7ScyCRxFsxTg4iHDpCOhc9baOTh+8BGD4Xxjt7tvN7tUd1HKEeosIsERsaOrhvLjiaB95FywVsLnmb53tebbgDTnmAPrtALU1a62ypDpHwUZRvoeQlPiYWq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQxSNcux; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4fcf4ae95dbso121970e0c.0;
        Wed, 04 Sep 2024 20:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725505959; x=1726110759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qefVb86hilWABFHmKbSeavsOvYhWalW/io0KUr/hVU=;
        b=hQxSNcuxitmEifjcvCq0WiEFYfF6rtw01eJwKCAZmjdJuZhCtotPSxA8z3no8shksF
         IpiOxVaiwWpNdBiTgXy8DMqvHlljFrDpp2ZRXT05eG/EqTjiOCF1hsw40s+u/wiJkww6
         TDK2DMBCW2aID+qfLuz0jl9xMM5ajyGDf9Wmn+SV0S11YcHEwSeBL0iCKiL28oJRKSRG
         aJnAqScGjQqT9HDI+/THZ81T1x+kCvzetGp0DIjX7m5At+BfTSHbepsMGJOW8tfo5hey
         jbrPTwla3A+H7k7pI8VyNtcvTFgEA8BlADT3G1u+bNp8VjutYngjo/LNXkQrMBOyCCK/
         DztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725505959; x=1726110759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qefVb86hilWABFHmKbSeavsOvYhWalW/io0KUr/hVU=;
        b=bciFgR2uBxTSwj0y2gUQTblTuzhiwLGha3jxq0FMxR+gOaPMaWFiBmUF9mlnkEy29Y
         kfpHzxFVEuhdU31kSnWyY4cQYrbdr6fYXfaYTkSTALHMDALrHTdtCy9Tp+AeLBX87ywa
         KV6rDkyzAtJsIBfTAZU3iYZ3GPOU3tii083laD3mf9LVPrAZ3TKinmTNyX8OiNDvG4cX
         YZTmMP4+OLJKlc9MCBf498K8UbJXcK5CWpr37NXD5/6BIsoj8xaXLatqW6GJUA//egfe
         HKry2P8OdBOGTSSUFOqqVK7+0R83qeJhMgsH+f1rTOleWQhVyZhvIwE169dFJID0gxVe
         NqeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcWUojZlNKb9iNb8nPP5wX4GKl9DvqLmw9tQJDrDXYh0SbILe2nEnG1sWDAyrSusfQBcSKFujFsSKV1QHhm78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6oec0/k1zmxwLKRNwQnRUu9HpPPvtJeHke0znqGiZ4B1CxQXL
	eJIZ1vDywW/sqCSxoC9qjP5lYdvBw5iEzMxos9YCk0c2B2A7iweyadw11w==
X-Google-Smtp-Source: AGHT+IGJZHldCmEsN6YcF6KrUCDsUxhynI/yfOhNoGMFUsQ290tj70pmC7862Gk2RNG/5lh/IOJQLg==
X-Received: by 2002:a05:6122:221b:b0:4fc:e4f5:7f83 with SMTP id 71dfb90a1353d-5009b1305bfmr18321382e0c.9.1725505958908;
        Wed, 04 Sep 2024 20:12:38 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801a153f0sm3819611cf.12.2024.09.04.20.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:12:38 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ncardwell@google.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	fw@strlen.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 2/2] selftests/net: integrate packetdrill with ksft
Date: Wed,  4 Sep 2024 23:07:03 -0400
Message-ID: <20240905031233.1528830-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905031233.1528830-1-willemdebruijn.kernel@gmail.com>
References: <20240905031233.1528830-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Lay the groundwork to import into kselftests the over 150 packetdrill
TCP/IP conformance tests on github.com/google/packetdrill.

Florian recently added support for packetdrill tests in nf_conntrack,
in commit a8a388c2aae49 ("selftests: netfilter: add packetdrill based
conntrack tests").

This patch takes a slightly different approach. It relies on
ksft_runner.sh to run every *.pkt file in the directory.

Any future imports of packetdrill tests should require no additional
coding. Just add the *.pkt files.

Initially import only two features/directories from github. One with a
single script, and one with two. This was the only reason to pick
tcp/inq and tcp/md5.

The path replaces the directory hierarchy in github with a flat space
of files: $(subst /,_,$(wildcard tcp/**/*.pkt)). This is the most
straightforward option to integrate with kselftests. The Linked thread
reviewed two ways to maintain the hierarchy: TEST_PROGS_RECURSE and
PRESERVE_TEST_DIRS. But both introduce significant changes to
kselftest infra and with that risk to existing tests.

Implementation notes:
- restore alphabetical order when adding the new directory to
  tools/testing/selftests/Makefile
- imported *.pkt files and support verbatim from the github project,
  except for
    - update `source ./defaults.sh` path (to adjust for flat dir)
    - add SPDX headers
    - remove one author statement
    - Acknowledgment: drop an e (checkpatch)

Tested:
	make -C tools/testing/selftests \
	  TARGETS=net/packetdrill \
	  run_tests

	make -C tools/testing/selftests \
	  TARGETS=net/packetdrill \
	  install INSTALL_PATH=$KSFT_INSTALL_PATH

	# in virtme-ng
        export KSELFTEST_PKT_INTERP=./packetdrill_ksft.sh
	./run_kselftest.sh -c net/packetdrill
	./run_kselftest.sh -t net/packetdrill:tcp_inq_client.pkt

Link: https://lore.kernel.org/netdev/20240827193417.2792223-1-willemdebruijn.kernel@gmail.com/
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes:
	- RFC -> v1
	  - replace custom runner with ksft_runner.sh
	    (previous patch in series) and ktap_helpers.sh
	  - flatten the github tcp/**/*.pkt directory structure
	  - add config for MD5 dependency
	  - drop unused set_sysctls.py
---
 tools/testing/selftests/Makefile              |  5 +-
 .../selftests/net/packetdrill/Makefile        |  9 +++
 .../testing/selftests/net/packetdrill/config  |  1 +
 .../selftests/net/packetdrill/defaults.sh     | 63 +++++++++++++++++++
 .../selftests/net/packetdrill/ksft_runner.sh  | 41 ++++++++++++
 .../net/packetdrill/tcp_inq_client.pkt        | 51 +++++++++++++++
 .../net/packetdrill/tcp_inq_server.pkt        | 51 +++++++++++++++
 .../tcp_md5_md5-only-on-client-ack.pkt        | 28 +++++++++
 8 files changed, 247 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/Makefile
 create mode 100644 tools/testing/selftests/net/packetdrill/config
 create mode 100755 tools/testing/selftests/net/packetdrill/defaults.sh
 create mode 100755 tools/testing/selftests/net/packetdrill/ksft_runner.sh
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_inq_server.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_md5_md5-only-on-client-ack.pkt

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index a5f1c0c27dff9..3b7df54773170 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -65,10 +65,11 @@ TARGETS += net/af_unix
 TARGETS += net/forwarding
 TARGETS += net/hsr
 TARGETS += net/mptcp
-TARGETS += net/openvswitch
-TARGETS += net/tcp_ao
 TARGETS += net/netfilter
+TARGETS += net/openvswitch
+TARGETS += net/packetdrill
 TARGETS += net/rds
+TARGETS += net/tcp_ao
 TARGETS += nsfs
 TARGETS += perf_events
 TARGETS += pidfd
diff --git a/tools/testing/selftests/net/packetdrill/Makefile b/tools/testing/selftests/net/packetdrill/Makefile
new file mode 100644
index 0000000000000..870f7258dc8d7
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_INCLUDES := ksft_runner.sh \
+		 defaults.sh \
+		 ../../kselftest/ktap_helpers.sh
+
+TEST_PROGS := $(wildcard *.pkt)
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/packetdrill/config b/tools/testing/selftests/net/packetdrill/config
new file mode 100644
index 0000000000000..b92ad2fb56b63
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/config
@@ -0,0 +1 @@
+CONFIG_TCP_MD5SIG=y
diff --git a/tools/testing/selftests/net/packetdrill/defaults.sh b/tools/testing/selftests/net/packetdrill/defaults.sh
new file mode 100755
index 0000000000000..1095a7b22f44d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/defaults.sh
@@ -0,0 +1,63 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Set standard production config values that relate to TCP behavior.
+
+# Flush old cached data (fastopen cookies).
+ip tcp_metrics flush all > /dev/null 2>&1
+
+# TCP min, default, and max receive and send buffer sizes.
+sysctl -q net.ipv4.tcp_rmem="4096 540000 $((15*1024*1024))"
+sysctl -q net.ipv4.tcp_wmem="4096 $((256*1024)) 4194304"
+
+# TCP timestamps.
+sysctl -q net.ipv4.tcp_timestamps=1
+
+# TCP SYN(ACK) retry thresholds
+sysctl -q net.ipv4.tcp_syn_retries=5
+sysctl -q net.ipv4.tcp_synack_retries=5
+
+# TCP Forward RTO-Recovery, RFC 5682.
+sysctl -q net.ipv4.tcp_frto=2
+
+# TCP Selective Acknowledgements (SACK)
+sysctl -q net.ipv4.tcp_sack=1
+
+# TCP Duplicate Selective Acknowledgements (DSACK)
+sysctl -q net.ipv4.tcp_dsack=1
+
+# TCP FACK (Forward Acknowldgement)
+sysctl -q net.ipv4.tcp_fack=0
+
+# TCP reordering degree ("dupthresh" threshold for entering Fast Recovery).
+sysctl -q net.ipv4.tcp_reordering=3
+
+# TCP congestion control.
+sysctl -q net.ipv4.tcp_congestion_control=cubic
+
+# TCP slow start after idle.
+sysctl -q net.ipv4.tcp_slow_start_after_idle=0
+
+# TCP RACK and TLP.
+sysctl -q net.ipv4.tcp_early_retrans=4 net.ipv4.tcp_recovery=1
+
+# TCP method for deciding when to defer sending to accumulate big TSO packets.
+sysctl -q net.ipv4.tcp_tso_win_divisor=3
+
+# TCP Explicit Congestion Notification (ECN)
+sysctl -q net.ipv4.tcp_ecn=0
+
+sysctl -q net.ipv4.tcp_pacing_ss_ratio=200
+sysctl -q net.ipv4.tcp_pacing_ca_ratio=120
+sysctl -q net.ipv4.tcp_notsent_lowat=4294967295 > /dev/null 2>&1
+
+sysctl -q net.ipv4.tcp_fastopen=0x70403
+sysctl -q net.ipv4.tcp_fastopen_key=a1a1a1a1-b2b2b2b2-c3c3c3c3-d4d4d4d4
+
+sysctl -q net.ipv4.tcp_syncookies=1
+
+# Override the default qdisc on the tun device.
+# Many tests fail with timing errors if the default
+# is FQ and that paces their flows.
+tc qdisc add dev tun0 root pfifo
+
diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
new file mode 100755
index 0000000000000..2f62caccbbbc5
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source "$(dirname $(realpath $0))/../../kselftest/ktap_helpers.sh"
+
+readonly ipv4_args=('--ip_version=ipv4 '
+		    '--local_ip=192.168.0.1 '
+		    '--gateway_ip=192.168.0.1 '
+		    '--netmask_ip=255.255.0.0 '
+		    '--remote_ip=192.0.2.1 '
+		    '-D CMSG_LEVEL_IP=SOL_IP '
+		    '-D CMSG_TYPE_RECVERR=IP_RECVERR ')
+
+readonly ipv6_args=('--ip_version=ipv6 '
+		    '--mtu=1520 '
+		    '--local_ip=fd3d:0a0b:17d6::1 '
+		    '--gateway_ip=fd3d:0a0b:17d6:8888::1 '
+		    '--remote_ip=fd3d:fa7b:d17d::1 '
+		    '-D CMSG_LEVEL_IP=SOL_IPV6 '
+		    '-D CMSG_TYPE_RECVERR=IPV6_RECVERR ')
+
+if [ $# -ne 1 ]; then
+	ktap_exit_fail_msg "usage: $0 <script>"
+	exit "$KSFT_FAIL"
+fi
+script="$1"
+
+if [ -z "$(which packetdrill)" ]; then
+	ktap_skip_all "packetdrill not found in PATH"
+	exit "$KSFT_SKIP"
+fi
+
+ktap_print_header
+ktap_set_plan 2
+
+packetdrill ${ipv4_args[@]} $(basename $script) > /dev/null \
+	&& ktap_test_pass "ipv4" || ktap_test_fail "ipv4"
+packetdrill ${ipv6_args[@]} $(basename $script) > /dev/null \
+	&& ktap_test_pass "ipv6" || ktap_test_fail "ipv6"
+
+ktap_finished
diff --git a/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt b/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
new file mode 100644
index 0000000000000..df49c67645ac8
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test TCP_INQ and TCP_CM_INQ on the client side.
+`./defaults.sh
+`
+
+// Create a socket and set it to non-blocking.
+    0	socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0	fcntl(3, F_GETFL) = 0x2 (flags O_RDWR)
+   +0	fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+
+// Connect to the server and enable TCP_INQ.
+   +0	connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+   +0	setsockopt(3, SOL_TCP, TCP_INQ, [1], 4) = 0
+
+   +0	> S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+ +.01	< S. 0:0(0) ack 1 win 5792 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 7>
+   +0	> . 1:1(0) ack 1 <nop,nop,TS val 200 ecr 700>
+
+// Now we have 10K of data ready on the socket.
+   +0	< . 1:10001(10000) ack 1 win 514
+   +0	> . 1:1(0) ack 10001 <nop,nop,TS val 200 ecr 700>
+
+// We read 1K and we should have 9K ready to read.
+   +0	recvmsg(3, {msg_name(...)=...,
+		    msg_iov(1)=[{..., 1000}],
+		    msg_flags=0,
+		    msg_control=[{cmsg_level=SOL_TCP,
+				  cmsg_type=TCP_CM_INQ,
+				  cmsg_data=9000}]}, 0) = 1000
+// We read 9K and we should have no further data ready to read.
+   +0	recvmsg(3, {msg_name(...)=...,
+		    msg_iov(1)=[{..., 9000}],
+		    msg_flags=0,
+		    msg_control=[{cmsg_level=SOL_TCP,
+				  cmsg_type=TCP_CM_INQ,
+				  cmsg_data=0}]}, 0) = 9000
+
+// Server sends more data and closes the connections.
+   +0	< F. 10001:20001(10000) ack 1 win 514
+   +0	> . 1:1(0) ack 20002 <nop,nop,TS val 200 ecr 700>
+
+// We read 10K and we should have one "fake" byte because the connection is
+// closed.
+   +0	recvmsg(3, {msg_name(...)=...,
+		    msg_iov(1)=[{..., 10000}],
+		    msg_flags=0,
+		    msg_control=[{cmsg_level=SOL_TCP,
+				  cmsg_type=TCP_CM_INQ,
+				  cmsg_data=1}]}, 0) = 10000
+// Now, receive EOF.
+   +0	read(3, ..., 2000) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_inq_server.pkt b/tools/testing/selftests/net/packetdrill/tcp_inq_server.pkt
new file mode 100644
index 0000000000000..04a5e2590c62c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_inq_server.pkt
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test TCP_INQ and TCP_CM_INQ on the server side.
+`./defaults.sh
+`
+
+// Initialize connection
+    0	socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0	setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0	bind(3, ..., ...) = 0
+   +0	listen(3, 1) = 0
+
+   +0	< S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 10>
+   +0	> S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+ +.01	< . 1:1(0) ack 1 win 514
+
+// Accept the connection and enable TCP_INQ.
+   +0	accept(3, ..., ...) = 4
+   +0	setsockopt(4, SOL_TCP, TCP_INQ, [1], 4) = 0
+
+// Now we have 10K of data ready on the socket.
+   +0	< . 1:10001(10000) ack 1 win 514
+   +0	> . 1:1(0) ack 10001
+
+// We read 2K and we should have 8K ready to read.
+   +0	recvmsg(4, {msg_name(...)=...,
+		    msg_iov(1)=[{..., 2000}],
+		    msg_flags=0,
+		    msg_control=[{cmsg_level=SOL_TCP,
+				  cmsg_type=TCP_CM_INQ,
+				  cmsg_data=8000}]}, 0) = 2000
+// We read 8K and we should have no further data ready to read.
+   +0	recvmsg(4, {msg_name(...)=...,
+		    msg_iov(1)=[{..., 8000}],
+		    msg_flags=0,
+		    msg_control=[{cmsg_level=SOL_TCP,
+				  cmsg_type=TCP_CM_INQ,
+				  cmsg_data=0}]}, 0) = 8000
+// Client sends more data and closes the connections.
+   +0	< F. 10001:20001(10000) ack 1 win 514
+   +0	> . 1:1(0) ack 20002
+
+// We read 10K and we should have one "fake" byte because the connection is
+// closed.
+   +0	recvmsg(4, {msg_name(...)=...,
+		    msg_iov(1)=[{..., 10000}],
+		    msg_flags=0,
+		    msg_control=[{cmsg_level=SOL_TCP,
+				  cmsg_type=TCP_CM_INQ,
+				  cmsg_data=1}]}, 0) = 10000
+// Now, receive error.
+   +0	read(3, ..., 2000) = -1 ENOTCONN (Transport endpoint is not connected)
diff --git a/tools/testing/selftests/net/packetdrill/tcp_md5_md5-only-on-client-ack.pkt b/tools/testing/selftests/net/packetdrill/tcp_md5_md5-only-on-client-ack.pkt
new file mode 100644
index 0000000000000..25dfef95d3f84
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_md5_md5-only-on-client-ack.pkt
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test what happens when client does not provide MD5 on SYN,
+// but then does on the ACK that completes the three-way handshake.
+
+`./defaults.sh`
+
+// Establish a connection.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 10>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+// Ooh, weird: client provides MD5 option on the ACK:
+ +.01 < . 1:1(0) ack 1 win 514 <md5 000102030405060708090a0b0c0d0e0f,nop,nop>
+ +.01 < . 1:1(0) ack 1 win 514 <md5 000102030405060708090a0b0c0d0e0f,nop,nop>
+
+// The TCP listener refcount should be 2, but on buggy kernels it can be 0:
+   +0 `grep " 0A " /proc/net/tcp /proc/net/tcp6 | grep ":1F90"`
+
+// Now here comes the legit ACK:
+ +.01 < . 1:1(0) ack 1 win 514
+
+// Make sure the connection is OK:
+   +0 accept(3, ..., ...) = 4
+
+ +.01 write(4, ..., 1000) = 1000
-- 
2.46.0.469.g59c65b2a67-goog


