Return-Path: <linux-kselftest+bounces-13685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 244C492FE78
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 18:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF54F1F23AFB
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4CF17557C;
	Fri, 12 Jul 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0762GMVx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AC716F8F5
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720801671; cv=none; b=XIOZCMKab396WPheQc+HXwX4CLr3EvXjcPSHj485nRf/OEbG1enaItw65Nmi/ich0BfdiH0fTahEEDc8ZTKM/aqVvrxTVKjIp3JbFYXnicm05oQxyRg3FhFd0zUWhi3aPJpQDuA7I6cW1Kf+KpA2fM+Oux4hZ0pjumTQ/vrwBu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720801671; c=relaxed/simple;
	bh=qwr8oCZNV/KmUE+KTkQdbZ4A96F4ooAb3w3bj6Z7kBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tpp75LfQg6aOXQA+pVAww600W24GrbdfZt/qcLmnNaVjGn8gjVzlD570s7p0ZC7A6wOpmJcmAsfkBWb6KIJ4VCJgYJBiMuBAL8xN7mk+hJRWbOb03qV1G3uMCNeE1s4hkT8OBnmGl45jc2ro+ry2FeygzYOolKKJIE6ZIhfW9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0762GMVx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c96e73c886so1921530a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2024 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720801669; x=1721406469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wEYr9JA8qEfnEiiFVxdx0TK1LeJE+9gMywwztiTkPVc=;
        b=0762GMVx/dDBDmRsp4aAYeGY/VnLjuoMlkFevxfmJS+HX2N6PUR9Qdh1voUJzjR3Mk
         BQOIb+KUSFci8ZR1cmeYYJ8mWjGChj4DWGx5PvEPxAOKHBc1bFVeSaGqHKcIhvdO3Q6E
         wi+T9Mnz5jSO7YpcX9/1yKQzZMAiotJ4zDsfEmIxV/2/3MNG8+RRsOBExNmcyX1TjPw5
         MUr5rom2OJVi2PaSAcnDyOwSMVkLYNuf5UU+a5nGO98qw5SaGkZDFr5wlG31VR14qBBJ
         xrG6oH+Ykt3zpvqnkJjvIo0dZrknYhSdjAJEpegQVWwb86WQZsC+Qevt6q98JWXprX3M
         6LZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720801669; x=1721406469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEYr9JA8qEfnEiiFVxdx0TK1LeJE+9gMywwztiTkPVc=;
        b=wFSKPvp+7chBk8fV1YhMxYMDwL4dqAODhT5hPEZ+j/zC3PftsfTTrdgbZJ1UJprg3u
         ZEBJ183TjpE0ampwHCBoYPGKeiSPczr8eqnpImVymtJcJ7dco7xpViL5Bgw+ZuLQspdZ
         NFqr14TK5y/191/jJW6Et5zLheYepUuwCBmbHRSN6mdvX5POGqGB7xdwm1sqxxUXlRej
         rZmLi+WygO8NvFzlR8GmwhpFNvuPVXXJSf4ebDQ088lAXKfSL2nFh9BrzCnbNWIkzjDx
         YJ3PtvD35IVOBa8wUMY9oRrFDW6MNJDGWmRjHWy56XL8i6kRJHwid8RbPy5XCQ5/tJyf
         XgIg==
X-Forwarded-Encrypted: i=1; AJvYcCUYrGVlPTXTHrJoC0stE0hND8xaIg80D2+6cdq2CjplSxyUcQW4jxlw/IMJYQKC+EGNwu681bhOsjbJGwjuVPP1lhrrlAh0NslfIvMpxTF7
X-Gm-Message-State: AOJu0YxO68tSojOsJ6JhKwCP4yFBPIlxz8TaeiwyQc8P0M27myVPmOcZ
	6rsY8+et7ANxFIe8Eu/9Z3TmXUTZaeXHyLTv9SyAZ7zZbA5RmW327VJj0MEmmODof75ScHnAolO
	JUw==
X-Google-Smtp-Source: AGHT+IExMjSzRoFzJZULA3iZrj2G4RD4SsmatrlRYdXUdzDN8jkO4bSuFKvy2f442Y3Vs24dL56BOimEEwQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:257:b0:2c9:a168:9719 with SMTP id
 98e67ed59e1d1-2ca35d4ea2bmr27995a91.6.1720801669355; Fri, 12 Jul 2024
 09:27:49 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:27:47 -0700
In-Reply-To: <SA1PR11MB67341A4D3E4D11DAE8AF6D2EA8A62@SA1PR11MB6734.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-10-xin3.li@intel.com>
 <ZmoYvcbFBPJ5ARma@google.com> <SA1PR11MB67348BD07CCCF8D52FCAC8FEA8A42@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZpFH86n_YY5ModwK@google.com> <SA1PR11MB67341A4D3E4D11DAE8AF6D2EA8A62@SA1PR11MB6734.namprd11.prod.outlook.com>
Message-ID: <ZpFZg-9MTveHfn_4@google.com>
Subject: Re: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and guest
From: Sean Christopherson <seanjc@google.com>
To: Xin3 Li <xin3.li@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	Ravi V Shankar <ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 12, 2024, Xin3 Li wrote:
> > > > > Switch MSR_IA32_FRED_RSP0 between host and guest in
> > Alternatively, is the desired RSP0 value tracked anywhere other than the MSR?
> 
> Yes, It's simply "(unsigned long)task_stack_page(task) + THREAD_SIZE".
> 
> > E.g. if it's somewhere in task_struct, then kvm_on_user_return() would restore
> > the current task's desired RSP0.
> 
> So you're suggesting to extend the framework to allow per task constants?

Yeah, or more likely, special case MSR_IA32_FRED_RSP0.  If KVM didn't already
have the user return framework, I wouldn't suggest this as I doubt avoiding WRMSR
when switching between vCPU tasks will be very meaningful, but it's easy to handle
FRED_RSP0, so why not.

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1783986d8626..ebecb205e5de 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -352,6 +352,7 @@ static void kvm_on_user_return(struct user_return_notifier *urn)
                = container_of(urn, struct kvm_user_return_msrs, urn);
        struct kvm_user_return_msr_values *values;
        unsigned long flags;
+       u64 host_val;
 
        /*
         * Disabling irqs at this point since the following code could be
@@ -365,9 +366,15 @@ static void kvm_on_user_return(struct user_return_notifier *urn)
        local_irq_restore(flags);
        for (slot = 0; slot < kvm_nr_uret_msrs; ++slot) {
                values = &msrs->values[slot];
-               if (values->host != values->curr) {
-                       wrmsrl(kvm_uret_msrs_list[slot], values->host);
-                       values->curr = values->host;
+
+               if (kvm_uret_msrs_list[slot] == MSR_IA32_FRED_RSP0)
+                       host_val = get_current_fred_rsp0();
+               else
+                       host_val = values->host;
+
+               if (host_val != values->curr) {
+                       wrmsrl(kvm_uret_msrs_list[slot], host_val);
+                       values->curr = host_val;
                }
        }
 }

