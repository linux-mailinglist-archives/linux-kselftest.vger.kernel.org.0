Return-Path: <linux-kselftest+bounces-23465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6171F9F568B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 19:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D94171B97
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 18:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D031F941E;
	Tue, 17 Dec 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyTbZnuI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A581A1F9416;
	Tue, 17 Dec 2024 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461536; cv=none; b=M5xIdTw9zRd+MW1W6d2uC7OA8HEKNqku4MTsQcdy50RXwGU8iDfItGS/Q2+6dZ9V01fZ9h8teRBO7XzKBTJXJTHXL/ljPgRm3KxQ9itrXmK6kmz0VTL5Sot7TpEH5dmlw30+AwZIAyh29eik3cMckIECFpaLbGjQObMFM+Hn62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461536; c=relaxed/simple;
	bh=1IDUsk552NwCqxLukZn5r0oH+hvERfctU103Y7ezJVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBcQoFYW33EhIbehP5mYiXZhgAuzSzu6tVc8K/LRiAURbOFGCx/XTxtRIMOZ5i39VXZVKiPoNCbLSrcypCIRTLHFCHOnvHFkFl5QLj7t0XQQOypXeVc5Ca21WmEIj3ZmBwI+8rx83DVEJzNhD3DDq9iv4B0VoYiJf4f2t1PVLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyTbZnuI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216634dd574so33039235ad.2;
        Tue, 17 Dec 2024 10:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734461533; x=1735066333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXam2bF1hWvqG+tUd6ouYMg6bcnv4ir2I3vnk49ZFnY=;
        b=XyTbZnuIsoklaaPcp/Y4UIL9kfga3AVw/FPrlwOxq69YiOCAVzh/hgVA1sbEiQ2UX8
         SoCkx1fnfoZhL/AMFO3ETFarhRV1o+9/m27kjq+dCAP5qsbeHnElWOEe4cqhpd5K1Qdd
         vpmtlu8c/f2al4KE3uhhgCFMDHJavMzfmQ0p8aAdxYl/0R0+hjxsD+ioOjntXmBcvikK
         kJrLfdfOV8bDDT1KVYQoMCruxvmo2JNIA2lu2RIVd8kKrf3s/qp2MzHy1gyitUv6GjEO
         mFPRVipPTJCBm3EJf1IJoceADlGPm5jeWm0uR0yuD+WYeelS+dMcRVm0FOAMWo2D2K/4
         9NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734461533; x=1735066333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXam2bF1hWvqG+tUd6ouYMg6bcnv4ir2I3vnk49ZFnY=;
        b=QXCneye0ZT8v0E36SDiglSjm6XYyLbgnPTo3VLI+Hi+4zRvF8b/xwZtpVP5KL8YmK3
         AIwToRkPVttaXyl0Jxj0kGolmvQcEzvUFLeZV3LyyAmvj2/lJeGXQoj5y9R3z5uWxW1a
         77YOFgGi99enCHXMAmMAQiLty06tNt+L/SAUpDyKed/l0inpeU5DeeeErFlH1BKN6slj
         IEhE5jYIdeHI3a0kcunM2y+t5Oig9PsfZ70Fky/gHuIHS783CNOXbPNbprN9by5a1pPW
         06AtiQLgIC20F5EqjYFjmihSWWVdlP2L38+bVAXMnu/bhxALG+nxVpvWxz0eSyJTVKs+
         mS+g==
X-Forwarded-Encrypted: i=1; AJvYcCVEkoDwwiKWJstL449JVY7WhV+2rWLNYFCZkMvGDwJD5I7+H4xP851CyVdPd+uopkbR4BIEiqiOyuTwJYYgdQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRnWvbu6PayEAvZ59ZqbIsYbXYDlND07o7HKndYKgabcklbt9d
	htu/TdpAS18CB4Y40UydXHicuCoWFecAgg9OGV83mSKbi/HSuLd2VZmbEMObp6Q=
X-Gm-Gg: ASbGncu3mKMQEIS4BlggEjLJbEIgIP/iIOYwU+Ho8uTiyehmWqlSsffPmZJpeY6/CYB
	dLoa0z2sg59oQwoyMrl944CeRbTKD50UIn3DEMqDmIFmjlSr8VoIlhMClIwWE6Hc6iU8+8wLmke
	a5zHwTc/jUeLyjAo7Z20D6UTHWMmnMoqer/F40ewVkCSZE31RMm7w8HTZsY9xnKb31aEcoS3Bfn
	wSe1fgeFllA0zhYYzrXeowB2cPM8aAcyJ5JAHFTn34ed0emFrN3x8YZT0C2t2qShKEnB0vA50Iy
	vIkeP7cgM8O3BH4qg5MajrGFFsDp2fn+Yyy6S6c/jWr47ulZGzlw0ck4gA==
X-Google-Smtp-Source: AGHT+IHRwkZlO7QBkcBJ1f/RG0z7odmmXvwXUZwJi4V0xLtnNpDdwQNZy8B8HZ1Ta7J/9mNQSl6yfg==
X-Received: by 2002:a17:903:22c6:b0:205:4721:19c with SMTP id d9443c01a7336-21892a417bdmr253358545ad.37.1734461532815;
        Tue, 17 Dec 2024 10:52:12 -0800 (PST)
Received: from sohamch-kvm.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dbb079sm62307715ad.31.2024.12.17.10.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:52:12 -0800 (PST)
From: Soham Chakradeo <sohamch.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Soham Chakradeo <sohamch@google.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 1/4] selftests/net: packetdrill: import tcp/ecn, tcp/close, tcp/sack, tcp/tcp_info
Date: Tue, 17 Dec 2024 18:51:58 +0000
Message-ID: <20241217185203.297935-2-sohamch.kernel@gmail.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241217185203.297935-1-sohamch.kernel@gmail.com>
References: <20241217185203.297935-1-sohamch.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Soham Chakradeo <sohamch@google.com>

Same as initial tests, import verbatim from
github.com/google/packetdrill, aside from:

- update `source ./defaults.sh` path to adjust for flat dir
- add SPDX headers
- remove author statements if any
- drop blank lines at EOF

Same test process as previous tests. Both with and without debug mode.
Recording the steps once:

make mrproper
vng --build \
--config tools/testing/selftests/net/packetdrill/config \
--config kernel/configs/debug.config
vng -v --run . --user root --cpus 4 -- \
make -C tools/testing/selftests TARGETS=net/packetdrill run_tests

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Soham Chakradeo <sohamch@google.com>
---
 ...lose_close-local-close-then-remote-fin.pkt | 23 +++++++
 .../tcp_close_close-on-syn-sent.pkt           | 21 ++++++
 .../tcp_close_close-remote-fin-then-close.pkt | 36 ++++++++++
 .../net/packetdrill/tcp_ecn_ecn-uses-ect0.pkt | 21 ++++++
 .../tcp_sack_sack-route-refresh-ip-tos.pkt    | 37 +++++++++++
 ...ack_sack-shift-sacked-2-6-8-3-9-nofack.pkt | 64 ++++++++++++++++++
 ..._sack_sack-shift-sacked-7-3-4-8-9-fack.pkt | 66 +++++++++++++++++++
 ..._sack_sack-shift-sacked-7-5-6-8-9-fack.pkt | 62 +++++++++++++++++
 .../tcp_tcp_info_tcp-info-last_data_recv.pkt  | 21 ++++++
 .../tcp_tcp_info_tcp-info-rwnd-limited.pkt    | 54 +++++++++++++++
 .../tcp_tcp_info_tcp-info-sndbuf-limited.pkt  | 39 +++++++++++
 11 files changed, 444 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_close_close-local-close-then-remote-fin.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_close_close-on-syn-sent.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_close_close-remote-fin-then-close.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ecn_ecn-uses-ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_sack_sack-route-refresh-ip-tos.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-2-6-8-3-9-nofack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-7-3-4-8-9-fack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-7-5-6-8-9-fack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-last_data_recv.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-rwnd-limited.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-sndbuf-limited.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_close_close-local-close-then-remote-fin.pkt b/tools/testing/selftests/net/packetdrill/tcp_close_close-local-close-then-remote-fin.pkt
new file mode 100644
index 000000000000..8514d6bdbb6d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_close_close-local-close-then-remote-fin.pkt
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test basic connection teardown where local process closes first:
+// the local process calls close() first, so we send a FIN, and receive an ACK.
+// Then we receive a FIN and ACK it.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+ +.01...0.011 connect(3, ..., ...) = 0
+   +0 >  S 0:0(0) <...>
+   +0 < S. 0:0(0) ack 1 win 32768 <mss 1000,nop,wscale 6,nop,nop,sackOK>
+   +0 >  . 1:1(0) ack 1
+
+   +0 write(3, ..., 1000) = 1000
+   +0 >  P. 1:1001(1000) ack 1
+   +0 < . 1:1(0) ack 1001 win 257
+
+   +0 close(3) = 0
+   +0 >  F. 1001:1001(0) ack 1
+   +0 < . 1:1(0) ack 1002 win 257
+
+   +0 < F. 1:1(0) ack 1002 win 257
+   +0 >  . 1002:1002(0) ack 2
diff --git a/tools/testing/selftests/net/packetdrill/tcp_close_close-on-syn-sent.pkt b/tools/testing/selftests/net/packetdrill/tcp_close_close-on-syn-sent.pkt
new file mode 100644
index 000000000000..04103134bd99
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_close_close-on-syn-sent.pkt
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test to make sure no RST is being sent when close()
+// is called on a socket with SYN_SENT state.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+
+   +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+   +0 > S 0:0(0) <...>
+
+// Application decideds to close the socket in SYN_SENT state
+// Make sure no RST is sent after close().
+   +0 close(3) = 0
+
+// Receive syn-ack to trigger the send side packet examination:
+// If a RESET were sent right after close(), it would have failed with
+// a mismatched timestamp.
+  +.1 < S. 0:0(0) ack 1 win 32000 <mss 1460,nop,wscale 7>
+   +0 > R 1:1(0)
diff --git a/tools/testing/selftests/net/packetdrill/tcp_close_close-remote-fin-then-close.pkt b/tools/testing/selftests/net/packetdrill/tcp_close_close-remote-fin-then-close.pkt
new file mode 100644
index 000000000000..5f3a2914213a
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_close_close-remote-fin-then-close.pkt
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+// Verify behavior for the sequence: remote side sends FIN, then we close().
+// Since the remote side (client) closes first, we test our LAST_ACK code path.
+
+`./defaults.sh`
+
+// Initialize a server socket.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+// Client closes first.
+ +.01 < F. 1:1(0) ack 1 win 257
+   +0 > . 1:1(0) ack 2
+
+// App notices that client closed.
+   +0 read(4, ..., 1000) = 0
+
+// Then we close.
+ +.01 close(4) = 0
+   +0 > F. 1:1(0) ack 2
+
+// Client ACKs our FIN.
+ +.01 < . 2:2(0) ack 2 win 257
+
+// Verify that we send RST in response to any incoming segments
+// (because the kernel no longer has any record of this socket).
+ +.01 < . 2:2(0) ack 2 win 257
+   +0 > R 2:2(0)
diff --git a/tools/testing/selftests/net/packetdrill/tcp_ecn_ecn-uses-ect0.pkt b/tools/testing/selftests/net/packetdrill/tcp_ecn_ecn-uses-ect0.pkt
new file mode 100644
index 000000000000..643baf3267cf
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_ecn_ecn-uses-ect0.pkt
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test ECN: verify that Linux TCP ECN sending code uses ECT0 (not ECT1).
+//
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=1  # fully enabled
+`
+
+// Initialize connection
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
+
+// ECN handshake: send EW flags in SYN packet, E flag in SYN-ACK response
++.002 ... 0.004 connect(4, ..., ...) = 0
+
+   +0 > SEW 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.002 < SE. 0:0(0) ack 1 win 32767 <mss 1000,nop,wscale 6,nop,nop,sackOK>
+   +0 > . 1:1(0) ack 1
+
+// Write 1 MSS.
++.002 write(4, ..., 1000) = 1000
+// Send 1 MSS with ect0.
+   +0 > [ect0] P. 1:1001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_sack_sack-route-refresh-ip-tos.pkt b/tools/testing/selftests/net/packetdrill/tcp_sack_sack-route-refresh-ip-tos.pkt
new file mode 100644
index 000000000000..310ef31518da
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_sack_sack-route-refresh-ip-tos.pkt
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+// Verify that setsockopt calls that force a route refresh do not
+// cause problems matching SACKs with packets in the write queue.
+// This variant tests IP_TOS.
+
+`./defaults.sh`
+
+// Establish a connection.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_IP, IP_MTU_DISCOVER, [IP_PMTUDISC_DONT], 1) = 0
+   +0...0.010 connect(3, ..., ...) = 0
+
+   +0 > S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+ +.01 < S. 0:0(0) ack 1 win 65535 <mss 1460,nop,wscale 2,nop,nop,sackOK>
+   +0 > . 1:1(0) ack 1
+
+ +.01 write(3, ..., 5840) = 5840
+   +0 > P. 1:5841(5840) ack 1
+ +.01 < . 1:1(0) ack 5841 win 65535
+
+ +.01 write(3, ..., 5840) = 5840
+   +0 > P. 5841:11681(5840) ack 1
+ +.01 < . 1:1(0) ack 11681 win 65535
+
+ +.01 write(3, ..., 14600) = 14600
+   +0 > P. 11681:26281(14600) ack 1
+
+// Try the socket option that we know can force a route refresh.
+   +0 setsockopt(3, SOL_IP, IP_TOS, [4], 1) = 0
+// Then revert to avoid routing/mangling/etc implications of that setting.
+   +0 setsockopt(3, SOL_IP, IP_TOS, [0], 1) = 0
+
+// Verify that we do not retransmit the SACKed segments.
+ +.01 < . 1:1(0) ack 13141 win 65535 <sack 16061:17521 20441:26281,nop,nop>
+   +0 > . 13141:16061(2920) ack 1
+   +0 > P. 17521:20441(2920) ack 1
+ +.01 < . 1:1(0) ack 26281 win 65535
diff --git a/tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-2-6-8-3-9-nofack.pkt b/tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-2-6-8-3-9-nofack.pkt
new file mode 100644
index 000000000000..f185e1ac57ea
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-2-6-8-3-9-nofack.pkt
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test shifting of newly-SACKed ranges onto the previous already-SACKed skb.
+// This variant tests non-FACK SACK with SACKs coming in the order
+// 2 6 8 3 9, to test what happens when we get a new SACKed range
+// (for packet 3) that is on the right of an existing SACKed range
+// (for packet 2).
+
+`./defaults.sh`
+
+// Establish a connection and send 10 MSS.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 1024
+   +0 accept(3, ..., ...) = 4
+
+   +0 write(4, ..., 10000) = 10000
+   +0 > P. 1:10001(10000) ack 1
+
+  +.1 < . 1:1(0) ack 1 win 257 <sack 2001:3001,nop,nop>
++.001 < . 1:1(0) ack 1 win 257 <sack 2001:3001 6001:7001,nop,nop>
++.001 < . 1:1(0) ack 1 win 257 <sack 2001:3001 6001:7001 8001:9001,nop,nop>
+
+// 3 SACKed packets, so we enter Fast Recovery.
+   +0 > . 1:1001(1000) ack 1
+   +0 %{ assert tcpi_ca_state == TCP_CA_Recovery, tcpi_ca_state }%
+   +0 %{ assert tcpi_lost == 6, tcpi_lost }%
+
+// SACK for 3001:4001.
+// This SACK for an adjacent range causes the sender to
+// shift the newly-SACKed range onto the previous skb.
++.007 < . 1:1(0) ack 1 win 257 <sack 2001:4001 6001:7001 8001:9001,nop,nop>
+   +0 > . 1001:2001(1000) ack 1
+   +0 %{ assert tcpi_lost == 5, tcpi_lost }%
+   +0 %{ assert tcpi_reordering == 6, tcpi_reordering }%   // 8001:9001 -> 3001:4001 is 6
+
+// SACK for 9001:10001.
+ +.01 < . 1:1(0) ack 1 win 257 <sack 2001:4001 6001:7001 8001:10001,nop,nop>
+   +0 %{ assert tcpi_lost == 5, tcpi_lost }%
+
+// ACK for 1:1001 as packets from t=0.303 arrive.
++.083 < . 1:1(0) ack 1001 win 257 <sack 2001:4001 6001:7001 8001:10001,nop,nop>
+   +0 %{ assert tcpi_lost == 4,tcpi_lost }%
+
+// ACK for 1:4001 as packets from t=0.310 arrive.
++.017 < . 1:1(0) ack 4001 win 257 <sack 6001:7001 8001:10001,nop,nop>
+   +0 %{ assert tcpi_lost == 3,tcpi_lost }%
+
+// ACK for 1:7001 as packets from t=0.320 arrive.
+ +.01 < . 1:1(0) ack 7001 win 257 <sack 8001:10001,nop,nop>
+
+// ACK for all data as packets from t=0.403 arrive.
+  +.1 < . 1:1(0) ack 10001 win 257
+   +0 %{
+assert tcpi_ca_state == TCP_CA_Open, tcpi_ca_state
+assert tcpi_unacked == 0, tcpi_unacked
+assert tcpi_sacked == 0, tcpi_sacked
+assert tcpi_lost == 0, tcpi_lost
+assert tcpi_retrans == 0, tcpi_retrans
+}%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-7-3-4-8-9-fack.pkt b/tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-7-3-4-8-9-fack.pkt
new file mode 100644
index 000000000000..0093b4973934
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-7-3-4-8-9-fack.pkt
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test shifting of newly-SACKed ranges onto the previous already-SACKed skb.
+// This variant tests the case where we mark packets 0-4 lost, then
+// get a SACK for 3, and then a SACK for 4.
+
+`./defaults.sh`
+
+// Establish a connection and send 10 MSS.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 1024
+   +0 accept(3, ..., ...) = 4
+
+   +0 write(4, ..., 10000) = 10000
+   +0 > P. 1:10001(10000) ack 1
+
+// SACK for 7001:8001. Using RACK we delay the fast retransmit.
+  +.1 < . 1:1(0) ack 1 win 257 <sack 7001:8001,nop,nop>
+// RACK reordering timer
++.027 > . 1:1001(1000) ack 1
+   +0 %{
+assert tcpi_ca_state == TCP_CA_Recovery, tcpi_ca_state
+assert tcpi_lost == 7, tcpi_lost  # RACK thinks 1:7001 are lost
+assert tcpi_reordering == 3, tcpi_reordering
+}%
+
+// SACK for 3001:4001.
++.002 < . 1:1(0) ack 1 win 257 <sack 3001:4001 7001:8001,nop,nop>
+   +0 > . 1001:2001(1000) ack 1
+   +0 %{
+assert tcpi_lost == 6, tcpi_lost              # since 3001:4001 is no longer lost
+assert tcpi_reordering == 5, tcpi_reordering  # 7001:8001 -> 3001:4001
+}%
+
+// SACK for 4001:5001.
+// This SACK for an adjacent range causes the sender to
+// shift the newly-SACKed range onto the previous skb.
+// It uses the RFC3517 algorithm to mark 1:3001 lost
+// because >=3 higher-sequence packets are SACKed.
++.002 < . 1:1(0) ack 1 win 257 <sack 3001:5001 7001:8001,nop,nop>
+   +0 > . 2001:3001(1000) ack 1
+   +0 %{
+assert tcpi_lost == 5,tcpi_lost         # SACK/RFC3517 thinks 1:3001 are lost
+}%
+
+// SACK for 8001:9001.
++.002 < . 1:1(0) ack 1 win 257 <sack 3001:5001 7001:9001,nop,nop>
+
+// SACK for 9001:10001.
++.002 < . 1:1(0) ack 1 win 257 <sack 3001:5001 7001:10001,nop,nop>
+   +0 > . 5001:6001(1000) ack 1
+
+// To simplify clean-up, say we get an ACK for all data.
+  +.1 < . 1:1(0) ack 10001 win 257
+   +0 %{
+assert tcpi_ca_state == TCP_CA_Open, tcpi_ca_state
+assert tcpi_unacked == 0, tcpi_unacked
+assert tcpi_sacked == 0, tcpi_sacked
+assert tcpi_lost == 0, tcpi_lost
+assert tcpi_retrans == 0, tcpi_retrans
+}%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-7-5-6-8-9-fack.pkt b/tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-7-5-6-8-9-fack.pkt
new file mode 100644
index 000000000000..980a832dc81c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_sack_sack-shift-sacked-7-5-6-8-9-fack.pkt
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test shifting of newly-SACKed ranges onto the previous already-SACKed skb.
+// This variant tests the case where we mark packets 0-4 lost, then
+// get a SACK for 5, and then a SACK for 6.
+
+`./defaults.sh`
+
+// Establish a connection and send 10 MSS.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 1024
+   +0 accept(3, ..., ...) = 4
+
+   +0 write(4, ..., 10000) = 10000
+   +0 > P. 1:10001(10000) ack 1
+
+// SACK for 7001:8001. Using RACK we delay a fast retransmit.
+  +.1 < . 1:1(0) ack 1 win 257 <sack 7001:8001,nop,nop>
++.027 > . 1:1001(1000) ack 1
+   +0 %{
+assert tcpi_ca_state == TCP_CA_Recovery, tcpi_ca_state
+assert tcpi_lost == 7,tcpi_lost         # RACK thinks 1:7001 are lost
+assert tcpi_reordering == 3, tcpi_reordering
+}%
+
+// SACK for 5001:6001.
+   +0 < . 1:1(0) ack 1 win 257 <sack 5001:6001 7001:8001,nop,nop>
+   +0 > . 1001:2001(1000) ack 1
+   +0 %{
+assert tcpi_lost == 6, tcpi_lost
+assert tcpi_reordering == 3, tcpi_reordering  # 7001:8001 -> 5001:6001 is 3
+}%
+
+// SACK for 6001:7001.
+// This SACK for an adjacent range causes the sender to
+// shift the newly-SACKed range onto the previous skb.
+   +0 < . 1:1(0) ack 1 win 257 <sack 5001:8001,nop,nop>
+   +0 > . 2001:3001(1000) ack 1
+   +0 %{ assert tcpi_lost == 5, tcpi_lost }%
+
+// SACK for 8001:9001.
+   +0 < . 1:1(0) ack 1 win 257 <sack 5001:9001,nop,nop>
+   +0 > . 3001:4001(1000) ack 1
+
+// SACK for 9001:10001.
+   +0 < . 1:1(0) ack 1 win 257 <sack 5001:10001,nop,nop>
+   +0 > . 4001:5001(1000) ack 1
+
+// To simplify clean-up, say we get an ACK for all data.
+  +.1 < . 1:1(0) ack 10001 win 257
+   +0 %{
+assert tcpi_ca_state == TCP_CA_Open, tcpi_ca_state
+assert tcpi_unacked == 0, tcpi_unacked
+assert tcpi_sacked == 0, tcpi_sacked
+assert tcpi_lost == 0, tcpi_lost
+assert tcpi_retrans == 0, tcpi_retrans
+}%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-last_data_recv.pkt b/tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-last_data_recv.pkt
new file mode 100644
index 000000000000..2e616ee00f5f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-last_data_recv.pkt
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test tcpi_last_data_recv for active session
+`./defaults.sh`
+
+// Create a socket and set it to non-blocking.
++0    socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0    fcntl(3, F_GETFL) = 0x2 (flags O_RDWR)
++0    fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+
++0    connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
++0    > S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.030 < S. 0:0(0) ack 1 win 10000 <mss 1000,sackOK,nop,nop,nop,wscale 8>
++0    > . 1:1(0) ack 1
+
++1 %{ assert 990 <= tcpi_last_data_recv <= 1010, tcpi_last_data_recv }%
+
++0    < . 1:1001(1000) ack 1 win 300
++0    > . 1:1(0) ack 1001
+
++0 %{ assert tcpi_last_data_recv <= 10, tcpi_last_data_recv }%
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-rwnd-limited.pkt b/tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-rwnd-limited.pkt
new file mode 100644
index 000000000000..a9bcd46f6cb6
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-rwnd-limited.pkt
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test rwnd limited time in tcp_info for client side.
+
+`./defaults.sh`
+
+// Create a socket and set it to non-blocking.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 fcntl(3, F_GETFL) = 0x2 (flags O_RDWR)
+   +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+
+   +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+   +0 > S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+
+// Server advertises 0 receive window.
+ +.01 < S. 0:0(0) ack 1 win 0 <mss 1000,nop,nop,sackOK>
+
+   +0 > . 1:1(0) ack 1
+   +0 getsockopt(3, SOL_SOCKET, SO_ERROR, [0], [4]) = 0
+   +0 fcntl(3, F_SETFL, O_RDWR) = 0   // set back to blocking
+
+// Make sure that initial rwnd limited time is 0.
+   +0 %{ assert tcpi_rwnd_limited == 0, tcpi_rwnd_limited }%
+
+// Receive window limited time starts here.
+   +0 write(3, ..., 1000) = 1000
+
+// Check that rwnd limited time in tcp_info is around 0.1s.
+  +.1 %{ assert 98000 <= tcpi_rwnd_limited <= 110000, tcpi_rwnd_limited }%
+
+// Server opens the receive window.
+  +.1 < . 1:1(0) ack 1 win 2000
+
+// Check that rwnd limited time in tcp_info is around 0.2s.
+   +0 %{ assert 198000 <= tcpi_rwnd_limited <= 210000, tcpi_rwnd_limited }%
+
+   +0 > P. 1:1001(1000) ack 1
+
+// Server advertises a very small receive window.
+ +.03 < . 1:1(0) ack 1001 win 10
+
+// Receive window limited time starts again.
+   +0 write(3, ..., 1000) = 1000
+
+// Server opens the receive window again.
+  +.1 < . 1:1(0) ack 1001 win 2000
+// Check that rwnd limited time in tcp_info is around 0.3s
+// and busy time is 0.3 + 0.03 (server opened small window temporarily).
+   +0 %{ assert 298000 <= tcpi_rwnd_limited <= 310000, tcpi_rwnd_limited;\
+         assert 328000 <= tcpi_busy_time <= 340000, tcpi_busy_time;\
+}%
+
+   +0 > P. 1001:2001(1000) ack 1
+ +.02 < . 1:1(0) ack 2001 win 2000
+   +0 %{ assert 348000 <= tcpi_busy_time <= 360000, tcpi_busy_time }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-sndbuf-limited.pkt b/tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-sndbuf-limited.pkt
new file mode 100644
index 000000000000..47f1ba68d141
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_tcp_info_tcp-info-sndbuf-limited.pkt
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test send-buffer-limited time in tcp_info for client side.
+`./defaults.sh`
+
+// Create a socket and set it to non-blocking.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 fcntl(3, F_GETFL) = 0x2 (flags O_RDWR)
+   +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+
+   +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+   +0 > S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+ +.01 < S. 0:0(0) ack 1 win 10000 <mss 1000,sackOK,nop,nop,nop,wscale 8>
+   +0 > . 1:1(0) ack 1
+   +0 getsockopt(3, SOL_SOCKET, SO_ERROR, [0], [4]) = 0
+   +0 fcntl(3, F_SETFL, O_RDWR) = 0   // set back to blocking
+   +0 setsockopt(3, SOL_SOCKET, SO_SNDBUF, [10000], 4) = 0
+   +0 getsockopt(3, SOL_SOCKET, SO_SNDBUF, [20000], [4]) = 0
+
+ +.09...0.14 write(3, ..., 150000) = 150000
+
+ +.01 < . 1:1(0) ack 10001 win 10000
+
+ +.01 < . 1:1(0) ack 30001 win 10000
+
+// cwnd goes from 40(60KB) to 80(120KB), and that we hit the tiny sndbuf limit 10KB
+ +.01 < . 1:1(0) ack 70001 win 10000
+
+ +.02 < . 1:1(0) ack 95001 win 10000
+   +0 %{ assert 19000 <= tcpi_sndbuf_limited <= 21000, tcpi_sndbuf_limited; \
+	 assert 49000 <= tcpi_busy_time <= 52000, tcpi_busy_time; \
+	 assert 0 == tcpi_rwnd_limited, tcpi_rwnd_limited }%
+
+// This ack frees up enough buffer so we are no longer
+// buffer limited (socket flag SOCK_NOSPACE is cleared)
+ +.02 < . 1:1(0) ack 150001 win 10000
+   +0 %{ assert 19000 <= tcpi_sndbuf_limited <= 21000, tcpi_sndbuf_limited;\
+	 assert 69000 <= tcpi_busy_time <= 73000, tcpi_busy_time;\
+	 assert 0 == tcpi_rwnd_limited, tcpi_rwnd_limited }%
+
-- 
2.47.1.613.gc27f4b7a9f-goog


