Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AAE70246D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 08:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbjEOGVc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 02:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjEOGVb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 02:21:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A5499;
        Sun, 14 May 2023 23:21:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24e09b4153eso8423636a91.2;
        Sun, 14 May 2023 23:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684131689; x=1686723689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5KcXSm8WFcedxDDrhapXrPCdZpvVQtw4gGehLHzKEU=;
        b=aROViLZz5mvC7TbPi+jUvy9D/wWUNBznyrr03rbM9yPbabZvgqkq3xLb9GKyPOHVAC
         MhF/+FdZcjADzijiOodszFZp/LAC5KLykNJ1+asmWntni3BI5gTYHPDELDA/WDe2yvqn
         kkLc7dNk6Unrx0ZQ4ss2vdwC9ATQESXiIPO5rHGlSFehZvR0bUL6p8lCPDLXUOklaYM8
         imtOA/PaTuImMzbRz7lyi3Un9MOQjkVwBCwWKDchV/NnqzP+XzmW94nmZr4emIgCweCe
         CozVwMvGLWf4a6zNE82o09j0c5G5cspp8kPorTCzI6PBp0jUG/9DE7FBxH0oJqHEqUJt
         ln+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684131689; x=1686723689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5KcXSm8WFcedxDDrhapXrPCdZpvVQtw4gGehLHzKEU=;
        b=dw8aYRg/s0eof6Q6JJwvafrlEJDBAucOuCqBtJ4ad6xvwcQFO7jP4iunxHNVSh2e/6
         S9clpYOto+vw3ss5CmY9lUxStJvmcfgDW9kvubDmmuWByJtkcwWMINU78oXisI0X1CX5
         P+qePfUdmZGp8eCkT5tBMo8AZ34XCMqqntBsjCO00euf0ukRYk02r/CGHv+SUuaE/Gj+
         GlZu8NMv3lBDXL4lwOsKXdnDLO7IP84dRZq0G0ZJmj2xFnXz9+JfR9iSL42zKN+NWUVF
         Wp/eLNS3vi/EOvWTxQDLGTUeCIMdxDFj9COnzXoEO98FBkiMLllzHE7emWjn8WiTL0Cp
         Zzcg==
X-Gm-Message-State: AC+VfDxkhxaEYph/YaesnPlUDGObV7cTRToMfFXXYQ+KEhRVARgUz+i+
        M2JbYq6/O7eKOXA7OBu8sRq+NLPGY01eso+hnoI=
X-Google-Smtp-Source: ACHHUZ7lSdsLhlRRqDXjuIVqn4OBKTafL6jKQF54bNpbwuknhMU2c5dzPg18Ijra5Jwxwy7jaD6r09Cc5AAyFfpewNg=
X-Received: by 2002:a17:90b:3881:b0:24e:4a1a:3994 with SMTP id
 mu1-20020a17090b388100b0024e4a1a3994mr32517309pjb.3.1684131689284; Sun, 14
 May 2023 23:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683791148.git.haibo1.xu@intel.com> <921fc2e1a91887170e277acb1b52df57480a5736.1683791148.git.haibo1.xu@intel.com>
 <20230511-5e8b478be55881a754cc2002@orel>
In-Reply-To: <20230511-5e8b478be55881a754cc2002@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Mon, 15 May 2023 14:21:17 +0800
Message-ID: <CAJve8on5CxNkzmfEPfmDSX=0quJL6iAoqMP+twBBw43QmTqdFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: kvm: Add KVM_GET_REG_LIST API support
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 11, 2023 at 6:44=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, May 11, 2023 at 05:22:48PM +0800, Haibo Xu wrote:
> > KVM_GET_REG_LIST API will return all registers that are available to
> > KVM_GET/SET_ONE_REG APIs. It's very useful to identify some platform
> > regression issue during VM migration.
> >
> > Since this API was already supported on arm64, it'd be straightforward
>
> s/it'd be/it is/
>
> > to enable it on riscv with similar code structure.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  Documentation/virt/kvm/api.rst |   2 +-
> >  arch/riscv/kvm/vcpu.c          | 346 +++++++++++++++++++++++++++++++++
> >  2 files changed, 347 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/ap=
i.rst
> > index add067793b90..280e89abd004 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -3499,7 +3499,7 @@ VCPU matching underlying host.
> >  ---------------------
> >
> >  :Capability: basic
> > -:Architectures: arm64, mips
> > +:Architectures: arm64, mips, riscv
> >  :Type: vcpu ioctl
> >  :Parameters: struct kvm_reg_list (in/out)
> >  :Returns: 0 on success; -1 on error
> > diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> > index 8bd9f2a8a0b9..fb8834e4fa15 100644
> > --- a/arch/riscv/kvm/vcpu.c
> > +++ b/arch/riscv/kvm/vcpu.c
> > @@ -657,6 +657,334 @@ static int kvm_riscv_vcpu_set_reg_isa_ext(struct =
kvm_vcpu *vcpu,
> >       return 0;
> >  }
> >
> > +static inline unsigned long num_config_regs(void)
> > +{
> > +     return sizeof(struct kvm_riscv_config) / sizeof(unsigned long);
> > +}
> > +
> > +static int copy_config_reg_indices(u64 __user *uindices)
> > +{
> > +     unsigned int i;
> > +     int n =3D num_config_regs();
> > +
> > +     for (i =3D 0; i < n; i++) {
> > +             u64 reg =3D KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RI=
SCV_CONFIG | i;
>                                           ^ this should be
>                                           size-ulong
>
>   u64 size =3D IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE=
_U64;
>   u64 reg =3D KVM_REG_RISCV | size | KVM_REG_RISCV_CONFIG | i;
>
> > +
> > +             if (uindices) {
> > +                     if (put_user(reg, uindices))
> > +                             return -EFAULT;
> > +                     uindices++;
> > +             }
> > +     }
> > +
> > +     return n;
> > +}
> > +
> > +static inline unsigned long num_core_regs(void)
> > +{
> > +     return sizeof(struct kvm_riscv_core) / sizeof(unsigned long);
> > +}
> > +
> > +static int copy_core_reg_indices(u64 __user *uindices)
> > +{
> > +     unsigned int i;
> > +     int n =3D num_core_regs();
> > +
> > +     for (i =3D 0; i < n; i++) {
> > +             u64 reg =3D KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RI=
SCV_CORE | i;
>                                           ^ size-ulong
>
> > +
> > +             if (uindices) {
> > +                     if (put_user(reg, uindices))
> > +                             return -EFAULT;
> > +                     uindices++;
> > +             }
> > +     }
> > +
> > +     return n;
> > +}
> > +
> > +static inline unsigned long num_csr_regs(void)
> > +{
> > +     unsigned long n =3D sizeof(struct kvm_riscv_csr) / sizeof(unsigne=
d long);
> > +
> > +     if (kvm_riscv_aia_available())
> > +             n +=3D sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned=
 long);
> > +
> > +     return n;
> > +}
> > +
> > +static int copy_csr_reg_indices(u64 __user *uindices)
> > +{
> > +     unsigned int i;
> > +     int n1 =3D sizeof(struct kvm_riscv_csr) / sizeof(unsigned long);
> > +     int n2 =3D 0;
> > +
> > +     /* copy general csr regs */
> > +     for (i =3D 0; i < n1; i++) {
> > +             u64 reg =3D KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RI=
SCV_CSR |
>                                           ^ size-ulong
>
> > +                               KVM_REG_RISCV_CSR_GENERAL | i;
> > +
> > +             if (uindices) {
> > +                     if (put_user(reg, uindices))
> > +                             return -EFAULT;
> > +                     uindices++;
> > +             }
> > +     }
> > +
> > +     /* copy AIA csr regs */
> > +     if (kvm_riscv_aia_available()) {
> > +             n2 =3D sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned=
 long);
> > +
> > +             for (i =3D 0; i < n2; i++) {
> > +                     u64 reg =3D KVM_REG_RISCV | KVM_REG_SIZE_U64 | KV=
M_REG_RISCV_CSR |
>                                                   ^ size-ulong
>
> > +                                       KVM_REG_RISCV_CSR_AIA | i;
> > +
> > +                     if (uindices) {
> > +                             if (put_user(reg, uindices))
> > +                                     return -EFAULT;
> > +                             uindices++;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return n1 + n2;
> > +}
> > +
> > +static inline unsigned long num_timer_regs(void)
> > +{
> > +     return sizeof(struct kvm_riscv_timer) / sizeof(unsigned long);
> > +}
> > +
> > +static int copy_timer_reg_indices(u64 __user *uindices)
> > +{
> > +     unsigned int i;
> > +     int n =3D num_timer_regs();
> > +
> > +     for (i =3D 0; i < n; i++) {
> > +             u64 reg =3D KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RI=
SCV_TIMER | i;
> > +
> > +             if (uindices) {
> > +                     if (put_user(reg, uindices))
> > +                             return -EFAULT;
> > +                     uindices++;
> > +             }
> > +     }
> > +
> > +     return n;
> > +}
> > +
> > +static inline unsigned long num_fp_f_regs(const struct kvm_vcpu *vcpu)
> > +{
> > +     const struct kvm_cpu_context *cntx =3D &vcpu->arch.guest_context;
> > +
> > +     if (riscv_isa_extension_available(vcpu->arch.isa, f))
> > +             return sizeof(cntx->fp.f) / sizeof(u32);
> > +     else
> > +             return 0;
> > +}
> > +
> > +static int copy_fp_f_reg_indices(const struct kvm_vcpu *vcpu,
> > +                                     u64 __user *uindices)
> > +{
> > +     unsigned int i;
> > +     int n =3D num_fp_f_regs(vcpu);
> > +
> > +     for (i =3D 0; i < n; i++) {
> > +             u64 reg =3D KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RI=
SCV_FP_F | i;
> > +
> > +             if (uindices) {
> > +                     if (put_user(reg, uindices))
> > +                             return -EFAULT;
> > +                     uindices++;
> > +             }
> > +     }
> > +
> > +     return n;
> > +}
> > +
> > +static inline unsigned long num_fp_d_regs(const struct kvm_vcpu *vcpu)
> > +{
> > +     const struct kvm_cpu_context *cntx =3D &vcpu->arch.guest_context;
> > +
> > +     if (riscv_isa_extension_available(vcpu->arch.isa, d))
> > +             return sizeof(cntx->fp.d.f) / sizeof(u64) + 1;
> > +     else
> > +             return 0;
> > +}
> > +
> > +static int copy_fp_d_reg_indices(const struct kvm_vcpu *vcpu,
> > +                                     u64 __user *uindices)
> > +{
> > +     unsigned int i;
> > +     int n =3D num_fp_d_regs(vcpu);
> > +     u64 reg;
> > +
> > +     /* copy fp.d.f indeices */
>
> indices
>
> > +     for (i =3D 0; i < n-1; i++) {
> > +             reg =3D KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_=
FP_D | i;
> > +
> > +             if (uindices) {
> > +                     if (put_user(reg, uindices))
> > +                             return -EFAULT;
> > +                     uindices++;
> > +             }
> > +     }
> > +
> > +     /* copy fp.d.fcsr indeices */
>
> indices
>
> > +     reg =3D KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_D | i=
;
> > +     if (uindices) {
> > +             if (put_user(reg, uindices))
> > +                     return -EFAULT;
> > +     }
> > +
> > +     return n;
> > +}
> > +
> > +static inline unsigned long num_isa_ext_regs(void)
> > +{
> > +     return KVM_RISCV_ISA_EXT_MAX;
> > +}
> > +
> > +static int copy_isa_ext_reg_indices(u64 __user *uindices)
> > +{
> > +     unsigned int i;
> > +     int n =3D num_isa_ext_regs();
> > +
> > +     for (i =3D 0; i < n; i++) {
> > +             u64 reg =3D KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RI=
SCV_ISA_EXT | i;
>                                           ^ size-ulong
>
> > +
> > +             if (uindices) {
> > +                     if (put_user(reg, uindices))
> > +                             return -EFAULT;
> > +                     uindices++;
> > +             }
> > +     }
> > +
> > +     return n;
> > +}
> > +
> > +static inline unsigned long num_sbi_ext_regs(void)
> > +{
> > +     /* number of KVM_REG_RISCV_SBI_SINGLE +
> > +      *  2x(number of KVM_REG_RISCV_SBI_MULTI)
> > +      */
>
> Please use an opening wing '/*' on comments.
>
> > +     return KVM_RISCV_SBI_EXT_MAX + 2*(KVM_REG_RISCV_SBI_MULTI_REG_LAS=
T+1);
> > +}
> > +
> > +static int copy_sbi_ext_reg_indices(u64 __user *uindices)
> > +{
> > +     unsigned int i;
> > +     int n;
> > +
> > +     /* copy KVM_REG_RISCV_SBI_SINGLE */
> > +     n =3D KVM_RISCV_SBI_EXT_MAX;
> > +     for (i =3D 0; i < n; i++) {
> > +             u64 reg =3D KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RI=
SCV_SBI_EXT |
>                                           ^ size-ulong
>
> > +                               KVM_REG_RISCV_SBI_SINGLE | i;
> > +
> > +             if (uindices) {
> > +                     if (put_user(reg, uindices))
> > +                             return -EFAULT;
> > +                     uindices++;
> > +             }
> > +     }
> > +
> > +     /* copy KVM_REG_RISCV_SBI_MULTI */
> > +     n =3D KVM_REG_RISCV_SBI_MULTI_REG_LAST + 1;
> > +     for (i =3D 0; i < n; i++) {
> > +             u64 reg =3D KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RI=
SCV_SBI_EXT |
>                                           ^ size-ulong
>
> > +                               KVM_REG_RISCV_SBI_MULTI_EN | i;
> > +
> > +             if (uindices) {
> > +                     if (put_user(reg, uindices))
> > +                             return -EFAULT;
> > +                     uindices++;
> > +             }
> > +
> > +             reg =3D KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_=
SBI_EXT |
> > +                       KVM_REG_RISCV_SBI_MULTI_DIS | i;
> > +
> > +             if (uindices) {
> > +                     if (put_user(reg, uindices))
> > +                             return -EFAULT;
> > +                     uindices++;
> > +             }
> > +     }
> > +
> > +     return num_sbi_ext_regs();
> > +}
> > +
> > +/**
> > + * kvm_riscv_vcpu_num_regs - how many registers do we present via KVM_=
GET/SET_ONE_REG
> > + *
> > + * This is for all registers.
> > + */
> > +static unsigned long kvm_riscv_vcpu_num_regs(struct kvm_vcpu *vcpu)
> > +{
> > +     unsigned long res =3D 0;
> > +
> > +     res +=3D num_config_regs();
> > +     res +=3D num_core_regs();
> > +     res +=3D num_csr_regs();
> > +     res +=3D num_timer_regs();
> > +     res +=3D num_fp_f_regs(vcpu);
> > +     res +=3D num_fp_d_regs(vcpu);
> > +     res +=3D num_isa_ext_regs();
> > +     res +=3D num_sbi_ext_regs();
> > +
> > +     return res;
> > +}
> > +
> > +/**
> > + * kvm_riscv_vcpu_copy_reg_indices - get indices of all registers.
> > + */
> > +static int kvm_riscv_vcpu_copy_reg_indices(struct kvm_vcpu *vcpu,
> > +                             u64 __user *uindices)
> > +{
> > +     int ret;
> > +
> > +     ret =3D copy_config_reg_indices(uindices);
> > +     if (ret < 0)
> > +             return ret;
> > +     uindices +=3D ret;
> > +
> > +     ret =3D copy_core_reg_indices(uindices);
> > +     if (ret < 0)
> > +             return ret;
> > +     uindices +=3D ret;
> > +
> > +     ret =3D copy_csr_reg_indices(uindices);
> > +     if (ret < 0)
> > +             return ret;
> > +     uindices +=3D ret;
> > +
> > +     ret =3D copy_timer_reg_indices(uindices);
> > +     if (ret < 0)
> > +             return ret;
> > +     uindices +=3D ret;
> > +
> > +     ret =3D copy_fp_f_reg_indices(vcpu, uindices);
> > +     if (ret < 0)
> > +             return ret;
> > +     uindices +=3D ret;
> > +
> > +     ret =3D copy_fp_d_reg_indices(vcpu, uindices);
> > +     if (ret < 0)
> > +             return ret;
> > +     uindices +=3D ret;
> > +
> > +     ret =3D copy_isa_ext_reg_indices(uindices);
> > +     if (ret < 0)
> > +             return ret;
> > +     uindices +=3D ret;
> > +
> > +     ret =3D copy_sbi_ext_reg_indices(uindices);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> >  static int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
> >                                 const struct kvm_one_reg *reg)
> >  {
> > @@ -758,6 +1086,24 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
> >                       r =3D kvm_riscv_vcpu_get_reg(vcpu, &reg);
> >               break;
> >       }
> > +     case KVM_GET_REG_LIST: {
> > +             struct kvm_reg_list __user *user_list =3D argp;
> > +             struct kvm_reg_list reg_list;
> > +             unsigned int n;
> > +
> > +             r =3D -EFAULT;
> > +             if (copy_from_user(&reg_list, user_list, sizeof(reg_list)=
))
> > +                     break;
> > +             n =3D reg_list.n;
> > +             reg_list.n =3D kvm_riscv_vcpu_num_regs(vcpu);
> > +             if (copy_to_user(user_list, &reg_list, sizeof(reg_list)))
> > +                     break;
> > +             r =3D -E2BIG;
> > +             if (n < reg_list.n)
> > +                     break;
> > +             r =3D kvm_riscv_vcpu_copy_reg_indices(vcpu, user_list->re=
g);
> > +             break;
> > +     }
> >       default:
> >               break;
> >       }
> > --
> > 2.34.1
> >
>
> Otherwise,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>
> Thanks,
> drew

Thanks for your review, Andrew! The comments will be addressed in next vers=
ion.
