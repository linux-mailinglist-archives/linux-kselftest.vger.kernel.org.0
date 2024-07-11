Return-Path: <linux-kselftest+bounces-13579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554A092E707
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 13:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D158D1F27DE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E63E16C680;
	Thu, 11 Jul 2024 11:33:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EBF1607B3;
	Thu, 11 Jul 2024 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697598; cv=none; b=J4jwP5HoHP2RY+fuDyeM+oH5xTUWl2Iqu84G3ldu4yLpjIcXqCZBf0s0KL1JUeYsBd0Ye+DftmjrtKZbX5385w2vBwsNpIQ675KKQ+DVquj8bQSTtCmH1ziHFcx0tbI5rwR6+dU9p6RP+f4hjkS7WMovC6IlQTpySBaDXDUh2jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697598; c=relaxed/simple;
	bh=vtjp7xT4YXwZ4iYQIFComZgrWpTRVHT6wKNCkqf+1eA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OGE7XS6DDnuXKhzL9VoAE2uZgyHD1mcL5uWFKFQVb2sNZK+UBrki0nAeLumexUaZarXH2V700yP0/jl/F/th6izIZKU04D6vH//TdWJ7N0L+GIlmtV52OSPDQxE+rW4iViaSnLv+AQw1oEfoctf9liFCho1YyucmiEOgMMfcYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WKXf9408pz4f3kKD;
	Thu, 11 Jul 2024 19:33:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3B76A1A01D2;
	Thu, 11 Jul 2024 19:33:13 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgDXKvT0wo9mzI8hBw--.25380S8;
	Thu, 11 Jul 2024 19:33:12 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Brendan Jackman <jackmanb@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	John Johansen <john.johansen@canonical.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH bpf-next v4 19/20] selftests/bpf: Add test for lsm tail call
Date: Thu, 11 Jul 2024 19:38:27 +0800
Message-Id: <20240711113828.3818398-7-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
References: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXKvT0wo9mzI8hBw--.25380S8
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWkXw1UtF4UCr15AFy7Jrb_yoW5urW7pa
	48W345KryFvFy3Xw43KF4xuF4Sya1kuryUArW7XryYvrn7Arn7GF1xKFWUtFnxJFWruwn5
	Zas7trs7Cr48Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add test for lsm tail call to ensure tail call can only be used between
bpf lsm progs attached to the same hook.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/prog_tests/test_lsm.c       | 46 ++++++++++++++++++-
 .../selftests/bpf/progs/lsm_tailcall.c        | 34 ++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_tailcall.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
index 16175d579bc7..2a27f3714f5c 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
@@ -12,6 +12,7 @@
 #include <stdlib.h>
 
 #include "lsm.skel.h"
+#include "lsm_tailcall.skel.h"
 
 char *CMD_ARGS[] = {"true", NULL};
 
@@ -95,7 +96,7 @@ static int test_lsm(struct lsm *skel)
 	return 0;
 }
 
-void test_test_lsm(void)
+static void test_lsm_basic(void)
 {
 	struct lsm *skel = NULL;
 	int err;
@@ -114,3 +115,46 @@ void test_test_lsm(void)
 close_prog:
 	lsm__destroy(skel);
 }
+
+static void test_lsm_tailcall(void)
+{
+	struct lsm_tailcall *skel = NULL;
+	int map_fd, prog_fd;
+	int err, key;
+
+	skel = lsm_tailcall__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "lsm_tailcall__skel_load"))
+		goto close_prog;
+
+	map_fd = bpf_map__fd(skel->maps.jmp_table);
+	if (CHECK_FAIL(map_fd < 0))
+		goto close_prog;
+
+	prog_fd = bpf_program__fd(skel->progs.lsm_file_permission_prog);
+	if (CHECK_FAIL(prog_fd < 0))
+		goto close_prog;
+
+	key = 0;
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	if (CHECK_FAIL(!err))
+		goto close_prog;
+
+	prog_fd = bpf_program__fd(skel->progs.lsm_file_alloc_security_prog);
+	if (CHECK_FAIL(prog_fd < 0))
+		goto close_prog;
+
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	if (CHECK_FAIL(err))
+		goto close_prog;
+
+close_prog:
+	lsm_tailcall__destroy(skel);
+}
+
+void test_test_lsm(void)
+{
+	if (test__start_subtest("lsm_basic"))
+		test_lsm_basic();
+	if (test__start_subtest("lsm_tailcall"))
+		test_lsm_tailcall();
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_tailcall.c b/tools/testing/selftests/bpf/progs/lsm_tailcall.c
new file mode 100644
index 000000000000..49c075ce2d4c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_tailcall.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Huawei Technologies Co., Ltd */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+SEC("lsm/file_permission")
+int lsm_file_permission_prog(void *ctx)
+{
+	return 0;
+}
+
+SEC("lsm/file_alloc_security")
+int lsm_file_alloc_security_prog(void *ctx)
+{
+	return 0;
+}
+
+SEC("lsm/file_alloc_security")
+int lsm_file_alloc_security_entry(void *ctx)
+{
+	bpf_tail_call_static(ctx, &jmp_table, 0);
+	return 0;
+}
-- 
2.30.2


