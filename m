Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18E7A15FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 08:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjIOGWD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 02:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIOGWC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 02:22:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68091BD0;
        Thu, 14 Sep 2023 23:21:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-500cfb168c6so2907381e87.2;
        Thu, 14 Sep 2023 23:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694758912; x=1695363712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CbOaBoTgdqZjkC9bgxngrjMf2gb+bcUOXRH9i9PPC4=;
        b=gY+rr6zZ+YNlIujztVUPNA9p9k5+SIjUrRBND7JK73DqqDCwFV2qwVGcOoIpoTjpKb
         wGdWVNtFHkttnGvDtEqS16t2h3VNhNq2LgyjVl/iaiP7t7OcO5vwWSWs7+GDDBuQzGgy
         0dBtxL2S/hOe5P1ofEm70vrL5o+gGSsNeLNsnRgmaqbdNUPr6QOQTgYXuovk0Y8dhiMT
         KLUym03KOpoih4bEFfdV22IbdzxztVDPS+kUlpeMAI6Vzy5UzLR3qk5NsRVsOwGape37
         KxQRbS9ZXI4AAZk3rxJ+Tl2KVU9glLl6Je4/9iY/NWqKB2FqtAidAPOxVZAlLYq7iXVw
         OZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694758912; x=1695363712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CbOaBoTgdqZjkC9bgxngrjMf2gb+bcUOXRH9i9PPC4=;
        b=uwZbp8JZNhe9yVQL+A5klm49Iua6vsgYriFHdAFYRdtWdupNH6tlZzo82wxlU+kNDx
         3jmj8MTaV7FmsP4iMzShpwF3Xp5VP2357WicKYKHeDApmm94ZDsH6dN0qqbUnS6/TV7V
         Mi4gdwlhYjtHf0sXA+pxln14B8+mIpNvcIxSo9JX1vz/H3OfFK1ETcZVvdiOWjkVyYqp
         4fxOkkXUZamrrW85+aiKpzc/tLaA9PPbn8RVih9/NIlFlj4L4z1A6TK4vW/sm3+lcPi1
         JodhSnJEqc0kyJb3lTqZ/2R2fnD/kT5+n59YQhaiqRyPdmUI2/SBBo+gGAkL989hvhzj
         WkhQ==
X-Gm-Message-State: AOJu0YwOctrAs+SF+9U5ve2sExGXejlKe9i3pk72vmZODV1oWSoftKoJ
        bAwDO/2zcHrP4Pg5mOZPp7VPZIiaGuRfnVgPQRE=
X-Google-Smtp-Source: AGHT+IFQEpOnX9uf3gdbZsJHudImE7kbvB8OM+rS3Fi4ABBNMgv5QYCfVKA10TAI1f03ryjhcKZYalx2hAKJFWVnvIc=
X-Received: by 2002:a19:6715:0:b0:502:e2be:54b5 with SMTP id
 b21-20020a196715000000b00502e2be54b5mr569046lfc.17.1694758912398; Thu, 14 Sep
 2023 23:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694421911.git.haibo1.xu@intel.com> <64e0637cd6f22dd7557ed44bd2242001e7830d1c.1694421911.git.haibo1.xu@intel.com>
 <20230914-d2e594e7d84503ad14036e2d@orel>
In-Reply-To: <20230914-d2e594e7d84503ad14036e2d@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Fri, 15 Sep 2023 14:21:41 +0800
Message-ID: <CAJve8onhY534T=Hyncjfi4GfdZ+0D2xM+jRSaYCAWCdaKxPUcQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] KVM: riscv: selftests: Add sstc timer test
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 5:52=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Sep 14, 2023 at 09:37:03AM +0800, Haibo Xu wrote:
> > Add a KVM selftests to validate the Sstc timer functionality.
> > The test was ported from arm64 arch timer test.
>
> I just tried this test out. Running it over and over again on QEMU I see
> it works sometimes, but it frequently fails with the
> GUEST_ASSERT_EQ(config_iter + 1, irq_iter) assert and at least once I
> also saw the __GUEST_ASSERT(xcnt >=3D cmp) assert.
>

Good catch!

I can also reproduce this issue and it is a common problem for both
arm64 and riscv because it also happens in a arm64 Qemu VM.

It seems like a synchronization issue between host and guest shared
variables. Will double check the test code.

> Thanks,
> drew
