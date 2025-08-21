Return-Path: <linux-kselftest+bounces-39432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507CFB2ECA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B82A583CD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4432765CE;
	Thu, 21 Aug 2025 04:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLdElNwO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2173D1F3FEC
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 04:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755749722; cv=none; b=WshJJs7WW5z0/FqMMATY7F9Db6QgbsGGKNZBQjL4wF534bkGnvW7NdXw8I2lDoYGgWtHNYvZ8bIht+nShg2ohu0rwh9G+emoBXC8kw8BqnWQfBREWSspln1Tq69pDvKiX078W9nWW6lgMYTD80LbKBsUoKZmeRPJyIi3BTuBpE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755749722; c=relaxed/simple;
	bh=JdY1qJGiDV0gX5VeBSkpZuvK/MFWiTVeYr9Rr+KfHQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1faKrd3zlKCDwGtII7YxRsDhG1D6WJ0S6OyLSpRQn3+ZcRovhnIqVrfxNPhy/8QIckIV15vMqUZYQzZHxvJsCBw9IBcBv9oMdibLUpTIBagjkqtGMLjkkPM1t4Gb4/Y6oQM5w1YEq6tChhFn8fOx4FIMsI9jU9a9fwAB6y1wMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLdElNwO; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b12b123e48so188871cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 21:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755749720; x=1756354520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNaNAKyGPmX/d78vEdQ+QgbBQO1veoXBan2CooQjkMg=;
        b=CLdElNwOtEQr6lq/X7O3rzVpCYQu5nz9UCTQltSzEdArE7IRpgqfjUYkEVTEXZVZu8
         U/uWTpfo4GUnWn+wq/OoRgqdhT8+EH6CJZDD0+bOMoOnscu06UTJekh8+NN83hFWzPwE
         yLEq5VbbHHAQFvciGKOCzPCpXR24pnNuKAsQ7T/3KQxYQhIOvUkEuy7ORoS8AIDBQ1vI
         H/mcmyWqXOCSGW4HGbJUcIz3yB5LjssTUXpW4EXysm4qRCEbNBTk2il7NxNo29wU2Ky3
         R1GT3KnRhweIoUUGKlgg8gFNnxC1EoRO9kM8lMmvxRhNvnZAW9m/FUnTISzuzLUEo2OR
         xtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755749720; x=1756354520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNaNAKyGPmX/d78vEdQ+QgbBQO1veoXBan2CooQjkMg=;
        b=QJkuug8/F0lQaqORvmT8W/pCwlmokY7QmfwVT0WwnkQMCBGOW3p/Bv13HZeTiAr28b
         pSZdLOFLjZRgN20010kR5YnVE+R8jNgh4nWzZBVkXeL2hFkU6PiM5pnsuhrZtaSzMrYs
         VeqjaEoVkvab+EuOji9OgJ0ZLgupxDGQKI2UIJsB7QDQFdYy9OYE05F6NrTg52oI/NhD
         zCzf25V0HbQRq/cRTc9WSNyFLQlWGHsUPT+T182Gdor0nZ1xzj74ZfWoCTBsn3nXficN
         TlUTbJQxewlP43kZiQwwQjDu+wAymT69gBPGa01MzLHwZCt3R0UD6pqWnt+SlA/oHF9g
         iOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlut6FcFos1PUL6JrCQGR5MOcfdDbkvuabhTdMpxK/2h4LuFKcIGMuod3j9dIsLLqEEZDC5rac/kYxwn7zooA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRAJ+LXz5NVuAnRJmGwV03dAqOLH4FdSJrwssvp00Beff65isw
	SLfdXj2z11gKMH3x4Itty9+SY+IBxHeVteKqMySDhDha86SGsqGvFkD6jrFD/u/ppUnp5QpNYO9
	fapCvWiJverFvGCepnaWmIEAr5D4ldjeesfDhkd5v
X-Gm-Gg: ASbGncsVog11fuvYHI5QXvpwiw/IyCjQi/lSatCDeTR1S1gUp9CHSXJtrP7Wr2+jn/G
	OT02PzJUlqdmCQYPZpLIRjzY85+aimfzWy2vO0I30Pjzr+1ZwUcxYieQraZstjBAEyWDfqSoiJn
	5gr7cV37oSjWooBqNCg122IJpjWOVqR3bPMkLLXL6iRMhu6fk79tnJ0m2Kb+3nOyWjaaJbrWJl0
	iwsy6QGbpTBYuoCOxwrQbQQY1WQPsLIYUCQk9ugKm5Vfs9NuCbdaO+6SQ==
X-Google-Smtp-Source: AGHT+IHrvMTbTaOJLKUlQ8aFWOIq+tSI0SGfzvUHFpq0M56V8X0953CH98M1Fodt4Q9+4XLn0iKbo+FSiuKH6JDo1rY=
X-Received: by 2002:a05:622a:1aa0:b0:4a5:a83d:f50d with SMTP id
 d75a77b69052e-4b29fa06aadmr1948401cf.11.1755749719366; Wed, 20 Aug 2025
 21:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-7-sagis@google.com>
 <1348bb0bed9da95489b83312998352060ac3defb.camel@intel.com>
In-Reply-To: <1348bb0bed9da95489b83312998352060ac3defb.camel@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Wed, 20 Aug 2025 23:15:08 -0500
X-Gm-Features: Ac12FXzudqPDBGFHEJVLJoRihcQqYBZ4EHBHQUfTtFItOC_ZZmIjCuL7sKLyGB8
Message-ID: <CAAhR5DFUKnoi3+1=AufhDtPpGC-isfFJhTa9t9Zv5YmjigDv=w@mail.gmail.com>
Subject: Re: [PATCH v8 06/30] KVM: selftests: Add helper functions to create
 TDX VMs
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Aktas, Erdem" <erdemaktas@google.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"Afranji, Ryan" <afranji@google.com>, "Chatre, Reinette" <reinette.chatre@intel.com>, 
	"seanjc@google.com" <seanjc@google.com>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, 
	"pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"Wang, Roger" <runanwang@google.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:49=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Thu, 2025-08-07 at 13:16 -0700, Sagi Shahar wrote:
> > +#define XFEATURE_MASK_CET (XFEATURE_MASK_CET_USER | XFEATURE_MASK_CET_=
KERNEL)
> > +
> > +static void tdx_apply_cpuid_restrictions(struct kvm_cpuid2 *cpuid_data=
)
> > +{
> > +     for (int i =3D 0; i < cpuid_data->nent; i++) {
> > +             struct kvm_cpuid_entry2 *e =3D &cpuid_data->entries[i];
> > +
> > +             if (e->function =3D=3D 0xd && e->index =3D=3D 0) {
> > +                     /*
> > +                      * TDX module requires both XTILE_{CFG, DATA} to =
be set.
> > +                      * Both bits are required for AMX to be functiona=
l.
> > +                      */
> > +                     if ((e->eax & XFEATURE_MASK_XTILE) !=3D
> > +                         XFEATURE_MASK_XTILE) {
> > +                             e->eax &=3D ~XFEATURE_MASK_XTILE;
> > +                     }
> > +             }
> > +             if (e->function =3D=3D 0xd && e->index =3D=3D 1) {
> > +                     /*
> > +                      * TDX doesn't support LBR yet.
> > +                      * Disable bits from the XCR0 register.
> > +                      */
> > +                     e->ecx &=3D ~XFEATURE_MASK_LBR;
> > +                     /*
> > +                      * TDX modules requires both CET_{U, S} to be set=
 even
> > +                      * if only one is supported.
> > +                      */
> > +                     if (e->ecx & XFEATURE_MASK_CET)
> > +                             e->ecx |=3D XFEATURE_MASK_CET;
> > +             }
> > +     }
> > +}
>
> Since this is only going to be used control the directly configurable bit=
s, do
> we really need to do this? SET_CPUID2 will just get what comes out of
> KVM_TDX_GET_CPUID, so it should pick up the correct values.
>

This code is used before vcpus are created so KVM_TDX_GET_CPUID can't
be used here.

But either way, I removed this function in the next version.

>
> <snip>
>
> > +
> > +static void tdx_td_init(struct kvm_vm *vm, uint64_t attributes)
> > +{
> > +     struct kvm_tdx_init_vm *init_vm;
> > +     const struct kvm_cpuid2 *tmp;
> > +     struct kvm_cpuid2 *cpuid;
> > +
> > +     tmp =3D kvm_get_supported_cpuid();
> > +
> > +     cpuid =3D allocate_kvm_cpuid2(KVM_MAX_CPUID_ENTRIES);
> > +     memcpy(cpuid, tmp, kvm_cpuid2_size(tmp->nent));
> > +     tdx_mask_cpuid_features(cpuid);
> > +
> > +     init_vm =3D calloc(1, sizeof(*init_vm) +
> > +                      sizeof(init_vm->cpuid.entries[0]) * cpuid->nent)=
;
> > +     TEST_ASSERT(init_vm, "vm allocation failed");
> > +
> > +     memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
> > +     free(cpuid);
> > +
> > +     init_vm->attributes =3D attributes;
> > +
> > +     tdx_apply_cpuid_restrictions(&init_vm->cpuid);
> > +     tdx_filter_cpuid(vm, &init_vm->cpuid);
> > +
> > +     tdx_ioctl(vm->fd, KVM_TDX_INIT_VM, 0, init_vm);
> > +     free(init_vm);
> > +}
>
> We should comment the CPUID twiddling that happens here. It masks, filter=
s, and
> applies restrictions. Sounds like all the same thing.
>
>
>

