Return-Path: <linux-kselftest+bounces-17775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C00BF975E34
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 02:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E452B21A6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 00:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4AF288BD;
	Thu, 12 Sep 2024 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKtPR/Ou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83BA1AACA;
	Thu, 12 Sep 2024 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102407; cv=none; b=ki46IKGtTP6XI0RUmtq0u5S89/K0HoPFQtL83Xr4xFaHxXWPe/bWc5G+rl04hO/mwT4+OLP8mKCjDAzR7I41IAmtfY0sNj2Va+J3fgi1o64HNSuR2/MDU/P0cMg6x6h2jCkLG9hbIMZ3UO87v3YO/4ZE0YBz8NAcRkAH5B2qsTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102407; c=relaxed/simple;
	bh=ooHki0IUKKvHEaRT1TIAKAYpg28fyT1CIPvlaBkLEVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbwgEkkjVo36VR4YT/J+WxF0tAzhV5ur7/85CYbjwBMCqJK2gnpygzHLy9RImfdpqD3d/9FftWGBtRDV59j6lhUahT+4Yg6VgGbdJsXVToiQ7cleYNh/iYKjkvVW9KknaKxYCuECmhX9PNjRI1JyXQiU7aDoOBDu/pDsQWaizv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKtPR/Ou; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c352bcb569so2167746d6.0;
        Wed, 11 Sep 2024 17:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726102404; x=1726707204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XLf5VnFEIa1b0e9lTeEgOR/HvKl48cnek9xVf5UAMo=;
        b=cKtPR/OuvUVNkjth7Eb/GRa2bNObFTQhV9FRd1Mi9NDN2g5oErnORYUQHB7faCpFXL
         hCQ/77mglMXxhXYTTU7MldLnIlIHfikRwG0YqtCRybYnQcr5VovK65yjnlORqVfpiW9R
         G0aSt2IQjcd/FqprT/gn4k/7u/mkP1LkiqcISCbsgLV2+ckLm1Z8+m7Y5qV7UigLI5e7
         XbMtvERukGsTFbUfZnzIJU+G0c1yBOdvPDmSHWAZrs/gouUHjqcVaQyu98MUbu4qUo5y
         fdBavPE2GuWZPdGIGhyKHonPQzB4Iu9aAMnFjR3X1qTNFBctrLtsYHZb6ImrW2WHAHRU
         n8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726102404; x=1726707204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XLf5VnFEIa1b0e9lTeEgOR/HvKl48cnek9xVf5UAMo=;
        b=OFwbWz/+PU9PHsiO8xUdxHrt5EY4iBdr2NBIYhJTevbhk2g+tLCB1KY/azFPhXkSXy
         z+xCNsvRvc5tcHvOA3Zd0L6gVVQKJCFY5Oxvi4jP0Fa5kRlqe0d9bvKR7kIkYAQxhvKg
         2p8JEVDpQeycPuUUCKuodunc0w6P5PoSL8p0OS0EI2j3nVJ5mH/OdMpYyiWIL6dC5Zwi
         o7qdM4L2JZbZhdBxYg3GFxfTZCdBBkJF1phm9zLVWB66PBXsAcJRiFX6KY54GrQF03P5
         3W+lKCrbeRzJ0/wKNDP5WtYrPKXCKtKhKPSzTepU8YoSzwgjA6vY7HHBjEEQUX6q+SfC
         nBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCqPr38Humq8yL4UIbgT3TvJXmxsEqccoALdFUJL3ZvkqWvl3vw99v0xsy1JoP+qJT8M2na510TbzzqOqc7w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhDqonQkK8ZJIedaMLli1Hsb1jtls4AIt3GF7kYY8anV94mJY/
	IeUKFcteYAScHqPdPaDWvAZw369WXjI1HLk97kwcGorbf3dUiNqyycBZLA==
X-Google-Smtp-Source: AGHT+IHkB/rYTz7LqednuaNgUsokaUEAhzWPWYmtj/gVk43Al2TEfHuaukmotxQzejklLS363jjItg==
X-Received: by 2002:a05:6214:4186:b0:6c5:71cc:1a2e with SMTP id 6a1803df08f44-6c573583d2fmr19609216d6.28.1726102403451;
        Wed, 11 Sep 2024 17:53:23 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53433b69dsm47947656d6.53.2024.09.11.17.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 17:53:22 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ncardwell@google.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	matttbe@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 2/3] selftests/net: packetdrill: import tcp/zerocopy
Date: Wed, 11 Sep 2024 20:52:41 -0400
Message-ID: <20240912005317.1253001-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240912005317.1253001-1-willemdebruijn.kernel@gmail.com>
References: <20240912005317.1253001-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Same as initial tests, import verbatim from
github.com/google/packetdrill, aside from:

- update `source ./defaults.sh` path to adjust for flat dir
- add SPDX headers
- remove author statements if any
- drop blank lines at EOF (new)

Also import set_sysctls.py, which many scripts depend on to set
sysctls and then restore them later. This is no longer strictly needed
for namespacified sysctl. But not all sysctls are namespacified, and
doesn't hurt if they are.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

changes v1->v2:
  - add set_sysctls.py to TEST_INCLUDES
  - drop blank lines at EOF
---
 .../selftests/net/packetdrill/Makefile        |   1 +
 .../selftests/net/packetdrill/set_sysctls.py  |  38 ++++++
 .../net/packetdrill/tcp_zerocopy_basic.pkt    |  55 ++++++++
 .../net/packetdrill/tcp_zerocopy_batch.pkt    |  41 ++++++
 .../net/packetdrill/tcp_zerocopy_client.pkt   |  30 +++++
 .../net/packetdrill/tcp_zerocopy_closed.pkt   |  44 +++++++
 .../packetdrill/tcp_zerocopy_epoll_edge.pkt   |  61 +++++++++
 .../tcp_zerocopy_epoll_exclusive.pkt          |  63 ++++++++++
 .../tcp_zerocopy_epoll_oneshot.pkt            |  66 ++++++++++
 .../tcp_zerocopy_fastopen-client.pkt          |  56 +++++++++
 .../tcp_zerocopy_fastopen-server.pkt          |  44 +++++++
 .../net/packetdrill/tcp_zerocopy_maxfrags.pkt | 118 ++++++++++++++++++
 .../net/packetdrill/tcp_zerocopy_small.pkt    |  57 +++++++++
 13 files changed, 674 insertions(+)
 create mode 100755 tools/testing/selftests/net/packetdrill/set_sysctls.py
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt

diff --git a/tools/testing/selftests/net/packetdrill/Makefile b/tools/testing/selftests/net/packetdrill/Makefile
index 870f7258dc8d7..31cfb666ba8b3 100644
--- a/tools/testing/selftests/net/packetdrill/Makefile
+++ b/tools/testing/selftests/net/packetdrill/Makefile
@@ -2,6 +2,7 @@
 
 TEST_INCLUDES := ksft_runner.sh \
 		 defaults.sh \
+		 set_sysctls.py \
 		 ../../kselftest/ktap_helpers.sh
 
 TEST_PROGS := $(wildcard *.pkt)
diff --git a/tools/testing/selftests/net/packetdrill/set_sysctls.py b/tools/testing/selftests/net/packetdrill/set_sysctls.py
new file mode 100755
index 0000000000000..5ddf456ae973a
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/set_sysctls.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Sets sysctl values and writes a file that restores them.
+
+The arguments are of the form "<proc-file>=<val>" separated by spaces.
+The program first reads the current value of the proc-file and creates
+a shell script named "/tmp/sysctl_restore_${PACKETDRILL_PID}.sh" which
+restores the values when executed. It then sets the new values.
+
+PACKETDRILL_PID is set by packetdrill to the pid of itself, so a .pkt
+file could restore sysctls by running `/tmp/sysctl_restore_${PPID}.sh`
+at the end.
+"""
+
+import os
+import subprocess
+import sys
+
+filename = '/tmp/sysctl_restore_%s.sh' % os.environ['PACKETDRILL_PID']
+
+# Open file for restoring sysctl values
+restore_file = open(filename, 'w')
+print('#!/bin/bash', file=restore_file)
+
+for a in sys.argv[1:]:
+  sysctl = a.split('=')
+  # sysctl[0] contains the proc-file name, sysctl[1] the new value
+
+  # read current value and add restore command to file
+  cur_val = subprocess.check_output(['cat', sysctl[0]], universal_newlines=True)
+  print('echo "%s" > %s' % (cur_val.strip(), sysctl[0]), file=restore_file)
+
+  # set new value
+  cmd = 'echo "%s" > %s' % (sysctl[1], sysctl[0])
+  os.system(cmd)
+
+os.system('chmod u+x %s' % filename)
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
new file mode 100644
index 0000000000000..a82c8899d36bf
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+// basic zerocopy test:
+//
+// send a packet with MSG_ZEROCOPY and receive the notification ID
+// repeat and verify IDs are consecutive
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 1:4001(4000) ack 1
+   +0 < . 1:1(0) ack 4001 win 257
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=0}}
+                   ]}, MSG_ERRQUEUE) = 0
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 4001:8001(4000) ack 1
+   +0 < . 1:1(0) ack 8001 win 257
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=1,
+                                    ee_data=1}}
+                   ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
new file mode 100644
index 0000000000000..c01915e7f4a15
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+// batch zerocopy test:
+//
+// send multiple packets, then read one range of all notifications.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_MARK, [666], 4) = 0
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 1:4001(4000) ack 1
+   +0 < . 1:1(0) ack 4001 win 257
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 4001:8001(4000) ack 1
+   +0 < . 1:1(0) ack 8001 win 257
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=1}}
+                  ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
new file mode 100644
index 0000000000000..6509882932e91
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+// Minimal client-side zerocopy test
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0...0 connect(4, ..., ...) = 0
+
+   +0 > S 0:0(0) <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 8>
+   +0 < S. 0:0(0) ack 1 win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > . 1:1(0) ack 1
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 1:4001(4000) ack 1
+   +0 < . 1:1(0) ack 4001 win 257
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=0}}
+                   ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
new file mode 100644
index 0000000000000..2cd78755cb2ac
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+// send with MSG_ZEROCOPY on a non-established socket
+//
+// verify that a send in state TCP_CLOSE correctly aborts the zerocopy
+// operation, specifically it does not increment the zerocopy counter.
+//
+// First send on a closed socket and wait for (absent) notification.
+// Then connect and send and verify that notification nr. is zero.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = -1 EPIPE (Broken pipe)
+
+   +0.1 recvmsg(4, {msg_name(...)=...,
+                    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE,
+                    msg_control=[]}, MSG_ERRQUEUE) = -1 EAGAIN (Resource temporarily unavailable)
+
+   +0...0 connect(4, ..., ...) = 0
+
+   +0 > S 0:0(0) <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 8>
+   +0 < S. 0:0(0) ack 1 win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > . 1:1(0) ack 1
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 1:4001(4000) ack 1
+   +0 < . 1:1(0) ack 4001 win 257
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=0}}
+                   ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
new file mode 100644
index 0000000000000..7671c20e01cf6
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+// epoll zerocopy test:
+//
+// EPOLLERR is known to be not edge-triggered unlike EPOLLIN and EPOLLOUT but
+// it is not level-triggered either.
+//
+// fire two sends with MSG_ZEROCOPY and receive the acks. confirm that EPOLLERR
+// is correctly fired only once, when EPOLLET is set. send another packet with
+// MSG_ZEROCOPY. confirm that EPOLLERR is correctly fired again only once.
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 epoll_create(1) = 5
+   +0 epoll_ctl(5, EPOLL_CTL_ADD, 4, {events=EPOLLOUT|EPOLLET, fd=4}) = 0
+   +0 epoll_wait(5, {events=EPOLLOUT, fd=4}, 1, 0) = 1
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 1:4001(4000) ack 1
+   +0 < . 1:1(0) ack 4001 win 257
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 4001:8001(4000) ack 1
+   +0 < . 1:1(0) ack 8001 win 257
+
+// receive only one EPOLLERR for the two sends above.
+   +0 epoll_wait(5, {events=EPOLLERR|EPOLLOUT, fd=4}, 1, 0) = 1
+   +0 epoll_wait(5, {events=0, ptr=0}, 1, 0) = 0
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 8001:12001(4000) ack 1
+   +0 < . 1:1(0) ack 12001 win 257
+
+// receive only one EPOLLERR for the third send above.
+   +0 epoll_wait(5, {events=EPOLLERR|EPOLLOUT, fd=4}, 1, 0) = 1
+   +0 epoll_wait(5, {events=0, ptr=0}, 1, 0) = 0
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=2}}
+                   ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
new file mode 100644
index 0000000000000..fadc480fdb7fe
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+// epoll zerocopy test:
+//
+// EPOLLERR is known to be not edge-triggered unlike EPOLLIN and EPOLLOUT but
+// it is not level-triggered either. this tests verify that the same behavior is
+// maintained when we have EPOLLEXCLUSIVE.
+//
+// fire two sends with MSG_ZEROCOPY and receive the acks. confirm that EPOLLERR
+// is correctly fired only once, when EPOLLET is set. send another packet with
+// MSG_ZEROCOPY. confirm that EPOLLERR is correctly fired again only once.
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 epoll_create(1) = 5
+   +0 epoll_ctl(5, EPOLL_CTL_ADD, 4,
+		{events=EPOLLOUT|EPOLLET|EPOLLEXCLUSIVE, fd=4}) = 0
+   +0 epoll_wait(5, {events=EPOLLOUT, fd=4}, 1, 0) = 1
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 1:4001(4000) ack 1
+   +0 < . 1:1(0) ack 4001 win 257
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 4001:8001(4000) ack 1
+   +0 < . 1:1(0) ack 8001 win 257
+
+// receive only one EPOLLERR for the two sends above.
+   +0 epoll_wait(5, {events=EPOLLERR|EPOLLOUT, fd=4}, 1, 0) = 1
+   +0 epoll_wait(5, {events=0, ptr=0}, 1, 0) = 0
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 8001:12001(4000) ack 1
+   +0 < . 1:1(0) ack 12001 win 257
+
+// receive only one EPOLLERR for the third send above.
+   +0 epoll_wait(5, {events=EPOLLERR|EPOLLOUT, fd=4}, 1, 0) = 1
+   +0 epoll_wait(5, {events=0, ptr=0}, 1, 0) = 0
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=2}}
+                   ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
new file mode 100644
index 0000000000000..5bfa0d1d2f4a3
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+// epoll zerocopy test:
+//
+// This is a test to confirm that EPOLLERR is only fired once for an FD when
+// EPOLLONESHOT is set.
+//
+// fire two sends with MSG_ZEROCOPY and receive the acks. confirm that EPOLLERR
+// is correctly fired only once, when EPOLLONESHOT is set. send another packet
+// with MSG_ZEROCOPY. confirm that EPOLLERR is not fired. Rearm the FD and
+// confirm that EPOLLERR is correctly set.
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 epoll_create(1) = 5
+   +0 epoll_ctl(5, EPOLL_CTL_ADD, 4,
+		{events=EPOLLOUT|EPOLLET|EPOLLONESHOT, fd=4}) = 0
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 1:4001(4000) ack 1
+   +0 < . 1:1(0) ack 4001 win 257
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 4001:8001(4000) ack 1
+   +0 < . 1:1(0) ack 8001 win 257
+
+// receive only one EPOLLERR for the two sends above.
+   +0 epoll_wait(5, {events=EPOLLERR|EPOLLOUT, fd=4}, 1, 0) = 1
+   +0 epoll_wait(5, {events=0, ptr=0}, 1, 0) = 0
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 8001:12001(4000) ack 1
+   +0 < . 1:1(0) ack 12001 win 257
+
+// receive no EPOLLERR for the third send above.
+   +0 epoll_wait(5, {events=0, ptr=0}, 1, 0) = 0
+
+// rearm the FD and verify the EPOLLERR is fired again.
+   +0 epoll_ctl(5, EPOLL_CTL_MOD, 4, {events=EPOLLOUT|EPOLLONESHOT, fd=4}) = 0
+   +0 epoll_wait(5, {events=EPOLLERR|EPOLLOUT, fd=4}, 1, 0) = 1
+   +0 epoll_wait(5, {events=0, ptr=0}, 1, 0) = 0
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=2}}
+                   ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
new file mode 100644
index 0000000000000..4a73bbf469610
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+// Fastopen client zerocopy test:
+//
+// send data with MSG_FASTOPEN | MSG_ZEROCOPY and verify that the
+// kernel returns the notification ID.
+//
+// Fastopen requires a stored cookie. Create two sockets. The first
+// one will have no data in the initial send. On return 0 the
+// zerocopy notification counter is not incremented. Verify this too.
+
+`./defaults.sh`
+
+// Send a FastOpen request, no cookie yet so no data in SYN
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 sendto(3, ..., 500, MSG_FASTOPEN|MSG_ZEROCOPY, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+   +0 > S 0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8,FO,nop,nop>
+ +.01 < S. 123:123(0) ack 1 win 14600 <mss 940,TS val 2000 ecr 1000,sackOK,nop,wscale 6, FO abcd1234,nop,nop>
+   +0 > . 1:1(0) ack 1 <nop,nop,TS val 1001 ecr 2000>
+
+// Read from error queue: no zerocopy notification
+   +1 recvmsg(3, {msg_name(...)=...,
+                    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE,
+                    msg_control=[]}, MSG_ERRQUEUE) = -1 EAGAIN (Resource temporarily unavailable)
+
+ +.01 close(3) = 0
+   +0 > F. 1:1(0) ack 1 <nop,nop,TS val 1002 ecr 2000>
+ +.01 < F. 1:1(0) ack 2 win 92 <nop,nop,TS val 2001 ecr 1002>
+   +0 > .  2:2(0) ack 2 <nop,nop,TS val 1003 ecr 2001>
+
+// Send another Fastopen request, now SYN will have data
+ +.07 `sysctl -q net.ipv4.tcp_timestamps=0`
+  +.1 socket(..., SOCK_STREAM, IPPROTO_TCP) = 5
+   +0 fcntl(5, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 setsockopt(5, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 sendto(5, ..., 500, MSG_FASTOPEN|MSG_ZEROCOPY, ..., ...) = 500
+   +0 > S 0:500(500) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO abcd1234,nop,nop>
+ +.05 < S. 5678:5678(0) ack 501 win 14600 <mss 1460,nop,nop,sackOK,nop,wscale 6>
+   +0 > . 501:501(0) ack 1
+
+// Read from error queue: now has first zerocopy notification
+   +0.5 recvmsg(5, {msg_name(...)=...,
+                    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE,
+                    msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=0}}
+                   ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
new file mode 100644
index 0000000000000..36086c5877ce7
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+// Fastopen server zerocopy test:
+//
+// send data with MSG_FASTOPEN | MSG_ZEROCOPY and verify that the
+// kernel returns the notification ID.
+
+`./defaults.sh
+ ./set_sysctls.py /proc/sys/net/ipv4/tcp_fastopen=0x207`
+
+// Set up a TFO server listening socket.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+  +.1 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [2], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+
+// Client sends a SYN with data.
+  +.1 < S 0:1000(1000) win 32792 <mss 1460,sackOK,nop,nop>
+   +0 > S. 0:0(0) ack 1001 <mss 1460,nop,nop,sackOK>
+
+// Server accepts and replies with data.
++.005 accept(3, ..., ...) = 4
+   +0 read(4, ..., 1024) = 1000
+   +0 sendto(4, ..., 1000, MSG_ZEROCOPY, ..., ...) = 1000
+   +0 > P. 1:1001(1000) ack 1001
+ +.05 < . 1001:1001(0) ack 1001 win 32792
+
+// Read from error queue: now has first zerocopy notification
+  +0.1 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                      {cmsg_level=CMSG_LEVEL_IP,
+                       cmsg_type=CMSG_TYPE_RECVERR,
+                       cmsg_data={ee_errno=0,
+                                  ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                  ee_type=0,
+                                  ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                  ee_info=0,
+                                  ee_data=0}}
+                  ]}, MSG_ERRQUEUE) = 0
+
+`/tmp/sysctl_restore_${PPID}.sh`
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
new file mode 100644
index 0000000000000..672f817faca0d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+// tcp_MAX_SKB_FRAGS test
+//
+// Verify that sending an iovec of tcp_MAX_SKB_FRAGS + 1 elements will
+// 1) fit in a single packet without zerocopy
+// 2) spill over into a second packet with zerocopy,
+//    because each iovec element becomes a frag
+// 3) the PSH bit is set on an skb when it runs out of fragments
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+
+   // Each pinned zerocopy page is fully accounted to skb->truesize.
+   // This test generates a worst case packet with each frag storing
+   // one byte, but increasing truesize with a page (64KB on PPC).
+   +0 setsockopt(3, SOL_SOCKET, SO_SNDBUF, [2000000], 4) = 0
+
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   // send an iov of 18 elements: just becomes a linear skb
+   +0 sendmsg(4, {msg_name(...)=...,
+		  msg_iov(18)=[{..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}],
+		  msg_flags=0}, 0) = 18
+
+   +0 > P. 1:19(18) ack 1
+   +0 < . 1:1(0) ack 19 win 257
+
+   // send a zerocopy iov of 18 elements:
+   +1 sendmsg(4, {msg_name(...)=...,
+		  msg_iov(18)=[{..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}],
+		  msg_flags=0}, MSG_ZEROCOPY) = 18
+
+   // verify that it is split in one skb of 17 frags + 1 of 1 frag
+   // verify that both have the PSH bit set
+   +0 > P. 19:36(17) ack 1
+   +0 < . 1:1(0) ack 36 win 257
+
+   +0 > P. 36:37(1) ack 1
+   +0 < . 1:1(0) ack 37 win 257
+
+   +1 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=0}}
+                   ]}, MSG_ERRQUEUE) = 0
+
+   // send a zerocopy iov of 64 elements:
+   +0 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(64)=[{..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1}],
+                  msg_flags=0}, MSG_ZEROCOPY) = 64
+
+   // verify that it is split in skbs with 17 frags
+   +0 > P. 37:54(17) ack 1
+   +0 < . 1:1(0) ack 54 win 257
+
+   +0 > P. 54:71(17) ack 1
+   +0 < . 1:1(0) ack 71 win 257
+
+   +0 > P. 71:88(17) ack 1
+   +0 < . 1:1(0) ack 88 win 257
+
+   +0 > P. 88:101(13) ack 1
+   +0 < . 1:1(0) ack 101 win 257
+
+   +1 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=1,
+                                    ee_data=1}}
+                   ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt
new file mode 100644
index 0000000000000..a9a1ac0aea4f4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+// small packet zerocopy test:
+//
+// verify that SO_EE_CODE_ZEROCOPY_COPIED is set on zerocopy
+// packets of all sizes, including the smallest payload, 1B.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   // send 1B
+   +0 send(4, ..., 1, MSG_ZEROCOPY) = 1
+   +0 > P. 1:2(1) ack 1
+   +0 < . 1:1(0) ack 2 win 257
+
+   +1 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=0}}
+                   ]}, MSG_ERRQUEUE) = 0
+
+   // send 1B again
+   +0 send(4, ..., 1, MSG_ZEROCOPY) = 1
+   +0 > P. 2:3(1) ack 1
+   +0 < . 1:1(0) ack 3 win 257
+
+   +1 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=1,
+                                    ee_data=1}}
+                   ]}, MSG_ERRQUEUE) = 0
-- 
2.46.0.598.g6f2099f65c-goog


