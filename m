Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EA8525139
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 17:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348090AbiELPZW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 11:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355917AbiELPZS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 11:25:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B6D2608C9
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 08:25:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dk23so10928595ejb.8
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZMxjSJmldQ3JWCoivCnvn/+FiMrBE9vcPF4uGtQz2A=;
        b=hhzaIlWaIG4YpufqFFKKB+9c/4n/9E89t2cVHITLb/CTZiRXgM4WOJTmuW5fPTCYtC
         c/jh9WFhKOMhx5aVbeKji3Tus8LJw4bjHpNOfXm+PqFrROCEA6/i0kitKKu49HOEzdzz
         4sobYKpWQqGS+YoDGoLZ/xoT2+4FdIAQgU9YbMrz1boNVhux5IHe8ZdQ/dqcwgcNq1Dh
         N9enZ/zIy58r4SEc42V6EkirsIn9CWFVD82Wfx2nk6whuMj++SmG7uYjm1wvISVRnprR
         xXLLtQvXbWxruFV4WKCz6UeWZiYrAcJPVsvRxLuxAQvAdy+8T5CjQiLzuSqz6pUBq2wM
         JX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZMxjSJmldQ3JWCoivCnvn/+FiMrBE9vcPF4uGtQz2A=;
        b=ZGsIki0RHWCTnBxM9Jx7iYaMiQLHH6Kwh0qbgAkX98hi0xTlrH/wHGAP8nb68l9prt
         a/jW4OO3HNdcv5V4Ftbo3rVDqu4fxg3NNi5KJrap3GJi+8bkCJl8kcX2n1bvcs5rPCcm
         Pbi/Jpar4eVUrUtDxg31gDbKtHGvKX8Oel0AnF3kc7i+s6J9PRKnl3ZUpevExdmEqLcd
         Iu3HFAOY7Y8m5CHulMKr1Wi2sYvQLof/juCA5hDGZm6r1GWIIN3d25uAt2RxdXzVsg+o
         6Od1arwF267NJXUyESHe2M0cRlep4guZd4xSsks/wG6mX7/jQG4oYP7SGBQ2At6ktVby
         L6HQ==
X-Gm-Message-State: AOAM530Iezr6kKi66Dy9INPqJT801QvDnemVRrRGtMfEV2ordvdU5uf/
        30KlIDix9GsEQI8bgEo1gpyLobnc4vC6qLXyL2wltw==
X-Google-Smtp-Source: ABdhPJyw52u6k4SKpOakHeWu7gjr6JuceopSOtVUJ5BHjzjLTgPQPdonUQjHuVeMJTBgwp2cRZ99WzBoL3BHUYZYrEk=
X-Received: by 2002:a17:907:72ce:b0:6f4:5a57:320c with SMTP id
 du14-20020a17090772ce00b006f45a57320cmr389491ejc.75.1652369115386; Thu, 12
 May 2022 08:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <bc6e9ed7-d98b-c4da-2a59-ee0915c18f10@gmail.com> <5ca35c47-6145-4ec1-6c05-3c46f436cb4d@gmail.com>
In-Reply-To: <5ca35c47-6145-4ec1-6c05-3c46f436cb4d@gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 12 May 2022 08:25:04 -0700
Message-ID: <CAGS_qxpE9qGsS1LqaobVGFKFgV6TwvwNLR4e9PG5zsfPACSf_Q@mail.gmail.com>
Subject: Re: [RFC] KTAP spec v2: prefix to KTAP data
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 11, 2022 at 11:01 PM Frank Rowand <frowand.list@gmail.com> wrote:
> ================================================================================
> #### discussion notes:
>
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> PRO: minimally invasive to specification.
>
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> CON:
>
> KTAP does not include any mechanism to describe the value of <prefix string>
> to test harnesses and test output processing programs.  The test output
> processing programs must infer the value of <prefix string> by detecting
> the <prefix string> in the "Version lines".
>
> The detection of a "Version lines" might be a match of the regex:
>
>    "^.*KTAP version 2$"
>
> This risks falsely detecting a "Version lines", but the risk is small???

Agree this is a risk and also think it's probably small, but it's hard to say.
I think the $ anchoring the regex is probably safe enough.

As noted earlier, this tracks with what kunit.py already does.
That was necessitated by dynamic prefixes such as timestamps, etc.
So I think this is probably a fine risk to take.

I imagine we could add constraints of prefix string, e.g. must have []
around it, etc. if we want to try and minimize this risk.
But I don't know if it's necessarily worth it, given what we know right now.

Along those lines, I think I like this approach (Alternative 1) more
than Alternative 2/2b.
I'm not sure we need a structured way to specify metadata in KTAP yet?
The prefix seems like a reasonable candidate, but do others have ideas
of other bits of metadata we'd want to be able to declare?

Daniel
