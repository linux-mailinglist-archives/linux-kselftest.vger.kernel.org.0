Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658FD614B79
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 14:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiKANQN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 09:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKANQL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 09:16:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D411A34;
        Tue,  1 Nov 2022 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667308568; x=1698844568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tT397+jp9ZyIWZq1wBaiRl8vuDNYk3uHjClfBLhU7oo=;
  b=Mi/+g9Che/3wlVGRaEoBnBhkqsdZ65GvmHmdaXTefqrpuHeYvX8Che6b
   Nq9w9mEaLIUoItTffcXfIA4pASP4dHeRPMu6/vcg0JyJvTeEguqWO896O
   XqC2JyCClrmQzFLFw9Mb/H37QZOaLJZhjyBVXHH3wQj8Qmx7l4dSXs82I
   RQrOtcuh1xq288iAPhgC9oXTESd6EpHb49MmHvPOHcP4wts7YS5uJmiCh
   /Kh7N54J/cnV6YMxP08XYb4nA0szS9zWEnW3U2k4nH6immCG+P92Quglo
   0cCQOO5CGh64qzKG/NBrZsR5htY1Fcv/Rk3emXxw2oRQ5K4qRUOQ4KOOt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="307855154"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="307855154"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 06:16:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="633869061"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="633869061"
Received: from thrakatuluk.fi.intel.com (HELO platvala-desk.ger.corp.intel.com) ([10.237.72.90])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 06:16:02 -0700
Date:   Tue, 1 Nov 2022 15:16:02 +0200
From:   Petri Latvala <petri.latvala@intel.com>
To:     Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
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
Message-ID: <Y2EcEnAzkt1Qn341@platvala-desk.ger.corp.intel.com>
References: <20220829000920.38185-1-isabbasso@riseup.net>
 <20220829000920.38185-5-isabbasso@riseup.net>
 <Yyl3UXvLd3Jyr9uP@platvala-desk.ger.corp.intel.com>
 <20221101135425.3ee12c9c@maurocar-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101135425.3ee12c9c@maurocar-mobl2>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 01, 2022 at 01:54:25PM +0100, Mauro Carvalho Chehab wrote:
> On Tue, 20 Sep 2022 11:18:25 +0300
> Petri Latvala <petri.latvala@intel.com> wrote:
> 
> > On Sun, Aug 28, 2022 at 09:09:20PM -0300, Isabella Basso wrote:
> > > As the DRM selftests are now using KUnit [1], update IGT tests as well.
> > > 
> > > [1] - https://lore.kernel.org/all/20220708203052.236290-1-maira.canal@usp.br/
> > > 
> > > Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> > > ---
> > >  tests/drm_buddy.c    |  7 ++++---
> > >  tests/drm_mm.c       |  7 ++++---
> > >  tests/kms_selftest.c | 12 +++++++++---
> > >  3 files changed, 17 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/tests/drm_buddy.c b/tests/drm_buddy.c
> > > index 06876e0c..74c06dce 100644
> > > --- a/tests/drm_buddy.c
> > > +++ b/tests/drm_buddy.c
> > > @@ -6,9 +6,10 @@
> > >  #include "igt.h"
> > >  #include "igt_kmod.h"
> > >  
> > > -IGT_TEST_DESCRIPTION("Basic sanity check of DRM's buddy allocator (struct drm_buddy)");
> > > +IGT_TEST_DESCRIPTION("Basic sanity check of DRM's buddy allocator (struct \
> > > +		      drm_buddy) using KUnit");
> > >  
> > > -igt_main
> > > +igt_simple_main
> > >  {
> > > -	igt_kselftests("test-drm_buddy", NULL, NULL, NULL);
> > > +	igt_kunit("drm_buddy_test", NULL);
> > >  }  
> > 
> > With kselftests we had the ability to only run a specified set of
> > tests, and with or without selection, we had sub-results for each
> > through dynamic subtests. Does kunit have that possibility? I mean I
> > know kunit itself does but what about igt_kunit()?
> 
> I don't think so. I created a KUnit with the mock selftests:
> 
> 	$ modinfo test-i915-mock
> 	filename:       /lib/modules/6.1.0-rc2-drm-b1cab854a639+/kernel/drivers/gpu/drm/i915/test-i915-mock.ko
> 	import_ns:      I915_SELFTEST
> 	license:        GPL v2
> 	depends:        i915
> 	retpoline:      Y
> 	intree:         Y
> 	name:           test_i915_mock
> 	vermagic:       6.1.0-rc2-drm-b1cab854a639+ SMP preempt mod_unload 
> 
> There's no module parameters. Just loading it makes all tests
> there to run.

Ah, the selection is in kunit.ko itself. kunit.filter_glob, set from
kunit.py with

positional arguments:
  filter_glob           Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test



-- 
Petri Latvala
