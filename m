Return-Path: <linux-kselftest+bounces-15552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7913195505D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F009C1F2481D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36711C4632;
	Fri, 16 Aug 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7ZPytUm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1631C3F32;
	Fri, 16 Aug 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830972; cv=none; b=En0b+R8KBmyfgksAE+g+dFJf+hbexnx6PWAqWbHAH7cGf4WzojjzJPMHApgq+XAUsF+65u+VFpIhsVwPteFV4h9yd66BRh+hWlW1f26UguoFzHCWGpIA4dukj7TmDGB2ApSvWH9/r6jm8D4xWE7GTgQT/pujr3GJqsq2Z/nESpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830972; c=relaxed/simple;
	bh=RoFVR6yT4mNH3ObeqFb9/cnsR2z5ewXxy5Jl49It58M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DpC+we7JK7UOcaAPneAIY4uoCJ9rHzEzwdYwU6Ca4MvGPMzc0xDjkUlfK6tp9smf+qAvH1anJ15GKlJV4mVpI5XmKRyer9VmOWFtP61hQ0pTJ8gCjuq8By4NBxqaNW03XcC3zdZhT3QKpbJ1sk727rZRNzU+a3P867ReLpU7uko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7ZPytUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813A8C4AF0F;
	Fri, 16 Aug 2024 17:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723830972;
	bh=RoFVR6yT4mNH3ObeqFb9/cnsR2z5ewXxy5Jl49It58M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W7ZPytUmP3jDEptkTeaqmKxNQJnCRJIoMu8N5O3BMKkt1tJpNBDuuapCMAowQjQUZ
	 SN4HyfNQE544DYHqVuqmRTeJFMNgSB0CgbuiGvSWGYdALmgTOWg6I/+foF9cWpXtUX
	 YNVXR5UhTEnTB+V92vSFUD5wBGk2PNldgJVJzpLeo/ox7MJJuzNVidOsgch7NyJGO0
	 uqmpq/2fm/T1kb4ORHBIBzy9/Yr+lVbvkhMBcDFLqpeEIqHTsIpYndATVdkNeqQtrq
	 x74YirrpaGgHD7RFWH0BY+0Eo2mNErEjttwvDvxK8u/RdCnA3D6erBP9O0YMQsbhZH
	 UNz/jv0y0UUQA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 16 Aug 2024 19:55:52 +0200
Subject: [PATCH bpf-next 1/2] selftests: bpf: use KHDR_INCLUDES for the
 UAPI headers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-ups-bpf-next-selftests-use-khdr-v1-1-1e19f3d5b17a@kernel.org>
References: <20240816-ups-bpf-next-selftests-use-khdr-v1-0-1e19f3d5b17a@kernel.org>
In-Reply-To: <20240816-ups-bpf-next-selftests-use-khdr-v1-0-1e19f3d5b17a@kernel.org>
To: mptcp@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8160; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RoFVR6yT4mNH3ObeqFb9/cnsR2z5ewXxy5Jl49It58M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmv5KyVrlqMX2LUx/4FY3pb5V2qCzSomZi8IBY0
 wiDWNoAcdOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr+SsgAKCRD2t4JPQmmg
 c0R7EACYD5d2GOAfk5hnKib0EsuAB3d50dmam5U4kLLqsYWcRspu+2t+z4roDSCxPEvhnsvL8Nm
 pZ3kQIb5BMZ36fzmJ2Ojq04t2QXz1zO2kL3n2qEIbiOEsxA8hg9/NBJY1FLc5hq0XYDGXIqCrvS
 AxAxGzG//jrUfO5Q4PQ3O5v7k6ivoxterTVwqi79lN1R7DNr3HuDse39bsvNQlzFTWkc23L/wtf
 VJi0FqOObawHyNTsxorOMuBKGl/AkKLARSsSi6vnt3RJG00DM58NL5aidjXT9J4L0mQOePPAJ7T
 k2W8tN2tzujZt+vqLEbxmR6ztD0h9XdehMIVb0Z11tqeDVMOWx+gL60X6cmGop8VFjYhxQ1NE7S
 09FivtaVNd8xU703IN650fbrppPBKyH2QJKQrfmuO+EVnlIkZdSQqSibWz2V3hqLxjKMN/LuLBj
 ed7V4tMYNa6fxYCIjc8p5vTfz8Lu7jfYqlqE9memnHGcJ/sOtDzOUI+CSvE3qXQC4Bv09CQB0zq
 6uzgWLyMnn6bYhNNI6GWR9P+uYsFP47O6jBGPuFP7Q/3WxoTGw+erOBJGPktrkKhEcbu7o+Q4wd
 njH32AuRp+5aePiMUu27u8ddIHpF7CFzOEtzl4fajuEf4fwOk3YhUg2WM2JZubSta8lIh/r7u1x
 ULixg4bqtreqoeQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of duplicating UAPI header files in 'tools/include/uapi', the
BPF selftests can also look at the header files inside the kernel
source.

To do that, the kernel selftests infrastructure provides the
'KHDR_INCLUDES' variable. This is what is being used in most selftests,
because it is what is recommended in the documentation [1]. If the
selftests are not executed from the kernel sources, it is possible to
override the variable, e.g.

  make KHDR_INCLUDES="-I${HDR_DIR}/include" -C "${KSFT_DIR}"

... where ${HDR_DIR} has been generated by this command:

  make headers_install INSTALL_HDR_PATH="${HDR_DIR}"

Thanks to 'KHDR_INCLUDES', it is no longer needed to duplicate header
files for userspace test programs, and these programs can include UAPI
header files without the 'uapi' prefix.

Note that it is still required to use 'tools/include/uapi' -- APIDIR,
which corresponds to TOOLS_INCLUDES from lib.mk -- for the BPF programs,
not to conflict with what is already defined in vmlinux.h.

Link: https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-tests-details [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/bpf/Makefile                       | 2 +-
 tools/testing/selftests/bpf/prog_tests/assign_reuse.c      | 2 +-
 tools/testing/selftests/bpf/prog_tests/tc_links.c          | 4 ++--
 tools/testing/selftests/bpf/prog_tests/tc_netkit.c         | 2 +-
 tools/testing/selftests/bpf/prog_tests/tc_opts.c           | 2 +-
 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c      | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_bonding.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c   | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_link.c          | 2 +-
 tools/testing/selftests/bpf/xdp_features.c                 | 4 ++--
 12 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4eceb491a8ae..6a7aeae7e206 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -37,7 +37,7 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
 	  -Wall -Werror -fno-omit-frame-pointer				\
 	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
-	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
+	  -I$(TOOLSINCDIR) $(KHDR_INCLUDES) -I$(OUTPUT)
 LDFLAGS += $(SAN_LDFLAGS)
 LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
 
diff --git a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
index 989ee4d9785b..3d06bf5a1ba4 100644
--- a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
+++ b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Isovalent */
-#include <uapi/linux/if_link.h>
+#include <linux/if_link.h>
 #include <test_progs.h>
 
 #include <netinet/tcp.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/testing/selftests/bpf/prog_tests/tc_links.c
index 1af9ec1149aa..532e162185c3 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Isovalent */
-#include <uapi/linux/if_link.h>
-#include <uapi/linux/pkt_sched.h>
+#include <linux/if_link.h>
+#include <linux/pkt_sched.h>
 #include <net/if.h>
 #include <test_progs.h>
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
index b9135720024c..1c8b8f03e873 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Isovalent */
-#include <uapi/linux/if_link.h>
+#include <linux/if_link.h>
 #include <net/if.h>
 #include <test_progs.h>
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index 196abf223465..14aee536c519 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Isovalent */
-#include <uapi/linux/if_link.h>
+#include <linux/if_link.h>
 #include <net/if.h>
 #include <test_progs.h>
 
diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
index dfff6feac12c..a37dda1b3cd2 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -12,7 +12,7 @@
 #include <sys/syscall.h>
 #include <sys/sysinfo.h>
 #include <test_progs.h>
-#include <uapi/linux/bpf.h>
+#include <linux/bpf.h>
 #include <unistd.h>
 
 #include "user_ringbuf_fail.skel.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index 6d8b54124cb3..ee9bd8606d14 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -18,7 +18,7 @@
 #include <linux/if_bonding.h>
 #include <linux/limits.h>
 #include <linux/udp.h>
-#include <uapi/linux/netdev.h>
+#include <linux/netdev.h>
 
 #include "xdp_dummy.skel.h"
 #include "xdp_redirect_multi_kern.skel.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
index 481626a875d1..e63a193e29e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <uapi/linux/bpf.h>
+#include <linux/bpf.h>
 #include <linux/if_link.h>
 #include <test_progs.h>
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
index ce6812558287..b916fa945b15 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <uapi/linux/bpf.h>
+#include <linux/bpf.h>
 #include <linux/if_link.h>
 #include <test_progs.h>
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index bad0ea167be7..c40a25837233 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -9,7 +9,7 @@
 #include <linux/in6.h>
 #include <linux/udp.h>
 #include <bpf/bpf_endian.h>
-#include <uapi/linux/netdev.h>
+#include <linux/netdev.h>
 #include "test_xdp_do_redirect.skel.h"
 
 struct udp_packet {
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_link.c b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
index e7e9f3c22edf..ab92c395a7c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include <uapi/linux/if_link.h>
+#include <linux/if_link.h>
 #include <test_progs.h>
 #include "test_xdp_link.skel.h"
 
diff --git a/tools/testing/selftests/bpf/xdp_features.c b/tools/testing/selftests/bpf/xdp_features.c
index 595c79141cf3..99b54674d94e 100644
--- a/tools/testing/selftests/bpf/xdp_features.c
+++ b/tools/testing/selftests/bpf/xdp_features.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <uapi/linux/bpf.h>
-#include <uapi/linux/netdev.h>
+#include <linux/bpf.h>
+#include <linux/netdev.h>
 #include <linux/if_link.h>
 #include <signal.h>
 #include <argp.h>

-- 
2.45.2


