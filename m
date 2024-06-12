Return-Path: <linux-kselftest+bounces-11806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3039905F34
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 01:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A7B1F225CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 23:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C3712D1E8;
	Wed, 12 Jun 2024 23:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPnpl7Og"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD8112CD96
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718235098; cv=none; b=MynDut0NmTSBZWVSsjk6OTHW2s15bb9iZEBy3fbc+QtTQ5xdi7BRakI8VWokRtsp2v4b0qQJ7YBRAHE5HtVxyoM5BWFAEF9EoYZ3a3fe+GM4NbUbtJYqUbmP3M4OT6jwlWneTBuUhgR9XhOdBFGcDNnQO1BRBT+6n1SlQIhgquI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718235098; c=relaxed/simple;
	bh=4SDKp1waJzXqdTd/ActDvagt62Ph9uX2CozVVnbthGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OUOjNjseYGZXP3wie/K4XPajA20wV0hDDNJ+pmyufqhiYLlz1+J+MiR2wny1uuYrpTujGVipVy6CuRNqM0QuiL+tr0+p2yQphJpVUydRY5w60O7oSOigf/7E7tzwkOYAPpevcDn30B8zB1GDFRHkoVXBg3EObN3qqXKeqrqN17I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPnpl7Og; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c4a1c9c0e0so290279a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 16:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718235097; x=1718839897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L/SyTTg+Pb2L8jVOL9JfQwGKpPzI3PRlHDd/+KWWSxs=;
        b=vPnpl7OgTw3m1W9f7qd8zuFbhpnIj+Jd34ThUJ7cL7UUofqkzRWLXa51Txwe4/fgxL
         PLzlDOasbRE+NzMuzxMsbsjUmjMh6HEYZPereLw5PaVNb8BVZzMrebU+Q81WpBJq7CPt
         GqouZtMhHxB7yb43W4Zs/RcZMGIN1WXLa5N6v64RhHdchIZvE9y2s3HQzP+2zejVkIsE
         D/qFO96+CjbH0nAd0oZsiCShLpItkPvCrABUdqVUmHILxr55EOKKcRgURxnQ8zF+0vYP
         xqjDo2Whtgb7BT4Tsq/V0HUpLKSHFphdLrYRrTmQTYmOXlENmugklXmS1yPBJ5Re6sh1
         IF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718235097; x=1718839897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/SyTTg+Pb2L8jVOL9JfQwGKpPzI3PRlHDd/+KWWSxs=;
        b=VhXw+2r2djFthdTUXJGrzfS8+LYZ1FJ2cGwfp5JRXjKj4vpawhgxgHcEGjhC3XDc71
         YVz2yByW1hIR3WIG1kC8n+abrI0LmlDQwwAjUHTijh2414Xowg2kkfWMf3814HDMmgEn
         2GoA1KwZkcgHafF9cKua6CTCbZd83rDj53SJqElTtFkAn8t4S+vjRSd2iVG1iqeVypqa
         sDD8rRnnaom7PIREEV7u3+NpjxJ/riHYipHpx3QzXcNwc/vo1ABAcT0+D6uwu8Ssvr6B
         gvyKJFEU59Dr5gvS/QnqXLMwXuiccyRcdOmnQ2JqwQjMeFiJFseZ+ggU//wsDoHARgPD
         ozwg==
X-Forwarded-Encrypted: i=1; AJvYcCVCSkWRIo5scNBad2EGPN65893r0Ix+CWXI4Ez/pRr3zh5LAxH1um9cRGHSHIMN7SruoYYrgfvwV+ohOw2Lty1VgIMtcnNJjyIq7SVcQyOb
X-Gm-Message-State: AOJu0YyuOdtGquVwuMmHnBIoP3IHQ06vvKqJ2lPF4b+6cqBBKEmPdrSh
	jrTqKhI+l59/aoL1a9LM2jpnTsnzkBjlhBA7idOHhXsNxOON6HxtDk0Y/YQY3NY1EGsSbD4cYZq
	2MA==
X-Google-Smtp-Source: AGHT+IFF6ktwP1UGkcUZHB0WhdUhwnLGJBuZ/L5no7UNOMPx0KJvnv6kZJUd9YOHzqFhW28idnkubVIueTQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:62c9:b0:2c2:c65f:52dc with SMTP id
 98e67ed59e1d1-2c4a770e8f6mr9058a91.6.1718235096779; Wed, 12 Jun 2024 16:31:36
 -0700 (PDT)
Date: Wed, 12 Jun 2024 16:31:35 -0700
In-Reply-To: <Zj7f+JWbVfIBIK8h@chao-email>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-13-xin3.li@intel.com>
 <ZjBiLDJ4SdQ0p5xm@chao-email> <SA1PR11MB6734740F9B6085E0997A4179A8E72@SA1PR11MB6734.namprd11.prod.outlook.com>
 <Zj7f+JWbVfIBIK8h@chao-email>
Message-ID: <Zmov1x2KFtoMN3Vm@google.com>
Subject: Re: [PATCH v2 12/25] KVM: VMX: Handle FRED event data
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Xin3 Li <xin3.li@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	Ravi V Shankar <ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, May 11, 2024, Chao Gao wrote:
> On Fri, May 10, 2024 at 05:36:03PM +0800, Li, Xin3 wrote:
> >> >+               if (kvm_is_fred_enabled(vcpu)) {
> >> >+                       u64 event_data = 0;
> >> >+
> >> >+                       if (is_debug(intr_info))
> >> >+                               /*
> >> >+                                * Compared to DR6, FRED #DB event data saved on
> >> >+                                * the stack frame have bits 4 ~ 11 and 16 ~ 31
> >> >+                                * inverted, i.e.,
> >> >+                                *   fred_db_event_data = dr6 ^ 0xFFFF0FF0UL
> >> >+                                */
> >> >+                               event_data = vcpu->arch.dr6 ^ DR6_RESERVED;
> >> >+                       else if (is_page_fault(intr_info))
> >> >+                               event_data = vcpu->arch.cr2;
> >> >+                       else if (is_nm_fault(intr_info))
> >> >+                               event_data =
> >> >+ to_vmx(vcpu)->fred_xfd_event_data;
> >> >+
> >> 
> >> IMO, deriving an event_data from CR2/DR6 is a little short-sighted because the
> >> event_data and CR2/DR6 __can__ be different, e.g., L1 VMM __can__ set CR2 to A
> >> and event_data field to B (!=A) when injecting #PF.
> >
> >VMM should guarantee a FRED guest _sees_ consistent values in CR6/DR6
> >and event data. If not it's just a VMM bug that we need to fix.
> 
> I don't get why VMM should.
> 
> I know the hardware will guarantee this. And likely KVM will also do this.
> but I don't think it is necessary for KVM to assume L1 VMM will guarantee
> this. because as long as L2 guest is enlightened to read event_data from stack
> only, the ABI between L1 VMM and L2 guest can be: CR2/DR6 may be out of sync
> with the event_data. I am not saying it is good that L1 VMM deviates from the
> real hardware behavior. But how L1 VMM defines this ABI with L2 has nothing to
> do with KVM as L0. KVM shouldn't make assumptions on that.

Right, but in that case the propagation of event_data would be from vmcs12 =>
vmcs02, which is handled by prepare_vmcs02_early().

For this flow, it specifically handles exception injection from _L0 KVM_, in which
case KVM should always follow the architectural behavior.

Ahh, but the code in with __vmx_complete_interrupts() is wrong.  Overwriting
vcpu->arch.{dr6,cr2} is wrong, because theres no telling what was in vmcs02.
And even if vmcs02 holds DR6/CR2 values, those might be L2 values, i.e. shouldn't
clobber the vCPU state.

It's not clear to me that we need to do anything new for FRED in
__vmx_complete_interrupts().  The relevant VMCS fields should already hold the
correct values, there's no reason to clobber vCPU state.  The reason KVM grabs
things like instruction length and error code is because that information is
visible to other aspects of injection, e.g. to adjust RIP and pushed the error
code on the stack.

