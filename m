Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E808620394
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 00:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiKGXQe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 18:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiKGXQd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 18:16:33 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D4526481
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 15:16:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u24so19930239edd.13
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Nov 2022 15:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yN2gWEajrNnQ2EFJgS3yWeDfhWLjKUKWV+TZ6nM6EA8=;
        b=bHgMYjRH6hCLWz287S9NVQPRhvhpY3ux7LZMdqA4TIcS2A+jWrB2dsBm23wXe4I2xN
         c/+w7EetsYsGHTrfI/1M9UAipR+bDmxiq7/4cLd/5HxNW92Uo+7m0bFHi+HoqJyaK5Sz
         rpUcTWXwXx2f8iJycWc7AkpX2vQq6IgvU8Mtu3l/hbzDsHSHj10PU7kBU673AlzpUgjU
         PVE5yMgsR2xzYXO2CdFfG++7gs+s9FKa4hA3Aw41zeeCMMEI91n4/0GkxeJPLHbjLAwy
         vkDRfZXQJSjTjDvussoO3Jvke3i081wonpFW7lrZK0sueY+vQfDiGPBuWX5Oavy9KKQ/
         1p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yN2gWEajrNnQ2EFJgS3yWeDfhWLjKUKWV+TZ6nM6EA8=;
        b=gEXXOUkY9UTWPCY5OytHKrizqQQeEVXkT7HQ7bPxv7pQhb0usJKM1kfCiCX27tB6Pa
         duF/ab06ZSW6URjJQlot6YpbehnrdEuCxUkwe4pBRhWejZpuQPouz644B2LMUyBxnvYF
         3dkk9Iz5iG3cQ6fHQUWn3BVeM9VeoAkhm0LeTMgeEjb07bNnZWXS+PIXec56bm4YCKRa
         uM/a7O+QjPtUUnJrJV2Z13IHZeLzyd86a8RtxISuDixdz0Eq2Y21b1ayPoOjzHcIs1v7
         +SGfRbsAHyVNQjl9WtrB+Z9jEZay//5fw0kIdhiSgxxJ1q9/o5vU0GOObyzHyAzqEfcl
         fmlQ==
X-Gm-Message-State: ACrzQf3VditkymbWpnXeQHVAKfj+M2+uCT28+k2w8ZsMrCmkJ77NEyZA
        3zmdiY6UPRZElpwohhX4Zfiv0qeeM0Wkptq5rfi0vUvKKICiug==
X-Google-Smtp-Source: AMsMyM7frnNCL/KlyxYyOUfz7D1jjOuRz2NPO/qa6jdHtNYq3Pwg2XBMgD2wBRWE4P+CgZ7ONDrdsny8m8T5RLSG1/I=
X-Received: by 2002:a05:6402:5248:b0:461:f0fa:864e with SMTP id
 t8-20020a056402524800b00461f0fa864emr51265354edd.81.1667862989200; Mon, 07
 Nov 2022 15:16:29 -0800 (PST)
MIME-Version: 1.0
References: <20221103162302.4ba62d72@maurocar-mobl2> <20221107183809.z5ntt6fj5ohs4bnn@nostramo>
In-Reply-To: <20221107183809.z5ntt6fj5ohs4bnn@nostramo>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 7 Nov 2022 15:16:17 -0800
Message-ID: <CAGS_qxrcyLCTMZTPXseH3nXZHLM24+pmcG9n5maKQwiorFqawQ@mail.gmail.com>
Subject: Re: KUnit issues - Was: [igt-dev] [PATCH RFC v2 8/8] drm/i915: check
 if current->mm is not NULL
To:     =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
Cc:     Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 7, 2022 at 10:38 AM Micha=C5=82 Winiarski
<michal.winiarski@intel.com> wrote:
>
> On Thu, Nov 03, 2022 at 04:23:02PM +0100, Mauro Carvalho Chehab wrote:
> > Hi,
> >
> > I'm facing a couple of issues when testing KUnit with the i915 driver.
> >
> > The DRM subsystem and the i915 driver has, for a long time, his own
> > way to do unit tests, which seems to be added before KUnit.
> >
> > I'm now checking if it is worth start using KUnit at i915. So, I wrote
> > a RFC with some patches adding support for the tests we have to be
> > reported using Kernel TAP and KUnit.
> >
> > There are basically 3 groups of tests there:
> >
> > - mock tests - check i915 hardware-independent logic;
> > - live tests - run some hardware-specific tests;
> > - perf tests - check perf support - also hardware-dependent.
> >
> > As they depend on i915 driver, they run only on x86, with PCI
> > stack enabled, but the mock tests run nicely via qemu.
> >
> > The live and perf tests require a real hardware. As we run them
> > together with our CI, which, among other things, test module
> > unload/reload and test loading i915 driver with different
> > modprobe parameters, the KUnit tests should be able to run as
> > a module.
>
> Note that KUnit tests that are doing more of a functional/integration
> testing (on "live" hardware) rather than unit testing (where hardware
> interactions are mocked) are not very common.
> Do we have other KUnit tests like this merged?

I don't think we have other tests like this.

> Some of the "live tests" are not even that, being more of a pure
> hardware tests (e.g. live_workarounds, which is checking whether values
> in MMIO regs stick over various HW state transitions).
>
> I'm wondering, is KUnit the right tool for this job?

The main focus of KUnit is for hw-independent tests.
So in theory: no.

But I can imagine it could be easier to write the validation via
KUNIT_EXPECT_EQ and friends as opposed to writing your own kernel
module w/ its own set of macros, etc.

So my first thought is: "if it works, then you can try using it."
(Might want to take steps like make sure they don't get enabled by
CONFIG_KUNIT_ALL_TESTS=3Dy).

Talking with David, he seems to have echoed my thoughts.
David also suggested that maybe the test could use a fake of the hw by
default, but have an option to run against real hw when available.
I think that sounds like a good chunk of work, so I don't know if you
need to worry about that.

Daniel
