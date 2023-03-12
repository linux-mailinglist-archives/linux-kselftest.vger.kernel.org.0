Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228D56B6308
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Mar 2023 04:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCLDZU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Mar 2023 22:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCLDZT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Mar 2023 22:25:19 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A287734C27;
        Sat, 11 Mar 2023 19:25:18 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id f1so6208338qvx.13;
        Sat, 11 Mar 2023 19:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678591518;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTsOdnsvMxiOI8KCSWCWvqwNEx3WV3fzPTdy2hJfLfc=;
        b=IXbho/A067RQWbtV+0EKK1uUxtq0mrwr8d7K4vHSJOzT+4+fcTHZv4qVIhUNc5itJZ
         CCWDas23QLX4Kb8N8AqYCsQGHgfExajdAteUv36qcbSeV3XAuBhugdr8nsezHgOmw+lQ
         1haphD4KIkssvc4FzFjnqa4o/X9BpDmU6yrnO1nYQks3oT6WeutV3pRe2fmIsAsC2KuT
         Uekk6nqJi551pPXKOhgJccQ9DmK95Cy4M1XCoNWwgP9iplNDhW0DXWeSLACD55a41Uxb
         4kTpob86gY3eVIbXDIO1/s8VwfbPT8WfPUZrGp9USVHefw7fCE0EYrgcAMBF5lksktJ+
         1Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678591518;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTsOdnsvMxiOI8KCSWCWvqwNEx3WV3fzPTdy2hJfLfc=;
        b=XgXa3yrzOdw9LDqwBvqUUHQaUyU7eljigwvJ7vqgSGXobo+n6sy/v8GALZeGsH15MI
         YYK96IqMIc6K691LmHogmzTkiAxnJgJz3LCLPqv2TakNAQhvfn1gFZQgvhx2lu/H9h3c
         Yq98nNHjazSCzhE+kj46Or3A/lHP1Gi9dYgAfCh3UO4FFWgr3oFVx1TnqXm7CaswCWiq
         XDmbysyolFysvnmEQGiokfGWZH3Du8YTBMiCbHXmqPjXl3fzDEfzdsKVi5mCMOMWCubz
         2BTjBYM+xCvuseImjQYZ0F0APv2qinRneBq+qFaAgH1vMR5GMqmhG2OWvvSa+9y80Dm9
         LaZQ==
X-Gm-Message-State: AO0yUKXSK2V4Iw+rPOpMNj0qb9d2SbKCuCQYdLzOfLB0cVNV+U8ls35/
        v12D7K8EGS5PPaK0ixlV/zk=
X-Google-Smtp-Source: AK7set+ZTONShD161Z3hYDMnAUKx5ZFFIrvmYAfdOsHGfVO7SsObksCHTnYksl95mbjXIXU88CqY4Q==
X-Received: by 2002:a05:6214:5182:b0:56e:f1fd:f16c with SMTP id kl2-20020a056214518200b0056ef1fdf16cmr10579267qvb.20.1678591517694;
        Sat, 11 Mar 2023 19:25:17 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:147a:a472:2165:1ae5? ([2600:1700:2442:6db0:147a:a472:2165:1ae5])
        by smtp.gmail.com with ESMTPSA id n73-20020a37404c000000b0074374e2b630sm2100164qka.119.2023.03.11.19.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 19:25:17 -0800 (PST)
Message-ID: <7180be2d-60c7-0d99-338e-b818771b310f@gmail.com>
Date:   Sat, 11 Mar 2023 21:25:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [KTAP V2 PATCH] ktap_v2: add skip test result
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>, davidgow@google.com,
        skhan@linuxfoundation.org, keescook@chromium.org,
        Tim.Bird@sony.com, brendanhiggins@google.com
Cc:     corbet@lwn.net, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310222002.3633162-1-rmoar@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230310222002.3633162-1-rmoar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/10/23 16:20, Rae Moar wrote:
> Add the test result "skip" to KTAP version 2 as an alternative way to
> indicate a test was skipped.
> 
> The current spec uses the "#SKIP" directive to indicate that a test was
> skipped. However, the "#SKIP" directive is not always evident when quickly
> skimming through KTAP results.
> 
> The "skip" result would provide an alternative that could make it clearer
> that a test has not successfully passed because it was skipped.
> 
> Before:
> 
>  KTAP version 1
>  1..1
>    KTAP version 1
>    1..2
>    ok 1 case_1
>    ok 2 case_2 #SKIP
>  ok 1 suite
> 
> After:
> 
>  KTAP version 2
>  1..1
>    KTAP version 2
>    1..2
>    ok 1 case_1
>    skip 2 case_2
>  ok 1 suite
> 
> Here is a link to a version of the KUnit parser that is able to parse
> the skip test result for KTAP version 2. Note this parser is still able
> to parse the "#SKIP" directive.
> 
> Link: https://kunit-review.googlesource.com/c/linux/+/5689
> 
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

< snip >

Another reason to add the "skip" result is that there was disagreement in previous
discussions as to whether the "#SKIP" directive should be used in an "ok" result
or a "not_ok" result.

