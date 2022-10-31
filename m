Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB94613F36
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Oct 2022 21:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJaUr4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Oct 2022 16:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJaUrz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Oct 2022 16:47:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B12713CC8
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Oct 2022 13:47:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a67so19139902edf.12
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Oct 2022 13:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3e58SrwemEHObjbJRryliS78Tw/s51FyjKv68TB348=;
        b=NwR2uyx1qYJ/OSkczGov1yrbCJlfZUHLYc7V80K7fR6Av4E/lkgvgC2N4c5Jjha+Z5
         jaH2OsFlychVzGjLZkDKKA02W15tzyC4R3ZhbXPcrf/hLHnsec36Y/qabgv+YnYTDEEk
         FfKNYvFz07Rqw9iXXQr2rs6+LBN22FWPN/B2rCm8elKjyvC+/UTQtxuRIyxn5SZryt0Z
         CYMLCSr0gXaFSr/UvoIjxpIkW/zlOmFGnnuBQI+3hk4wGqIe1QB7OCfiiAZevLtUy5Z5
         edJXeuMrBikg5uAIbnndvotxaGLwTcqhL3fduOekboSXt7Gxh9Y6NfjsZ7jAPUk/nSZp
         AT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3e58SrwemEHObjbJRryliS78Tw/s51FyjKv68TB348=;
        b=KXyp9Jaxl/aOTE3iJXiJS6y9JX2ca7XRrXC9DoBdLW5IE6sSXZPxtKXLPOlIKnWJ9O
         Az24r3cZmyabqvRsiLoSORtdFiW6jQxsY5bEpvNm7qGDW4X/06KeXoD3rxBrICf4M2DL
         29FYqREVdwKJbRi9QpyKg5JhawLM4zu6+BTq/jIqbPP5IL/EGH2tL8XmUEGshU8AjMuw
         R39+kkauNgMXPD55qhXLv9+Ak5/+F4EbA5z9cr7OFX0VeJFg3flHtUxcIfpqdj/6Blpk
         /HLmXBLMHwZSqQGkpYBkWYgXsjtWoQpyEQq2NfeHnen47XYe9YNw65Gp4uOo3BvZygJ+
         K90w==
X-Gm-Message-State: ACrzQf38oM8uMSdHPBU4fS6WH+Ah8fbAnN3IjTf0v1NjU0pzKo880zjn
        +6xQ9Bvz6FOUiRsLJA+Pb+oLJhNGasQkYkFxJR6ugw==
X-Google-Smtp-Source: AMsMyM7gemIDs/xPxH55ukVoeGlszx5qd67EmMr1IOA6vi7/xHbMpqS4UBKJUmU6eG8KCtG6Z7qDJOGGolDtrXqF3vo=
X-Received: by 2002:aa7:cfda:0:b0:461:9d22:3484 with SMTP id
 r26-20020aa7cfda000000b004619d223484mr16043612edy.142.1667249272975; Mon, 31
 Oct 2022 13:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221028144241.634012-1-her0gyugyu@gmail.com> <CABVgOSmtD3GRV3hDoMw9EgMG4DPFWWK1SEDJT_yGDs7-CnwveA@mail.gmail.com>
In-Reply-To: <CABVgOSmtD3GRV3hDoMw9EgMG4DPFWWK1SEDJT_yGDs7-CnwveA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 31 Oct 2022 13:47:41 -0700
Message-ID: <CAGS_qxqWcD6wsncncqtFR00QO1QcLPm3e1Vzjto3ah-NoE3+jg@mail.gmail.com>
Subject: Re: [PATCH] kunit: alloc_string_stream_fragment error handling bug fix
To:     David Gow <davidgow@google.com>
Cc:     "YoungJun.park" <her0gyugyu@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 29, 2022 at 8:20 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Fri, Oct 28, 2022 at 10:43 PM YoungJun.park <her0gyugyu@gmail.com> wro=
te:
> >
> > When it fails to allocate fragment, it does not free and return error.
> > And check the pointer inappropriately.
> >
> > Signed-off-by: YoungJun.park <her0gyugyu@gmail.com>
> > ---
>
> Thanks! As Ma=C3=ADra points out, the added kunit_kfree() call isn't
> strictly necessary, though it definitely doesn't hurt (and it's
> probably a nice thing to free memory early if we're already in a
> pretty dire memory situation). So I think it's an improvement.
>
> The IS_ERR check is definitely a fix, though.

Note: the IS_ERR check was fixed already in
https://patchwork.kernel.org/project/linux-kselftest/patch/Y0kt1aCTHO4r2CmL=
@kili/
That change has made its way into torvalds/master.
So we could rebase this patch and reword it to talk just about the
early kfree().

Re free memory early:
It'll save us sizeof(struct string_stream_fragment) + sizeof(struct
kunit_resource), i.e. 24 + 56 =3D 80 bytes (on UML/x86_64).
So it's not much, but I guess it could help in edge cases.

Daniel
