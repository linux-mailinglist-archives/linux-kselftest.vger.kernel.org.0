Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE5D79E7F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 14:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbjIMMaJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 08:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240193AbjIMMaJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 08:30:09 -0400
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8F719AC;
        Wed, 13 Sep 2023 05:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1694608205; x=1726144205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:reply-to:mime-version:
   content-transfer-encoding;
  bh=KwurXCQbHNZPBAhNsuzjlPwfomO/Yw3Mf9C+fqRMat8=;
  b=p+05Sm3Z30+cAAvptk0/c/lGOLFH34mbCEyWJwW4TTI8DpzBsRZJa5ZX
   lm5KxYhvLdMAajrAY6Z3sQYp+DhBd6rTJwuR4hENDtKYbpIE6l7AKWF8n
   eL8olpgR5Y9j7M9MlZyyBVhXoqY7aay64scMxK7Z0nr9coabTRjA30qBP
   U=;
X-IronPort-AV: E=Sophos;i="6.02,143,1688428800"; 
   d="scan'208";a="671219876"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 12:29:56 +0000
Received: from EX19D017EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com (Postfix) with ESMTPS id 48BC047EC2;
        Wed, 13 Sep 2023 12:29:49 +0000 (UTC)
Received: from dev-dsk-gerhorst-1c-a6f23d20.eu-west-1.amazon.com
 (10.15.21.113) by EX19D017EUA004.ant.amazon.com (10.252.50.239) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 13 Sep
 2023 12:29:42 +0000
From:   Luis Gerhorst <gerhorst@amazon.de>
To:     <alexei.starovoitov@gmail.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <haoluo@google.com>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <kpsingh@kernel.org>, <laoar.shao@gmail.com>,
        <martin.lau@linux.dev>, <sdf@google.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <mykolal@fb.com>, <shuah@kernel.org>,
        <gerhorst@amazon.de>, <iii@linux.ibm.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luis Gerhorst <gerhorst@cs.fau.de>,
        Hagar Gamal Halim Hemdan <hagarhem@amazon.de>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH 2/3] Revert "bpf: Fix issue in verifying allow_ptr_leaks"
Date:   Wed, 13 Sep 2023 12:28:28 +0000
Message-ID: <20230913122827.91591-1-gerhorst@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAADnVQLid7QvukhnqRoY2VVFi1tCfkPFsMGUUeHDtCgf0SAJCg@mail.gmail.com>
References: <CAADnVQLid7QvukhnqRoY2VVFi1tCfkPFsMGUUeHDtCgf0SAJCg@mail.gmail.com>
Reply-To: <gerhorst@cs.fau.de>
MIME-Version: 1.0
X-Originating-IP: [10.15.21.113]
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D017EUA004.ant.amazon.com (10.252.50.239)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This reverts commit d75e30dddf73449bc2d10bb8e2f1a2c446bc67a2.

To mitigate Spectre v1, the verifier relies on static analysis to deduct
constant pointer bounds, which can then be enforced by rewriting pointer
arithmetic [1] or index masking [2]. This relies on the fact that every
memory region to be accessed has a static upper bound and every date
below that bound is accessible. The verifier can only rewrite pointer
arithmetic or insert masking instructions to mitigate Spectre v1 if a
static upper bound, below of which every access is valid, can be given.

When allowing packet pointer comparisons, this introduces a way for the
program to effectively construct an accessible pointer for which no
static upper bound is known. Intuitively, this is obvious as a packet
might be of any size and therefore 0 is the only statically known upper
bound below of which every date is always accessible (i.e., none).

To clarify, the problem is not that comparing two pointers can be used
for pointer leaks in the same way in that comparing a pointer to a known
scalar can be used for pointer leaks. That is because the "secret"
components of the addresses cancel each other out if the pointers are
into the same region.

With [3] applied, the following malicious BPF program can be loaded into
the kernel without CAP_PERFMON:

r2 = *(u32 *)(r1 + 76) // data
r3 = *(u32 *)(r1 + 80) // data_end
r4 = r2
r4 += 1
if r4 > r3 goto exit
r5 = *(u8 *)(r2 + 0) // speculatively read secret
r5 &= 1 // choose bit to leak
// ... side channel to leak secret bit
exit:
// ...

This is jited to the following amd64 code which still contains the
gadget:

   0:   endbr64
   4:   nopl   0x0(%rax,%rax,1)
   9:   xchg   %ax,%ax
   b:   push   %rbp
   c:   mov    %rsp,%rbp
   f:   endbr64
  13:   push   %rbx
  14:   mov    0xc8(%rdi),%rsi // data
  1b:   mov    0x50(%rdi),%rdx // data_end
  1f:   mov    %rsi,%rcx
  22:   add    $0x1,%rcx
  26:   cmp    %rdx,%rcx
  29:   ja     0x000000000000003f // branch to mispredict
  2b:   movzbq 0x0(%rsi),%r8 // speculative load of secret
  30:   and    $0x1,%r8 // choose bit to leak
  34:   xor    %ebx,%ebx
  36:   cmp    %rbx,%r8
  39:   je     0x000000000000003f // branch based on secret
  3b:   imul   $0x61,%r8,%r8 // leak using port contention side channel
  3f:   xor    %eax,%eax
  41:   pop    %rbx
  42:   leaveq
  43:   retq

Here I'm using a port contention side channel because storing the secret
to the stack causes the verifier to insert an lfence for unrelated
reasons (SSB mitigation) which would terminate the speculation.

As Daniel already pointed out to me, data_end is even attacker
controlled as one could send many packets of sufficient length to train
the branch prediction into assuming data_end >= data will never be true.
When the attacker then sends a packet with insufficient data, the
Spectre v1 gadget leaks the chosen bit of some value that lies behind
data_end.

To make it clear that the problem is not the pointer comparison but the
missing masking instruction, it can be useful to transform the code
above into the following equivalent pseudocode:

r2 = data
r3 = data_end
r6 = ... // index to access, constant does not help
r7 = data_end - data // only known at runtime, could be [0,PKT_MAX)
if !(r6 < r7) goto exit
// no masking of index in r6 happens
r2 += r6 // addr. to access
r5 = *(u8 *)(r2 + 0) // speculatively read secret
// ... leak secret as above

One idea to resolve this while still allowing for unprivileged packet
access would be to always allocate a power of 2 for the packet data and
then also pass the respective index mask in the skb structure. The
verifier would then have to check that this index mask is always applied
to the offset before a packet pointer is dereferenced. This patch does
not implement this extension, but only reverts [3].

[1] 979d63d50c0c0f7bc537bf821e056cc9fe5abd38 ("bpf: prevent out of bounds speculation on pointer arithmetic")
[2] b2157399cc9898260d6031c5bfe45fe137c1fbe7 ("bpf: prevent out-of-bounds speculation")
[3] d75e30dddf73449bc2d10bb8e2f1a2c446bc67a2 ("bpf: Fix issue in verifying allow_ptr_leaks")

Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Luis Gerhorst <gerhorst@amazon.de>
Signed-off-by: Luis Gerhorst <gerhorst@cs.fau.de>
Acked-by: Hagar Gamal Halim Hemdan <hagarhem@amazon.de>
Cc: Puranjay Mohan <puranjay12@gmail.com>
---
 kernel/bpf/verifier.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb78212fa5b2..b415a81149ed 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14050,12 +14050,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	/* check src2 operand */
-	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
-	if (err)
-		return err;
-
-	dst_reg = &regs[insn->dst_reg];
 	if (BPF_SRC(insn->code) == BPF_X) {
 		if (insn->imm != 0) {
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
@@ -14067,13 +14061,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		if (err)
 			return err;
 
-		src_reg = &regs[insn->src_reg];
-		if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_reg)) &&
-		    is_pointer_value(env, insn->src_reg)) {
+		if (is_pointer_value(env, insn->src_reg)) {
 			verbose(env, "R%d pointer comparison prohibited\n",
 				insn->src_reg);
 			return -EACCES;
 		}
+		src_reg = &regs[insn->src_reg];
 	} else {
 		if (insn->src_reg != BPF_REG_0) {
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
@@ -14081,6 +14074,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		}
 	}
 
+	/* check src2 operand */
+	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
+	if (err)
+		return err;
+
+	dst_reg = &regs[insn->dst_reg];
 	is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 
 	if (BPF_SRC(insn->code) == BPF_K) {
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



