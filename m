Return-Path: <linux-kselftest+bounces-39791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30738B32A28
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 18:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCD3189D857
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3510A2E92DC;
	Sat, 23 Aug 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="A4x5nRlO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF5C2E7BC5
	for <linux-kselftest@vger.kernel.org>; Sat, 23 Aug 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964809; cv=none; b=jVjmEnSEdorMz9ULglFO9LnGDZUW/ttRJ+uI9eBSxEGSyFltnI+hyvqMsRpnC/xKhCdZgYQkuOfylQI9a2d1h0oQZ1XRLxvJFXrPDVMpfongNURvjV+e8dLzZvdGJJHpT9OJvMuLpwghzrbWsQbrngy+UW5Mj0vWfeEMLdAAm8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964809; c=relaxed/simple;
	bh=WUdBTM0dhD8Re3kqq0DQBL5Pq0pV3tt6HtHEsLxoxa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIwSEHGTzC9HfGmgXDjUlzWHB2AMpsX/a3oMkWXAdr3jak+J6PvJymaPdGkK+3YZX+OIEfe0kVvK+La4uSGH6v+6Q3RBZIqKGJUdK//85f0N6CXrxFr8ja1srLLj0b3uEYshU8gymJAZ3AaZsRT8KVgCk12PgPByKdJZwXms9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=A4x5nRlO; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b47174c8e45so2956421a12.2
        for <linux-kselftest@vger.kernel.org>; Sat, 23 Aug 2025 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755964807; x=1756569607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxIYjoD6qGJ2CFZvAXrDV0PDdB+JeyudOZZgvLWLYX8=;
        b=A4x5nRlOEs0eMEekwhHdrr94WOzBOwWUwfBsyfgg4mqWzenHJywiDuCnUiPpqra/Ef
         x8zYA63YhEWdTo5dP1KAAJi9X3DWKZNpJ4kOUBUEexCzTll6juuHvz40fZZXAmI/jByJ
         t2hYbKwQGjAI0YAHmZZFJACfkRHZlL+b+vIOvJxRvsgCVvyx/TvPGBH1fXfJ51xugZHC
         LJE5GZSMl74L7Bya/HDprTVzXxf6xuWkGVduToUWVxY5Yd8XB0kacfrCrAatvbz7nj/V
         ebyPe4gLXGLGHNBH3RRVHrpW6WxSrboKAeY/KTsEdch64028wAAZD7Q2MbtmDgerru7B
         JwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755964807; x=1756569607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxIYjoD6qGJ2CFZvAXrDV0PDdB+JeyudOZZgvLWLYX8=;
        b=ADTFWyaKOxPX9O0/ErR316IX8o8dJni7jPm7ja/y2V6mxLUaL7N+a2UtO+XAGxJLBr
         G/Nc9p1PMyMRM6FlejpbixTM6C3jNlkUhUguUfGN0Z2ons8p0g9PGtrw3Lrxzvr4q4ab
         AJO8W0NfNonewEeNnATJZxGNt4oVA3wDXzGcp3jz75ojpOmSy/wgDQ7dpLusxp3p2HiV
         s4iKV4Rcp37a7yM9MLRYfHozZPJScDJTN6oBAgqS+KQzpty+lVTu5eEJ0d/1o5CATcTP
         UH0UTNEzYjA6FqHPHIxvDcYLylaKvNrMKOT3pnTX5sa4kkGyE8aFipe0o+u2Ezg3KKjK
         2Kkw==
X-Forwarded-Encrypted: i=1; AJvYcCUkMibWRoHI2xiDyOogsWFbEIP71eMXoyHmYh/E7DKzRZGpzw7asYG12JeSPHNBzXVPtPyKseLK3aafQipY8PM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DW8Bd3P6JuGiBOIXsi18ULaVDQRAL96FKYhnpye3ilVXHTpV
	6gIUIEwnsNaES+1s4Jjywm9kn8RMtdXxt5JDvvBdqxsEJqfcKF669n+TkogymMm4VFA=
X-Gm-Gg: ASbGncttJgql8YNH12pUeyub8uda7Amgv1OZ48BWIIgkNeJ6Ua42PVr1w39fMg4Eldf
	5k6JHtZX2cVnlyXBfgqIjcYmKL/H/rbPm++b0oRrOM5vK2VpSD+i+ff8OBOcm4ZtMZW3S9LmGgu
	DS2TmfrdB637aszNVVc52+H+1YWiRwhNbJz+KkDfopsHgIqcgniRwbPOs8Yf5nERHw0GShRNCv2
	gRON0D1CqtsOsUlJHiPnIfRQvX/sf7ie1xeSaNDuTUxOf4OdqBQF2rEryprVsBnkpu0+vQ8v2/W
	ONmdQLExS6UmNW7WRKfav9AZvrFi+nlm02keGTXlcsaj4zeOIKQt+MTCIpnTRnpyISvcUfJ8RKS
	yXU7nzBtKQgIe9duMwT16P+kHqOFlD9+UASBmFvIyUoKpsP4arU5h7C4O8eQFrhYyYOe35qoW
X-Google-Smtp-Source: AGHT+IH5FZJLOyfrOllB8g78rtlC90yaqO9Xq93Uvux/rEMgW/lp4f5ouiM5epDFAdg0M4MxVn/lXQ==
X-Received: by 2002:a05:6a20:1592:b0:23d:dd9b:b563 with SMTP id adf61e73a8af0-24340d15dcemr10004613637.39.1755964806710;
        Sat, 23 Aug 2025 09:00:06 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040214b81sm2804464b3a.93.2025.08.23.09.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 09:00:06 -0700 (PDT)
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
Subject: [PATCH v3 1/6] RISC-V: KVM: Set initial value of hedeleg in kvm_arch_vcpu_create()
Date: Sat, 23 Aug 2025 21:29:42 +0530
Message-ID: <20250823155947.1354229-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250823155947.1354229-1-apatel@ventanamicro.com>
References: <20250823155947.1354229-1-apatel@ventanamicro.com>
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
index 3ebcfffaa978..47bcf190ccc5 100644
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


