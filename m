Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E88590583
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Aug 2022 19:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbiHKROo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Aug 2022 13:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiHKROa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Aug 2022 13:14:30 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812019E2FD
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Aug 2022 09:56:10 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id c22so9228704vko.7
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Aug 2022 09:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=G0jqPx9rziCQX4VfMuTReGksQVA2TXCq4FcbporBUUE=;
        b=bY6Z46A2sYDi7bnO93xe0wKNlM2kWwf1rZ8WXR+o0b9U0kcPZQvX/b6U7wJuCkJ0ra
         OtVWeOHzn2C13uh/TAQVBKdSyMwxAlLY5vMkRXrVW0tXv57ai1ksQg9RI5TbRzp4x43d
         Fj94pCnbuUVMLnlRNzV+CFBDUDJq1DUFhFZ+dmA7JCHH1VtL9Pb1qqG4go1GIUX/eEI5
         YJD83lNAz8S4xiiVJOTKCFPgDPPb+huEJLkUpLeFiYvFq7I9xUEE9WIbxNS6s1A3s6E8
         jKZc55buqasK/K1J0cmf7ct7U3d3VMbV/D0iKvTzJkuJegb7KftZAFJI4Io+ZEU5R0qc
         3qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=G0jqPx9rziCQX4VfMuTReGksQVA2TXCq4FcbporBUUE=;
        b=NtPG8oXZUr0dwFVuw/pHagVHrqst2wLK9Cs8fv7UpTCFnNWctaDQIqwbIE0bq/nexG
         yoi3yvtaeisMCVjpUVy+l9LjOeLQ5qj7DZfQLH7Fy9o7G4T1S9VzCUqLnZKbf2GrmQer
         u28HoREmhiUt+fIX9ys4QNfg27c6bHoc41wRch7sIMR/9+slcFaa/g+mQBQ2Zs3Gaw36
         qGJ73G6Pxe7G9LrkSMt4QAqPDkn2cxUfr3GxNZNkqIqrpCia0Mb8Rgm1oVnyos2Ttzoj
         N/S2UoBgnneVzFKh+WagiZ/iYJW9RLcGVGej1j7R3F7iojS25xAiEGTL+RSN1TgeeKai
         m7xw==
X-Gm-Message-State: ACgBeo2rycn3nH6juiBFtGbV3o4PJlL0fua4IgHB2bdHptrsmabQkNsq
        tBfxa5UEnY4En+5R2/QouHoZdhaoD5cWQHYszBHE2Q==
X-Google-Smtp-Source: AA6agR7OdJBDdsv27oJWMCBkG7w1cww7Zf3DnUJ98jysy8HZ/Q85KSrXHjt06FJo0I8HQr0pnWwdZYA6hlRaWORya6g=
X-Received: by 2002:a1f:dac3:0:b0:377:8cb:4544 with SMTP id
 r186-20020a1fdac3000000b0037708cb4544mr12084vkg.7.1660236969573; Thu, 11 Aug
 2022 09:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220709032001.819487-1-davidgow@google.com> <20220709032001.819487-2-davidgow@google.com>
 <CAMuHMdUdvGyMFyDSX3cSGDz9x3Q0+z1e0nQB5cB0GFazyPcK3A@mail.gmail.com>
In-Reply-To: <CAMuHMdUdvGyMFyDSX3cSGDz9x3Q0+z1e0nQB5cB0GFazyPcK3A@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 12 Aug 2022 00:55:58 +0800
Message-ID: <CABVgOSk_Y-eEoqH1xbbXfK5TN3P188JFeuZn3ZgV59Bs3Ds4Hg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] kunit: unify module and builtin suite definitions
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jeremy Kerr <jk@codeconstruct.com.au>,
        Brendan Higgins <brendanhiggins@google.com>,
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
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        USB list <linux-usb@vger.kernel.org>,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Aug 11, 2022 at 9:49 PM Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
>
> Hi David, Jeremy,
>
> On Sat, Jul 9, 2022 at 5:21 AM David Gow <davidgow@google.com> wrote:
> > From: Jeremy Kerr <jk@codeconstruct.com.au>
> >
> > Currently, KUnit runs built-in tests and tests loaded from modules
> > differently. For built-in tests, the kunit_test_suite{,s}() macro adds =
a
> > list of suites in the .kunit_test_suites linker section. However, for
> > kernel modules, a module_init() function is used to run the test suites=
.
> >
> > This causes problems if tests are included in a module which already
> > defines module_init/exit_module functions, as they'll conflict with the
> > kunit-provided ones.
> >
> > This change removes the kunit-defined module inits, and instead parses
> > the kunit tests from their own section in the module. After module init=
,
> > we call __kunit_test_suites_init() on the contents of that section,
> > which prepares and runs the suite.
> >
> > This essentially unifies the module- and non-module kunit init formats.
> >
> > Tested-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Thanks for your patch, which is now commit 3d6e44623841c8b8 ("kunit:
> unify module and builtin suite definitions") upstream.
>
> Since this commit, modular kunit tests are no longer run at all.
>
> Before:
>
>     # insmod lib/kunit/kunit.ko
>     # insmod lib/test_hash.ko
>     test_hash: loading test module taints kernel.
>         # Subtest: hash
>         1..2
>         ok 1 - test_string_or
>         ok 2 - test_hash_or
>     # hash: pass:2 fail:0 skip:0 total:2
>     # Totals: pass:2 fail:0 skip:0 total:2
>     ok 1 - hash
>
> After:
>
>     # insmod lib/kunit/kunit.ko
>     # insmod lib/test_hash.ko
>     test_hash: loading test module taints kernel.
>
> The actual test code (and test init code, if it exists) is not run.
>
> Reverting commits e5857d396f35e59e ("kunit: flatten kunit_suite***
> to kunit_suite** in .kunit_test_suites") and 3d6e44623841c8b8 ("kunit:
> unify module and builtin suite definitions") fixes the issue.

Thanks Geert,

This is a known issue. There's a patch to fix it here, which just
missed the pull request:
https://patchwork.kernel.org/project/linux-kselftest/patch/20220713005221.1=
926290-1-davidgow@google.com/

We'll try to get it merged as soon as possible.

Cheers,
-- David
