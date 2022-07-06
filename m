Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240575692C7
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 21:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiGFTnZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 15:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiGFTnZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 15:43:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7762E285
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 12:43:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g26so28845782ejb.5
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQRsnwv9u5IuL08Zu0b0BsRI6BGP8zbhAD30ZwGOKSY=;
        b=mc2otIGuBDLviocnQmzsnPStf1y6s1B8oLQEpaEnJtA0+MhjEcCuE30cMfGGAr7rSh
         3Dr+s6Pq80xvdUdJzHes1T7/9AA0thSKQDzO8jdRKCx/jKghZOSQ9ETfXVLnGPdTwil6
         YDPfTfKxnb2LaQl8RkQ3y+tiJAmuG0fB0CeL8X+/DYZUN3JT+7gdh67sPEmSki5WhIoF
         WdvK6x7P72Dk0c42qx+TzcKjLMUxLwGXY6RVlcH+FFIsckcUPUL3IIxSzX0jDxe5SCG9
         qDcgUqD5ezsCVoOgcbhaMd/uKZiYkiToHfbQe3QmzCyWk6hKAKVHVi4ivbx2H0hQ1hjd
         Y0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQRsnwv9u5IuL08Zu0b0BsRI6BGP8zbhAD30ZwGOKSY=;
        b=n3G7Une5PEcbW9p+9zka7WmjTOUpvaskSwifKjHGVvjI8GyczTvd78XpQ9kYbCffZz
         F4DLjDLdRm/5pY5lLEQFfNj/60uAtdRFhbFXDOdqCp+gttH1W+ORtnbpOQScjb95UENI
         ZZ5OoWSLhDmjW0iriERIo88bZWcty327YLx0o7drsgpKqBoFpI1PolmYEev4pbNfj8hC
         F0VgC0ZyivglCDtgr4N7wud0PsDe4lr7D1xhgGAz7KlgLgfs7gsrzjaWsE0G5KOm82CI
         7CEQIW8T6gan324HCopbR7yilbyeuzaGxiKGwGmGAhsMONHmJSEKZnWGO4/7tlEeNaNe
         zBOw==
X-Gm-Message-State: AJIora/sZglfY1jq/PgekCIkK648mt+biTTeKklUycop34Es1HHcoGTt
        01ojbI5Muzyhe/UkcBZ6XyUT/cf+KJeGzF7qxkxlHg==
X-Google-Smtp-Source: AGRyM1t4dRFvvQJAo3o+9zwoctngRDgoPiYrC8YooMHhSrERSiGT4kieKFmITMD8tdqHtO7K0lhat2uj3BHpxqC84aA=
X-Received: by 2002:a17:907:168c:b0:726:c521:25aa with SMTP id
 hc12-20020a170907168c00b00726c52125aamr40430672ejc.46.1657136600905; Wed, 06
 Jul 2022 12:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <CAGS_qxrOUYC5iycS436Rb-gEoEnYDa2OJLkQhEVXcDN0BEJ4YA@mail.gmail.com>
 <CANpmjNPSm8eZX7nAJyMts-4XdYB2ChXK17HApUpoHN-SOo7fRA@mail.gmail.com>
 <CABVgOS=X51T_=hwTumnzL2yECgcshWBp1RT0F3GiT3+Fe_vang@mail.gmail.com> <CAGS_qxqsF-soqSM7-cO+tRD1Rg5fqrA07TGLRruxPE4i_rLdJw@mail.gmail.com>
In-Reply-To: <CAGS_qxqsF-soqSM7-cO+tRD1Rg5fqrA07TGLRruxPE4i_rLdJw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 15:43:09 -0400
Message-ID: <CAFd5g44dp05DaEot23_a2QdOGfmg=eehtoe24=6yo_UKiGNukA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: Add x86_64-smp architecture for SMP testing
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, May 19, 2022 at 1:11 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, May 19, 2022 at 6:15 AM David Gow <davidgow@google.com> wrote:
> >
> > I tend to agree that having both would be nice: I think there are
> > enough useful "machine configs" that trying to maintain, e.g, a 1:1
> > mapping with kernel architectures is going to leave a bunch of things
> > on the table, particularly as we add more tests for, e.g., drivers and
> > specific CPU models.
>
> I agree that we don't necessarily need to maintain a 1:1 mapping.
> But I feel like we should have a pretty convincing reason for doing
> so, e.g. support for a CPU that requires we add in a bunch of
> kconfigs.

Agreed. That being said, if we have a good convention for archs that
are not in arch/, then it should be OK. The biggest thing is that all
archs passed into ARCH=, if supported, should have a default with the
same value for kunittool; as long as that is the case, I don't think
anyone will get confused.

> This particular one feels simple enough to me.
> Given we already have to put specific instructions in the
> kcsan/.kunitconfig, I don't know if there's much of a difference in
> cost between these two commands
>
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan
> --arch=x86_64-smp
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan
> --arch=x86_64 --kconfig_add CONFIG_SMP=y --qemu_args "-smp 8"

Also agree.

> I've generally learned to prefer more explicit commands like the
> second, even if they're quite a bit longer.

I agree, but I think I learned this from you :-)

> But I have the following biases
> * I use FZF heavily, so I don't re-type long commands much

Same.

> * I'm the person who proposed --kconfig_add and --qemu_args, so of
> course I'd think the longer form is easy to understand.
> so I'm not in a position to object to this change.

Yeah, I think I am a bit biased on this too, but I don't terribly care
one way or the other.

> Changing topics:
> Users can overwrite the '-smp 8' here via --qemu_args [1], so I'm much
> less worried about hard-coding any specific value in this file
> anymore.
> And given that, I think a more "natural" value for this file would be "-smp 2".
> I think anything that needs more than that should explicitly should --qemu_args.
>
> Thoughts?

If we have time, we could bring this topic up at LPC?

> [1] tested with --qemu_args='-smp 4' --qemu_args='-smp 8'
> and I see the following in the test.log
>  smpboot: Allowing 8 CPUs, 0 hotplug CPUs
> so QEMU respects the last value passed in, as expected.
>
> >
> > The problem, of course, is that the --kconfig_add flags don't allow us
> > to override anything explicitly stated in either the kunitconfig or
> > qemu_config (and I imagine there could be problems with --qemu_config,
> > too).
>
> This patch would fix that.
> https://lore.kernel.org/linux-kselftest/20220519164512.3180360-1-dlatypov@google.com
>
> It introduces an overwriting priority of
> * --kconfig_add
> * kunitconfig / --kunitconfig
> * qemu_config
