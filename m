Return-Path: <linux-kselftest+bounces-43381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4448BE932C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B87A6E3229
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E7032E129;
	Fri, 17 Oct 2025 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sgj5XqfB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4EB2F6932
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711372; cv=none; b=q4yCj5be8xaXjTlK2hT4GBeEdBxjsZuUrfs7wvpv1sNStFhFkwkrL5I8qKXpFNP6z5IhP76WClYsfBrtfGIGuniAst5i4Jiwl5p04jiue9aBGwwKFQNTG8oQGCZd9a0X/Li1w+OG1XHo/dhDWUrvMbVAxsCQsjUo2ZOhZ49Yi2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711372; c=relaxed/simple;
	bh=AMnOGuPyTxc/wOAipROy8Cm7dD50UeGn7Exz5SN5tBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NuCqnu9H3GAZBIzZUdRuco1gJxzu1NpOAj/5h+KxgaQKgpR7GgtdKXD1+Pu0oN0+jXI/nbBEJqA6OSaNRCr9CrrIjkFTxucICKwbxn6vUZfDMG83YdiWboKIxDTiPkVPuDt93Qdutrs3o5J09SVqtzJl+mw0eUUGk6jwC/QNeoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sgj5XqfB; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 905074E41145;
	Fri, 17 Oct 2025 14:29:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5FCDB606DB;
	Fri, 17 Oct 2025 14:29:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF99F102F235F;
	Fri, 17 Oct 2025 16:29:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760711368; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=x12HquKXA7IzRCCiFRtnUfP0tLVK2UcLqpRyJLpa3RU=;
	b=sgj5XqfBa7fBeDAOe2/mqbaGQtpBKaJquiCiOLJBUjCU5a3fXl3+k0Fogheiw/imZR9RF9
	CYFH7ReyySXcwPu0ovWMQRBzf4gAu4MV6PhSVsM1JmmV6v5N4ElRA4fAS1v1Nda9wkxqsa
	FMV/fl7t1WEjgkXiF6vO/+ffYVe+GvoymqF9QljfccCTDmoF7lsVpKFQw3tt3MWt8g5LPg
	ZE09SG1l9j5t/IGa2EU/Nc3Ed2yQAme2Gb4ivrKbasTi2suwCC6HtZzRAB8TE57tmx3s49
	4RQr88fVjGkq4X5Y+ala1OPDupcJdxBbG0rQnvKDW6gnJTlT7FUoFuTu7mLXIQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 17 Oct 2025 16:29:02 +0200
Subject: [PATCH bpf-next 2/5] selftests/bpf: add tc helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251017-tc_tunnel-v1-2-2d86808d86b2@bootlin.com>
References: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
In-Reply-To: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The test_tunnel.c file defines small fonctions to easily attach eBPF
programs to tc hooks, either on egress, ingress or both.

Move those helpers in a dedicated file so that other tests can benefit
from it.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile               |  1 +
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 80 +-------------------
 tools/testing/selftests/bpf/tc_helpers.c           | 87 ++++++++++++++++++++++
 tools/testing/selftests/bpf/tc_helpers.h           |  9 +++
 4 files changed, 98 insertions(+), 79 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f00587d4ede68ef08419bdd545f0ce8e6c3fcfd2..2f248dab922f57e2c14053cb0bdfbb547efe1292 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -737,6 +737,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 netlink_helpers.c	\
 			 jit_disasm_helpers.c	\
 			 io_helpers.c		\
+			 tc_helpers.c		\
 			 test_loader.c		\
 			 xsk.c			\
 			 disasm.c		\
diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index bae0e9de277d24c34938de30b42f3418ecb6fba8..9e5577c74d60b02a7d39158967112805111b69d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -64,6 +64,7 @@
 
 #include "test_progs.h"
 #include "network_helpers.h"
+#include "tc_helpers.h"
 #include "test_tunnel_kern.skel.h"
 
 #define IP4_ADDR_VETH0 "172.16.1.100"
@@ -534,85 +535,6 @@ static void ping6_dev1(void)
 	close_netns(nstoken);
 }
 
-static int attach_tc_prog(int ifindex, int igr_fd, int egr_fd)
-{
-	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = ifindex,
-			    .attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS);
-	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts1, .handle = 1,
-			    .priority = 1, .prog_fd = igr_fd);
-	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts2, .handle = 1,
-			    .priority = 1, .prog_fd = egr_fd);
-	int ret;
-
-	ret = bpf_tc_hook_create(&hook);
-	if (!ASSERT_OK(ret, "create tc hook"))
-		return ret;
-
-	if (igr_fd >= 0) {
-		hook.attach_point = BPF_TC_INGRESS;
-		ret = bpf_tc_attach(&hook, &opts1);
-		if (!ASSERT_OK(ret, "bpf_tc_attach")) {
-			bpf_tc_hook_destroy(&hook);
-			return ret;
-		}
-	}
-
-	if (egr_fd >= 0) {
-		hook.attach_point = BPF_TC_EGRESS;
-		ret = bpf_tc_attach(&hook, &opts2);
-		if (!ASSERT_OK(ret, "bpf_tc_attach")) {
-			bpf_tc_hook_destroy(&hook);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-static int generic_attach(const char *dev, int igr_fd, int egr_fd)
-{
-	int ifindex;
-
-	if (!ASSERT_OK_FD(igr_fd, "check ingress fd"))
-		return -1;
-	if (!ASSERT_OK_FD(egr_fd, "check egress fd"))
-		return -1;
-
-	ifindex = if_nametoindex(dev);
-	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
-		return -1;
-
-	return attach_tc_prog(ifindex, igr_fd, egr_fd);
-}
-
-static int generic_attach_igr(const char *dev, int igr_fd)
-{
-	int ifindex;
-
-	if (!ASSERT_OK_FD(igr_fd, "check ingress fd"))
-		return -1;
-
-	ifindex = if_nametoindex(dev);
-	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
-		return -1;
-
-	return attach_tc_prog(ifindex, igr_fd, -1);
-}
-
-static int generic_attach_egr(const char *dev, int egr_fd)
-{
-	int ifindex;
-
-	if (!ASSERT_OK_FD(egr_fd, "check egress fd"))
-		return -1;
-
-	ifindex = if_nametoindex(dev);
-	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
-		return -1;
-
-	return attach_tc_prog(ifindex, -1, egr_fd);
-}
-
 static void test_vxlan_tunnel(void)
 {
 	struct test_tunnel_kern *skel = NULL;
diff --git a/tools/testing/selftests/bpf/tc_helpers.c b/tools/testing/selftests/bpf/tc_helpers.c
new file mode 100644
index 0000000000000000000000000000000000000000..d668e10e3ebad8f8e04862f5c2b3ccd487fe8fa6
--- /dev/null
+++ b/tools/testing/selftests/bpf/tc_helpers.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define _GNU_SOURCE
+
+#include <net/if.h>
+#include "tc_helpers.h"
+#include "test_progs.h"
+
+static int attach_tc_prog(int ifindex, int igr_fd, int egr_fd)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = ifindex,
+			    .attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS);
+	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts1, .handle = 1,
+			    .priority = 1, .prog_fd = igr_fd);
+	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts2, .handle = 1,
+			    .priority = 1, .prog_fd = egr_fd);
+	int ret;
+
+	ret = bpf_tc_hook_create(&hook);
+	if (!ASSERT_OK(ret, "create tc hook"))
+		return ret;
+
+	if (igr_fd >= 0) {
+		hook.attach_point = BPF_TC_INGRESS;
+		ret = bpf_tc_attach(&hook, &opts1);
+		if (!ASSERT_OK(ret, "bpf_tc_attach")) {
+			bpf_tc_hook_destroy(&hook);
+			return ret;
+		}
+	}
+
+	if (egr_fd >= 0) {
+		hook.attach_point = BPF_TC_EGRESS;
+		ret = bpf_tc_attach(&hook, &opts2);
+		if (!ASSERT_OK(ret, "bpf_tc_attach")) {
+			bpf_tc_hook_destroy(&hook);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int generic_attach(const char *dev, int igr_fd, int egr_fd)
+{
+	int ifindex;
+
+	if (!ASSERT_OK_FD(igr_fd, "check ingress fd"))
+		return -1;
+	if (!ASSERT_OK_FD(egr_fd, "check egress fd"))
+		return -1;
+
+	ifindex = if_nametoindex(dev);
+	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
+		return -1;
+
+	return attach_tc_prog(ifindex, igr_fd, egr_fd);
+}
+
+int generic_attach_igr(const char *dev, int igr_fd)
+{
+	int ifindex;
+
+	if (!ASSERT_OK_FD(igr_fd, "check ingress fd"))
+		return -1;
+
+	ifindex = if_nametoindex(dev);
+	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
+		return -1;
+
+	return attach_tc_prog(ifindex, igr_fd, -1);
+}
+
+int generic_attach_egr(const char *dev, int egr_fd)
+{
+	int ifindex;
+
+	if (!ASSERT_OK_FD(egr_fd, "check egress fd"))
+		return -1;
+
+	ifindex = if_nametoindex(dev);
+	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
+		return -1;
+
+	return attach_tc_prog(ifindex, -1, egr_fd);
+}
+
+
diff --git a/tools/testing/selftests/bpf/tc_helpers.h b/tools/testing/selftests/bpf/tc_helpers.h
new file mode 100644
index 0000000000000000000000000000000000000000..d31abe33f9d80dadd8f829bcf9a68cfd744c3b99
--- /dev/null
+++ b/tools/testing/selftests/bpf/tc_helpers.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TC_HELPERS_H
+#define __TC_HELPERS_H
+
+
+int generic_attach(const char *dev, int igr_fd, int egr_fd);
+int generic_attach_igr(const char *dev, int igr_fd);
+int generic_attach_egr(const char *dev, int egr_fd);
+#endif

-- 
2.51.0


