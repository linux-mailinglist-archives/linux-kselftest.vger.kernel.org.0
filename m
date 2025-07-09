Return-Path: <linux-kselftest+bounces-36797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BFCAFE2CC
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 10:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031163BB292
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 08:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63FC27D77B;
	Wed,  9 Jul 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TjKCJY6l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6987627AC34;
	Wed,  9 Jul 2025 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050243; cv=none; b=VJY2EMPyfIGhc+EaSrn6T7t/nysUda4YwfzdqhPxeFvXyWWJTvUOu2Ouvp+bxuuVhFzN7C4NGSxEJkF0MduWxcjObZismlG8Qdx0D/InHNgNIbDJx7FtFHo/VCBxlvtQ4fFiD3dFnXWC7erzR33XsBN6RJDrszj962kUqs52srU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050243; c=relaxed/simple;
	bh=L93bLiNKztx8aB9zhYzQ6xi3GcIgscSsGxcIfpM/DHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kg75mDqe2RsCcinNMuuNWr8uKi9bGY6s5Si+jEAcMoRUgbfE9Wsc0A6OYb2UcT7MbVgGOC9m8687kTZ2HolrD6FvNeY7XhgNSrLOKEl2KfqBBuauvdbXdH+x1mSXGfksC+3jULGaUfHpfk8BNW182b3kF+xLEFvJagLsyGP7qyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TjKCJY6l; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD30742DFF;
	Wed,  9 Jul 2025 08:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752050234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5P8A90l1y12Vp7M4Bmnp36AiCOYYzQNBrh1FfXK/1E=;
	b=TjKCJY6lX5CKK8PpiMwCcNpCXR104xGzI3YtVayIzqFmu8k1i1CGUT1i0pPwC70wJxiPd6
	GS5bB6tiuQ51t9UqdRKNj6TU7zsKX2Tqa7GbZUVwwoHEisl9ArShi6tL7CItPfP/Qj8eI/
	5sUUYTIQm9HH9slEBcli6xMlMk2zlgDH9LcQDk3h2iCoC5wtYPbDyNPePw5QSsfAoD0I5P
	TDajvD8bDH9wNXdph4XsQ8ZnpZ2Is9i6hQLHyrViq/xLwefmR3rc8Oi7y6TVtCt5MsLTCT
	eNyjQ6rqkbLU6sdyKr6GOFEMlQ8LCquJKpOsYmfb9YOmMlmtiwpW6Tphzc7Tmw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 09 Jul 2025 10:36:55 +0200
Subject: [PATCH 1/2] bpf, arm64: remove structs on stack constraint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250709-arm64_relax_jit_comp-v1-1-3850fe189092@bootlin.com>
References: <20250709-arm64_relax_jit_comp-v1-0-3850fe189092@bootlin.com>
In-Reply-To: <20250709-arm64_relax_jit_comp-v1-0-3850fe189092@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjedtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepteejvdeftdduueeihfeuhfevgfevhedttdeuveeuheefveffudekleekhfeljeffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddvmeekgedvkeemhegvsgeimeduvddtudemrghfugeimeeffhgssgemrggutdekmeekfhelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmeehvggsieemuddvtddumegrfhguieemfehfsggsmegrugdtkeemkehfleeipdhhvghloheplgduledvrdduieekrddurdegjegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvt
 hdprhgtphhtthhopehihhhorhdrshholhhoughrrghisehlihhnuhigrdguvghvpdhrtghpthhtohepvggsphhfsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehpuhhrrghnjhgrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: alexis.lothore@bootlin.com

While introducing support for 9+ arguments for tracing programs on
ARM64, commit 9014cf56f13d ("bpf, arm64: Support up to 12 function
arguments") has also introduced a constraint preventing BPF trampolines
from being generated if the target function consumes a struct argument
passed on stack, because of uncertainties around the exact struct
location: if the struct has been marked as packed or with a custom
alignment, this info is not reflected in BTF data, and so generated
tracing trampolines could read the target function arguments at wrong
offsets.

This issue is not specific to ARM64: there has been an attempt (see [1])
to bring the same constraint to other architectures JIT compilers. But
discussions following this attempt led to the move of this constraint
out of the kernel (see [2]): instead of preventing the kernel from
generating trampolines for those functions consuming structs on stack,
it is simpler to just make sure that those functions with uncertain
struct arguments location are not encoded in BTF information, and so
that one can not even attempt to attach a tracing program to such
function. The task is then deferred to pahole (see [3]).

Now that the constraint is handled by pahole, remove it from the arm64
JIT compiler to keep it simple.

[1] https://lore.kernel.org/bpf/20250613-deny_trampoline_structs_on_stack-v1-0-5be9211768c3@bootlin.com/
[2] https://lore.kernel.org/bpf/CAADnVQ+sj9XhscN9PdmTzjVa7Eif21noAUH3y1K6x5bWcL-5pg@mail.gmail.com/
[3] https://lore.kernel.org/bpf/20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com/

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 arch/arm64/net/bpf_jit_comp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b6c42b5c96688251ea24f5e771fa1effff896541..89b1b8c248c62e09cec61e13318d45b59006dce1 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2240,11 +2240,6 @@ static int calc_arg_aux(const struct btf_func_model *m,
 
 	/* the rest arguments are passed through stack */
 	for (; i < m->nr_args; i++) {
-		/* We can not know for sure about exact alignment needs for
-		 * struct passed on stack, so deny those
-		 */
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			return -ENOTSUPP;
 		stack_slots = (m->arg_size[i] + 7) / 8;
 		a->bstack_for_args += stack_slots * 8;
 		a->ostack_for_args = a->ostack_for_args + stack_slots * 8;

-- 
2.50.0


