Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DC9339969
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 23:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhCLWBl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 17:01:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:63797 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235404AbhCLWB2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 17:01:28 -0500
IronPort-SDR: RYWdTLg2J4mfRYtfZkjOlpaSNSqZ1DpI4CXY0r5TrZPEeUkIQzW0NYUGP3+2/jerKbaIcQ6Cw7
 KxFsGHl79UjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="273938414"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="273938414"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 14:01:10 -0800
IronPort-SDR: +7al5dHMabwqxeckJhEusPd5XMrIWMn0Szh+ejdZR3184586oQ2EqkrkIvMTgn9UmtasQP9aX2
 hwrcuY6U1Jew==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="448752402"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 14:01:09 -0800
Date:   Fri, 12 Mar 2021 22:01:07 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     Shuah Khan <shuah@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 04/21] selftests/resctrl: Clean up resctrl features
 check
Message-ID: <YEvkozSBn15WjvV7@otcwcpicx3.sc.intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
 <20210307145502.2916364-5-fenghua.yu@intel.com>
 <ec07e30f-9d8b-6e68-e3c6-743c3435a0d1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec07e30f-9d8b-6e68-e3c6-743c3435a0d1@amd.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Babu,

On Fri, Mar 12, 2021 at 01:09:50PM -0600, Babu Moger wrote:
> > -	if (strcmp(resctrl_val, "mba") == 0)
> > +	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)))
> >  		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=',
> > schemata);
> I see there are few other references as well.  Like this.
> 
> 1 cat_test.c  cat_perf_miss_val  135 if
> (!validate_resctrl_feature_request("cat"))
> 
> 2 cqm_test.c  cqm_resctrl_val                  125 if
> (!validate_resctrl_feature_request("cqm"))
> 
> 3 mba_test.c  mba_schemata_change    157 if
> (!validate_resctrl_feature_request("mba"))
> 
> 4 mbm_test.c  mbm_bw_change             131 if
> (!validate_resctrl_feature_request("mbm"))
> 
> Should you use CAT_STR and CQM_STR etc.. in here as well?

Sure. I will fix this.

Thanks.

-Fenghua
