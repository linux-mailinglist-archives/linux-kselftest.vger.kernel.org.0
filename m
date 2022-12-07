Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D38A64601F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 18:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiLGRZp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 12:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLGRZh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 12:25:37 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD28C5AE36;
        Wed,  7 Dec 2022 09:25:36 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NS3sG3fLCz9xHw7;
        Thu,  8 Dec 2022 01:18:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD34m9YzJBjc9DJAA--.62662S4;
        Wed, 07 Dec 2022 18:25:13 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, mykolal@fb.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v2 2/7] bpf: Mark ALU32 operations in bpf_reg_state structure
Date:   Wed,  7 Dec 2022 18:24:29 +0100
Message-Id: <20221207172434.435893-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207172434.435893-1-roberto.sassu@huaweicloud.com>
References: <20221207172434.435893-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD34m9YzJBjc9DJAA--.62662S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1UAr1UKry7Wr1UAF48tFb_yoW5tFW5pF
        s5GrsxGr4kZF4xuasrZa15AF9YkF10v3WUuFWUA347Ar13Wry5Xr4DKFyjyas0yrW0vw4S
        y3Wq9rW2qw1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
        AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
        07j7hLnUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj4JqngACsQ
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

BPF LSM needs a reliable source of information to determine if the return
value given by eBPF programs is acceptable or not. At the moment, choosing
either the 64 bit or the 32 bit one does not seem to be an option
(selftests fail).

If we choose the 64 bit one, the following happens.

      14:	61 10 00 00 00 00 00 00	r0 = *(u32 *)(r1 + 0)
      15:	74 00 00 00 15 00 00 00	w0 >>= 21
      16:	54 00 00 00 01 00 00 00	w0 &= 1
      17:	04 00 00 00 ff ff ff ff	w0 += -1

This is the last part of test_deny_namespace. After #16, the register
values are:

smin_value = 0x0, smax_value = 0x1,
s32_min_value = 0x0, s32_max_value = 0x1,

After #17, they become:

smin_value = 0x0, smax_value = 0xffffffff,
s32_min_value = 0xffffffff, s32_max_value = 0x0

where only the 32 bit values are correct.

If we choose the 32 bit ones, the following happens.

0000000000000000 <check_access>:
       0:	79 12 00 00 00 00 00 00	r2 = *(u64 *)(r1 + 0)
       1:	79 10 08 00 00 00 00 00	r0 = *(u64 *)(r1 + 8)
       2:	67 00 00 00 3e 00 00 00	r0 <<= 62
       3:	c7 00 00 00 3f 00 00 00	r0 s>>= 63

This is part of test_libbpf_get_fd_by_id_opts (no_alu32 version). In this
case, 64 bit register values should be used (for the 32 bit ones, there is
no precise information from the verifier).

As the examples above suggest that which register values to use depends on
the specific case, mark ALU32 operations in bpf_reg_state structure, so
that BPF LSM can choose the proper ones.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 70d06a99f0b8..29c9cf6b0d01 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -181,6 +181,7 @@ struct bpf_reg_state {
 	enum bpf_reg_liveness live;
 	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
 	bool precise;
+	bool alu32;
 };
 
 enum bpf_stack_slot_type {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c5f0adbbde3..edce85c425a2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10524,9 +10524,13 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		break;
 	}
 
+	dst_reg->alu32 = false;
+
 	/* ALU32 ops are zero extended into 64bit register */
-	if (alu32)
+	if (alu32) {
 		zext_32_to_64(dst_reg);
+		dst_reg->alu32 = true;
+	}
 	reg_bounds_sync(dst_reg);
 	return 0;
 }
@@ -10700,6 +10704,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 				*dst_reg = *src_reg;
 				dst_reg->live |= REG_LIVE_WRITTEN;
 				dst_reg->subreg_def = DEF_NOT_SUBREG;
+				dst_reg->alu32 = false;
 			} else {
 				/* R1 = (u32) R2 */
 				if (is_pointer_value(env, insn->src_reg)) {
@@ -10716,6 +10721,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					dst_reg->id = 0;
 					dst_reg->live |= REG_LIVE_WRITTEN;
 					dst_reg->subreg_def = env->insn_idx + 1;
+					dst_reg->alu32 = true;
 				} else {
 					mark_reg_unknown(env, regs,
 							 insn->dst_reg);
@@ -10733,9 +10739,11 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			if (BPF_CLASS(insn->code) == BPF_ALU64) {
 				__mark_reg_known(regs + insn->dst_reg,
 						 insn->imm);
+				regs[insn->dst_reg].alu32 = false;
 			} else {
 				__mark_reg_known(regs + insn->dst_reg,
 						 (u32)insn->imm);
+				regs[insn->dst_reg].alu32 = true;
 			}
 		}
 
-- 
2.25.1

