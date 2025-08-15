Return-Path: <linux-kselftest+bounces-39047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2680BB277C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 06:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A0CA283F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 04:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A637221FC3;
	Fri, 15 Aug 2025 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ImAlz7yy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C4A21A43C
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 04:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755232169; cv=none; b=VugJnWKsewhV4Ny3ML8HOJtO24aF6be2444jHX8YNJ+Phg/k1Bs4wCA81KSZGEcKqW5R5XwP9ewg1aSolOcHjQjBNttMuXEC1kmAzU170jmA4UMg87Ng9NWNFurZaIaaGChVJPAUe/xC9aqA/k0rSFGEIN7HXZdBHuk739glviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755232169; c=relaxed/simple;
	bh=9qtLzM3OMwo2/FzKkbwn/dx6wo+sTX2QjA8OuyejtkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsTHuOUIS3nE/CI0pIhGtK5QeM7h7Q3KJLYc+l22yIirXR6kFZYbgQQSCtvSJ1a99IVNOvlKTdV26XzC9iceaFtTDJuIjmxlzYPTyl+HDkUaqbJOSDzrmT4/f20C4haKO7b4dyEC8H+B1SC4ZeH52Np8PnjFQy0p2xlJSBIoGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ImAlz7yy; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b0bd88ab8fso153841cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 21:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755232166; x=1755836966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWx+VXe6pkrLJ/ya8qipLPY+dN8/8pvnFFipbxwAgkE=;
        b=ImAlz7yy4s4FlecQsW83CBuE48y8zLOMoCGsBGvvMjcoedhzpMTD5UvefHfBtecAI0
         xojsP8jur9vpPR0v2uamD9eUiRfxW0E15Mx5yZeuKFvRBbHpuX4PeSLz2Sg2d/eNHHU2
         9Q882fJasrsKEWaKhzncnoFZALVAdRx7SaEtev89iMUcEEKFuhstetx3i7Nywp3Z/r2H
         mD1LOIh69gP6FBWrcutxhUjZg9YzZkao/GmghHixAbVx7QoiW8WnVs2pe2O1KW98zE7b
         8OvVe4/9jwGvpwHcT1Kl8zmbM6Lxvj5kbzeefPSK+mx5p5T57VIZkhU+hvAegv+5P2cM
         9HvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755232166; x=1755836966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWx+VXe6pkrLJ/ya8qipLPY+dN8/8pvnFFipbxwAgkE=;
        b=opLHB6fIJ5JT+oa/j0bQmBQMcd+mosnEeGIxYU39ZrU4Q2Nx9XZPRTzNM0uOK7OkLJ
         x+NuEI9Rm7NKbDNCV+EzOL/HApVbUUOGA5toghV9gnGl8lUJLp1Xp70+V+vW801MMmnw
         EmpFoRSG4dTRvV6At7Gv6REZUVs5uFc10/GtOKZNEqtelHNHHLi7fnf9j6L9ibVvpT3n
         SLiWsOLo1xxGSb1SLJI2Zl9dM1p5IovPUdbyueB79J43Ntq9ptqVwcpYxhH+RL4ZZE8i
         E1QFuVh5eBgGo+Mad2uIoY5gWdQC9aVfJ9cZBoD3jNmKBKnUNWQNCxys7AnoxflrBSi1
         uSQg==
X-Gm-Message-State: AOJu0Ywk7xBxO6V6gN/4LIdwp/MWuPjtFz8pdGWV/wqq8ejgQb0IPQyz
	hk4Nc3DAKHX9J/dNGOH32i/EYR/u4Hqgm9Aeh1St4RQ94A/QiFSCgvlO+i2SNssA5t4BMU87PLl
	CX6xOrTOnXRah+6Ug4ts5PMeD5HyStomu73NworLV
X-Gm-Gg: ASbGncsPNOKsPVFx5jJbJ6HzcqICvXrF2xihuF0Qba9fCWUTgm5MmoVud+3fLF+4Hc3
	Ldk32uDSGTnd4MI1qcuvOdfiuL8B1lg/QlxzvULHLIxwvxfUhsM4iQPILIeVvhnHWQ983wYR0+3
	Tt66ljnnjEJPZlCOjs0uFvTQSU79qJqyezUj5FtNHI0dB9+rrMVdpC3utO2jotCvijJZDM+MHsU
	rdriJAxClcJyo928sUsCXdcS7BJ+70SB2YqcgSgGGwaTA==
X-Google-Smtp-Source: AGHT+IGTtCmo/WAwL9qd6ot9c+qQQtNLBBQttgktMp1bBoCOYQo//YJrWIr7SF3H6IOFL2A8Yr9maEGnIsMwfMMHVkA=
X-Received: by 2002:a05:622a:3cf:b0:4a5:9af6:8f84 with SMTP id
 d75a77b69052e-4b119e98f42mr2662581cf.14.1755232166261; Thu, 14 Aug 2025
 21:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-5-sagis@google.com>
 <aJo1kNCUzAe2TFAz@google.com>
In-Reply-To: <aJo1kNCUzAe2TFAz@google.com>
From: Sagi Shahar <sagis@google.com>
Date: Thu, 14 Aug 2025 23:29:15 -0500
X-Gm-Features: Ac12FXwmZv9OAmjGbMnmrilv68VWgFEkOUK30MUJ6RwqLVrDrhJagqwxaB4xWV0
Message-ID: <CAAhR5DGdCx9XzBc9ZpgV3ckG_-6NB-DvPT3QG8ScPj+EW-34uA@mail.gmail.com>
Subject: Re: [PATCH v8 04/30] KVM: selftests: Add vCPU descriptor table
 initialization utility
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:25=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Aug 07, 2025, Sagi Shahar wrote:
> > From: Ackerley Tng <ackerleytng@google.com>
> >
> > Turn vCPU descriptor table initialization into a utility for use by tes=
ts
> > needing finer control, for example for TDX TD creation.
>
> NAK.  "needing finer control" is not a sufficient explanation for why _th=
is_
> patch is necessary.  There's also zero argument made throughout any of th=
ese
> patches as to why this pattern:
>
>         vm =3D td_create();
>         td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
>         vcpu =3D td_vcpu_add(vm, 0, guest_io_writes);
>         td_finalize(vm);
>
> is the best approach.  IMO it is NOT the best approach.  I would much rat=
her we
> structure things so that creating TDs can use APIs like this:
>
> static inline struct kvm_vm *td_create_with_vcpus(uint32_t nr_vcpus,
>                                                   void *guest_code,
>                                                   struct kvm_vcpu *vcpus[=
])
> {
>         return __vm_create_with_vcpus(VM_SHAPE_TDX, nr_vcpus, 0, guest_co=
de, vcpus);
> }
>
> instead of open coding an entirely different set of APIs for creating TDs=
, which
> is not maintanable.

Dropping this patch in the next version.

