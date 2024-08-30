Return-Path: <linux-kselftest+bounces-16753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4993C96554B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 04:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9ED21F24333
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 02:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E5A4D8CB;
	Fri, 30 Aug 2024 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfF9H34v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B738DD6
	for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985420; cv=none; b=KJt9k4HV1Z0V93xfLsVdY4M4s3GY9xU3jNQ57Trs0nGOk8FK5s6ObBzwP5x3dznR1BMVCLDZTCRB71Ojkwl5GZqcpwekwf/E9WVWrWjQ9u7rjaVMinZ0FrIXOY8JhoQIkahSiXIPxp6ZCKvSIcvUnIYYTJXZRUjE8xpUJAuDr74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985420; c=relaxed/simple;
	bh=fM1UXiA75lC0t62D2dla1o8lILo9Q8CRSahRviWi5ew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oVkTWVxcyYYKEDeB6yiTHRdRFxRffJt9+7ezigq/vDBYBvFlFQ2zJbAhl/Ydv0A9SbY3PXgnrtOTsN6iTVpQZ3t/l+wO/LJz+SjWDJEETvoWzoKfLVLz1Vxn8rjdxmNWs1MIovXWSPN05VJoykaEF1KLwrkw8+9Zbafcf1qopIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfF9H34v; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7cd9ac1fa89so1228866a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 19:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724985418; x=1725590218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VD3hQvDktv/EfnTYCms5ZPCRMMvQU2Cc7a/RkZOAue0=;
        b=SfF9H34vOIFf8JUJwMvAfOVu3Jekf8PvLLDe5I5ww29wYnZDFIMywUogFIh30dwcpp
         B81/UrJ4Rq4p1Jk15jKc4WV2hfUYTNXiYoIpuXv+Q+UhNYEIFlEsCW92ZZJTuKTIpumq
         jDemMUDuHwE9ff7p3RDE/mPTlbUgbHZvnGIMTwrYSmvado93KtUd3zDbJp83SbjKlaO8
         z1s8GSxgs6WNZxszsxOEKLQOCjLhc6VZR1h8eq3izjYVDTLIuj3XuG162eXp3EqOSfiV
         R7CY7oli1MM4suBl2IdPSjdR7+oEw62gZbZCbYSQARpIODcajSri8lIFhRLydPaIQtf5
         613A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724985418; x=1725590218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VD3hQvDktv/EfnTYCms5ZPCRMMvQU2Cc7a/RkZOAue0=;
        b=ttDJFKqCHXSlI0K/EnVcBusMNl71Gkv5I9Ej2VTLW1vhziFfPtFpGNoLFqLKHF42zs
         61i6Hk5hJ8fSWGHYx0O8fCp7LmdSGRZQKL22kqnPZ/uPanG/C7uCq5KCl1dHn7q5dcc3
         idSq0RbveIVgUwMZT8qXMH/4i4L4rL9Z53dl/Udf52921FTjKHw2cvhqaJ74pYRQgrhY
         dwBKQ1RPSkZb9Cp5B/OfLOIG/sJzFYRQ9rFvoTwuOfcUjzVSekWVhMhjKqR9n7CJ/E7U
         vgPvmOZ6MZ2mu842KF1VAU6Stdkm8RpWlSu9xEoKbY0+1BdijCjd/iiu+P67kis6AyH4
         Okgg==
X-Forwarded-Encrypted: i=1; AJvYcCWeK3mL9CC2DdH42mOdW/lrH9GTWGOJ/v8OPwU0vw5V3SLgwwASsOFqWW1Al/jF/Xozu8+p26BegOEtjwpGfgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6VST9xmufF0DYc+LId3k2uux7f2GrkXaZD4BNl1HmIHXO9qsl
	5tk9cTQvTE/Ct9axW2hfWaLtc+w+BGn0LjAbWQhtOBasUD8OQAPOF0Liu2NuHX734F5FLrvWS+d
	qrw==
X-Google-Smtp-Source: AGHT+IH+k6HDIiN1o48889VDXAYhz766twpv53PBiB56DU6qPBsCvgJbnTcPhbmOP8hjIhMw1MR9kn8C2m4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f906:b0:201:cd7c:c0da with SMTP id
 d9443c01a7336-20527f74b42mr271205ad.6.1724985417882; Thu, 29 Aug 2024
 19:36:57 -0700 (PDT)
Date: Thu, 29 Aug 2024 19:36:56 -0700
In-Reply-To: <20240709182936.146487-1-pgonda@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709182936.146487-1-pgonda@google.com>
Message-ID: <ZtEwSOzeAEuzpLpy@google.com>
Subject: Re: [PATCH] KVM: selftests: Add SEV-ES shutdown test
From: Sean Christopherson <seanjc@google.com>
To: Peter Gonda <pgonda@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Alper Gun <alpergun@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 09, 2024, Peter Gonda wrote:
> Regression test for ae20eef5 ("KVM: SVM: Update SEV-ES shutdown intercepts
> with more metadata"). Test confirms userspace is correctly indicated of
> a guest shutdown not previous behavior of an EINVAL from KVM_RUN.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Alper Gun <alpergun@google.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Peter Gonda <pgonda@google.com>
> 
> ---
>  .../selftests/kvm/x86_64/sev_smoke_test.c     | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> index 7c70c0da4fb74..04f24d5f09877 100644
> --- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> @@ -160,6 +160,30 @@ static void test_sev(void *guest_code, uint64_t policy)
>  	kvm_vm_free(vm);
>  }
>  
> +static void guest_shutdown_code(void)
> +{
> +	__asm__ __volatile__("ud2");

Heh, this passes by dumb luck, not because the #UD itself causes a SHUTDOWN.  It
_looks_ like the #UD causes a shutdown, because KVM will always see the original
guest RIP, but the shutdown actually occurs somewhere in the ucall_assert() in
route_exception().

Now that x86 selftests install an IDT and exception handlers by default, it's
actually quite hard to induce shutdown.  Ok, not "hard", but it requires more
work than simply generating a #UD.

I'll add this as fixup when applying:

diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 04f24d5f0987..2e9197eb1652 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -162,6 +162,12 @@ static void test_sev(void *guest_code, uint64_t policy)
 
 static void guest_shutdown_code(void)
 {
+       struct desc_ptr idt;
+
+       /* Clobber the IDT so that #UD is guaranteed to trigger SHUTDOWN. */
+       memset(&idt, 0, sizeof(idt));
+       __asm__ __volatile__("lidt %0" :: "m"(idt));
+
        __asm__ __volatile__("ud2");
 }

