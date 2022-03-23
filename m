Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC584E5A52
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 22:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240859AbiCWVFu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 17:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiCWVFu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 17:05:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7473D11C1C
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 14:04:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dr20so5344652ejc.6
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96OPHRtjpLUkzMKOmZHTFwbJz5Jyl9hyIas7RLYSw4Q=;
        b=Y031F6hf2sWxJzVczsI6DwN15K/fScPKXLhbWHFfYBi5upYSFMRNec8Mbc4WSNARgG
         4sqVpLnuoG2DGIOHvH8mL3diB5NIeN+mwoDHLMhIHicZa7/WmLnePbKJOMCYQeyBnksJ
         zXeVrIYCMBR8bHLbJfOgZ3nIXkjF0DkkmiA+K8Lbyw2184VsnpUDPLqIUWX3fJN8OIpw
         oLIOpj707wDyyb05BnFgblOUt6Qy7S5VXF01Au9UWWc+bnH/xymFEue+2j8Yms2aRMAp
         gseQ5FsJr12DGqdxxWBNrjOJbAYM+NK4NRYB1e2bbFfxyA0StQlKn9rt7pBAoOqeH4zq
         nHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96OPHRtjpLUkzMKOmZHTFwbJz5Jyl9hyIas7RLYSw4Q=;
        b=pvUQm+b6Ac2xZrfRCXdpsTiowRxdcmPF5QeJlsrKNGVJf+bvemja0rU5d1yTphjY7d
         A+Kq5DU8dhocpWM9SoX3XODddaM+eTsVguTDNarHyv7P2nkUWorUyE5ZBV5hcuSuzLhF
         CqpuyOapWm4Q9xvXYS5IdYd0tc91hU7f241IWOVfKLF1Kl+lLY4MsnLeBtfGNN2qcj2X
         uP3BSdWEjlkdXe7YviToG9n856n4xULvu1bDo7ekTjgmXdjP2Pnl6lMsi2sBIuq/lErV
         IfylijQkrbmPbGc3W6AyyAIUKHfzhtdxWKERIoX0fsInEg26mvhSexJ3KnZUahtel5xS
         3tZQ==
X-Gm-Message-State: AOAM5332tm+IsqG3f3Xx3jcttySA+iu2hVW6djvbhdnnuUP9YTQy6I9T
        ZhTlL+zPm1XVyKM1e6RRs8AN7+YaUH41E9SG+9LaHQ==
X-Google-Smtp-Source: ABdhPJzdu0So/JbbLp6MeXfrKuRthxofNbACLCTnpUvfS7ucyWSPfllgGv30FdGrNnTR49ZFPKiqvjn2qeHRG4voyBw=
X-Received: by 2002:a17:907:c018:b0:6df:e31b:d912 with SMTP id
 ss24-20020a170907c01800b006dfe31bd912mr2204489ejc.196.1648069456760; Wed, 23
 Mar 2022 14:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com> <20220118190922.1557074-5-dlatypov@google.com>
In-Reply-To: <20220118190922.1557074-5-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 17:04:05 -0400
Message-ID: <CAFd5g47vptm6c0x+sbUpYTgNL6viH2Yj8k8GMG=WKN2A6eTA5Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] kunit: tool: simplify code since build_dir can't be None
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 18, 2022 at 2:09 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> --build_dir is set to a default of '.kunit' since commit ddbd60c779b4
> ("kunit: use --build_dir=.kunit as default"), but even before then it
> was explicitly set to ''.
>
> So outside of one unit test, there was no way for the build_dir to be
> ever be None, and we can simplify code by fixing the unit test and
> enforcing that via updated type annotations.
>
> E.g. this lets us drop `get_file_path()` since it's now exactly
> equivalent to os.path.join().
>
> Note: there's some `if build_dir` checks that also fail if build_dir is
> explicitly set to '' that just guard against passing "O=" to make.
> But running `make O=` works just fine, so drop these checks.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
