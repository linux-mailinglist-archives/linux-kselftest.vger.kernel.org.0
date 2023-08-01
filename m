Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FD576B849
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 17:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjHAPOA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjHAPN7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 11:13:59 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10AF116;
        Tue,  1 Aug 2023 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690902838; x=1722438838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D3Gr4CQz5RXEpExSMqhczLYsHj+yuAQsgSmsBQ4YJ6c=;
  b=CrdxN4KYzAalhwHv9BTvmUYmsCzX/AYiKre100TzFT35yX54fMOh8Wgp
   +/vDCNMKF+yYIrXui7Qq6vRGXNN0Z2R7c7/JrWa5/2s9nYQbAGWMhVJMH
   QpG0uWW3pyHKDrhCUbbJBhO1DTxNNQIY9Q9iOT0kaHemPm/cDVaBHUMdy
   SLPb/a4D1cLzH16P940eAgObD8Oz220H172P4vLPNx5wrtCyFbHJTxHTl
   nspwrEuFs1dA47DRFFGg7g+2PC6qjQuMwxa6Vni9/5hsm0YZMb7ANajiV
   iZnxVNDnNspEskMi0bTigye+K7DaZg/VwbEf1ygpizMI95H6e9PiG36CN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="349619784"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="349619784"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 08:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="975350300"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="975350300"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.213.27.8])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 08:13:56 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [PATCH v3 1/3] kunit: Report the count of test suites in a module
Date:   Tue, 01 Aug 2023 17:13:53 +0200
Message-ID: <5405097.29KlJPOoH8@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230801151711.2765e2eb@coco.lan>
References: <20230731141021.2854827-5-janusz.krzysztofik@linux.intel.com>
 <20230731141021.2854827-6-janusz.krzysztofik@linux.intel.com>
 <20230801151711.2765e2eb@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mauro,

Thanks for review.

On Tuesday, 1 August 2023 15:17:11 CEST Mauro Carvalho Chehab wrote:
> Em Mon, 31 Jul 2023 16:10:23 +0200
> Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com> escreveu:
> 
> > According to KTAP specification[1], results should always start from a
> > header that provides a TAP protocol version, followed by a test plan with
> > a count of items to be executed.  That pattern should be followed at each
> > nesting level.  In the current implementation of the top-most, i.e., test
> > suite level, those rules apply only for test suites built into the kernel,
> > executed and reported on boot.  Results submitted to dmesg from kunit test
> > modules loaded later are missing those top-level headers.
> > 
> > As a consequence, if a kunit test module provides more than one test suite
> > then, without the top level test plan, external tools that are parsing
> > dmesg for kunit test output are not able to tell how many test suites
> > should be expected and whether to continue parsing after complete output
> > from the first test suite is collected.
> > 
> > Submit the top-level headers also from the kunit test module notifier
> > initialization callback.
> > 
> > [1] https://docs.kernel.org/dev-tools/ktap.html#
> > 
> > Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> > ---
> >  lib/kunit/test.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 84e4666555c94..a29ca1acc4d81 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -729,6 +729,11 @@ EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
> >  #ifdef CONFIG_MODULES
> >  static void kunit_module_init(struct module *mod)
> >  {
> > +	if (mod->num_kunit_suites > 0) {
> > +		pr_info("KTAP version 1\n");
> > +		pr_info("1..%d\n", mod->num_kunit_suites);
> > +	}
> > +
> >  	__kunit_test_suites_init(mod->kunit_suites, mod->num_kunit_suites);
> >  }
> 
> IMO, the best would be instead to export kunit_exec_run_tests() and
> use it here too.

I was considering a similar approach, i.e., moving those two pr_info() lines 
from built-in only kunit_exec_run_tests() to __kunit_test_suites_init() which 
is common to both built-in and modular paths, but please note that with kunit 
built in, an empty test plan "1..0" is now reported on boot, while we don't 
want similar reports to appear on loading modules that don't provide any kunit 
tests.  Then, inside either your exported kunit_exec_run_tests() or my 
__kunit_test_suites_init(), we would have to check somehow if it has been 
called from a module notifier initialization callback, and that seemed to me 
too much complicated and less clean than what I've proposed: keep using 
unmodified kunit_exec_run_tests() in built-in and updated kunit_module_init() 
in modular processing path.
Dropping the empty "1..0" test plan from boot messages would mean an ABI 
change, I believe, which I'd rather avoid adding to the scope of this patch as 
not required.

Thanks,
Janusz
 
> 
> Except for the nit, LGTM.
> 
> 
> Thanks,
> Mauro
> 




