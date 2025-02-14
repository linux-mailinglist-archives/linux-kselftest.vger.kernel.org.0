Return-Path: <linux-kselftest+bounces-26688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C603FA36757
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 22:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265E23A71D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 21:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2F11FC11F;
	Fri, 14 Feb 2025 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Ja0+x4ai"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1341DB128
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567602; cv=none; b=nEmm0GhXReZwNPxIbjhlXLGCpEs/x/MdqINV18yE0fi1gIXkleZtzxknGQHr+9CmYSNjaZEjnEjQd4uy5P4w3ijaXTuhuWMdV+spo7590k8Xq5FbbcEuBAtPK31V2j1fo1iTKFb+iHDFDDEKNcLUGBS+UF4JE8ZRzcNV1Zn8zp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567602; c=relaxed/simple;
	bh=rlrXc4hroYFAQc+w/Ml5h4jot5Mubo3164+XNtZ2tik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bY/Nq6owwN/6HorYIcZyqmxtG9P1LToQs3+91BHte3lVjZBY1TxuKxXqm/sHYLcqq1xyeog/tBLG64yqHOi1C4h9xu0xDXuTLskWy9ytarWxhyzDT5AqoaUnluYsXFM0CARwBnQeZ+AVtf7//sWBNhnx+jmrFi2rOMG9OfugV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Ja0+x4ai; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f441791e40so3708373a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 13:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739567600; x=1740172400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQVAlNj3QbWNBbK5rOU0fAHCX0qfBnwQBa4usEGobZQ=;
        b=Ja0+x4aisuqZX6j7K6q0RT6PIGWxYXy2CmHnhtzzzpw3Muex46I2n4e1oLXPvuXHZW
         0Jjptcz42G/ONltGNOd7eDRIqb1hoy98vClaT6yMDQSCHMRMjT7AXOMQv86vN+cyXxqX
         Bk2Q4QGbGlw/fUM+VEwNj6NsP9xBzzR8EGDWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739567600; x=1740172400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQVAlNj3QbWNBbK5rOU0fAHCX0qfBnwQBa4usEGobZQ=;
        b=SN7jJbJHPoecWRdxdiWKrxu6yuYXe3ME78zCVbQx/szoHPY4foCC399KAy6mJeAaQo
         Jje8JPWovxDz49rZFJZtukAo2HgfO5UyhR+xbR/J9GsYNtZps1KA6AozQGLIF1Dipqpv
         QmrxlVpO5+MQRvkF/4fhg4o8zckEV86MsgR2YTz17LNYqlmj6P0jgkZ1XFydHFIzSfRk
         tdlHpAbqwyp+WWROjHlDYxPyQ7iZ4exsoZsuiiFs2xrDxp4oU7K1HbL2411sDBpvgGLa
         uNuBHaCOcBvM4nFM423V/KuxVOl2+vp9oZErouWiSxNE1uecdg/UkI/do/aakGV2TH4A
         r7Og==
X-Forwarded-Encrypted: i=1; AJvYcCUejTeT/xeztfLOka8SPt9RKk87CFpop8mNvTK2ejWoaR5jjwM0CVhnf40TeBKtI4EWj6CETl4yH+vOCPwIpcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhj10LJmlAJCqP1IVJqBp8rRm4Wh2VKG3Md/LJySGRuKiDrh5f
	YVoewf0MgIieYS0oKXzhU0BAGU+UTQVQIjPiYNPStpE6YvnPMJhq5iZMoWAXWHA=
X-Gm-Gg: ASbGncuvTzU2gKnsRzzdH0AQDdulww1EF6yarD1nnDONaAI4Gi/Ka9qBZitBZedsPWA
	45YNiZ5thL2S1Y6dc5IQt0JZXKUdPWQNgeQXB2lnp8dvy87RDssCDN67jbN0HwggOl5C57bU33j
	XQX6IZUgQfpfkZzygjVGnmozOVZzEnenERp+cDdueLa9+k+o/mjeid2BFA+osUde5NM00pXQu2/
	ICzpFpNeELxQSbH2XK+s3a0eca2Ids6eal8t+PCSUcg9jEfUcsjO0gFIzqr35wCGsKCTHKJeRdF
	PYkwFDG2FX7G/FnIOBVtm8s=
X-Google-Smtp-Source: AGHT+IG25rthdsrePVBbc4s0lfFZSqx3GHujdDrq1qGR930P5reQFwnTWK+/n+GUAgL9O+BCHUIXBg==
X-Received: by 2002:a17:90b:1b0d:b0:2ee:c9b6:4c42 with SMTP id 98e67ed59e1d1-2fc40f22cbamr1022240a91.16.1739567600010;
        Fri, 14 Feb 2025 13:13:20 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55908a7sm33285265ad.240.2025.02.14.13.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:13:19 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: stfomichev@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next v8 3/3] selftests: drv-net: Test queue xsk attribute
Date: Fri, 14 Feb 2025 21:12:31 +0000
Message-ID: <20250214211255.14194-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214211255.14194-1-jdamato@fastly.com>
References: <20250214211255.14194-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that queues which are used for AF_XDP have the xsk nest attribute.
The attribute is currently empty, but its existence means the AF_XDP is
being used for the queue. Enable CONFIG_XDP_SOCKETS for
selftests/drivers/net tests, as well.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
---
 v8:
   - Switch from TEST_GET_PROGS to TEST_GEN_FILES in the Makefile.
   - Fix codespell spelling issue in xdp_helper.c

 v7:
   - Added CONFIG_XDP_SOCKETS=y to selftests/drivers/net/config.
   - Updated xdp_helper to return -1 on AF_XDP non-existence, 1 for
     other failures.
   - Updated queues.py to skip if AF_XDP does not not exist, fail
     otherwise.

 v3:
   - Change comment style of helper C program to avoid kdoc warnings as
     suggested by Jakub. No other changes.

 v2:
   - Updated the Python test after changes to patch 1 which expose an
     empty nest
   - Updated Python test with general Python coding feedback

 .../testing/selftests/drivers/net/.gitignore  |  2 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/config    |  1 +
 tools/testing/selftests/drivers/net/queues.py | 42 +++++++-
 .../selftests/drivers/net/xdp_helper.c        | 98 +++++++++++++++++++
 5 files changed, 143 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c

diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
new file mode 100644
index 000000000000..ec746f374e85
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+xdp_helper
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 28b6d47f812d..0c95bd944d56 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -1,10 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
+CFLAGS += $(KHDR_INCLUDES)
 
 TEST_INCLUDES := $(wildcard lib/py/*.py) \
 		 $(wildcard lib/sh/*.sh) \
 		 ../../net/net_helper.sh \
 		 ../../net/lib.sh \
 
+TEST_GEN_FILES := xdp_helper
+
 TEST_PROGS := \
 	netcons_basic.sh \
 	netcons_fragmented_msg.sh \
diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index a2d8af60876d..f27172ddee0a 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -4,3 +4,4 @@ CONFIG_CONFIGFS_FS=y
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
+CONFIG_XDP_SOCKETS=y
diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 38303da957ee..5fdfebc6415f 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -2,13 +2,16 @@
 # SPDX-License-Identifier: GPL-2.0
 
 from lib.py import ksft_disruptive, ksft_exit, ksft_run
-from lib.py import ksft_eq, ksft_raises, KsftSkipEx
+from lib.py import ksft_eq, ksft_raises, KsftSkipEx, KsftFailEx
 from lib.py import EthtoolFamily, NetdevFamily, NlError
 from lib.py import NetDrvEnv
 from lib.py import cmd, defer, ip
 import errno
 import glob
-
+import os
+import socket
+import struct
+import subprocess
 
 def sys_get_queues(ifname, qtype='rx') -> int:
     folders = glob.glob(f'/sys/class/net/{ifname}/queues/{qtype}-*')
@@ -21,6 +24,39 @@ def nl_get_queues(cfg, nl, qtype='rx'):
         return len([q for q in queues if q['type'] == qtype])
     return None
 
+def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
+    test_dir = os.path.dirname(os.path.realpath(__file__))
+    xdp = subprocess.Popen([f"{test_dir}/xdp_helper", f"{cfg.ifindex}", f"{xdp_queue_id}"],
+                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
+                           text=True)
+    defer(xdp.kill)
+
+    stdout, stderr = xdp.communicate(timeout=10)
+    rx = tx = False
+
+    if xdp.returncode == 255:
+        raise KsftSkipEx('AF_XDP unsupported')
+    elif xdp.returncode > 0:
+        raise KsftFailEx('unable to create AF_XDP socket')
+
+    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
+    if not queues:
+        raise KsftSkipEx("Netlink reports no queues")
+
+    for q in queues:
+        if q['id'] == 0:
+            if q['type'] == 'rx':
+                rx = True
+            if q['type'] == 'tx':
+                tx = True
+
+            ksft_eq(q['xsk'], {})
+        else:
+            if 'xsk' in q:
+                _fail("Check failed: xsk attribute set.")
+
+    ksft_eq(rx, True)
+    ksft_eq(tx, True)
 
 def get_queues(cfg, nl) -> None:
     snl = NetdevFamily(recv_size=4096)
@@ -81,7 +117,7 @@ def check_down(cfg, nl) -> None:
 
 def main() -> None:
     with NetDrvEnv(__file__, queue_count=100) as cfg:
-        ksft_run([get_queues, addremove_queues, check_down], args=(cfg, NetdevFamily()))
+        ksft_run([get_queues, addremove_queues, check_down, check_xdp], args=(cfg, NetdevFamily()))
     ksft_exit()
 
 
diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
new file mode 100644
index 000000000000..cf06a88b830b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/xdp_helper.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/socket.h>
+#include <linux/if_xdp.h>
+#include <linux/if_link.h>
+#include <net/if.h>
+#include <inttypes.h>
+
+#define UMEM_SZ (1U << 16)
+#define NUM_DESC (UMEM_SZ / 2048)
+
+/* this is a simple helper program that creates an XDP socket and does the
+ * minimum necessary to get bind() to succeed.
+ *
+ * this test program is not intended to actually process packets, but could be
+ * extended in the future if that is actually needed.
+ *
+ * it is used by queues.py to ensure the xsk netlinux attribute is set
+ * correctly.
+ */
+int main(int argc, char **argv)
+{
+	struct xdp_umem_reg umem_reg = { 0 };
+	struct sockaddr_xdp sxdp = { 0 };
+	int num_desc = NUM_DESC;
+	void *umem_area;
+	int ifindex;
+	int sock_fd;
+	int queue;
+	char byte;
+
+	if (argc != 3) {
+		fprintf(stderr, "Usage: %s ifindex queue_id", argv[0]);
+		return 1;
+	}
+
+	sock_fd = socket(AF_XDP, SOCK_RAW, 0);
+	if (sock_fd < 0) {
+		perror("socket creation failed");
+		/* if the kernel doesn't support AF_XDP, let the test program
+		 * know with -1. All other error paths return 1.
+		 */
+		if (errno == EAFNOSUPPORT)
+			return -1;
+		return 1;
+	}
+
+	ifindex = atoi(argv[1]);
+	queue = atoi(argv[2]);
+
+	umem_area = mmap(NULL, UMEM_SZ, PROT_READ | PROT_WRITE, MAP_PRIVATE |
+			MAP_ANONYMOUS, -1, 0);
+	if (umem_area == MAP_FAILED) {
+		perror("mmap failed");
+		return 1;
+	}
+
+	umem_reg.addr = (uintptr_t)umem_area;
+	umem_reg.len = UMEM_SZ;
+	umem_reg.chunk_size = 2048;
+	umem_reg.headroom = 0;
+
+	setsockopt(sock_fd, SOL_XDP, XDP_UMEM_REG, &umem_reg,
+		   sizeof(umem_reg));
+	setsockopt(sock_fd, SOL_XDP, XDP_UMEM_FILL_RING, &num_desc,
+		   sizeof(num_desc));
+	setsockopt(sock_fd, SOL_XDP, XDP_UMEM_COMPLETION_RING, &num_desc,
+		   sizeof(num_desc));
+	setsockopt(sock_fd, SOL_XDP, XDP_RX_RING, &num_desc, sizeof(num_desc));
+
+	sxdp.sxdp_family = AF_XDP;
+	sxdp.sxdp_ifindex = ifindex;
+	sxdp.sxdp_queue_id = queue;
+	sxdp.sxdp_flags = 0;
+
+	if (bind(sock_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)) != 0) {
+		munmap(umem_area, UMEM_SZ);
+		perror("bind failed");
+		close(sock_fd);
+		return 1;
+	}
+
+	/* give the parent program some data when the socket is ready*/
+	fprintf(stdout, "%d\n", sock_fd);
+
+	/* parent program will write a byte to stdin when its ready for this
+	 * helper to exit
+	 */
+	read(STDIN_FILENO, &byte, 1);
+
+	close(sock_fd);
+	return 0;
+}
-- 
2.43.0


