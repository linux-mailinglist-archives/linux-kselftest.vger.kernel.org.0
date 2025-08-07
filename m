Return-Path: <linux-kselftest+bounces-38502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9496BB1DDE0
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2734A0145E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47274274B58;
	Thu,  7 Aug 2025 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZmFzrer6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36FC274B36
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597810; cv=none; b=uLo5ZDuCAOk45ryP2waumYpPbR4+9UvYvkeEfzOdI27+69JGrIFWNMBWPxdhpjsxgn9MBZVTMfxofXl86lEo8qIWXRJteKt1llg7SkTzpYGKeZDkXXNmYaz6UGv3V17Rs2uDdV6EpzsMsmZ0ktdYe+TAdBvwnqj0AW8/SyaXIek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597810; c=relaxed/simple;
	bh=qZKtRz7nLG2KF7a1TIq9CkaKwIyQfE7M1cz+YMT0C3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A/tNeH8PNlzLj9qC3fkh2JY7RCD5r5xPLleko9OT7KAxH8GA8AfRhqBezJPyw7RsPIv0MZtNe0NmHWcCGBxAqaQURpP1XlWfkkrHYJg+UgNPXAwhjEx0K4rMpNb1+y8ORqVdOSXRh47+/Hz/MCHmEjZf2yOlml4ZGPLG6wikFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZmFzrer6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31ea10f801aso2808169a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597808; x=1755202608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ok7xE/zvSsxm3sMvm91OXvNKe4HIqd8wijh5DP/BfeQ=;
        b=ZmFzrer6tnf89eTHTYtDDmcOlwC7JhRsg5azmqe4vedhD8IK8/8xH8c0LpvUyRz2FP
         Px+K7U0iwI+S6WRFc/QpANy4QUbrsEzv6B7O+0RW+Uq/B5LOH+BHY80oxhwWtlSmi8VU
         sZKvt8OHddPO7glc0yzKco2t3IyQAsC7/3ZemZ2uWFRc6PXIhXF7NbIKNX+T+7bBtqWL
         hQkLTWD51D5726zXEfrOPw4wdNlIUX69hH7MeZ9XzUo74n0sPoueRnlLeFtoisDGK/aC
         105Z+YEmorV9kn+DuV1+CfrnjJqHc3NcnG7QPhkIDBQeytX6mYePVjUaF2YE26mTXqEQ
         vsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597808; x=1755202608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ok7xE/zvSsxm3sMvm91OXvNKe4HIqd8wijh5DP/BfeQ=;
        b=VZ5LRFyoOaVC9+gWy7XPwyiv7NLZblzN6MWCDNy9744BaIgfpzWOTU2BorNicHaWna
         mFRdofnbhmdWTdt4zF0tf3hVcrCHxkKMRfIfmGvMlxv9Gih3wd4mBXlD8Jiog+wqBPXF
         RfeXtdmI1r744K0Ut3B7ua7Xn+56/svu8c1IsbPHiPGWIZZpLjZMYP59uJN/PEmbvxh3
         RzldOOIqly8nkW0PlzNvqlpLQGvmPl2u0inba+YpWWdaqikJLQgb5O8/Cqp2kOJgSI/J
         nE5to58YH3sshmfSC1Smo/4HbfqHeBNiZDH+pHmlIx+dZ1+ad31SwjI4F9WJ8LGB3ZLa
         Ol3g==
X-Gm-Message-State: AOJu0Yzb2TLna52fBgXDfO/3H50oRf/Mwavp+0sL6itmIXdbawwuhJDr
	++vYWBPVjdEhqshBfrFviOLl/3RKxyc4NjiBLRnmjlLds4esX6QfC27O0nPWGa+UxTWsX2tIoc3
	j5eWWyZCZyrYgbjYf18i0mzzyKaxKnFL7xWnQtFfVjtf05apV+6fH82QKGGPNB9z4ACf2XRp2u3
	L6drJo4vTAqSDuVojo625WUURR/Q7EpF79avwcsW8nMbw=
X-Google-Smtp-Source: AGHT+IEOPFXTvjzpu+YcxLn8CBY9Lmh8oefZR6eapvpl0ypNZ8CQQQCwseoJbEg4jHcPbgbjKqwF/k3k4w==
X-Received: from pjnx5.prod.google.com ([2002:a17:90a:8a85:b0:31f:335d:342d])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d89:b0:321:2160:bf76
 with SMTP id 98e67ed59e1d1-32183e6d8b9mr392794a91.25.1754597808002; Thu, 07
 Aug 2025 13:16:48 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:03 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-8-sagis@google.com>
Subject: [PATCH v8 07/30] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
 validate TDs' attribute configuration
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

This also exercises the KVM_TDX_CAPABILITIES ioctl.

Suggested-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/lib/x86/tdx/tdx_util.c        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 392d6272d17e..bb074af4a476 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -140,6 +140,21 @@ static void tdx_apply_cpuid_restrictions(struct kvm_cpuid2 *cpuid_data)
 	}
 }
 
+static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attributes)
+{
+	struct kvm_tdx_capabilities *tdx_cap;
+
+	tdx_cap = tdx_read_capabilities(vm);
+
+	/* TDX spec: any bits 0 in supported_attrs must be 0 in attributes */
+	TEST_ASSERT_EQ(attributes & ~tdx_cap->supported_attrs, 0);
+
+	/* TDX spec: any bits 1 in attributes must be 1 in supported_attrs */
+	TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes);
+
+	free(tdx_cap);
+}
+
 #define KVM_MAX_CPUID_ENTRIES 256
 
 #define CPUID_EXT_VMX			BIT(5)
@@ -256,6 +271,8 @@ static void tdx_td_init(struct kvm_vm *vm, uint64_t attributes)
 	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
 	free(cpuid);
 
+	tdx_check_attributes(vm, attributes);
+
 	init_vm->attributes = attributes;
 
 	tdx_apply_cpuid_restrictions(&init_vm->cpuid);
-- 
2.51.0.rc0.155.g4a0f42376b-goog


