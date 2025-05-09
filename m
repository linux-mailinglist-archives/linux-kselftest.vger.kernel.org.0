Return-Path: <linux-kselftest+bounces-32723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F6CAB08CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE05D3B86E4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9BC23AE60;
	Fri,  9 May 2025 03:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="2llTUcHZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA57A64A8F
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 03:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760839; cv=none; b=LzcY+ZMUdB7a8nVyxKwHyZlYQUmI/W/06g7mnhQirujNYLWewt1RWVTK4B7pPKebQdXHPvxnNsQsQqqbfmHoob//UB8lFA/E/7/033vBrXylMOpnx+i09wXSZHpK6ku/iTT3rel1Xnq82kQZSytaEmIcPeMf+KpIP/dk/Gr8WhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760839; c=relaxed/simple;
	bh=QxYt6I37j8Y2FWScFRIV2InQ82omXNQYJHqU/dkoDOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhctWXKl5l8opVvzaks0G2iaA9xwm04bChmzMwBTu7ppHhfew0S08n5NHNsfS6Zv6ZU7wxd+S8xMQ1Np2jpjGxPs4mJc5GoYqaAw+Nk9DFDxq8KOFCh6dV4n5zVeHinNS+eUdinD4mss5HI676/Lk0esz+uOO7B2vm1RJI2XBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=2llTUcHZ; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d91db4f0c3so9032935ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 May 2025 20:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1746760836; x=1747365636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnqKcVSyirwFx4wEXZIT0zJRplLj4a3hbHksAZ3+SSo=;
        b=2llTUcHZLw6lkdSaA7SZ26rQk0pvWBtXZGqOKYRe+hJw77S5vZ4SUYziUG/BmQFSnH
         iAUW8p5quXkXaUI4KY36MXOxO6lDGF7CL/HUA1EA3WoKIaMc5xP4KUF/BL6BeLQQ29mS
         DjRzLbOIN0Uu0W+NQimB+37BjrZ/p9xeFkSLhEzlQZbwFj5Us6uOYqmOJqITUCn5Cz7t
         t0dzXGWvjO/gNfMK1CLqTXcu7YfppmCE3ryhiyrIqAGmoPszKdQg07Z2FVC3FbOGwuOM
         oKRCDaVz45uuFiK6a6+whegrPpMFa8ajXuNS36JA90h/Z8ojcvw/SL/P7oseeMYUNuCu
         10Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746760836; x=1747365636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnqKcVSyirwFx4wEXZIT0zJRplLj4a3hbHksAZ3+SSo=;
        b=RPzpEwp8uQFhi40c5Wh+Ri8Cf1GaSAuG3LxCX1fJLGdW+NrOuJAbzm6km2sJQAWH+T
         +GYXgWOQ6AhdsyAe7caz3z/50KmVU6fK/BuFjMiCg9KsnwXoRq4Pq5MdEEBfYZp6yi7l
         GhW9XMoTNYhNkdODZngv+Gk7DzGzNccrOaWfaR+3cdJ0qWMR/pMpCdfXYL67MVG37eqW
         Y0sOF/NjBS1Wbhp8mjxnSDtLEh/J9iXBrlflz2fZidPrX7LlM2YwiQPw2w6ixWABTvoM
         ApDEGCmjPYfVg02torTLUZx31L46j1v7p4y32jNwuEzf4evrHUaGuFmkNopmZmbipP2D
         oqLw==
X-Forwarded-Encrypted: i=1; AJvYcCWrUlwAQ5Qe5FdcAWqbuzuNCYz3zS258JpG1v6/EhuJ4Z+EMPwhBpe6UkJ23NyjkVECto45vMWD+u4GYWwc8KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBT1/AzBWEu3TZjYSMIAzYRypylYRij2OK86VbJKGPrYqTHbt4
	pNCUq4Ou4KwrZoQe7bcqt8ZUvstoOQex3go3p4BSEbOeUs+EP8/7IMSEC8uIp2CKI48o1gC+BJf
	wqYQ6pBMdjyiyHxIKfSwSR9OanVYO8NCJywgTOQ==
X-Gm-Gg: ASbGncu90OCN6Wh6LFu0LMhq+W+cXOHo8D2KTa1nf2k0sJb5XlOPAfJHViS4mqio5N/
	2PBpNPuRkH+ASfSlbF0PYFJTf/oOQsNaMrD4KcULOkYUJBszoKKbRmdZqhCBzeayKKViQKeVHVq
	vBCRUgySCLKpuVS56mI4u150k=
X-Google-Smtp-Source: AGHT+IGxJSJOfj/uPGDX0l9BVY/KPaOwcW52GGJrD6j3FDNArn7ULaOwfHRemocw3j7KZ3LWZVqMGaPpDr7hAfyxnxs=
X-Received: by 2002:a05:6e02:2292:b0:3d6:cd54:ba53 with SMTP id
 e9e14a558f8ab-3da7e21658cmr27127695ab.22.1746760835694; Thu, 08 May 2025
 20:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424173204.1948385-12-cleger@rivosinc.com> <mhng-0c7b576b-882d-4020-996d-adb1b2bbcc4b@palmer-ri-x1c9a>
In-Reply-To: <mhng-0c7b576b-882d-4020-996d-adb1b2bbcc4b@palmer-ri-x1c9a>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 9 May 2025 08:50:24 +0530
X-Gm-Features: ATxdqUHBve2EeFlPYflmLTkAF_hrOfFokX5MPn_gLZXF6fdS6VEfyoAB6lvQ_MY
Message-ID: <CAAhSdy1JspaC6aYjkMQn_fvjc1eFakdu2JMTQFuCzrh4h4o_3w@mail.gmail.com>
Subject: Re: [PATCH v6 11/14] RISC-V: KVM: add SBI extension init()/deinit() functions
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Atish Patra <atishp@rivosinc.com>, cleger@rivosinc.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, atishp@atishpatra.org, shuah@kernel.org, 
	corbet@lwn.net, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, samuel.holland@sifive.com, 
	ajones@ventanamicro.com, debug@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

On Thu, May 8, 2025 at 10:57=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Thu, 24 Apr 2025 10:31:58 PDT (-0700), cleger@rivosinc.com wrote:
> > The FWFT SBI extension will need to dynamically allocate memory and do
> > init time specific initialization. Add an init/deinit callbacks that
> > allows to do so.
> >
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/kvm_vcpu_sbi.h |  9 +++++++++
> >  arch/riscv/kvm/vcpu.c                 |  2 ++
> >  arch/riscv/kvm/vcpu_sbi.c             | 26 ++++++++++++++++++++++++++
> >  3 files changed, 37 insertions(+)
>
> There's 4 KVM patches in here without an Ack from Atish or Anup.
> They're all tied up in the SBIv3 stuff, so just LMK if you want me to
> take them into that staging branch or if you want me to wait.
>
> For now I'm going to go look at other stuff, no rush on my end.

The 4 KVM patches of this series should go through the KVM RISC-V
tree to avoid conflicts when it reaches Linus. I am okay doing a shared
tag for the first 10 patches.

Regards,
Anup

>
> >
> > diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include=
/asm/kvm_vcpu_sbi.h
> > index 4ed6203cdd30..bcb90757b149 100644
> > --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> > +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> > @@ -49,6 +49,14 @@ struct kvm_vcpu_sbi_extension {
> >
> >       /* Extension specific probe function */
> >       unsigned long (*probe)(struct kvm_vcpu *vcpu);
> > +
> > +     /*
> > +      * Init/deinit function called once during VCPU init/destroy. The=
se
> > +      * might be use if the SBI extensions need to allocate or do spec=
ific
> > +      * init time only configuration.
> > +      */
> > +     int (*init)(struct kvm_vcpu *vcpu);
> > +     void (*deinit)(struct kvm_vcpu *vcpu);
> >  };
> >
> >  void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run =
*run);
> > @@ -69,6 +77,7 @@ const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_fin=
d_ext(
> >  bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
> >  int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *ru=
n);
> >  void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
> > +void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
> >
> >  int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned lon=
g reg_num,
> >                                  unsigned long *reg_val);
> > diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> > index 60d684c76c58..877bcc85c067 100644
> > --- a/arch/riscv/kvm/vcpu.c
> > +++ b/arch/riscv/kvm/vcpu.c
> > @@ -185,6 +185,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu=
)
> >
> >  void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
> >  {
> > +     kvm_riscv_vcpu_sbi_deinit(vcpu);
> > +
> >       /* Cleanup VCPU AIA context */
> >       kvm_riscv_vcpu_aia_deinit(vcpu);
> >
> > diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> > index d1c83a77735e..3139f171c20f 100644
> > --- a/arch/riscv/kvm/vcpu_sbi.c
> > +++ b/arch/riscv/kvm/vcpu_sbi.c
> > @@ -508,5 +508,31 @@ void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu=
)
> >               scontext->ext_status[idx] =3D ext->default_disabled ?
> >                                       KVM_RISCV_SBI_EXT_STATUS_DISABLED=
 :
> >                                       KVM_RISCV_SBI_EXT_STATUS_ENABLED;
> > +
> > +             if (ext->init && ext->init(vcpu) !=3D 0)
> > +                     scontext->ext_status[idx] =3D KVM_RISCV_SBI_EXT_S=
TATUS_UNAVAILABLE;
> > +     }
> > +}
> > +
> > +void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu)
> > +{
> > +     struct kvm_vcpu_sbi_context *scontext =3D &vcpu->arch.sbi_context=
;
> > +     const struct kvm_riscv_sbi_extension_entry *entry;
> > +     const struct kvm_vcpu_sbi_extension *ext;
> > +     int idx, i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(sbi_ext); i++) {
> > +             entry =3D &sbi_ext[i];
> > +             ext =3D entry->ext_ptr;
> > +             idx =3D entry->ext_idx;
> > +
> > +             if (idx < 0 || idx >=3D ARRAY_SIZE(scontext->ext_status))
> > +                     continue;
> > +
> > +             if (scontext->ext_status[idx] =3D=3D KVM_RISCV_SBI_EXT_ST=
ATUS_UNAVAILABLE ||
> > +                 !ext->deinit)
> > +                     continue;
> > +
> > +             ext->deinit(vcpu);
> >       }
> >  }

