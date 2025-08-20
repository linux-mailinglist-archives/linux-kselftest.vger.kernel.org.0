Return-Path: <linux-kselftest+bounces-39399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DAFB2E75F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 23:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D965E665D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 21:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A7A2D8780;
	Wed, 20 Aug 2025 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w5uFRzjV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF5271472
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724729; cv=none; b=TRH4p6um2jgJZt7UM2NZ9LA10omoGdYrSmhH9nddOhh2VKO4oTnLAbg9XN2UdMWUa3ICkDoVjgOB15D0Zvz/uXau6KX1mp7YZGqJ5NfHAK8cyA+B5T43EgiuA41fhK1pcudc5C/xZqj8iJt3nC7LiS1cXubQXBpeF/ixkjk4de0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724729; c=relaxed/simple;
	bh=LjWgtUe2ffDBIWe5AFEdQGtloc8BFsTdPCWfRERMshk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StTbzqBJrPlhRWlGx79Q+EgRLEL2zcNvWZ+2L2HmQZjEcU4uKxoI5+KboScCOBuWIG9SUGBkxx5r6+oxL5G5ZrKvp6y+Pi2t0FqniHVlZo1i1bGLZu4hazDaXDIxKpfUjv3gNpsW6gkbn9KPYhyzNg9Yx7dBghJ/MG2rdho/IAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w5uFRzjV; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b0bd88ab8fso73021cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755724726; x=1756329526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YanTK0e4sjbxPtv/E87AJagkyaCOqYnz6w0QIlh+WUM=;
        b=w5uFRzjVLHGoWA28qun18g8F+qm8/UmNNMO0jRdnF3Rpf3dfqsha8zxn1xxBsI3NBI
         HWzFT8vVEFFmqPy184XOZeqDWaDCBTCq9/sDgXgi4i6low7lnxw5E62gPiRiD2lxt0Hf
         iIfMd8sWPn+dfe1PFP/EPZQoQEeSWQ4t4HMwb49atVeuZFU9zoJIAL8h4rS9izg+Q6tj
         ik7BK0oT1fz6ZkxZGZfOxrouXlj+Z70dSuzY7t+cXyUxqJ1DzQqvkKQ9ZfmRNXV6+2iN
         rGGwP4C4MhKCVilbOmfCUtuyb1N+uugtpo5NTV3knsJrh+OpP6H2XI49vU+ouio3nJjN
         UBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755724726; x=1756329526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YanTK0e4sjbxPtv/E87AJagkyaCOqYnz6w0QIlh+WUM=;
        b=Iljg4ZFwV18GRCLaZwKwFGO9SnZVsa0QBMT4OpuTNgAt9SijIJHmaT4pBjiilol05/
         r+p8Nt0U1i6M+UgsOlYsLFu1Wx+bSYs6hFWd1CWmcOgE8dwP1KFxTKSaUvyVyM9uCpDv
         SWIvqwE2JpqSZxihq+VoBBnfR3ZQ5sDZE0w7iwqm+0COmNygMAm4ZADZq2rcTdKwC+f4
         SmVJwNSL/9reF6RG2MM3MpDyv725lvs8DwkYALmaR43RC/227l8oEuEB6M1yHLpbeW8g
         +eJsJ4N7kaeGvIWdWu/LyxUxCcdNbXsM5S67l0rr2iaY0DoQpnW1VIQf5mg4eSV6ldwu
         M00Q==
X-Gm-Message-State: AOJu0YyakKB63OQmOH1oAUy1HLZlWS5zbuTKvLIaUuHJsGrTQHXfnvXi
	/MxEQ9S5Nxdg4q/BUJEHaiHixqiTwbeGHwGgSgdJjk3Cepn1OcemdivD7zbxQlyvQpQcFM17Zwy
	LXI/J6eNZjAHT/YJr5Lgm2PPYzTjCysWXMsGOqOSI
X-Gm-Gg: ASbGncuyDtXjhdHIsSQs4R9SXDVEKhg4cuwG90hE0jPo2PwEVdQ/0TjAtaNxlr6dv+J
	B/1KyO9RrmHjb01Lv2Jzl4HwKUIqoHElX9fmNtaf266PnD/8zkQfbHy3s5dyg6Jl75TP4EbKxQd
	aHfFjPHJ3jilfBzNAW5TCPJWckTAFISz2d9KVwiI92LCNMaO5miVDgYXavVH5v8fu6d3zuVk/6l
	22Z49ZwqoAuUaAibZNU7gksSghZ4utaSvaAOEFitXffhpI/Dkj8cASh
X-Google-Smtp-Source: AGHT+IHQRQFKbAOxo3PCN2gG1G+ONSaIYJEXSt8UDmWnpQyb4QJhOGxYZUIFKUu3mwSBMEBJBwB01GXcO6yRlid9inA=
X-Received: by 2002:ac8:7d0f:0:b0:4ae:d28f:b259 with SMTP id
 d75a77b69052e-4b29f9a3674mr171551cf.1.1755724725381; Wed, 20 Aug 2025
 14:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-8-sagis@google.com>
 <55e8d6da-50e3-4916-a778-71da628cbc08@intel.com>
In-Reply-To: <55e8d6da-50e3-4916-a778-71da628cbc08@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Wed, 20 Aug 2025 16:18:34 -0500
X-Gm-Features: Ac12FXy_O78l2qvX7QDGviCsQ0A4AbxaWcPp4bMvbe2OHW1_jf70ZZip1EYTtc4
Message-ID: <CAAhR5DHc_1VtVTD=g=q7qvnrK0z57jwD38AoDSDK1buEb5WUDg@mail.gmail.com>
Subject: Re: [PATCH v8 07/30] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
 validate TDs' attribute configuration
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 8:34=E2=80=AFAM Chenyi Qiang <chenyi.qiang@intel.co=
m> wrote:
>
>
>
> On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> > From: Ackerley Tng <ackerleytng@google.com>
> >
> > This also exercises the KVM_TDX_CAPABILITIES ioctl.
> >
> > Suggested-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >  .../selftests/kvm/lib/x86/tdx/tdx_util.c        | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools=
/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > index 392d6272d17e..bb074af4a476 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > @@ -140,6 +140,21 @@ static void tdx_apply_cpuid_restrictions(struct kv=
m_cpuid2 *cpuid_data)
> >       }
> >  }
> >
> > +static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attribute=
s)
> > +{
> > +     struct kvm_tdx_capabilities *tdx_cap;
> > +
> > +     tdx_cap =3D tdx_read_capabilities(vm);
> > +
> > +     /* TDX spec: any bits 0 in supported_attrs must be 0 in attribute=
s */
> > +     TEST_ASSERT_EQ(attributes & ~tdx_cap->supported_attrs, 0);
> > +
> > +     /* TDX spec: any bits 1 in attributes must be 1 in supported_attr=
s */
> > +     TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes)=
;
> > +
> > +     free(tdx_cap);
> > +}
> > +
> >  #define KVM_MAX_CPUID_ENTRIES 256
> >
> >  #define CPUID_EXT_VMX                        BIT(5)
> > @@ -256,6 +271,8 @@ static void tdx_td_init(struct kvm_vm *vm, uint64_t=
 attributes)
> >       memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
> >       free(cpuid);
> >
> > +     tdx_check_attributes(vm, attributes);
> > +
> >       init_vm->attributes =3D attributes;
> >
> >       tdx_apply_cpuid_restrictions(&init_vm->cpuid);
>
> Do we need to set the init_vm->xfam based on cpuid.0xd and validate it wi=
th tdx_cap->supported_xfam?
>
I don't think it's necessary. And according to the TDX spec (TDX
Module Base Spec - 11.8.3. Extended Features Execution Control) the
mapping from CPUID to XFAM is not trivial. Checking attributes makes
sense since some tests use non-default attributes but right now we
don't have any test which uses XFAM features. We can add XFAM support
in the future if it's needed and do the check then.

