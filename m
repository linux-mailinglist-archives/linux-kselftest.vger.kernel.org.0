Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FFE6B8C02
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 08:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCNHf0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 03:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCNHfY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 03:35:24 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B348F7F01B;
        Tue, 14 Mar 2023 00:35:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PbQKf2HsQz4f3pG8;
        Tue, 14 Mar 2023 15:35:18 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgBnF6utIxBk_rhhFQ--.63403S4;
        Tue, 14 Mar 2023 15:35:19 +0800 (CST)
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: check bounds not in the 32-bit range
Date:   Tue, 14 Mar 2023 16:34:24 -0400
Message-Id: <20230314203424.4015351-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230314203424.4015351-1-xukuohai@huaweicloud.com>
References: <20230314203424.4015351-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnF6utIxBk_rhhFQ--.63403S4
X-Coremail-Antispam: 1UD129KBjvPXoW5XFyrGF1DAw4DAr1fKrW3p5X_Ar47ZoZ8Wr
        y7tr48Gr1kXas3Kw4fCasrZw4rKF1vyFsIkayUAFyrZrnrZrZxJwn7XF4qvw1UWr18Z34U
        XFn0kwnxJFykn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3AaLa
        J3UjIYCTnIWjp_UUUOn7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAv
        wI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VW8XVW5AwA204
        8vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2II
        xxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjc
        xK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
        F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F4
        0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_
        Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8c
        xan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
        0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Gg
        4DUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

Add cases to check if bound is updated correctly when 64-bit value is
not in the 32-bit range.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
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

