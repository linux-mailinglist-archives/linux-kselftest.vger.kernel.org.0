Return-Path: <linux-kselftest+bounces-23467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFD49F5693
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 19:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B18117082C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 18:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74D21F9A92;
	Tue, 17 Dec 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmvJAROy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3121F9AB7;
	Tue, 17 Dec 2024 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461542; cv=none; b=qE6B/EYUqCPEvh4hmd4eUIFX13KxZxzhe8RXF2yodLsCTidqldPwLb88mKDJjFNYrfBnoq4Xtw2nsb/P7Ek1Z99dWSOmiIne2npJh59j2B8xA/p3MInwU0IzVTfhxuUUCG19p/7Vc1ZSgvJHfpW3IqvbNT1JXaV1JgFBTIABd/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461542; c=relaxed/simple;
	bh=u+FMOUIlnJDZ8mdMwro7HfjugcRmF++RceUtMw8Q8NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y62iRSda/49vb3BmTz4A18gFnbGYbvFyZTBMUQ49cSZDdqrRWjbGZ0476vRMzxOjLrJFaTaI3kJ6WNynbCMNgv6Qlc08mXjgnxu3i+LjQDR2JbdAtxFB0mQomteddGdLGqHlbfDF6lFj9QhTT5b4dFgTLCbkVK3clYJLtMSal4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmvJAROy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-218c8aca5f1so15467995ad.0;
        Tue, 17 Dec 2024 10:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734461537; x=1735066337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OUGfAnnmrS/Rjsof2vORc6nItHYk0ZB6kf6OSqTthA=;
        b=NmvJAROyvLI+0gwhnaq0i4Th4RlXiY48f4d5ZdtBc8XiqDj9dMuW4MsB+TweT4MAFA
         OAItZVQRGZU2rZTxyGePK0q//yr+XYvyGSfqY2EfzwiPT+RgTFo7WdiBgtQu28sPJz5S
         U9lIBMCL6BQi9uTLMVaohYmTSy2eWl++Zivpnj+9xrSCkpTb7UE8MbcHTJ2oU+zg/YnC
         sOsGS+Qgzg3P/tGmkD1PFIs0p3HOMvG8pn3YTv7HWJMB2luSVY5VBpczq+oikuIUP/AE
         KmK+rQeS1MXI753RM5vfXfDFPLT2lvrMGF0JmrC74PHqS/Yjdt8uS/Fms0PvkczEjeaf
         95rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734461537; x=1735066337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OUGfAnnmrS/Rjsof2vORc6nItHYk0ZB6kf6OSqTthA=;
        b=MBR32SXXxkjHAKV7Jk83f8xVtuBMk/rDew6dxNjUd2GrrL/0LYw8YTQj9BlgEdKGvC
         KEHXScRlH8THCwhH2DFziK8r5JBgrhdSrpsK28PR9V1qjGHhnAeHdU4U2TpwXV6U0apa
         Mrjwgb+upz/BCw4cgpo2B83a88psZ2lJP5DSufGMdCXAzyv1ZDI6p+iNAHG88oXgD9x9
         x3CJnFyHAAzMxDk8MvOlgAa1+ShSBgW7FlK+rhDzzhMMvwJ1TfIjGiG4Zwb6BV3MLvEC
         4UL/3yE0O4v8DWhNnCfebYtxaRrhquH5ZyugtQxMXkc9d96ezwu8epZLXsJ07otNbuOI
         ZpvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvZwH9/IQdo3Q3mQmGhNnl7pfZI2SdbQkcoR1T/i6JgKH5l+w4D3h6z1hkW1prlTLK+qy1XkPHjx9UdTEDZx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx766vwfzLUYoyEOmf8a96Y9Iz7JKsKxPYNx2DF7jg2uGAe0C3w
	swSGm6WLFC8nqsiDEkMlms/bSAqbqc1tLduB/ZXU46lPHLoWeE2O2maas5lT8Cg=
X-Gm-Gg: ASbGncugok8IEDRipMlkI0+KYo6/CTQOxY3d+OcxUxzsH07XS1MCAKpoi0wVMH4kPGE
	9IphCmo1Huq/5bLSHay8pTy+g9wXu5dX4Z7X1p7OAKM8zd/0Wzbqg06a18BnvBxU3mbEvN+4TtK
	DZXynImV93WuZdlOQ9eJitIPM1U8eLQqlyrji/hXmpkOdOkjWG1Nsg6X9xFKcQLPL9t8hUUIfm9
	qcxRc3LEP9HhtjgBsYGwCTFGq6umHx9Sln0IfJGm6IibjA8fFeJYNBSZkeHpgVlUnozCxmD6Oad
	EnGsBsTwOBOMbRvvUMHe/54312hkD7gcSeObxevJLJjFZSg+VZxoDzaN2A==
X-Google-Smtp-Source: AGHT+IEI9Uun3RB5Kn/bszZcGU6hC3+LemrWIXCr2DmXfWuhbtVlyye9RF5LjGAikdkqoneH2lr6rQ==
X-Received: by 2002:a17:903:234c:b0:212:5786:7bb6 with SMTP id d9443c01a7336-218929929a2mr202073205ad.3.1734461537325;
        Tue, 17 Dec 2024 10:52:17 -0800 (PST)
Received: from sohamch-kvm.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dbb079sm62307715ad.31.2024.12.17.10.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:52:16 -0800 (PST)
From: Soham Chakradeo <sohamch.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Soham Chakradeo <sohamch@google.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 3/4] selftests/net: packetdrill: import tcp/eor, tcp/splice, tcp/ts_recent, tcp/blocking
Date: Tue, 17 Dec 2024 18:52:00 +0000
Message-ID: <20241217185203.297935-4-sohamch.kernel@gmail.com>
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

Use the standard import and testing method, as described in the
import of tcp/ecn and tcp/close , tcp/sack , tcp/tcp_info.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Soham Chakradeo <sohamch@google.com>
---
 .../tcp_blocking_blocking-accept.pkt          | 18 +++++
 .../tcp_blocking_blocking-connect.pkt         | 13 ++++
 .../tcp_blocking_blocking-read.pkt            | 29 ++++++++
 .../tcp_blocking_blocking-write.pkt           | 35 +++++++++
 .../packetdrill/tcp_eor_no-coalesce-large.pkt | 38 ++++++++++
 .../tcp_eor_no-coalesce-retrans.pkt           | 72 +++++++++++++++++++
 .../packetdrill/tcp_eor_no-coalesce-small.pkt | 36 ++++++++++
 .../tcp_eor_no-coalesce-subsequent.pkt        | 66 +++++++++++++++++
 .../tcp_splice_tcp_splice_loop_test.pkt       | 20 ++++++
 .../packetdrill/tcp_ts_recent_fin_tsval.pkt   | 23 ++++++
 .../packetdrill/tcp_ts_recent_invalid_ack.pkt | 25 +++++++
 .../packetdrill/tcp_ts_recent_reset_tsval.pkt | 25 +++++++
 12 files changed, 400 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-accept.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-read.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-write.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-large.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-retrans.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-small.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-subsequent.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_splice_tcp_splice_loop_test.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ts_recent_fin_tsval.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ts_recent_invalid_ack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ts_recent_reset_tsval.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-accept.pkt b/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-accept.pkt
new file mode 100644
index 000000000000..38535701656e
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-accept.pkt
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test for blocking accept.
+
+`./defaults.sh`
+
+// Establish a connection.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0...0.200 accept(3, ..., ...) = 4
+
+  +.1 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 257
+
+  +.1 write(4, ..., 2000) = 2000
+   +0 > P. 1:2001(2000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-connect.pkt b/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-connect.pkt
new file mode 100644
index 000000000000..3692ef102381
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-connect.pkt
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test for blocking connect.
+
+`./defaults.sh`
+
+// Establish a connection.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+
+  +.1...0.200 connect(3, ..., ...) = 0
+
+   +0 > S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+  +.1 < S. 0:0(0) ack 1 win 5792 <mss 1460,nop,wscale 2,nop,nop,sackOK>
+   +0 > . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-read.pkt b/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-read.pkt
new file mode 100644
index 000000000000..914eabab367a
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-read.pkt
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test for blocking read.
+--tolerance_usecs=10000
+
+`./defaults.sh`
+
+// Establish a connection.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+  +.1 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+
+   +0...0.100 read(4, ..., 2000) = 2000
+  +.1 < P. 1:2001(2000) ack 1 win 257
+   +0 > . 1:1(0) ack 2001
+
+  +.1...0.200 read(4, ..., 2000) = 2000
+  +.1 < P. 2001:4001(2000) ack 1 win 257
+   +0 > . 1:1(0) ack 4001
+
+  +.1 < P. 4001:6001(2000) ack 1 win 257
+   +0 > . 1:1(0) ack 6001
+   +0...0.000 read(4, ..., 1000) = 1000
+   +0...0.000 read(4, ..., 1000) = 1000
diff --git a/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-write.pkt b/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-write.pkt
new file mode 100644
index 000000000000..cec5a0725d95
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-write.pkt
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test for blocking write.
+--tolerance_usecs=10000
+
+`./defaults.sh
+./set_sysctls.py /proc/sys/net/ipv4/tcp_min_tso_segs=10
+`
+
+// Establish a connection.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+  +.1 < S 0:0(0) win 50000 <mss 1000,nop,wscale 0>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 50000
+   +0 accept(3, ..., ...) = 4
+
+// Kernel doubles our value -> sk->sk_sndbuf is set to 42000
+   +0 setsockopt(4, SOL_SOCKET, SO_SNDBUF,  [21000], 4) = 0
+   +0 getsockopt(4, SOL_SOCKET, SO_SNDBUF,  [42000], [4]) = 0
+
+// A write of 60000 does not block.
+   +0...0.300 write(4, ..., 61000) = 61000    // this write() blocks
+
+  +.1 < . 1:1(0) ack 10001 win 50000
+
+  +.1 < . 1:1(0) ack 30001 win 50000
+
+// This ACK should wakeup the write(). An ACK of 35001 does not.
+  +.1 < . 1:1(0) ack 36001 win 50000
+
+// Reset to sysctls defaults.
+`/tmp/sysctl_restore_${PPID}.sh`
diff --git a/tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-large.pkt b/tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-large.pkt
new file mode 100644
index 000000000000..f95b9b3c9fa1
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-large.pkt
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test TCP does not append any data from consequent writes to the tail
+// skb created for the chunk. The large chunk itself should be packetized as
+// usual.
+`./defaults.sh
+`
+
+// Initialize connection
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 10>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+ +.01 < . 1:1(0) ack 1 win 514
+
+   +0 accept(3, ..., ...) = 4
+
+// Write a 10400B chunk to fill the ICW, and have a 400 byte skb sitting on
+// the tail.
+   +0 write(4, ..., 10400) = 10400
+
+// Write another 10040B chunk with no coalescing options.
+   +0 send(4, ..., 10400, MSG_EOR) = 10400
+
+// Write a 2KB chunk. This chunk should not be appended to the packets created
+// the previous chunk.
+   +0 write(4, ..., 2000) = 2000
+
+   +0 > P. 1:10001(10000) ack 1
++.001 < .  1:1(0) ack 10001 win 514
+// Now we have enough room to send out the 2 x 400B packets out.
+   +0 > P. 10001:20801(10800) ack 1
++.001 < .  1:1(0) ack 20801 win 514
+// This 2KB packet should be sent alone.
+   +0 > P. 20801:22801(2000) ack 1
++.001 < .  1:1(0) ack 22801 win 514
diff --git a/tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-retrans.pkt b/tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-retrans.pkt
new file mode 100644
index 000000000000..2ff66075288e
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-retrans.pkt
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test TCP does not append any data from consequent writes to the tail
+// skb created for the chunk. Also, when packets are retransmitted, they
+// will not be coalesce into the same skb.
+`./defaults.sh
+`
+
+// Initialize connection
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 10>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+ +.01 < . 1:1(0) ack 1 win 514
+
+   +0 accept(3, ..., ...) = 4
+
+// Write a 10400B chunk to fill the ICW, and have a 400 byte skb sitting on
+// the tail.
+   +0 write(4, ..., 10400) = 10400
+
+// Write 10 400B chunks with no coalescing options.
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+// This chunk should not be appended to the skbs created for the previous chunk.
+   +0 write(4, ..., 10000) = 10000
+
+   +0 > P. 1:10001(10000) ack 1
++.001 < .  1:1(0) ack 10001 win 514
+// Now we have enough room to send out the 2 x 400B packets out.
+   +0 > P. 10001:10801(800) ack 1
+// The 9 remaining 400B chunks should be sent as individual packets.
+   +0 > P. 10801:11201(400) ack 1
+   +0 > P. 11201:11601(400) ack 1
+   +0 > P. 11601:12001(400) ack 1
+   +0 > P. 12001:12401(400) ack 1
+   +0 > P. 12401:12801(400) ack 1
+   +0 > P. 12801:13201(400) ack 1
+   +0 > P. 13201:13601(400) ack 1
+   +0 > P. 13601:14001(400) ack 1
+   +0 > P. 14001:14401(400) ack 1
+// The last 10KB chunk should be sent separately.
+   +0 > P. 14401:24401(10000) ack 1
+
++.001 < .  1:1(0) ack 10401 win 514
++.001 < .  1:1(0) ack 10801 win 514
++.001 < .  1:1(0) ack 11201 win 514
++.001 < .  1:1(0) ack 11601 win 514
++.001 < .  1:1(0) ack 12001 win 514 <sack 13201:14401,nop,nop>
+// TCP should fill the hole but no coalescing should happen, and all
+// retransmissions should be sent out as individual packets.
+
+// Note : This is timeout based retransmit.
+// Do not put +0 here or flakes will come back.
++.004~+.008 > P. 12001:12401(400) ack 1
+
++.001 < .  1:1(0) ack 12401 win 514 <sack 13201:14401,nop,nop>
+   +0 > P. 12401:12801(400) ack 1
+   +0 > P. 12801:13201(400) ack 1
++.001 < .  1:1(0) ack 12801 win 514 <sack 13201:14401,nop,nop>
++.001 < .  1:1(0) ack 14401 win 514
++.001 < .  1:1(0) ack 24401 win 514
diff --git a/tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-small.pkt b/tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-small.pkt
new file mode 100644
index 000000000000..77039c5aac39
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-small.pkt
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test TCP does not append any data from consequent writes to the tail
+// skb created for the chunk.
+`./defaults.sh
+`
+
+// Initialize connection
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 10>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+ +.01 < . 1:1(0) ack 1 win 514
+
+   +0 accept(3, ..., ...) = 4
+
+// Write a 10400B chunk to fill the ICW, and have a 400 byte skb sitting on
+// the tail.
+   +0 write(4, ..., 10400) = 10400
+
+// Write a 400B chunk with no coalescing options.
+   +0 send(4, ..., 400, MSG_EOR) = 400
+
+// This chunk should not be appended to the skbs created for the previous chunk.
+   +0 write(4, ..., 10000) = 10000
+
+   +0 > P. 1:10001(10000) ack 1
++.001 < .  1:1(0) ack 10001 win 514
+// Now we have enough room to send out the 2 x 400B packets out.
+   +0 > P. 10001:10801(800) ack 1
+   +0 > P. 10801:20801(10000) ack 1
++.001 < .  1:1(0) ack 10401 win 514
++.001 < .  1:1(0) ack 10801 win 514
++.001 < .  1:1(0) ack 20801 win 514
diff --git a/tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-subsequent.pkt b/tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-subsequent.pkt
new file mode 100644
index 000000000000..dd5a06250595
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_eor_no-coalesce-subsequent.pkt
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test TCP does not append any data from consequent writes to the tail
+// skb created for the chunk even though we have 10 back-to-back small
+// writes.
+`./defaults.sh
+`
+
+// Initialize connection
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 10>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+ +.01 < . 1:1(0) ack 1 win 514
+
+   +0 accept(3, ..., ...) = 4
+
+// Write a 10400B chunk to fill the ICW, and have a 400 byte skb sitting on
+// the tail.
+   +0 write(4, ..., 10400) = 10400
+
+// Write 10 400B chunks with no coalescing options.
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+   +0 send(4, ..., 400, MSG_EOR) = 400
+// This chunk should not be appended to the skbs created for the previous chunk.
+   +0 write(4, ..., 10000) = 10000
+
+   +0 > P. 1:10001(10000) ack 1
++.001 < .  1:1(0) ack 10001 win 514
+// Now we have enough room to send out the 2 x 400B packets out.
+   +0 > P. 10001:10801(800) ack 1
+// The 9 remaining 400B chunks should be sent as individual packets.
+   +0 > P. 10801:11201(400) ack 1
+   +0 > P. 11201:11601(400) ack 1
+   +0 > P. 11601:12001(400) ack 1
+   +0 > P. 12001:12401(400) ack 1
+   +0 > P. 12401:12801(400) ack 1
+   +0 > P. 12801:13201(400) ack 1
+   +0 > P. 13201:13601(400) ack 1
+   +0 > P. 13601:14001(400) ack 1
+   +0 > P. 14001:14401(400) ack 1
+// The last 10KB chunk should be sent separately.
+   +0 > P. 14401:24401(10000) ack 1
+
++.001 < .  1:1(0) ack 10401 win 514
++.001 < .  1:1(0) ack 10801 win 514
++.001 < .  1:1(0) ack 11201 win 514
++.001 < .  1:1(0) ack 11601 win 514
++.001 < .  1:1(0) ack 12001 win 514
++.001 < .  1:1(0) ack 12401 win 514
++.001 < .  1:1(0) ack 12801 win 514
++.001 < .  1:1(0) ack 13201 win 514
++.001 < .  1:1(0) ack 13601 win 514
++.001 < .  1:1(0) ack 14001 win 514
++.001 < .  1:1(0) ack 14401 win 514
++.001 < .  1:1(0) ack 24401 win 514
diff --git a/tools/testing/selftests/net/packetdrill/tcp_splice_tcp_splice_loop_test.pkt b/tools/testing/selftests/net/packetdrill/tcp_splice_tcp_splice_loop_test.pkt
new file mode 100644
index 000000000000..0cbd43253236
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_splice_tcp_splice_loop_test.pkt
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+`./defaults.sh`
+
+// Initialize a server socket
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_IP, IP_FREEBIND, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+// Connection should get accepted
+   +0 < S 0:0(0) win 32972 <mss 1460,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <...>
+   +0 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+
+   +0 pipe([5, 6]) = 0
+   +0 < U. 1:101(100) ack 1 win 257 urg 100
+   +0 splice(4, NULL, 6, NULL, 99, 0) = 99
+   +0 splice(4, NULL, 6, NULL, 1, 0) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_ts_recent_fin_tsval.pkt b/tools/testing/selftests/net/packetdrill/tcp_ts_recent_fin_tsval.pkt
new file mode 100644
index 000000000000..e61424a7bd0a
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_ts_recent_fin_tsval.pkt
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test that we send FIN packet with correct TSval
+--tcp_ts_tick_usecs=1000
+--tolerance_usecs=7000
+
+`./defaults.sh`
+
+// Create a socket.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+// Establish a connection.
+   +0 < S 0:0(0) win 20000 <mss 1000,sackOK,TS val 100 ecr 0>
+   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 100 ecr 100>
+  +.1 < . 1:1(0) ack 1 win 20000 <nop,nop,TS val 200 ecr 100>
+   +0 accept(3, ..., ...) = 4
+
+   +1 close(4) = 0
+// Check that FIN TSval is updated properly, one second has passed since last sent packet.
+   +0 > F. 1:1(0) ack 1 <nop,nop,TS val 1200 ecr 200>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_ts_recent_invalid_ack.pkt b/tools/testing/selftests/net/packetdrill/tcp_ts_recent_invalid_ack.pkt
new file mode 100644
index 000000000000..174ce9a1bfc0
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_ts_recent_invalid_ack.pkt
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test that we reject TS val updates on a packet with invalid ACK sequence
+
+`./defaults.sh
+`
+
+// Create a socket.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+// Establish a connection.
+  +.1 < S 0:0(0) win 20000 <mss 1000,sackOK,TS val 100 ecr 0>
+   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 100 ecr 100>
+  +.1 < . 1:1(0) ack 1 win 20000 <nop,nop,TS val 200 ecr 100>
+   +0 accept(3, ..., ...) = 4
+
+// bad packet with high tsval (its ACK sequence is above our sndnxt)
+   +0 < F. 1:1(0) ack 9999 win 20000 <nop,nop,TS val 200000 ecr 100>
+
+
+   +0 < . 1:1001(1000) ack 1 win 20000 <nop,nop,TS val 201 ecr 100>
+   +0 > . 1:1(0) ack 1001 <nop,nop,TS val 200 ecr 201>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_ts_recent_reset_tsval.pkt b/tools/testing/selftests/net/packetdrill/tcp_ts_recent_reset_tsval.pkt
new file mode 100644
index 000000000000..2e3b3bb7493a
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_ts_recent_reset_tsval.pkt
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test that we send RST packet with correct TSval
+--tcp_ts_tick_usecs=1000
+
+`./defaults.sh`
+
+// Create a socket.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+// Establish a connection.
+   +0 < S 0:0(0) win 20000 <mss 1000,sackOK,TS val 100 ecr 0>
+   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 100 ecr 100>
+  +.1 < . 1:1(0) ack 1 win 20000 <nop,nop,TS val 200 ecr 100>
+   +0 accept(3, ..., ...) = 4
+
+   +0 < . 1:1001(1000) ack 1 win 20000 <nop,nop,TS val 201 ecr 100>
+   +0 > . 1:1(0) ack 1001 <nop,nop,TS val 200 ecr 201>
+
+   +1 close(4) = 0
+// Check that RST TSval is updated properly, one second has passed since last sent packet.
+   +0 > R. 1:1(0) ack 1001 <nop,nop,TS val 1200 ecr 201>
-- 
2.47.1.613.gc27f4b7a9f-goog


