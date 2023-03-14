Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8FF6B8C01
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 08:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCNHfZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 03:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjCNHfX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 03:35:23 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5084B888A1;
        Tue, 14 Mar 2023 00:35:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PbQKd0T2pz4f3l8d;
        Tue, 14 Mar 2023 15:35:17 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgBnF6utIxBk_rhhFQ--.63403S3;
        Tue, 14 Mar 2023 15:35:18 +0800 (CST)
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
Subject: [PATCH bpf-next v2 1/2] bpf: Fix a umin > umax reg bound error
Date:   Tue, 14 Mar 2023 16:34:23 -0400
Message-Id: <20230314203424.4015351-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230314203424.4015351-1-xukuohai@huaweicloud.com>
References: <20230314203424.4015351-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnF6utIxBk_rhhFQ--.63403S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw15XF15tw4DGFyUXFy3XFb_yoWDXr1Dpr
        W3Gr1jgF4kWay8Zr4ktwsrXrZ5Ar18Ja4kCr9Ykry8tr13Wr9IyrnrKrWUtFyxAry0qa1x
        Jw1DZayq9w4UtFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r4Y6ry7M2
        8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxV
        A2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
        W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUCVW8JwCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
        s18BUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

After commit 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking"),
the following bpf prog is rejected:

0: (61) r2 = *(u32 *)(r1 +0)          ; R2_w=pkt(off=0,r=0,imm=0)
1: (61) r3 = *(u32 *)(r1 +4)          ; R3_w=pkt_end(off=0,imm=0)
2: (bf) r1 = r2
3: (07) r1 += 1
4: (2d) if r1 > r3 goto pc+8
5: (71) r1 = *(u8 *)(r2 +0)           ; R1_w=scalar(umax=255,var_off=(0x0; 0xff))
6: (18) r0 = 0x7fffffffffffff10
8: (0f) r1 += r0                      ; R1_w=scalar(umin=0x7fffffffffffff10,umax=0x800000000000000f)
9: (18) r0 = 0x8000000000000000
11: (07) r0 += 1
12: (ad) if r0 < r1 goto pc-2
13: (b7) r0 = 0
14: (95) exit

And the verifier log says:

[...]

from 12 to 11: R0_w=-9223372036854775794 R1=scalar(umin=9223372036854775823,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
11: (07) r0 += 1                      ; R0_w=-9223372036854775793
12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775793 R1=scalar(umin=9223372036854775823,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
13: safe

from 12 to 11: R0_w=-9223372036854775793 R1=scalar(umin=9223372036854775824,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
11: (07) r0 += 1                      ; R0_w=-9223372036854775792
12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775792 R1=scalar(umin=9223372036854775824,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
13: safe

[...]

What can be seen here is that r1->umin grows blindly and becomes bigger
than r1->umax. The reason is because the loop does not terminate, when
r0 increases to r1->umax_value, the following code in reg_set_min_max()
sets r1->umin_value to r1->umax_value + 1 blindly:

case BPF_JGT:
{
        if (is_jmp32) {
                [...]
        } else {
                u64 false_umax = opcode == BPF_JGT ? val    : val - 1;
                u64 true_umin = opcode == BPF_JGT ? val + 1 : val;

                false_reg->umax_value = min(false_reg->umax_value, false_umax);
                true_reg->umin_value = max(true_reg->umin_value, true_umin);
        }
        break;
}

Why the loop does not terminate is because tnum_is_const(src_reg->var_off)
always returns false, causing is_branch_taken() to be skipped:

if (src_reg->type == SCALAR_VALUE &&
	   !is_jmp32 && tnum_is_const(src_reg->var_off)) {
	pred = is_branch_taken(dst_reg,   // could not reach here
			       src_reg->var_off.value,
			       opcode,
			       is_jmp32);
}

Why tnum_is_const(src_reg->var_off) always returns false is because
r1->umin_value starts increasing from 0x7fffffffffffff10, always bigger
than U32_MAX, causing the __reg_combine_64_into_32() to mark the lower
32 bits unbounded, i.e. not a constant.

To fix it:
1. avoid increasing reg lower bound to a value bigger than the upper bound,
   or decreasing reg upper bound to a value smaller than the lower bound.
2. set 32-bit min/max values to the lower 32 bits of the 64-bit min/max values
   when the 64-bit min/max values are equal.

Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/verifier.c | 143 +++++++++++++++++++++++++++---------------
 1 file changed, 93 insertions(+), 50 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2bbd89279070..b775b50353d6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2223,14 +2223,21 @@ static bool __reg64_bound_u32(u64 a)
 
 static void __reg_combine_64_into_32(struct bpf_reg_state *reg)
 {
+	s64 smin = reg->smin_value;
+	s64 smax = reg->smax_value;
+	u64 umin = reg->umin_value;
+	u64 umax = reg->umax_value;
+
 	__mark_reg32_unbounded(reg);
-	if (__reg64_bound_s32(reg->smin_value) && __reg64_bound_s32(reg->smax_value)) {
-		reg->s32_min_value = (s32)reg->smin_value;
-		reg->s32_max_value = (s32)reg->smax_value;
+	if ((__reg64_bound_s32(smin) && __reg64_bound_s32(smax)) ||
+		smin == smax) {
+		reg->s32_min_value = (s32)smin;
+		reg->s32_max_value = (s32)smax;
 	}
-	if (__reg64_bound_u32(reg->umin_value) && __reg64_bound_u32(reg->umax_value)) {
-		reg->u32_min_value = (u32)reg->umin_value;
-		reg->u32_max_value = (u32)reg->umax_value;
+	if ((__reg64_bound_u32(umin) && __reg64_bound_u32(umax)) ||
+		umin == umax) {
+		reg->u32_min_value = (u32)umin;
+		reg->u32_max_value = (u32)umax;
 	}
 	reg_bounds_sync(reg);
 }
@@ -12828,6 +12835,62 @@ static int is_pkt_ptr_branch_taken(struct bpf_reg_state *dst_reg,
 	return -1;
 }
 
+static void reg_inc_u32_min(struct bpf_reg_state *reg, u32 val)
+{
+	reg->u32_min_value = max(reg->u32_min_value, val);
+	if (reg->u32_min_value > reg->u32_max_value)
+		reg->u32_min_value = reg->u32_max_value;
+}
+
+static void reg_dec_u32_max(struct bpf_reg_state *reg, u32 val)
+{
+	reg->u32_max_value = min(reg->u32_max_value, val);
+	if (reg->u32_max_value < reg->u32_min_value)
+		reg->u32_max_value = reg->u32_min_value;
+}
+
+static void reg_inc_s32_min(struct bpf_reg_state *reg, s32 val)
+{
+	reg->s32_min_value = max(reg->s32_min_value, val);
+	if (reg->s32_min_value > reg->s32_max_value)
+		reg->s32_min_value = reg->s32_max_value;
+}
+
+static void reg_dec_s32_max(struct bpf_reg_state *reg, s32 val)
+{
+	reg->s32_max_value = min(reg->s32_max_value, val);
+	if (reg->s32_max_value < reg->s32_min_value)
+		reg->s32_max_value = reg->s32_min_value;
+}
+
+static void reg_inc_u64_min(struct bpf_reg_state *reg, u64 val)
+{
+	reg->umin_value = max(reg->umin_value, val);
+	if (reg->umin_value > reg->umax_value)
+		reg->umin_value = reg->umax_value;
+}
+
+static void reg_dec_u64_max(struct bpf_reg_state *reg, u64 val)
+{
+	reg->umax_value = min(reg->umax_value, val);
+	if (reg->umax_value < reg->umin_value)
+		reg->umax_value = reg->umin_value;
+}
+
+static void reg_inc_s64_min(struct bpf_reg_state *reg, s64 val)
+{
+	reg->smin_value = max(reg->smin_value, val);
+	if (reg->smin_value > reg->smax_value)
+		reg->smin_value = reg->smax_value;
+}
+
+static void reg_dec_s64_max(struct bpf_reg_state *reg, s64 val)
+{
+	reg->smax_value = min(reg->smax_value, val);
+	if (reg->smax_value < reg->smin_value)
+		reg->smax_value = reg->smin_value;
+}
+
 /* Adjusts the register min/max values in the case that the dst_reg is the
  * variable register that we are working on, and src_reg is a constant or we're
  * simply doing a BPF_K check.
@@ -12898,76 +12961,56 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
 	case BPF_JGE:
 	case BPF_JGT:
 	{
-		if (is_jmp32) {
-			u32 false_umax = opcode == BPF_JGT ? val32  : val32 - 1;
-			u32 true_umin = opcode == BPF_JGT ? val32 + 1 : val32;
+		bool neq = (opcode == BPF_JGT);
 
-			false_reg->u32_max_value = min(false_reg->u32_max_value,
-						       false_umax);
-			true_reg->u32_min_value = max(true_reg->u32_min_value,
-						      true_umin);
+		if (is_jmp32) {
+			reg_dec_u32_max(false_reg, neq ? val32 : val32 - 1);
+			reg_inc_u32_min(true_reg, neq ? val32 + 1 : val32);
 		} else {
-			u64 false_umax = opcode == BPF_JGT ? val    : val - 1;
-			u64 true_umin = opcode == BPF_JGT ? val + 1 : val;
-
-			false_reg->umax_value = min(false_reg->umax_value, false_umax);
-			true_reg->umin_value = max(true_reg->umin_value, true_umin);
+			reg_dec_u64_max(false_reg, neq ? val : val - 1);
+			reg_inc_u64_min(true_reg, neq ? val + 1 : val);
 		}
 		break;
 	}
 	case BPF_JSGE:
 	case BPF_JSGT:
 	{
-		if (is_jmp32) {
-			s32 false_smax = opcode == BPF_JSGT ? sval32    : sval32 - 1;
-			s32 true_smin = opcode == BPF_JSGT ? sval32 + 1 : sval32;
+		bool neq = (opcode == BPF_JSGT);
 
-			false_reg->s32_max_value = min(false_reg->s32_max_value, false_smax);
-			true_reg->s32_min_value = max(true_reg->s32_min_value, true_smin);
+		if (is_jmp32) {
+			reg_dec_s32_max(false_reg, neq ? sval32 : sval32 - 1);
+			reg_inc_s32_min(true_reg, neq ? sval32 + 1 : sval32);
 		} else {
-			s64 false_smax = opcode == BPF_JSGT ? sval    : sval - 1;
-			s64 true_smin = opcode == BPF_JSGT ? sval + 1 : sval;
-
-			false_reg->smax_value = min(false_reg->smax_value, false_smax);
-			true_reg->smin_value = max(true_reg->smin_value, true_smin);
+			reg_dec_s64_max(false_reg, neq ? sval : sval - 1);
+			reg_inc_s64_min(true_reg, neq ? sval + 1 : sval);
 		}
 		break;
 	}
 	case BPF_JLE:
 	case BPF_JLT:
 	{
-		if (is_jmp32) {
-			u32 false_umin = opcode == BPF_JLT ? val32  : val32 + 1;
-			u32 true_umax = opcode == BPF_JLT ? val32 - 1 : val32;
+		bool neq = (opcode == BPF_JLT);
 
-			false_reg->u32_min_value = max(false_reg->u32_min_value,
-						       false_umin);
-			true_reg->u32_max_value = min(true_reg->u32_max_value,
-						      true_umax);
+		if (is_jmp32) {
+			reg_inc_u32_min(false_reg, neq ? val32 : val32 + 1);
+			reg_dec_u32_max(true_reg, neq ? val32 - 1 : val32);
 		} else {
-			u64 false_umin = opcode == BPF_JLT ? val    : val + 1;
-			u64 true_umax = opcode == BPF_JLT ? val - 1 : val;
-
-			false_reg->umin_value = max(false_reg->umin_value, false_umin);
-			true_reg->umax_value = min(true_reg->umax_value, true_umax);
+			reg_inc_u64_min(false_reg, neq ? val : val + 1);
+			reg_dec_u64_max(true_reg, neq ? val - 1 : val);
 		}
 		break;
 	}
 	case BPF_JSLE:
 	case BPF_JSLT:
 	{
-		if (is_jmp32) {
-			s32 false_smin = opcode == BPF_JSLT ? sval32    : sval32 + 1;
-			s32 true_smax = opcode == BPF_JSLT ? sval32 - 1 : sval32;
+		bool neq = (opcode == BPF_JSLT);
 
-			false_reg->s32_min_value = max(false_reg->s32_min_value, false_smin);
-			true_reg->s32_max_value = min(true_reg->s32_max_value, true_smax);
+		if (is_jmp32) {
+			reg_inc_s32_min(false_reg, neq ? sval32 : sval32 + 1);
+			reg_dec_s32_max(true_reg, neq ? sval32 - 1 : sval32);
 		} else {
-			s64 false_smin = opcode == BPF_JSLT ? sval    : sval + 1;
-			s64 true_smax = opcode == BPF_JSLT ? sval - 1 : sval;
-
-			false_reg->smin_value = max(false_reg->smin_value, false_smin);
-			true_reg->smax_value = min(true_reg->smax_value, true_smax);
+			reg_inc_s64_min(false_reg, neq ? sval : sval + 1);
+			reg_dec_s64_max(true_reg, neq ? sval - 1 : sval);
 		}
 		break;
 	}
-- 
2.30.2

