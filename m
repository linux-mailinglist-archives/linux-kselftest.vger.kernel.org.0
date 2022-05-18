Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C8F52BF93
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 18:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbiERPbs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 11:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239353AbiERPbm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 11:31:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A373E5C9
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 08:31:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ck4so292170ejb.8
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BsKITgJe0n74ro4jmQWlnQSOXtIrCCeeoRj5fvJvlc0=;
        b=QbX9x8QYId9IYqLSJLz7B0lNYR5Ysq9SBtezIFgF9MxRuFFhgUQb08yofIQ91NjF6T
         j8BNWfBXTMUcqev9dUOJvjngjgkinx9SiYS0zg/d9CVznombWSAUvvOCZa/PuaVB3gwN
         1uqYIsQhnkwLB7akZjsrIp2VfWC1BcVGVCaD0AAVV3T+AUJkM9grUxrjgGOUlcbpCJ7Q
         IeWC5F8GO0y6JSidBbBMapnVKYFFwBBW9XUYgsKDbR2gGqbLYPKMNNiaZDRzEa24wDKr
         j8pNn6PckGBWkyQaarY2OOp8IP9hmqxUkTcK3KmWub42D4ReKkPddXGxFnJ7tv5ZqaV9
         jJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsKITgJe0n74ro4jmQWlnQSOXtIrCCeeoRj5fvJvlc0=;
        b=rVKEeaw0nagKxfng9Td9TRwqTpmX18QarHIcwt1TlNTDIxWA3GaxgBy0CwYlnoR+UD
         gtqkrZhWN3UpAVkLB+mRUdXQlou1BobYhItpF68JxQJzYLyBTTOBhM5s6vhuaHkFGctv
         fwZ3ygcCIAoxtKoRPrT+jOdnSFlOxwDkff23vnM7kuJNn0klGkidUVcqE1D9fvFYTyiu
         oCNpXPXtFEvJB/k4F6l04LlcnIQ9nc9bN+CSH4W4dL85p26Y/atxwQ8GpdFG9baZNYF/
         yWPNuh5kVSj+INf/RYidknm/TXmuIPJZ7MWQ2oy07cEA9XvOwZyuF1IaUnJpp7uGptp2
         LGfQ==
X-Gm-Message-State: AOAM533bD8GTLP22uu2I8x25NAyCxEYqa43RVAID9LXgtwDDN9nfePOe
        +gf5VB1KbeBVWLt7lW+R8UeXH8zaI0E3FD0Z0Tjewg==
X-Google-Smtp-Source: ABdhPJypdAwNsHGSQOCFoNHLEpvFi/jgA+FFF6DbVWnbkiIb+knGUAlhkoYYf6uCpI4qtHTl6NSZOVNx73Y9TpbSvCE=
X-Received: by 2002:a17:907:2cc7:b0:6fa:7356:f411 with SMTP id
 hg7-20020a1709072cc700b006fa7356f411mr118908ejc.369.1652887898099; Wed, 18
 May 2022 08:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com>
In-Reply-To: <20220518073232.526443-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 18 May 2022 08:31:27 -0700
Message-ID: <CAGS_qxrOUYC5iycS436Rb-gEoEnYDa2OJLkQhEVXcDN0BEJ4YA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: Add x86_64-smp architecture for SMP testing
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, May 18, 2022 at 12:32 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Add a new QEMU config for kunit_tool, x86_64-smp, which provides an
> 8-cpu SMP setup. No other kunit_tool configurations provide an SMP
> setup, so this is the best bet for testing things like KCSAN, which
> require a multicore/multi-cpu system.
>
> The choice of 8 CPUs is pretty arbitrary: it's enough to get tests like
> KCSAN to run with a nontrivial number of worker threads, while still
> working relatively quickly on older machines.
>

Since it's arbitrary, I somewhat prefer the idea of leaving up
entirely to the caller
i.e.
$ kunit.py run --kconfig_add=CONFIG_SMP=y --qemu_args '-smp 8'

We could add CONFIG_SMP=y to the default qemu_configs/*.py and do
$ kunit.py run --qemu_args '-smp 8'
but I'd prefer the first, even if it is more verbose.

Marco, does this seem reasonable from your perspective?

I think that a new --qemu_args would be generically useful for adhoc
use and light enough that people won't need to add qemu_configs much.
E.g. I can see people wanting multiple NUMA nodes, a specific -cpu, and so on.
