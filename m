Return-Path: <linux-kselftest+bounces-43964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34538C03E96
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 01:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FFF1A67CBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 23:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D20C2E1EFF;
	Thu, 23 Oct 2025 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBDI8FR2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780E7296BD4
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761263956; cv=none; b=RtuC8TvTJPoVbc/2IsouCQ1M5okk06mTVrknW7iZ+RwbipQps3Hd5gLeXBTXRZutCmv5pqcYSijex0aWpAHK+Q3HMiyFZtQrJSoOsRugAhb95lhfGtSWME+5fKDW1PILRufOKO6tr/NVPmuBAIKHe4hMb7FvuArY5Nic5YnJANo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761263956; c=relaxed/simple;
	bh=KRqFx1cZkwsyBUxEVPNGesO9wktbAXLUFJV2t0yuRh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+QJX3RhEgsX9sIGPkWpI7Q12Yoep/zVVO/0DnkkurP+f8+14hiW79QIKk8YN1CdwWdpmI3R/NTTNdqVUbojYoNWmyWoj6pkCy00WtnrqyvHsKa7DooRURYqz4cJoV9Qqp34cgRT1g0UqBCU7Bm+u9wj1jaUbLe52Z24y6jYPEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBDI8FR2; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ea12242d2eso105231cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 16:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761263953; x=1761868753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWaPYvH94F3bazBBQR1mRrH2sncW+IAfzERpSr3zH6w=;
        b=cBDI8FR2q8G+wj/K7qG8Xv1LOz52xdMF0mAjnX/UuhvnPwmNybAhHmkFcdjC0zTzdP
         nOmxIwLxVyHLEv9ExgF6SgSPKfqHEIDkz+VsvHiWGB71OwQSL09CWKa2pN1lnMroIA1P
         pks6bcR7Qp62Wqj2oL/y5U/ZX96fhXEU+E6wAJ9qnRWRHdZBqOuF6/8ARR4z3L7NIDH4
         gazN6fvDW2A4wdKACHdVdEwITcCZenBPCIxIkabUmDEttmsyeQ8m3b972PSzKg8PuFQw
         LD1O2J41f6W/ZIIIhysyF7VzPZCQHJUURKl3mpZa6umfRvD4FSqw7n41mssstow+83ho
         IzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761263953; x=1761868753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWaPYvH94F3bazBBQR1mRrH2sncW+IAfzERpSr3zH6w=;
        b=aEkZE+rHuQw+N56oOuKrM1RSwxfEIU5u1Z2EUHZSYHN9ZRldMBVbieD5QZI2wqz/rp
         RbK9V7RKtlLYn2369rmfgaaLzOim2zEm7vrujBEjyptByRQMRu7Qt91H09BnJxFtFbzW
         kbqj4ctC0iM1guK73GaUarTVZcFy5KFt/Dqk59wT/Hx8viHSUtpvRaBJwW4qjVt4Y9c3
         DrqSemcvWNikNPaPS1H/vl5V8egFgK+NBcauIJ7KEDDueiNklGamYFPKodIV0/3yGZ8R
         caHzQdozk3nZoxfxd6bIYPBNuT31x1jpN1q3mk0iAkIWKfjH81aBD/HW/9ScRWl64e2B
         r6dg==
X-Gm-Message-State: AOJu0YwX1PvK5hxpZxO5121JWdwQuSYhgGPcVU7Ifh0yr150xgr9XEI8
	lZ2Sn0aRgDLzUg4nBSjnB+vrUqRBsWOV/FRkYPov+kBZ/cc+BMWcIj6EoBlxIhEtqdEsIFK76xu
	80cCxnqVJoXmyvDG0GZvdnt0e9NmZjaWi3SbvC/v1
X-Gm-Gg: ASbGncsSQBobq3rnZlanbHJPcsVMHhpm4o66OCX/MMJIQOwrZhet8dBFKHSBl0rED+o
	1MUXw6KpnlsBrOHqxX7YAaqc8Aa5fLbPp9Hnb8uf/aM75jPziOZ5vJ8q33w/YmO2awa6uqdCP6/
	cAPuQ7Vz1UiuoOkVHao8G33bERN0VJn3PMIrpYFI6XkCOXsQpwhuFMjE3oFtZ5Z8EYf4PwpuhUN
	ynXmbTxxaK0bppG1hqFkhoVu+UInKOvIosjoMYBPE6nxunnI92xTSsee1KJtMiL5uQwjD4+Hkzg
	PFX85hcYB20PLAUPPondspdCOWig
X-Google-Smtp-Source: AGHT+IFiCpGL8XfWTU0ddwConeQqYO4+/7UNnfpipr71hb3sds9xvvlkZExSlvxpN5YXK1dP6WJgpa5Frp79V38UrVw=
X-Received: by 2002:a05:622a:1495:b0:4eb:75cb:a267 with SMTP id
 d75a77b69052e-4eb9251b2b5mr2286001cf.12.1761263953189; Thu, 23 Oct 2025
 16:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com> <20250925172851.606193-14-sagis@google.com>
 <68efcb7ee33e5_cab031002e@iweiny-mobl.notmuch>
In-Reply-To: <68efcb7ee33e5_cab031002e@iweiny-mobl.notmuch>
From: Sagi Shahar <sagis@google.com>
Date: Thu, 23 Oct 2025 18:59:01 -0500
X-Gm-Features: AS18NWB13mopkwuSS4JxlZadYovueuOn6EGZfluKJpeBEQ17CYTqorbiZz-kY7o
Message-ID: <CAAhR5DGcz-2=a6Q2zZS_eP2ZjNNPs65jNG+K50tdVAQfC6AbbA@mail.gmail.com>
Subject: Re: [PATCH v11 13/21] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 11:25=E2=80=AFAM Ira Weiny <ira.weiny@intel.com> wr=
ote:
>
> Sagi Shahar wrote:
> > From: Ackerley Tng <ackerleytng@google.com>
> >
>
> [snip]
>
> > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools=
/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > index 2551b3eac8f8..53cfadeff8de 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > @@ -270,3 +270,61 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t at=
tributes)
> >
> >       free(init_vm);
> >  }
> > +
>
> [snip]
>
> > +
> > +void vm_tdx_finalize(struct kvm_vm *vm)
>
> Why is this not a new kvm_arch_vm_finalize_vcpu() call?

What do you mean?
>
> Ira
>
> > +{
> > +     load_td_private_memory(vm);
> > +     vm_tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
> > +}
> > --
> > 2.51.0.536.g15c5d4f767-goog
> >

