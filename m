Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324B27AD934
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 15:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjIYNdO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 09:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjIYNdN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 09:33:13 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BE110D
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 06:33:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2773cc1721bso1495342a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 06:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695648786; x=1696253586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWWpsmuiT0DkC2S1ORrZVL7ehSbw0Lmve5XUeVl5vjQ=;
        b=mGyc4CtzzL7jmvrO+UVQijx/aJdxWbngibdJKHFKIvgrcHVrN2vVA1c/t2qUqUrTQz
         WWVejohSwgbd1EHl7YkO2tstIROtBo0ghxQmzGDZbKdNvuE2tf2/ELWPGSoFyOI1YRF3
         +qAzUysBtkl816f93hfMt6i12dw7g8cw9zaAIjgDxA1F0OzMv1qsy/ebsAkmFYjOLKz/
         7zyjHGrTFD8AVR5T0sTXE+/U1BNl/fgpAjARKpbPD2tURP+slsxI3nfINKkQujD7b6dP
         wrduMVLsPElRfvSV8pt9s2oUTkS5JSFdt2VQ6hoUc2s0u6GZc3+DaQkI+5cWaAnk2RaE
         OoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695648786; x=1696253586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWWpsmuiT0DkC2S1ORrZVL7ehSbw0Lmve5XUeVl5vjQ=;
        b=U7G6b9wFmyxA7Bn5KGmMo3n4O/Q6fLAVpdigWbIaRyp3DekCEAbl/h+Q9FQpAmLs5u
         /MnQB/IzSrl/sOsKNSLdz/DMK3cMzKVwCFwSK95hzjfxnUR5PTNKMOsfU/WH4ytvV4pV
         mdETb8BtI6CF1I/uXEt5owrCSveXJ0qQBlJPUnDq25EV+sTu/pSlzuxtRXyXOgVdUCdr
         VWDFlDxjbFW9OBIGu8ZM+SmKXeU9WgbpbVn4ziwLtmN3/wXU73GuazBTM5Cs1I9qtOO2
         yrGMdxYF1q15D+MWFOYxSquY/ERpFukNXGv/VAlB4jBIzhEzxaLgr+mVewwPacH1jhQa
         7cQQ==
X-Gm-Message-State: AOJu0YwFKjIMtEgkm0AnDSZB0Km2ZgAjYTxmrIKGMSBHjMNhhtFkmc+j
        72Pn8srhQVGUmyzMMPg83V9w9vO+R9m70+Y2Lu1hyg==
X-Google-Smtp-Source: AGHT+IHvwDRQn3v039uMTkyZOXLfNbfqYk8vrxj7zH1v4k0e9teZWE9FtAuclu3zJWXqqqQSY3Tmt4Ji3RAYL/Go4VQ=
X-Received: by 2002:a17:90a:5785:b0:274:8330:c7da with SMTP id
 g5-20020a17090a578500b002748330c7damr4567601pji.28.1695648785859; Mon, 25 Sep
 2023 06:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230919035343.1399389-1-apatel@ventanamicro.com>
 <20230919035343.1399389-8-apatel@ventanamicro.com> <20230920-d30b398a99804418792264c3@orel>
In-Reply-To: <20230920-d30b398a99804418792264c3@orel>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 25 Sep 2023 19:02:54 +0530
Message-ID: <CAK9=C2WAZWdcKEKy6DjQRhJZxMfWZmcX4hVxSuV3=_nAQnYb4A@mail.gmail.com>
Subject: Re: [PATCH 7/7] KVM: riscv: selftests: Add condops extensions to
 get-reg-list test
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
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

On Wed, Sep 20, 2023 at 1:48=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Tue, Sep 19, 2023 at 09:23:43AM +0530, Anup Patel wrote:
> > We have a new conditional operations related ISA extensions so let us a=
dd
> > these extensions to get-reg-list test.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/t=
esting/selftests/kvm/riscv/get-reg-list.c
> > index 9f464c7996c6..4ad4bf87fa78 100644
> > --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > @@ -50,6 +50,8 @@ bool filter_reg(__u64 reg)
> >       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI:
> >       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM:
> >       case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SMSTATEEN:
> > +     case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_XVENTANACONDOPS:
> > +     case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICOND:
> >               return true;
> >       /* AIA registers are always available when Ssaia can't be disable=
d */
> >       case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CS=
R_AIA_REG(siselect):
> > @@ -360,6 +362,8 @@ static const char *isa_ext_id_to_str(__u64 id)
> >               "KVM_RISCV_ISA_EXT_ZIFENCEI",
> >               "KVM_RISCV_ISA_EXT_ZIHPM",
> >               "KVM_RISCV_ISA_EXT_SMSTATEEN",
> > +             "KVM_RISCV_ISA_EXT_XVENTANACONDOPS",
> > +             "KVM_RISCV_ISA_EXT_ZICOND",
> >       };
> >
> >       if (reg_off >=3D ARRAY_SIZE(kvm_isa_ext_reg_name)) {
> > --
> > 2.34.1
> >
>
> Don't we want to add test configs for these?

Okay, I will update.

Regards,
Anup
