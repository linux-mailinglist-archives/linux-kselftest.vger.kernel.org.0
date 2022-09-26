Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E4E5EAD35
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Sep 2022 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIZQw2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Sep 2022 12:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiIZQv7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Sep 2022 12:51:59 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06481E732;
        Mon, 26 Sep 2022 08:45:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mbn4T5Dhvz9xqcC;
        Mon, 26 Sep 2022 23:39:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwB3pF7lyDFjZ4d6AA--.42219S5;
        Mon, 26 Sep 2022 16:45:14 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org, oss@lmb.io
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, fengc@google.com, davem@davemloft.net
Subject: [RFC][PATCH 3/3] selftests/bpf: Test enforcement of map fd permissions at verifier level
Date:   Mon, 26 Sep 2022 17:44:30 +0200
Message-Id: <20220926154430.1552800-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926154430.1552800-1-roberto.sassu@huaweicloud.com>
References: <20220926154430.1552800-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwB3pF7lyDFjZ4d6AA--.42219S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw17Ar47WFW3XF1rAr4fZrb_yoWfAFWkpa
        4rXF1DGFW8Xr4YvayvgFy7ZF13KF4DXwsxAr92gr17ArsxX3Z3W3W8Ka13tr13JryrWFs3
        uF4Ykr97Cay2yFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
        AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
        07jzE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj4N4HAAAsU
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Create two maps, one read/writable and another only readable. Also, define
four programs, that respectively read, read/write, read/write (with two map
fds), and write to a given map.

For the read/writable map, two additional fds are obtained to test the
ability of the verifier to restrict operations by a program depending on
the map permissions granted.

To make testing easier, the map fd for the BPF_LD_MAP_FD instruction is
always the same (20), and dup2() is used to make sure that the program
takes the correct map at the time it is loaded.

In addition, a second fd (21) set with dup2() is passed to one eBPF program
to check the merging of fd modes (read-only and write-only).

The tests first verify the correct behavior, i.e. a program is successfully
executed if it has sufficient permissions on the map. Then, they verify the
incorrect combinations (e.g. a program willing to perform read/write
operations on a map referenced with a write-only fd), and ensure that the
verifier emits the expected error message.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../selftests/bpf/prog_tests/map_fd_perm.c    | 227 ++++++++++++++++++
 1 file changed, 227 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_fd_perm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_fd_perm.c b/tools/testing/selftests/bpf/prog_tests/map_fd_perm.c
new file mode 100644
index 000000000000..eaabf6f5bb9b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_fd_perm.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ */
+
+#include <test_progs.h>
+
+#define TARGET_MAP_FD 20
+#define TARGET_MAP_FD2 21
+#define EXPECTED_MAP_VALUE 2
+
+char bpf_log_buf[BPF_LOG_BUF_SIZE];
+
+struct bpf_insn prog_r[] = {
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp - 4) = r0 */
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
+	BPF_LD_MAP_FD(BPF_REG_1, TARGET_MAP_FD),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0), /* r0 = 0 */
+	BPF_EXIT_INSN(),
+};
+
+struct bpf_insn prog_rw[] = {
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp - 4) = r0 */
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
+	BPF_LD_MAP_FD(BPF_REG_1, TARGET_MAP_FD),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_MOV64_IMM(BPF_REG_1, EXPECTED_MAP_VALUE),
+	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0), /* r0 = 0 */
+	BPF_EXIT_INSN(),
+};
+
+struct bpf_insn prog_rw_merge[] = {
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp - 4) = r0 */
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
+	BPF_LD_MAP_FD(BPF_REG_1, TARGET_MAP_FD),
+	BPF_LD_MAP_FD(BPF_REG_1, TARGET_MAP_FD2),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+	BPF_MOV64_IMM(BPF_REG_1, EXPECTED_MAP_VALUE),
+	BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0), /* r0 = 0 */
+	BPF_EXIT_INSN(),
+};
+
+struct bpf_insn prog_w[] = {
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp - 4) = r0 */
+	BPF_MOV64_IMM(BPF_REG_0, EXPECTED_MAP_VALUE),
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -8), /* *(u32 *)(fp - 8) = r0 */
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -8), /* r3 = fp - 8 */
+	BPF_LD_MAP_FD(BPF_REG_1, TARGET_MAP_FD),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_update_elem),
+	BPF_MOV64_IMM(BPF_REG_0, 0), /* r0 = 0 */
+	BPF_EXIT_INSN(),
+};
+
+static int load_prog(struct bpf_insn *prog, int num_insn, int map_fd,
+		     int map_fd2, int map_check_fd, int expected_map_value,
+		     const char *expected_err_msg)
+{
+	u32 key = 0, value;
+	int ret, prog_fd, link_fd;
+
+	LIBBPF_OPTS(bpf_prog_load_opts, trace_opts,
+		.expected_attach_type = BPF_TRACE_FENTRY,
+		.log_buf = bpf_log_buf,
+		.log_size = BPF_LOG_BUF_SIZE,
+	);
+
+	memset(bpf_log_buf, 0, sizeof(bpf_log_buf));
+
+	trace_opts.attach_btf_id =
+		libbpf_find_vmlinux_btf_id("array_map_lookup_elem",
+					   trace_opts.expected_attach_type);
+
+	ret = dup2(map_fd, TARGET_MAP_FD);
+	if (ret < 0)
+		return ret;
+
+	if (map_fd2 != -1) {
+		ret = dup2(map_fd2, TARGET_MAP_FD2);
+		if (ret < 0) {
+			close(TARGET_MAP_FD);
+			return ret;
+		}
+	}
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_TRACING, NULL, "GPL",
+				prog, num_insn, &trace_opts);
+
+	close(TARGET_MAP_FD);
+	if (map_fd2 != -1)
+		close(TARGET_MAP_FD2);
+
+	if (prog_fd < 0) {
+		if (expected_err_msg && strstr(bpf_log_buf, expected_err_msg))
+			return 0;
+
+		printf("%s\n", bpf_log_buf);
+		return -EINVAL;
+	}
+
+	if (map_check_fd >= 0) {
+		link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_FENTRY, NULL);
+		if (link_fd < 0) {
+			ret = -errno;
+			close(prog_fd);
+			return ret;
+		}
+
+		ret = bpf_map_lookup_elem(map_check_fd, &key, &value);
+
+		close(prog_fd);
+		close(link_fd);
+
+		if (ret < 0)
+			return ret;
+
+		if (value != expected_map_value)
+			return -EINVAL;
+	} else {
+		close(prog_fd);
+	}
+
+	return 0;
+}
+
+void test_map_fd_perm(void)
+{
+	int map_fd, map_fd_rdonly, map_fd_wronly;
+	int map_rdonly_fd;
+	struct bpf_map_info info_m = { 0 };
+	__u32 len = sizeof(info_m);
+	int ret;
+
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, fd_opts_rdonly,
+		.open_flags = BPF_F_RDONLY,
+	);
+
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, fd_opts_wronly,
+		.open_flags = BPF_F_WRONLY,
+	);
+
+	DECLARE_LIBBPF_OPTS(bpf_map_create_opts, create_opts,
+		.map_flags = BPF_F_RDONLY_PROG,
+	);
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(u32),
+				sizeof(u32), 1, NULL);
+	ASSERT_GE(map_fd, 0, "failed to create rw map");
+
+	map_rdonly_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(u32),
+				       sizeof(u32), 1, &create_opts);
+	ASSERT_GE(map_rdonly_fd, 0, "failed to create ro map");
+
+	ret = bpf_obj_get_info_by_fd(map_fd, &info_m, &len);
+	ASSERT_OK(ret, "bpf_obj_get_info_by_fd");
+
+	map_fd_rdonly = bpf_map_get_fd_by_id_opts(info_m.id, &fd_opts_rdonly);
+	ASSERT_GE(map_fd_rdonly, 0, "bpf_map_get_fd_by_id_opts rw map ro fd");
+
+	map_fd_wronly = bpf_map_get_fd_by_id_opts(info_m.id, &fd_opts_wronly);
+	ASSERT_GE(map_fd_wronly, 0, "bpf_map_get_fd_by_id_opts rw map wo fd");
+
+	ret = load_prog(prog_r, ARRAY_SIZE(prog_r), map_fd_rdonly, -1, -1, -1,
+			NULL);
+	ASSERT_OK(ret, "load ro prog, rw map, ro fd");
+
+	ret = load_prog(prog_rw, ARRAY_SIZE(prog_rw), map_fd, -1, map_fd,
+			EXPECTED_MAP_VALUE, NULL);
+	ASSERT_OK(ret, "load rw prog, rw map, rw fd");
+
+	ret = load_prog(prog_w, ARRAY_SIZE(prog_w), map_fd_wronly, -1, map_fd,
+			EXPECTED_MAP_VALUE, NULL);
+	ASSERT_OK(ret, "load wo prog, rw map, wo fd");
+
+	ret = load_prog(prog_r, ARRAY_SIZE(prog_r), map_rdonly_fd, -1, -1, -1,
+			NULL);
+	ASSERT_OK(ret, "load ro prog, ro map, ro fd");
+
+	/* Existing value was set by prog_w, so it is EXPECTED_MAP_VALUE * 2. */
+	ret = load_prog(prog_rw_merge, ARRAY_SIZE(prog_rw_merge), map_fd_rdonly,
+			map_fd_wronly, map_fd, EXPECTED_MAP_VALUE * 2, NULL);
+	ASSERT_OK(ret, "load rw prog merge, ro fd, wo fd");
+
+	ret = load_prog(prog_r, ARRAY_SIZE(prog_r), map_fd_wronly, -1, -1, -1,
+			"read from map forbidden");
+	ASSERT_OK(ret, "load ro prog, rw map, wo fd");
+
+	ret = load_prog(prog_w, ARRAY_SIZE(prog_w), map_fd_rdonly, -1, -1, -1,
+			"write into map forbidden");
+	ASSERT_OK(ret, "load wo prog, rw map, ro fd");
+
+	ret = load_prog(prog_rw, ARRAY_SIZE(prog_rw), map_fd_rdonly, -1, -1, -1,
+			"write into map forbidden");
+	ASSERT_OK(ret, "load rw prog, rw map, ro fd");
+
+	ret = load_prog(prog_rw, ARRAY_SIZE(prog_rw), map_fd_wronly, -1, -1, -1,
+			"read from map forbidden");
+	ASSERT_OK(ret, "load rw prog, rw map, wo fd");
+
+	ret = load_prog(prog_w, ARRAY_SIZE(prog_w), map_rdonly_fd, -1, -1, -1,
+			"write into map forbidden");
+	ASSERT_OK(ret, "load wo prog, ro map, rw fd");
+}
-- 
2.25.1

