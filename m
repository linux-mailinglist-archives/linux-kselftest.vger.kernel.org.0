Return-Path: <linux-kselftest+bounces-43686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FAEBF9031
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 00:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B33018A76CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 22:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486E6258ED1;
	Tue, 21 Oct 2025 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h/W+7Lqs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E436295DBD
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761084733; cv=none; b=tpiUriorotiHaBhvu+ARAAEpJE2kQ3EnzXh47jYUuTf3W+V3JLArh1oMucbhz7CWzwVpcJ8RmkkmRnzWk6Xnsm4JDYGypoEkTHeGz1rNdil4sstLXhRY6JdpUV0Vc9beOEIfCEiDNf9Xgs6J1XlT13NeeS75VwvU/1kY3AgzBrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761084733; c=relaxed/simple;
	bh=XRVho6x3CAXpDYPRoaypne+v5vxgk7Rk+Y/8muoiTwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mF7s6sZ9odEWq3zFqDW273V3AyJczMSHlT5YBSdT9dOOIwqHkBdN3QDPqjsrdVcpdeRF9HFof82cW/6J8+n7+cq+DL4mJTAdXCqWLp9VVGY72h23qkRozAKD5u2rY96apIIsTcs34cl5Qh9yeY9uy04Wjm5w+67GMIULXT0JUSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h/W+7Lqs; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so2351a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 15:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761084730; x=1761689530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7eLrXTSNrcJmCzKV8hcGeZgYUynnNUc8ztGtDOV+aI=;
        b=h/W+7Lqsp6SzCfXytpOMgPlepll/2rc1igi6LKjua9y/JP/X9ORMR73SoScwwi5NhU
         dXnAU5Vw0eVu/B7hMNFUN06Op8LstoqlrNpoCvXWok2HWaoDn78UIg0p61Qc3xUfXINH
         DKlrQwPV+A1XGShajV7e17QAJc1h5xLDjRsAX3EMAKWx25JLaMeCrb8mwovn3xw9gi5V
         JFmaPN8UNADH5+8YUYlDOpQ3n4NCjUDjFPUN6hTreKwxTLphbpUNvnQqnaNAyN7dippW
         2OFJfsoipm69W0n8mMDdG0YtFTkZ5Oe9MLAtDWGZCXKJh7HQS4EIYurzr6KA9xEeoECo
         foqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761084730; x=1761689530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7eLrXTSNrcJmCzKV8hcGeZgYUynnNUc8ztGtDOV+aI=;
        b=KH0rWSTE9hMNK8ESRXx62nSM6Pl85pfNXaOd1Iky5XS4KyWMXKq9rk08te0VrSjt9m
         ujWzS85fgvcqrZ40YjmoccYkvukifcBNMli5mZAQpRG9PqEgDO+ahTHDIbOMmE1vrHjt
         fovfYnYerHjYzcPNDJr3VFs97O7d9LAwU8yk3EklijwtgR5ifWAGSGZUcb4g3BaEay2L
         Hs1oS2fOEHLPZCboYD93tI9iXE1pnR2CxZNfBemdxEZbyKMxY884d2z0bbus9wBLrtIX
         hL5SU1z/5Tds2cjkaUBJ7mOiS77xI1xzlrcYr2XLUlHNb4HuWB51AMQ9VmoqnU6ITyWZ
         dSHg==
X-Forwarded-Encrypted: i=1; AJvYcCU5tetjmZk3MNnHwksobC1yKMNbyYNY1Vp/6cSGpgr75RGbt7naDkieK+4+60Gb1q6GcA1jGKfA5skYNrTJmCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xcpxn/RbSYmXnPFW4Lw00BW7hIwj4VWFBRO89wEnXU75xzI8
	NWN0RLSsgFgiGPVECz2f2MmfDzNCM20Fw36jjwZ2h5Dra5jGZz1Z8HVXYITGYqlIRkeOd2oHhIj
	7xFDjRx3wrwgkf86tdjUAh9VjgJmg02GbhgPLPTHp
X-Gm-Gg: ASbGncsPkECx63HV+9yR7zZBWq3WfTypZ//vt8t4gEM+ajpDIBSVcTuTCgzhmSc4ciC
	bQAU9Vg3gZysV2WktKguKbRFUDNCeY5A4EKknwUOhzusvoLLOz7cbE30Ujp3Ht1pamYCCPg86bh
	QNWO5f/tIsyG7N8D4OtycoZ+pDWOdvdbafgQeciahb9FRltz44Muud+vZtNe0IEePWFGAMOAGEf
	acvShQZDOVbtGWDCDvZk2XU3qW3J0n/61/CxfKAzh3scUb0AA90pMEIHp5P
X-Google-Smtp-Source: AGHT+IEDfmQOTJ5uUHv+b9t2BTyp4nF+vwssE+QpElDc/3BLDlaDr87JmIuKIzE91n4JGIZIVijGfX21oevNWu7t2CU=
X-Received: by 2002:a05:6402:1609:b0:634:b4b5:896f with SMTP id
 4fb4d7f45d1cf-63e19703191mr36229a12.4.1761084729562; Tue, 21 Oct 2025
 15:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917215031.2567566-1-jmattson@google.com> <20250917215031.2567566-3-jmattson@google.com>
 <o7m5gh76crbgzlfvq4lbp6ymuzbgze25qphlhsezl2ox5rfjuv@3xh7gqh5dmlt>
In-Reply-To: <o7m5gh76crbgzlfvq4lbp6ymuzbgze25qphlhsezl2ox5rfjuv@3xh7gqh5dmlt>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 21 Oct 2025 15:11:56 -0700
X-Gm-Features: AS18NWCZB-uPByh2zmyeyJUrBhWozotqzpuihhT1Sdzsic8Gvc4nBEp7Rj2-7nI
Message-ID: <CALMp9eRK7d1GF6Kqhji_KFz2+5jEs5JgbvyiCrqCiW_ZZiaoWQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] KVM: selftests: Use a loop to walk guest page tables
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 10:21=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev=
> wrote:
>
> On Wed, Sep 17, 2025 at 02:48:38PM -0700, Jim Mattson wrote:
> > Walk the guest page tables via a loop when searching for a PTE,
> > instead of using unique variables for each level of the page tables.
> >
> > This simplifies the code and makes it easier to support 5-level paging
> > in the future.
> >
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  .../testing/selftests/kvm/lib/x86/processor.c | 21 +++++++------------
> >  1 file changed, 8 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/te=
sting/selftests/kvm/lib/x86/processor.c
> > index 0238e674709d..433365c8196d 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> > @@ -270,7 +270,8 @@ static bool vm_is_target_pte(uint64_t *pte, int *le=
vel, int current_level)
> >  uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
> >                                   int *level)
> >  {
> > -     uint64_t *pml4e, *pdpe, *pde;
> > +     uint64_t *pte =3D &vm->pgd;
> > +     int current_level;
> >
> >       TEST_ASSERT(!vm->arch.is_pt_protected,
> >                   "Walking page tables of protected guests is impossibl=
e");
> > @@ -291,19 +292,13 @@ uint64_t *__vm_get_page_table_entry(struct kvm_vm=
 *vm, uint64_t vaddr,
> >       TEST_ASSERT(vaddr =3D=3D (((int64_t)vaddr << 16) >> 16),
> >               "Canonical check failed.  The virtual address is invalid.=
");
> >
> > -     pml4e =3D virt_get_pte(vm, &vm->pgd, vaddr, PG_LEVEL_512G);
> > -     if (vm_is_target_pte(pml4e, level, PG_LEVEL_512G))
> > -             return pml4e;
> > -
> > -     pdpe =3D virt_get_pte(vm, pml4e, vaddr, PG_LEVEL_1G);
> > -     if (vm_is_target_pte(pdpe, level, PG_LEVEL_1G))
> > -             return pdpe;
> > -
> > -     pde =3D virt_get_pte(vm, pdpe, vaddr, PG_LEVEL_2M);
> > -     if (vm_is_target_pte(pde, level, PG_LEVEL_2M))
> > -             return pde;
> > +     for (current_level =3D vm->pgtable_levels; current_level > 0; cur=
rent_level--) {
>
> This should be current_level >=3D PG_LEVEL_4K. It's the same, but easier
> to read.
>
> > +             pte =3D virt_get_pte(vm, pte, vaddr, current_level);
> > +             if (vm_is_target_pte(pte, level, current_level))
>
> Seems like vm_is_target_pte() is written with the assumption that it
> operates on an upper-level PTE, but I think it works on 4K PTEs as well.

I believe it does. Would you prefer that I exit the loop before
PG_LEVEL_4K and restore the virt_get_pte() below?

> > +                     return pte;
> > +     }
> >
> > -     return virt_get_pte(vm, pde, vaddr, PG_LEVEL_4K);
> > +     return pte;
> >  }
> >
> >  uint64_t *vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr)
> > --
> > 2.51.0.470.ga7dc726c21-goog
> >

