Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD225851C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jul 2022 16:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbiG2OoL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Jul 2022 10:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiG2OoL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Jul 2022 10:44:11 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00957E025
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Jul 2022 07:44:08 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oHQNS-0045gm-Jb; Fri, 29 Jul 2022 15:50:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From; bh=I8JQffYkp7PTLavONuPZCV5xoA7eupc8ZymQ1b2jLBY=; b=SP1pYn+ArfMo7
        3d/x00ET6pVDrTMoYFTwjQdyBFr056FSnaL0zK4SF9OSfvF6WjPSMrH7sysYqhh+qA8FZUp2IrSDr
        ml8tRAcjB0Q4xhRIe6VJXYodKSRIdtDc5TspAZkVyRfHVRikSecEfkn6GVBKGuwzKV/mr2F961ve4
        XLlEk9fqP0Xt5927ROU04RKmUTnactKWtdsfpObeUOqtejO7vOOlU6RNJDD62MbiLpRSfoHJdeMs9
        LVud9KZtrN36dlfkeDOw7Dy5Wz3hv+8Onw46xrqN+yJo3W50230DMke9rmAtAAYp1FerjmnSlqj17
        FfHfo9lchffG6d2BDbcIQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oHQNS-0004Gc-3c; Fri, 29 Jul 2022 15:50:06 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oHQNI-0001bD-Ff; Fri, 29 Jul 2022 15:49:56 +0200
From:   Michal Luczaj <mhal@rbox.co>
To:     kvm@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, seanjc@google.com,
        pbonzini@redhat.com, shuah@kernel.org, Michal Luczaj <mhal@rbox.co>
Subject: [PATCH 1/2] KVM: x86: emulator: Fix illegal LEA handling
Date:   Fri, 29 Jul 2022 15:48:01 +0200
Message-Id: <20220729134801.1120-1-mhal@rbox.co>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The emulator mishandles LEA with register source operand. Even though such
LEA is illegal, it can be encoded and fed to CPU. In which case real
hardware throws #UD. The emulator, instead, returns address of
x86_emulate_ctxt._regs. This info leak hurts host's kASLR.

Tell the decoder that illegal LEA is not to be emulated.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
What the emulator does for LEA is simply:
	
	case 0x8d: /* lea r16/r32, m */
		ctxt->dst.val = ctxt->src.addr.mem.ea;
		break;

And it makes sense if you assume that LEA's source operand is always
memory. But because there is a race window between VM-exit and the decoder
instruction fetch, emulator can be force fed an arbitrary opcode of choice.
Including some that are simply illegal and would cause #UD in normal
circumstances. Such as a LEA with a register-direct source operand -- for
which the emulator sets `op->addr.reg`, but reads `op->addr.mem.ea`.

		union {
			unsigned long *reg;
			struct segmented_address {
				ulong ea;
				unsigned seg;
			} mem;
			...
		} addr;

Because `reg` and `mem` are in union, emulator reveals address in host's
memory.

I hope this patch is not considered an `instr_dual` abuse?

 arch/x86/kvm/emulate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index f8382abe22ff..7c14706372d0 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -4566,6 +4566,10 @@ static const struct mode_dual mode_dual_63 = {
 	N, I(DstReg | SrcMem32 | ModRM | Mov, em_movsxd)
 };
 
+static const struct instr_dual instr_dual_8d = {
+	D(DstReg | SrcMem | ModRM | NoAccess), N
+};
+
 static const struct opcode opcode_table[256] = {
 	/* 0x00 - 0x07 */
 	F6ALU(Lock, em_add),
@@ -4622,7 +4626,7 @@ static const struct opcode opcode_table[256] = {
 	I2bv(DstMem | SrcReg | ModRM | Mov | PageTable, em_mov),
 	I2bv(DstReg | SrcMem | ModRM | Mov, em_mov),
 	I(DstMem | SrcNone | ModRM | Mov | PageTable, em_mov_rm_sreg),
-	D(ModRM | SrcMem | NoAccess | DstReg),
+	ID(0, &instr_dual_8d),
 	I(ImplicitOps | SrcMem16 | ModRM, em_mov_sreg_rm),
 	G(0, group1A),
 	/* 0x90 - 0x97 */
-- 
2.32.0

