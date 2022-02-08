Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7470A4ADEFC
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 18:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352623AbiBHRLK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 12:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345912AbiBHRLJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 12:11:09 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF710C0613CB
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 09:11:05 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id y84so22066247iof.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 09:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DUOmgbDHv9TGhzCwwc6ir5fTuwgLxZHx2yr6wrlhX/c=;
        b=eex8i7kur3v78Vl/7duuld6Gedj+S9MbQzPL4dqaRAmkcvf6y19qbfCr7f0mpjVnYe
         7NbM8tZue9DfEpwG7KleDx6axk4urVIRu6QhVzMymZ9l3AoEsJDxpe1mTPCJRrBPLTRv
         GR5X4ED9HqF2qffqJd17N70du82rofyEAm0dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DUOmgbDHv9TGhzCwwc6ir5fTuwgLxZHx2yr6wrlhX/c=;
        b=Skv6bx8RDnQPzFdBPfUMjPn0kBdA+ZgWQPdP6LQvhWPdhnm8Bs2jxIaah9e8AkCTZo
         gPZ3F4G29hcqzqtXuqOpvITJ73n3EskwL0dvLzH1SlyVJ9KnPHw4YZi+G7aJ4TXy6N6W
         6LNFCg73xAkjrZEgGLrvRxRjvs8rAV3qFU/8PdxIGMKj3i98gHtExDAgXwx2wTc2vL2y
         QWwWlyfvAaHNjNSnp7VSnIeZj3YmMrMCx/VZ0UEO8RzHYMdzS7uPoT0cR1Rrv+aMThVx
         jYoiR91ZJmkHlGbiOCfcknQTwp2cZpRQQara0QqCPmMasPG7+wMB4FhE3XQCuMi2hB25
         Xk1w==
X-Gm-Message-State: AOAM532F1hf+NiwUUIy78xb2FPmAv4t51yApB4KlqQA+yDucyup50/3M
        hbXT+wLIZlDAWw/eFNKPli/oXQ==
X-Google-Smtp-Source: ABdhPJxI+60kUWV0wK02Do1Ljum8fRfUSV96QCsR/1AD9uHXCNG3g22230pw4nhS3axAL2kQCSoY8Q==
X-Received: by 2002:a05:6602:2ac1:: with SMTP id m1mr2448582iov.123.1644340265093;
        Tue, 08 Feb 2022 09:11:05 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g7sm7620275ild.23.2022.02.08.09.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 09:11:04 -0800 (PST)
Subject: Re: [PATCH v3 1/1] Documentation: dev-tools: clarify KTAP
 specification wording
To:     frowand.list@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Tim.Bird@sony.com, Brendan Higgins <brendanhiggins@google.com>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220208164623.3151777-1-frowand.list@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <86c4c8ce-468d-8922-3ada-7960f1924ba8@linuxfoundation.org>
Date:   Tue, 8 Feb 2022 10:11:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220208164623.3151777-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/8/22 9:46 AM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Add the spec version to the title line.
> 
> Explain likely source of "Unknown lines".
> 
> "Unknown lines" in nested tests are optionally indented.
> 
> Add "Unknown lines" items to differences between TAP & KTAP list
> 
> Reviewed-by: Tim Bird <Tim.Bird@sony.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> Changes since version 2
>    - Add missing quote after word: incorrect
>    - Add Reviewed-by tags
> 
> Changes since version 1
>    - Explain likely source of "Unknown lines"
>    - "Unknown line" in nested tests are optionally indented
>    - Add "Unknown lines" items to differences between TAP & KTAP list
> 
>   Documentation/dev-tools/ktap.rst | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
> index 878530cb9c27..dfb3f10a8b2d 100644
> --- a/Documentation/dev-tools/ktap.rst
> +++ b/Documentation/dev-tools/ktap.rst
> @@ -1,8 +1,8 @@
>   .. SPDX-License-Identifier: GPL-2.0
>   
> -========================================
> -The Kernel Test Anything Protocol (KTAP)
> -========================================
> +===================================================
> +The Kernel Test Anything Protocol (KTAP), version 1
> +===================================================
>   
>   TAP, or the Test Anything Protocol is a format for specifying test results used
>   by a number of projects. It's website and specification are found at this `link
> @@ -174,6 +174,13 @@ There may be lines within KTAP output that do not follow the format of one of
>   the four formats for lines described above. This is allowed, however, they will
>   not influence the status of the tests.
>   
> +This is an important difference from TAP.  Kernel tests may print messages
> +to the system console or a log file.  Both of these destinations may contain
> +messages either from unrelated kernel or userspace activity, or kernel
> +messages from non-test code that is invoked by the test.  The kernel code
> +invoked by the test likely is not aware that a test is in progress and
> +thus can not print the message as a diagnostic message.
> +
>   Nested tests
>   ------------
>   
> @@ -186,10 +193,13 @@ starting with another KTAP version line and test plan, and end with the overall
>   result. If one of the subtests fail, for example, the parent test should also
>   fail.
>   
> -Additionally, all result lines in a subtest should be indented. One level of
> +Additionally, all lines in a subtest should be indented. One level of
>   indentation is two spaces: "  ". The indentation should begin at the version
>   line and should end before the parent test's result line.
>   
> +"Unknown lines" are not considered to be lines in a subtest and thus are
> +allowed to be either indented or not indented.
> +
>   An example of a test with two nested subtests:
>   
>   .. code-block::
> @@ -225,9 +235,11 @@ Major differences between TAP and KTAP
>   --------------------------------------
>   
>   Note the major differences between the TAP and KTAP specification:
> -- yaml and json are not recommended in diagnostic messages
> -- TODO directive not recognized
> +- yaml and json are not recommended in KTAP diagnostic messages
> +- TODO directive not recognized in KTAP
>   - KTAP allows for an arbitrary number of tests to be nested> +- TAP includes "Unknown lines" in the category of "Anything else"
> +- TAP says "Unknown lines" are "incorrect"; KTAP allows "Unknown lines"
>   

If we can put the data in a table - makes it lot easier to read

>   The TAP14 specification does permit nested tests, but instead of using another
>   nested version line, uses a line of the form
> 

Looks good otherwise. Thanks for clearly outlining the differences.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
