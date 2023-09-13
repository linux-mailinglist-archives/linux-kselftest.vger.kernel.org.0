Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6231479E5A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 13:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbjIMLDI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 07:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjIMLDI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 07:03:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CBB1726;
        Wed, 13 Sep 2023 04:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694602984; x=1726138984;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=tl2PB1NpiVR1OX9ewKIvOnsbXbiiP6qbvDil9+QGcmk=;
  b=ZrQdZw3I4BlReGfihJyTQQn4qBMdyG3QSVdPAkSp1dYDVoKedILmRWGN
   OcP+pLZJf/Y6v8ybbEyJxvAlqkPNXvlbzywZANAiPxyM1BChMN+p0w51l
   1RzXegace+X2XuXtek4oDDltk6YyygxXlN99JQGf23JacDiJuYE0ALiLF
   FZBYw4nvwHt7SOes4CV33clz1JpZNDxJ1/tvkVsQ1eucwuGTMNUVI7suj
   nKkFAGCweX3vdNbRCIy0UK6G+wzbb3UvG09Nk0N+NHYPEz+j4hk+YS2eK
   0Z16r5l6+D75HJmzV4LaFdU8ou2OgJlXS2GgBl6i2bsWTH/93gjDvKhsw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464998542"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="464998542"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737457082"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737457082"
Received: from pakurapo-mobl3.ger.corp.intel.com ([10.249.45.213])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:03:01 -0700
Date:   Wed, 13 Sep 2023 14:02:58 +0300 (EEST)
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
In-Reply-To: <b5a36b8a-c5c7-84a9-270e-bef4478d4bff@intel.com>
Message-ID: <eac7deb6-3593-7a59-7df8-208392254f7@linux.intel.com>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com> <20230911111930.16088-4-ilpo.jarvinen@linux.intel.com> <b5a36b8a-c5c7-84a9-270e-bef4478d4bff@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-947309311-1694599446=:1849"
Content-ID: <67bd5477-5f-654-0e6-7d4be5efb566@linux.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-947309311-1694599446=:1849
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <f2223ced-6689-2843-d663-8356e8e1b650@linux.intel.com>

On Tue, 12 Sep 2023, Reinette Chatre wrote:
> On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
> > Feature check in validate_resctrl_feature_request() takes in the test
> > name string and maps that to what to check per test.
> > 
> > Pass resource and feature names to validate_resctrl_feature_request()
> > directly rather than deriving them from the test name inside the
> > function which makes the feature check easier to extend for new test
> > cases.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: <stable@vger.kernel.org>
> 
> This does not seem to be stable material.

Alone it isn't, but both 2/5 and this 3/5 are prerequisites for 4/5 as 
shown by the tags there.

> > ---
> >  tools/testing/selftests/resctrl/resctrl.h     |  6 +-
> >  .../testing/selftests/resctrl/resctrl_tests.c | 10 +--
> >  tools/testing/selftests/resctrl/resctrlfs.c   | 69 ++++++++-----------
> >  3 files changed, 34 insertions(+), 51 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> > index dd07463cdf48..89ced4152933 100644
> > --- a/tools/testing/selftests/resctrl/resctrl.h
> > +++ b/tools/testing/selftests/resctrl/resctrl.h

> > diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> > index bd36ee206602..bd547a10791c 100644
> > --- a/tools/testing/selftests/resctrl/resctrlfs.c
> > +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> > @@ -10,6 +10,8 @@
> >   */
> >  #include "resctrl.h"
> >  
> > +#include <limits.h>
> > +
> 
> Could you please include <limits.h> before the local resctrl.h?

Believe me I tried that first but it did not work. So this intentionally 
in the current order as resctrl.h defines _GNU_SOURCE which is among 
things that tends to alter many things. If I reorder them, the build gives 
me these issues:

resctrlfs.c: In function ‘taskset_benchmark’:
resctrlfs.c:284:2: warning: implicit declaration of function ‘CPU_ZERO’; 
did you mean ‘FP_ZERO’? [-Wimplicit-function-declaration]
  284 |  CPU_ZERO(&my_set);
      |  ^~~~~~~~
      |  FP_ZERO
resctrlfs.c:285:2: warning: implicit declaration of function ‘CPU_SET’ 
[-Wimplicit-function-declaration]
  285 |  CPU_SET(cpu_no, &my_set);
      |  ^~~~~~~
resctrlfs.c:287:6: warning: implicit declaration of function 
‘sched_setaffinity’ [-Wimplicit-function-declaration]
  287 |  if (sched_setaffinity(bm_pid, sizeof(cpu_set_t), &my_set)) {
      |      ^~~~~~~~~~~~~~~~~

It might be useful to move _GNU_SOURCE define into Makefile though to 
avoid these kind of issues (but that's not material for this patch).

> >  static int find_resctrl_mount(char *buffer)
> >  {
> >  	FILE *mounts;
> > @@ -604,63 +606,46 @@ char *fgrep(FILE *inf, const char *str)
> >  
> >  /*
> >   * validate_resctrl_feature_request - Check if requested feature is valid.
> > - * @resctrl_val:	Requested feature
> > + * @resource:	Required resource (e.g., MB, L3, L2, L3_MON, etc.)
> > + * @feature:	Feature to be checked under resource (can be NULL). This path
> > + *		is relative to the resource path.
> 
> I do not think "this path" is accurate. @feature is not a path but an entry
> within the mon_features file.

Yes, agreed.

> Also please note that mon_features only exists for L3_MON, none of the other
> listed resources have an associated mon_features file in resctrl. This
> function is created to be generic has specific requirements on what
> valid (never checked) parameters should be. This may be ok with the usage
> but it should not pretend to be generic.

So are you recommending I split this function into two where the new one 
would do the mon_features check?

> >  	char *res;
> >  	FILE *inf;
> >  	int ret;
> >  
> > -	if (!resctrl_val)
> > +	if (!resource)
> >  		return false;
> >  
> >  	ret = find_resctrl_mount(NULL);
> >  	if (ret)
> >  		return false;
> >  
> > -	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
> > -		if (!stat(L3_PATH, &statbuf))
> > -			return true;
> > -	} else if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
> > -		if (!stat(MB_PATH, &statbuf))
> > -			return true;
> > -	} else if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
> > -		   !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
> > -		if (!stat(L3_MON_PATH, &statbuf)) {
> > -			inf = fopen(L3_MON_FEATURES_PATH, "r");
> > -			if (!inf)
> > -				return false;
> > -
> > -			if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
> > -				res = fgrep(inf, "llc_occupancy");
> > -				if (res) {
> > -					found = true;
> > -					free(res);
> > -				}
> > -			}
> > -
> > -			if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
> > -				res = fgrep(inf, "mbm_total_bytes");
> > -				if (res) {
> > -					free(res);
> > -					res = fgrep(inf, "mbm_local_bytes");
> > -					if (res) {
> > -						found = true;
> > -						free(res);
> > -					}
> > -				}
> > -			}
> > -			fclose(inf);
> > -		}
> > -	}
> > +	snprintf(res_path, sizeof(res_path), "%s/%s", INFO_PATH, resource);
> > +
> > +	if (stat(res_path, &statbuf))
> > +		return false;
> > +
> > +	if (!feature)
> > +		return true;
> > +
> > +	snprintf(res_path, sizeof(res_path), "%s/%s/mon_features", INFO_PATH, resource);
> > +	inf = fopen(res_path, "r");
> > +	if (!inf)
> > +		return false;
> > +
> > +	res = fgrep(inf, feature);
> > +	free(res);
> > +	fclose(inf);
> >  
> > -	return found;
> > +	return res;
> 
> This is unexpected. Function should return bool but instead returns a char * that
> has been freed?

Okay, I understand it looks confusing when relying on implicit conversion 
to boolean (despite being functionally correct).

I can do this instead to make it more obvious the intention is to convert 
the result to boolean and not return a pointer:
	return !!res;

-- 
 i.
--8323329-947309311-1694599446=:1849--
