Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0F46F024A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 10:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243215AbjD0IE4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 04:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243274AbjD0IEp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 04:04:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C46540E7;
        Thu, 27 Apr 2023 01:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682582666; x=1714118666;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YAwLYDdMqQcMoIUVD/XrkZQr1t1fwC+m98oRe+LHHI0=;
  b=Lfn6JMdzIyBDeDbdLPj2ra8viyfF1aoad4p0j1nQZp+kyoVb/Yozq3VT
   Z5MI6z5Ir3IVeliFVctSq0M935Zct7ZNNka/KqHSxzaQQMx9+cD+U0tj9
   K/aRoYa+pS9JCCCLM+Uz05FfABJ0KLswx+qNbHH1Cwbfs5CfQYysrQ9WS
   jtvIYfeMSAysuqXCxcNYSnAziTSy78WybPMXypsv3HJA/itVnt5hpaRHQ
   ss0Sf8cCNEh3C3ohBK4cKGTVqzOxNlXK3ozE+sO55EzLmT+5XHGP2lcI/
   4yRwQciDJPVNr/PRpVZsOcL2KtvCogOmgmDIIRBlgzxHcuMJJhDauCqMf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="336304909"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="336304909"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 01:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="758993834"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="758993834"
Received: from mmaiores-mobl.ger.corp.intel.com ([10.251.215.69])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 01:04:22 -0700
Date:   Thu, 27 Apr 2023 11:04:17 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v2 24/24] selftests/resctrl: Rewrite Cache Allocation
 Technology (CAT) test
In-Reply-To: <ff2b3b61-57d2-04da-a719-c72d8bfd49eb@intel.com>
Message-ID: <dfe24719-cd5e-9ff-9278-a92356dc1490@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-25-ilpo.jarvinen@linux.intel.com> <eac72c7b-bd01-084e-cf23-ec5e8e0e3cf3@intel.com> <b2f72637-5c16-d25b-8a0-3fee4ca9ec7e@linux.intel.com>
 <ff2b3b61-57d2-04da-a719-c72d8bfd49eb@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2136314721-1682582664=:1971"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2136314721-1682582664=:1971
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 26 Apr 2023, Reinette Chatre wrote:
> On 4/26/2023 6:58 AM, Ilpo Järvinen wrote:
> > On Fri, 21 Apr 2023, Reinette Chatre wrote:
> >> On 4/18/2023 4:45 AM, Ilpo Järvinen wrote:
> 
> ...
> 
> >>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> >>> index 4b505fdb35d7..85053829b9c5 100644
> >>> --- a/tools/testing/selftests/resctrl/cat_test.c
> >>> +++ b/tools/testing/selftests/resctrl/cat_test.c
> >>> @@ -11,11 +11,12 @@
> >>>  #include "resctrl.h"
> >>>  #include <unistd.h>
> >>>  
> >>> -#define RESULT_FILE_NAME1	"result_cat1"
> >>> -#define RESULT_FILE_NAME2	"result_cat2"
> >>> -#define NUM_OF_RUNS		5
> >>> -#define MAX_DIFF_PERCENT	4
> >>> -#define MAX_DIFF		1000000
> >>> +#define RESULT_FILE_NAME		"result_cat"
> >>> +#define NUM_OF_RUNS			5
> >>> +#define MIN_DIFF_PERCENT_PER_BIT	2
> >>
> >> Could you please start a new trend that adds documentation
> >> that explains what this constant means and how it was chosen?
> > 
> > I can try although that particular 2 was a bit handwavy that just seems to 
> > work with the tests I performed.
> 
> The changelog claims that the existing CAT test does not work with
> this new test offered as replacement. Considering that I do think it
> is important to have confidence that this test is able to test CAT.
> The words "handwave" and "seems to work" are red flags to me.
> When merged, these tests will be run on a variety of platforms with
> various configurations. Using test criteria based on measurements
> from one particular system may work but there needs to be confidence
> that the criteria maps to all systems these tests will be run on.

My "tests" (in plural) were not limited to one particular system but 
included systems from different generations.

> >>> +static unsigned long current_mask;
> >>> +static long prev_avg_llc_val;
> >>>  
> >>>  /*
> >>>   * Change schemata. Write schemata to specified
> >>> @@ -28,13 +29,24 @@ static int cat_setup(struct resctrl_val_param *p)
> >>>  	int ret = 0;
> >>>  
> >>>  	/* Run NUM_OF_RUNS times */
> >>> -	if (p->num_of_runs >= NUM_OF_RUNS)
> >>> -		return END_OF_TESTS;
> >>> +	if (p->num_of_runs >= NUM_OF_RUNS) {
> >>> +		/* Remove one bit from the consecutive block */
> >>> +		current_mask &= current_mask >> 1;
> >>> +		if (!current_mask)
> >>> +			return END_OF_TESTS;
> >>> +
> >>> +		p->num_of_runs = 0;
> >>
> >> This seems like a workaround to get the schemata to be written. It is
> >> problematic since now p->num_of_runs no longer accurately reflects the
> >> number of test runs.
> > 
> > This is already the case. MBA test works around this very same problem by 
> > using a custom static variable (runs_per_allocation) which is reset to 0 
> > every NUM_OF_RUNS tests and not keeping ->num_of_runs at all. If MBA test 
> > would replace runs_per_allocation with use of ->num_of_runs, it would 
> > match what the new CAT test does.
> > 
> > Nothing currently relies on ->num_of_runs counting across the different 
> > "tests" that are run inside CAT and MBA tests. And I don't have anything 
> > immediately around the corner that would require ->num_of_runs to count 
> > total number of repetitions that were ran.
> > 
> > I guess it would be possible to attempt to consolidate that second layer
> > MBA and the rewritten CAT tests need somehow into resctrl_val_param. But 
> > IMHO that too is low-prio refactor as nothing is broken as is.
> 
> I do not think that I would use any of the other tests as reference
> since all the other tests rely on the same wrapper (resctrl_val())
> by providing it their own customization (via aptly named ... struct
> resctrl_val_param). 

Oh, I see. I never made the connection to the function name before this.
(To be honest, it's pretty stupid name for that particular function,
given what the function does, but that's an entirely separate issue.)

-- 
 i.

> The CAT test is already unique by _not_ using resctrl_val() but its
> own test. I do not see why those resctrl_val() customization need to
> propagate to the CAT test if it is not using the wrapper to begin with.
> 
> > 
> >> I was expecting this mask manipulation to be
> >> in cat_val() so that it is clear how test works instead of part
> >> of the logic handled here.
> > 
> > That seems to be moving into opposite direction from how things are 
> > currently handled. Doing it in cat_val() would be relying less on 
> > ->setup(). If that's the preferred direction, then the question becomes, 
> > should CAT test do anything in ->setup() because also the schemata 
> > writing could be done in directly cat_val().
> > 
> > What I would prefer not to do is to have a rule which says: if there's a 
> > test-specific function, don't use ->setup() but do any setup directly 
> > in the test-specific function but, otherwise use ->setup(). Such an
> > inconsistency would make things hard to track.
> 
> The test specific function can still call a setup function but it
> can be done directly instead of via "struct resctrl_val_param". The
> test specific function already transitioned away from using resctrl_val(),
> it is not clear to me why there should be rules about how
> function pointers within "struct resctrl_val_param" should be used or
> indeed why "struct resctrl_val_param" should be used at all.
> 
> Reinette
> 

--8323329-2136314721-1682582664=:1971--
