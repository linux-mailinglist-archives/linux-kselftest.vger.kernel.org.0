Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B32614C1E
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 14:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiKANxq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 09:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiKANxp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 09:53:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237E919293;
        Tue,  1 Nov 2022 06:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667310824; x=1698846824;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HbiE9H6K1QA3Gs6UeJRLL4w76SL9urnXizp/flcoQFA=;
  b=G/ZbZQtsoMxTmF3cRLrLZ2W7QCeIqAfns6v0ovJZhBV4rmGBFhWx35aI
   5w8eWXx7gLId7Ik3s7SCtAlKOhgGqt08clRwF773W7zKV0szgfnn2R/qH
   Zr+QxEXY/5ECTyuaTPwYj5qIh6Ta8fu7rpHIwVuOEdldWctDYw6I8fpa6
   6uZjf0RT8DzcmG6o23qtvcQppbW0JgCfyTcGQ0gAjDVIioVBm1yo4Sg0H
   ue2sR/He/3oYhdjH4dwtgWBA+AU9K/Zm/Gjva/UecLyBA8dlvKMnhJE0k
   1ZMIBbq64nR2aL1k7Eb9GryqXFEWxrw+FmeCYZR6BkyGbyVOj5Qqogsa4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="306752704"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="306752704"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 06:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="665153457"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="665153457"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 01 Nov 2022 06:53:43 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com [10.252.29.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D24EA580AA7;
        Tue,  1 Nov 2022 06:53:36 -0700 (PDT)
Date:   Tue, 1 Nov 2022 14:53:33 +0100
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Petri Latvala <petri.latvala@intel.com>
Cc:     Isabella Basso <isabbasso@riseup.net>, twoerner@gmail.com,
        linux-kselftest@vger.kernel.org, magalilemes00@gmail.com,
        maira.canal@usp.br, dlatypov@google.com, tales.aparecida@gmail.com,
        brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        leandro.ribeiro@collabora.com, igt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch, n@nfraprado.net,
        davidgow@google.com, skhan@linuxfoundation.org,
        andrealmeid@riseup.net, kunit-dev@googlegroups.com
Subject: Re: [igt-dev] [PATCH i-g-t v2 4/4] tests: DRM selftests: switch to
 KUnit
Message-ID: <20221101145333.5960e6e7@maurocar-mobl2>
In-Reply-To: <Y2EcEnAzkt1Qn341@platvala-desk.ger.corp.intel.com>
References: <20220829000920.38185-1-isabbasso@riseup.net>
        <20220829000920.38185-5-isabbasso@riseup.net>
        <Yyl3UXvLd3Jyr9uP@platvala-desk.ger.corp.intel.com>
        <20221101135425.3ee12c9c@maurocar-mobl2>
        <Y2EcEnAzkt1Qn341@platvala-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 1 Nov 2022 15:16:02 +0200
Petri Latvala <petri.latvala@intel.com> wrote:

> On Tue, Nov 01, 2022 at 01:54:25PM +0100, Mauro Carvalho Chehab wrote:
> > On Tue, 20 Sep 2022 11:18:25 +0300
> > Petri Latvala <petri.latvala@intel.com> wrote:
> > 
> > > On Sun, Aug 28, 2022 at 09:09:20PM -0300, Isabella Basso wrote:
> > > > As the DRM selftests are now using KUnit [1], update IGT tests as well.
> > > > 
> > > > [1] - https://lore.kernel.org/all/20220708203052.236290-1-maira.canal@usp.br/
> > > > 
> > > > Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> > > > ---
> > > >  tests/drm_buddy.c    |  7 ++++---
> > > >  tests/drm_mm.c       |  7 ++++---
> > > >  tests/kms_selftest.c | 12 +++++++++---
> > > >  3 files changed, 17 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/tests/drm_buddy.c b/tests/drm_buddy.c
> > > > index 06876e0c..74c06dce 100644
> > > > --- a/tests/drm_buddy.c
> > > > +++ b/tests/drm_buddy.c
> > > > @@ -6,9 +6,10 @@
> > > >  #include "igt.h"
> > > >  #include "igt_kmod.h"
> > > >  
> > > > -IGT_TEST_DESCRIPTION("Basic sanity check of DRM's buddy allocator (struct drm_buddy)");
> > > > +IGT_TEST_DESCRIPTION("Basic sanity check of DRM's buddy allocator (struct \
> > > > +		      drm_buddy) using KUnit");
> > > >  
> > > > -igt_main
> > > > +igt_simple_main
> > > >  {
> > > > -	igt_kselftests("test-drm_buddy", NULL, NULL, NULL);
> > > > +	igt_kunit("drm_buddy_test", NULL);
> > > >  }  
> > > 
> > > With kselftests we had the ability to only run a specified set of
> > > tests, and with or without selection, we had sub-results for each
> > > through dynamic subtests. Does kunit have that possibility? I mean I
> > > know kunit itself does but what about igt_kunit()?
> > 
> > I don't think so. I created a KUnit with the mock selftests:
> > 
> > 	$ modinfo test-i915-mock
> > 	filename:       /lib/modules/6.1.0-rc2-drm-b1cab854a639+/kernel/drivers/gpu/drm/i915/test-i915-mock.ko
> > 	import_ns:      I915_SELFTEST
> > 	license:        GPL v2
> > 	depends:        i915
> > 	retpoline:      Y
> > 	intree:         Y
> > 	name:           test_i915_mock
> > 	vermagic:       6.1.0-rc2-drm-b1cab854a639+ SMP preempt mod_unload 
> > 
> > There's no module parameters. Just loading it makes all tests
> > there to run.
> 
> Ah, the selection is in kunit.ko itself. kunit.filter_glob, set from
> kunit.py with
> 
> positional arguments:
>   filter_glob           Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test
> \

Gah, permissions are 0:

	module_param_named(filter_glob, filter_glob_param, charp, 0);

You can't even see what filters were set via sysfs:

	$ ls /sys/module/kunit/parameters/
	stats_enabled

So, once set, there's no way to change it.

I wonder why this isn't 0x644.

It sounds that, if we want to control it at runtime, we'll need to 
build with kunit as module, and unload/reload it every time if/when
we want to run IGT with a different filtering ruleset.

Regards,
Mauro
