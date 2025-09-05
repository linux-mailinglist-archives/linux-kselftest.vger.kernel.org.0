Return-Path: <linux-kselftest+bounces-40846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 230D9B45C30
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3CC1C20BAB
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3AB31B837;
	Fri,  5 Sep 2025 15:13:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580F31B809;
	Fri,  5 Sep 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085206; cv=none; b=Rkci3H11Bs037lhT5Z8MwlT/YneLqTtWNusYATovlL6RpE3sk/JAuG+QX/0IjdBC7/R16hzoomcgvq0tcduuuTw/XdHD3A2Apfi6Ts/XlWZi/WWBqr7eX/CqAbufqXomIbhh+h5zEHybE1PPgoAdJCNB4uciQV71HAaBAxI7kY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085206; c=relaxed/simple;
	bh=735ErX0nXQAIiqsum52DgprUGZicLHAW4DORG/hNMwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYrP3prXtusJiJqUt6oH4tiknxGsB9bw0As5RwK9mhq8o2Fq45zqE2WANiRHrZ26G6MkNl4TuFnV4tfp+cw3wXVqCrIXVQlQI4dKgyaRFepLoW0Jnx64gcRwoWNTlS4m8zx4j4s6aP2UeFmENx+hATYH9xwC1RTB3WnvydFvNvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cJKbw58TzzYQvLp;
	Fri,  5 Sep 2025 23:13:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 334CD1A0F15;
	Fri,  5 Sep 2025 23:13:15 +0800 (CST)
Received: from k-arm6401.huawei.com (unknown [7.217.19.243])
	by APP4 (Coremail) with SMTP id gCh0CgDnfYoF_rpoPC72BQ--.54678S4;
	Fri, 05 Sep 2025 23:13:14 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yhs@fb.com>,
	Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Tao Chen <chen.dylane@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Add test for overwrite ring buffer
Date: Fri,  5 Sep 2025 23:06:40 +0800
Message-ID: <20250905150641.2078838-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905150641.2078838-1-xukuohai@huaweicloud.com>
References: <20250905150641.2078838-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnfYoF_rpoPC72BQ--.54678S4
X-Coremail-Antispam: 1UD129KBjvJXoW3AFykGFyrGr4ktF15GF4DJwb_yoW3GrWxpa
	yFgr1YkryI93WFgrWxuFyIvFW8ur4DAw4rKrsrXw1rZr1DuFsxXr1Ikr1Ut3Z8XrW8Xr1Y
	k34Y9FZ3A3WUGF7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5MxkIecxEwVCI4VW5WwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUhNB_UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add test for overwiret mode ring buffer. The test creates a bpf ring
buffer in overwrite mode, then repeatlly reserves and commits data
to check if the ring buffer works as expected both before and after
overwrite happens.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/testing/selftests/bpf/Makefile          |  3 +-
 .../selftests/bpf/prog_tests/ringbuf.c        | 74 ++++++++++++++
 .../bpf/progs/test_ringbuf_overwrite.c        | 98 +++++++++++++++++++
 3 files changed, 174 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_overwrite.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 11d2a368db3e..e6c18e201555 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -499,7 +499,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
 	trace_printk.c trace_vprintk.c map_ptr_kern.c 			\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
-	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c
+	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
+	test_ringbuf_overwrite.c
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index d1e4cb28a72c..205a51c725a7 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -17,6 +17,7 @@
 #include "test_ringbuf_n.lskel.h"
 #include "test_ringbuf_map_key.lskel.h"
 #include "test_ringbuf_write.lskel.h"
+#include "test_ringbuf_overwrite.lskel.h"
 
 #define EDONE 7777
 
@@ -497,6 +498,77 @@ static void ringbuf_map_key_subtest(void)
 	test_ringbuf_map_key_lskel__destroy(skel_map_key);
 }
 
+static void ringbuf_overwrite_mode_subtest(void)
+{
+	unsigned long size, len1, len2, len3, len4, len5;
+	unsigned long expect_avail_data, expect_prod_pos, expect_over_pos;
+	struct test_ringbuf_overwrite_lskel *skel;
+	int err;
+
+	skel = test_ringbuf_overwrite_lskel__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	size = 0x1000;
+	len1 = 0x800;
+	len2 = 0x400;
+	len3 = size - len1 - len2 - BPF_RINGBUF_HDR_SZ * 3; /* 0x3e8 */
+	len4 = len3 - 8; /* 0x3e0 */
+	len5 = len3; /* retry with len3 */
+
+	skel->maps.ringbuf.max_entries = size;
+	skel->rodata->LEN1 = len1;
+	skel->rodata->LEN2 = len2;
+	skel->rodata->LEN3 = len3;
+	skel->rodata->LEN4 = len4;
+	skel->rodata->LEN5 = len5;
+
+	skel->bss->pid = getpid();
+
+	err = test_ringbuf_overwrite_lskel__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	err = test_ringbuf_overwrite_lskel__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	syscall(__NR_getpgid);
+
+	ASSERT_EQ(skel->bss->reserve1_fail, 0, "reserve 1");
+	ASSERT_EQ(skel->bss->reserve2_fail, 0, "reserve 2");
+	ASSERT_EQ(skel->bss->reserve3_fail, 1, "reserve 3");
+	ASSERT_EQ(skel->bss->reserve4_fail, 0, "reserve 4");
+	ASSERT_EQ(skel->bss->reserve5_fail, 0, "reserve 5");
+
+	CHECK(skel->bss->ring_size != size,
+	      "check_ring_size", "exp %lu, got %lu\n",
+	      size, skel->bss->ring_size);
+
+	expect_avail_data = len2 + len4 + len5 + 3 * BPF_RINGBUF_HDR_SZ;
+	CHECK(skel->bss->avail_data != expect_avail_data,
+	      "check_avail_size", "exp %lu, got %lu\n",
+	      expect_avail_data, skel->bss->avail_data);
+
+	CHECK(skel->bss->cons_pos != 0,
+	      "check_cons_pos", "exp 0, got %lu\n",
+	      skel->bss->cons_pos);
+
+	expect_prod_pos = len1 + len2 + len4 + len5 + 4 * BPF_RINGBUF_HDR_SZ;
+	CHECK(skel->bss->prod_pos != expect_prod_pos,
+	      "check_prod_pos", "exp %lu, got %lu\n",
+	      expect_prod_pos, skel->bss->prod_pos);
+
+	expect_over_pos = len1 + BPF_RINGBUF_HDR_SZ;
+	CHECK(skel->bss->over_pos != expect_over_pos,
+	      "check_over_pos", "exp %lu, got %lu\n",
+	      (unsigned long)expect_over_pos, skel->bss->over_pos);
+
+	test_ringbuf_overwrite_lskel__detach(skel);
+cleanup:
+	test_ringbuf_overwrite_lskel__destroy(skel);
+}
+
 void test_ringbuf(void)
 {
 	if (test__start_subtest("ringbuf"))
@@ -507,4 +579,6 @@ void test_ringbuf(void)
 		ringbuf_map_key_subtest();
 	if (test__start_subtest("ringbuf_write"))
 		ringbuf_write_subtest();
+	if (test__start_subtest("ringbuf_overwrite_mode"))
+		ringbuf_overwrite_mode_subtest();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_overwrite.c b/tools/testing/selftests/bpf/progs/test_ringbuf_overwrite.c
new file mode 100644
index 000000000000..da89ba12a75c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_overwrite.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(map_flags, BPF_F_OVERWRITE);
+} ringbuf SEC(".maps");
+
+int pid;
+
+const volatile unsigned long LEN1;
+const volatile unsigned long LEN2;
+const volatile unsigned long LEN3;
+const volatile unsigned long LEN4;
+const volatile unsigned long LEN5;
+
+long reserve1_fail = 0;
+long reserve2_fail = 0;
+long reserve3_fail = 0;
+long reserve4_fail = 0;
+long reserve5_fail = 0;
+
+unsigned long avail_data = 0;
+unsigned long ring_size = 0;
+unsigned long cons_pos = 0;
+unsigned long prod_pos = 0;
+unsigned long over_pos = 0;
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int test_overwrite_ringbuf(void *ctx)
+{
+	char *rec1, *rec2, *rec3, *rec4, *rec5;
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (cur_pid != pid)
+		return 0;
+
+	rec1 = bpf_ringbuf_reserve(&ringbuf, LEN1, 0);
+	if (!rec1) {
+		reserve1_fail = 1;
+		return 0;
+	}
+
+	rec2 = bpf_ringbuf_reserve(&ringbuf, LEN2, 0);
+	if (!rec2) {
+		bpf_ringbuf_discard(rec1, 0);
+		reserve2_fail = 1;
+		return 0;
+	}
+
+	rec3 = bpf_ringbuf_reserve(&ringbuf, LEN3, 0);
+	/* expect failure */
+	if (!rec3) {
+		reserve3_fail = 1;
+	} else {
+		bpf_ringbuf_discard(rec1, 0);
+		bpf_ringbuf_discard(rec2, 0);
+		bpf_ringbuf_discard(rec3, 0);
+		return 0;
+	}
+
+	rec4 = bpf_ringbuf_reserve(&ringbuf, LEN4, 0);
+	if (!rec4) {
+		reserve4_fail = 1;
+		bpf_ringbuf_discard(rec1, 0);
+		bpf_ringbuf_discard(rec2, 0);
+		return 0;
+	}
+
+	bpf_ringbuf_submit(rec1, 0);
+	bpf_ringbuf_submit(rec2, 0);
+	bpf_ringbuf_submit(rec4, 0);
+
+	rec5 = bpf_ringbuf_reserve(&ringbuf, LEN5, 0);
+	if (!rec5) {
+		reserve5_fail = 1;
+		return 0;
+	}
+
+	for (int i = 0; i < LEN3; i++)
+		rec5[i] = 0xdd;
+
+	bpf_ringbuf_submit(rec5, 0);
+
+	ring_size = bpf_ringbuf_query(&ringbuf, BPF_RB_RING_SIZE);
+	avail_data = bpf_ringbuf_query(&ringbuf, BPF_RB_AVAIL_DATA);
+	cons_pos = bpf_ringbuf_query(&ringbuf, BPF_RB_CONS_POS);
+	prod_pos = bpf_ringbuf_query(&ringbuf, BPF_RB_PROD_POS);
+	over_pos = bpf_ringbuf_query(&ringbuf, BPF_RB_OVER_POS);
+
+	return 0;
+}
-- 
2.43.0


