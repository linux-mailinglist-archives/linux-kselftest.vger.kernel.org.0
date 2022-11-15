Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2B662AD88
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 23:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiKOWCR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 17:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiKOWCQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 17:02:16 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7117B2F65B
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 14:02:15 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 205so4334178ybe.7
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 14:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sOXMIOy4WN5lgYszDuN0wDh6uR0jdmTx6LWUdGFuzEs=;
        b=AF+51D2E1FcandtHFX4Qke0hi48D4Wilo29nSIEdG6lGEt+k91s3eUWb30nlqINzf5
         Umwsbj0SE2IoNowGYPLVVSDKCwpYr5/qftsCjYVMvGO1kZceiAZnuOwudIVOzctlTfvt
         6i5eclJ29WBAVhv88U+BRM+juEZMdo0bKOtYIOYoNtmVlBwKgqWeGEXHNAsl9y8POMt2
         uLNXWRPMoJLJj/0IPUGlBsQgtV0xPx/74LcEZtCoBbGym0tNEzdRNpD1qC1n+SCZj2MV
         tC3XXJnmmMVGItrMAx343PzXXpaFr5QvuqVS1mes+CuOsUQDbhmzJXzw/P3jE5P2LXvC
         HZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOXMIOy4WN5lgYszDuN0wDh6uR0jdmTx6LWUdGFuzEs=;
        b=hPU9tqoDR2w77Mnx27NmTux8ZiRQS6p7y/SbjHGUYZKNg9SjX2qVNw8kNYzwZLMNvP
         CvjXsdPvW+XahcRJns0WyxaZdyp2Os5bdPms3wzr7KgbyWdA7ilQsKRaD3QeMki4cMmD
         kpaRef3uQs2nbm6meDZoFBjmyoFrIGsVHajZLZOrBJLPyVqnCjMR5EFLiLJpTMV9kWHY
         w/P/hseB37KV/guqe4wXq3/JUwlNfKgOrS1VZEfKhC3qWpNN4bfQ2KSyomipGA/J1HWc
         3EpQSPoEyrwH4+J6PRkfwSkFktAEQYJoGvOqs4VULU8XL/uCT8kH1OM2ESe0GMpDwHWj
         Mv7w==
X-Gm-Message-State: ANoB5plcaoCsr2R7s8ZI/0RBOB3l2UcAkKFTzRHn9a26MEL4Dhjld3OY
        aZNz3jNY+iIkXRcnkysi4UftMsepXA1BM3eFCpoIpw==
X-Google-Smtp-Source: AA0mqf4lkBv42yxFQw9Hqi29Ph//5Po92DKW4izl43xIAFxlJiLUy9tXiRqfkHm+rOhKRfpaj+T3E5WusKhICukFuss=
X-Received: by 2002:a25:4016:0:b0:6ca:4fb8:a033 with SMTP id
 n22-20020a254016000000b006ca4fb8a033mr19598440yba.158.1668549734577; Tue, 15
 Nov 2022 14:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20221104194705.3245738-1-rmoar@google.com> <20221104194705.3245738-2-rmoar@google.com>
 <CABVgOS=eq0RnnP=MGMb-mZntA7+yZ=pe3U_dOq1gxoTPTeC8Bw@mail.gmail.com> <CA+GJov7N0gU_a2xNkj_ex9EiuGtDq+7k2zVh4CQ259DL-YMA2Q@mail.gmail.com>
In-Reply-To: <CA+GJov7N0gU_a2xNkj_ex9EiuGtDq+7k2zVh4CQ259DL-YMA2Q@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 15 Nov 2022 14:02:03 -0800
Message-ID: <CAGS_qxpQVWs2RYX_+6FZS8a9-M1GocoMjHNrLBADtkGzxh8mHw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] kunit: tool: parse KTAP compliant test output
To:     Rae Moar <rmoar@google.com>
Cc:     David Gow <davidgow@google.com>, brendanhiggins@google.com,
        skhan@linuxfoundation.org, mauro.chehab@linux.intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Nov 15, 2022 at 12:46 PM Rae Moar <rmoar@google.com> wrote:
> > - As Daniel mentioned, can we think of a better placeholder name for
> > tests without Subtest lines? One thought is to just leave it as the
> > empty string?
>
> I am definitely open to changing this placeholder name.
>
> The ideas I thought of are: "Test suite", just "Test", or just an
> empty string. "Test" or empty string may be less confusing. What do
> people prefer?

I'd prefer the empty string.

So it would show up as something like
===== (1 subtests) =====
[PASSED] case1
====== suite1 ======

Note: we'll just have to make sure to avoid a leading space (e.g.
we're currently doing message += f' (1 subtest)' )

Daniel
