Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163167A0224
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 13:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjINLHF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 07:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINLHE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 07:07:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3531BF8;
        Thu, 14 Sep 2023 04:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694689620; x=1726225620;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=9JugPIiCsTNlGSqA+RcuSCrtIlm0srdP+9uKp4qf/eI=;
  b=iHvk9Ff9y3VeGaBg2/3JY9GTAStt3FVMr8C1IUkOeqUtoPQgiIyjUjLu
   nDrz2th439hD4G8keMHgGXsdSWppZyB3HW8B12ELVicxtzGG87fOC76ho
   Tw8uIbUSLq50eRlz6iBXVc9ArNyWpHJBDyd+m/Vx1DmYbPEqkV0lg7vKx
   HaxbXVKWRjMAocLkR3IkRT6LqYH88CnHXlv/jBoI4dbDEtszWr7UJS/tH
   oeCR5KHV3BcWo6pfZ6a4WBZ1Su+XwvIdCc7Eefh7OdZoS6wSrsRpHqKF8
   3q1D/6lDFUnNGIsuEB9U6RwcNUx7Dt0DtzXIZSq6tDw1mJ8wLsQZtzd1+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377826677"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="377826677"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 04:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="694204392"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="694204392"
Received: from skolhe-mobl1.ger.corp.intel.com ([10.252.36.254])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 04:06:56 -0700
Date:   Thu, 14 Sep 2023 14:06:54 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 3/5] selftests/resctrl: Refactor feature check to use
 resource and feature name
In-Reply-To: <8eb32195-102b-cbf5-3ea0-88550cc81de6@intel.com>
Message-ID: <dfc53e-3f92-82e4-6af-d1a28e8c199a@linux.intel.com>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com> <20230911111930.16088-4-ilpo.jarvinen@linux.intel.com> <b5a36b8a-c5c7-84a9-270e-bef4478d4bff@intel.com> <eac7deb6-3593-7a59-7df8-208392254f7@linux.intel.com>
 <8eb32195-102b-cbf5-3ea0-88550cc81de6@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1062744194-1694684643=:1814"
Content-ID: <28d9a3b7-cfeb-a9c3-296d-fb7779b81997@linux.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1062744194-1694684643=:1814
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <b452ea9-a5c4-b7dd-25c6-5441c2c767eb@linux.intel.com>

On Wed, 13 Sep 2023, Reinette Chatre wrote:
> On 9/13/2023 4:02 AM, Ilpo Järvinen wrote:
> > On Tue, 12 Sep 2023, Reinette Chatre wrote:
> >> On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
> >>> Feature check in validate_resctrl_feature_request() takes in the test
> >>> name string and maps that to what to check per test.
> >>>
> >>> Pass resource and feature names to validate_resctrl_feature_request()
> >>> directly rather than deriving them from the test name inside the
> >>> function which makes the feature check easier to extend for new test
> >>> cases.
> >>>
> >>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >>> Cc: <stable@vger.kernel.org>
> >>
> >> This does not seem to be stable material.
> > 
> > Alone it isn't, but both 2/5 and this 3/5 are prerequisites for 4/5 as 
> > shown by the tags there.
> > 
> >>> ---
> >>>  tools/testing/selftests/resctrl/resctrl.h     |  6 +-
> >>>  .../testing/selftests/resctrl/resctrl_tests.c | 10 +--
> >>>  tools/testing/selftests/resctrl/resctrlfs.c   | 69 ++++++++-----------
> >>>  3 files changed, 34 insertions(+), 51 deletions(-)
> >>>
> >>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> >>> index dd07463cdf48..89ced4152933 100644
> >>> --- a/tools/testing/selftests/resctrl/resctrl.h
> >>> +++ b/tools/testing/selftests/resctrl/resctrl.h
> > 
> >>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> >>> index bd36ee206602..bd547a10791c 100644
> >>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> >>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> >>> @@ -10,6 +10,8 @@
> >>>   */
> >>>  #include "resctrl.h"
> >>>  
> >>> +#include <limits.h>
> >>> +
> >>
> >> Could you please include <limits.h> before the local resctrl.h?
> > 
> > Believe me I tried that first but it did not work. So this intentionally 
> > in the current order as resctrl.h defines _GNU_SOURCE which is among 
> > things that tends to alter many things. If I reorder them, the build gives 
> > me these issues:
> > 
> > resctrlfs.c: In function ‘taskset_benchmark’:
> > resctrlfs.c:284:2: warning: implicit declaration of function ‘CPU_ZERO’; 
> > did you mean ‘FP_ZERO’? [-Wimplicit-function-declaration]
> >   284 |  CPU_ZERO(&my_set);
> >       |  ^~~~~~~~
> >       |  FP_ZERO
> > resctrlfs.c:285:2: warning: implicit declaration of function ‘CPU_SET’ 
> > [-Wimplicit-function-declaration]
> >   285 |  CPU_SET(cpu_no, &my_set);
> >       |  ^~~~~~~
> > resctrlfs.c:287:6: warning: implicit declaration of function 
> > ‘sched_setaffinity’ [-Wimplicit-function-declaration]
> >   287 |  if (sched_setaffinity(bm_pid, sizeof(cpu_set_t), &my_set)) {
> >       |      ^~~~~~~~~~~~~~~~~
> > 
> > It might be useful to move _GNU_SOURCE define into Makefile though to 
> > avoid these kind of issues (but that's not material for this patch).
> 
> How about a #define _GNU_SOURCE in this file as an intermediate step?
> I did see your patch making this change but cannot see how it is
> coordinated with fixing the include order in this file.

I'll just make that change part of this series and use also it as 
dependency. Making an intermediate step just for stable that is going to 
immediately removed in mainline would just causing the code to diverge 
unnecessarily, IMO.

There's also a small risk for some other bug that does not cause compile 
to fail due to differences because of a late define for _GNU_SOURCE. I 
don't find it very likely but seems possible due to differences in some 
constant values (not that the resctrl selftest code is very good at using 
those defined constants in the first place, there are plenty of literals 
still to cleanup).

> >>>  static int find_resctrl_mount(char *buffer)
> >>>  {
> >>>  	FILE *mounts;
> >>> @@ -604,63 +606,46 @@ char *fgrep(FILE *inf, const char *str)
> >>>  
> >>>  /*
> >>>   * validate_resctrl_feature_request - Check if requested feature is valid.
> >>> - * @resctrl_val:	Requested feature
> >>> + * @resource:	Required resource (e.g., MB, L3, L2, L3_MON, etc.)
> >>> + * @feature:	Feature to be checked under resource (can be NULL). This path
> >>> + *		is relative to the resource path.
> >>
> >> I do not think "this path" is accurate. @feature is not a path but an entry
> >> within the mon_features file.
> > 
> > Yes, agreed.
> > 
> >> Also please note that mon_features only exists for L3_MON, none of the other
> >> listed resources have an associated mon_features file in resctrl. This
> >> function is created to be generic has specific requirements on what
> >> valid (never checked) parameters should be. This may be ok with the usage
> >> but it should not pretend to be generic.
> > 
> > So are you recommending I split this function into two where the new one 
> > would do the mon_features check?
> 
> No need to split the function. That seems overkill considering its
> captive usage. I think a snippet making its usage clear will be helpful.
> Something like:
> 
> 	@feature: <description>. Can only be set for L3_MON. Must be
> 		  NULL for all other resources.
> 
> Please feel free to improve.

Thanks, I'll do that.

-- 
 i.
--8323329-1062744194-1694684643=:1814--
