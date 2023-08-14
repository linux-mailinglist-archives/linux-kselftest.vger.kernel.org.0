Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6434177BA61
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 15:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjHNNms (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 09:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjHNNm3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 09:42:29 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F0310E4;
        Mon, 14 Aug 2023 06:42:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686be3cbea0so3598960b3a.0;
        Mon, 14 Aug 2023 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692020546; x=1692625346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvHLE1G4I90f+nf16fsbrAMJ1svZraVgMPkDGTs4isg=;
        b=bWbRgdGT7PvEPb8o676YuWJLDh9pGsZ3yLABdOYpmue4gwTls2uibHibiNse+SJlSr
         QzTIh7/kSIozfoFDqaOAk7GQAnNYHRJGG/QBq3UN4AlQUDXDym8t6l/3NulqfdxpwugZ
         SRP3PdW71TQaiPr5czlGvZgBDXG9ZAI9WJ9129/48xLC3b0bMvFMkukpuyZbpVpjrUfJ
         V68KuKj9TV9ta3MF6gS8Ujkg3Sc1Ywl57zv4/ZL3M7u0RJvQBrPN/V4ZGFpcIRFJnUsn
         5mDe9x1rtGtzh2D45MWk6bPwuHl+f5YykcgUAKgehToryVk2YTb6+btTEL3GK9uKUkam
         Xziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692020546; x=1692625346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvHLE1G4I90f+nf16fsbrAMJ1svZraVgMPkDGTs4isg=;
        b=EQshigAPI5vgf+zK4EIL4sJhMHQ1tngd/ZNqTkBYfSufADEGpCx485wqn/wOG5jgRa
         pXqgG/jFAnJ4PaExTYzhrlsWL9Muf9Q4ICRSi/UXSVGAxH6BiIsbzCd3yZ2ORRj592TJ
         Ma+sO661c+oTurGvuWhvWraBSRwtOKcPw3biebbKAXgdXePJvlWGwSAZVGv4T4DzDlCU
         1KXR3VckUuQOJNQmy+JJ1VgvRzoDNgJVFZ+oejGtBLgFDqNQH34LaZc5Q6sA445W5V+2
         q0C7vfafofiyUQ0htWeQR/2lFpYgkHmGL4MFcoQmhkl0WnGcLDQlrV2TUnv2gZghkgpA
         Z/Hw==
X-Gm-Message-State: AOJu0YwsiQ/se7fVDw8e49CnKoEv3yucunoYkiwWhtLmrJoVPCmVEcvM
        bXfmshOZs+qMSuBg1k9rg9mYQYpFZJok6UnC
X-Google-Smtp-Source: AGHT+IEDOpTrYMCOqRryz7xUyxIXrQAMw833n5fbfEpJDnnc6djVGiM+IhwPRMyZyPw7LKphNL867w==
X-Received: by 2002:a05:6a21:99a6:b0:13d:7f7b:1926 with SMTP id ve38-20020a056a2199a600b0013d7f7b1926mr15615937pzb.11.1692020545798;
        Mon, 14 Aug 2023 06:42:25 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id m3-20020a638c03000000b0055c02b8688asm8555583pgd.20.2023.08.14.06.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:42:25 -0700 (PDT)
From:   Leon Hwang <hffilwlqm@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mykolal@fb.com,
        shuah@kernel.org, davem@davemloft.net, dsahern@kernel.org,
        hffilwlqm@gmail.com, tangyeechou@gmail.com,
        kernel-patches-bot@fb.com, maciej.fijalkowski@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH bpf-next 1/2] bpf, x64: Fix tailcall infinite loop bug
Date:   Mon, 14 Aug 2023 21:41:46 +0800
Message-ID: <20230814134147.70289-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814134147.70289-1-hffilwlqm@gmail.com>
References: <20230814134147.70289-1-hffilwlqm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
handling in JIT"), the tailcall on x64 works better than before.

From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
for x64 JIT"), tailcall is able to run in BPF subprograms on x64.

From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF program
to other BPF programs"), BPF program is able to trace other BPF programs.

How about combining them all together?

1. FENTRY/FEXIT on a BPF subprogram.
2. A tailcall runs in the BPF subprogram.
3. The tailcall calls itself.

As a result, a tailcall infinite loop comes up. And the loop halts the
machine.

As we know, in tail call context, the tail_call_cnt propagates by stack
and RAX register between BPF subprograms. So do it in FENTRY/FEXIT
trampolines.

Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 23 +++++++++++++++++++----
 include/linux/bpf.h         |  6 ++++++
 kernel/bpf/trampoline.c     |  5 +++--
 kernel/bpf/verifier.c       |  9 +++++++--
 4 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a5930042139d3..ca5366d97ad04 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1018,6 +1018,10 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
+/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
+#define RESTORE_TAIL_CALL_CNT(stack)				\
+	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
+
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
 		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -1623,9 +1627,7 @@ st:			if (is_imm8(insn->off))
 
 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
-				EMIT3_off32(0x48, 0x8B, 0x85,
-					    -round_up(bpf_prog->aux->stack_depth, 8) - 8);
+				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
 				if (!imm32)
 					return -EINVAL;
 				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
@@ -2464,6 +2466,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	else
 		/* sub rsp, stack_size */
 		EMIT4(0x48, 0x83, 0xEC, stack_size);
+	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+		EMIT1(0x50);		/* push rax */
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
 
@@ -2516,6 +2520,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		restore_regs(m, &prog, regs_off);
 		save_args(m, &prog, arg_stack_off, true);
 
+		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+			/* Before calling the original function, restore the
+			 * tail_call_cnt from stack.
+			 */
+			RESTORE_TAIL_CALL_CNT(stack_size);
+
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
 			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
 			EMIT2(0xff, 0xd0); /* call *rax */
@@ -2569,7 +2579,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 			ret = -EINVAL;
 			goto cleanup;
 		}
-	}
+	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+		/* Before running the original function, restore the
+		 * tail_call_cnt from stack.
+		 */
+		RESTORE_TAIL_CALL_CNT(stack_size);
+
 	/* restore return value of orig_call or fentry prog back into RAX */
 	if (save_ret)
 		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cfabbcf47bdb8..55c72086034ef 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1028,6 +1028,11 @@ struct btf_func_model {
  */
 #define BPF_TRAMP_F_SHARE_IPMODIFY	BIT(6)
 
+/* Indicate that current trampoline is in a tail call context. Then, it has to
+ * cache and restore tail_call_cnt to avoid infinite tail call loop.
+ */
+#define BPF_TRAMP_F_TAIL_CALL_CTX	BIT(7)
+
 /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
  * bytes on x86.
  */
@@ -1147,6 +1152,7 @@ struct bpf_attach_target_info {
 	struct module *tgt_mod;
 	const char *tgt_name;
 	const struct btf_type *tgt_type;
+	bool tail_call_ctx;
 };
 
 #define BPF_DISPATCHER_MAX 48 /* Fits in 2048B */
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 78acf28d48732..0fae334e3f7b8 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -415,8 +415,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		goto out;
 	}
 
-	/* clear all bits except SHARE_IPMODIFY */
-	tr->flags &= BPF_TRAMP_F_SHARE_IPMODIFY;
+	/* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
+	tr->flags &= (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX);
 
 	if (tlinks[BPF_TRAMP_FEXIT].nr_links ||
 	    tlinks[BPF_TRAMP_MODIFY_RETURN].nr_links) {
@@ -783,6 +783,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 
 	memcpy(&tr->func.model, &tgt_info->fmodel, sizeof(tgt_info->fmodel));
 	tr->func.addr = (void *)tgt_info->tgt_addr;
+	tr->flags = (tgt_info->tail_call_ctx ? BPF_TRAMP_F_TAIL_CALL_CTX : 0);
 out:
 	mutex_unlock(&tr->mutex);
 	return tr;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4ccca1f6c9981..a78e5a2ae5c72 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19400,10 +19400,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			return -EINVAL;
 		fallthrough;
 	case BPF_MODIFY_RETURN:
-	case BPF_LSM_MAC:
-	case BPF_LSM_CGROUP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+		if (tgt_prog && subprog > 0 &&
+		    tgt_prog->aux->func[subprog]->is_func &&
+		    tgt_prog->aux->tail_call_reachable)
+			tgt_info->tail_call_ctx = true;
+		fallthrough;
+	case BPF_LSM_MAC:
+	case BPF_LSM_CGROUP:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
-- 
2.41.0

