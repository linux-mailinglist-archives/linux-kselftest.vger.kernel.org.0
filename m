Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B6C614B39
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 13:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiKAMyl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 08:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiKAMyg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 08:54:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A499C1B9D3;
        Tue,  1 Nov 2022 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667307275; x=1698843275;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/2AoikK0W8w5NML5eDaXWNLf++sjzy7BGwh04ld7jzA=;
  b=aecTX7DcR6fR2S8L8gxBbt27F6Dk1JZtG68h0oit9nBYEr+eY1kA5CsF
   zBJnct8/2YAfSivU3Aq5lMEhnIC2ks9Y8qz/OlbJ2xiiwxfU1NU3x26Se
   i2KwPeVTTlrSSUgxoTwk/nVTO8AyS4Q86YLZ4O6ptiBTnCp5OtqOEOi8a
   7+J3lnw29bbuntcm+A7VjwdkHLzDqakjm47XehypdWBpVMFfp1DXS8WLJ
   PRMY0UuxK1EOtxP/ZnmZDblx4PTqhYjxbaPthYLBot2bzf2PMqLfiYdlb
   46gecV2Zd6hFXr3w2hSpc6JAbhZQc0KlXScMsZNGwbfDCc5QnYTqA0u1i
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="371208207"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="371208207"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 05:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="633863354"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="633863354"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 01 Nov 2022 05:54:35 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com [10.252.29.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BE3D9580B9D;
        Tue,  1 Nov 2022 05:54:28 -0700 (PDT)
Date:   Tue, 1 Nov 2022 13:54:25 +0100
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
Message-ID: <20221101135425.3ee12c9c@maurocar-mobl2>
In-Reply-To: <Yyl3UXvLd3Jyr9uP@platvala-desk.ger.corp.intel.com>
References: <20220829000920.38185-1-isabbasso@riseup.net>
        <20220829000920.38185-5-isabbasso@riseup.net>
        <Yyl3UXvLd3Jyr9uP@platvala-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 20 Sep 2022 11:18:25 +0300
Petri Latvala <petri.latvala@intel.com> wrote:

> On Sun, Aug 28, 2022 at 09:09:20PM -0300, Isabella Basso wrote:
> > As the DRM selftests are now using KUnit [1], update IGT tests as well.
> > 
> > [1] - https://lore.kernel.org/all/20220708203052.236290-1-maira.canal@usp.br/
> > 
> > Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> > ---
> >  tests/drm_buddy.c    |  7 ++++---
> >  tests/drm_mm.c       |  7 ++++---
> >  tests/kms_selftest.c | 12 +++++++++---
> >  3 files changed, 17 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tests/drm_buddy.c b/tests/drm_buddy.c
> > index 06876e0c..74c06dce 100644
> > --- a/tests/drm_buddy.c
> > +++ b/tests/drm_buddy.c
> > @@ -6,9 +6,10 @@
> >  #include "igt.h"
> >  #include "igt_kmod.h"
> >  
> > -IGT_TEST_DESCRIPTION("Basic sanity check of DRM's buddy allocator (struct drm_buddy)");
> > +IGT_TEST_DESCRIPTION("Basic sanity check of DRM's buddy allocator (struct \
> > +		      drm_buddy) using KUnit");
> >  
> > -igt_main
> > +igt_simple_main
> >  {
> > -	igt_kselftests("test-drm_buddy", NULL, NULL, NULL);
> > +	igt_kunit("drm_buddy_test", NULL);
> >  }  
> 
> With kselftests we had the ability to only run a specified set of
> tests, and with or without selection, we had sub-results for each
> through dynamic subtests. Does kunit have that possibility? I mean I
> know kunit itself does but what about igt_kunit()?

I don't think so. I created a KUnit with the mock selftests:

	$ modinfo test-i915-mock
	filename:       /lib/modules/6.1.0-rc2-drm-b1cab854a639+/kernel/drivers/gpu/drm/i915/test-i915-mock.ko
	import_ns:      I915_SELFTEST
	license:        GPL v2
	depends:        i915
	retpoline:      Y
	intree:         Y
	name:           test_i915_mock
	vermagic:       6.1.0-rc2-drm-b1cab854a639+ SMP preempt mod_unload 

There's no module parameters. Just loading it makes all tests
there to run.

OK, with the current implementation, we could have one module per subtest, 
but that sounds overkill. 

Another possibility would be to implement it like:

	test-i915-mock-fences
	test-i915-mock-hugepages
	...

which would allow a finer control. Another possibility would be to
change kunit_suite and kunit_test_suites() to optionally create
a modprobe parameter to allow specifying what tests from the test
suites would run.

On the other hand, not sure if are there any gains implementing it,
at least for the hardware-independent tests. I mean, if one of such
tests fail after a patch, the change is broken and should be reverted,
as this is a regression.

> Orthogonal to that question, drm_mm and test-drm_modeset are _now_
> using kunit but in LTS kernels they're not, and we'd like to be able
> to keep testing those. That means having both launchers here and just
> letting the "incorrect" one produce a 'skip'.

Agreed. Patch 4/4 should be checking if the test module is there.
If not, fall back to selftest.

Regards,
Mauro

