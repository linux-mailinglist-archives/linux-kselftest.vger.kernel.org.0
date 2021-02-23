Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272D13225ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Feb 2021 07:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhBWGbW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Feb 2021 01:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhBWGaa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Feb 2021 01:30:30 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B0FC061574
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Feb 2021 22:29:49 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id u8so15937149ior.13
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Feb 2021 22:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItTDB5sUANcyO8fzgqNMRbwBdT6LStcOgI5johhBaiQ=;
        b=qNWMc3Bc3SqnhF+1KqKzKgCcUbmRrLa1UOoDnDh1VnIjYmUTkBYKRve+SnuAARSM6g
         ufkJpKfaiz1W+f0uE54KIo24fbQDDKCoqqFprm6gZdTJn7z+0e0A9W0LVSR7He8FENai
         7dhY8RSfYjO9RMp+xXfI0i5dmpNp0lNU2DGto0xwXu3eXdpEcKxYIhnhUZcg6LOd1Ubb
         Q3GVttUMKSTU6LLFpxg3CEsfM2yS4edVVEuKjjlHUhqhQnIfII5UmczfbxmHPMgIAHH9
         IFJxDcM2qFihSYadlTVmSmVo1ewBOG18GgANm88hoCMVQ2Yez11OTeoAGnPHhdP9CL7a
         t4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItTDB5sUANcyO8fzgqNMRbwBdT6LStcOgI5johhBaiQ=;
        b=EQTmVPELNkoOapCn3yneLNIC1wneBYVIDjV7fIMn/KQnbBAheyKGqPzlrZdYBN+BwU
         bkRiN068180tAdBFtguPQ9ooWeqJozwkc1YP30UA9n19PxvWok9KSmxcod5DRRMjh2en
         u9W3wVR2zOWhhYK+SR3hE3sn5o7spLMqmxB218sU5EaHZs6qsq7RUlA61N5Dkg0m+Na9
         RtvUILs890JmrkyVGqfEPg0p27UhEoEjcBaU41KWaHd1i0HqU7EntrQDsnBvygPWoE6t
         oC0A8iUoOm9AdtUj63yWV1yGV3FugAp+uHBWNlEbGtRbcFnDP/TCjGZDKfGpYWSIUAcH
         TXtA==
X-Gm-Message-State: AOAM530OUXRJErv9hex6a4d4cW5Zg87mHRmLBFcCz9dl2SkLr/IqkkgF
        /29jRVcitMo/mepV16HXzL2YWgSCZuxasorkXIs8DQ==
X-Google-Smtp-Source: ABdhPJxaLayWuRU1U/pWVgzYANX6AkcP3C3TScz3s5HpCqlQKTd2NQ17OMd4EYpXNR6z9kXrNAVaVWmm1L6+Xmt+t+g=
X-Received: by 2002:a5d:9c4e:: with SMTP id 14mr17998159iof.57.1614061788952;
 Mon, 22 Feb 2021 22:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20210223054930.2345555-1-davidgow@google.com>
In-Reply-To: <20210223054930.2345555-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 22 Feb 2021 22:29:37 -0800
Message-ID: <CAGS_qxpr+-0Kk2ijH5uo_tSbQODN9hJpEedW0A_SK2rBW9ZbFQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix a python tuple typing error
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 22, 2021 at 9:49 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> The first argument to namedtuple() should match the name of the type,
> which wasn't the case for KconfigEntryBase.
>
> Fixing this is enough to make mypy show no python typing errors again.

Ah, this is something apparently only newer versions of mypy detect.
On 0.782 I didn't see it, but after pip install --upgrade to 0.812, I
see the error.

While I'm here, I also upgraded my pytype install and checked.
It's happy w/ or w/o this patch.

So while this is in some sense an error only mypy cares about, this
fix does make the code more stylistically correct and should
definitely go in.

>
> Fixes 97752c39bd ("kunit: kunit_tool: Allow .kunitconfig to disable config items")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

> ---
>  tools/testing/kunit/kunit_config.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
> index 0b550cbd667d..1e2683dcc0e7 100644
> --- a/tools/testing/kunit/kunit_config.py
> +++ b/tools/testing/kunit/kunit_config.py
> @@ -13,7 +13,7 @@ from typing import List, Set
>  CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
>  CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
>
> -KconfigEntryBase = collections.namedtuple('KconfigEntry', ['name', 'value'])
> +KconfigEntryBase = collections.namedtuple('KconfigEntryBase', ['name', 'value'])
>
>  class KconfigEntry(KconfigEntryBase):
>
> --
> 2.30.0.617.g56c4b15f3c-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20210223054930.2345555-1-davidgow%40google.com.
