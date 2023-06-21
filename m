Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3627B737EC9
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 11:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjFUIpd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 04:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjFUIpd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 04:45:33 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B85110FB;
        Wed, 21 Jun 2023 01:45:31 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b46f5f4d79so46838161fa.1;
        Wed, 21 Jun 2023 01:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687337130; x=1689929130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYIw9zUPZWZ2o+QN5fG2PRt2gO03dubW8fyBAMQKZLE=;
        b=qCW19/pbsOnWIPKRDK74psGxSYvuSBgLbZKbYaLkXRj8HGXRWFkCqN6ysyA2wMI1sJ
         M6Hu+XCvThIRolfER9vvD7qSoYNTz3tVirW3vUlmab7wwpnKgtxoVWzjEA1w75vgmdaC
         zPZiauwtpHfapncsJTrYOmxGzcTKOZaIAI7qf6hWfpPBVAjNDBCSVIswVtTQsbrFTdUl
         vFZJP+LgHa3YlMETckvBWqL7D/wG/w+eIHVRbEMh11gqKkTNQiU0QhPhQP0VVbyp7fAf
         nZLmNVSvaQsw2l3vcfsWOUqoXgQ083lQn7APLu//1YLpw8Mb+mOvlFL8bvKE3ftwMG16
         VEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687337130; x=1689929130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYIw9zUPZWZ2o+QN5fG2PRt2gO03dubW8fyBAMQKZLE=;
        b=QqcytLAYl9EFFd2/hevw5HWtgV+zHVK/AQgN9muL4ZINVGwKY9slPNotM2M+GysoIg
         emP+CcwDgIKpacgNatH7rZ2G2U8hDoS4LrgQzySp5cSsClXKPd//GEiq2ehEMzudH16t
         127K5bE6dEODZJwOUvKfTQpjjXIocaFeMhRj6SF/xj4hs61VNWczN0+CgOsCO3QGmWog
         0zI2ZbNJDVqPYnolkRKCBFtyk25jXWc6GBy+H5oWopOoDJ/jfmuFtKNp9x6Kv2A41CSj
         AxtfuIhtz6Cj9G0ZWqkqDl61IuXfuxvk3d2cALkLIUFblvhdoyxH8fypeO7E4qy/SiDm
         7c2A==
X-Gm-Message-State: AC+VfDwuicd/jg6woSKWWAY07A2xuo19P1L+qsCs8t/nRMe8xOAOG/gl
        xjlnQNev6rzAGxCJhGTE5ZevarruYc8ThST/L78=
X-Google-Smtp-Source: ACHHUZ4BrKigQscUYyAgK2m2X7YOR2aGI6Htk1A+97xpwtjx/lbr6R6ahZTgONsoUBJEA53I5JDdW30GyqH39ENS4FU=
X-Received: by 2002:a05:651c:10b0:b0:2b4:7910:36a3 with SMTP id
 k16-20020a05651c10b000b002b4791036a3mr3026730ljn.0.1687337129513; Wed, 21 Jun
 2023 01:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686275310.git.haibo1.xu@intel.com> <8cd4ce50f5f4a639f4508085959aae222d4d4386.1686275310.git.haibo1.xu@intel.com>
 <20230609-fba04b424a4d46574e04e587@orel> <CAJve8okjRZEt6_6SB9EWm+6c7utpExzenfWo2T1N-J6G9w9czQ@mail.gmail.com>
 <20230620-95ce8ab70956a72b9da3a31a@orel> <CAJve8onNFfHFcvAGkbtnxjzqgfq4geL1zOwJEc8Xzc=NHVDrFg@mail.gmail.com>
 <20230621-37ea9461250036cc2ec8c544@orel>
In-Reply-To: <20230621-37ea9461250036cc2ec8c544@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 21 Jun 2023 16:45:18 +0800
Message-ID: <CAJve8omtMhHvH1huOanu+UfsJLZxGnFs6=pnuZzGvm1O1wbw+g@mail.gmail.com>
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

On Wed, Jun 21, 2023 at 3:30=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Wed, Jun 21, 2023 at 09:55:13AM +0800, Haibo Xu wrote:
> > On Tue, Jun 20, 2023 at 6:44=E2=80=AFPM Andrew Jones <ajones@ventanamic=
ro.com> wrote:
> > >
> > > On Tue, Jun 20, 2023 at 06:05:59PM +0800, Haibo Xu wrote:
> > > > On Fri, Jun 9, 2023 at 9:35=E2=80=AFPM Andrew Jones <ajones@ventana=
micro.com> wrote:
> > > > >
> > > > > On Fri, Jun 09, 2023 at 10:12:18AM +0800, Haibo Xu wrote:
> > > > > > +static struct vcpu_reg_list aia_config =3D {
> > > > > > +     .sublists =3D {
> > > > > > +     BASE_SUBLIST,
> > > > > > +     AIA_REGS_SUBLIST,
> > > > > > +     {0},
> > > > > > +     },
> > > > > > +};
> > > > > > +
> > > > > > +static struct vcpu_reg_list fp_f_d_config =3D {
> > > > > > +     .sublists =3D {
> > > > > > +     BASE_SUBLIST,
> > > > > > +     FP_F_REGS_SUBLIST,
> > > > > > +     FP_D_REGS_SUBLIST,
> > > > > > +     {0},
> > > > > > +     },
> > > > > > +};
> > > > > > +
> > > > > > +struct vcpu_reg_list *vcpu_configs[] =3D {
> > > > > > +     &zicbo_config,
> > > > > > +     &aia_config,
> > > > > > +     &fp_f_d_config,
> > > > > > +};
> > > > > > +int vcpu_configs_n =3D ARRAY_SIZE(vcpu_configs);
> > > > > > --
> > > > > > 2.34.1
> > > > > >
> > > > >
> > > > > I see we have a bit of a problem with the configs for riscv. Sinc=
e we
> > > > > don't disable anything we're not testing, then for any test that =
is
> > > > > missing, for example, the f and d registers, we'll get output lik=
e
> > > > > "There are 66 new registers. Consider adding them to the blessed =
reg
> > > > > list with the following lines:" and then a dump of all the f and =
d
> > > > > registers. The test doesn't fail, but it's messy and confusing. I=
deally
> > > > > we'd disable all registers of all sublists not in the config, pro=
bably
> > > > > by starting by disabling everything and then only reenabling the =
ones
> > > > > in the config.
> > > > >
> > > > > Anything that can't be disabled is either a KVM bug, i.e. we shou=
ld
> > > > > be able to disable it, because we can't expect every host to have=
 it,
> > > > > or it needs to be in the base register sublist (meaning every hos=
t
> > > > > will always have it).
> > > > >
> > > >
> > > > HI Andrew,
> > > >
> > > > I found several multi-letters ISA EXT(AIA/SSTC etc) were not allowe=
d
> > > > to be disabled.
> > > > Is it a bug? shall we fix it=EF=BC=9F
> > >
> > > Extensions that a guest could use (regardless of whether or not the h=
ost
> > > described it in the guest's isa string), because the instructions or =
CSR
> > > accesses don't trap, can't truly be disabled. So, it's not a bug to
> > > prohibit disabling them and indeed the test cases should actually ens=
ure
> > > disabling them fails.
> > >
> >
> > So these kinds of ISA_EXT_* regs should be in the base reg list, right?
> >
>
> Ah, this is getting a bit messy. We don't want all these extensions in a
> "base", which represents extensions for all possible hosts, because the
> extensions are optional, but, we can't remove them from get-reg-list
> output by disabling them, since they can't be disabled. It seems we
> need the concept of "base", which is the common set expected on all hosts=
,
> and also the concept of "this host's base". I'm struggling to think of
> a nice way to deal with that. A first thought is to both add these types
> of registers to their own extension-specific sublists and to filter_reg()=
.
> I think that will keep them from being reported as new registers in every
> test, but also allow detection of them going missing when they're
> extension is present.
>

Yes, I was also stuck with the mess!

I was trying one way to only include `disable not allowed` regs to the
base reg list and
only check errno for disable(set 0) operation.

I will also try your suggestion and let you know the results soon!

Thanks,
Haibo

> Thanks,
> drew
