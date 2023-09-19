Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24CF7A6C26
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjISUNI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 16:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjISUNH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 16:13:07 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ED8BD
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 13:13:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50305abe5f0so5543967e87.2
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 13:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1695154379; x=1695759179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6ch6RWPf/XAfaKMkUuRJLYD6PuDcDg5GNJHK0YM5ng=;
        b=H6azQLfUcVLGTpySUHDi6XvpCGX2HO9hB5XSzuHOP3RtjKYFone6gtqnDhFzHEIczN
         WdtyCOBvauJoBFbgSex+/zf7Kf6W9xGvMyUFeM+ezVqJMQ3zOiDN7mPmkIIzVeL4tMza
         ujyp5w7M5my4mST117KQMABpl3UF/JXeTu9Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695154379; x=1695759179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6ch6RWPf/XAfaKMkUuRJLYD6PuDcDg5GNJHK0YM5ng=;
        b=ZMMbFt07L6Pa4+ItSVgQwR4MyMUM6W0yuo9UduGWd4NuKq9J9zTMDKciIvFKLBBPs2
         kOC9JUQe2RAid6N49ejsQrq+Wi4rvy9qjQWSgrZL/6+Af+qvF1+I8TeGVORn2ixpRIpi
         TJVmn8ulLUwuRxew9eGn3xlsjlhgdMngEBp+4qe0rdKlhEqKbWndQ3h9Hwy7vhpre4jx
         D66RkuvvGToCG56DYB/tZHgXI/ZlioyNJJHVd5WirkqBiL+9qkWC1SumeVBR8bTb504J
         i5rASY3qgRxB9i4JG3/HWeSr3Rgv34kXlXxvKzVomgjC0qvKVLfVWoHAv/X5ys8cUant
         Wo4w==
X-Gm-Message-State: AOJu0YysVQcDPP/DLwMkKk06OS3A62Pa03AZJ6YbUOpRUwmLLA7EA+XR
        qbAGqGKJPN2+U3e/SRkzNlwEFcTXTrf5JqwnQm4w
X-Google-Smtp-Source: AGHT+IGQ6hyYgt2XkleZcYChrWn4Hxuo5o+pyUqe/AgSgyUUhTT4q6QNmrd+sMMqXJB1pMLbt8L5TXnmcjoQ1HS1UKQ=
X-Received: by 2002:ac2:4da7:0:b0:502:9fce:b6cc with SMTP id
 h7-20020ac24da7000000b005029fceb6ccmr589020lfe.11.1695154378656; Tue, 19 Sep
 2023 13:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230918180646.1398384-1-apatel@ventanamicro.com> <20230918180646.1398384-5-apatel@ventanamicro.com>
In-Reply-To: <20230918180646.1398384-5-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 19 Sep 2023 13:12:47 -0700
Message-ID: <CAOnJCU+h-Y_i=HkCf194SLWp-7bqzMhRLC31q0xxQDMuLppapA@mail.gmail.com>
Subject: Re: [PATCH 4/4] KVM: riscv: selftests: Selectively filter-out AIA registers
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 18, 2023 at 11:07=E2=80=AFAM Anup Patel <apatel@ventanamicro.co=
m> wrote:
>
> Currently the AIA ONE_REG registers are reported by get-reg-list
> as new registers for various vcpu_reg_list configs whenever Ssaia
> is available on the host because Ssaia extension can only be
> disabled by Smstateen extension which is not always available.
>
> To tackle this, we should filter-out AIA ONE_REG registers only
> when Ssaia can't be disabled for a VCPU.
>
> Fixes: 477069398ed6 ("KVM: riscv: selftests: Add get-reg-list test")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../selftests/kvm/riscv/get-reg-list.c        | 23 +++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index 76c0ad11e423..85907c86b835 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -12,6 +12,8 @@
>
>  #define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK)
>
> +static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
> +
>  bool filter_reg(__u64 reg)
>  {
>         switch (reg & ~REG_MASK) {
> @@ -48,6 +50,15 @@ bool filter_reg(__u64 reg)
>         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI:
>         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM:
>                 return true;
> +       /* AIA registers are always available when Ssaia can't be disable=
d */
> +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(siselect):
> +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(iprio1):
> +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(iprio2):
> +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(sieh):
> +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(siph):
> +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(iprio1h):
> +       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(iprio2h):
> +               return isa_ext_cant_disable[KVM_RISCV_ISA_EXT_SSAIA] ? tr=
ue : false;

Ahh I guess. you do need the switch case for AIA CSRs but for ISA
extensions can be avoided as it is contiguous.

>         default:
>                 break;
>         }
> @@ -71,14 +82,22 @@ static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu=
, int ext)
>
>  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
>  {
> +       int rc;
>         struct vcpu_reg_sublist *s;
> +       unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] =3D { 0 };
> +
> +       for (int i =3D 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
> +               __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(i), &isa_ext_state=
[i]);
>
>         /*
>          * Disable all extensions which were enabled by default
>          * if they were available in the risc-v host.
>          */
> -       for (int i =3D 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
> -               __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
> +       for (int i =3D 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
> +               rc =3D __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
> +               if (rc && isa_ext_state[i])
> +                       isa_ext_cant_disable[i] =3D true;
> +       }
>
>         for_each_sublist(c, s) {
>                 if (!s->feature)
> --
> 2.34.1
>

Otherwise, LGTM.

Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
