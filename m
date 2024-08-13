Return-Path: <linux-kselftest+bounces-15237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B68D9509FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 18:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7291C2231A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 16:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EDE1A08C2;
	Tue, 13 Aug 2024 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DV1nYA4P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C561FCF
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565997; cv=none; b=QwzN4cPAjqooCClhwp8VFB+9BXkgNxzc6MWZdT+eAU26F2RStfHUrtKROV3MyqE08uU6xzszuyaz330Vt6EbqMOv8DtolTe/IHMOtUV9URG+cs6qrIuIbTqSN7ZsdOqKub4Iqz4s8Qw4+XP0OQchQhsz84LZI42usGcFtN1mds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565997; c=relaxed/simple;
	bh=fwvtbPRrnhU9JDW6k7vFkywZk1R1B9bgqmZPfUzSZfE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q3ZaWfXciERcK6v3RinaWzeh5H4gxmAjzgqHxcnpCKVXNxfZJEYNBKdwnDUPyMrCX6juIn4c7qrgKy+1kvHZb4oSXiY3gpUQHtPmQIhyIhjyiDIg+VbI3A3r7EZgpauqPa7O17CMCBmr55i6clYsOQUBpjm5Zj8AbkYavppKGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DV1nYA4P; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2cb51290896so6020502a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723565995; x=1724170795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jxbzQRkRTBS9epafRwyVqalVAhDx8HH/aK+YY0S1gVc=;
        b=DV1nYA4Poxp6VSTJJJKQq83jH7Uye6saIhg+drfR0Vv2dEiPMCoJVF4Vprgj+1tWRq
         6FKhzesOJslhIXPoheJ69RNysPoe0+o+/skUrDanAmI0J3DAOK9Xe9Y/6ui1Kx0xqPv4
         G6xAyP4wg+hzv0ZFGaYIeGjuXzo0uMFL18NJDlVocbxDVTHirGSUR4YHHq3P5XqL9gsn
         lwMCecDk1cGYvlzhDn9VyR/XgbIPIjZ9SsP/p7lfUluV19I34IYJXut+jy3DmAcFm81c
         7MQrO/5SlbhqQVmeqFqn82vhYxZTna176n1uXOVGXxMdJoHnfkbpMad/JH213LrrbUkv
         pxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723565995; x=1724170795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxbzQRkRTBS9epafRwyVqalVAhDx8HH/aK+YY0S1gVc=;
        b=nYjLE+uC4WRSJYJoaRGjRBB4lmo5bqJlHdsf7nomb6ZUBsblK5+qhS/yPM702WU3w7
         To9iRZmrmUn4MUN9eGQ0gXty3kqY3UbyEY7ZVHAeJn1UDR+4m2cKf3eelnocG7tUMYhI
         9eTsZB6l4TvPNnPgN4FikR34F+tfzHNgrPIw3TpYZL9rl7uwuUpgs7JvpcYe/TNgyVIL
         tzJTBv7Iw5lw4UKTJrw0QY9FwyMhy/50Hm9J6czw0mqt71AtR4XYKy/W3ESORAShsu1m
         +sA3Z3q7v1iJUa/EjoZwWne+oar5hiSnwfFsb0tvCT4EeabK6sO8pH4vLhuxvZ4Hc6SK
         ORBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXHPLv5vLDfVc8PaHKfUIP3fTuOXtld3gxxsAREKy/X5P38q3kxyeFfKedEs2974kFM/Y20Q5HTSIAZ5qR8tFFx1yPUNMc7AY7Kzc8RfqS
X-Gm-Message-State: AOJu0YzgOU07g+zCdmKqrWq2PKOM5qMDpTNTggqX3spvEstnyRDaji0M
	3yvobMe6jAs2vBzDNUBONU9ozUhBJY8frfLELbAApTWnN8PGLnSlii+YU1BK00ahYU8R7zjaVcx
	9hg==
X-Google-Smtp-Source: AGHT+IHJOBYOGLfOsSIj1L4isKWLN1SiBNX/UssBmCLYnWNSmeqqNHiquUNhnOOFmY/z8a8nbvIuqL+5sOI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e10a:b0:2cf:deef:4261 with SMTP id
 98e67ed59e1d1-2d39269b500mr16432a91.7.1723565994916; Tue, 13 Aug 2024
 09:19:54 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:19:53 -0700
In-Reply-To: <009cbe00-dfc3-4a94-b6ab-9d6ec9605473@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528041926.3989-1-manali.shukla@amd.com> <CABgObfbz5kZZObu9dO=KPu8_mZvGmV1752SQzQckkrj5jPaTQg@mail.gmail.com>
 <009cbe00-dfc3-4a94-b6ab-9d6ec9605473@amd.com>
Message-ID: <ZruHqe4in12RnNuf@google.com>
Subject: Re: [PATCH v3 0/5] Add support for the Idle HLT intercept feature
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, nikunj@amd.com, 
	thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de, 
	ajones@ventanamicro.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 04, 2024, Manali Shukla wrote:
> On 5/28/2024 3:52 PM, Paolo Bonzini wrote:
> > Does this have an effect on the number of vmexits for KVM, unless AVIC
> > is enabled?

Ah, I suspect it will (as Manali's trace shows), because KVM will pend a V_INTR
(V_IRQ in KVM's world) in order to detect the interrupt window.  And while KVM
will still exit on the V_INTR, it'll avoid an exit on HLT.

Of course, we could (should?) address that in KVM by clearing the V_INTR (and its
intercept) when there are no pending, injectable IRQs at the end of
kvm_check_and_inject_events().  VMX would benefit from that change as well.

I think it's just this?  Because enabling an IRQ window for userspace happens
after this.

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index af6c8cf6a37a..373c850cc325 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10556,9 +10556,11 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
                                WARN_ON(kvm_x86_call(interrupt_allowed)(vcpu, true) < 0);
                        }
                }
-               if (kvm_cpu_has_injectable_intr(vcpu))
-                       kvm_x86_call(enable_irq_window)(vcpu);
        }
+       if (kvm_cpu_has_injectable_intr(vcpu))
+               kvm_x86_call(enable_irq_window)(vcpu);
+       else
+               kvm_x86_call(disable_irq_window)(vcpu);
 
        if (is_guest_mode(vcpu) &&
            kvm_x86_ops.nested_ops->has_events &&


> Snippet of the Test case:
> +static void idle_hlt_test(void)
> +{
> +       x = 0;
> +       cli();
> +       apic_self_ipi(IPI_TEST_VECTOR);
> +       safe_halt();
> +       if (x != 1) printf("%d", x);
> +}

This isn't very representative of real world behavior.  In practice, the window
for a wake event to arrive between CLI and STI;HLT is quite small, i.e. having a
V_INTR (or V_NMI) pending when HLT is executed is fairly uncommon.

A more compelling benchmark would be something like a netperf latency test.

I honestly don't know how high of a bar we should set for this feature.  On one
hand, it's a tiny amount of enabling.  On the other hand, it would be extremely
unfortunate if this somehow caused latency/throughput regressions, which seems
highly improbably, but never say never...

