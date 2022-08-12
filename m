Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A630590D2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Aug 2022 10:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbiHLIIi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Aug 2022 04:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbiHLIIi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Aug 2022 04:08:38 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72628A830E;
        Fri, 12 Aug 2022 01:08:35 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id a4so245070qto.10;
        Fri, 12 Aug 2022 01:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Nfjn6VbuIp0pl/q9REwTChp9DU/5iKx5Kue3uNgaktM=;
        b=snNemg6WMAImdLec7ag85jaV6YzQLk8qA4XTd4EHrdn0Qz4k4Xr9zc0zMZw6MguRxh
         /52eHF/LaE28UQz0wWxwifILLyOsRPKvAwr8i8weAcx59OV6Iyx+EScg/BAidw908nfo
         QlxhOEJAhbaZIWZkfkS1iyXCqUvwhQbXD3XT6dZSgWHI3rcF2B3aE6iJIBkTb9YJLV2+
         I3kkjgboqxFeuBw0ueQj1PgB/RhwZUGzrUaeytWKgVpcOZAmHNP9+Ep6LybnLEuWeB9B
         uB0lDACW3ulA2eZdVxbuiudplBTNJ/F79Jd0gbXpXxaEg18Et1RccoRWSXkQzSRQyj3n
         kvQA==
X-Gm-Message-State: ACgBeo0Jj0L4kb3eF8TOCJcqBv55CnnLXxt794SW+gaDEqN7gdaJ982X
        kq2MXEFZRU77QHa1BlqmoKrrMRr66moqjQ==
X-Google-Smtp-Source: AA6agR4SmLNGtNIRczd/JhI/E5330Ls2b+5yO9UbmSuJdbY3YClwLYTDsKuNoeQVha0Mm4+rcyovAw==
X-Received: by 2002:ac8:7f0e:0:b0:31f:402f:1b89 with SMTP id f14-20020ac87f0e000000b0031f402f1b89mr2559367qtk.590.1660291714430;
        Fri, 12 Aug 2022 01:08:34 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id j2-20020a05620a410200b006b958c34bf1sm1333560qko.10.2022.08.12.01.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 01:08:33 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 123so363806ybv.7;
        Fri, 12 Aug 2022 01:08:32 -0700 (PDT)
X-Received: by 2002:a25:da0b:0:b0:67a:7fb6:8ae with SMTP id
 n11-20020a25da0b000000b0067a7fb608aemr2557291ybf.89.1660291712387; Fri, 12
 Aug 2022 01:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220709032001.819487-1-davidgow@google.com> <20220709032001.819487-2-davidgow@google.com>
 <CAMuHMdUdvGyMFyDSX3cSGDz9x3Q0+z1e0nQB5cB0GFazyPcK3A@mail.gmail.com> <CABVgOSk_Y-eEoqH1xbbXfK5TN3P188JFeuZn3ZgV59Bs3Ds4Hg@mail.gmail.com>
In-Reply-To: <CABVgOSk_Y-eEoqH1xbbXfK5TN3P188JFeuZn3ZgV59Bs3Ds4Hg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Aug 2022 10:08:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-v7Ovcx8+3XALK_cS8OxODVP5nDVT8n44q_9C=C+C2Q@mail.gmail.com>
Message-ID: <CAMuHMdW-v7Ovcx8+3XALK_cS8OxODVP5nDVT8n44q_9C=C+C2Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] kunit: unify module and builtin suite definitions
To:     David Gow <davidgow@google.com>
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On Thu, Aug 11, 2022 at 6:56 PM David Gow <davidgow@google.com> wrote:
> On Thu, Aug 11, 2022 at 9:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sat, Jul 9, 2022 at 5:21 AM David Gow <davidgow@google.com> wrote:
> > > From: Jeremy Kerr <jk@codeconstruct.com.au>
> > >
> > > Currently, KUnit runs built-in tests and tests loaded from modules
> > > differently. For built-in tests, the kunit_test_suite{,s}() macro adds a
> > > list of suites in the .kunit_test_suites linker section. However, for
> > > kernel modules, a module_init() function is used to run the test suites.
> > >
> > > This causes problems if tests are included in a module which already
> > > defines module_init/exit_module functions, as they'll conflict with the
> > > kunit-provided ones.
> > >
> > > This change removes the kunit-defined module inits, and instead parses
> > > the kunit tests from their own section in the module. After module init,
> > > we call __kunit_test_suites_init() on the contents of that section,
> > > which prepares and runs the suite.
> > >
> > > This essentially unifies the module- and non-module kunit init formats.
> > >
> > > Tested-by: Maíra Canal <maira.canal@usp.br>
> > > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > > Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > Signed-off-by: David Gow <davidgow@google.com>
> >
> > Thanks for your patch, which is now commit 3d6e44623841c8b8 ("kunit:
> > unify module and builtin suite definitions") upstream.
> >
> > Since this commit, modular kunit tests are no longer run at all.
> >
> > Before:
> >
> >     # insmod lib/kunit/kunit.ko
> >     # insmod lib/test_hash.ko
> >     test_hash: loading test module taints kernel.
> >         # Subtest: hash
> >         1..2
> >         ok 1 - test_string_or
> >         ok 2 - test_hash_or
> >     # hash: pass:2 fail:0 skip:0 total:2
> >     # Totals: pass:2 fail:0 skip:0 total:2
> >     ok 1 - hash
> >
> > After:
> >
> >     # insmod lib/kunit/kunit.ko
> >     # insmod lib/test_hash.ko
> >     test_hash: loading test module taints kernel.
> >
> > The actual test code (and test init code, if it exists) is not run.
> >
> > Reverting commits e5857d396f35e59e ("kunit: flatten kunit_suite***
> > to kunit_suite** in .kunit_test_suites") and 3d6e44623841c8b8 ("kunit:
> > unify module and builtin suite definitions") fixes the issue.
>
> Thanks Geert,
>
> This is a known issue. There's a patch to fix it here, which just
> missed the pull request:
> https://patchwork.kernel.org/project/linux-kselftest/patch/20220713005221.1926290-1-davidgow@google.com/
>
> We'll try to get it merged as soon as possible.

Thanks for the pointer. I can confirm it fixes the issue, so I provided
my Tb tag.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
