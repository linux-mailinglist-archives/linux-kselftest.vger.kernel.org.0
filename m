Return-Path: <linux-kselftest+bounces-49068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F437D29397
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 00:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB7CD302069B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 23:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B74832145B;
	Thu, 15 Jan 2026 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNTD8VKb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF83629B8E6
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519334; cv=none; b=N+AvljwpkxpXf7vyOjnVNMf6fT7cRxPwchClwZZ4wBILaC+ZVFCmLBJIArQbYk+H8PUPqFnVt2jyHUOrJ7LL9ZPN1FUwDNWMVT6myBr736z6bv0GOfhAIDMfgX1eXHnr4ig3oGDrcaCaVGtZ8jv8aUBxRplzF5xgwcdUf1WqL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519334; c=relaxed/simple;
	bh=W1qB9LQBXMeUfzf2Pv2RG2HRtCPQdMLMtOyLJeq5ur4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eXWu8zPCX6//5TAR9QeaU3AYpNHsbKZsUjTTX8i0H2igah9MC+9FyMXWCx2n+dki8m/LXY+u5S09e1frj2qTmN7DaDwdzbdrounBZOHZMrd4NO5x1N1ak5ooKXcLKumo63JyS0+z5Egb5TKZtfluS6IeI6cLhzkmdS0on/zF7cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNTD8VKb; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-81efa628efbso1208947b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 15:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768519332; x=1769124132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mUjBGLWGHTwZbLi39rVIOBV5qrsnmjBUvPK620tiSyQ=;
        b=fNTD8VKbIGkRp+mYxwEb2w5N1bSrDGeENKTvJXE/OOEZsKIKzQ1DfLKvyLlQ6H6Y5n
         yG2RV8YLQgdxZXFoisMxzgbPKkOXj/sptYJrxiqdsGdzYm+OB1ChXUD/NiJZoun/bUhk
         ibiDieqMJZvwXyQR+NUNxHFg5CqRgfjOUJsfGCsrxzm5CY8olarab7YzNd68cuRO9PKv
         zKQSXkhQfoCuepGzwJjBlIEmNuRNuiOzx42hAcRkuJV1FNmXwp49MYcfn4KHH4NB2oCb
         yFlDtnAp5MFg7vCMKDcwHf6iAVq9v8yFg2lRSroGiQkbYjjLRjYZqe+gAoC9MUlYPDRY
         7ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768519332; x=1769124132;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUjBGLWGHTwZbLi39rVIOBV5qrsnmjBUvPK620tiSyQ=;
        b=ODOzZ3MVGxHaFzY4oYvLwg8F/H0uOYPHhdb0DZxw3rWR5niOH7h/KRZzF56GPNL+9o
         EtS1l3+PmYLjH99PxxvTOKId+N3/TwZbVG9Y7hKDu0fRwp/Ti1wzixFiUEcEfq8aK3b7
         P1G+ObmodFTOj1eCbUJ+S2elkYZTCanxHM/BKbqLQyPEFVAlNx+pu3goHbK/rMaUTZ7K
         FUv5BRkTrnWNEQM9ri5suMiBaL0gHfes9NcpfDEURdgQNsOgcaS5GdrHBbaIqTIuDnj1
         r9tLGiHd3JNeJy3KMXAloNQFO2OnDmgE9bkoJeAkLYndrbBhWFK3LsEcaZQzsrhkLssS
         b8rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiSoxB9pKq9sxG4qALtueWofHX4+2Ysbyyz+UPmyDDhNiVdIS6iAbydCAd17jyR4HUywfHLoc0kqZ8M/EckKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeD0wHg+iwQ9qwhmJioKr0PzMR8WHIXGz50KtB0m6F0MCBrGTT
	p1iLFpRDulIOApjJJkvmF18/szl/V010dSt5hD1r5Aa+w4oE2uxu3ceOEGRsEGAydVAd5ZOdhaI
	wcrasXZaDIjphew==
X-Received: from pfst41.prod.google.com ([2002:aa7:8fa9:0:b0:77e:32f7:68cd])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:f8f:b0:81f:473e:e8d8 with SMTP id d2e1a72fcca58-81fa182746emr657554b3a.36.1768519331975;
 Thu, 15 Jan 2026 15:22:11 -0800 (PST)
Date: Thu, 15 Jan 2026 15:21:39 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115232154.3021475-1-jmattson@google.com>
Subject: [PATCH v2 0/8] KVM: x86: nSVM: Improve PAT virtualization
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, KVM's implementation of nested SVM treats the PAT MSR the same
way whether or not nested NPT is enabled: L1 and L2 share a single
PAT. However, the APM specifies that when nested NPT is enabled, the host
(L1) and the guest (L2) should have independent PATs: hPAT for L1 and gPAT
for L2. This patch series implements the architectural specification in
KVM.

The existing PAT MSR (vcpu->arch.pat) is used for hPAT, and the
vmcb02.save.g_pat field is used for gPAT. With nested NPT enabled, guest
accesses to the IA32_PAT MSR are redirected to gPAT, which is stored in
vmcb02->save.g_pat. All other accesses, including userspace accesses via
KVM_{GET,SET}_MSRS, continue to reference hPAT.

The special handling of userspace accesses ensures save/restore forward
compatibility (i.e. resuming a new checkpoint on an older kernel). When an
old kernel restores a checkpoint from a new kernel, the gPAT will be lost,
and L2 will simply use L1's PAT, which is the behavior of the old kernel
anyway.

v1 -> v2:
  Adhere to the architectural specification
  Drop the preservation of vmcb01->g_pat across virtual SMM
  Store the gPAT rather than the hPAT in the nested state (save.g_pat)
  Fix forward compatibility
  Handle backward compatibility when MSRs are restored after nested state
  (setq-default fill-column 75) [Sean]
  Or the KVM_STATE_SVM_VALID_GPAT bit into flags [Sean]
  
Jim Mattson (8):
  KVM: x86: nSVM: Redirect IA32_PAT accesses to either hPAT or gPAT
  KVM: x86: nSVM: Cache g_pat in vmcb_save_area_cached
  KVM: x86: nSVM: Add validity check for vmcb12 g_pat
  KVM: x86: nSVM: Set vmcb02.g_pat correctly for nested NPT
  KVM: x86: nSVM: Save gPAT to vmcb12.g_pat on VMEXIT
  KVM: x86: nSVM: Save/restore gPAT with KVM_{GET,SET}_NESTED_STATE
  KVM: x86: nSVM: Handle restore of legacy nested state
  KVM: selftests: nSVM: Add svm_nested_pat test

 arch/x86/include/uapi/asm/kvm.h               |   3 +
 arch/x86/kvm/svm/nested.c                     |  49 ++-
 arch/x86/kvm/svm/svm.c                        |  39 +-
 arch/x86/kvm/svm/svm.h                        |   7 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/svm_nested_pat_test.c   | 357 ++++++++++++++++++
 6 files changed, 442 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_pat_test.c


base-commit: f62b64b970570c92fe22503b0cdc65be7ce7fc7c
-- 
2.52.0.457.g6b5491de43-goog


