Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6418358FDAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Aug 2022 15:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiHKNtp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Aug 2022 09:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiHKNto (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Aug 2022 09:49:44 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A558991F;
        Thu, 11 Aug 2022 06:49:40 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id j17so8735072qtp.12;
        Thu, 11 Aug 2022 06:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=ycqVFDjjlSz4BGsRWhX/Rm6K2hCv5ji5U2hZQvy6Esw=;
        b=rdTmpAtSbVqgjs7BL6+pYO71qCb07PF3eKpK9Xcde33GSCllN8DiAJcAYGpbOGDCJd
         iO8eQCxNtG1hCHecLGy0AODrN9pG1Tf2wkByKk0mOoHIKjpFPjQmvXP2C0H5QZpAXSlo
         8H+YUsnBWTzDMZ3EvxG7dIEigspeAZAVim4QVOtmCWLiM4HICzhY8McGj3ccFgNb+EAL
         T45HZFn3ehYWj/CxtWZohdC1zjGPDRsBCfzj2uhRMHtPpL4/vHGX6s+3IsbnvbAcWcK2
         FmQ9ez9NgymGf8BeIMPVk7d24F7oVTPc2qFrsv45YO7DqY6SqXDxg9nERJpI7bmofz+Y
         i/gA==
X-Gm-Message-State: ACgBeo32bsNXkFSP5DTAB7fQx19s0DHzGUFTSjuLgHXt/N4cs72zU95Z
        DnwVE9QkQ7i2ruMOSSq7DX17svTLx8c35yGK
X-Google-Smtp-Source: AA6agR6EtPk/iSBVvIUf8DzYPk9WT8oBxLen5jNg2mg7iMH72mSxbyDni0DNUKfPGFFgt2vLMeUQ1g==
X-Received: by 2002:ac8:57c7:0:b0:341:8a19:aa28 with SMTP id w7-20020ac857c7000000b003418a19aa28mr29712066qta.395.1660225779790;
        Thu, 11 Aug 2022 06:49:39 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id n16-20020a05622a041000b0033e51aea00esm1815409qtx.25.2022.08.11.06.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 06:49:38 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id o15so28268801yba.10;
        Thu, 11 Aug 2022 06:49:38 -0700 (PDT)
X-Received: by 2002:a25:da0b:0:b0:67a:7fb6:8ae with SMTP id
 n11-20020a25da0b000000b0067a7fb608aemr29654576ybf.89.1660225777780; Thu, 11
 Aug 2022 06:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220709032001.819487-1-davidgow@google.com> <20220709032001.819487-2-davidgow@google.com>
In-Reply-To: <20220709032001.819487-2-davidgow@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Aug 2022 15:49:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUdvGyMFyDSX3cSGDz9x3Q0+z1e0nQB5cB0GFazyPcK3A@mail.gmail.com>
Message-ID: <CAMuHMdUdvGyMFyDSX3cSGDz9x3Q0+z1e0nQB5cB0GFazyPcK3A@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] kunit: unify module and builtin suite definitions
To:     David Gow <davidgow@google.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        USB list <linux-usb@vger.kernel.org>,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David, Jeremy,

On Sat, Jul 9, 2022 at 5:21 AM David Gow <davidgow@google.com> wrote:
> From: Jeremy Kerr <jk@codeconstruct.com.au>
>
> Currently, KUnit runs built-in tests and tests loaded from modules
> differently. For built-in tests, the kunit_test_suite{,s}() macro adds a
> list of suites in the .kunit_test_suites linker section. However, for
> kernel modules, a module_init() function is used to run the test suites.
>
> This causes problems if tests are included in a module which already
> defines module_init/exit_module functions, as they'll conflict with the
> kunit-provided ones.
>
> This change removes the kunit-defined module inits, and instead parses
> the kunit tests from their own section in the module. After module init,
> we call __kunit_test_suites_init() on the contents of that section,
> which prepares and runs the suite.
>
> This essentially unifies the module- and non-module kunit init formats.
>
> Tested-by: Maíra Canal <maira.canal@usp.br>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Thanks for your patch, which is now commit 3d6e44623841c8b8 ("kunit:
unify module and builtin suite definitions") upstream.

Since this commit, modular kunit tests are no longer run at all.

Before:

    # insmod lib/kunit/kunit.ko
    # insmod lib/test_hash.ko
    test_hash: loading test module taints kernel.
        # Subtest: hash
        1..2
        ok 1 - test_string_or
        ok 2 - test_hash_or
    # hash: pass:2 fail:0 skip:0 total:2
    # Totals: pass:2 fail:0 skip:0 total:2
    ok 1 - hash

After:

    # insmod lib/kunit/kunit.ko
    # insmod lib/test_hash.ko
    test_hash: loading test module taints kernel.

The actual test code (and test init code, if it exists) is not run.

Reverting commits e5857d396f35e59e ("kunit: flatten kunit_suite***
to kunit_suite** in .kunit_test_suites") and 3d6e44623841c8b8 ("kunit:
unify module and builtin suite definitions") fixes the issue.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
