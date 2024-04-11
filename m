Return-Path: <linux-kselftest+bounces-7630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B68A047E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 02:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2D11C219BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 00:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3083933C5;
	Thu, 11 Apr 2024 00:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="l6q4d0pp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88CF1D52D
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 00:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794116; cv=none; b=nPIzqTUoZ1sRiUie2lhiFjgKVP3jEjOTnWEJML+S5PvngELpgzpInzViO5oXmBi3TnMj4ZNCraof7BGsyJXimbW421AkfYX+gC8r/rxz5Q4HLrAVPRlBVC1qzqo9wVHMDI+wbYsS2sOMWsnId7DHxu1rxAM6wi0UK6JIUezWZUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794116; c=relaxed/simple;
	bh=i4/+SnhxIOkVH6jnqRPVGKLSvQvEdBjQqHeh5YP3SQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MNtHG9Ll/kYsfLFD3ZkV3CTcdqwvtoWGBbGanlptmQNVZdDcbhgVxKFtgr4phLDRYrUbJfzhlcmUvk17UO/rZfOizA1Sx93bBoVR9WtsM2+FVPjFrcghtJ+upnBnTIQ7Oa53TMadXFw78NpRtGpF7QTcLDTat5qnlZYqqkPUO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=l6q4d0pp; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso5381114a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 17:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794114; x=1713398914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=l6q4d0ppNxosr61PxpO+nUwCvp8BuauMe8AT/gF+ws53u+i1hRcpLbAxgLL/RR9FNM
         I2ehD7DsI9uFFtzN6CmfRs0UQs23vpNYKPCV57cGjhERXd1jCXhEJT2XFyXnERDqU9qr
         hDX27UVa/IAVTggAs3avcEOHN+5kbilri8uxj9GTd4MxtBzOYq5BfIxhtGBbRNNxF0aC
         wxUA2/IWKnkYOblTYQWHV9V0yVhMugliuiLDTPpoiAiGaf7gwPk1BOQlymixilBoEsco
         ZIa3OcH8XGoBnSDo99fhtXchf3E5jKN4U/1Tgx5MpbrQaf8hHA/losih3lakGF2Xx5UE
         TcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794114; x=1713398914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=lk68bZ4NLnkVi6KlI34trSwhemVbbgi8B0dNNH6RFBNe/bFNYE9ODwArEiq7jAgPuQ
         aTUHyeKw3jRkDylJziUyqFlciqWuXSedqddzgjk5VpA+88qL/ODhPi6R5MRlz9Lgdezy
         o9MrF3q+sRv/yVZysJV+94JXGAvKh7xUFzjyYJNUd1JkyK13OIRen2acDJUrgZW97BmP
         vw5LpKWQ+eW2FbvR0o60PBKOJJYxTloInA4VKlHylC2q+gb9zTjiM5WKk1sYzQZGPuSI
         Nul8i3VV7ZCazjDvUzFk+ziwIfgnYr/KIxMF8p4CNo13wmL28Lxq3musbR6xGZPiBDvw
         lwjg==
X-Forwarded-Encrypted: i=1; AJvYcCW+ECo2Sv7VZRfSzO0IG5KU33rEu90JEYrv9JxYTZgq+/hg8LlSTAhguu5bbeIPw8XoW+bhXMx4csMigAF3tDrMIDwcUS72fjHQFhOI4a9H
X-Gm-Message-State: AOJu0YyGW8FAd9+c5PKh0eiJ1AzLC+Ie8JF8UXOT1i3HeaVAmv59tnLV
	rEPyhVeCc17ZuYbhJvaU9L87NyLKX4GkLmnariGormK4bf59oK+OwPQaYDS4/M4=
X-Google-Smtp-Source: AGHT+IGlZjUnG/cOH6oxCvOCuQrtoKifdSzPlvvNyoKqm+NzGiaKMBomwqkIVAChpjCW/s39Q+Uflg==
X-Received: by 2002:a17:902:8490:b0:1e0:119e:f935 with SMTP id c16-20020a170902849000b001e0119ef935mr3564608plo.15.1712794114043;
        Wed, 10 Apr 2024 17:08:34 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:33 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v6 10/24] RISC-V: KVM: Fix the initial sample period value
Date: Wed, 10 Apr 2024 17:07:38 -0700
Message-Id: <20240411000752.955910-11-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial sample period value when counter value is not assigned
should be set to maximum value supported by the counter width.
Otherwise, it may result in spurious interrupts.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 86391a5061dd..cee1b9ca4ec4 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -39,7 +39,7 @@ static u64 kvm_pmu_get_sample_period(struct kvm_pmc *pmc)
 	u64 sample_period;
 
 	if (!pmc->counter_val)
-		sample_period = counter_val_mask + 1;
+		sample_period = counter_val_mask;
 	else
 		sample_period = (-pmc->counter_val) & counter_val_mask;
 
-- 
2.34.1


