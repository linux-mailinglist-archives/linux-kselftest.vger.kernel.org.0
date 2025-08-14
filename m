Return-Path: <linux-kselftest+bounces-38987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5918AB26BCF
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 18:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A972CAC0D97
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2665221DA3;
	Thu, 14 Aug 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fiz69Bs3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6042D204096
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186967; cv=none; b=WuEVZbeYdbHuM9rjwgsNftpPx+/E2LUedfIjBQQ/K9Uq1a4LpbWogc38MQfhm/Nu5CTcLT0+YNWgczQOAkfa0NpyIzkjLjIdzSzwBaM4QwI7e1Ywlv2FMeD7vRp4kiSN8/Innysd90B4yq5RVov0utmI/xa/esSRbpKC5W6lDD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186967; c=relaxed/simple;
	bh=AMl3xYJNuSAGeF7OLy/Kzv4+2drH4oPVNI0DIJBBJPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6G2Rw44RPBjkpNemh7k4fI9kjvOblgSlSRqlft0ZolckG8MhFovhkpkAuQFlRSQx/bEuvLxP9QwR/v+rSVZoAJdK9q5T2gKwwWknz7+M2IzwUWtzU8+/z9rCxcs1+1uObz7djznY8AKqFf3jczKwqZ/ATE7s+9sPaYnf4maTOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fiz69Bs3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24457f47492so7787915ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755186966; x=1755791766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bm60/2Cr4w6uAzbvsdcbKrh6VNvMu+/Ils5A4Kn+0Hk=;
        b=fiz69Bs38/4zeuGfhRlrC409rA6lEj1VYNmfke5l81TWzPBup8G8xjG+Ix46y4RGnD
         tANIVvox1Lw+H8k6HCjSBfy475Iao8yS1/4G7BtiaPYU9pxFCHqtFJ+iwmpGHPOk7S4/
         SgvIYlk+1XRCUhPURCkSVHCFCNaLG70zX+XwHwSE8/XrzPrErUWjAWfU+t6Bd4/dpIRE
         OMSq8M3wYKY8Cpt1pEGXOaZ/LjyKOOiJBWLXe3yYgpODVdVSabxAKEvbI4W79O5fw2j/
         jrPsFqMgYeNvQX0Uq41CqV4WgUX7mPhmb8ZGwbNawawJAnvIIAFs+v6qp9Nu0ZDIIcCb
         jAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186966; x=1755791766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bm60/2Cr4w6uAzbvsdcbKrh6VNvMu+/Ils5A4Kn+0Hk=;
        b=AxtPym6Cy7MYMQXVOo+VNZ4eQ2dO5xffi8deuGRPdbkOIsAIZBKn0NqAdFQtLBciqF
         Tv3eqOwmlzgiH2FSDd5qMhPIPvVrd5xSofDmuR40YVSoEAO+m+lWYFGsIh30XPPS9KPd
         UJe9oJS6FFIzM7S1OSRb9TwVc9l+fLiBzNlS/WZzimI4XVxQgxzCPf0mtMU9wdndGmi5
         0V9V4kZwUgiFLIxbMdbz3kuOem3ISeSacdColKpglRu41ew4UgHtYDLHzDUD1Cp085T4
         g0yaKHQkVX+vxuioIRs59hi/ShYcITmfPEg8GflnXn93X5jG4XqEwhsIFOPPAjHWH2Rt
         0RHw==
X-Forwarded-Encrypted: i=1; AJvYcCWP0QlA0onUKuggoNX6g9Yms13VQJSkmFD0gXy3cS7hhZxM7GkDldJGIHdWiNsG2cEW1ExHOt1BDuFOQ8+8UF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzffOWB4gSZududfHyFJrfYut+KoCGa14UsqBmd45aHOyeVxpaW
	Y8B5v8Yv/sS14Duogsl4CI+WZd3QEPbVCOrFjQxGCKCGEFC5D4ZAtUnQjfalnfJn3xM=
X-Gm-Gg: ASbGncu8e/4dsx8zPeBYE0UUPb2BOSG5l0Lh2x6wHgZMTFIPiuNWaOyr0wqre6AwNp8
	Vm7jX7+JXCB1JxLh/SzNWFK99Dvi25YHmrZWrzsEROJ4DVd4gVPHFi2Q/WQozC4PL7IxLAAGZvP
	aJKVtdgJ12Jt19E6j62nrjJHgqvjLiLRqk7NtYktNcHGXRUYtFcYXgH/uCaMWr9CjxkVDLmZy1A
	/TfOw353fQkC2ErEhW1x3vmwNtpDmgIt1O3KOKnwqtu2w8GLhrM7Y862zvbNHqkCM58twhsa0Nf
	Pnr6PohhmV5ooRjOadWkTDwa3Cf4dWG5vQnW6oVcYoq+3xf5VjiRKrKaV4cEMELtqg0oG0WpC3v
	Aky/aEYSTfKf8td24VHIhBvb+pkBP/do6FSzllGJvNPxFqOCqHrKl+ZW/Gu834g==
X-Google-Smtp-Source: AGHT+IFZMx0P1JKNMfotkf1h9uD05/LbUJ3nHS+qqEqkenBGx5Rm/Php8OZMQlv5/iu6GkzqmdURRg==
X-Received: by 2002:a17:902:cccb:b0:23f:f065:f2be with SMTP id d9443c01a7336-244586a0e5bmr50715635ad.26.1755186965537;
        Thu, 14 Aug 2025 08:56:05 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3233108e1d9sm2225500a91.29.2025.08.14.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:56:05 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 1/6] RISC-V: KVM: Set initial value of hedeleg in kvm_arch_vcpu_create()
Date: Thu, 14 Aug 2025 21:25:43 +0530
Message-ID: <20250814155548.457172-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814155548.457172-1-apatel@ventanamicro.com>
References: <20250814155548.457172-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hedeleg may be updated by ONE_REG interface before the VCPU
is run at least once hence set the initial value of hedeleg in
kvm_arch_vcpu_create() instead of kvm_riscv_vcpu_setup_config().

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/vcpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index f001e56403f9..86025f68c374 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -133,6 +133,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	/* Mark this VCPU never ran */
 	vcpu->arch.ran_atleast_once = false;
+
+	vcpu->arch.cfg.hedeleg = KVM_HEDELEG_DEFAULT;
 	vcpu->arch.mmu_page_cache.gfp_zero = __GFP_ZERO;
 	bitmap_zero(vcpu->arch.isa, RISCV_ISA_EXT_MAX);
 
@@ -570,7 +572,6 @@ static void kvm_riscv_vcpu_setup_config(struct kvm_vcpu *vcpu)
 			cfg->hstateen0 |= SMSTATEEN0_SSTATEEN0;
 	}
 
-	cfg->hedeleg = KVM_HEDELEG_DEFAULT;
 	if (vcpu->guest_debug)
 		cfg->hedeleg &= ~BIT(EXC_BREAKPOINT);
 }
-- 
2.43.0


