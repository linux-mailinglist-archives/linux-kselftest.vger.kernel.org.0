Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715C97368D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 12:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjFTKGo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjFTKGS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 06:06:18 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA257DB;
        Tue, 20 Jun 2023 03:06:15 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b4725e9917so35299241fa.2;
        Tue, 20 Jun 2023 03:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687255571; x=1689847571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtXc4PCbTDlAHZAVqhvtwaRICGJ6lazGNb1ljaV+Ftw=;
        b=ldW/ylsuWZH3AXZueyYlRT0nh9Gl/MhIKISAju1Ir5dsyEDOYv8I/dKPmBee/odzkK
         SDbVl0f1M1Z+H7UtPcorlVsRZ1YEUg+5forY69CwXp/YyhIvg9aUPWStKrGV2gmYsZNf
         NowMzGu9Th8C8x1f9CVWdoHwEa07JlDa8276RyVLTkeEuOuDgoqnuPXbaJN0RQp9CxTN
         scEmXUBZ0g6uTFZ/EWqPVXJUnHpeqXlZJ82NBJRiFQfJgWE85T8UqdlMfqHEootOMNc4
         iiLGC6mmOBawCmItBjo8MjcoUJOAgAXU+CIrdSEtjUQzRSJ6ljr4Z5qpcnpXOjSwCxRp
         vlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687255571; x=1689847571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtXc4PCbTDlAHZAVqhvtwaRICGJ6lazGNb1ljaV+Ftw=;
        b=l8megoFlgHrfD+dmkWmrP0X4XgeljU/oDZAACQUnD1hWQFVAwLhcMjSmKxWwYW0tat
         RfWzpopmsThIXT7rPGviDkVcFqUxyJbKkcC19beWPrJa4A3czVanWXMFMopdMTJlRy2c
         JcyZ5fOKU1rUCd7l110iXKcKLWsskjlBYwEYauzN4cY9Jo0ifuQDUkb2o6Qx2iTMnRQy
         YVtsjr6Z00Skky5HJOSboVKSamTwimkQmtpiDxxxsvaa55685c7uYYySuYQmq5ji14tR
         NpxrE5Zc4iRUxbOeL46R/gFcEIML9JCKUkpYlN7jWmcqy6+QOEcXFHLnCQ7S8njNxTML
         8/ng==
X-Gm-Message-State: AC+VfDzx3bD56ERWNFI6k3dnH1ORgUu/guA4qfk0a8PZimBSqE75E6L/
        MIS14a3Itq7QjkwL7f3ze3NmCNsZWVTx2vSuAbc=
X-Google-Smtp-Source: ACHHUZ7b29WcQEpJBxPgynKh2dxcEjQKO63R0QvBncBcn4CVZjBKqj6DvExU9PFON2qlRV1iXePc6q0qi5nDf7A9U3Q=
X-Received: by 2002:a2e:9b06:0:b0:2b1:dc7a:ebf2 with SMTP id
 u6-20020a2e9b06000000b002b1dc7aebf2mr7647520lji.17.1687255570896; Tue, 20 Jun
 2023 03:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686275310.git.haibo1.xu@intel.com> <8cd4ce50f5f4a639f4508085959aae222d4d4386.1686275310.git.haibo1.xu@intel.com>
 <20230609-fba04b424a4d46574e04e587@orel>
In-Reply-To: <20230609-fba04b424a4d46574e04e587@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Tue, 20 Jun 2023 18:05:59 +0800
Message-ID: <CAJve8okjRZEt6_6SB9EWm+6c7utpExzenfWo2T1N-J6G9w9czQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] KVM: riscv: selftests: Add get-reg-list test
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>, maz@kernel.org,
        oliver.upton@linux.dev, seanjc@google.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
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

On Fri, Jun 9, 2023 at 9:35=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Fri, Jun 09, 2023 at 10:12:18AM +0800, Haibo Xu wrote:
> > +static struct vcpu_reg_list aia_config =3D {
> > +     .sublists =3D {
> > +     BASE_SUBLIST,
> > +     AIA_REGS_SUBLIST,
> > +     {0},
> > +     },
> > +};
> > +
> > +static struct vcpu_reg_list fp_f_d_config =3D {
> > +     .sublists =3D {
> > +     BASE_SUBLIST,
> > +     FP_F_REGS_SUBLIST,
> > +     FP_D_REGS_SUBLIST,
> > +     {0},
> > +     },
> > +};
> > +
> > +struct vcpu_reg_list *vcpu_configs[] =3D {
> > +     &zicbo_config,
> > +     &aia_config,
> > +     &fp_f_d_config,
> > +};
> > +int vcpu_configs_n =3D ARRAY_SIZE(vcpu_configs);
> > --
> > 2.34.1
> >
>
> I see we have a bit of a problem with the configs for riscv. Since we
> don't disable anything we're not testing, then for any test that is
> missing, for example, the f and d registers, we'll get output like
> "There are 66 new registers. Consider adding them to the blessed reg
> list with the following lines:" and then a dump of all the f and d
> registers. The test doesn't fail, but it's messy and confusing. Ideally
> we'd disable all registers of all sublists not in the config, probably
> by starting by disabling everything and then only reenabling the ones
> in the config.
>
> Anything that can't be disabled is either a KVM bug, i.e. we should
> be able to disable it, because we can't expect every host to have it,
> or it needs to be in the base register sublist (meaning every host
> will always have it).
>

HI Andrew,

I found several multi-letters ISA EXT(AIA/SSTC etc) were not allowed
to be disabled.
Is it a bug? shall we fix it=EF=BC=9F

Thanks,
Haibo

static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 {
     switch (ext) {
     case KVM_RISCV_ISA_EXT_A:
     case KVM_RISCV_ISA_EXT_C:
     case KVM_RISCV_ISA_EXT_I:
     case KVM_RISCV_ISA_EXT_M:
     case KVM_RISCV_ISA_EXT_SSAIA:
     case KVM_RISCV_ISA_EXT_SSTC:
     case KVM_RISCV_ISA_EXT_SVINVAL:
     case KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
     case KVM_RISCV_ISA_EXT_ZBB:
         return false;
     default:
         break;
     }

     return true;
 }

> Thanks,
> drew
