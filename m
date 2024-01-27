Return-Path: <linux-kselftest+bounces-3668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E4183EF43
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 18:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33511F220B8
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07A32E652;
	Sat, 27 Jan 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eobIvT+0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195B92D04C;
	Sat, 27 Jan 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706377996; cv=none; b=VpGCbiYUTPX9NpAd/RNijYpUAYX6yIjssDCnTwbvyJ44qV2QvEKsX3FV1Af5u9pUzqUFDylz0SOOhBEUaerWwxz6ijwuqeqWlk/9KjWL2by9rWfgn3E42WFqXG2WxrxtvvhIFK8acRLvqnTiEGqTslVikSlhu3iRh3locUuVn2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706377996; c=relaxed/simple;
	bh=ppuOJbWTKXG47/qhgqZIDczj38nPaUZRQ1q+3ti7jxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qfi8aI3vuHyrZcz731kRSD+lyxDi2ooYiqqv5qJSo7TRkdwU0V4rjZ2nJ3qHVXiwENDOLdHawSZkCOVa0RWTm9N4GKlrpxGz/O08GDgh2F+ZZzt3TWSWq2s5yAOs03XmvHiakWL/gVLrU1fuyL2HOlXHO1Uc7HjBhXNKVEYSMDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eobIvT+0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a30e445602cso533592066b.0;
        Sat, 27 Jan 2024 09:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706377993; x=1706982793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gih8YjOYCnRXo89Ub0lhyCjdzkl+eWifpUUwXHuNba8=;
        b=eobIvT+0zLotwb9EHhtOwEMb2AGAoLIk7blvKh2i9x2F1u6WLYnTg2merdKjligSnL
         9EghsI1AgI7rZOQORcAK+TPIpd9MPN1CAikDa27DmPP5N+Ih1wYx50hq0bywxxv4+IEF
         i+Pblhz/xjrn5jvXBOKb2yPxpEi950GEw9DbK/88HL7p8tGQBC5648WWjDEFYpK1ip3O
         OvFAtv9mLO/aFk+6/sxFuCE2tfM0YfFX7L5wnq1Fixiw3TBcrZCm9fsYDI1UM9o1m/fz
         XkYrWepso/Fkpk2Mx1rAu4GjYJ2IIJon6/x8uOgvZ/GNaa///EoaRPg6JvF5tLt0JCeN
         WFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706377993; x=1706982793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gih8YjOYCnRXo89Ub0lhyCjdzkl+eWifpUUwXHuNba8=;
        b=FB/FrjszdJGvYOM5V9AealGPsGBcm/s1hWpPQNg0aO7n5Y7q/6WYC4rGnRfe/ihOL/
         Z6NKb+r1MfONCfJTIHRI8j3APGguL5t2Q0nS54QUaiBoW8w+pQS7hs7WPP2vSGK5rSC3
         bcnA/jG7Em6QN5MFrbfzk1mIFYQZAErMgmVq+40102/VLdDSS3GiZAAasqnbhs0J9QL1
         0hActsQoVwOCwJ7ppvVajRJY+nkgUuFvDubR3qcLCUrrNygG904L3SPa3c9Gj+YHjofz
         mmkf3ozlpDZUu11xHBODH1bMTHXpKMhrymrjZNSb5WnAj4noX3PuCksI/G5AJASFlc59
         hK6g==
X-Gm-Message-State: AOJu0Yz68s0wewl0Ku0xiKuQGL67MWd11qm/DTcZzrRe+WvBt+wpMsnQ
	skD/OVw4kNNC5VgrOQYrOIXUUPIXyUDf3svM/9xW54hpJsk61zWA
X-Google-Smtp-Source: AGHT+IH/9Nj5WDlsPbIDD1PwT1FxXbii1wmvr/nrJGYxhoi6DMNAq+DmzYtYnoPRfoyLnVY+Q57aig==
X-Received: by 2002:a17:907:76e9:b0:a2b:130c:a897 with SMTP id kg9-20020a17090776e900b00a2b130ca897mr3789358ejc.17.1706377992884;
        Sat, 27 Jan 2024 09:53:12 -0800 (PST)
Received: from localhost ([185.220.101.170])
        by smtp.gmail.com with ESMTPSA id vu2-20020a170907a64200b00a2cc5199dd0sm1967844ejc.135.2024.01.27.09.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 09:53:12 -0800 (PST)
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
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 5/6] bpf: handle scalar spill vs all MISC in stacksafe()
Date: Sat, 27 Jan 2024 19:52:36 +0200
Message-ID: <20240127175237.526726-6-maxtram95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127175237.526726-1-maxtram95@gmail.com>
References: <20240127175237.526726-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

When check_stack_read_fixed_off() reads value from an spi
all stack slots of which are set to STACK_{MISC,INVALID},
the destination register is set to unbound SCALAR_VALUE.

Exploit this fact by allowing stacksafe() to use a fake
unbound scalar register to compare 'mmmm mmmm' stack value
in old state vs spilled 64-bit scalar in current state
and vice versa.

Veristat results after this patch show some gains:

./veristat -C -e file,prog,states -f 'states_pct>10'  not-opt after
File                     Program                States   (DIFF)
-----------------------  ---------------------  ---------------
bpf_overlay.o            tail_rev_nodeport_lb4    -45 (-15.85%)
bpf_xdp.o                tail_lb_ipv4            -541 (-19.57%)
pyperf100.bpf.o          on_event                -680 (-10.42%)
pyperf180.bpf.o          on_event               -2164 (-19.62%)
pyperf600.bpf.o          on_event               -9799 (-24.84%)
strobemeta.bpf.o         on_event               -9157 (-65.28%)
xdp_synproxy_kern.bpf.o  syncookie_tc             -54 (-19.29%)
xdp_synproxy_kern.bpf.o  syncookie_xdp            -74 (-24.50%)

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 72 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 81b08a0e9e2c..6a174c4849ba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1155,6 +1155,12 @@ static bool is_spilled_scalar_reg(const struct bpf_stack_state *stack)
 	       stack->spilled_ptr.type == SCALAR_VALUE;
 }
 
+static bool is_spilled_scalar_reg64(const struct bpf_stack_state *stack)
+{
+	return stack->slot_type[0] == STACK_SPILL &&
+	       stack->spilled_ptr.type == SCALAR_VALUE;
+}
+
 /* Mark stack slot as STACK_MISC, unless it is already STACK_INVALID, in which
  * case they are equivalent, or it's STACK_ZERO, in which case we preserve
  * more precise STACK_ZERO.
@@ -2264,8 +2270,7 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
 }
 
 /* Mark a register as having a completely unknown (scalar) value. */
-static void __mark_reg_unknown(const struct bpf_verifier_env *env,
-			       struct bpf_reg_state *reg)
+static void __mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
 {
 	/*
 	 * Clear type, off, and union(map_ptr, range) and
@@ -2277,10 +2282,20 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 	reg->ref_obj_id = 0;
 	reg->var_off = tnum_unknown;
 	reg->frameno = 0;
-	reg->precise = !env->bpf_capable;
+	reg->precise = false;
 	__mark_reg_unbounded(reg);
 }
 
+/* Mark a register as having a completely unknown (scalar) value,
+ * initialize .precise as true when not bpf capable.
+ */
+static void __mark_reg_unknown(const struct bpf_verifier_env *env,
+			       struct bpf_reg_state *reg)
+{
+	__mark_reg_unknown_imprecise(reg);
+	reg->precise = !env->bpf_capable;
+}
+
 static void mark_reg_unknown(struct bpf_verifier_env *env,
 			     struct bpf_reg_state *regs, u32 regno)
 {
@@ -16474,6 +16489,43 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 	}
 }
 
+static struct bpf_reg_state unbound_reg;
+
+static __init int unbound_reg_init(void)
+{
+	__mark_reg_unknown_imprecise(&unbound_reg);
+	unbound_reg.live |= REG_LIVE_READ;
+	return 0;
+}
+late_initcall(unbound_reg_init);
+
+static bool is_stack_all_misc(struct bpf_verifier_env *env,
+			      struct bpf_stack_state *stack)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(stack->slot_type); ++i) {
+		if ((stack->slot_type[i] == STACK_MISC) ||
+		    (stack->slot_type[i] == STACK_INVALID && env->allow_uninit_stack))
+			continue;
+		return false;
+	}
+
+	return true;
+}
+
+static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifier_env *env,
+						  struct bpf_stack_state *stack)
+{
+	if (is_spilled_scalar_reg64(stack))
+		return &stack->spilled_ptr;
+
+	if (is_stack_all_misc(env, stack))
+		return &unbound_reg;
+
+	return NULL;
+}
+
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		      struct bpf_func_state *cur, struct bpf_idmap *idmap, bool exact)
 {
@@ -16512,6 +16564,20 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		if (i >= cur->allocated_stack)
 			return false;
 
+		/* 64-bit scalar spill vs all slots MISC and vice versa.
+		 * Load from all slots MISC produces unbound scalar.
+		 * Construct a fake register for such stack and call
+		 * regsafe() to ensure scalar ids are compared.
+		 */
+		old_reg = scalar_reg_for_stack(env, &old->stack[spi]);
+		cur_reg = scalar_reg_for_stack(env, &cur->stack[spi]);
+		if (old_reg && cur_reg) {
+			if (!regsafe(env, old_reg, cur_reg, idmap, exact))
+				return false;
+			i += BPF_REG_SIZE - 1;
+			continue;
+		}
+
 		/* if old state was safe with misc data in the stack
 		 * it will be safe with zero-initialized stack.
 		 * The opposite is not true
-- 
2.43.0


