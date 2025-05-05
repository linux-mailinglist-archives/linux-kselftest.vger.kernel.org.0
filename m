Return-Path: <linux-kselftest+bounces-32393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A2FAA9878
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76A5189F04B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5E126B0AB;
	Mon,  5 May 2025 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dq1de9w4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92926A1BB
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461662; cv=none; b=IEHNASd/zIXNZWTdaThS/JxBu8nWT3mKO5eIPYnqzv5XiyNI7EYnLLFn5muHK+wISHKJI24c0LeISAoE+7yC4YkiMo4RWP6UCKN6twv9CFEq2LR+iEYWNzzwJ63aata7dWDUVkvUcWOTbILX3ivbKhAj+OK7YfBbNuYz8Ee+180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461662; c=relaxed/simple;
	bh=tP/Dy38GceNJDf3Zr30G5oxFd5DNpiB2roiPdOIJcEM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mfWGUq5BZuQLVirjslp0Worciyg+f3ywmjIG/oKvmFc7AVP2elZJMirbxVj32LNtttCJELvt9h2gTB37HEZxUv1DiXfryrndASwnLS3VhXA0os7E92sICm1F9hiUNsH0S+2CFyhS1vt4q+kucUoPTLjFGH90f9ILr7oBJx4CUu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dq1de9w4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b1b2fa98c39so4731344a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 09:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746461658; x=1747066458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJagTHHNdVxyDzkTZrB+wizm+z9g6erBUIGhulC+0c0=;
        b=Dq1de9w4Pg5IEbVQ7AXzJAaX/hESIaPjg90O5SF3l8pDliiJs8rWe/u6tsuAracit+
         enRAQfE9EORFZ42ebCyZa/bC3BkD3qJd1OLRJbfQsGNX1Lf2jsi37yU9tsRg0uYDDV9g
         x11w5UrCq29k3EZSL14EV5gjIXw6SNj5/ORvLunUPHvhVR/ATPCRVnKOPUJmbOioPwSi
         t594DaLU7cHR6EtgdIP8I3gfqiNQB61vXIR6jmEMrJT45xYeTEZEH+CaaQ7TPClYXqgp
         lCkuzopDk+YmuIpvS5M/GSSIGAvjIvQbOAkWflbB7G9WX7fbXnytQmFBnALrXvkj11Md
         WxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746461658; x=1747066458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJagTHHNdVxyDzkTZrB+wizm+z9g6erBUIGhulC+0c0=;
        b=ubA+Nxs//RDYjcEOVjDZ46RkJPayugBk4G1/yHtehsRqjPeq+doheTdV7CNWVtLTVA
         4HA9Ao5PovSspGTn4K6jBjP1DvRrdqiD1X1vpFEwQm86/CHmlSWhn45MfsT2/RK3oqzX
         HchabA2tIvLwCShJbycR6VZzq8yXpTPEDJVAxFOa4kCfhpXH2KaYZISkHz/e8GQp/Buw
         +YOlnYvEsLrBIvgp1eiaeH4+dSgi1m0IEUwlBIqLu5CEPrA9yVxO70H/7p0qqkKbzWMo
         Wbi3USBmjdz22senjbsf/hU6Z2tiMJgrr2fT2cCeGAJYIK9DKuyQj4cxLjMFhlI4c9oQ
         f4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9p+jKaYddlpfEl5yvQn1RDhQBE0MPyl+zSg+Rf8l5IVga7oLA2lA0ucsqWK9qegnkcU7zHtmLwLyl42khn58=@vger.kernel.org
X-Gm-Message-State: AOJu0YylnYqXM+m6qS/El6v8oJLmqjgnfpc8ZinkDHgJh2BVvI3Ng5Rv
	g5pKeA5q0HSqRKB6SEIPONPJ0686cU6uNR6ydVl6V2PFLEm4k6eZLgJvfMBbtlQp/050t1Bxk8C
	T3hfWVEdigg==
X-Google-Smtp-Source: AGHT+IHmeuVYVihs7sQ36TEo2hNXWZbWh14KISXEiA150JU3zbOiiYwpdjNYy9bWt46liO2U4UYaoHnwxcbrZQ==
X-Received: from pjbpw4.prod.google.com ([2002:a17:90b:2784:b0:2f8:49ad:406c])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d883:b0:309:eb54:9ea2 with SMTP id 98e67ed59e1d1-30a5ae3f34cmr13505195a91.20.1746461658457;
 Mon, 05 May 2025 09:14:18 -0700 (PDT)
Date: Mon,  5 May 2025 16:14:08 +0000
In-Reply-To: <20250505161412.1926643-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250505161412.1926643-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250505161412.1926643-3-jiaqiyan@google.com>
Subject: [PATCH v1 2/6] KVM: arm64: Set FnV for VCPU when FAR_EL2 is invalid
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
and results in a synchronous external abort (SEA). This means the
faulting guest physical address is unavailable when KVM handles such
SEA in EL2, and FAR_EL2 just holds a garbage value.

In case VMM later asks KVM to synchronously inject a SEA into the
guest, KVM should set FnV bit
- in VCPU's ESR_EL1 to let guest kernel know that FAR_EL1 is invalid
  and holds garbage value
- in VCPU's ESR_EL2 to let nested virtualization know that FAR_EL2
  is invalid and holds garbage value

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
2.49.0.967.g6a0df3ecc3-goog


