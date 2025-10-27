Return-Path: <linux-kselftest+bounces-44154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECC9C1213C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23EC1188BF90
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 23:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2400632D434;
	Mon, 27 Oct 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eEke48V5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3A6324B3B
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608534; cv=none; b=HS/ieuW+xPWa6JRwmMS8/CcUO1Li+50PoKevbOafpP4MlIuQk7u7Ult4xiIG1z3FI4nzAWcvdkfZnzBoE56Z6rVtdRpTzUqjnQhmmNrMwZ6ly4yGvElESexMvru96C3NFyQDYcONkJFKCUlyYYEs8Zoo0GucVK1le6FMQnSUYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608534; c=relaxed/simple;
	bh=puF+aGtYO5s2MYsxCALFC+9nUczVh0W5+txcOclIcsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gGRsb9QIvSziz43A9lsDCvLrd4XH8hKCjs/Udc8Yd1BzUGXiYKfTrxuJ9wbbEBy+sC9/8XytdUFzjJT1TMAw+XJcyWf/Y5hOtXKO6uMJQaax2veomBlmSVXZWUsgq9DDhoEPaOiKkd/APkUtGsX/QqTnxdfd/yGTyDm8BXTn0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eEke48V5; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso3327180a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 16:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761608532; x=1762213332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aAmis02MY/SPD0Hs7vo+GbkUlTOrf3bzWV+l6BGfls8=;
        b=eEke48V5ZE0jhBVHEC/ccmKP3wDct2lr3Lvu8bqRt7zfaCaJuThWKsJHTR+qtijNeq
         DuixpMZmeuKSetJhIL6dw2CwQYA1gPKglpZjb0EjfC9BUU3w11W6SaUfc0IyPtTW5jZa
         4pKUAqPKfKx6AjqcBNW3ACGhWf8zsVl3BtOnM9bdwPYrRGvPIY1UZ5GqiIpQn1/ehcaR
         HZlRnXryedMm2mMD8OEBy+ofbacFCyBpBS7mx8rWh2d+Wly93gkORQzpTwGNMHEO1rjY
         yiQEGOOa8C8io3r5E1GnhFx9Ao+slthWdciaDJMZ4aeBik8yD0CTWEl/v09IujpTTHX2
         2POA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761608532; x=1762213332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAmis02MY/SPD0Hs7vo+GbkUlTOrf3bzWV+l6BGfls8=;
        b=aRuzcjKdkHNr+zD9lN7rmYD4087JbIzQMF+fGHYWmA47Pt2c5vLecjPLZq1bnaWP1j
         kiHuh+i6c5kdWyUm8+g+9fwuH7NuFKFhNA+sazArP4MktD1IDASu2ADEyNP3FUQ6LzEs
         nQkafMcQEQ/WLVNgrGGZ13l8p34nOwNn9vhQKCJXqlg4y1POPzBOXuzcpMHpe3WKAhty
         p0ioOrZXrvBiA9L3q+MH/I0ICvfM1s+zBpfmj1SanBhvrMm71EvRXPWakTQryfPRm4Rx
         bkeYtHnsiCQcGVP/trx6JbECDWnAD2XbdI495+8hYaYoiynu97JtykzLmcTzNNOlhE40
         7OKw==
X-Forwarded-Encrypted: i=1; AJvYcCXE10HoahQ7/ItInXq/5M/wxXTxqxc5ZS93H4egPrmAdJbZocG8zoNYq9N943JPDo0eXJkDuAYSFvUCgThrv44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mp+m8XtKeWMWH7jYBhuKgefi6H/zc6vmnB63YUnhY87fDSvc
	G2scy0GmtcFiyJ1WWBE5ijgKPcUjjaIck6TvYfXezUgvXx9UbpZZHgfL6dnyxnsYYbtgPX0Aa08
	TsH6zNQ==
X-Google-Smtp-Source: AGHT+IGYp8OSEh6n3uju+4I19uY+Q2quGSWM2e9It+MGilW2heCNkxOdmfwFxaiUgOrbP7KksK/kXcOhiO4=
X-Received: from pjbsd4.prod.google.com ([2002:a17:90b:5144:b0:33b:51fe:1a93])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c40c:b0:290:bd15:24a8
 with SMTP id d9443c01a7336-294cb35eae8mr19734005ad.11.1761608531946; Mon, 27
 Oct 2025 16:42:11 -0700 (PDT)
Date: Mon, 27 Oct 2025 16:42:10 -0700
In-Reply-To: <68fff9328b74_1ffdeb100d8@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com> <20250925172851.606193-22-sagis@google.com>
 <aPum5qJjFH49YVyy@google.com> <68fff9328b74_1ffdeb100d8@iweiny-mobl.notmuch>
Message-ID: <aQADUmrDSRAydBhI@google.com>
Subject: Re: [PATCH v11 21/21] KVM: selftests: Add TDX lifecycle test
From: Sean Christopherson <seanjc@google.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 27, 2025, Ira Weiny wrote:
> Sean Christopherson wrote:
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > index af52cd938b50..af0b53987c06 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > @@ -210,6 +210,20 @@ kvm_static_assert(sizeof(struct vm_shape) == sizeof(uint64_t));
> >  	shape;					\
> >  })
> >  
> > +#define __VM_TYPE(__mode, __type)		\
> > +({						\
> > +	struct vm_shape shape = {		\
> > +		.mode = (__mode),		\
> > +		.type = (__type)		\
> > +	};					\
> > +						\
> > +	shape;					\
> > +})
> > +
> > +#define VM_TYPE(__type)				\
> > +	__VM_TYPE(VM_MODE_DEFAULT, __type)
> 
> We already have VM_SHAPE()?  Why do we need this as well?

VM_SHAPE() takes the "mode", and assumes a default type.  The alternative would
be something like __VM_SHAPE(__type, __mode), but that's annoying, especially on
x86 which only has one mode.

And __VM_SHAPE(__type) + ____VM_SHAPE(__type, __mode) feels even more weird.

I'm definitely open to more ideas, VM_TYPE() isn't great either, just the least
awful option I came up with.

> >  #if defined(__aarch64__)
> >  
> >  extern enum vm_guest_mode vm_mode_default;
> > diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> > index 51cd84b9ca66..dd21e11e1908 100644
> > --- a/tools/testing/selftests/kvm/include/x86/processor.h
> > +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> > @@ -362,6 +362,10 @@ static inline unsigned int x86_model(unsigned int eax)
> >  	return ((eax >> 12) & 0xf0) | ((eax >> 4) & 0x0f);
> >  }
> >  
> > +#define VM_SHAPE_SEV		VM_TYPE(KVM_X86_SEV_VM)
> > +#define VM_SHAPE_SEV_ES		VM_TYPE(KVM_X86_SEV_ES_VM)
> > +#define VM_SHAPE_SNP		VM_TYPE(KVM_X86_SNP_VM)
> 
> FWIW I think the SEV bits should be pulled apart from the TDX bits and the
> TDX bits squashed back into this series with the SEV as a per-cursor patch.

Ya, that's my intent, "officially" post and land this SEV+ change, then have the
TDX series build on top.  Or did you mean something else?

