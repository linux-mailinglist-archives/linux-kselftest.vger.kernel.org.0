Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2141C6AB10B
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Mar 2023 15:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCEObw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Mar 2023 09:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjCEObu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Mar 2023 09:31:50 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2801117E;
        Sun,  5 Mar 2023 06:31:37 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PV4042pC9z4f3jMK;
        Sun,  5 Mar 2023 22:31:32 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgBnF6vApwRkTwIvEw--.13658S4;
        Sun, 05 Mar 2023 22:31:34 +0800 (CST)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: check if verifier tracks dst_reg bound for BPF_MOD
Date:   Sun,  5 Mar 2023 22:31:19 -0500
Message-Id: <20230306033119.2634976-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230306033119.2634976-1-xukuohai@huaweicloud.com>
References: <20230306033119.2634976-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnF6vApwRkTwIvEw--.13658S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtr48uw1UGr4xtF48XF43Wrg_yoWxuF1xp3
        4Fq3WDJr48Jw4YvaykKFyI93W3Kr4kJrsrC3s29r17Zay3J3WfW3WUta15CwnxJr1rJrsY
        qr15Cw1kJayjvrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r4Y6ry7M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxV
        A2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
        W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
        U8HKZJUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

Test cases to check if verifier tracks dst_reg bound for BPF_MOD.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/testing/selftests/bpf/verifier/mod.c | 247 +++++++++++++++++++++
 1 file changed, 247 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/mod.c

diff --git a/tools/testing/selftests/bpf/verifier/mod.c b/tools/testing/selftests/bpf/verifier/mod.c
new file mode 100644
index 000000000000..717e4cd08e59
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/mod.c
@@ -0,0 +1,247 @@
+{
+	"mod64 positive imm",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ALU64_IMM(BPF_MOD, BPF_REG_0, 1),
+
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
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
+	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_0, -2),
+
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.retval = 1,
+},
+{
+	"mod64 variable dividend cross signed boundary",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
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
+	BPF_JMP_REG(BPF_JLT, BPF_REG_1, BPF_REG_0, -2),
+
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.retval = 1,
+},
+{
+	"mod32 variable dividend cross signed boundary",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
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

