Return-Path: <linux-kselftest+bounces-8201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A9A8A7395
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 20:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CC91C21205
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCAA13C660;
	Tue, 16 Apr 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uwv+EDie"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2556713BC3E
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293100; cv=none; b=BW7Nb7eVliwrKsB0HXxYayMnN87+94JNFLoBDUEi8leRi1IXmtZQ7YlXuxYkdAKMe4ohb7Rl4dghXJ05r8OZivcu21Ha5g9rK3cWki6RthcUdQmNf/z3CKjcFgdixvfdvWB2e7vV25VT8rDOQvj3tv+995QQZFi1+YNmfCzRWt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293100; c=relaxed/simple;
	bh=HvWaHaPle0cX5HGWWdRxWlP3z/kNux1E5mFj4+zTNsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CXxjKQRyJSqIOsKzcMzHbW2/QfNzn5mDHrp1AqhJbUA+Slv2EaU5aFZbpj/sl70cy8+G1+5ilfe41vPEiDq1PNZZ6WUg0+SZpHGCm5hzrMX83W4fwvg9Qv3fI9V2tgMxGftBHCd1CTZKNow8G4rv7OgpfQ233Yt0zxiR/PrnVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uwv+EDie; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so42405a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293098; x=1713897898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIyaUvQe1Xat3Gv2wtXts1DoFv5C5UbopqhCGzslRuw=;
        b=uwv+EDieKboPbOwWiDwdhRbXg7c0dcf8L1d3kGCh1KQxmNFS3pimdpkt7E3fRK7oHT
         UQDy1cSjhdO1OnRPJ1WGU1ps0v6K5DigP46KbJjM7iFfKPb0VoV6OBMtkm051d1dTmU4
         i48UIXlCtaFM5cEiNT5tPZ7Q+8zPUD02ts+hEiSwWZV7/cG1hh4qji3oWLOjmFwz21vc
         1yThUUZpyupoSdF6GPay095r8TrqZ36xiPGrZzFQvjGGdpCEFQW1m8VaIL0+c/kiQLg4
         oY90FBElHk6mCclvcNPs777IyBL3fby9f2kyXvSdQenj0WKVX18TTLxjjuhi8IY1o3ly
         xWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293098; x=1713897898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIyaUvQe1Xat3Gv2wtXts1DoFv5C5UbopqhCGzslRuw=;
        b=jp/X/UMeEbH0jmFskRWgR4pGFwqvd2B/cdFN8RbwYhzo5cjRclQ8VQouDaNi/DLE6H
         PY//rrFkoPMXSsQNtnE8sIucmMeOQiEqTRZhxZpOZJzXWPt6OwKwePWcEQVucXYf+g4f
         xeiGk7RX2Z176/RtFOL9KOd6sZTN/SYk1+OZnUGolPH2Fz56jbuuiInEnM9J8ZhqGJZ/
         e6nvsGsc4578wY63p+c4+VpPA2FZb9g1Sg87LHW45oeeQx7AxX/2urRNWIZ2IQDzuWDs
         xSvFTmlWuwxAchK1+q44WV4XWgPLzjrixD2yVRKTuIiwq01l0emEiYx194NfV7A7pKYG
         pTHA==
X-Forwarded-Encrypted: i=1; AJvYcCWJMbBCItjee88L2w5w3epTc1Nqn52slVI61W7kJmjrQqn9S2T+zQYUJmZamZ2nJOqXY34vomjQxMtZeq45ZDqsv72xcWndkuesLvFZGVqK
X-Gm-Message-State: AOJu0YxElR0fmEALnROIzmm0apq57AT1ue90va21f1dziOO6KyrTX+T8
	3qKvEvYkuSvE4SYaVggAxn3p7ynXY1Vk85cN1bIHhtDdsl6bvuhut5M62DhvKOo=
X-Google-Smtp-Source: AGHT+IE5BlMcsvz+u+Gj/J8AqEIUfsDQO0SrpH7rjTE2a3GSrJYPJFMfaRQ3pXJt55L3OJ7SLgYUVQ==
X-Received: by 2002:a17:90a:db42:b0:2aa:c389:c9f0 with SMTP id u2-20020a17090adb4200b002aac389c9f0mr2914939pjx.12.1713293098421;
        Tue, 16 Apr 2024 11:44:58 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:58 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
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
Subject: [PATCH v7 12/24] RISC-V: KVM: No need to exit to the user space if perf event failed
Date: Tue, 16 Apr 2024 11:44:09 -0700
Message-Id: <20240416184421.3693802-13-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we return a linux error code if creating a perf event failed
in kvm. That shouldn't be necessary as guest can continue to operate
without perf profiling or profiling with firmware counters.

Return appropriate SBI error code to indicate that PMU configuration
failed. An error message in kvm already describes the reason for failure.

Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c     | 14 +++++++++-----
 arch/riscv/kvm/vcpu_sbi_pmu.c |  6 +++---
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index b5159ce4592d..2d9929bbc2c8 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -229,8 +229,9 @@ static int kvm_pmu_validate_counter_mask(struct kvm_pmu *kvpmu, unsigned long ct
 	return 0;
 }
 
-static int kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_attr *attr,
-				     unsigned long flags, unsigned long eidx, unsigned long evtdata)
+static long kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_attr *attr,
+				      unsigned long flags, unsigned long eidx,
+				      unsigned long evtdata)
 {
 	struct perf_event *event;
 
@@ -454,7 +455,8 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 				     unsigned long eidx, u64 evtdata,
 				     struct kvm_vcpu_sbi_return *retdata)
 {
-	int ctr_idx, ret, sbiret = 0;
+	int ctr_idx, sbiret = 0;
+	long ret;
 	bool is_fevent;
 	unsigned long event_code;
 	u32 etype = kvm_pmu_get_perf_event_type(eidx);
@@ -513,8 +515,10 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 			kvpmu->fw_event[event_code].started = true;
 	} else {
 		ret = kvm_pmu_create_perf_event(pmc, &attr, flags, eidx, evtdata);
-		if (ret)
-			return ret;
+		if (ret) {
+			sbiret = SBI_ERR_NOT_SUPPORTED;
+			goto out;
+		}
 	}
 
 	set_bit(ctr_idx, kvpmu->pmc_in_use);
diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
index 7eca72df2cbd..e1633606c98b 100644
--- a/arch/riscv/kvm/vcpu_sbi_pmu.c
+++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
@@ -42,9 +42,9 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 #endif
 		/*
 		 * This can fail if perf core framework fails to create an event.
-		 * Forward the error to userspace because it's an error which
-		 * happened within the host kernel. The other option would be
-		 * to convert to an SBI error and forward to the guest.
+		 * No need to forward the error to userspace and exit the guest.
+		 * The operation can continue without profiling. Forward the
+		 * appropriate SBI error to the guest.
 		 */
 		ret = kvm_riscv_vcpu_pmu_ctr_cfg_match(vcpu, cp->a0, cp->a1,
 						       cp->a2, cp->a3, temp, retdata);
-- 
2.34.1


