Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517A3633633
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 08:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKVHrQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 02:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiKVHrP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 02:47:15 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E946A31EE5
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 23:47:13 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s5so19415819edc.12
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 23:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul05IzRXE61CMlw9KgRAl/R4lzTUkwIwdoW7/jl/bmg=;
        b=z1p4yL52qJimKHlDFTqIx8/ByXcgJXv5sbBgICTjIH58ocFhfsTim8rmdXBY1bMvNS
         jX1zGwyAp/zKK8W8Pl4DIAGICAiqwQgGnA/HrrUsRzy8y7Evt1hii84Huz/7IHQAq89T
         bBogWhFdHWO86kMA2q/MqWn1uzkDwcF+J4DReuRYfzd1Xv1R4wevYMfJGHQBabGwgDdJ
         3Gl3ULLR1XqjcF1uucCY3PWXtwmwWa2g/RSBhMwO3WEDMHTN3k+EQpixBhDOzvfVcP5s
         VafZ5xY5kMcVe7J+i/6hq/OQa1qVVt/Wn99pRDE2FdP1lyPJuF1udnAWk41AHoeBKWMS
         OkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ul05IzRXE61CMlw9KgRAl/R4lzTUkwIwdoW7/jl/bmg=;
        b=5ITQh6cwna2PHr4SnyODd1/ngS2lpiK6KV3WygI6lqq9Us3FIToEY4m+g6Tib+Vzjw
         6c4KBOPUrn+mjR9IlS6dynQiGpYEv92Lpq6sxRJ+palpcM1utVznAW95rkobaS8acp42
         kMK2PQlIUYy23wWZDv822t2Mz5IsHuMxcDo2vriy7EzL27v1lIBWK6vjhsD4BDRc3wNW
         rnGhQcIm0OFXUMl/qhpYe1i4/PzCJTr/96YU8yXUlDFXqkhbBtg125ziHs4bteFcoCYq
         RNIrOl7e2P5mnBfgY5qKV/COShgSE6I21RIJq+7y+iTog9ZmaZkiv/5jaJ1ATck4CWl+
         CyCg==
X-Gm-Message-State: ANoB5pknWx9Y8D6P18vpjq+RcowAkgJarRuxR2Snv+Y1rBPAzxouS7sD
        DIVWoK7gizod3vGQLg/AM5rwyiH5IP0K69d+dj9qXw==
X-Google-Smtp-Source: AA0mqf752hh5lxlSa+EctA1AsD03tolBTTp1BxXGpFLiXkmeQTHyJakvrvMeHgnF4Z9nyIQs0T1gg3A0oenRnEDJY1M=
X-Received: by 2002:aa7:c50b:0:b0:469:d36e:3213 with SMTP id
 o11-20020aa7c50b000000b00469d36e3213mr3660281edq.206.1669103232447; Mon, 21
 Nov 2022 23:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20221119171841.2014936-1-bjorn@kernel.org> <CADYN=9LxMhccyx6wncjO99am7z+8wNWoMzV3DCSyCdJYktGevg@mail.gmail.com>
 <87edtwb6e8.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87edtwb6e8.fsf@all.your.base.are.belong.to.us>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 22 Nov 2022 08:47:01 +0100
Message-ID: <CADYN=9JDOBHEgmiWCy_k5sXLizdtRET6-G5_PdZcaOLvSp5vTA@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: net: Add cross-compilation support
 for BPF programs
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Lina Wang <lina.wang@mediatek.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 21 Nov 2022 at 17:48, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wrot=
e:
>
> Anders Roxell <anders.roxell@linaro.org> writes:
>
> > On Sat, 19 Nov 2022 at 18:19, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> =
wrote:
> [...]
> >> Now that BPF builds are starting to show up in more places
> >> (selftests/net, and soon selftests/hid), maybe it would be cleaner to
> >> move parts of the BPF builds to lib.mk?
> >
> > Yes, since its in tc-testing too.
> > Maybe thats what we should do already now?
>
> Ok, so there's three BPF builds, in addition to selftests/bpf. Do you
> suggest moving (cross-compiled) libbpf builds (for bpf_helpers_defs.h
> generation) and some kind of clang BPF build-rule to lib.mk?

Maybe start with moving the libbpf builds, for build_helpers_defs.h generat=
ion,
and 'define get_sys_includes' into the lib.mk ?

> Or would
> you like more things there, like resolve_btfids?
>
> I guess this patch could go in regardless, and fix the build *now*, and
> do a lib.mk thing as a follow-up?

Make sense.

Reviewed-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders
