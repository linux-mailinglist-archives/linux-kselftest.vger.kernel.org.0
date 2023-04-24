Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5E76ECA8D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 12:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjDXKqx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 06:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjDXKqu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 06:46:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BE630F0;
        Mon, 24 Apr 2023 03:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682333209; x=1713869209;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gbeGoOKmXuLGeeP4cvTrM+3FzdK+JZjke+ms7lt+PVw=;
  b=GDD8jevc3XFSs8mg02a6OC8li1IPtfeNoHdUIXbRsVscISROrfM3N8Dv
   9PIhhLd0fEVGl5vkxISWsI299cVNM7qEZAYhuF71QlhAuFpIxaka2oXKC
   ZsfJJ5ddmI/fStZ0DxRjwehJvx8KkdoaAxwa4jVLAkQOKOIRW2j/aZWzR
   fqXFUG3Ls2e8GvNhmxTMN7zkI1WfaYdz20J+fOoIjpKe3k5TUbC7EuvV3
   zQnd2CzQmBYGX88jgBgKgaqfwP8zeCVQQcsmlc/Pe0Z1TyK4L0bBWE6co
   ZKXJIrIZ8NCXn+n/oJdwEhVTNLQoOfpWKStawGJJT03iFWW2sPS4NMFZA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="411694776"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="411694776"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 03:46:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="867432181"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="867432181"
Received: from wlwpo-8.amr.corp.intel.com ([10.251.215.143])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 03:46:46 -0700
Date:   Mon, 24 Apr 2023 13:46:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v2 02/24] selftests/resctrl: Check also too low values
 for CBM bits
In-Reply-To: <4bae56e1-9223-7d94-e6da-72504f3d0be3@intel.com>
Message-ID: <d803fd0-1df2-b46d-5b3a-987afd4de24e@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-3-ilpo.jarvinen@linux.intel.com> <4bae56e1-9223-7d94-e6da-72504f3d0be3@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-266868635-1682333208=:2038"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-266868635-1682333208=:2038
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 21 Apr 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> > CAT test only validates that the number of CBM bits is not too large
> > but it could be too small too.
> 
> Could you please elaborate how this scenario could occur?
> 
> > Check and return error before starting the CAT test if the number of
> > CBM bits is too small.
> > 
> > Fixes: 09a67934625a ("selftests/resctrl: Don't hard code value of "no_of_bits" variable")
> 
> This fix is not clear to me. This commit being fixed already contains
> an explicit test that will bail out of no_of_bits <= 0. It is not clear to me
> why it is necessary to adding a test for < 1 as a fix for this commit.

Ah, indeed, it's checked on the higher level so this fix is unnecessary.
I missed it entirely while taking this change out from a more complex 
change and even failed to make the connection when I stared at the very if 
<= 0 check not so many days ago.

-- 
 i.


> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/cat_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> > index fb1443f888c4..722c9cd4120d 100644
> > --- a/tools/testing/selftests/resctrl/cat_test.c
> > +++ b/tools/testing/selftests/resctrl/cat_test.c
> > @@ -129,7 +129,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
> >  	if (!n)
> >  		n = count_of_bits / 2;
> >  
> > -	if (n > count_of_bits - 1) {
> > +	if (n < 1 || n > count_of_bits - 1) {
> >  		ksft_print_msg("Invalid input value for no_of_bits n!\n");
> >  		ksft_print_msg("Please enter value in range 1 to %d\n",
> >  			       count_of_bits - 1);

--8323329-266868635-1682333208=:2038--
