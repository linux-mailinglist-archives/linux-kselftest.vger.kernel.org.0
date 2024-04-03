Return-Path: <linux-kselftest+bounces-7056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3357389679E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 10:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644931C20DE5
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 08:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9000C7FBC6;
	Wed,  3 Apr 2024 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TSeifkcC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4B7A15C
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131531; cv=none; b=m6IfhwEF8Gp7OPzcZ9+3Ap3WWgMXjGWFbtrXzF1eXFFUcM4VoVGH//STXu39Rs3jJYhuz2eJHqp7yrbRr+UXZbDOYsq0RT+UpgPlu7Pm/cjgL8MJTRasiUdcuXZZ4VWvQXOzvVfYIuFriEXX0c3fHA3+q/ksHJiBtXiB6twW8S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131531; c=relaxed/simple;
	bh=qmTer1L5IWEJQe0rkUy5cvb4CMl5u/8y+hPoEZoMutA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5ARgN4+DYOa1+ItuwejkTMJWKT+0B1gYSle0f/rtqg9x9VTI29KnmGw9D5z89hQMe/ybuWdlTfpG/wileiCgOXlJ/ZZ7z3nMHpqsmVqZBX15Az69l0Vc+RB/Jygg+/RXak1JJmpwy6r+oKXbn6tfG2ZLGMKt7U3w+Flh4yXwo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TSeifkcC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e2232e30f4so46283725ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 01:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131529; x=1712736329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HMUEh/ouJpwrjadx4E8ELJ1oGZIEAqlVNHNOiveHPA=;
        b=TSeifkcCVel9tg4BDxNqVioc8wG9MlkoJ3zjDFmQ42yLVyPQQ8/t+ga6mhJbasv/cw
         kdJkdlohOprTHDTHFncMalAz2OKXkpESH3KiBcjPJ3O0ROPYzDMLNerLFiJXwcaURbUe
         3mI2ilSR2OFLFlLOLX1B4cW/7jrw41WmIldFZwK2rPx7Q4ZzK6Bw97v8K/ZJs5yHr3TS
         6SlM4sakMFvnbC9Gbl3qb8BFO+Y+NQVomRmg8WnYURs55sBXVKzOufTz7YG/ZqSp8MLp
         ZVpChGoH1VXBdxE7bFMf9Dp0wm1JhxgFxm0n5HeRKbSBSShB8oHiu3umukjLxijTUd35
         srDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131529; x=1712736329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HMUEh/ouJpwrjadx4E8ELJ1oGZIEAqlVNHNOiveHPA=;
        b=ib9UFhmzn6ctWrvpoY7Tu9btfOlBGOX/PuOSH+WWtrgWx0YNeX1MxgNH12wJpfUuSV
         eMZ6/DL7b+vlzVf7UbaSDcYxPudyQk1SS+1dBh5HDdia7iEs6m7IHTvlsiUctuZZ2Dgw
         8tUUjnpDOK2C80EIG0/QXw5lzNB7+Eltul8lTbEt37+gJNvCwk33oRsU/SFUCqQWojwL
         AKGO2hQLisDRXyoXxj4NPRQOR5AbIpUi9WvjZzm5pvg59/CpTDeL2PREmODlDZ0M+DuB
         iPvrXJ+Nwr7NeSqJNZD9uuQG8XPH98om7tGDhi9I+S/eCJ8fYeKCZ0RPH3CLyn4KOJlD
         H93w==
X-Forwarded-Encrypted: i=1; AJvYcCVDi5RixXwGcY6YnMrkg/nCVLC727LuDPHeaN3JpLxhTzoBp3HS8WAJ2mGq3BTZL5JmnVMNwEgLwsma2p/cRgOI2bZFHISCna+ZFKvyU4er
X-Gm-Message-State: AOJu0Yz7eB08WhO+xAzaGJlBq8vYGrMR6UPKkyo87RXcnqluLqZ/sTus
	aV+C+Ib4M6NepPKGKOEaqXjCGPJC4osrN225V5+3ELVbYFRpnCbd4uBTefG3FRCV/rFz0PoGbfg
	d
X-Google-Smtp-Source: AGHT+IF30gBaFjuZamH6gB+fLa8VQAOCDXL32p+FdETcNWyCBYGk0g9s0A7zOmyK2RvO8zqC4rEDCA==
X-Received: by 2002:a17:902:aa04:b0:1e2:23b8:98dd with SMTP id be4-20020a170902aa0400b001e223b898ddmr14090965plb.69.1712131529484;
        Wed, 03 Apr 2024 01:05:29 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:28 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
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
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v5 08/22] RISC-V: KVM: Fix the initial sample period value
Date: Wed,  3 Apr 2024 01:04:37 -0700
Message-Id: <20240403080452.1007601-9-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403080452.1007601-1-atishp@rivosinc.com>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
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


