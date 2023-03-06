Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393C86AB107
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Mar 2023 15:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjCEObq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Mar 2023 09:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCEObo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Mar 2023 09:31:44 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F0A10A95;
        Sun,  5 Mar 2023 06:31:36 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PV40243qhz4f3kpB;
        Sun,  5 Mar 2023 22:31:30 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgBnF6vApwRkTwIvEw--.13658S3;
        Sun, 05 Mar 2023 22:31:32 +0800 (CST)
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
Subject: [PATCH bpf-next 1/2] bpf: add bound tracking for BPF_MOD
Date:   Sun,  5 Mar 2023 22:31:18 -0500
Message-Id: <20230306033119.2634976-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230306033119.2634976-1-xukuohai@huaweicloud.com>
References: <20230306033119.2634976-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnF6vApwRkTwIvEw--.13658S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WFy8tFWDZFy8Gr4kGFWrGrg_yoW7XFWrpF
        ZxWrZxXr4DA3y7Awn2qw4DArZ5WF18J3Wruryqk34xJry7JFyYy3WDKF12ya4ayrZ2yr4f
        tF1UW39rWa1Uta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r4Y6ry7M2
        8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxV
        A2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
        W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
        IdgAUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

dst_reg is marked as unknown when BPF_MOD instruction is verified, causing
the following bpf prog to be incorrectly rejected.

0: r0 = 0
1: r0 %= 10   // r0 is marked as unknown
2: r1 = 0
3: r1 += 1
4: if r1 < r0 goto pc-2 // verifier concludes the loop is unbounded
5: exit

To teach verifier to accept the above prog, this patch adds bound tracking
for BPF_MOD, based on the following observation.

BPF_MOD is unsigned and for a given unsigned divisor x:
1. when x != 0, dst_reg bits are in the range [0, x);
2. when x == 0, dst_reg is truncated to 32 bits by mod32 or remains
   unchanged by mod64.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/verifier.c | 98 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 93 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 272563a0b770..d44a33a53e8e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11257,6 +11257,87 @@ static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
 	__update_reg_bounds(dst_reg);
 }
 
+static void scalar32_min_max_mod(struct bpf_reg_state *dst_reg,
+				 struct bpf_reg_state *src_reg)
+{
+	u32 val = (u32)src_reg->var_off.value; /* src_reg is const */
+	u32 umax = dst_reg->u32_max_value;
+	u32 umin = dst_reg->u32_min_value;
+	u32 umax_rem, umin_rem;
+
+	/* dst_reg is 32-bit truncated when mod32 zero, since
+	 * adjust_scalar_min_max_vals calls zext_32_to_64 to do truncation for
+	 * all alu32 ops, here we do nothing and just return.
+	 */
+	if (!val)
+		return;
+
+	umax_rem = do_div(umax, val);
+	umin_rem = do_div(umin, val);
+
+	/* no winding */
+	if (umax - umin < val && umin_rem <= umax_rem) {
+		dst_reg->var_off = tnum_range(umin_rem, umax_rem);
+		dst_reg->u32_min_value = umin_rem;
+		dst_reg->u32_max_value = umax_rem;
+	} else {
+		dst_reg->var_off = tnum_range(0, val - 1);
+		dst_reg->u32_min_value = 0;
+		dst_reg->u32_max_value = val - 1;
+	}
+
+	/* cross the sign boundary */
+	if ((s32)dst_reg->u32_min_value > (s32)dst_reg->u32_max_value) {
+		dst_reg->s32_min_value = S32_MIN;
+		dst_reg->s32_max_value = S32_MAX;
+	} else {
+		dst_reg->s32_min_value = (s32)dst_reg->u32_min_value;
+		dst_reg->s32_max_value = (s32)dst_reg->u32_max_value;
+	}
+
+	/* mark reg64 unbounded to deduce 64-bit bounds from var_off */
+	__mark_reg64_unbounded(dst_reg);
+}
+
+static void scalar_min_max_mod(struct bpf_reg_state *dst_reg,
+			       struct bpf_reg_state *src_reg)
+{
+	u64 val = src_reg->var_off.value; /* src_reg is const */
+	u64 umax = dst_reg->umax_value;
+	u64 umin = dst_reg->umin_value;
+	u64 umax_rem, umin_rem;
+
+	/* dst_reg is untouched when mod64 zero */
+	if (!val)
+		return;
+
+	div64_u64_rem(umin, val, &umin_rem);
+	div64_u64_rem(umax, val, &umax_rem);
+
+	/* no winding */
+	if (umax - umin < val && umin_rem <= umax_rem) {
+		dst_reg->var_off = tnum_range(umin_rem, umax_rem);
+		dst_reg->umin_value = umin_rem;
+		dst_reg->umax_value = umax_rem;
+	} else {
+		dst_reg->var_off = tnum_range(0, val - 1);
+		dst_reg->umin_value = 0;
+		dst_reg->umax_value = val - 1;
+	}
+
+	/* cross the sign boundary */
+	if ((s64)dst_reg->umin_value > (s64)dst_reg->umax_value) {
+		dst_reg->smin_value = S64_MIN;
+		dst_reg->smax_value = S64_MAX;
+	} else {
+		dst_reg->smin_value = (s64)dst_reg->umin_value;
+		dst_reg->smax_value = (s64)dst_reg->umax_value;
+	}
+
+	/* mark reg32 unbounded to deduce 32-bit bounds from var_off */
+	__mark_reg32_unbounded(dst_reg);
+}
+
 /* WARNING: This function does calculations on 64-bit values, but the actual
  * execution may occur on 32-bit values. Therefore, things like bitshifts
  * need extra checks in the 32-bit case.
@@ -11331,11 +11412,12 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	 * and BPF_OR. This is possible because these ops have fairly easy to
 	 * understand and calculate behavior in both 32-bit and 64-bit alu ops.
 	 * See alu32 verifier tests for examples. The second class of
-	 * operations, BPF_LSH, BPF_RSH, and BPF_ARSH, however are not so easy
-	 * with regards to tracking sign/unsigned bounds because the bits may
-	 * cross subreg boundaries in the alu64 case. When this happens we mark
-	 * the reg unbounded in the subreg bound space and use the resulting
-	 * tnum to calculate an approximation of the sign/unsigned bounds.
+	 * operations, BPF_LSH, BPF_RSH, BPF_ARSH and BPF_MOD, however are not
+	 * so easy with regards to tracking sign/unsigned bounds because the
+	 * bits may cross subreg boundaries in the alu64 case. When this happens
+	 * we mark the reg unbounded in the subreg bound space and use the
+	 * resulting tnum to calculate an approximation of the sign/unsigned
+	 * bounds.
 	 */
 	switch (opcode) {
 	case BPF_ADD:
@@ -11407,6 +11489,12 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		else
 			scalar_min_max_arsh(dst_reg, &src_reg);
 		break;
+	case BPF_MOD:
+		if (alu32)
+			scalar32_min_max_mod(dst_reg, &src_reg);
+		else
+			scalar_min_max_mod(dst_reg, &src_reg);
+		break;
 	default:
 		mark_reg_unknown(env, regs, insn->dst_reg);
 		break;
-- 
2.30.2

