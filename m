Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB334AC685
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 17:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbiBGQy0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 11:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356846AbiBGQi4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 11:38:56 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6450EC0401D3;
        Mon,  7 Feb 2022 08:38:55 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id k25so12371527qtp.4;
        Mon, 07 Feb 2022 08:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=omVF455pvemsLVj7xnWoQW2sUd/KNgnEiQ/s7RiZc/8=;
        b=k4ayfMnBUu4S6TrIigANz8YZeT5vNoAtZLetXYMk3RebEfveH9HpwQcw0k/rgqjlrH
         Q59gx6DXbE8RrT3JvuEHw/CNPeWwO/4M+SfHaWP7UUGP2ew/SrAQ2+NhzZDr6T16tvhT
         sQ2VPhM1sjB3PcgAp+MV5ow2SXxIw0i1Gzz/ceQiSWxUFY7q6cKdIn1P4YxdxqyHLKCT
         uNiiDeA3rF6sGDEVj5fIMN29ommgeQJP+GObCCdU/AAfeSt06jCHf8ZpOfmE9naHPi3T
         /pcrAIuoQ9aRkofY5fXPYNnzvZFqKooSyxzBu1DB3jEF36Jm75Uy4ArE9oleZbKkt4oK
         z11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=omVF455pvemsLVj7xnWoQW2sUd/KNgnEiQ/s7RiZc/8=;
        b=FCykHHuhYO/ZfYw1u4GfSeVO2SL+nt49g2p2UGgpGMz+m7u2fXRoEti5XCR8L+MsPv
         CDsPEqo/jv7BHqRfflYQ1IS2FbfM+dVJiPdXaBfQ6MZYO5Kt4v2ji4Mcj3oLlb9shglD
         ojEcSpxFhYzYBYUJGDOJfhHoqkvu7ZDYzK5uEl0IjR+QILGk8x1FsLVWBZrHUG15lr2a
         2RCK8CQNq1ERZrwnY6Oy5kLmmQ0tMTUpS/uPHQTebNKkJeNZvew/ucnxZtcbSbB6vHNH
         rMFdBjMS6OsRjYmibgUTyEFYkfDaIx3qmHvbiVM4sKzRjOGM2xWFL0ida3jjqF9qA3wC
         GIZw==
X-Gm-Message-State: AOAM5319b+iOtBBXgP2jHTcRyriM+gHznAJ+6hlhPQG20Yy5kKp20QYn
        Z3F4/FYpKFapWWgWSCIPpk4Ywq09/fc=
X-Google-Smtp-Source: ABdhPJz9t66FJObaww+NCPnsu5oVG34zt8pjj7Gcflr5t4pIH0YwYAuy2AWGPb1lXRD1+Rewit68SA==
X-Received: by 2002:a05:622a:14d4:: with SMTP id u20mr254950qtx.262.1644251934550;
        Mon, 07 Feb 2022 08:38:54 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id z22sm5509676qko.2.2022.02.07.08.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 08:38:54 -0800 (PST)
Subject: Re: [PATCH v2 1/1] Documentation: dev-tools: clarify KTAP
 specification wording
From:   Frank Rowand <frowand.list@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Tim.Bird@sony.com, Brendan Higgins <brendanhiggins@google.com>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220207162813.3091899-1-frowand.list@gmail.com>
Message-ID: <e795ad1a-ddb1-f0af-4a74-7c2c6a0a949a@gmail.com>
Date:   Mon, 7 Feb 2022 10:38:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220207162813.3091899-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/7/22 10:28 AM, frowand.list@gmail.com wrote:
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
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---

Please do not apply this version (v2).  I was working off the KTAP specification
from a different github repo than I should have been referencing.

v3 upcoming.

-Frank

> 
> Changes since version 1
>   - Explain likely source of "Unknown lines"
>   - "Unknown line" in nested tests are optionally indented
>   - Add "Unknown lines" items to differences between TAP & KTAP list
> 
>  Documentation/dev-tools/ktap.rst | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
> index 878530cb9c27..9c40c94d3f12 100644
> --- a/Documentation/dev-tools/ktap.rst
> +++ b/Documentation/dev-tools/ktap.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -========================================
> -The Kernel Test Anything Protocol (KTAP)
> -========================================
> +===================================================
> +The Kernel Test Anything Protocol (KTAP), version 1
> +===================================================
>  
>  TAP, or the Test Anything Protocol is a format for specifying test results used
>  by a number of projects. It's website and specification are found at this `link
> @@ -174,6 +174,13 @@ There may be lines within KTAP output that do not follow the format of one of
>  the four formats for lines described above. This is allowed, however, they will
>  not influence the status of the tests.
>  
> +This is an important difference from TAP.  Kernel tests may print messages
> +to the system console or a log file.  Both of these destinations may contain
> +messages either from unrelated kernel or userspace activity, or kernel
> +messages from non-test code that is invoked by the test.  The kernel code
> +invoked by the test likely is not aware that a test is in progress and
> +thus can not print the message as a diagnostic message.
> +
>  Nested tests
>  ------------
>  
> @@ -186,10 +193,13 @@ starting with another KTAP version line and test plan, and end with the overall
>  result. If one of the subtests fail, for example, the parent test should also
>  fail.
>  
> -Additionally, all result lines in a subtest should be indented. One level of
> +Additionally, all lines in a subtest should be indented. One level of
>  indentation is two spaces: "  ". The indentation should begin at the version
>  line and should end before the parent test's result line.
>  
> +"Unknown lines" are not considered to be lines in a subtest and thus are
> +allowed to be either indented or not indented.
> +
>  An example of a test with two nested subtests:
>  
>  .. code-block::
> @@ -225,9 +235,11 @@ Major differences between TAP and KTAP
>  --------------------------------------
>  
>  Note the major differences between the TAP and KTAP specification:
> -- yaml and json are not recommended in diagnostic messages
> -- TODO directive not recognized
> +- yaml and json are not recommended in KTAP diagnostic messages
> +- TODO directive not recognized in KTAP
>  - KTAP allows for an arbitrary number of tests to be nested
> +- TAP includes "Unknown lines" in the category of "Anything else"
> +- TAP says "Unknown lines" are "incorrect; KTAP allows "Unknown lines"
>  
>  The TAP14 specification does permit nested tests, but instead of using another
>  nested version line, uses a line of the form
> 

