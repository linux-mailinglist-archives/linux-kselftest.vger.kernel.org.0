Return-Path: <linux-kselftest+bounces-8495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747738AB7BA
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4A61F21B67
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F3F1465B5;
	Fri, 19 Apr 2024 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0O6iL23/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DDE145332
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570487; cv=none; b=JP7C4P6VjUaEaUHPxm5HSinnbjPpNiVj6qYBiqMiccRTbU6xRI3AyX40opHZzP6vlBEF8abTTDYdPEmASPeynJg5swBlmOUoRDhJgbidAd8GairfSZ0hbt/zGttNs9ZSI1kHujSw3yyTBbFhToNugznz6U87qZgnn5XLUS2uJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570487; c=relaxed/simple;
	bh=+BS7mctHpN9iWLFPEwC2/74zIoWzY97OXSTjHAOIU1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aw80UxjLoe2VWpZRRdFLY3pLjCqWChjMxbcM+LqzyMSRUbg6N3JYOGeiLBpt4I3bQelRVcjzVTZVL0IYP9czqSLUkW+qYglLkfM5VELqIokjaVgCziQbyfEtoDLn0q7dbd11rA4R9lX08op8QHvZ8XpB9KiI5HfamVwQJpVO1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0O6iL23/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e5aa82d1f6so23015635ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570485; x=1714175285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLadZMY/1E+aj61iqE390ie32fUnJXqsMN5cFXtebck=;
        b=0O6iL23/oe+eBGKeMRcBL3gb3aUl9h7Q8dbdGrM2iK3QFSkNNQ/ffKNvsQheHxMRZW
         11eMczk8wu0F2Ltv8hRopaualHCH2usIIDA2fHl3X9lQjOB6RqgQl1fhrQOn50T7lH85
         wYmge7UNBbP93H5hYZHgOsRb/t/EpW8ovXxV3j6Hrutwfei5XWFMj0izTbTPwb78dT/D
         0U4WBgwLGi7glj4uK1DgzKCJXfgLrM0w4zQcir1XwX6UaQbIFWdBZyrAvb18unMMZp/R
         sbSsX/UwssePCJsetUzWp1RcegAK0oh2D46W4TeNe5NDScyiRv9TBSr7bLQzrp8Xzjp8
         NNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570485; x=1714175285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLadZMY/1E+aj61iqE390ie32fUnJXqsMN5cFXtebck=;
        b=fFc0lu0XT7yQ54LtRIJMzSSAlx3Q7Egukj+kbvv4LkWQFD+JmYQHIYpALNHQQyClhy
         AmBvKj0HRFcb7/3mSNOh+BcACWaweObcJGz7VUC+VZh3Y6kMmHhXt6d+C/yHpuBmfU91
         ueBMcdgcyAE/pfvnrT/8IiDbtdRMCbilbOlQHHpn8SQqYmI+xoFRgiRifw8GTkEmLU4s
         blFzQ4R1N6axrt2pKz/L3v5MB6ZwDfzvVF7Fi1xo3qto7WqIhE8OvSrUT72KD5jSVh87
         CJR+B0CisX3htN8Elk4TM/AH/ITF0uz5jaUoj35JBb/3hUkFPT5KwEQkFFah0Vsy9US4
         BxyA==
X-Forwarded-Encrypted: i=1; AJvYcCVDtRW2mHS3auhIteZ+14kq+jRzQqbTLQkSIIiszS2QiNd7lWMM6PG1Gx+w8n4D9s86B5EzaLS1lB5bQhe4ga5/r6H3uiXh/NtxXO+v2WPh
X-Gm-Message-State: AOJu0Yz5WVtTfFU9XUEubQ4dLH/+KzcF5Fcw0E+ZLZH0sYDXwqRsR5UY
	cQIPn+35ipdmkuwR7F3CrDrchWYbKcLOw5jLd7A5V+bcgaKRZHZTuyC77FTR4z0=
X-Google-Smtp-Source: AGHT+IEvBph6MwRCbI7XrCelJMnCCSQbSD7j1tJCROcKUOJKQW1V7Ng3imAkSqKF24OFdFi/RyQiKw==
X-Received: by 2002:a17:902:f544:b0:1e3:f622:f21a with SMTP id h4-20020a170902f54400b001e3f622f21amr10308080plf.24.1713570484830;
        Fri, 19 Apr 2024 16:48:04 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:48:04 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	samuel.holland@sifive.com,
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
Subject: [PATCH v8 11/24] RISC-V: KVM: No need to update the counter value during reset
Date: Sat, 20 Apr 2024 08:17:27 -0700
Message-Id: <20240420151741.962500-12-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
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


