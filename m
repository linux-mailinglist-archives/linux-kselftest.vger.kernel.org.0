Return-Path: <linux-kselftest+bounces-44017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E898C0761F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562721B83639
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0463376A9;
	Fri, 24 Oct 2025 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lzJoDO81"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363DD2DA765
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324351; cv=none; b=aE1QVpAun1tCM7tXTGmaSN9y6x7Bu7qzf0WdmnKB4kH39efOBoRxWOxjqrl0uiLmwQdrAqfXMrDXgzvHAYu8OBk74znIgFjKZAJmyHwJFqINpayiqsrBglSAr8bPkLGvTW40N+DBIRfEru9ywoOTtMEId7noswmGa1TIcm+RBjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324351; c=relaxed/simple;
	bh=l8fHPPkC4JRlA1R9eBG/HBWLmHeZAxOGw9dz4ZOhCvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCZhXteOoBdgAlwtLGU9CwsxpxgqAWlL2I9W9UqkMLHWlzt+h9OD+rjWYj8Owsn4ES7bOv87Bg3doHbllKr40pQBU2L7li4oBiFLJp0ifCqpf4mt0wRrtDCfDUOMkEl+BAwe/dRNkniOnodVTWbhV9FmJNXF3o65xCoCYJy50cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lzJoDO81; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4e6ec0d1683so7041cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761324348; x=1761929148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp94m+0iT2dB2E8reOhXroB6plr+CCHWM/+pbCZUMQM=;
        b=lzJoDO81WHJOg9h67mGvL06kNlZ4CSMFA88zLpAkZ7wWpR4UB2Um3IBz0+KpUotgaR
         qYiqh50/oLerda2L8fg8Y5NoHeJlbvwe/WKoKZBy62InUQCWjKz+1P2ANipd8iqRqvvu
         kOiqMGBvBg/SWno4KzMxRLE+HZyh+WmwVzQS7jc/MDx0HLbS7Tge5y/6ZZ8y0C2FxdoP
         9c46Sg2hdpajGsJQzAyZC4HnbHJjF5ILMvg1RxMNuyum1x5BhXrKLWwD6GvqjyEB5VMy
         T5MsMMYQjUtTNGuVOLWPhm9mRb83F3PhGxtre+EEYfgFBKh3Fej8DwPZSkGKtFBd0TOD
         GbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761324348; x=1761929148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tp94m+0iT2dB2E8reOhXroB6plr+CCHWM/+pbCZUMQM=;
        b=Ne80r8EH13yQMhSEosHr0IRqxsPzQnSxicEuBgoGfMKqzVRVBSadUbIlOjsOovYHQY
         1hNYobI/3mYk3oMKQUOo8WYKGAV4Lyc4I/iB+hTgwj/2ChpKJ/gyReLGmGnSPjeaFByt
         2NMvhaMMrPJD1yPRHYb4DfyRBBWpxSVUb5QaEy4M57WhQTbb7OG54LoM5JQZ5nHS7c1o
         KFdbJ73/S0FQcWDOTPAvFz6pwdrOgglgPI4xqq4tQ6NemMSdxb8NY0+eWB01PoTSafKg
         lbW6FLd73xcchtpIYlLogWqdfjsP18TpHnfpsMNDobhyVw9n0frD0mWiqr6/siBVJmsN
         jlKw==
X-Forwarded-Encrypted: i=1; AJvYcCU534hcX37HA591foHlvM2cxCcP9AlRKDSXMtNPDnnajdi0G2L37/JmnO2ojxJWRJaybD1+nskmJRTciz2i8QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVlqJO5YY49wSZE5P5EFkRwZhY2MA+oPRoglBcqxRd+CSWC6GW
	OCMIzkMChktBTvk7CvReRfvoN7m6SI39jqwwQAbS/JArSPnCONNwxYJfgEZWNr8d4WvwtEmzt+F
	wnbmoifKuX1GYAxyDzFZm2Ppgmdd4ygn3riF3JOjU
X-Gm-Gg: ASbGncsFsJjOKsu0fy0lcDMjLiaapnVGDksJ9EGjUYAvgIekhTI3JkTl/OjnafeXhpQ
	YFfHhlg9/RFW5lYhf1JuCXgLZwzRDXU8D//BU12EKYEhAGKLJlJWHBWrK2RAjTEkdJJu3I45Il5
	1qSNgT46odqB3TnOTh/a7XminfldQr77MmojCvE8Op3vbkwde3grhisluCFh97DPAowQkGA4QLl
	WlkzfhhleyJrnACIhtAPlL0SyKh1h1cI1G7zXLerwUkg8M/GHXMvVyNwMBYVHRiXNxe7dKgAe1U
	7SElLvaVoCpBxVz37A==
X-Google-Smtp-Source: AGHT+IHj9jJsKJWJhcz77Qoyqqh2QgHDB/OktV5aMTXEGJP/cspOjR+15VD0ZBgbsEKzvzwaFG7Jo2NnWVJOzgywjrg=
X-Received: by 2002:a05:622a:cb:b0:4e6:e07f:dc98 with SMTP id
 d75a77b69052e-4eb93730b28mr5610111cf.9.1761324347845; Fri, 24 Oct 2025
 09:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com> <20250925172851.606193-14-sagis@google.com>
 <68efcb7ee33e5_cab031002e@iweiny-mobl.notmuch> <CAAhR5DGcz-2=a6Q2zZS_eP2ZjNNPs65jNG+K50tdVAQfC6AbbA@mail.gmail.com>
 <aPui50JMEcuIl7-8@google.com>
In-Reply-To: <aPui50JMEcuIl7-8@google.com>
From: Sagi Shahar <sagis@google.com>
Date: Fri, 24 Oct 2025 11:45:36 -0500
X-Gm-Features: AS18NWBLOljVToQUAT57VvW_ehimBaX2k2m0jrXQCZpfD9mmAYUsGAZUGeqHF5Q
Message-ID: <CAAhR5DFJKTTY3tN7AU=BXDRJAGjuortmK0ruQWU8RB_Z6jVugQ@mail.gmail.com>
Subject: Re: [PATCH v11 13/21] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
To: Sean Christopherson <seanjc@google.com>
Cc: Ira Weiny <ira.weiny@intel.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:02=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Oct 23, 2025, Sagi Shahar wrote:
> > On Wed, Oct 15, 2025 at 11:25=E2=80=AFAM Ira Weiny <ira.weiny@intel.com=
> wrote:
> > >
> > > Sagi Shahar wrote:
> > > > From: Ackerley Tng <ackerleytng@google.com>
> > > >
> > >
> > > [snip]
> > >
> > > > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/t=
ools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > > index 2551b3eac8f8..53cfadeff8de 100644
> > > > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > > @@ -270,3 +270,61 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_=
t attributes)
> > > >
> > > >       free(init_vm);
> > > >  }
> > > > +
> > >
> > > [snip]
> > >
> > > > +
> > > > +void vm_tdx_finalize(struct kvm_vm *vm)
> > >
> > > Why is this not a new kvm_arch_vm_finalize_vcpu() call?
> >
> > What do you mean?
>
> Ira is pointing out that upstream now has kvm_arch_vm_finalize_vcpus(), s=
o you
> can (and I agree, should) implement that for x86.c, and do vm_tdx_finaliz=
e() from
> there (based on the VM shape) instead of requiring the caller to manually=
 finalize
> the TD.
>
> Unlike SEV, where userspace can manipulate guest state prior to LAUNCH, T=
DX guest
> state is unreachable from time zero, i.e. there is unlikely to be many (a=
ny?) use
> cases where a selftest wants to do something between creating vCPUs and f=
inalizing
> the TD.

There are actually a few use cases for calling vm_tdx_finalize
seperately from the create phase. One such case is when a user wants
to add additional memslots for testing shared memory conversions.
Another one is installing interrupt handlers. But these are probably
rare enough that they can call __vm_create() and vm_vcpu_add()
manually instead of using the wrapper

