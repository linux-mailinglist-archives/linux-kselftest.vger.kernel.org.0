Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2803C7A6BD9
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 21:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjISTyy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 15:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjISTyw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 15:54:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D881B9D
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 12:54:45 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50098cc8967so9883382e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 12:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1695153284; x=1695758084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjrdE60++TcwatJpXQy7OuWtzjqtwzDOP4HlaCMD688=;
        b=sRu16KAOkVD0agT9pdQCQeM8bB1TjVRVnK5JwdoDH07GsZD92zQ+g+Id0bjhm5mEy/
         gmVPHQ3ADTrUphmtraeXoguL/snemaBJnAz5BY3hycpPufCq3yW8cw/ucCed53DjC9K1
         8wZbbg3ImSfHvoUi4VHA+dZG2NHEM2dtHdooE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695153284; x=1695758084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjrdE60++TcwatJpXQy7OuWtzjqtwzDOP4HlaCMD688=;
        b=aRXrRFaMV40MP2MKFVmhFAMfGwtOvTKznfNllHVwQOQJyHI3DXCkqlZqoyL3QdRX+n
         D9B6d4ZXUheJuC5utgToKja1evmaGwq2OwOCYn3+UEJjlkOPjTSehq3f7CbPP9t+lCxN
         ln6N4j7+5J+/QAMbD9oGfbSPyXBfhXrsYnEupGauiu/k+xtZ2tpeyr4llc2JV976WFjV
         EVOzZ5P+MQeQSwCNfkNa7Uw9jaFJ4XApYxmTm+lgiNEypTzPoGIU28JH2+aJR5cPKjMY
         NiFWWRgLJojYQ17gHrJKYty+SUR5erpAwI3CJLq+41pQuPrn+07L06R6vKadSLFr8IOY
         Qw0Q==
X-Gm-Message-State: AOJu0Yx3rpCzoUQJk8q9ZYiOUW7zmOSeHbJFFVft3RrWLmDoXrA6/C65
        7Yi3u+g/Gpe9+cdvu0Vx2Xxz9PQYFyc9JQdWUvZg
X-Google-Smtp-Source: AGHT+IGCP2sHSYQZgQISUa9EgUk/8O464Rrr/vqidV5rzxfkX7nm0h42VEh5K+cIZmfXJ4mpo7ccdy+WLMgXrV6wO8E=
X-Received: by 2002:a05:6512:475:b0:4fe:8c4:44fb with SMTP id
 x21-20020a056512047500b004fe08c444fbmr546266lfd.38.1695153283961; Tue, 19 Sep
 2023 12:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230918180646.1398384-1-apatel@ventanamicro.com> <20230918180646.1398384-4-apatel@ventanamicro.com>
In-Reply-To: <20230918180646.1398384-4-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 19 Sep 2023 12:54:32 -0700
Message-ID: <CAOnJCUJYDHtbYS4js7PSAeLqT4sL5zi7DT5xeSww+5Nvs2UhcA@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: riscv: selftests: Fix ISA_EXT register handling
 in get-reg-list
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
> Same set of ISA_EXT registers are not present on all host because
> ISA_EXT registers are visible to the KVM user space based on the
> ISA extensions available on the host. Also, disabling an ISA
> extension using corresponding ISA_EXT register does not affect
> the visibility of the ISA_EXT register itself.
>
> Based on the above, we should filter-out all ISA_EXT registers.
>

In that case, we don't need the switch case any more. Just a
conditional check with KVM_RISCV_ISA_EXT_MAX should be sufficient.

> Fixes: 477069398ed6 ("KVM: riscv: selftests: Add get-reg-list test")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../selftests/kvm/riscv/get-reg-list.c        | 35 +++++++++++--------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index d8ecacd03ecf..76c0ad11e423 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -14,17 +14,33 @@
>
>  bool filter_reg(__u64 reg)
>  {
> +       switch (reg & ~REG_MASK) {
>         /*
> -        * Some ISA extensions are optional and not present on all host,
> -        * but they can't be disabled through ISA_EXT registers when pres=
ent.
> -        * So, to make life easy, just filtering out these kind of regist=
ers.
> +        * Same set of ISA_EXT registers are not present on all host beca=
use
> +        * ISA_EXT registers are visible to the KVM user space based on t=
he
> +        * ISA extensions available on the host. Also, disabling an ISA
> +        * extension using corresponding ISA_EXT register does not affect
> +        * the visibility of the ISA_EXT register itself.
> +        *
> +        * Based on above, we should filter-out all ISA_EXT registers.
>          */
> -       switch (reg & ~REG_MASK) {
> +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_A:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_C:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_D:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_F:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_H:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_I:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_M:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVPBMT:
>         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSTC:
>         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVINVAL:
>         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOZ:
>         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBB:
>         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSAIA:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_V:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVNAPOT:
>         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBA:
>         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBS:
>         case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICNTR:
> @@ -50,12 +66,7 @@ static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu,=
 int ext)
>         unsigned long value;
>
>         ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> -       if (ret) {
> -               printf("Failed to get ext %d", ext);
> -               return false;
> -       }
> -
> -       return !!value;
> +       return (ret) ? false : !!value;
>  }
>
>  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
> @@ -506,10 +517,6 @@ static __u64 base_regs[] =3D {
>         KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_=
RISCV_TIMER_REG(time),
>         KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_=
RISCV_TIMER_REG(compare),
>         KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_=
RISCV_TIMER_REG(state),
> -       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_A,
> -       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_C,
> -       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_I,
> -       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
RISCV_ISA_EXT_M,
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_=
REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_V01,
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_=
REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_TIME,
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_=
REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_IPI,
> --
> 2.34.1
>


--=20
Regards,
Atish
