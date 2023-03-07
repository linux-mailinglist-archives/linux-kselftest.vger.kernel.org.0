Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAE76AD9D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 10:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCGJFY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 04:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCGJFX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 04:05:23 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A5EFF37;
        Tue,  7 Mar 2023 01:05:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PW8fj20Mlz4f3l1s;
        Tue,  7 Mar 2023 17:05:17 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgDXia1L_gZkc5mfEw--.53857S4;
        Tue, 07 Mar 2023 17:05:19 +0800 (CST)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: check bounds not in the 32-bit range
Date:   Tue,  7 Mar 2023 17:04:49 -0500
Message-Id: <20230307220449.2933650-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230307220449.2933650-1-xukuohai@huaweicloud.com>
References: <20230307220449.2933650-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXia1L_gZkc5mfEw--.53857S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1UAF4UJr1UJF43uF4fuFg_yoW7Gr4fp3
        4rXF1DGr48Jw4YvaykKFWIv3W3KrWkAwsrCas29ry7ZrW3J3W3Wa4Uta15Cwnxtr1rJr4a
        qr15A3s7tayUZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r4Y6ry7M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxV
        A2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
        W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
        4nYwUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add cases to check if bound is updated correctly when 64-bit value is
not in the 32-bit range.

Signed-off-by: Xu Kuohai <xukuohai@huaweicloud.com>
---
 tools/testing/selftests/bpf/verifier/bounds.c | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testing/selftests/bpf/verifier/bounds.c
index 33125d5f6772..74b1917d4208 100644
--- a/tools/testing/selftests/bpf/verifier/bounds.c
+++ b/tools/testing/selftests/bpf/verifier/bounds.c
@@ -753,3 +753,124 @@
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
 },
+{
+	"bound check with JMP_JLT for crossing 64-bit signed boundary",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 8),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
+	BPF_LD_IMM64(BPF_REG_0, 0x7fffffffffffff10),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
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
+	"bound check with JMP_JSLT for crossing 64-bit signed boundary",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 8),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
+	BPF_LD_IMM64(BPF_REG_0, 0x7fffffffffffff10),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
+
+	BPF_LD_IMM64(BPF_REG_0, 0x8000000000000000),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	/* r1 signed range is [S64_MIN, S64_MAX] */
+	BPF_JMP_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
+
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.errstr = "BPF program is too large",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"bound check for loop upper bound greater than U32_MAX",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 8),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
+	BPF_LD_IMM64(BPF_REG_0, 0x100000000),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
+
+	BPF_LD_IMM64(BPF_REG_0, 0x100000000),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	BPF_JMP_REG(BPF_JLT, BPF_REG_0, BPF_REG_1, -2),
+
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"bound check with JMP32_JLT for crossing 32-bit signed boundary",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 6),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
+	BPF_MOV32_IMM(BPF_REG_0, 0x7fffff10),
+	BPF_ALU32_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
+
+	BPF_MOV32_IMM(BPF_REG_0, 0x80000000),
+	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
+	/* r1 unsigned range is [0, 0x8000000f] */
+	BPF_JMP32_REG(BPF_JLT, BPF_REG_0, BPF_REG_1, -2),
+
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
+{
+	"bound check with JMP32_JSLT for crossing 32-bit signed boundary",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 6),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
+	BPF_MOV32_IMM(BPF_REG_0, 0x7fffff10),
+	BPF_ALU32_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
+
+	BPF_MOV32_IMM(BPF_REG_0, 0x80000000),
+	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
+	/* r1 signed range is [S32_MIN, S32_MAX] */
+	BPF_JMP32_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
+
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.errstr = "BPF program is too large",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+},
-- 
2.30.2

