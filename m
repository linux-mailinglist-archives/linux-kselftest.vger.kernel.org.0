Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F94059F069
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 02:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiHXAqN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 20:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiHXAqM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 20:46:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A40219F
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 17:46:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d8so9522449lfq.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 17:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hardline-pl.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=+7YC01QZWr2H+Z11+QtNy0peh5GHhPgH8/H+v7UwPXM=;
        b=jYus24zPijQN5JdrsH5VT1VZPIGdLNSvI5RgeZRHZYlKU/Bb2LSdSpWy4+S9il+dus
         qCVLvQuBWMzx7ZLbQYbhCgxCfnUanvLgIRc8rgkIADx+sqcmUfn90EP5ZTNzT07z2YOH
         vofXJYPpoxv3QLCdn6x4bmcs42nnXWi0H01cUyAEhLOYsw4jw+UPlcyCQy3FGptJ63Ap
         30PbsLQ1e+kA/By/DcH3+fjcrJh/nOV8E8o2I31zlSIs9QWwbKLGJhlDLbPf3fB0wgS0
         EvVQ7gTXn7JlcfrZ9eX0XSmSbfYLPROtTVPSChYJUp0WuNSVfrpUw+5E9a0w6cLBCW9a
         8NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=+7YC01QZWr2H+Z11+QtNy0peh5GHhPgH8/H+v7UwPXM=;
        b=ssF7Lx9QFxqMz4zz0hgWQ073NXvOe9azYaO6XlpHikhEabqeXabhl6EIKF8rs35oxx
         H31taGE4sEtW/vGQzIQr2/gBxtBbQylcznbO6oIvRVcidfqvPfjEWZa4wPEvw2AwHSgM
         Oq26detjHcOfHWZ1POLoDs/EFMbk4Wb5ziXhGJespnNaoYDhJxAkkGurTVm7EVVwDsx2
         0z6J477AEV/RE839Nu9kKCTq8vZ8yOzj5XuUS9HskCPxD3izvd5yBzujoCal176OliNX
         V2ZwOKi4HIDut/tZHqBtUDknMOTd7DgNPm6p7JVgt6xzi8y/cG6Xy2E73VoA8ewSx/RI
         YOLA==
X-Gm-Message-State: ACgBeo2q0jROIEXlMtBLQp7jS5J2StFxuwyN7sAgzGM2TQ7tkXkt1tRj
        Hb35L+zv6SR1WpanCDHRj+0NhQ==
X-Google-Smtp-Source: AA6agR7sRImMNaAM0Jb12p84NAKhEUSyFvm3ewFa1xEzGiE/jRI1uZfhA1nP8y5VGI92jbu3qrZy4w==
X-Received: by 2002:a05:6512:1155:b0:48a:fb9a:32d8 with SMTP id m21-20020a056512115500b0048afb9a32d8mr9530380lfg.672.1661301967470;
        Tue, 23 Aug 2022 17:46:07 -0700 (PDT)
Received: from localhost (89-64-119-148.dynamic.chello.pl. [89.64.119.148])
        by smtp.gmail.com with ESMTPSA id g21-20020a2eb5d5000000b00261c19bbb6asm2007841ljn.97.2022.08.23.17.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 17:46:06 -0700 (PDT)
Date:   Wed, 24 Aug 2022 02:46:06 +0200
From:   =?utf-8?Q?Micha=C5=82?= Winiarski <michal@hardline.pl>
To:     Isabella Basso <isabbasso@riseup.net>
Cc:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>,
        Matthew Auld <matthew.william.auld@gmail.com>,
        Arthur Grillo <arthur.grillo@usp.br>,
        Rodrigo Siqueira <siqueirajordao@riseup.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Latypov <dlatypov@google.com>,
        brendanhiggins@google.com,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kselftest@vger.kernel.org, n@nfraprado.net,
        andrealmeid@riseup.net, magalilemes00@gmail.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        kunit-dev@googlegroups.com, mwen@igalia.com,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
        tales.aparecida@gmail.com,
        kernel list <linux-kernel@vger.kernel.org>,
        leandro.ribeiro@collabora.com,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Subject: Re: [PATCH v5 9/9] drm: selftest: convert drm_mm selftest to KUnit
Message-ID: <20220824004606.ufca7rrd4s4xrkms@macragge.hardline.pl>
References: <20220708203052.236290-1-maira.canal@usp.br>
 <20220708203052.236290-10-maira.canal@usp.br>
 <CAM0jSHNG8Ozs+NpvwMK6zvbRm3Ve=Wa1_H7jS0uQ8FeAWgvyoA@mail.gmail.com>
 <b1ae4f77-4e24-24c9-fd87-abcd612a3533@usp.br>
 <20220722162529.wy4ox7pyjhno66lz@macragge.hardline.pl>
 <52481C88-9CD7-4E4F-ABCB-1EFC01E4B4D0@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52481C88-9CD7-4E4F-ABCB-1EFC01E4B4D0@riseup.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 21, 2022 at 07:22:30PM -0300, Isabella Basso wrote:
> Hi Michał,
> 
> While I totally understand your point, we have talked about this in our GSoC
> meetings with mentors, and have found a few reasons as to why a KUnit runner
> integrated to IGT might be really useful. 
> 
> > Am 22/07/2022 um 1:25 PM schrieb Michał Winiarski <michal@hardline.pl>:
> > 
> > On Fri, Jul 22, 2022 at 08:04:51AM -0300, Maíra Canal wrote:
> >> On 7/22/22 07:35, Matthew Auld wrote:
> >>> On Fri, 8 Jul 2022 at 21:32, Maíra Canal <maira.canal@usp.br> wrote:
> >>>> 
> >>>> From: Arthur Grillo <arthur.grillo@usp.br>
> >>>> 
> >>>> Considering the current adoption of the KUnit framework, convert the
> >>>> DRM mm selftest to the KUnit API.
> >>> 
> >>> Is there a plan to convert the corresponding selftest IGT that was
> >>> responsible for running this (also drm_buddy) to somehow work with
> >>> kunit? Previously these IGTs were always triggered as part of
> >>> intel-gfx CI, but it looks like they are no longer run[1].
> >>> 
> >>> [1] https://gitlab.freedesktop.org/drm/intel/-/issues/6433
> >> 
> >> Hi Matthew,
> >> 
> >> Isabella sent a while ago a patch to IGT adding KUnit compatibility to
> >> IGT [1], but there wasn't any feedback on the patch. I believe that soon
> >> she will resend the series in order to make all KUnit DRM tests run on IGT.
> >> 
> >> Any feedback on the patch is welcomed so that we can fix this issue as
> >> soon as possible.
> >> 
> >> [1] https://patchwork.freedesktop.org/patch/489985/
> >> 
> >> Best Regards,
> >> - Maíra Canal
> > 
> > Hi.
> > 
> > Instead of going back to using IGT for *unit* tests, it would be a better idea
> > to adjust the CI to just run the tests once at "build" time (just like e.g.
> > checkpatch).
> 
> First, I’d like to point out that there would be some inherent overhead in
> doing so, which might actually not be worth it, as KUnit tool would need to
> compile HEAD in the UML arch, then we’d have to re-compile everything to a real
> machine’s architecture, like x86_64 (in the least), having in mind still that
> arch-dependent issues would not show up when we run tests in UML, so there’s
> still a downside to it even if it’s quick enough.
> 
> Even if we don’t run them as UML and instead use a VM, there’s a VM being run
> just for a couple of tests, which might be slower than adding a step to a
> dedicated machine that’s (probably) already available, plus the setup and
> hardware needed to run a VM inside of a CI runner are overheads in themselves,
> needing dedicated, modern machines.

No - we don't need a dedicated machine for running kunit - the machine that we
just used to compile the code is perfectly fine.
Builders used in CI systems usually have beefy server-grade CPUs - pretty good
candidates for running unit tests (even with virtualization overhead).
Plus - if the unit tests fail, we can consider skipping the deployment and
not run any regular tests (just like the case where build has failed).
Meanwhile, one of the "dedicated machines" (ones that are used to run the tests)
can actually be a low-power device (think tablet). And if the test ends up
crashing the kernel, it needs to be rebooted. VMs are much easier to work with,
especially with kunit.py abstracting away all of the qemu interactions.

> 
> > We would then stop executing the same test multiple times on different machines
> > (note that both DRM selftests and i915 "mock" selftests are pure unit tests - in
> > other words, they don't need the hardware to be present), which would save some
> > (small) amount of machine-time that can be utilized to do something that
> > actually needs the hardware.
> 
> I totally agree with your solution in regards to arch-independent tests, though.

There are no arch-specific kunit tests in DRM-core. There shouldn't be any
arch-specific code in DRM-core. Same thing for drivers (at least for the purpose
of COMPILE_TEST and by extension, running kunit).
All of DRM kunit tests should pass on all architectures supported by kunit.

> 
> > Plus there's no need to maintain the kunit-runner in IGT.
> > Note - we're currently going to lose "DMESG-WARN" detection if we go this route,
> > but this is something that can be improved on the kunit-side.
> > 
> > -Michał
> 
> There’s also a point to be made on maintaining such a runner if we think about
> companies like AMD, as they rely heavily on IGT, so they have lots of tests
> written in there, and it'd be difficult for them to accommodate one more
> non-trivial thing to their CI. Plus I think this might be a good starting point
> for them to transition their CI to a KUnit-centered approach without stressing
> engineers unnecessarily.

I agree with the IGT-compatibility angle, however, that would only apply to test
content that gets converted from selftests to kunit (just like DRM selftests),
not newly introduced test content (as is the case with amdgpu).
I also wouldn't call interpreting exit code of "kunit.py run (...)" something
that's difficult to be added to various CI pipelines.
Also - do we really want to transition to KUnit-centered approach?
Regular IGTs are actually about exercising the HW through driver uAPI from
userspace, not about isolated unit testing (which is what KUnit is about).
Then we have selftests, which are implemented on the kernel side, and are about
internal implementation. Selftests may or may not require HW to operate (if HW
is needed, we're usually doing more of a functional/integration testing, if not
- it's most likely going to be a pure unit test).
I view regular IGTs and KUnit (and kselftests that are not isolated, and need
the HW to be present) as complementary mechanisms, not something to be replaced
(in other words - we only want to transition unit tests to KUnit).

When it comes to transition, I'm just worried that once the IGT KTAP parser is
adopted, the transition to kunit.py @ build time will never happen, and we'll
end up maintaining custom DRM-specific solution instead of participating in
wider kernel community.

-Michał

> 
> Cheers,
> —
> Isabella
> 
