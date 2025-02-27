Return-Path: <linux-kselftest+bounces-27784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C04B1A48498
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 17:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746DF3BB63F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A591D9A48;
	Thu, 27 Feb 2025 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xI/qwobT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90A1D9320
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672678; cv=none; b=Es2RY3e/kkoNFG9KdCIkPQU7Sh8IbGaLiSgVziT0a4zhgbr2ejgi68HgKEukROqweJL1Rf4et4NEy5tHfix4xyuv6Yw4mL5EZtghahW7dXk33pVBhZvV9/80E15WAXR6qHlvUrModmUOVmRK7dOCyaMdkGtG9Bllxxr+LcUb3AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672678; c=relaxed/simple;
	bh=pgpRAI7Y8QhaOP6Pymm3EbLnV2qRk4y6/v2FWzz7CJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BYmNlDkF5Ghjq9LhtkNSbWm9z8JjqpAvsaOZhh8BFAvMK9D9eI8KOLdQvL8wfIznzrH4bpQYvrmDQBPQlbnak2EhdX1JWxl+YDa+ijdG6vOvdpzibceiDyO4qsLP6nyI/OMuFm65En3J3gMBGf6JKOgLl0/8fnnDw2FboQl4HEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xI/qwobT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe862ea448so3615262a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 08:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740672676; x=1741277476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gt8hEde/7Gru946GRkddPPAww42go+fQbGXT4sZ1O7Y=;
        b=xI/qwobTzepLuCRoE1MeH0GGDYuynLPzjACiohLMWDhV9KYqNJIrCNmsXfIEtDuOmr
         +lGHRDUMgc5Vwq2znDb1IH6soiXTt0Xn5ii81tYeuRc8k5Ph3Ez/j6SBRM/8jsTLTaYI
         5TgkUtBoSlfMWKFxwaOmZvtmsgPcHuaJNURUaQnIhFNwR8WM+Hgq5tAfxyIGUoEUSGBG
         Ep1jeYXOPkyDwkNUQ1xF9JXLeB0XnuAzHx7gQ9ROmUoo6EC2dkr0KkRA1jK5DmvzAnA0
         f1YqBnGR8fOrOO+I3WIDHmkGwIT5OKCEH5r5TUOhYrvw3kUpKe8RxulCdFY0W14z9ykJ
         99lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672676; x=1741277476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gt8hEde/7Gru946GRkddPPAww42go+fQbGXT4sZ1O7Y=;
        b=U2cyPhXwCzJDsyxdJIQ7QQfIPZQqkDAzSwYV250zKiLbbO9SLhrAbsJOGD3RApU1YV
         EvQvO9UoQEGujpEXPlP6tJUjQ36GSwQIRp/W8PclH1vMr5IHnrvMwanOchxvOj0yNych
         YjUrLFHdGD/02moFAIt0HQx8OT0e5Qpkagd3UcbyssurLjf8BA+YuA1gG64UznoECeUP
         imHq6K5UcJTrT9wInGpE8G013wwdYEpAtw0ix/PuQXeoV/yEPesv8jYzUjiVHAyAbmZW
         0Gk76jzGiysLzMmfUorgrCUEkaQi6iTpksE74OKfxbQFok5RhblqVTj4DKp6XUfCHNYp
         XfwA==
X-Forwarded-Encrypted: i=1; AJvYcCXtDTNcSXcgOFsMvqp0PdsaUWs7xAzOsWK+KzxEyl3QqsPdomwQJR32jn97qX6dLNdw56IzghqUPFnOdFu6XVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH0muhlHcvyPsYaHUBL0O90QYgfmPqe6I4dLs032sXj4B2It/W
	oHJQOiEVTJEwO7V7JqjMPJQkDblosp5mDYaL9mv/90yipfA9IaoGA2Bt4U7tiKhijrwCeMxo+LA
	SVA==
X-Google-Smtp-Source: AGHT+IGpaIEW48FnCdlEFTCrks+Nq/cebvX49QneM3RNc5CaNQ3CCLp9tHq36FfTJ1IoI3fwpdCN9uiRRxM=
X-Received: from pjd14.prod.google.com ([2002:a17:90b:54ce:b0:2fa:27e2:a64d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c88c:b0:2ee:cddd:2454
 with SMTP id 98e67ed59e1d1-2fe68ae617bmr20354873a91.15.1740672676087; Thu, 27
 Feb 2025 08:11:16 -0800 (PST)
Date: Thu, 27 Feb 2025 08:11:14 -0800
In-Reply-To: <9e35b27f-affe-4345-8a87-07f4f285b63f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250128124812.7324-1-manali.shukla@amd.com> <20250128124812.7324-3-manali.shukla@amd.com>
 <Z74_HQaQ1jY4eKBB@google.com> <454ba4ae-4be7-49ae-a9b9-3b25cad8433a@amd.com>
 <Z8B3l8VGA2RHRI1j@google.com> <9e35b27f-affe-4345-8a87-07f4f285b63f@amd.com>
Message-ID: <Z8COoix1SiBV-AFW@google.com>
Subject: Re: [PATCH v6 2/3] KVM: SVM: Add Idle HLT intercept support
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de, babu.moger@amd.com, 
	neeraj.upadhyay@amd.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 27, 2025, Manali Shukla wrote:
> On 2/27/2025 8:02 PM, Sean Christopherson wrote:
> > On Thu, Feb 27, 2025, Manali Shukla wrote:
> >> On 2/26/2025 3:37 AM, Sean Christopherson wrote:
> >>>> @@ -5225,6 +5230,8 @@ static __init void svm_set_cpu_caps(void)
> >>>>  		if (vnmi)
> >>>>  			kvm_cpu_cap_set(X86_FEATURE_VNMI);
> >>>>  
> >>>> +		kvm_cpu_cap_check_and_set(X86_FEATURE_IDLE_HLT);
> >>>
> >>> I am 99% certain this is wrong.  Or at the very least, severly lacking an
> >>> explanation of why it's correct.  If L1 enables Idle HLT but not HLT interception,
> >>> then it is KVM's responsibility to NOT exit to L1 if there is a pending V_IRQ or
> >>> V_NMI.
> >>>
> >>> Yeah, it's buggy.  But, it's buggy in part because *existing* KVM support is buggy.
> >>> If L1 disables HLT exiting, but it's enabled in KVM, then KVM will run L2 with
> >>> HLT exiting and so it becomes KVM's responsibility to check for valid L2 wake events
> >>> prior to scheduling out the vCPU if L2 executes HLT.  E.g. nVMX handles this by
> >>> reading vmcs02.GUEST_INTERRUPT_STATUS.RVI as part of vmx_has_nested_events().  I
> >>> don't see the equivalent in nSVM.
> >>>
> >>> Amusingly, that means Idle HLT is actually a bug fix to some extent.  E.g. if there
> >>> is a pending V_IRQ/V_NMI in vmcb02, then running with Idle HLT will naturally do
> >>> the right thing, i.e. not hang the vCPU.
> >>>
> >>> Anyways, for now, I think the easiest and best option is to simply skip full nested
> >>> support for the moment.
> >>>
> >>
> >> Got it, I see the issue you're talking about. I'll need to look into it a bit more to
> >> fully understand it. So yeah, we can hold off on full nested support for idle HLT 
> >> intercept for now.
> >>
> >> Since we are planning to disable Idle HLT support on nested guests, should we do
> >> something like this ?
> >>
> >> @@ -167,10 +167,15 @@ void recalc_intercepts(struct vcpu_svm *svm)
> >>         if (!nested_svm_l2_tlb_flush_enabled(&svm->vcpu))
> >>                 vmcb_clr_intercept(c, INTERCEPT_VMMCALL);
> >>
> >> +       if (!guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_IDLE_HLT))
> >> +               vmcb_clr_intercept(c, INTERCEPT_IDLE_HLT);
> >> +
> >>
> >> When recalc_intercepts copies the intercept values from vmc01 to vmcb02, it also copies
> >> the IDLE HLT intercept bit, which is set to 1 in vmcb01. Normally, this isn't a problem 
> >> because the HLT intercept takes priority when it's on. But if the HLT intercept gets 
> >> turned off for some reason, the IDLE HLT intercept will stay on, which is not what we
> >> want.
> > 
> > Why don't we want that?
> 
> The idle-HLT intercept remains '1' for the L2 guest. Now, when L2 executes HLT and there
> is no pending event available, it will still do idle-HLT exit, although Idle HLT
> was never explicitly enabled on L2 guest.

Yes, but why is that a problem?  L1 doesn't want to intercept HLT, so KVM isn't
violating the architecture by not intercepting HLT.

