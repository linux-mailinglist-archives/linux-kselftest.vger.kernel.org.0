Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC153596E58
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiHQMTX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 08:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239393AbiHQMTS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 08:19:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A57B2640;
        Wed, 17 Aug 2022 05:19:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u14so1461404wrq.9;
        Wed, 17 Aug 2022 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PvQ1VTkR2TBqqjzA69gfrLsfT8nfazvXfsefYA9g+lo=;
        b=e9akmKRpa6Fp06HHF72K5rqZcPAVV/QyCi2T6/klrrcHO9vbhKVl4f4DVektjn+DX3
         EAgoLG+Iq4oBXugdtjHXjsU4WuQ9ZHgJOBS6ci+etwNviZgUiBdltXC4qVmsuokjAasa
         hAvmF/oYjJ5/mzK6JUx/bBy5wXY4JS7qPOcN+PqZY36e+AWfE5qnkiU3R9o1WqhvWSMw
         i09E3MLgPFMsv8FqnNHPut5SOXpDG9LQSZlG4Ff+39/oL6Vwr/Z6erfAbhzxhIpCHqFj
         UvRPgQoiP4fXXM5DDd0aLp+f5+GnJ0VWeuSz95yiq7PpiIsYohvIW7QwyhBWy8dl0Zlq
         uQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PvQ1VTkR2TBqqjzA69gfrLsfT8nfazvXfsefYA9g+lo=;
        b=P6nWgBzD5DTxSE1Z7tU1wRWVAI5HfcXp6L9T92+6fSXnFI3Ygr8WuNy1PdlNCQp+Q2
         Nj8/CVevlc43l1mgpW75xlhhYbjdlYjRjS+LVCiU/DI0UL4ckaCJUwuX+SScQgTcplpv
         FpSlLihaXaKuFX0DhnRDco5aCcYY7DbCbMdzHmrggLA9hcC5t2Nch0efdn9f0rYG/3Vl
         2PXxWGwrtuE7JR87v/3pW4JrnPdDIsZL/TVhxVTr8po7gts/XrTFXeNQE9qtr240y/JX
         eR4jd9Zw+g9uaEM78bvKExAXa5qwiayHiVBpTGwGluCjusAcS33TVzGXIlKOoccwbrnb
         P7mw==
X-Gm-Message-State: ACgBeo1eBt7GFP4xbvmW0O2LwG0uo9+HpC4iHFyuiP1cFdYez1pd2EuZ
        ki2zp2IMKnWuu8Z73QDRW/CkU+0wdRu8HSaTToDqQaerJOc=
X-Google-Smtp-Source: AA6agR5jfO4+nCkMdTVyrGOUCAgwggu4V5bU/qF2pElWz5ImI7rYnV3KZ3PK+0/Gi3XULaiYdGBm7lxoAqTtg9lXeWc=
X-Received: by 2002:a5d:404c:0:b0:225:1a39:d69f with SMTP id
 w12-20020a5d404c000000b002251a39d69fmr4042257wrp.576.1660738756137; Wed, 17
 Aug 2022 05:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAGi-RUKv-8zyku-3pjXdjxbyMP_X_YV5rd6y2wyaCOJJ9UOQAw@mail.gmail.com>
 <CABVgOSnxa=H5A-0U0QRCAv+OWCGb0zN_f7gP5FmhGjRy7NCUSw@mail.gmail.com>
In-Reply-To: <CABVgOSnxa=H5A-0U0QRCAv+OWCGb0zN_f7gP5FmhGjRy7NCUSw@mail.gmail.com>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Wed, 17 Aug 2022 15:19:03 +0300
Message-ID: <CAGi-RUL46gA_0ah_TTJVpc9RRS8nvd7yoqt=OLXxvUjL6TAvyQ@mail.gmail.com>
Subject: Re: Running kunit tests on platform devices
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 17, 2022 at 7:43 AM David Gow <davidgow@google.com> wrote:
>
> On Mon, Aug 15, 2022 at 5:16 PM Ramon Fried <rfried.dev@gmail.com> wrote:
> >
> > Hi.
> > I implemented a test suite that checks a platform driver, that's the
> > only way I can test interrupts behavior in the code.
> > Because it's a platform, I can't use kunit_test_suite(), so I call
> > __kunit_test_suites_init() as part of the platform driver probe
> > function.
> >
> > This works fine but has the following problems.
> > "TAP version 14" string is not printed and it's impossible to parse
> > the results using the script.
> > In addition, the suite is not displayed in /sys/kernel/debug/kunit.
> >
> > It would be my pleasure to provide a patch that fixes this, I just
> > wanted to make sure that my testing strategy makes sense.
> >
> > Thanks,
> > Ramon
> >
> Hi Ramon,
>
> Thanks for reaching out. Calling __kunit_test_suites_init() directly
> is not something we'd recommend (and are trying desperately to remove
> existing uses), so several of the issues re: the "TAP version 14"
> string et al are side effects of calling what is supposed to be an
> internal KUnit function manually.
>
> That being said, we definitely do want to make testing platform
> drivers as convenient as possible. I'm not sure why kunit_test_suite()
> doesn't work for you for platform drivers: are you just missing some
> way of instantiating the device from within a test context?
>
> I know Brendan has experimented with some hardware faking code, for
> which there's some example use here:
> https://kunit-review.googlesource.com/c/linux/+/5275
> (Note that you'll need to look at the other patches in the 'relation
> chain' for dependencies.)
>
> Equally, I've experimented a bit with testing old soundcard drivers
> (via a platform device) here, which may be an easier way to look
> through:
> https://github.com/sulix/linux/commit/4e1620c86553b9edde7f032318cf417dc13e4d26
>
> Note that neither of those examples are anything other than
> experiments, so may not work as-is, or be ideal.
>
> Otherwise, we're always happy to accept patches, though again, if
> there's any way of getting your tests working without a direct call to
> __kunit_test_suites_init() --- even if that would require patches to
> work --- that'd be preferable on our end.
>
> Cheers,
> -- David
Hi David,
Thanks for replying.
I looked at the examples you shared, and they all fake the actual device.
My intention is to actually interact with the real device. - get a
real interrupt, etc.
Is it wrong, was the intention that the platform device be mocked ?
Thanks,
Ramon.
