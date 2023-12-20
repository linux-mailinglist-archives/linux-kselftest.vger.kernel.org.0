Return-Path: <linux-kselftest+bounces-2291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EA381A884
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A523C1C214D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D7F4E1BF;
	Wed, 20 Dec 2023 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFTjO6l2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B304E1A6;
	Wed, 20 Dec 2023 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-54bf9a54fe3so146156a12.3;
        Wed, 20 Dec 2023 13:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108456; x=1703713256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=novcoq9/4Pyy8zw+ZSP6rZp8sZ+5d2Y5G7xxLF0te80=;
        b=ZFTjO6l2wQ4ZPEnXlWl/z5X+BQAMxNSz/ujTCrUR5E/W9tg9tVKJfaUfKEgZm0PFwZ
         d/Z0N2dX1KSh/8fVRE2l/vornS+HmKB1HkBcw+osnlMpmN5Lx2jn26zve5mJhepglyhz
         gbL3bNtOAbJIXJR08vOZKlwN9hvIyDRuWW68aj84LeeBx0gm3KJi8p9brIx19d/eRxT6
         Mx+vChBV9VtgDlUo3IIKNhsxImeodyozqIx9Y5AZ9NhJ6n1S25K+pT7q0lf0ZsQG75O6
         makEI70Ff4DaahU0qM/T1fWmp4VDdoZKBqh1crIQHosrVLcFaDfLgGagXJiAyA85/Mi0
         STBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108456; x=1703713256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=novcoq9/4Pyy8zw+ZSP6rZp8sZ+5d2Y5G7xxLF0te80=;
        b=v2akKb8uvyXHivvDco3jtOmHnWf6NW59gnu76iOPiVuNzjo4Lt/wa6P/ukTBWB5g4x
         BgpJ+G2Q/Y/UBy0VmME7vcGPQTvs4/f2ahowaifICyjDej6tT0hxJIQp6w/hL0f/q+fo
         2vxMsxf+6mi0uXGc8CLG/rf6pTQTH/nn+ryq+Cov0LE2tseAGqZIrMY7/o905DevKn8W
         mJGuPzv7dHJF9+YLGwFxpkGXY2vcNxtPGoNw9DX7JmdzpQTUYXnxgztocZjOnZcvmpYt
         kfrE6W7eaAGcCeTQAt0xCTyq59EWYlmaC2GNl4PVLbVblXq1u37WdgeY8NLbh3jJoNKQ
         BCKA==
X-Gm-Message-State: AOJu0YzJBs+wHLjrkGfAmLQR7WH3cX+atPgeCHcLjjzl2Dwh8V6CeM/w
	noddRRFVJ8hPnZqW9HUCAtI=
X-Google-Smtp-Source: AGHT+IHBRMSo1/bxNLn3ZilaWSFFZRRplZXKeZl1jv+HP/070ZAZqfrMPWV4s4WYqVKEhMP6Kud4bA==
X-Received: by 2002:a50:c209:0:b0:552:85f4:ed39 with SMTP id n9-20020a50c209000000b0055285f4ed39mr5534327edf.38.1703108456194;
        Wed, 20 Dec 2023 13:40:56 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id q11-20020a056402248b00b00553165eb4f7sm296778eda.17.2023.12.20.13.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:55 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
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
Subject: [PATCH bpf-next 14/15] bpf: Optimize state pruning for spilled scalars
Date: Wed, 20 Dec 2023 23:40:12 +0200
Message-ID: <20231220214013.3327288-15-maxtram95@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231220214013.3327288-1-maxtram95@gmail.com>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
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
index b6e252539e52..a020d4d83524 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1168,6 +1168,12 @@ static void mark_stack_slot_misc(struct bpf_verifier_env *env, u8 *stype)
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
@@ -16449,11 +16455,45 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
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
@@ -16474,6 +16514,49 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
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
2.42.1


