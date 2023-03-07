Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F6D6AD9D4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 10:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCGJFX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 04:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjCGJFV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 04:05:21 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE87432531;
        Tue,  7 Mar 2023 01:05:20 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PW8fh2HXYz4f3jJB;
        Tue,  7 Mar 2023 17:05:16 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgDXia1L_gZkc5mfEw--.53857S3;
        Tue, 07 Mar 2023 17:05:18 +0800 (CST)
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
Subject: [PATCH bpf-next 1/2] bpf: update 32-bit bounds when the lower 32-bit value is not wrapping
Date:   Tue,  7 Mar 2023 17:04:48 -0500
Message-Id: <20230307220449.2933650-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230307220449.2933650-1-xukuohai@huaweicloud.com>
References: <20230307220449.2933650-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXia1L_gZkc5mfEw--.53857S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW7CF45AF15WF1fKF4UJwb_yoWrXFyfpr
        W5GF4UCa1kX348C3yxtw15t34vyF10ya17uFWj9ryktrnIgw1qvw17Kry5KF9avFyxZa1I
        qwnrX3y7K3yUtw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
        s18BUUUUU
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

The following XDP prog is accepted by verifier.

0: (61) r2 = *(u32 *)(r1 +0)          ; R2_w=pkt(off=0,r=0,imm=0)
1: (61) r3 = *(u32 *)(r1 +4)          ; R3_w=pkt_end(off=0,imm=0)
2: (bf) r1 = r2
3: (07) r1 += 1
4: (2d) if r1 > r3 goto pc+6
5: (71) r1 = *(u8 *)(r2 +0)           ; R1_w=scalar(umax=255,var_off=(0x0; 0xff))
6: (b4) w0 = 0x7fffff10
7: (0c) w1 += w0                      ; R1_w=scalar(umin=0x7fffff10,umax=0x8000000f,var_off=(0x0; 0xffffffff))
8: (b4) w0 = 0x80000000
9: (04) w0 += 1
10: (ae) if w0 < w1 goto pc-2
11: (b7) r0 = 0
12: (95) exit

while the following 64-bit version is rejected.

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

The verifier log says:

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

The loop crosses termination condition r0 == r1.umax, and does not stop.

The reason is that when the verifier enumerates to r1.umin == r1.umax, the value
0x800000000000000f of r1.umin is greater than U32_MAX, so __reg_combine_64_into_32
sets the u32 range of r1 to [0, U32_MAX] instead of marking r1 as a constant,
making is_branch_taken() in check_cond_jmp_op() be skipped.

To fix it, update 32-bit bounds when the lower 32-bit value is not wrapping,
even if the 64-bit value is beyond the range of [0, U32_MAX] or [S32_MIN, S32_MAX].

Signed-off-by: Xu Kuohai <xukuohai@huaweicloud.com>
---
 kernel/bpf/verifier.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b2116ca78d9a..64c9ee3857ec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2013,26 +2013,21 @@ static void __reg_combine_32_into_64(struct bpf_reg_state *reg)
 	reg_bounds_sync(reg);
 }
 
-static bool __reg64_bound_s32(s64 a)
-{
-	return a >= S32_MIN && a <= S32_MAX;
-}
-
-static bool __reg64_bound_u32(u64 a)
-{
-	return a >= U32_MIN && a <= U32_MAX;
-}
-
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
+	if ((u64)(smax - smin) <= (u64)U32_MAX && (s32)smin <= (s32)smax) {
+		reg->s32_min_value = (s32)smin;
+		reg->s32_max_value = (s32)smax;
 	}
-	if (__reg64_bound_u32(reg->umin_value) && __reg64_bound_u32(reg->umax_value)) {
-		reg->u32_min_value = (u32)reg->umin_value;
-		reg->u32_max_value = (u32)reg->umax_value;
+	if (umax - umin <= U32_MAX && (u32)umin <= (u32)umax) {
+		reg->u32_min_value = (u32)umin;
+		reg->u32_max_value = (u32)umax;
 	}
 	reg_bounds_sync(reg);
 }
-- 
2.30.2

