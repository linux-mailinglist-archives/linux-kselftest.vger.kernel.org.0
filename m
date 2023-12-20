Return-Path: <linux-kselftest+bounces-2285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5205A81A871
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255EC1C22F5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6394D11E;
	Wed, 20 Dec 2023 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5jS6oXP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6674C3B7;
	Wed, 20 Dec 2023 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2698cff486so13722966b.0;
        Wed, 20 Dec 2023 13:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108441; x=1703713241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gvv0pY6A6i2DfvrEtu8tnwcwTcSQg/Fj4m22tiCCEIc=;
        b=d5jS6oXPIKO7rM6Xss9YBTwvHwHa7e4kICmeLlQAIrgWMFewzmfBB5GFWDO/DsaAK4
         39uYaEIsV8dtQzDEKtpaCDrhQq3OxFExBlaeZTCj+dNlnklYHpETOGPW+fgw00vDjJfg
         HgMLUnTM6u6cW7TS3pntQ/WUuxpkUQhhWTJVMKPFmD1uZev+bouB1Dxlqd/SEAUOtxTW
         MKFCuh6TFBFt9Q+XsaSWkHehE9sWWt8/G+FH4bav+pjnMrIna21ZL41GBRomFOQTrDqJ
         hGm8nFQdm0brQoD/+1zVm0uHQOU8ZS4QJAuAx4aZJRI4DXJ3Z6bHQCHOVcO5s8C7htim
         mbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108441; x=1703713241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gvv0pY6A6i2DfvrEtu8tnwcwTcSQg/Fj4m22tiCCEIc=;
        b=dRn4WXV2be5Fxrvq0wA1kIVKGcpdzxWdr3e1I1G8/0PJJXIPd7Yg39vfO3KXPNwjhY
         VmrjuvuFtL6rqeCewfVG0AgD4fJEVSeFzKrS8orKRDxOueI1a6RoX1wBnehe33Oymj7d
         mMkf9IoQ4pXjmAKG2Wzaltcp+75y03eFMyQHiStn19u0V5xYW9bmXH4eOlHm+Po6Z2fJ
         Y3m8jq2m33jFxEZFhNqRuEqDWkxfKQbv8fzCG94TDyXjcsaWxcbKeQNqdf0WHw+JPTjJ
         OYZIZZ1HyFal9Z3byGAxfHNn6sBmNJtIFhRtaFtVuU5c6/lbTqFzAfpp2Y5cDqaOY+K7
         rJ/w==
X-Gm-Message-State: AOJu0YxQHLDvNKnEKUs3ICQq7ey6sfAcWCWSAiMJMp7x31tl9veGwdlR
	QeyQ3liZq/VVcgeR+1HSjX4=
X-Google-Smtp-Source: AGHT+IEG+vbZCfaPYkd+ZYiamB9M4+7BZMnOHPrP/ZTHlQLhYzCRyzlX8y93l+SaW1Q3qCTTcV6DPQ==
X-Received: by 2002:a17:906:5ac9:b0:a23:3b67:a14d with SMTP id x9-20020a1709065ac900b00a233b67a14dmr1898025ejs.189.1703108440972;
        Wed, 20 Dec 2023 13:40:40 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id ex17-20020a170907955100b00a269fa0d305sm189501ejc.8.2023.12.20.13.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:40 -0800 (PST)
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
	netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH bpf-next 08/15] bpf: Assign ID to scalars on spill
Date: Wed, 20 Dec 2023 23:40:06 +0200
Message-ID: <20231220214013.3327288-9-maxtram95@gmail.com>
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

From: Maxim Mikityanskiy <maxim@isovalent.com>

Currently, when a scalar bounded register is spilled to the stack, its
ID is preserved, but only if was already assigned, i.e. if this register
was MOVed before.

Assign an ID on spill if none is set, so that equal scalars could be
tracked if a register is spilled to the stack and filled into another
register.

One test is adjusted to reflect the change in register IDs.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 kernel/bpf/verifier.c                                     | 8 +++++++-
 .../selftests/bpf/progs/verifier_direct_packet_access.c   | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b757fdbbbdd2..caa768f1e369 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4503,9 +4503,15 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) && env->bpf_capable) {
+		bool reg_value_fits;
+
+		reg_value_fits = get_reg_width(reg) <= BITS_PER_BYTE * size;
+		/* Make sure that reg had an ID to build a relation on spill. */
+		if (reg_value_fits)
+			assign_scalar_id_before_mov(env, reg);
 		save_register_state(env, state, spi, reg, size);
 		/* Break the relation on a narrowing spill. */
-		if (get_reg_width(reg) > BITS_PER_BYTE * size)
+		if (!reg_value_fits)
 			state->stack[spi].spilled_ptr.id = 0;
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   insn->imm != 0 && env->bpf_capable) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index be95570ab382..28b602ac9cbe 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -568,7 +568,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("tc")
 __description("direct packet access: test23 (x += pkt_ptr, 4)")
-__failure __msg("invalid access to packet, off=0 size=8, R5(id=2,off=0,r=0)")
+__failure __msg("invalid access to packet, off=0 size=8, R5(id=3,off=0,r=0)")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void test23_x_pkt_ptr_4(void)
 {
-- 
2.42.1


