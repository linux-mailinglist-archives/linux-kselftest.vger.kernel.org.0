Return-Path: <linux-kselftest+bounces-7631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22CB8A0482
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 02:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF651C22EC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 00:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E07E6FB5;
	Thu, 11 Apr 2024 00:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qb6VCKE0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325F21105
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 00:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794118; cv=none; b=m1ZrQYnW0gR51juQn8f8u1Noy5+6Ua54lWklQfq5VEH7BA+SUwlBRsaaGYmcXJnZhJftBRUE+zRugrNTcEwvp3l6vn7UmYShLoAj2BIboke0rPsYPz72GixmgNmxuBRUpzz5cZ9uCIGtTK263i181GODl+AfDWzIsQFgHEreeTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794118; c=relaxed/simple;
	bh=+BS7mctHpN9iWLFPEwC2/74zIoWzY97OXSTjHAOIU1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZKC1vZ0fQlMJv0Fzfc+YyPYTyVc1VGIJa4CT6IaMmVds9oIp/0P6YeQU8/dd6isfC19UTATj2FZKxHsWVp8flovQrDRUSEg77C8FVjrSkeQie2a0kLCc4vV6ZJYzgEwVR2RjtQdmVAB4NP5Blbbb6dAsCnWiP0nPLM/vItuZMNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qb6VCKE0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e3f17c6491so35812035ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 17:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794116; x=1713398916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLadZMY/1E+aj61iqE390ie32fUnJXqsMN5cFXtebck=;
        b=qb6VCKE00YMtOknbAUXNkED4zt6DeWc6S20red6fPf+F1MiWv9QhvY3XNigJ/hlgPZ
         SpOWVpj5nlam32LwHkzUtmtd4ZX/j61MNPZTyUELTfEVWg+UJ8lFbuZnXdng3ChiRbT6
         bTWBaEvSHTYbXo3Hj85zRgFLrKvrrCUlMwIrG4eN5rZ/GuEbp5aZeCbmXE3SdDWVB5tA
         Y8WUoH5iD9DZcWp0sn5/ng+V4W3T923PUy5XtWSWYhsrcuXucl8qv4AXY9l5Z+r/PP6k
         eMFp6zcleGBS6tSX++hMI+o1XFUXYMW/mc/wBOnzw/oFKzpDxYETcaFWbLVVTPToIVEv
         xcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794116; x=1713398916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLadZMY/1E+aj61iqE390ie32fUnJXqsMN5cFXtebck=;
        b=FPmMXKg4XeELp506Q8bf1HovijRrXFe0R8Dqsd7lokrIjpeeizkQA9eGvDOVUrFcom
         4n480nRdlEEZZiHP0BR4DIAE0uDmU4pO1yAjHUE9519w05fRBqyqft0Xqn2s+X7Q4E+W
         JqPo8HRI0UgXpWjG0FremZBfVSpT9TvWz1TtXNteFzHym5yiBjeNcfzaULbcD1sBhvI0
         AZLg7ZJL8UlBbal6F6Z5/jj66BE4c4jPXEg0u6RoWvHpZNnVTarqANkhrZw1W0xb3/Cd
         xrNRvtrGt1eyTOG+gozzJCuGIaW9NG8r9cHhzYaWSrpUcHNQckWHJK6bmfVo3/6sB81l
         N5mA==
X-Forwarded-Encrypted: i=1; AJvYcCWFKXL6IcKB1TYOVQrdsrzUBiDIP7m7ihOCCePHOZYr/M3fjvn6VLyFxnxBOOZ3ZhNMArqa4EedY9wuroN2yj0dtDwMRwPJEXBwG9xBj/rU
X-Gm-Message-State: AOJu0Yzm1NCbVtKM2vi0sSE6AprfCXXAFB1HAG0iwTB8BKuj4R1M0qRs
	tI5r3Dyla5HRWvjuTwIE4cZ9zOUlcvQdUoror7gnAi0mOma0LP/ljUs1J+Qmi1k=
X-Google-Smtp-Source: AGHT+IHzUax2ZWhBgUrf+kjl8kX3eFwG3U4ev74//NPfPvOpyLG8kxL1HYpH/nLS8u5KiTb01/SP5A==
X-Received: by 2002:a17:903:48c:b0:1e4:3f8d:12ca with SMTP id jj12-20020a170903048c00b001e43f8d12camr4120344plb.14.1712794116104;
        Wed, 10 Apr 2024 17:08:36 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:35 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
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
Subject: [PATCH v6 11/24] RISC-V: KVM: No need to update the counter value during reset
Date: Wed, 10 Apr 2024 17:07:39 -0700
Message-Id: <20240411000752.955910-12-atishp@rivosinc.com>
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


