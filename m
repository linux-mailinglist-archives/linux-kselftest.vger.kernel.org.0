Return-Path: <linux-kselftest+bounces-2737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 331E48279AA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03F628502E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594A856472;
	Mon,  8 Jan 2024 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAOsSM7m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DBA46B89;
	Mon,  8 Jan 2024 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso2255995e87.3;
        Mon, 08 Jan 2024 12:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747216; x=1705352016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLfm1mzQrY+NzOzQ/cChcdxuSLRWPW8l6yPKrN7SEt0=;
        b=KAOsSM7my3o0ss9t7OQVwYIK3v6j8c25SIVgd1lutYaJEUfcvsnqc0W7CdPdWhg5uz
         aWcy5G9AF4wmUx1bjhEExthRAlmZhaY/mFn+jLMklCAZu3BldSR8TIDnXKUZ6etKuExf
         yV0nEgckNmni2xq424wk+5agYBTjTCX3R7YqJfBGoXfLJHifTyYt8kaV4xBSjG+8UD9o
         tGksga8hHY0kzYvyg1laFuu0YIxtyVGSNSpEDc4ezS47gyYsYe8iENY20qZ0KbFr3PTy
         46YssoaHsQcXnb9O1xLogfzI/M9BRcvFrDtV96gtgiLq8dX1GoDlr7uqxhqn0ZgL4pfm
         0C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747216; x=1705352016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLfm1mzQrY+NzOzQ/cChcdxuSLRWPW8l6yPKrN7SEt0=;
        b=JN2EIiBjhxM4P4ULyL2s0ZpKr5duT/8gzatvW56wge5PxOK4Mh/tTufvvMTtBWxZBv
         lnxekEuTVz1jH9T+JGlxPSiLdwstFDjfvovsQHBo/jI6Jo/MvqllICq5f5Be4ost3AVj
         orZpCZoXbnlUeS6v9ZB4jEyIRckycOfaur5blynTPI0UygLDRHLYY479YFiOt3z78lTp
         kislYexTDr/PoCAN3p7H3WAs4FJ7yJ3sI+rCiwC9bHeECde9R+U116x7mD9XEIJR3+fb
         lrp5eWmS054Qz9NoIkCO7LmwWhTub1K+FTIz3KbUO+FE86Ly5rniFiEmBIDVNPCMgQlx
         QDkg==
X-Gm-Message-State: AOJu0YzRoEHDSezsZlz0hrSVDZbZbtEQIT9uc/109kpQ1dr/rohBPGKO
	mzMK4QnkKphqfjpz2lDsvGk=
X-Google-Smtp-Source: AGHT+IFc9xZYhhIW8erzKgh0zJWNQ/mdnjmLVjr5yuwJyDMvhfxPQNehXoqEejCOLO6Kdi4IFxMUWQ==
X-Received: by 2002:a05:6512:68f:b0:50e:76e7:b1fc with SMTP id t15-20020a056512068f00b0050e76e7b1fcmr2243701lfe.0.1704747216612;
        Mon, 08 Jan 2024 12:53:36 -0800 (PST)
Received: from localhost ([185.220.101.80])
        by smtp.gmail.com with ESMTPSA id ov19-20020a170906fc1300b00a26ac88d801sm245406ejb.30.2024.01.08.12.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:53:36 -0800 (PST)
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
Subject: [PATCH bpf-next v2 14/15] bpf: Optimize state pruning for spilled scalars
Date: Mon,  8 Jan 2024 22:52:08 +0200
Message-ID: <20240108205209.838365-15-maxtram95@gmail.com>
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

From: Eduard Zingerman <eddyz87@gmail.com>

Changes for scalar ID tracking of spilled unbound scalars lead to
certain verification performance regression. This commit mitigates the
regression by exploiting the following properties maintained by
check_stack_read_fixed_off():
- a mix of STACK_MISC, STACK_ZERO and STACK_INVALID marks is read as
  unbounded scalar register;
- spi with all slots marked STACK_ZERO is read as scalar register with
  value zero.

This commit modifies stacksafe() to consider situations above
equivalent.

Veristat results after this patch show significant gains:

$ ./veristat -e file,prog,states -f '!states_pct<10' -f '!states_b<10' -C not-opt after
File              Program   States (A)  States (B)  States    (DIFF)
----------------  --------  ----------  ----------  ----------------
pyperf180.bpf.o   on_event       10456        8422   -2034 (-19.45%)
pyperf600.bpf.o   on_event       37319       22519  -14800 (-39.66%)
strobemeta.bpf.o  on_event       13435        4703   -8732 (-64.99%)

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 83 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aeb3e198a5ea..cb82f8d4226f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1170,6 +1170,12 @@ static void mark_stack_slot_misc(struct bpf_verifier_env *env, u8 *stype)
 	*stype = STACK_MISC;
 }
 
+static bool is_spilled_scalar_reg64(const struct bpf_stack_state *stack)
+{
+	return stack->slot_type[0] == STACK_SPILL &&
+	       stack->spilled_ptr.type == SCALAR_VALUE;
+}
+
 static void scrub_spilled_slot(u8 *stype)
 {
 	if (*stype != STACK_INVALID)
@@ -16459,11 +16465,45 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 	}
 }
 
+static bool is_stack_zero64(struct bpf_stack_state *stack)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(stack->slot_type); ++i)
+		if (stack->slot_type[i] != STACK_ZERO)
+			return false;
+	return true;
+}
+
+static bool is_stack_unbound_slot64(struct bpf_verifier_env *env,
+				    struct bpf_stack_state *stack)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(stack->slot_type); ++i)
+		if (stack->slot_type[i] != STACK_ZERO &&
+		    stack->slot_type[i] != STACK_MISC &&
+		    (!env->allow_uninit_stack || stack->slot_type[i] != STACK_INVALID))
+			return false;
+	return true;
+}
+
+static bool is_spilled_unbound_scalar_reg64(struct bpf_stack_state *stack)
+{
+	return is_spilled_scalar_reg64(stack) && __is_scalar_unbounded(&stack->spilled_ptr);
+}
+
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		      struct bpf_func_state *cur, struct bpf_idmap *idmap, bool exact)
 {
+	struct bpf_reg_state unbound_reg = {};
+	struct bpf_reg_state zero_reg = {};
 	int i, spi;
 
+	__mark_reg_unknown(env, &unbound_reg);
+	__mark_reg_const_zero(env, &zero_reg);
+	zero_reg.precise = true;
+
 	/* walk slots of the explored stack and ignore any additional
 	 * slots in the current stack, since explored(safe) state
 	 * didn't use them
@@ -16484,6 +16524,49 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			continue;
 		}
 
+		/* load of stack value with all MISC and ZERO slots produces unbounded
+		 * scalar value, call regsafe to ensure scalar ids are compared.
+		 */
+		if (is_spilled_unbound_scalar_reg64(&old->stack[spi]) &&
+		    is_stack_unbound_slot64(env, &cur->stack[spi])) {
+			i += BPF_REG_SIZE - 1;
+			if (!regsafe(env, &old->stack[spi].spilled_ptr, &unbound_reg,
+				     idmap, exact))
+				return false;
+			continue;
+		}
+
+		if (is_stack_unbound_slot64(env, &old->stack[spi]) &&
+		    is_spilled_unbound_scalar_reg64(&cur->stack[spi])) {
+			i += BPF_REG_SIZE - 1;
+			if (!regsafe(env,  &unbound_reg, &cur->stack[spi].spilled_ptr,
+				     idmap, exact))
+				return false;
+			continue;
+		}
+
+		/* load of stack value with all ZERO slots produces scalar value 0,
+		 * call regsafe to ensure scalar ids are compared and precision
+		 * flags are taken into account.
+		 */
+		if (is_spilled_scalar_reg64(&old->stack[spi]) &&
+		    is_stack_zero64(&cur->stack[spi])) {
+			if (!regsafe(env, &old->stack[spi].spilled_ptr, &zero_reg,
+				     idmap, exact))
+				return false;
+			i += BPF_REG_SIZE - 1;
+			continue;
+		}
+
+		if (is_stack_zero64(&old->stack[spi]) &&
+		    is_spilled_scalar_reg64(&cur->stack[spi])) {
+			if (!regsafe(env, &zero_reg, &cur->stack[spi].spilled_ptr,
+				     idmap, exact))
+				return false;
+			i += BPF_REG_SIZE - 1;
+			continue;
+		}
+
 		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID)
 			continue;
 
-- 
2.43.0


