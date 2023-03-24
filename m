Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4057B6C6CCB
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 16:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjCWP7j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 11:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjCWP7h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 11:59:37 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B928FF25;
        Thu, 23 Mar 2023 08:59:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Pj95G58g6z4f3mJJ;
        Thu, 23 Mar 2023 23:59:30 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgC3aq5fdxxktQW3Fw--.25283S4;
        Thu, 23 Mar 2023 23:59:32 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: check if verifier tracks dst_reg bound for BPF_MOD
Date:   Fri, 24 Mar 2023 00:58:42 -0400
Message-Id: <20230324045842.729719-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230324045842.729719-1-xukuohai@huaweicloud.com>
References: <20230324045842.729719-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3aq5fdxxktQW3Fw--.25283S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr48CFW3XrWDGryrAFyrZwb_yoWfCF18p3
        4rX3WDJr48Jw4YvaykKFyIv3W3Kr4kJrsrCas2gr17ZrW3J3W3W3WUta15CwnxJr1rJrsI
        qF15C3s7JayjvwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r4Y6ry7M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x0262
        8vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr
        3ktUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=4.7 required=5.0 tests=DATE_IN_FUTURE_12_24,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

Test cases to check if verifier tracks dst_reg bound for BPF_MOD.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/testing/selftests/bpf/verifier/mod.c | 320 +++++++++++++++++++++
 1 file changed, 320 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/mod.c

diff --git a/tools/testing/selftests/bpf/verifier/mod.c b/tools/testing/selftests/bpf/verifier/mod.c
new file mode 100644
index 000000000000..3aec856d5c9f
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/mod.c
@@ -0,0 +1,320 @@
+{
+	"mod64 positive imm",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ALU64_IMM(BPF_MOD, BPF_REG_0, 1),
+
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	/* r0 = 0 */
+	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_0, -2),
+
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"mod64 positive reg",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_MOV64_IMM(BPF_REG_1, 1),
+	BPF_ALU64_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
+
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	/* r0 = 0 */
+	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_0, -2),
+
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"mod64 zero",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
+
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	/* r0 = 0 */
+	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_0, -2),
+
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"mod64 negative 1",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_MOV64_IMM(BPF_REG_1, -1),
+	BPF_ALU64_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
+
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	/* r0 = 1 */
+	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_0, -2),
+
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.retval = 1,
+},
+{
+	"mod64 negative 2",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, -4),
+	BPF_MOV32_IMM(BPF_REG_1, 5),
+	BPF_ALU64_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
+
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	/* r0 = 2 */
+	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_0, -2),
+
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.retval = 2,
+},
+{
+	"mod64 negative 3",
+	.insns = {
+	BPF_MOV32_IMM(BPF_REG_0, -4),
+	BPF_MOV32_IMM(BPF_REG_1, -5),
+	BPF_ALU64_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
+
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	/* r0 = 1 */
+	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_0, -2),
+
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.retval = 1,
+},
+{
+	"mod64 variable dividend cross signed boundary, with JLT",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct xdp_md, data_end)),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 11),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
+	BPF_LD_IMM64(BPF_REG_0, 0x7fffffffffffff10),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
+	BPF_LD_IMM64(BPF_REG_0, 0x80000000000000ff),
+	BPF_ALU64_REG(BPF_MOD, BPF_REG_1, BPF_REG_0),
+
+	BPF_LD_IMM64(BPF_REG_0, 0x8000000000000000),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	/* r1 unsigned range is [0x7fffffffffffff10, 0x800000000000000f] */
+	BPF_JMP_REG(BPF_JLT, BPF_REG_0, BPF_REG_1, -2),
+
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"mod64 variable dividend cross signed boundary, with JSLT",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct xdp_md, data_end)),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 11),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
+	BPF_LD_IMM64(BPF_REG_0, 0x7fffffffffffff10),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
+	BPF_LD_IMM64(BPF_REG_0, 0x80000000000000ff),
+	BPF_ALU64_REG(BPF_MOD, BPF_REG_1, BPF_REG_0),
+
+	BPF_LD_IMM64(BPF_REG_0, 0x8000000000000000),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	/* r1 signed range is [S64_MIN, S64_MAX] */
+	BPF_JMP_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
+
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.errstr = "BPF program is too large.",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"mod32 positive imm",
+	.insns = {
+	BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_ALU32_IMM(BPF_MOD, BPF_REG_0, 1),
+
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	/* r0 = 0 */
+	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_0, -2),
+
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"mod32 positive reg",
+	.insns = {
+	BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_MOV32_IMM(BPF_REG_1, 1),
+	BPF_ALU32_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
+
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	/* r0 = 0 */
+	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_0, -2),
+
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"mod32 zero",
+	.insns = {
+	BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_MOV32_IMM(BPF_REG_1, 0),
+	BPF_ALU32_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
+
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	/* r0 = 0 */
+	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_0, -2),
+
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"mod32 negative 1",
+	.insns = {
+	BPF_MOV32_IMM(BPF_REG_0, 1),
+	BPF_MOV32_IMM(BPF_REG_1, -1),
+	BPF_ALU32_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
+
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	/* r0 = 1 */
+	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_0, -2),
+
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.retval = 1,
+},
+{
+	"mod32 negative 2",
+	.insns = {
+	BPF_MOV32_IMM(BPF_REG_0, -4),
+	BPF_MOV32_IMM(BPF_REG_1, 5),
+	BPF_ALU32_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
+
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	/* r0 = 2 */
+	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_0, -2),
+
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.retval = 2,
+},
+{
+	"mod32 negative 3",
+	.insns = {
+	BPF_MOV32_IMM(BPF_REG_0, -4),
+	BPF_MOV32_IMM(BPF_REG_1, -5),
+	BPF_ALU32_REG(BPF_MOD, BPF_REG_0, BPF_REG_1),
+
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	/* r0 = 1 */
+	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_0, -2),
+
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.retval = 1,
+},
+{
+	"mod32 variable dividend cross signed boundary, with JLT",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct xdp_md, data_end)),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 7),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0x7fffff10),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
+	BPF_ALU32_IMM(BPF_MOD, BPF_REG_1, 0x800000ff),
+
+	BPF_MOV32_IMM(BPF_REG_0, 0x80000000),
+	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
+	/* r1 unsigned 32-bit range is [0x7fffff10, 0x8000000f] */
+	BPF_JMP32_REG(BPF_JLT, BPF_REG_0, BPF_REG_1, -2),
+
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"mod32 variable dividend cross signed boundary, with JSLT",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct xdp_md, data_end)),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 7),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0x7fffff10),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
+	BPF_ALU32_IMM(BPF_MOD, BPF_REG_1, 0x800000ff),
+
+	BPF_MOV32_IMM(BPF_REG_0, 0x80000000),
+	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
+	/* r1 signed 32-bit range is [S32_MIN, S32_MAX] */
+	BPF_JMP32_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
+
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.errstr = "BPF program is too large.",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
-- 
2.30.2

