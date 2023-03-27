Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB326C999D
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 04:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjC0ChI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Mar 2023 22:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0ChH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Mar 2023 22:37:07 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9311140C0;
        Sun, 26 Mar 2023 19:37:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PlH5P09Hcz4f3nKC;
        Mon, 27 Mar 2023 10:36:57 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgB3J6tKASFkB_OSGA--.18301S2;
        Mon, 27 Mar 2023 10:36:58 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next] selftests/bpf: Remove two infinite loop bound check cases
Date:   Mon, 27 Mar 2023 11:35:38 -0400
Message-Id: <20230327153538.850440-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3J6tKASFkB_OSGA--.18301S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw48AFWkKrW7XrWxKFyDJrb_yoW5WFyrpa
        4fX3ZrJrWxJw4UAa4kKay2vrySgrWkZa17Aas7Kr1xAry7t3W3Wa4Uta15CwnxtryfGrsa
        vr1UAwn7tayUWw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r4Y6ry7M2
        8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
        tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z2
        80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcZXoUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=3.9 required=5.0 tests=DATE_IN_FUTURE_12_24,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

The two infinite loop bound check cases added by commit
1a3148fc171f ("selftests/bpf: Check when bounds are not in the 32-bit range")
take a long time to execute but don't add much value.

Remove them to reduce run time of test_verifier.

Fixes: 1a3148fc171f ("selftests/bpf: Check when bounds are not in the 32-bit range")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/testing/selftests/bpf/verifier/bounds.c | 50 -------------------
 1 file changed, 50 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testing/selftests/bpf/verifier/bounds.c
index 74b1917d4208..515a8222f08f 100644
--- a/tools/testing/selftests/bpf/verifier/bounds.c
+++ b/tools/testing/selftests/bpf/verifier/bounds.c
@@ -777,31 +777,6 @@
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_XDP,
 },
-{
-	"bound check with JMP_JSLT for crossing 64-bit signed boundary",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 8),
-
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
-	BPF_LD_IMM64(BPF_REG_0, 0x7fffffffffffff10),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-
-	BPF_LD_IMM64(BPF_REG_0, 0x8000000000000000),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	/* r1 signed range is [S64_MIN, S64_MAX] */
-	BPF_JMP_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
-
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "BPF program is too large",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
 {
 	"bound check for loop upper bound greater than U32_MAX",
 	.insns = {
@@ -849,28 +824,3 @@
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_XDP,
 },
-{
-	"bound check with JMP32_JSLT for crossing 32-bit signed boundary",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 6),
-
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
-	BPF_MOV32_IMM(BPF_REG_0, 0x7fffff10),
-	BPF_ALU32_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-
-	BPF_MOV32_IMM(BPF_REG_0, 0x80000000),
-	BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
-	/* r1 signed range is [S32_MIN, S32_MAX] */
-	BPF_JMP32_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
-
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "BPF program is too large",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-- 
2.30.2

