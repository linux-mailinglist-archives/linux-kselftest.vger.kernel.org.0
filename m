Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC75352DAF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 May 2022 19:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242445AbiESRLe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 May 2022 13:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbiESRLU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 May 2022 13:11:20 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2179193EB
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 10:11:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c12so7752448eds.10
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 10:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ctr4gplq7tIvfpEzcReXp2Tbx4VBOJ0VA7nTlFJ97VA=;
        b=TUnSopuTxg2nJAUBxDLL9PhbokwuRBME0f+G4z3bOlAfsNI+Xhdm+gB1CqUu5jLpmF
         +xRkF1+WV7wiqnwZSD7fTkd9u8G4oazcWW/CPUc7c1GnL/E7blfLlI6Uywp6psBzf/JP
         2GtaIffxA1jbUDrVeOEBVTYaPsl5cTNaHvJeHpOb/AJ3rwvXqKA1BFkJrVYiPLTS7qVJ
         hg7/vU2sdRawx3xjYU0E9IEKy8bIXBIjVCZj58qzVSdz6d7a7cc+xDbcBmQjjsavPovC
         jsNR4CjFWhXaKqSFT4zGmNlO+umOS/8UWENUyBNAm9Xn3ZuZV3Ux/vC2BFQEesqt9kv3
         00Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ctr4gplq7tIvfpEzcReXp2Tbx4VBOJ0VA7nTlFJ97VA=;
        b=vHEHsdOLD2dEqLpg/cyszeD+jDFziSFKexQXvTi045oXQvNZyy9NUF9v7hgDCwoNRz
         4XVUmnBZ5CDeHaAcs5oDkB1ymp36rdoBsxHwILhbaheTe0cKlsQNl3etb9MsGAqMja+j
         dolhQu6XLqEUy0f9lEoBNLlxy56CpgiH8XRLDnkx5RqkfJMdcr8HkKaztX8aEhW+6vJx
         myW4BH2kx8j48hpoysUT57EEsV2Rsh0aDYe+INVy0YMJ26ENxIQoe6stNSwuZnUC8QZk
         NBemn0ihNTmuD/VCzGSR1SRqsDF2wABgOGj2YS3QMk28F5gnwkbwCumgzZQzuy65rr3Z
         nbZg==
X-Gm-Message-State: AOAM5317ZtYJ9WF+NjWj6/luv+mZTJDyRWACONRLbF8c0XvXawBvBteE
        pK78yAScyWFZUkUGWphMNBP4iTzh71ZvxTQD6hIA+w==
X-Google-Smtp-Source: ABdhPJzxeCfFVspMrH294SeXXh2amM4330ptlS97S6S9iL5xqvR4rTFUaueUXHN8XGTPkRFQUVQRAQ0TI0JZnvtiUtU=
X-Received: by 2002:a05:6402:84a:b0:426:262d:967e with SMTP id
 b10-20020a056402084a00b00426262d967emr6618652edz.286.1652980276934; Thu, 19
 May 2022 10:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <CAGS_qxrOUYC5iycS436Rb-gEoEnYDa2OJLkQhEVXcDN0BEJ4YA@mail.gmail.com>
 <CANpmjNPSm8eZX7nAJyMts-4XdYB2ChXK17HApUpoHN-SOo7fRA@mail.gmail.com> <CABVgOS=X51T_=hwTumnzL2yECgcshWBp1RT0F3GiT3+Fe_vang@mail.gmail.com>
In-Reply-To: <CABVgOS=X51T_=hwTumnzL2yECgcshWBp1RT0F3GiT3+Fe_vang@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 19 May 2022 10:11:06 -0700
Message-ID: <CAGS_qxqsF-soqSM7-cO+tRD1Rg5fqrA07TGLRruxPE4i_rLdJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: Add x86_64-smp architecture for SMP testing
To:     David Gow <davidgow@google.com>
Cc:     Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
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

On Thu, May 19, 2022 at 6:15 AM David Gow <davidgow@google.com> wrote:
>
> I tend to agree that having both would be nice: I think there are
> enough useful "machine configs" that trying to maintain, e.g, a 1:1
> mapping with kernel architectures is going to leave a bunch of things
> on the table, particularly as we add more tests for, e.g., drivers and
> specific CPU models.

I agree that we don't necessarily need to maintain a 1:1 mapping.
But I feel like we should have a pretty convincing reason for doing
so, e.g. support for a CPU that requires we add in a bunch of
kconfigs.

This particular one feels simple enough to me.
Given we already have to put specific instructions in the
kcsan/.kunitconfig, I don't know if there's much of a difference in
cost between these two commands

$ ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan
--arch=x86_64-smp
$ ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan
--arch=x86_64 --kconfig_add CONFIG_SMP=y --qemu_args "-smp 8"

I've generally learned to prefer more explicit commands like the
second, even if they're quite a bit longer.
But I have the following biases
* I use FZF heavily, so I don't re-type long commands much
* I'm the person who proposed --kconfig_add and --qemu_args, so of
course I'd think the longer form is easy to understand.
so I'm not in a position to object to this change.


Changing topics:
Users can overwrite the '-smp 8' here via --qemu_args [1], so I'm much
less worried about hard-coding any specific value in this file
anymore.
And given that, I think a more "natural" value for this file would be "-smp 2".
I think anything that needs more than that should explicitly should --qemu_args.

Thoughts?

[1] tested with --qemu_args='-smp 4' --qemu_args='-smp 8'
and I see the following in the test.log
 smpboot: Allowing 8 CPUs, 0 hotplug CPUs
so QEMU respects the last value passed in, as expected.

>
> The problem, of course, is that the --kconfig_add flags don't allow us
> to override anything explicitly stated in either the kunitconfig or
> qemu_config (and I imagine there could be problems with --qemu_config,
> too).

This patch would fix that.
https://lore.kernel.org/linux-kselftest/20220519164512.3180360-1-dlatypov@google.com

It introduces an overwriting priority of
* --kconfig_add
* kunitconfig / --kunitconfig
* qemu_config
