Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A045339949
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 22:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbhCLVwE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 16:52:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:43337 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235288AbhCLVv5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 16:51:57 -0500
IronPort-SDR: 75oQiYs0q8lBYyvsj4aqnLxrFGdlnp52n4j6zSaC8f8mtLA395WqqeiN4IWDe/5NI9wnbpdIwA
 a4kpJ8gBWEfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="168167076"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="168167076"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 13:51:47 -0800
IronPort-SDR: sEyJrDV40PbpN3UUX4MfDknCTVMh3ZsDfnCTf3oW0fZUX3PViyeFQOyP6D56iLGZVq2GfKBxd5
 oZTffeEAW6Yw==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="510453600"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 13:51:47 -0800
Date:   Fri, 12 Mar 2021 21:51:40 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     Shuah Khan <shuah@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/21] selftests/resctrl: Fix compilation issues for
 global variables
Message-ID: <YEvibJFnQhCncaqr@otcwcpicx3.sc.intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
 <20210307145502.2916364-3-fenghua.yu@intel.com>
 <bf2efac2-99bf-5b58-8952-db9291a1eae1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2efac2-99bf-5b58-8952-db9291a1eae1@amd.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Babu,

On Fri, Mar 12, 2021 at 01:08:31PM -0600, Babu Moger wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > Taking a closer look at the usage of these variables reveals that these
> > variables are used only locally to functions such as cqm_resctrl_val()
> 
> %s/ locally to functions/locally in two functions

OK. Will change it.

> > -int get_cbm_mask(char *cache_type)
> > +int get_cbm_mask(char *cache_type, char *cbm_mask)
> >  {
> >  	char cbm_mask_path[1024];
> >  	FILE *fp;
> > 
> > +	if (!cbm_mask)
> > +		return -1;
> 
> Can cbm_mask be NULL? I see it is statically allocated.
> Or should this be if (!(*cbm_mask))? Or did I miss something.

This is a sanity checking. Although current callers do pass statically
allocated cbm_mask to the parameter, future callers may incorrectly pass
un-allocated cbm_mask to the parameter and may cause segmentation fault
without the sanity checking. To debug this kind of issue, the sanity
checking will be very helpful.

So I would keep this sanity checking.

Thanks.

-Fenghua
