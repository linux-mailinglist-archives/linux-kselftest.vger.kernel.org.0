Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DDD7E0123
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 11:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347474AbjKCJzN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 05:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347549AbjKCJzM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 05:55:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B035BD49;
        Fri,  3 Nov 2023 02:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699005304; x=1730541304;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NSyd2tFqpwQi+DzpKhIJTBw3g3F0f78dLo/zLH6QgjA=;
  b=HuUl+btO67zZ4+uIqb5CLMI1MUe0jL5ybZKh9L8W+ArzQRHgHnekXvgi
   S2cK4ox+trYT/WELJPdH5+dR9CauNYrHCZaokwZ3pqjQe166eJUdcPf28
   VXR+k9QgElm2zZScZEcQf2UsQNCwSp4LcsDKcETrbEjVzLIQzFNt2pjst
   qXnXoXrXnQzdxwW5GyhkNJoRstODl7K8d47EWyX7LRsLi7Qt/K3wbNbZP
   PiH/CAVSbo6zFPcdRc7AXeq0vIIRpl19AXWzPl4HZkV9jq/K4Tgpr3IpL
   zV6OGbx5PJl5/4rKaTnbbrrBTCLQ59f2mBbiYvc2fIzKmNpVVWBQ4uTvj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="10451100"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="10451100"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 02:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="9321815"
Received: from pors-mobl3.ger.corp.intel.com ([10.252.35.38])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 02:55:01 -0700
Date:   Fri, 3 Nov 2023 11:54:59 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/24] selftests/resctrl: Introduce generalized test
 framework
In-Reply-To: <56769c01-e21d-4775-94f0-ef9f863c1e92@intel.com>
Message-ID: <ffdeb9a9-c066-19c-9898-c2bdf632cef1@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-19-ilpo.jarvinen@linux.intel.com> <56769c01-e21d-4775-94f0-ef9f863c1e92@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2039173404-1699005303=:1725"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2039173404-1699005303=:1725
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 2 Nov 2023, Reinette Chatre wrote:
> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> ...
> > diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> > index ec6efd36f60a..e017adf1390d 100644
> 
> > @@ -233,25 +183,26 @@ int main(int argc, char **argv)
> >  		case 't':
> >  			token = strtok(optarg, ",");
> >  
> > -			mbm_test = false;
> > -			mba_test = false;
> > -			cmt_test = false;
> > -			cat_test = false;
> > +			if (!test_param_seen) {
> > +				for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++)
> > +					resctrl_tests[i]->disabled = true;
> > +				tests = 0;
> > +				test_param_seen = true;
> > +			}
> >  			while (token) {
> > -				if (!strncmp(token, MBM_STR, sizeof(MBM_STR))) {
> > -					mbm_test = true;
> > -					tests++;
> > -				} else if (!strncmp(token, MBA_STR, sizeof(MBA_STR))) {
> > -					mba_test = true;
> > -					tests++;
> > -				} else if (!strncmp(token, CMT_STR, sizeof(CMT_STR))) {
> > -					cmt_test = true;
> > -					tests++;
> > -				} else if (!strncmp(token, CAT_STR, sizeof(CAT_STR))) {
> > -					cat_test = true;
> > -					tests++;
> > -				} else {
> > -					printf("invalid argument\n");
> > +				bool found = false;
> > +
> > +				for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++) {
> > +					if (!strcasecmp(token, resctrl_tests[i]->name)) {
> > +						if (resctrl_tests[i]->disabled)
> > +							tests++;
> > +						resctrl_tests[i]->disabled = false;
> > +						found = true;
> > +					}
> > +				}
> 
> Could providing multiple "-t" result in the test count not
> matching the number of tests run?

bool test_param_seen covers the case with more than one -t parameter.
Because of it, the code above resets tests and ->disabled only when the 
first -t is encountered. tests++ is only done when ->disabled is set from 
true to false.

I don't see how they could get out of sync but if you had a more specific 
case in mind, just let me know.

-- 
 i.

--8323329-2039173404-1699005303=:1725--
