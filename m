Return-Path: <linux-kselftest+bounces-39173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF28DB292FD
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 14:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0972020729F
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 12:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E056E241673;
	Sun, 17 Aug 2025 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GWnzBVip"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717B423F40F
	for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755434027; cv=none; b=t0aRhJ/LYtMowdOGnAotuVWNR3V+vGhnCNRDVUplRIdJayYD1CEWajT3eP0n8oBdAd4x+y815CTX6bu0jlOiNr7xJstF0qgl1UkEw49Q4/58llFjVcyMpqqp5ReIzda3c17EWIU8J0Aj5D66nJHZ1PC4IgnQ/29d3DOizH6g3cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755434027; c=relaxed/simple;
	bh=BGEWapcJO5F2Bt9H9CNcjKlUy6pXszyUchO3+rDe18U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6vSpPr0ZoUn7Yz5gUou/xJRZnhJzT8jtJtxFMYUQHDasF97O4154sq7cuizsADWKjGsoPgcwP+dU12PSWtAmb9UzN+QUnScHPsXxQEU7MEwpC9doIGjVcYySNY1mjfUugzW/KNJlTnOHpImHXY0Zh/80aQRCMn7IoYy0UaWaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GWnzBVip; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32326e7baa1so2583721a91.3
        for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755434026; x=1756038826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdtyVjgEpxnmEVvN9KL7OGdIrEXqBJ3Mt9H1T0gTjFI=;
        b=GWnzBVips+KwEYwZ+kznUnRVo0g7347isNIKytAm2M6Cgcm5wr0w1PnO0mNfoq03ny
         6JdvQA6NOVPXhug+CrZNmGUHAp+I0Kc1CWJRy7FohMr09vlzegal+nFaipNwptaO4A57
         1xbohDlLW/k1BL4s7y1R50gdMycw8yuGb1gofRr0ec7uDdT85i9oTqlTBapiMpIuL2Px
         aBXmZQS6vP1LR1jU/Qydtvw+fBDvpm2O+bDgPkr/PkLWOHFq49IZ9ciW/WgUgJOt7DxE
         RtpmIqGech9XoIF8A+yLLEDBga1WDhFDzvQIG02F/hZYt1wSe57F0rzweDbOMR+iXE0U
         lU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755434026; x=1756038826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdtyVjgEpxnmEVvN9KL7OGdIrEXqBJ3Mt9H1T0gTjFI=;
        b=RVgPsusphLWksP90vqiIo9TsqILcWiQIAe/MbyEOmZiZH1yRV7obzcZ218w0jyJOtZ
         y+vEhQQXwIZ+T+0s9+1egSgTWM7XHyPMSBaK3pTTXyzX5umNSxuu17/K6yV+hCD2sZ85
         igcSmHLGBWsBc8jO0ubAP63w+H5ppvz3gtv3lhkF2tQ2Dcpq71K9f6qQA/t04qdPhC+b
         dXc7iK0KFsZwp29pTGMjSRAM5eNTcQrsuhZjbLAOfzo1nTjm8hxPAaeb2Bqcl+XpkBoS
         FOlNXr5hY4bL0Pgk6cnCzEVYAHU2ddgOwtVgyC3GJW7BvmZ8cWBqOJpZVpJt6H7onIkF
         bbSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGoEpWqcoY5UeL8y6H58G/OyvBOKRkLvUixUqnELfr+tGHHHuaR/iXBbN4gkr8Undsf9aiZJvUqnFaDIYrgjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ5v2BLcUqTpHUIJDKqImo/EUsqkU0eH8utsr4TkSvTQ621HbU
	7r77JmWvuiPDsxKeThj90AbFz2LDxz7oVXP+pfVAfGIZg1M6Z6VY5kXli61bpfHRpG4=
X-Gm-Gg: ASbGnct23yhYpqy2b/je3HglBs4CEGLhA7NgmEoLVC+9ubm2hJK9SP4m19Xkr1rjDL6
	paRBbBlwQR9YGDCNFm/tS1zC7YWsI1TBBL19pwC6Nks6KUjuRQrjEbMfaQHlsrZvTpVr3aeTMVb
	xsg2Z0tsjzaagpgZoCZPVWh/g7LL3s9P/SAq9nKGCsxJij/AtPGHKYApddLAunIvGIh5WMTrjz4
	TdZIpA1w2dPtD+AAvCOZcczui6v1RZuAtVaQYPZ8qGmlPOvhhiDx+dELyc1Hec9KsxTxOu97mWG
	9GZwaKHJUSJ4ouQvfWV8u/ckQg0deivtozs3kd4sYSAojA3O55T7hOi+sWAv1eAphA4z8m98JrA
	Z4xRvsbNxCi60UCorYOLe6kz1/XUFSGovklY98YRnSkd8UoAFISayIWo=
X-Google-Smtp-Source: AGHT+IEDEZ+sKN9pizGMbZuUmdosnGUt8+j6ILexLeYj3eWsbGW9HTYMbtimVNOhIKuNFlbVtoY1Dw==
X-Received: by 2002:a17:90b:2d43:b0:31e:c62b:477b with SMTP id 98e67ed59e1d1-32341ec4ed7mr12210812a91.11.1755434025641;
        Sun, 17 Aug 2025 05:33:45 -0700 (PDT)
Received: from localhost.localdomain ([122.171.23.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232b291449sm4480912a91.0.2025.08.17.05.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 05:33:45 -0700 (PDT)
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
Subject: [PATCH v2 1/6] RISC-V: KVM: Set initial value of hedeleg in kvm_arch_vcpu_create()
Date: Sun, 17 Aug 2025 18:03:19 +0530
Message-ID: <20250817123324.239423-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250817123324.239423-1-apatel@ventanamicro.com>
References: <20250817123324.239423-1-apatel@ventanamicro.com>
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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


