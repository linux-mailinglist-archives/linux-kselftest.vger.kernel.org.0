Return-Path: <linux-kselftest+bounces-2735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A488279A5
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CE8285093
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA66E55E7E;
	Mon,  8 Jan 2024 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgJsQK3d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9CF55E55;
	Mon,  8 Jan 2024 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d5336986cso29744205e9.1;
        Mon, 08 Jan 2024 12:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747207; x=1705352007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4YlXYJMAttQeRUGHeeQCdYKHw087JtCupOXw2uBL7U=;
        b=OgJsQK3dsSbUVzIN74bx0rlob9KA1z4wWEqg2MiRp2sBFXOJm1ygd4nWwv36IpPTHA
         xVw4xnFLxfQwAOK+G0ihEh7yRWzkkAWHkPTzg5UbdGh/+VfwDsaaKXfNcnQzltXROpVQ
         iyGjyFXUe7kM+py7d/W5+Hnwxw+FJPtw0tXyg7mbLaZn2Tm1nXLncVf8K5+D+qAvDTgL
         mWqhe4Q3XMdexoPFCkcg8sQYtJrBSu+gwYfwXTIuSxbYIFTEs4GVtvfn+pnScp2r+v/1
         VJl8YToNvGqxmIji+1RBgDZ8tD4nOKOTKv7M5EnWf+n6njXtzREIt2vF2MuJuSH+4rPK
         7q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747207; x=1705352007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4YlXYJMAttQeRUGHeeQCdYKHw087JtCupOXw2uBL7U=;
        b=iLEUNABCxyqK28Z59q+UVTOmZQajWM8HxaUa+ftFnw1Lx6e5UQx3d06p5FF/9V9n8u
         PMly6sGTcCBQXiAb3qnPUjdZTdigav5WcEsxcNiJGkJCQsIHWF944NK8VDLYFxG6f9rb
         HPv4Y/D3q/t5roTxTBVKGK0s5FJq53pHAmR3599qzx+RlsMLYVH8GeBUgG9o1koNls3U
         tMuDjFaaJHKhpvBPb+0vk4Mdg4A86/ehlW/zRmBRNRXCQdbR9OdbMRIfEo5PWLzW11TP
         p/bE2iOFcn+zMjbj3Sp00EN7lUCmDzy6RbrgEvSCVzrFwp6nr5Spig6SqmyeuQuWMpUb
         bSsA==
X-Gm-Message-State: AOJu0YxbVQ+LURn1zBNo+nVcYrgBmOYtbhXPxBX30+kARqLdcGPQ7hHP
	xBp6GqYG6cMGm+G26Jbs868=
X-Google-Smtp-Source: AGHT+IFWfP2KgCdPWlOIm+9tf4F2y+HBtjp27VCgJ2SLRi8qejXhNUypcZusVoBytirW4TholAzmOQ==
X-Received: by 2002:a05:600c:1d9d:b0:40e:4914:31d0 with SMTP id p29-20020a05600c1d9d00b0040e491431d0mr649700wms.70.1704747206734;
        Mon, 08 Jan 2024 12:53:26 -0800 (PST)
Received: from localhost ([185.220.101.80])
        by smtp.gmail.com with ESMTPSA id x8-20020a1709065ac800b00a28d1d73654sm239553ejs.207.2024.01.08.12.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:53:26 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH bpf-next v2 12/15] bpf: Preserve boundaries and track scalars on narrowing fill
Date: Mon,  8 Jan 2024 22:52:06 +0200
Message-ID: <20240108205209.838365-13-maxtram95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108205209.838365-1-maxtram95@gmail.com>
References: <20240108205209.838365-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

When the width of a fill is smaller than the width of the preceding
spill, the information about scalar boundaries can still be preserved,
as long as it's coerced to the right width (done by coerce_reg_to_size).
Even further, if the actual value fits into the fill width, the ID can
be preserved as well for further tracking of equal scalars.

Implement the above improvements, which makes narrowing fills behave the
same as narrowing spills and MOVs between registers.

Two tests are adjusted to accommodate for endianness differences and to
take into account that it's now allowed to do a narrowing fill from the
least significant bits.

reg_bounds_sync is added to coerce_reg_to_size to correctly adjust
umin/umax boundaries after the var_off truncation, for example, a 64-bit
value 0xXXXXXXXX00000000, when read as a 32-bit, gets umin = 0, umax =
0xFFFFFFFF, var_off = (0x0; 0xffffffff00000000), which needs to be
synced down to umax = 0, otherwise reg_bounds_sanity_check doesn't pass.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 include/linux/bpf_verifier.h                  |  2 --
 include/linux/filter.h                        | 12 ++++++++
 kernel/bpf/verifier.c                         | 15 +++++++---
 .../selftests/bpf/progs/verifier_spill_fill.c | 28 +++++++++++++------
 4 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e11baecbde68..95ea7657f07e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -239,8 +239,6 @@ enum bpf_stack_slot_type {
 	STACK_ITER,
 };
 
-#define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
-
 #define BPF_REGMASK_ARGS ((1 << BPF_REG_1) | (1 << BPF_REG_2) | \
 			  (1 << BPF_REG_3) | (1 << BPF_REG_4) | \
 			  (1 << BPF_REG_5))
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 68fb6c8142fe..be784be7ed4e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -39,6 +39,8 @@ struct sock_reuseport;
 struct ctl_table;
 struct ctl_table_header;
 
+#define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
+
 /* ArgX, context and stack frame pointer register positions. Note,
  * Arg1, Arg2, Arg3, etc are used as argument mappings of function
  * calls in BPF_CALL instruction.
@@ -881,6 +883,16 @@ bpf_ctx_narrow_access_offset(u32 off, u32 size, u32 size_default)
 
 #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
 
+static inline bool
+bpf_stack_narrow_access_ok(int off, int size, int spill_size)
+{
+#ifdef __BIG_ENDIAN
+	off -= spill_size - size;
+#endif
+
+	return !(off % BPF_REG_SIZE);
+}
+
 static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
 {
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7fff5f5aa1d..aeb3e198a5ea 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4774,7 +4774,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			if (dst_regno < 0)
 				return 0;
 
-			if (!(off % BPF_REG_SIZE) && size == spill_size) {
+			if (size <= spill_size &&
+			    bpf_stack_narrow_access_ok(off, size, spill_size)) {
 				/* The earlier check_reg_arg() has decided the
 				 * subreg_def for this insn.  Save it first.
 				 */
@@ -4782,6 +4783,12 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 
 				copy_register_state(&state->regs[dst_regno], reg);
 				state->regs[dst_regno].subreg_def = subreg_def;
+
+				/* Break the relation on a narrowing fill.
+				 * coerce_reg_to_size will adjust the boundaries.
+				 */
+				if (get_reg_width(reg) > size * BITS_PER_BYTE)
+					state->regs[dst_regno].id = 0;
 			} else {
 				int spill_cnt = 0, zero_cnt = 0;
 
@@ -6057,10 +6064,10 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
 	 * values are also truncated so we push 64-bit bounds into
 	 * 32-bit bounds. Above were truncated < 32-bits already.
 	 */
-	if (size < 4) {
+	if (size < 4)
 		__mark_reg32_unbounded(reg);
-		reg_bounds_sync(reg);
-	}
+
+	reg_bounds_sync(reg);
 }
 
 static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index cc6c5a3b464b..fab8ae9fe947 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -217,7 +217,7 @@ __naked void uninit_u32_from_the_stack(void)
 
 SEC("tc")
 __description("Spill a u32 const scalar.  Refill as u16.  Offset to skb->data")
-__failure __msg("invalid access to packet")
+__success __retval(0)
 __naked void u16_offset_to_skb_data(void)
 {
 	asm volatile ("					\
@@ -225,19 +225,24 @@ __naked void u16_offset_to_skb_data(void)
 	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
 	w4 = 20;					\
 	*(u32*)(r10 - 8) = r4;				\
-	r4 = *(u16*)(r10 - 8);				\
+	r4 = *(u16*)(r10 - %[offset]);			\
 	r0 = r2;					\
-	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=20 */\
 	r0 += r4;					\
-	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */\
+	/* if (r0 > r3) R0=pkt,off=20 R2=pkt R3=pkt_end R4=20 */\
 	if r0 > r3 goto l0_%=;				\
-	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */\
+	/* r0 = *(u32 *)r2 R0=pkt,off=20 R2=pkt R3=pkt_end R4=20 */\
 	r0 = *(u32*)(r2 + 0);				\
 l0_%=:	r0 = 0;						\
 	exit;						\
 "	:
 	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
-	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	  __imm_const(offset, 8)
+#else
+	  __imm_const(offset, 6)
+#endif
 	: __clobber_all);
 }
 
@@ -268,7 +273,7 @@ l0_%=:	r0 = 0;						\
 }
 
 SEC("tc")
-__description("Spill a u32 const scalar.  Refill as u16 from fp-6.  Offset to skb->data")
+__description("Spill a u32 const scalar.  Refill as u16 from MSB.  Offset to skb->data")
 __failure __msg("invalid access to packet")
 __naked void _6_offset_to_skb_data(void)
 {
@@ -277,7 +282,7 @@ __naked void _6_offset_to_skb_data(void)
 	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
 	w4 = 20;					\
 	*(u32*)(r10 - 8) = r4;				\
-	r4 = *(u16*)(r10 - 6);				\
+	r4 = *(u16*)(r10 - %[offset]);			\
 	r0 = r2;					\
 	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
 	r0 += r4;					\
@@ -289,7 +294,12 @@ l0_%=:	r0 = 0;						\
 	exit;						\
 "	:
 	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
-	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	  __imm_const(offset, 6)
+#else
+	  __imm_const(offset, 8)
+#endif
 	: __clobber_all);
 }
 
-- 
2.43.0


