Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C592627B4A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 12:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiKNLAA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 06:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiKNK76 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 05:59:58 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BB31E3DB
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Nov 2022 02:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668423598; x=1699959598;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HjlrE4lDUsyjd9izNiNxUcfHs5xYsRlSUoFdBWgVPf8=;
  b=TZrpAANIsrUSVQ96rlvk4aJGMsmh5E6qU/mQz0mw7BeHrU1PaN0WGBG1
   A/JfIREXli9GTjGK8EvSkcWHnA7Rz8ViUvB0WLjbFC4hsjAyOhuPxkJzA
   pYeRW7sfBf4mQ0qJ5lXFO1baxlS+GqH83By86MLZrJpD8hRiWlNoykXsH
   rpYpbs3xupzD6aGZFK96+aLYuaoFCCkf78V1GyKZBrTEyCJxc08GCPqqU
   4eSGQnuPVPcfcQ5v98icljL58FVT0fi2yn0ZblKAN9q46Z5ayKLNn9AA1
   AWk3PSZ4zGZaC7QG/1yuTnyWmixfr3d1yfaV8RUHbxnmYNQXZuIjno3qE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="310649141"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="310649141"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 02:59:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="883493510"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="883493510"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 14 Nov 2022 02:59:57 -0800
Received: from maurocar-mobl2 (unknown [10.252.18.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BDFED580A5F;
        Mon, 14 Nov 2022 02:59:50 -0800 (PST)
Date:   Mon, 14 Nov 2022 11:59:47 +0100
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     =?UTF-8?B?TWljaGHFgg==?= Winiarski <michal.winiarski@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: KUnit issues - Was: [igt-dev] [PATCH RFC v2 8/8] drm/i915:
 check if current->mm is not NULL
Message-ID: <20221114115947.63c377fe@maurocar-mobl2>
In-Reply-To: <CAGS_qxrcyLCTMZTPXseH3nXZHLM24+pmcG9n5maKQwiorFqawQ@mail.gmail.com>
References: <20221103162302.4ba62d72@maurocar-mobl2>
        <20221107183809.z5ntt6fj5ohs4bnn@nostramo>
        <CAGS_qxrcyLCTMZTPXseH3nXZHLM24+pmcG9n5maKQwiorFqawQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 7 Nov 2022 15:16:17 -0800
Daniel Latypov <dlatypov@google.com> wrote:

> On Mon, Nov 7, 2022 at 10:38 AM Micha=C5=82 Winiarski
> <michal.winiarski@intel.com> wrote:
> >
> > On Thu, Nov 03, 2022 at 04:23:02PM +0100, Mauro Carvalho Chehab wrote: =
=20
> > > Hi,
> > >
> > > I'm facing a couple of issues when testing KUnit with the i915 driver.
> > >
> > > The DRM subsystem and the i915 driver has, for a long time, his own
> > > way to do unit tests, which seems to be added before KUnit.
> > >
> > > I'm now checking if it is worth start using KUnit at i915. So, I wrote
> > > a RFC with some patches adding support for the tests we have to be
> > > reported using Kernel TAP and KUnit.
> > >
> > > There are basically 3 groups of tests there:
> > >
> > > - mock tests - check i915 hardware-independent logic;
> > > - live tests - run some hardware-specific tests;
> > > - perf tests - check perf support - also hardware-dependent.
> > >
> > > As they depend on i915 driver, they run only on x86, with PCI
> > > stack enabled, but the mock tests run nicely via qemu.
> > >
> > > The live and perf tests require a real hardware. As we run them
> > > together with our CI, which, among other things, test module
> > > unload/reload and test loading i915 driver with different
> > > modprobe parameters, the KUnit tests should be able to run as
> > > a module. =20
> >
> > Note that KUnit tests that are doing more of a functional/integration
> > testing (on "live" hardware) rather than unit testing (where hardware
> > interactions are mocked) are not very common.
> > Do we have other KUnit tests like this merged? =20
>=20
> I don't think we have other tests like this.
>=20
> > Some of the "live tests" are not even that, being more of a pure
> > hardware tests (e.g. live_workarounds, which is checking whether values
> > in MMIO regs stick over various HW state transitions).
> >
> > I'm wondering, is KUnit the right tool for this job? =20
>=20
> The main focus of KUnit is for hw-independent tests.
> So in theory: no.
>=20
> But I can imagine it could be easier to write the validation via
> KUNIT_EXPECT_EQ and friends as opposed to writing your own kernel
> module w/ its own set of macros, etc.

Right now, i915 has its own way of doing that, for both hw-independent
and live tests. The current patches are keeping them, because it helps=20
comparing both approaches, and won't disrupt CI jobs.

However, if we're willing to merge KUnit support, the best would be
to use the same macros/logic for both, as having two different unit
test frameworks used on i915 doesn't make much sense.

So yeah, using KUNIT_EXPECT_EQ and friends for live unit and hw tests
makes sense to me.

The main difference between i915 selftest and KUnit seems to be at
the way the tests are started:

- i915 selftest uses module parameters to run the driver on test mode.
  When such parameters are enabled, the probe() function will run the
  tests.

- from what I understood, KUnit uses a .kunit_test_suites code
  section, which does an early initialization of the tests, calling
  the test suite a lot earlier than probe().=20

Due to such differences, running KUnit against a real hardware requires
to load the real driver first, letting it probe the hardware. Once the
driver is loaded and have the hardware properly initialized, load a=20
separate KUnit module that would call the test functions from the driver.
That's the approach took on this series.

It sounds possible to merge both approaches, by adding some helper
functions similar to what kunit_test_suites() do, but, instead of
using a separate segment, run the tests at probe() time.

That would mean a cleaner solution with the usage of all KUnit
macros and, in thesis, it will be equivalent to what i915 selftest
already does.

Another possibility would be to make sure that kunit_test_suites()
will fully initiate the user context, allowing mmap() to work.

> So my first thought is: "if it works, then you can try using it."
> (Might want to take steps like make sure they don't get enabled by
> CONFIG_KUNIT_ALL_TESTS=3Dy).

Yeah, it makes sense to have hw-dependent tests not enabled with
KUNIT_ALL_TESTS. Another approach would be to just skip them when
hw is required[1]. Skipping the tests is needed anyway, as the
hardware probing may fail.

[1] Btw, despite the comments:

	/**
	 * kunit_skip() - Marks @test_or_suite as skipped
	 *
	 * @test_or_suite: The test context object.
	 * @fmt:  A printk() style format string.
	 *
	 * Skips the test. @fmt is given output as the test status
	 * comment, typically the reason the test was skipped.
	 *
	 * Test execution is halted after kunit_skip() is called.
	 */

kunit_skip() doesn't work inside .suite_init, so this would cause
compilation errors:

	static int i915_pci_init_suite(struct kunit_suite *suite)
	{
		if (!hw)
			kunit_skip(suite);
	}


> Talking with David, he seems to have echoed my thoughts.
> David also suggested that maybe the test could use a fake of the hw by
> default, but have an option to run against real hw when available.
> I think that sounds like a good chunk of work, so I don't know if you
> need to worry about that.

Emulating a GPU is a lot of work, and offers their own challenges.
Besides that, the goal here is to check the driver against real
hardware, which may have different steppings and versions. Running
on an emulated hardware defeats such purpose, and may introduce
bugs on its own.

Regards,
Mauro
