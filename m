Return-Path: <linux-kselftest+bounces-1849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AB7811917
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 17:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F824B20D49
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2715B33CF1;
	Wed, 13 Dec 2023 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="d6qh7Xut"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3955F4
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 08:20:57 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-28659348677so5525000a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 08:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702484457; x=1703089257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIJjv+e0tTxf8PNAHYeP7fkm8EBld5oupHXn0lAaJpk=;
        b=d6qh7Xut8AmuUTLCdpkiPOdby63QOfFSI4lSJ8Mu68Eei5YpHiZhjwF2EmszS7wdfh
         +FVJeaP0emZYytQFOjFGFyyMyVxYiF+Rug567Iu6Rmsx6de8ieYZmighvc2b1Ohmq1Gg
         hnOdAmq6g2gwBNs8VRPWhqiMXgRDZVSllDqc0a66kPoo/88Fw4d2ua0CrAkdAIhIci/G
         xPtxRbje2eaBOPTgyQjUAYfwXnpa6wxNS08u0nL0QYwIUQfSymfAWIUU557zHabiXeoO
         KAj0C389iMlDdnVjn/wgTwlam5r/D8cdETlgmrMWqCgXfdfYqZrvSwaGQxfZ2eaYqEEo
         izmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484457; x=1703089257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIJjv+e0tTxf8PNAHYeP7fkm8EBld5oupHXn0lAaJpk=;
        b=nlTez4+s5Z2H6SPVhn/q3UrrV9gThStZQiVIBIc7dJqhsh6xLPZ3wtHHUqLXswQyU6
         ojWTYfb4gevPoYdl7npeTVze0oz/JKCPojkchdPx/s01PLh9zgJ1DoVDju7Ds5cLKhfF
         9AffUrF9pNuSJA+eYxZ3SsRHBkm/C9hLdbE093hlXVl2h8P9m8NsxzLvagRYP3IaMH3+
         pi4d8KwqerXmG8kwjfQtXCIcuUW+uxyfdwhwsSivGMBkn4lTUqzCpgaUP5tuv3O4wQsg
         6aeTR1lme+5PEpePg1YuWXwyjM+7NBp2k88xjlIRs8++xqeeNVG7cDkVxkhRZLRtVNxr
         mVMQ==
X-Gm-Message-State: AOJu0YynSxXYE+eqPhnMlJTY6tUMPAEHnqBVvZ+kbHRRMiqJBk7+HEkn
	+JPysoA7W+3ZieJcqrUozxVOLGzzzWWbz6XNOiktgg==
X-Google-Smtp-Source: AGHT+IEjzcK13S4bpQjHvkP/WNLaAwG8IF+WhDBPm+KYbX9sTlmVKVPfIA+3J8TrHXDfS/9GnhkMO7Q29MoC2FkpLPA=
X-Received: by 2002:a17:90b:1298:b0:280:280c:efe3 with SMTP id
 fw24-20020a17090b129800b00280280cefe3mr8682239pjb.14.1702484457249; Wed, 13
 Dec 2023 08:20:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128145357.413321-1-apatel@ventanamicro.com>
 <20231128145357.413321-2-apatel@ventanamicro.com> <20231213-f8c7c8ca94f67631dfa97631@orel>
In-Reply-To: <20231213-f8c7c8ca94f67631dfa97631@orel>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 13 Dec 2023 21:50:45 +0530
Message-ID: <CAAhSdy0ehPWpbcny3oxOF+_=7x69zJ81dOEhg5rhCN+vQci9DA@mail.gmail.com>
Subject: Re: [PATCH 01/15] KVM: riscv: selftests: Generate ISA extension
 reg_list using macros
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, devicetree@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 9:22=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Tue, Nov 28, 2023 at 08:23:43PM +0530, Anup Patel wrote:
> > Various ISA extension reg_list have common pattern so let us generate
> > these using macros.
> >
> > We define two macros for the above purpose:
> > 1) KVM_ISA_EXT_SIMPLE_CONFIG - Macro to generate reg_list for
> >    ISA extension without any additional ONE_REG registers
> > 2) KVM_ISA_EXT_SUBLIST_CONFIG - Macro to generate reg_list for
> >    ISA extension with additional ONE_REG registers
>
> This patch also adds the missing config for svnapot.
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks Drew, I am queuing this one patch so that others can rebase
on the RISC-V KVM queue. Other patches of this series, will have to
wait for dependent patches to be merged by Palmer.

Queued this patch for Linux-6.8.

Regards,
Anup

>
> Thanks,
> drew
>
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  .../selftests/kvm/riscv/get-reg-list.c        | 331 ++++--------------
> >  1 file changed, 76 insertions(+), 255 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/t=
esting/selftests/kvm/riscv/get-reg-list.c
> > index 6bedaea95395..b6b4b6d7dacd 100644
> > --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > @@ -581,10 +581,6 @@ static __u64 base_skips_set[] =3D {
> >       KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_=
RISCV_TIMER_REG(state),
> >  };
> >
> > -static __u64 h_regs[] =3D {
> > -     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_H,
> > -};
> > -
> >  static __u64 zicbom_regs[] =3D {
> >       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_R=
EG_RISCV_CONFIG_REG(zicbom_block_size),
> >       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_ZICBOM,
> > @@ -595,54 +591,6 @@ static __u64 zicboz_regs[] =3D {
> >       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_ZICBOZ,
> >  };
> >
> > -static __u64 svpbmt_regs[] =3D {
> > -     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_SVPBMT,
> > -};
> > -
> > -static __u64 sstc_regs[] =3D {
> > -     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_SSTC,
> > -};
> > -
> > -static __u64 svinval_regs[] =3D {
> > -     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_SVINVAL,
> > -};
> > -
> > -static __u64 zihintpause_regs[] =3D {
> > -     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_ZIHINTPAUSE,
> > -};
> > -
> > -static __u64 zba_regs[] =3D {
> > -     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_ZBA,
> > -};
> > -
> > -static __u64 zbb_regs[] =3D {
> > -     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_ZBB,
> > -};
> > -
> > -static __u64 zbs_regs[] =3D {
> > -     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_ZBS,
> > -};
> > -
> > -static __u64 zicntr_regs[] =3D {
> > -     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_ZICNTR,
> > -};
> > -
> > -static __u64 zicond_regs[] =3D {
> > -     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_ZICOND,
> > -};
> > -
> > -static __u64 zicsr_regs[] =3D {
> > -     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_ZICSR,
> > -};
> > -
> > -static __u64 zifencei_regs[] =3D {
> > -     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_ZIFENCEI,
> > -};
> > -
> > -static __u64 zihpm_regs[] =3D {
> > -     KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_ZIHPM,
> > -};
> > -
> >  static __u64 aia_regs[] =3D {
> >       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_=
RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect),
> >       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_=
RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1),
> > @@ -733,221 +681,94 @@ static __u64 fp_d_regs[] =3D {
> >       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_D,
> >  };
> >
> > -#define BASE_SUBLIST \
> > +#define SUBLIST_BASE \
> >       {"base", .regs =3D base_regs, .regs_n =3D ARRAY_SIZE(base_regs), =
\
> >        .skips_set =3D base_skips_set, .skips_set_n =3D ARRAY_SIZE(base_=
skips_set),}
> > -#define H_REGS_SUBLIST \
> > -     {"h", .feature =3D KVM_RISCV_ISA_EXT_H, .regs =3D h_regs, .regs_n=
 =3D ARRAY_SIZE(h_regs),}
> > -#define ZICBOM_REGS_SUBLIST \
> > +#define SUBLIST_ZICBOM \
> >       {"zicbom", .feature =3D KVM_RISCV_ISA_EXT_ZICBOM, .regs =3D zicbo=
m_regs, .regs_n =3D ARRAY_SIZE(zicbom_regs),}
> > -#define ZICBOZ_REGS_SUBLIST \
> > +#define SUBLIST_ZICBOZ \
> >       {"zicboz", .feature =3D KVM_RISCV_ISA_EXT_ZICBOZ, .regs =3D zicbo=
z_regs, .regs_n =3D ARRAY_SIZE(zicboz_regs),}
> > -#define SVPBMT_REGS_SUBLIST \
> > -     {"svpbmt", .feature =3D KVM_RISCV_ISA_EXT_SVPBMT, .regs =3D svpbm=
t_regs, .regs_n =3D ARRAY_SIZE(svpbmt_regs),}
> > -#define SSTC_REGS_SUBLIST \
> > -     {"sstc", .feature =3D KVM_RISCV_ISA_EXT_SSTC, .regs =3D sstc_regs=
, .regs_n =3D ARRAY_SIZE(sstc_regs),}
> > -#define SVINVAL_REGS_SUBLIST \
> > -     {"svinval", .feature =3D KVM_RISCV_ISA_EXT_SVINVAL, .regs =3D svi=
nval_regs, .regs_n =3D ARRAY_SIZE(svinval_regs),}
> > -#define ZIHINTPAUSE_REGS_SUBLIST \
> > -     {"zihintpause", .feature =3D KVM_RISCV_ISA_EXT_ZIHINTPAUSE, .regs=
 =3D zihintpause_regs, .regs_n =3D ARRAY_SIZE(zihintpause_regs),}
> > -#define ZBA_REGS_SUBLIST \
> > -     {"zba", .feature =3D KVM_RISCV_ISA_EXT_ZBA, .regs =3D zba_regs, .=
regs_n =3D ARRAY_SIZE(zba_regs),}
> > -#define ZBB_REGS_SUBLIST \
> > -     {"zbb", .feature =3D KVM_RISCV_ISA_EXT_ZBB, .regs =3D zbb_regs, .=
regs_n =3D ARRAY_SIZE(zbb_regs),}
> > -#define ZBS_REGS_SUBLIST \
> > -     {"zbs", .feature =3D KVM_RISCV_ISA_EXT_ZBS, .regs =3D zbs_regs, .=
regs_n =3D ARRAY_SIZE(zbs_regs),}
> > -#define ZICNTR_REGS_SUBLIST \
> > -     {"zicntr", .feature =3D KVM_RISCV_ISA_EXT_ZICNTR, .regs =3D zicnt=
r_regs, .regs_n =3D ARRAY_SIZE(zicntr_regs),}
> > -#define ZICOND_REGS_SUBLIST \
> > -     {"zicond", .feature =3D KVM_RISCV_ISA_EXT_ZICOND, .regs =3D zicon=
d_regs, .regs_n =3D ARRAY_SIZE(zicond_regs),}
> > -#define ZICSR_REGS_SUBLIST \
> > -     {"zicsr", .feature =3D KVM_RISCV_ISA_EXT_ZICSR, .regs =3D zicsr_r=
egs, .regs_n =3D ARRAY_SIZE(zicsr_regs),}
> > -#define ZIFENCEI_REGS_SUBLIST \
> > -     {"zifencei", .feature =3D KVM_RISCV_ISA_EXT_ZIFENCEI, .regs =3D z=
ifencei_regs, .regs_n =3D ARRAY_SIZE(zifencei_regs),}
> > -#define ZIHPM_REGS_SUBLIST \
> > -     {"zihpm", .feature =3D KVM_RISCV_ISA_EXT_ZIHPM, .regs =3D zihpm_r=
egs, .regs_n =3D ARRAY_SIZE(zihpm_regs),}
> > -#define AIA_REGS_SUBLIST \
> > +#define SUBLIST_AIA \
> >       {"aia", .feature =3D KVM_RISCV_ISA_EXT_SSAIA, .regs =3D aia_regs,=
 .regs_n =3D ARRAY_SIZE(aia_regs),}
> > -#define SMSTATEEN_REGS_SUBLIST \
> > +#define SUBLIST_SMSTATEEN \
> >       {"smstateen", .feature =3D KVM_RISCV_ISA_EXT_SMSTATEEN, .regs =3D=
 smstateen_regs, .regs_n =3D ARRAY_SIZE(smstateen_regs),}
> > -#define FP_F_REGS_SUBLIST \
> > +#define SUBLIST_FP_F \
> >       {"fp_f", .feature =3D KVM_RISCV_ISA_EXT_F, .regs =3D fp_f_regs, \
> >               .regs_n =3D ARRAY_SIZE(fp_f_regs),}
> > -#define FP_D_REGS_SUBLIST \
> > +#define SUBLIST_FP_D \
> >       {"fp_d", .feature =3D KVM_RISCV_ISA_EXT_D, .regs =3D fp_d_regs, \
> >               .regs_n =3D ARRAY_SIZE(fp_d_regs),}
> >
> > -static struct vcpu_reg_list h_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     H_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list zicbom_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     ZICBOM_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list zicboz_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     ZICBOZ_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list svpbmt_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     SVPBMT_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list sstc_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     SSTC_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list svinval_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     SVINVAL_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list zihintpause_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     ZIHINTPAUSE_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list zba_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     ZBA_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list zbb_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     ZBB_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list zbs_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     ZBS_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list zicntr_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     ZICNTR_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list zicond_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     ZICOND_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list zicsr_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     ZICSR_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list zifencei_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     ZIFENCEI_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list zihpm_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     ZIHPM_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list aia_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     AIA_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list smstateen_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     SMSTATEEN_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list fp_f_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     FP_F_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > -
> > -static struct vcpu_reg_list fp_d_config =3D {
> > -     .sublists =3D {
> > -     BASE_SUBLIST,
> > -     FP_D_REGS_SUBLIST,
> > -     {0},
> > -     },
> > -};
> > +#define KVM_ISA_EXT_SIMPLE_CONFIG(ext, extu)                 \
> > +static __u64 regs_##ext[] =3D {                                       =
 \
> > +     KVM_REG_RISCV | KVM_REG_SIZE_ULONG |                    \
> > +     KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_##extu,       \
> > +};                                                           \
> > +static struct vcpu_reg_list config_##ext =3D {                 \
> > +     .sublists =3D {                                           \
> > +             SUBLIST_BASE,                                   \
> > +             {                                               \
> > +                     .name =3D #ext,                           \
> > +                     .feature =3D KVM_RISCV_ISA_EXT_##extu,    \
> > +                     .regs =3D regs_##ext,                     \
> > +                     .regs_n =3D ARRAY_SIZE(regs_##ext),       \
> > +             },                                              \
> > +             {0},                                            \
> > +     },                                                      \
> > +}                                                            \
> > +
> > +#define KVM_ISA_EXT_SUBLIST_CONFIG(ext, extu)                        \
> > +static struct vcpu_reg_list config_##ext =3D {                 \
> > +     .sublists =3D {                                           \
> > +             SUBLIST_BASE,                                   \
> > +             SUBLIST_##extu,                                 \
> > +             {0},                                            \
> > +     },                                                      \
> > +}                                                            \
> > +
> > +/* Note: The below list is alphabetically sorted. */
> > +
> > +KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
> > +KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
> > +KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
> > +KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
> > +KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
> > +KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
> > +KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
> > +KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
> > +KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
> > +KVM_ISA_EXT_SIMPLE_CONFIG(zba, ZBA);
> > +KVM_ISA_EXT_SIMPLE_CONFIG(zbb, ZBB);
> > +KVM_ISA_EXT_SIMPLE_CONFIG(zbs, ZBS);
> > +KVM_ISA_EXT_SUBLIST_CONFIG(zicbom, ZICBOM);
> > +KVM_ISA_EXT_SUBLIST_CONFIG(zicboz, ZICBOZ);
> > +KVM_ISA_EXT_SIMPLE_CONFIG(zicntr, ZICNTR);
> > +KVM_ISA_EXT_SIMPLE_CONFIG(zicond, ZICOND);
> > +KVM_ISA_EXT_SIMPLE_CONFIG(zicsr, ZICSR);
> > +KVM_ISA_EXT_SIMPLE_CONFIG(zifencei, ZIFENCEI);
> > +KVM_ISA_EXT_SIMPLE_CONFIG(zihintpause, ZIHINTPAUSE);
> > +KVM_ISA_EXT_SIMPLE_CONFIG(zihpm, ZIHPM);
> >
> >  struct vcpu_reg_list *vcpu_configs[] =3D {
> > -     &h_config,
> > -     &zicbom_config,
> > -     &zicboz_config,
> > -     &svpbmt_config,
> > -     &sstc_config,
> > -     &svinval_config,
> > -     &zihintpause_config,
> > -     &zba_config,
> > -     &zbb_config,
> > -     &zbs_config,
> > -     &zicntr_config,
> > -     &zicond_config,
> > -     &zicsr_config,
> > -     &zifencei_config,
> > -     &zihpm_config,
> > -     &aia_config,
> > -     &smstateen_config,
> > -     &fp_f_config,
> > -     &fp_d_config,
> > +     &config_aia,
> > +     &config_fp_f,
> > +     &config_fp_d,
> > +     &config_h,
> > +     &config_smstateen,
> > +     &config_sstc,
> > +     &config_svinval,
> > +     &config_svnapot,
> > +     &config_svpbmt,
> > +     &config_zba,
> > +     &config_zbb,
> > +     &config_zbs,
> > +     &config_zicbom,
> > +     &config_zicboz,
> > +     &config_zicntr,
> > +     &config_zicond,
> > +     &config_zicsr,
> > +     &config_zifencei,
> > +     &config_zihintpause,
> > +     &config_zihpm,
> >  };
> >  int vcpu_configs_n =3D ARRAY_SIZE(vcpu_configs);
> > --
> > 2.34.1
> >

