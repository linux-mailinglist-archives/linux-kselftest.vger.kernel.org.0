Return-Path: <linux-kselftest+bounces-36796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A32EAFE2C9
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 10:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CFC3BB3F7
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 08:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE7427AC44;
	Wed,  9 Jul 2025 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jl1vqhvL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE227C866;
	Wed,  9 Jul 2025 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050242; cv=none; b=ZU0WTOrZulmkfvH+E8H7xQLdcJvISHgDwYw4Ke+uqsuRvnaBsZUHFOIqkUhZ5qZqbIdD8Wt2TqUjN9vdK6EBSMdCdHiUqILQqmtCc0NrHwZVIYudDCGWD8maS2f8dBdL1SdnzEtsEa+ZHNIL17qofoT9Tw22fsT0QoUC6kVHbwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050242; c=relaxed/simple;
	bh=1YP4NdysJPYE5sk5PuPzp1kp7AYvrvG4PkrBB8p3CJU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IVsDB3cdQ4L9DFEMZCaQuC+WPGH6BUgncnqyPeWSqlxeLyzqOa4cfjfgpxWXPHMJbvAPvaXQwSZggWc/Z+IcZKY4T/gvVG+DbWLFz5YSqO+Xf0FjOHveoGdS62Aak37oxkuiYeY9bowQ74ykjxr83n77mQ6QEvz55rKbR79dk9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jl1vqhvL; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70C6941C7D;
	Wed,  9 Jul 2025 08:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752050232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KMvv0TAm7AUFg0zF7mpWH4qMZsMiovoNEigxpXVTyQg=;
	b=Jl1vqhvLD0hPkq6x3gZ3bA6IXyiBYcTaqty0Maa0/2gNGcSeQricKhdJMyM+7oMGyjVhvH
	HhMq9n74n0oGW2OowAf3eY6ebe+j85d/o6Uv+gPbnPmsSINpqyx2P/nOdKy33Qklgdp+Df
	PuwYbpGucry6Xs9NrYE0poFCRBWwtHGJERHAYypmC4/l9mXaVLxF5bLMa7hyXS8noucqln
	r+9E3tjK1Pd/MsF88Ox3RGxJ6ZgkDl1nj+CRjCRJWX2LPWu0LNSwayEOh/09r414/3kzjy
	gmuGs7+vAEZf5tHP4NqJkpzB2dpnBcmuEO0ZVUZZrHiA+vpGXydhxgKyssL2YA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH 0/2] bpf, arm64: relax constraint in BPF JIT compiler
Date: Wed, 09 Jul 2025 10:36:54 +0200
Message-Id: <20250709-arm64_relax_jit_comp-v1-0-3850fe189092@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACYqbmgC/x3MSQqAMAxA0atI1hZqcYheRaQUGzXiRCoiiHe3u
 HyL/x8IJEwBmuQBoYsD71tElibQT24bSbGPBqNNoSuNysla5lZocbed+bT9vh6KELEu88qjNxD
 TQ2jg+9+23ft+ARVwTmYAAAA=
X-Change-ID: 20250708-arm64_relax_jit_comp-e8889647d8d2
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjedtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeuuefggeeiuedutdeghffhtefguefffeelledttdfgjeejueeggeeugfdugfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemhegvsgeimeduvddtudemrghfugeimeeffhgssgemrggutdekmeekfhelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmeehvggsieemuddvtddumegrfhguieemfehfsggsmegrugdtkeemkehfleeipdhhvghloheplgduledvrdduieekrddurdegjegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhog
 hgvrghrsghogidrnhgvthdprhgtphhtthhopehihhhorhdrshholhhoughrrghisehlihhnuhigrdguvghvpdhrtghpthhtohepvggsphhfsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehpuhhrrghnjhgrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,
this series follows up on the one introducing 9+ args for tracing
programs [1]. It has been observed with this series that there are cases
for which we can not identify accurately the location of the target
function arguments to prepare correctly the corresponding BPF
trampoline. This is the case for example if:
- the function consumes a struct variable _by value_
- it is passed on the stack (no more register available for it)
- it has some __packed__ or __aligned(X)__ attribute

As a consequence, a small restrictive check has been added to the ARM64
side, highlighting that other arch supporting 9+ args in BPF trampolines
are already suffering from the same issue.  After a bit of discussions
and attempts, the chosen solution is, rather than applying the same
constraint to all JIT compilers, to prevent such function from being
encoded at all in BTF info([2]). As the pahole side is closed to be
integrated, we can now remove the restrictive check from kernel side.
 
[1] https://lore.kernel.org/bpf/20250527-many_args_arm64-v3-0-3faf7bb8e4a2@bootlin.com/
[2] https://lore.kernel.org/bpf/20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com/

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Alexis Lothoré (eBPF Foundation) (2):
      bpf, arm64: remove structs on stack constraint
      selftests/bpf: enable tracing_struct tests for arm64

 arch/arm64/net/bpf_jit_comp.c                | 5 -----
 tools/testing/selftests/bpf/DENYLIST.aarch64 | 1 -
 2 files changed, 6 deletions(-)
---
base-commit: 8da1e37fc84868b50ba6a7cdf082aa3b0d11e006
change-id: 20250708-arm64_relax_jit_comp-e8889647d8d2

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


