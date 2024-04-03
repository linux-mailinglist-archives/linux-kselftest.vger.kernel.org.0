Return-Path: <linux-kselftest+bounces-7058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B89788967B6
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 10:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F3B284BD4
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F1A81AC4;
	Wed,  3 Apr 2024 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LoaKepvw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0510F82860
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131535; cv=none; b=QHTbwySwjGnyK+PSXaVCsDWcmcijLfNVawtWIzd8oN7QkcDBOb6bD+eTVDOLYY718LMk6cUhOCU3euMPAWvlUH93XbSfOj86MRNwwsHVM44133oxYrwdEAvRMSeiexSVWhG7X50nQiLP8ZTdAUud5RsV3aWaP94QJuawnepY/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131535; c=relaxed/simple;
	bh=+BS7mctHpN9iWLFPEwC2/74zIoWzY97OXSTjHAOIU1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E7v/Gjj/Ilx22hwOwcBTIeelMLst7z7g1S5IP0pvh0nLBUHrwIzFX6xTZDXsPB6wJPmaDdMlLoIgd4cvbXaBnb4R8Fur8b06Nmvp/0RH6HoClFeiYQkUQaAuFZYwYe8qA8Bij+Qbbo60bPHmrcw3R/ix9LtZRUQLQN/FQOhvh+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LoaKepvw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6eaf7c97738so2851951b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131533; x=1712736333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLadZMY/1E+aj61iqE390ie32fUnJXqsMN5cFXtebck=;
        b=LoaKepvwpIgMgTETh3kzvXiZiZwSk+B9o73db2yUsrHf0PeqmmT4O4FXUjdiF6lgH9
         +SJTk8Gp6utJJzIeThkrwLJp0MkiycHvkrPfjfaUDYF9G0kuF2olWU0A9/MGQcI/1YHq
         ePSbSQa4NDp1GdSg5ozbKaFx6dny/viVqIQhIhfawKkC8GCzYZ86G/Np1ZnrHtrEdzFG
         Ia31qc9p6AvwgtLwXeT23pDuQCNoDayhHtGguhQ//jSZsvEW+nsWqQ8tNS7uMugcnWK2
         0qApW4wFGj1MmdZNsRCk5LFO9sekAdwsTLJCTs9wmR3OsbpnYZmHXW5TFHHWYI76Z315
         17Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131533; x=1712736333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLadZMY/1E+aj61iqE390ie32fUnJXqsMN5cFXtebck=;
        b=hI/c+y+KpeGoASyyyPKOvEjJaYfsPcrjc32L+Ri5hM88L542xVeXUZWTm/wCFZkhKM
         ePTgLbsnNmL00v1foAwVLTC125xzeoeQGtFdkiBzuiXIRv4xHW25S7xDk/YWbGGBrG1t
         WnhiUwKdYnoR0n4Qvcf42M9RAblDAfBGmq83Y/858/tnEyeOP7FrstoM4RPpX+JJO+Xs
         c3hnX0WVpSbUN2bjVY28KhIyaI+prBpzSbxD/bvuPig/7cjUos2SBDhiqvfBFnLspFNF
         qfb+mc9UQyCg0OozLt011EYEMbhjCU0qIn9O3LJ2To/KcNoU6W9IYMWjh3uopqw2Mzob
         wyaA==
X-Forwarded-Encrypted: i=1; AJvYcCV3pnRoCaTyuKikQITr1dtL6xqPr5YbHABVxMxhVVW6nPSY3UWzHOTZ1Rz600ETu7kYJ4jH4R/GfT+MSpYcRC7jYYP/pHXszWfz9akXCxsA
X-Gm-Message-State: AOJu0YwCni0DoQNhP9GMMaF4DDxcu2Rf1OfS4p3UNvVkYCdBDwPx92Xd
	yhWcC1HwUfAizhTJDrMVRH4brxnQWZN9pAZnlcG8kctrV5n9NezxB/LoXQu5F9Y=
X-Google-Smtp-Source: AGHT+IHYBgMwEeWVbd4P9PNDRXwi0PIWRTlB15cj+AGKTpxTy9q1IU7RrYP0KIGaFYPVod/3S9sbOg==
X-Received: by 2002:a05:6a21:3294:b0:1a5:6a85:8ce9 with SMTP id yt20-20020a056a21329400b001a56a858ce9mr2619252pzb.12.1712131533285;
        Wed, 03 Apr 2024 01:05:33 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:32 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
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
Subject: [PATCH v5 10/22] RISC-V: KVM: No need to update the counter value during reset
Date: Wed,  3 Apr 2024 01:04:39 -0700
Message-Id: <20240403080452.1007601-11-atishp@rivosinc.com>
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

The virtual counter value is updated during pmu_ctr_read. There is no need
to update it in reset case. Otherwise, it will be counted twice which is
incorrect.

Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index cee1b9ca4ec4..b5159ce4592d 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -397,7 +397,6 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 {
 	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
 	int i, pmc_index, sbiret = 0;
-	u64 enabled, running;
 	struct kvm_pmc *pmc;
 	int fevent_code;
 
@@ -432,12 +431,9 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 				sbiret = SBI_ERR_ALREADY_STOPPED;
 			}
 
-			if (flags & SBI_PMU_STOP_FLAG_RESET) {
-				/* Relase the counter if this is a reset request */
-				pmc->counter_val += perf_event_read_value(pmc->perf_event,
-									  &enabled, &running);
+			if (flags & SBI_PMU_STOP_FLAG_RESET)
+				/* Release the counter if this is a reset request */
 				kvm_pmu_release_perf_event(pmc);
-			}
 		} else {
 			sbiret = SBI_ERR_INVALID_PARAM;
 		}
-- 
2.34.1


