Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1D070248E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 08:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbjEOGYq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 02:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbjEOGYn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 02:24:43 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6CA9F;
        Sun, 14 May 2023 23:24:40 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52caed90d17so7778091a12.0;
        Sun, 14 May 2023 23:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684131880; x=1686723880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipVfxboz2N3BTbhUZctFrasYMvC8E8GR8fiHDB5wG9A=;
        b=K/Ds5UQDShQ1jfqjq8VIbQzq9KL8b4ueLhmM+jbfvGykQOm9udF30CIzh7yLh0AyyW
         VYx2xlivf2OSEdspjfb8Gx7JMtCBsJInxMc/fFczq4kfjpAo0USZOFUZc6QxtZNJ4j3N
         E79DBz4t+N8DzEbdPJRBFSlFxD+9mq6SDrSMmmWHAeKYSgfnh2tpWRcuuT+67GCsSXQ/
         FP3HV5EZfoM11bfhNw1pyATMs6J2zLTpG+S2im1DBjb52UWpC5TQMtLjdJSk97kejt+d
         ZrAzPOBGlVVTLZU9eegXT+l0o/7mv0ugLJBck6gy/AjW0mGGRfvrYJoYuhwH2BEWATXt
         pymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684131880; x=1686723880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipVfxboz2N3BTbhUZctFrasYMvC8E8GR8fiHDB5wG9A=;
        b=Ob1oLNPv7UZCEYzxzV8UVeAv28qv3ZYiSly+mgYgoAKTiea9/Hnb1a45lINmSixoFS
         hU12ipxaDR9Hur4wq2aT1G3LiLEB+aAbuAiggi7/5dWEghuwEo/bl/WOBM6YoAjdpaFe
         NrD4P4a9gNb+OT75yYUWsxcKOMqkVAhWUEYXo0G3Uex+4O2stBsZ9W3FpWjFpggbfdnc
         mDq6SyodrLnpI94fw0NYZSFPXpvUa38BmHSo0EeLikh6dUqpUtmHPSu7Y0XxgltX2Dws
         7JwsT4sPrW5M22Q86IhkbAmAtUYEHZP4QlwPYdoYCv00no3Ld+rQtPkBM4MYN91Xlv66
         ExBA==
X-Gm-Message-State: AC+VfDyuMyne+u4KCGcf9EUjW7qw5v5d9uL3OwpL0tKF76HGBRPbVUus
        G39kWewu1LGu4AXltoIYRtxmxOlkDG0I/NGMXSA=
X-Google-Smtp-Source: ACHHUZ4wRiCLeYPgQOiKNNvZY75L/XiRY4hGc1xrqkwiizwTTiO+743uCn+9bRYh7GxEKf2LBVi2VCi/iVrz18zFAOQ=
X-Received: by 2002:a17:90a:d48d:b0:252:a7b5:723f with SMTP id
 s13-20020a17090ad48d00b00252a7b5723fmr11803679pju.2.1684131879992; Sun, 14
 May 2023 23:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683791148.git.haibo1.xu@intel.com> <921fc2e1a91887170e277acb1b52df57480a5736.1683791148.git.haibo1.xu@intel.com>
 <20230511-boozy-comic-5bc8f297dc8e@spud> <20230511-leverage-backspin-34bcde885006@spud>
In-Reply-To: <20230511-leverage-backspin-34bcde885006@spud>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Mon, 15 May 2023 14:24:28 +0800
Message-ID: <CAJve8okYNEbk2PwXVzx+dMSq+uci=W_tpShNv3FER=pWRUymWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: kvm: Add KVM_GET_REG_LIST API support
To:     Conor Dooley <conor@kernel.org>
Cc:     Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com,
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

On Fri, May 12, 2023 at 6:48=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, May 11, 2023 at 11:25:41PM +0100, Conor Dooley wrote:
> > On Thu, May 11, 2023 at 05:22:48PM +0800, Haibo Xu wrote:
> > > KVM_GET_REG_LIST API will return all registers that are available to
> > > KVM_GET/SET_ONE_REG APIs. It's very useful to identify some platform
> > > regression issue during VM migration.
> > >
> > > Since this API was already supported on arm64, it'd be straightforwar=
d
> > > to enable it on riscv with similar code structure.
> >
> > Applied on top of v6.4-rc1 this breaks the build :/
>
> I lied, I forgot W=3D1 is enabled for the allmodconfig builds in the
> patchwork automation.
> The warnings are trivial to fix, so you should fix them anyway!
>

sure, I will fix them in the next version.

Thanks,
Haibo

> > warning: Function parameter or member 'vcpu' not described in 'kvm_risc=
v_vcpu_num_regs'
> > warning: Function parameter or member 'uindices' not described in 'kvm_=
riscv_vcpu_copy_reg_indices'
> > warning: Function parameter or member 'vcpu' not described in 'kvm_risc=
v_vcpu_copy_reg_indices'
> >
> > You have a bunch of kerneldoc comments (the ones with /**) that are not
> > valid kerneldoc. Apparently allmodconfig catches that!
> >
> > Cheers,
> > Conor.
>
>
