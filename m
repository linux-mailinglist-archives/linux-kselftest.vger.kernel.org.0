Return-Path: <linux-kselftest+bounces-7698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B237A8A147E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 14:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14C60B250F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BE214EC44;
	Thu, 11 Apr 2024 12:24:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB1214C585;
	Thu, 11 Apr 2024 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838293; cv=none; b=KNDyPYhQJ40Js3PCVzmJhVN0MDAIX/UXaOgnxF4qJ7fmILRV+Fu1uDODMyjDBwOQL+6crDkh+4Ys69hLAAtB9DE7GeL7XymY3ngZ2U46pX5JwCuH1nsy5+yz3cbbZ/ruKJUjTgeuO4znbx8Bn82Ksy6Y0YJZOOkEEzW0q3jrJGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838293; c=relaxed/simple;
	bh=vtjp7xT4YXwZ4iYQIFComZgrWpTRVHT6wKNCkqf+1eA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GtP3VaesFSO5RuZWoippwzyokzwR/cubyEacIwtAK80hgmJkfvr2CC+hJAgqWXMigROBx88kZqM6c2g68traV3GU3e8frOmQthqLNWozia1XaHq0ybonBLzmyL/95s7fLKximXsH66YK8cMbTg7MsXsfDLmbobBPzJFuUrGocyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VFf5k3jgjz4f3kpB;
	Thu, 11 Apr 2024 20:24:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E8EE11A0572;
	Thu, 11 Apr 2024 20:24:46 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgA3h2mJ1hdmZ5R_Jw--.23051S12;
	Thu, 11 Apr 2024 20:24:46 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org
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
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 10/11] selftests/bpf: Add test for lsm tail call
Date: Thu, 11 Apr 2024 20:27:51 +0800
Message-Id: <20240411122752.2873562-11-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3h2mJ1hdmZ5R_Jw--.23051S12
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWkXw1UtF4UCr15AFy7Jrb_yoW5urW7pa
	48W345KryFvFy3Xw43KF4xuF4Sya1kuryUArW7XryYvrn7Arn7GF1xKFWUtFnxJFWruwn5
	Zas7trs7Cr48Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
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


