Return-Path: <linux-kselftest+bounces-38193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0146CB18955
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 01:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0F75A104F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 23:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C7322F76E;
	Fri,  1 Aug 2025 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJ5dRXVw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E1A22D786
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Aug 2025 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754089832; cv=none; b=Rz9d+/gKUW/jEjHX24wo12O2Dk7OzZs7bLAhEzl49tYvMRtQ71+g8iOujBpxDwRjnK6YwX7qOI9LYA90VymsPDdZ92mBfxG72ItNzL7uVu75wmVyhBtM+pNx9JELbTtQDBgqjT30hYpl4NyoaRrp6IodPaBdOM1N3L6MdpAC/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754089832; c=relaxed/simple;
	bh=GwrrHh+mKQ4p41elE73MS6bGKcwXmcqEjf1KLecr9Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLlW0xvuzY3v65zIpaGTGM7A4OYIx9Fu0XScxoHQ6NMKhjAHhQIwj2EhzOedaTlAvCYIStR6eC9eiBM22QdQG960Z8yeUrOtDUDUgPCv2cWeWypuvFNYnW+QZyGWevzuMY71rTguWU7vQlv6Gz4U0bUXpNTfprOQj5toupf6eMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nJ5dRXVw; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso153721cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Aug 2025 16:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754089830; x=1754694630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7g2gB+6N1sjCl5YcGKFO4HOtdhCFwo/qJxfuXGOfsPo=;
        b=nJ5dRXVwtv1f91pA8hDJfJ66hz9VvBS88sULCiXDg1GrS2pD2dvPB6CMgt0gS2vRCo
         E2S7NAUOeUOVha/onQch1gUamRi3s860FocgIwTlb3nj4Op4C8SbzH7jRg+IxHv0mxyd
         VlWQ/542gCx2+4XqtSMPyYdfbmGh4J6tq0XV3zlCQd6h+3BnIUaps45LftioGrhbOnMF
         utJH20mAtR47FCIUFSQrnVDzIjMCUhgw4bEW+ZmvVZO+gjmi2/4T12jlbviO1tNbWps2
         ftXOH6AtlmrIGK8gcqBWOBR2hWv2ID04TJuQu64TjRbWyhtaiuOCAKG+apR/+rx9toa9
         ms5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754089830; x=1754694630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7g2gB+6N1sjCl5YcGKFO4HOtdhCFwo/qJxfuXGOfsPo=;
        b=j4IynwbtH+OwlUA1Ldodf+eOgLtP95pEWAo2TUCZTro2IOD0InnYyuWeLVT7kBLris
         VMZgG51G879cWheNSigppq44sUQuTU92LcL9I4xitdcvunuYDk1iwWoRcMBXypcafX5x
         JzJJsH0/YYTE1VDqdP+mol53R7QEKGU3LpSEg748MHemtzs06fgjtDaxTmBDQldafVFl
         bkkt5P0/j+jYU+6l1yrc1UQqMu0Ez3dKz5oVzRgr9R11a1/6PKL6LWG/AnHeeLXFyiHY
         1d+i+KRPyoVGYVxlzVI8AFld/o5CP0sDzZQRuFF/Oms6aRygHCCELdU3TlYwDVZv3cbH
         gz4g==
X-Gm-Message-State: AOJu0YwnokpGPk3X96YylSTbNR81nKjiJL6jXiiGORYLohlbS/FZPRAd
	Zx2bLtzgoyLPrtILQBErA20EOdQLBaAJKS8dMTl8egAQ3Tueg8sn4grdhse4Ufa2xWo6XnT4llp
	2ZPFk4ZtDSW2QUaoA3AWS2VB5wOBBWO9ox3pp/inM
X-Gm-Gg: ASbGnctw++HvG83g9HDMJ9p3RbvZkl0i1KdVMYGtkC3hfsWfMbBMng613+fDZPelZu4
	OqdufNv35wyD0QUOKojPJQILLewpfXwe09dTR7imiMClNl5P+OFQI7X1abq5qM8uOWsDomjxTdp
	Sw2uQs1f6k1DahQzVDUyC2kvlnTzNI+IKAgF9fEzD/UierFvVT1YS45stDSSgCwW9kjv1YIrthW
	9AVdqx92dC/DAWdReF0Ie8o5/GUffxYUAQzwQYP
X-Google-Smtp-Source: AGHT+IG3phk7tKovbC70u4hARPE5dtDSCFUBqv/mdXZaf4iZ2qRLkbKaC5fUwIf1Iwu9r984nTzsGVnOfq8EtbgMdJc=
X-Received: by 2002:a05:622a:302:b0:4ab:54d2:3666 with SMTP id
 d75a77b69052e-4af164bd40cmr710461cf.25.1754089829339; Fri, 01 Aug 2025
 16:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com> <20250613191359.35078-6-sagis@google.com>
 <aH62f9X25LHuUx8n@iweiny-mobl>
In-Reply-To: <aH62f9X25LHuUx8n@iweiny-mobl>
From: Sagi Shahar <sagis@google.com>
Date: Fri, 1 Aug 2025 18:10:18 -0500
X-Gm-Features: Ac12FXwQNDLbo9Q31lKoiJLw7QQejnonXC6nW-MjLkZmnyO9vlyhYR3XHFSy7sM
Message-ID: <CAAhR5DEQ9QWfdzO1yCuFzYjju+Q=pDGbcYyRWFmA_6tc8A4LNA@mail.gmail.com>
Subject: Re: [PATCH v7 05/30] KVM: selftests: Update kvm_init_vm_address_properties()
 for TDX
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 4:51=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> On Fri, Jun 13, 2025 at 12:13:32PM -0700, Sagi Shahar wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> >
>
> [snip]
>
> >
> > diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/te=
sting/selftests/kvm/lib/x86/processor.c
> > index d082d429e127..d9f4ecd6ffbc 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> > @@ -1166,10 +1166,19 @@ void kvm_get_cpu_address_width(unsigned int *pa=
_bits, unsigned int *va_bits)
> >
> >  void kvm_init_vm_address_properties(struct kvm_vm *vm)
> >  {
> > +     uint32_t gpa_bits =3D kvm_cpu_property(X86_PROPERTY_GUEST_MAX_PHY=
_ADDR)
>
> This fails to compile.

Looks like it's a simple case of missing semicolon at the end of the
line, it builds fine if you add it. I can update it in the next
version.
>
> Ira
>
> [snip]

