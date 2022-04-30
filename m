Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4503515B0D
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Apr 2022 09:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382316AbiD3Hoi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 30 Apr 2022 03:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiD3Hoh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 30 Apr 2022 03:44:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2435224591
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Apr 2022 00:41:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a1so11382693edt.3
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Apr 2022 00:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kwPZKfu//VArF+FVVE8zbUqlSbSrCotry34rYD1+ekw=;
        b=ZoJDMlDRJQ+VhW4am5V169loO6fm7omKdERD77BJM0/JbiBvl70/SdDm5TY397yuf3
         rEj9Abv54/G7Btssc/0oJPXqDQR6m2ex9pM2Vvj1gozMPRCOqqszbxsdNYU2dB1p8Wnn
         AjQnlfHYHjTq8MIksiHY9n0oJn7jSVOR9A+wYn/mKyo5G06maOHup9fFwLUVwA1B/KRt
         HybaxGVyV4LOwi2buaE0z8iOLG0+iAX49x7AgSAG4LQXRHCPHh9ZZ/iSplo5tujCZvFn
         DexN5sVTAt0FKRCFtk+KJY/+qyGDH0cGjOQDkAVGTy2+RygyPTXwDY6N/TsjDXeVviPs
         zU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwPZKfu//VArF+FVVE8zbUqlSbSrCotry34rYD1+ekw=;
        b=Y2hHCLqH/o3xJ3/PGfu6h3PznZh57vy8muBdpYkGzkuHfnobdbn3Tfl6J1RZahREr7
         805IPMbg37nDiXwHybfovByW4yuYKqV7NrUJi5RBGJ8AknSjHM9ctdSMzYta3OBvXnKm
         Cg5frE6Ed0XWvgUnuw7hKJ1ICVl3iJYK8PEPOQirDr6Tvn82zd8cw0vr10fNoQje21ag
         XVSg1siuB9SrvzHkAhmVmFCPd3RoPp1qz4Mw+Ewcc99tWhYpRxUqNVqkk1wD59WeIZBO
         Zqg2G6ERbSmRfCJg0T+9Ht9rbyUcZ+GLq2eqjjoLe21HoV6qBe4i6vnL9MWSJ8e54JN6
         fWpQ==
X-Gm-Message-State: AOAM531JQnXTh5SrRjxsO3OE2OJs2PkYEg/d/jWEoUgUbNM2uqNzbPrF
        EcS+PFbgUquuc7UtVo2Y7Vv8d7eP7Rb0RptZJmBG9g==
X-Google-Smtp-Source: ABdhPJxR5dUZBHrZwxXS0EjAc8Yo2gFytkKQR0GWsxYatgTIE/NVBNHffKX/m/kBw0qYCP440uqV+fioqmlRZFZG9NI=
X-Received: by 2002:a05:6402:1cc1:b0:413:2b12:fc49 with SMTP id
 ds1-20020a0564021cc100b004132b12fc49mr3364804edb.118.1651304473460; Sat, 30
 Apr 2022 00:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220429181259.622060-1-dlatypov@google.com> <20220429181259.622060-3-dlatypov@google.com>
In-Reply-To: <20220429181259.622060-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sat, 30 Apr 2022 03:41:02 -0400
Message-ID: <CAFd5g469Q2hF18HXgAhs=3ds_=Pw-s2yw3=msaCucJs-JVFmfA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] kfence: test: use new suite_{init/exit} support,
 add .kunitconfig
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 29, 2022 at 2:13 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, the kfence test suite could not run via "normal" means since
> KUnit didn't support per-suite setup/teardown. So it manually called
> internal kunit functions to run itself.
> This has some downsides, like missing TAP headers => can't use kunit.py
> to run or even parse the test results (w/o tweaks).
>
> Use the newly added support and convert it over, adding a .kunitconfig
> so it's even easier to run from kunit.py.
>
> People can now run the test via
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=mm/kfence --arch=x86_64
> ...
> [11:02:32] Testing complete. Passed: 23, Failed: 0, Crashed: 0, Skipped: 2, Errors: 0
> [11:02:32] Elapsed time: 43.562s total, 0.003s configuring, 9.268s building, 34.281s running
>
> Cc: kasan-dev@googlegroups.com
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Tested-by: David Gow <davidgow@google.com>
> Reviewed-by: Marco Elver <elver@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
