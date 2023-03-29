Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5AB6CBEBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 14:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjC1MLq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 08:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjC1MLp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 08:11:45 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDCB7EFD;
        Tue, 28 Mar 2023 05:11:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pm7p346xvz4f3mWd;
        Tue, 28 Mar 2023 20:11:39 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP1 (Coremail) with SMTP id cCh0CgAHcix72SJkruJiFw--.58388S2;
        Tue, 28 Mar 2023 20:11:40 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2] selftests/bpf: Rewrite two infinite loops in bound check cases
Date:   Tue, 28 Mar 2023 21:10:48 -0400
Message-Id: <20230329011048.1721937-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAHcix72SJkruJiFw--.58388S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4rZw13tF1xtr18ZrWUurg_yoW5CF1xp3
        4rX3WDGrW8Jw45Za4kKFy2qr13Kr4kAwsrC3s2gr17ArW7J3W3W34Utw45AwnxJr1rJrZI
        vr1UC3s7tayUuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r4Y6ry7M2
        8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
        tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
        80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUx89NDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.5 required=5.0 tests=DATE_IN_FUTURE_12_24,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

The two infinite loops in bound check cases added by commit
1a3148fc171f ("selftests/bpf: Check when bounds are not in the 32-bit range")
increased the execution time of test_verifier from about 6 seconds to
about 9 seconds. Rewrite these two infinite loops to finite loops to get
rid of this extra time cost.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
v2:
 - rewrite the infinite loops to finite loops instead of removing the
   test cases

v1: https://lore.kernel.org/bpf/20230327153538.850440-1-xukuohai@huaweicloud.com/
---
 tools/testing/selftests/bpf/verifier/bounds.c | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testing/selftests/bpf/verifier/bounds.c
index 74b1917d4208..43942ce8cf15 100644
--- a/tools/testing/selftests/bpf/verifier/bounds.c
+++ b/tools/testing/selftests/bpf/verifier/bounds.c
@@ -784,22 +784,26 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 8),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 13),
 
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
 	BPF_LD_IMM64(BPF_REG_0, 0x7fffffffffffff10),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
 
+	BPF_LD_IMM64(BPF_REG_2, 0x8000000000000fff),
 	BPF_LD_IMM64(BPF_REG_0, 0x8000000000000000),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+	BPF_JMP_REG(BPF_JSGT, BPF_REG_0, BPF_REG_2, 3),
 	/* r1 signed range is [S64_MIN, S64_MAX] */
-	BPF_JMP_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
+	BPF_JMP_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -3),
+
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
 
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "BPF program is too large",
-	.result = REJECT,
+	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_XDP,
 },
 {
@@ -856,21 +860,25 @@
 	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 6),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 10),
 
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
 	BPF_MOV32_IMM(BPF_REG_0, 0x7fffff10),
 	BPF_ALU32_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
 
+	BPF_MOV32_IMM(BPF_REG_2, 0x80000fff),
 	BPF_MOV32_IMM(BPF_REG_0, 0x80000000),
 	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
+	BPF_JMP32_REG(BPF_JSGT, BPF_REG_0, BPF_REG_2, 3),
 	/* r1 signed range is [S32_MIN, S32_MAX] */
-	BPF_JMP32_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
+	BPF_JMP32_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -3),
+
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
 
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "BPF program is too large",
-	.result = REJECT,
+	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_XDP,
 },
-- 
2.30.2

