Return-Path: <linux-kselftest+bounces-34278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61753ACD761
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 07:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC924177A9B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 05:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BA5263F30;
	Wed,  4 Jun 2025 05:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZpsQ2rd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C400262FC3
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 05:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749013750; cv=none; b=if7ydnAnsns2IZNBp0ubH/MIv/T1oc3AOHNfy6x0x24o328+51+D0XhomVEbDwTSZNAmwFlR+D7L1vGs43oNIC9tfO3c93zvdE+QvGqzf2VTN/WwCgM2waDDDFEhFsfKSsZLRksGLiJcwtQjQtGw4XWcDMtAfXRYLcPayxPODUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749013750; c=relaxed/simple;
	bh=+djBXRGZZ4KS/japPqQxkteXePbiEDHtGk4KYt6B518=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HSFUwFygZZ5qp7OWZQ42FuoB2OlpRSmK0LZfRh+jCxGCfR1vwqJBLQaGMtZolKGa5wsXOPirvjZBeo3KNmIpvePa8xkdHMMwdqNB3GMD6f5qsKoM82PWv1amh2hn6TELodZyOCMPzAt/QC8mFtLMPhd7y17r0cBh9XQwORkNg54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZpsQ2rd; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2f02cd1daeso1248918a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 22:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749013748; x=1749618548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HXtiOD32k+3IRpg7Tl5Q1Nm4vKBBcoEeXUHabwSNFEc=;
        b=aZpsQ2rdXY2M/DO5xgroGh9FlkRp3fC+ZRpjKgqF947j0VsAfMZBqP3uIQOwOZ1Akv
         PasdGXbQXE2FC30LGwraR60z1aXE8dU0GDzyjiVPFmt7zlD/mopPE8n1HyzRIMsvz2gR
         fS0B/EG+2wG/M7a8JtoB+bJN3AO1URYgcbasrBMo390CLtcku9iBXbf37Wpz2Y4ado/B
         7JSbPPQ15gvEslhK90i0OTM2j+r8vMpTkiVi4BU/bz5kopezq6tpJZN/Rk7XYE6J1rJQ
         gsdRPKP+lqzULI98zrIu/5k0bGcBdvhPvhbW/70nu25Wkx6LKq/3r/7a4UavUUAFOAmH
         I14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749013748; x=1749618548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXtiOD32k+3IRpg7Tl5Q1Nm4vKBBcoEeXUHabwSNFEc=;
        b=gaSXAbojCnDV8rF5nmBSLCcUbeFSPEeVpKHGtVbHl/Zlg/Fo8ciqMJIzwDjsJ5I/J5
         jgfhEGW28LRzLqOG0uIZeH8SYQg8TH6vCyYMFBX+IOYOw9jwMNASqYnxwbCK3fKWu65G
         0TAhflb68x0Vo7MFE8FXoqjkJ4TMf96XoOxZMgOzFbLrfjh4QkxQ0R0yk1bDbM5yV0uC
         OTNMgFPeajPaQWjixDY0T7G1GXUWvEokx0p3W4cr+B0y41wb4RauPKGVkx5/Yf0lhOng
         NfXbea6rnvRAj02HMXBZ0UEhW95aVwQybTj2DH0dX/Nl8ZBY6WdGbFrjz6TwOC9mBfjF
         mxYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpBQvXNJIa36gQvercxt5CKHCC2WAFKHrWJiSIbdyqGRVltcQpnrKBw6RpTHYrNDzt0dO+LgVnpvHHHiGg5jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGwhZXkRgpqBUXxjsut9rqiXTle6O8t/H0NKA/dTvy8tOlNGYO
	XAu7JIYrPUrkHeTcVji1MF7p9724obqi4TlNaz/eM5ijGMJKZpYZ0q7seH+V1/wDWMa4BNY13KM
	rD3lkpRy9zhzJvA==
X-Google-Smtp-Source: AGHT+IE0yG+wVldA+Ut+AEkkDvhjuf8f2LJxfg7qHFUSl5PI3nGJnDA82B1khwNucVOGJtMX8A10UmFpgQtpEg==
X-Received: from pjh4.prod.google.com ([2002:a17:90b:3f84:b0:311:9b25:8e87])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:28c7:b0:312:e731:5a6b with SMTP id 98e67ed59e1d1-3130cdfb38dmr1864793a91.32.1749013747721;
 Tue, 03 Jun 2025 22:09:07 -0700 (PDT)
Date: Wed,  4 Jun 2025 05:08:57 +0000
In-Reply-To: <20250604050902.3944054-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604050902.3944054-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604050902.3944054-3-jiaqiyan@google.com>
Subject: [PATCH v2 2/6] KVM: arm64: Set FnV for VCPU when FAR_EL2 is invalid
From: Jiaqi Yan <jiaqiyan@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	duenwen@google.com, rananta@google.com, jthoughton@google.com, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Certain microarchitectures (e.g. Neoverse V2) do not keep track of
the faulting address for a memory load that consumes poisoned data
and results in a synchronous external abort (SEA). IOW, both
FAR_EL2 register and kvm_vcpu_get_hfar holds a garbage value.

In case VMM later totally relies on KVM to synchronously inject a
SEA into the guest, KVM should set FnV bit in VCPU's
- ESR_EL1 to let guest kernel know FAR_EL1 is invalid
- ESR_EL2 to let nested virtualization know FAR_EL2 is invalid

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 arch/arm64/kvm/inject_fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index a640e839848e6..b4f9a09952ead 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -81,6 +81,9 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
 	if (!is_iabt)
 		esr |= ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
 
+	if (!kvm_vcpu_sea_far_valid(vcpu))
+		esr |= ESR_ELx_FnV;
+
 	esr |= ESR_ELx_FSC_EXTABT;
 
 	if (match_target_el(vcpu, unpack_vcpu_flag(EXCEPT_AA64_EL1_SYNC))) {
-- 
2.49.0.1266.g31b7d2e469-goog


