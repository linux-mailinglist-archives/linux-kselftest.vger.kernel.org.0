Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C167A6AF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 20:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjISS6A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 14:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjISS6A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 14:58:00 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECA2E1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 11:57:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso9827073e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1695149871; x=1695754671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhVTmCY18AAwuZtx0mwKmmrwAcWS17iU82Rcu9KB1Uo=;
        b=PjeRXiIgIo5irZi0xds6a4vSeJX8/FWPN5gEBvv9ZakAtHMfjqpt51cEBmz3AXzv/7
         NyLXsQQO8GN2ySiFoUGN3b1E/hLoUQOSHuXirYCWRsAW7s0IEDFQPk7dt3dXenKtNvTe
         kgIeF1l+PlrxG16BJv31Aba7GDUwEPUldUghU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695149871; x=1695754671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhVTmCY18AAwuZtx0mwKmmrwAcWS17iU82Rcu9KB1Uo=;
        b=v6Ti3TXNHlZ2N4R0t+itBukCUIs5EHdtbrIuT7QFzD12TTTROuX+u9CsQ4TGwArIb7
         RIxWoppWMw85VQzaF4L36Z2Z67X6UHI6HybpChlQEgxvCQrpBmXxgIe7/nhqcEGKytLC
         WStD6VWWGzdcdS4HlwJtNoBlnekWUC6/6Ik1ob/3Us/bSiJJppRv3n31PtOSjzW+aJcl
         UEt3AZM5Gn8hpPPz16XUTebk4vLCA5/9TpVtmVLRgjGSk44uM4UfaHnY29v4OxUcNUAx
         3BeA26M+FYO2Oz16rwiCjhiG15BJhwwHhmjcOt9NDDymALYWm/p/t9FsvEXxwn8j26G7
         e2PA==
X-Gm-Message-State: AOJu0YwZ6AVmOhfG18CE4AEnjaYJZKNTZ0Nb4ywLhKVxOzDlDnYx/P+5
        ySJtjNNOiw/d+vi7164xdJB6K5OK/z+d8gqAYTsM
X-Google-Smtp-Source: AGHT+IGzgFUkeaLucDDy+VjfOLYnjbzLxksr6Bjjy8m/XEtgrZyisbaxP5h6+A9hOORSOeSpaVrcf+At/pha0PYjcCA=
X-Received: by 2002:ac2:5b1c:0:b0:503:314f:affe with SMTP id
 v28-20020ac25b1c000000b00503314faffemr498289lfn.17.1695149870227; Tue, 19 Sep
 2023 11:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230918180646.1398384-1-apatel@ventanamicro.com> <20230918180646.1398384-2-apatel@ventanamicro.com>
In-Reply-To: <20230918180646.1398384-2-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 19 Sep 2023 11:57:38 -0700
Message-ID: <CAOnJCULNPvZzWH5bAFW+zKL_kM15Du+qV50atfqUsB1pzp0dmA@mail.gmail.com>
Subject: Re: [PATCH 1/4] RISC-V: KVM: Fix KVM_GET_REG_LIST API for ISA_EXT registers
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
> The ISA_EXT registers to enabled/disable ISA extensions for VCPU
> are always available when underlying host has the corresponding
> ISA extension. The copy_isa_ext_reg_indices() called by the
> KVM_GET_REG_LIST API does not align with this expectation so
> let's fix it.
>
> Fixes: 031f9efafc08 ("KVM: riscv: Add KVM_GET_REG_LIST API support")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/vcpu_onereg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index 1b7e9fa265cb..e7e833ced91b 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -842,7 +842,7 @@ static int copy_isa_ext_reg_indices(const struct kvm_=
vcpu *vcpu,
>                 u64 reg =3D KVM_REG_RISCV | size | KVM_REG_RISCV_ISA_EXT =
| i;
>
>                 isa_ext =3D kvm_isa_ext_arr[i];
> -               if (!__riscv_isa_extension_available(vcpu->arch.isa, isa_=
ext))
> +               if (!__riscv_isa_extension_available(NULL, isa_ext))
>                         continue;
>
>                 if (uindices) {
> --
> 2.34.1
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish
