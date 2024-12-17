Return-Path: <linux-kselftest+bounces-23468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508BC9F5691
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 19:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE0A189311B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 18:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426D31F9EBF;
	Tue, 17 Dec 2024 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUS8lVGr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C871F9EB3;
	Tue, 17 Dec 2024 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461543; cv=none; b=hBXmBOgXfhxhSi+REJ0iaP18uT02RyEftyNYgHGQ2/ms9Go1r9GymNp5pcCL+OnFYHyGCfu3C5IKUZC3XzqnaAdohwJrGb2fqYRKOMsKtSJoyJd4Xr+n9upSTvhyAKMmxdC+EvrX3Pz3sVS8vhbqtdidFU4bsrPES/aby6ZU12o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461543; c=relaxed/simple;
	bh=eDTOOP8Yq3N41D0FGgrvMaqRwwPdZB1ENd5RTz6n+vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NF1p45VYTeeI4Ta9nBsJ/FmFOcH2IhuvfXOAEiCH4tkXJXfP+o7c6TPOCgTXmI3y3RfKz+p0QttK6uWvf8bNLSo+16UxOpSjcnv9RCl68Pvfly+J1jrGWSYjPhghL3b6+bGtEHxBWhLTKXzQEHouUbebPOMzg/hc/UbNccq9FHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUS8lVGr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-218c80a97caso11653595ad.0;
        Tue, 17 Dec 2024 10:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734461540; x=1735066340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZyO+6QCWNwjrR6mezZYFG5l+My1Kog/pkP8ltIOYNU=;
        b=CUS8lVGr/ZcW6+2bnpTuySH6gxGfjVP8bReAE+hkMCluffpZTyBxO+HW/qQoPAemKm
         xKn8ZxM/vVSFxQQFKobM43HCwq0qr0iZMfcavqTpDYp8ZinHKAGkbYI6jr7YX7au/HcC
         MJb/nPp6I06tJKKqZRCggzpJWfNBHsHAJA+tkRINJWvDXVlGAEaIbUo3NH2I6MqAPy3Z
         Jmjksxf4ocyATsbhREPX7FL3BU7Ul8bXsJiUwySEq+JpMA0PD7ag3u57eJHcZCtaaO7f
         LAq05dTRoe/Vw80EIK3QWL7c56NF1XP6+gd3Zbssc6sBghTwgWb2znYz885lA3rqyc61
         s7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734461540; x=1735066340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZyO+6QCWNwjrR6mezZYFG5l+My1Kog/pkP8ltIOYNU=;
        b=vBNmxTsVOV3kbQlzliC3CFAdYDp04v7NxEtKPDUdmjMRD4sfZLvHUdIe1kXpZaTYY8
         AbZO1hCBBbOs3hm3XR4nK2+bvN7m/eDO7rsA8I8RhW0NSgW2e+PysPhRddRrRAzOxeCo
         eNTKSYpK4B3mmxmk+Tx8CVW52wjBmJs9JtaiOCY3+D2vEEOcHHqANwD6h9hoHTtGjP0v
         oyYEGfG+Rbmo7uia/kAMslNonUOrqnOg4/bgZ3vXCJ62t6Cw9NP05ooeEOeXF2SIjU+s
         3Uv+088yOMaV9LpYW4c4Ne9NuPADp/ay6D45QOUiwrW83bx6GY+ZlmdHrS0pIZEaIvyK
         gtQw==
X-Forwarded-Encrypted: i=1; AJvYcCXBjzT2gWJrxTm4v802nzMAdW0oxq1S4gImDvljOfQxoXUeKEM+DW9srE9jwppTPJzZarAwfYXtm85Spea5/fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvjyg/J5lntxf5p++8S+7sKYPqavbwkupli86MfxHdzNM2n9wp
	BpiQ+sH2m8HxOCGePlKoWT8fbFsJcB8bc68FzKIAM04ts+Ky/eHEhhBpARHBTpk=
X-Gm-Gg: ASbGncsmJOkH46enDGgb0yCETEF0WJw7tJnGPvlVkVUzAhstKyL8LcnA6YzYvtQY6YY
	xWk/13Y6ZHZNROiJuiU8uwrGkfJhr03hJyRGJzoCkMsLts9FTjSOQ66TUvy6d6GHQAe+UCGfznM
	plEWl6/NDFHTiZmhYd1Rne8U7aAYstovVYskXZqOLChQYG5Fz0no5209eJm0Dwj1RB1XoiXbRt1
	xu0wgqxtK2OmJyNuAoKk/MQ0OUkKiMJ7sWe0Z4BujWnroyWvOOMob8tpyo+GOHa1V89GgYBAP6e
	fp5wcZk9mEPrWovm6VabhUdq+nrqZilI4j08AT52msiZgoJqEHHGHvXzsQ==
X-Google-Smtp-Source: AGHT+IFS//apqzSboEGkPLjAnkEbA4QthafKWVkXB7esAa3Szox5Y1STqh+LuQNBE/M/kchETDZmfQ==
X-Received: by 2002:a17:902:bf06:b0:215:577b:ab77 with SMTP id d9443c01a7336-218d52b4bb6mr7190445ad.39.1734461539460;
        Tue, 17 Dec 2024 10:52:19 -0800 (PST)
Received: from sohamch-kvm.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dbb079sm62307715ad.31.2024.12.17.10.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:52:18 -0800 (PST)
From: Soham Chakradeo <sohamch.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Soham Chakradeo <sohamch@google.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 4/4] selftests/net: packetdrill: import tcp/user_timeout, tcp/validate, tcp/sendfile, tcp/limited-transmit, tcp/syscall_bad_arg
Date: Tue, 17 Dec 2024 18:52:01 +0000
Message-ID: <20241217185203.297935-5-sohamch.kernel@gmail.com>
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
 ...ited_transmit_limited-transmit-no-sack.pkt | 53 +++++++++++++++++++
 ...limited_transmit_limited-transmit-sack.pkt | 50 +++++++++++++++++
 .../tcp_sendfile_sendfile-simple.pkt          | 26 +++++++++
 ...scall_bad_arg_fastopen-invalid-buf-ptr.pkt | 42 +++++++++++++++
 .../tcp_syscall_bad_arg_sendmsg-empty-iov.pkt | 31 +++++++++++
 ...yscall_bad_arg_syscall-invalid-buf-ptr.pkt | 25 +++++++++
 .../tcp_user_timeout_user-timeout-probe.pkt   | 37 +++++++++++++
 .../tcp_user_timeout_user_timeout.pkt         | 33 ++++++++++++
 ...validate_validate-established-no-flags.pkt | 24 +++++++++
 9 files changed, 321 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_limited_transmit_limited-transmit-no-sack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_limited_transmit_limited-transmit-sack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_sendfile_sendfile-simple.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_fastopen-invalid-buf-ptr.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_syscall-invalid-buf-ptr.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_user_timeout_user-timeout-probe.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_user_timeout_user_timeout.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_validate_validate-established-no-flags.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_limited_transmit_limited-transmit-no-sack.pkt b/tools/testing/selftests/net/packetdrill/tcp_limited_transmit_limited-transmit-no-sack.pkt
new file mode 100644
index 000000000000..96b01eb5b7a4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_limited_transmit_limited-transmit-no-sack.pkt
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test RFC 3042 "Limited Transmit": "sending a new data segment in
+// response to each of the first two duplicate acknowledgments that
+// arrive at the sender".
+// This variation tests a receiver that doesn't support SACK.
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
+  +.1 < . 1:1(0) ack 1 win 320
+   +0 accept(3, ..., ...) = 4
+
+// Write some data, and send the initial congestion window.
+   +0 write(4, ..., 15000) = 15000
+   +0 > P. 1:10001(10000) ack 1
+
+// Limited transmit: on first dupack, send a new data segment.
+ +.11 < . 1:1(0) ack 1 win 320
+   +0 > . 10001:11001(1000) ack 1
+
+// Limited transmit: on second dupack, send a new data segment.
+ +.01 < . 1:1(0) ack 1 win 320
+   +0 > . 11001:12001(1000) ack 1
+
+// It turned out to be reordering, not loss.
+// We have one packet newly acked (1001:3001 were DUP-ACK'd)
+// So we revert state back to Open. Slow start cwnd from 10 to 11
+// and send 11 - 9 = 2 packets
+ +.01 < . 1:1(0) ack 3001 win 320
+   +0 > P. 12001:14001(2000) ack 1
+
+ +.02 < . 1:1(0) ack 5001 win 320
+   +0 > P. 14001:15001(1000) ack 1
+
+// Client gradually ACKs all data.
+ +.02 < . 1:1(0) ack 7001 win 320
+ +.02 < . 1:1(0) ack 9001 win 320
+ +.02 < . 1:1(0) ack 11001 win 320
+ +.02 < . 1:1(0) ack 13001 win 320
+ +.02 < . 1:1(0) ack 15001 win 320
+
+// Clean up.
+ +.17 close(4) = 0
+   +0 > F. 15001:15001(0) ack 1
+  +.1 < F. 1:1(0) ack 15002 win 257
+   +0 > . 15002:15002(0) ack 2
diff --git a/tools/testing/selftests/net/packetdrill/tcp_limited_transmit_limited-transmit-sack.pkt b/tools/testing/selftests/net/packetdrill/tcp_limited_transmit_limited-transmit-sack.pkt
new file mode 100644
index 000000000000..642da51ec3a4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_limited_transmit_limited-transmit-sack.pkt
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test RFC 3042 "Limited Transmit": "sending a new data segment in
+// response to each of the first two duplicate acknowledgments that
+// arrive at the sender".
+// This variation tests a receiver that supports SACK.
+
+`./defaults.sh`
+
+// Establish a connection.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+  +.1 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 320
+   +0 accept(3, ..., ...) = 4
+
+// Write some data, and send the initial congestion window.
+   +0 write(4, ..., 15000) = 15000
+   +0 > P. 1:10001(10000) ack 1
+
+// Limited transmit: on first dupack, send a new data segment.
+ +.11 < . 1:1(0) ack 1 win 320 <sack 1001:2001,nop,nop>
+   +0 > . 10001:11001(1000) ack 1
+
+// Limited transmit: on second dupack, send a new data segment.
+ +.01 < . 1:1(0) ack 1 win 320 <sack 1001:3001,nop,nop>
+   +0 > . 11001:12001(1000) ack 1
+
+// It turned out to be reordering, not loss.
+ +.01 < . 1:1(0) ack 3001 win 320
+   +0 > P. 12001:14001(2000) ack 1
+
+ +.02 < . 1:1(0) ack 5001 win 320
+   +0 > P. 14001:15001(1000) ack 1
+
+// Client gradually ACKs all data.
+ +.02 < . 1:1(0) ack 7001 win 320
+ +.02 < . 1:1(0) ack 9001 win 320
+ +.02 < . 1:1(0) ack 11001 win 320
+ +.02 < . 1:1(0) ack 13001 win 320
+ +.02 < . 1:1(0) ack 15001 win 320
+
+// Clean up.
+ +.17 close(4) = 0
+   +0 > F. 15001:15001(0) ack 1
+  +.1 < F. 1:1(0) ack 15002 win 257
+   +0 > . 15002:15002(0) ack 2
diff --git a/tools/testing/selftests/net/packetdrill/tcp_sendfile_sendfile-simple.pkt b/tools/testing/selftests/net/packetdrill/tcp_sendfile_sendfile-simple.pkt
new file mode 100644
index 000000000000..6740859a1360
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_sendfile_sendfile-simple.pkt
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+// Simplest possible test of open() and then sendfile().
+// We write some zeroes into a file (since packetdrill expects payloads
+// to be all zeroes) and then open() the file, then use sendfile()
+// and verify that the correct number of zeroes goes out.
+
+`./defaults.sh
+/bin/rm -f /tmp/testfile
+/bin/dd bs=1 count=5 if=/dev/zero of=/tmp/testfile status=none
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
+   +0 < . 1:1(0) ack 1 win 514
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 open("/tmp/testfile", O_RDONLY) = 5
+   +0 sendfile(4, 5, [0], 5) = 5
+   +0 > P. 1:6(5) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_fastopen-invalid-buf-ptr.pkt b/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_fastopen-invalid-buf-ptr.pkt
new file mode 100644
index 000000000000..8940726a3ec2
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_fastopen-invalid-buf-ptr.pkt
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test TCP fastopen behavior with NULL as buffer pointer, but a non-zero
+// buffer length.
+`./defaults.sh
+./set_sysctls.py /proc/sys/net/ipv4/tcp_timestamps=0`
+
+// Cache warmup: send a Fast Open cookie request
+ 0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
++0 setsockopt(3, SOL_TCP, TCP_FASTOPEN_CONNECT, [1], 4) = 0
++0 connect(3, ..., ...) = -1 EINPROGRESS (Operation is now in progress)
++0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO,nop,nop>
++0 < S. 123:123(0) ack 1 win 14600 <mss 1460,nop,nop,sackOK,nop,wscale 6,FO abcd1234,nop,nop>
++0 > . 1:1(0) ack 1
++0 close(3) = 0
++0 > F. 1:1(0) ack 1
++0 < F. 1:1(0) ack 2 win 92
++0 > .  2:2(0) ack 2
+
+// Test with MSG_FASTOPEN without TCP_FASTOPEN_CONNECT.
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
++0 sendto(4, NULL, 1, MSG_FASTOPEN, ..., ...) = -1
++0 close(4) = 0
+
+// Test with TCP_FASTOPEN_CONNECT without MSG_FASTOPEN.
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 5
++0 fcntl(5, F_SETFL, O_RDWR|O_NONBLOCK) = 0
++0 setsockopt(5, SOL_TCP, TCP_FASTOPEN_CONNECT, [1], 4) = 0
++0 connect(5, ..., ...) = 0
++0 sendto(5, NULL, 1, 0, ..., ...) = -1
++0 close(5) = 0
+
+// Test with both TCP_FASTOPEN_CONNECT and MSG_FASTOPEN.
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 6
++0 fcntl(6, F_SETFL, O_RDWR|O_NONBLOCK) = 0
++0 setsockopt(6, SOL_TCP, TCP_FASTOPEN_CONNECT, [1], 4) = 0
++0 connect(6, ..., ...) = 0
++0 sendto(6, NULL, 1, MSG_FASTOPEN, ..., ...) = -1
++0 close(6) = 0
+
+`/tmp/sysctl_restore_${PPID}.sh`
diff --git a/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt b/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt
new file mode 100644
index 000000000000..171c15da2728
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test that we correctly skip zero-length IOVs.
+`./defaults.sh`
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,wscale 8>
+ +.01 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+   +0 setsockopt(4, SOL_TCP, TCP_NODELAY, [1], 4) = 0
+
+   +0 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(4)=[{..., 0}, {..., 40}, {..., 0}, {..., 20}],
+                  msg_flags=0}, 0) = 60
+   +0 > P. 1:61(60) ack 1
+ +.01 < . 1:1(0) ack 61 win 257
+
+   +0 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(4)=[{..., 0}, {..., 0}, {..., 0}, {..., 0}],
+                  msg_flags=0}, MSG_ZEROCOPY) = 0
+
+   +0 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(4)=[{..., 0}, {..., 10}, {..., 0}, {..., 50}],
+                  msg_flags=0}, MSG_ZEROCOPY) = 60
+   +0 > P. 61:121(60) ack 1
+ +.01 < . 1:1(0) ack 121 win 257
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_syscall-invalid-buf-ptr.pkt b/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_syscall-invalid-buf-ptr.pkt
new file mode 100644
index 000000000000..59f5903f285c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_syscall-invalid-buf-ptr.pkt
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test kernel behavior with NULL as buffer pointer
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 10>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.2 < . 1:1(0) ack 1 win 514
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 write(4, NULL, 1000) = -1 EFAULT (Bad address)
+   +0 send(4, NULL, 1000, 0) = -1 EFAULT (Bad address)
+   +0 sendto(4, NULL, 1000, 0, ..., ...) = -1 EFAULT (Bad address)
+
+   +0 < . 1:1001(1000) ack 1 win 200
+   +0 read(4, NULL, 1000) = -1 EFAULT (Bad address)
+   +0 recv(4, NULL, 1000, 0) = -1 EFAULT (Bad address)
+   +0 recvfrom(4, NULL, 1000, 0, ..., ...) = -1 EFAULT (Bad address)
diff --git a/tools/testing/selftests/net/packetdrill/tcp_user_timeout_user-timeout-probe.pkt b/tools/testing/selftests/net/packetdrill/tcp_user_timeout_user-timeout-probe.pkt
new file mode 100644
index 000000000000..183051ba0cae
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_user_timeout_user-timeout-probe.pkt
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+
+   +0 < S 0:0(0) win 0 <mss 1460>
+   +0 > S. 0:0(0) ack 1 <mss 1460>
+
+  +.1 < . 1:1(0) ack 1 win 65530
+   +0 accept(3, ..., ...) = 4
+
+   +0 setsockopt(4, SOL_TCP, TCP_USER_TIMEOUT, [3000], 4) = 0
+   +0 write(4, ..., 24) = 24
+   +0 > P. 1:25(24) ack 1
+   +.1 < . 1:1(0) ack 25 win 65530
+   +0 %{ assert tcpi_probes == 0, tcpi_probes; \
+         assert tcpi_backoff == 0, tcpi_backoff }%
+
+// install a qdisc dropping all packets
+   +0 `tc qdisc delete dev tun0 root 2>/dev/null ; tc qdisc add dev tun0 root pfifo limit 0`
+   +0 write(4, ..., 24) = 24
+   // When qdisc is congested we retry every 500ms
+   // (TCP_RESOURCE_PROBE_INTERVAL) and therefore
+   // we retry 6 times before hitting 3s timeout.
+   // First verify that the connection is alive:
++3.250 write(4, ..., 24) = 24
+   // Now verify that shortly after that the socket is dead:
+ +.100 write(4, ..., 24) = -1 ETIMEDOUT (Connection timed out)
+
+   +0 %{ assert tcpi_probes == 6, tcpi_probes; \
+         assert tcpi_backoff == 0, tcpi_backoff }%
+   +0 close(4) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_user_timeout_user_timeout.pkt b/tools/testing/selftests/net/packetdrill/tcp_user_timeout_user_timeout.pkt
new file mode 100644
index 000000000000..edc371a5596b
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_user_timeout_user_timeout.pkt
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+`./defaults.sh`
+
+// Initialize connection
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
+  +.1 < . 1:1(0) ack 1 win 32792
+
+
+   +0 accept(3, ..., ...) = 4
+
+// Okay, we received nothing, and decide to close this idle socket.
+// We set TCP_USER_TIMEOUT to 3 seconds because really it is not worth
+// trying hard to cleanly close this flow, at the price of keeping
+// a TCP structure in kernel for about 1 minute !
+   +2 setsockopt(4, SOL_TCP, TCP_USER_TIMEOUT, [3000], 4) = 0
+   +0 close(4) = 0
+
+   +0 > F. 1:1(0) ack 1
+  +.3~+.400 > F. 1:1(0) ack 1
+  +.3~+.400 > F. 1:1(0) ack 1
+  +.6~+.800 > F. 1:1(0) ack 1
+
+// We finally receive something from the peer, but it is way too late
+// Our socket vanished because TCP_USER_TIMEOUT was really small
+   +0 < . 1:2(1) ack 1 win 32792
+   +0 > R 1:1(0)
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp_validate_validate-established-no-flags.pkt b/tools/testing/selftests/net/packetdrill/tcp_validate_validate-established-no-flags.pkt
new file mode 100644
index 000000000000..8bd60226ccfc
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_validate_validate-established-no-flags.pkt
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+// Verify that established connections drop a segment without the ACK flag set.
+
+`./defaults.sh`
+
+// Create a socket.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+// Establish a connection.
+   +0 < S 0:0(0) win 20000 <mss 1000,sackOK,nop,nop>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK>
+ +.01 < . 1:1(0) ack 1 win 20000
+   +0 accept(3, ..., ...) = 4
+
+// Receive a segment with no flags set, verify that it's not enqueued.
+ +.01 < - 1:1001(1000) win 20000
+   +0 ioctl(4, SIOCINQ, [0]) = 0
+
+// Receive a segment with ACK flag set, verify that it is enqueued.
+ +.01 < . 1:1001(1000) ack 1 win 20000
+   +0 ioctl(4, SIOCINQ, [1000]) = 0
-- 
2.47.1.613.gc27f4b7a9f-goog


