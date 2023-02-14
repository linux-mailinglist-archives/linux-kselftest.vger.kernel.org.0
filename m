Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315F0696023
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 11:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjBNKCm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 05:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjBNKCD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 05:02:03 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEF9265A3;
        Tue, 14 Feb 2023 02:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676368845; x=1707904845;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ay2iQk5KSGr6gse7ujsRlbfAyYEoHsLc7jM48yfVN6k=;
  b=O7Bu3v3chlld3pNpqOiXUcohl/qssLprq/EyVUrOUhR08nukqUMqc4ZI
   C79ozRLsAM9pwIUSH25VfYMLINqr8JOGA2P5wOBMGAZGmcdLEmk8FVCcl
   Pi6HarCKFyCk6AVGimQ4ebYW+L+0IllbpFzcC0ydauT94BJS9GE9fGbd4
   GZK7KcRM5OIHjZttFmizK/BzO8J+fcjfuTZXr7/UyVBSMuz5zubLYGK9n
   OnAvqqf28qovz5UvVbWBB7M5TW1RwFfOdrafz4FzdYYc3i/r5ZltAjuDy
   0h380d/f1pQcJC5PmFCyYSvuKgOuI7SXai/IODSb8j+YHMFCM8Uu4Vtvk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="310758254"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="310758254"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 02:00:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="778263089"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="778263089"
Received: from asmit6-mobl2.ger.corp.intel.com ([10.249.37.52])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 02:00:43 -0800
Date:   Tue, 14 Feb 2023 12:00:41 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 2/4] selftests/resctrl: Don't hard code divisor in MBM
 results
In-Reply-To: <8ed0dcbd-86af-2658-95de-fdccffba7728@intel.com>
Message-ID: <346283c6-b5a5-ad35-7a90-fd17858be46f@linux.intel.com>
References: <20230208094026.22529-1-ilpo.jarvinen@linux.intel.com> <20230208094026.22529-3-ilpo.jarvinen@linux.intel.com> <8ed0dcbd-86af-2658-95de-fdccffba7728@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-941652853-1676368845=:1771"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-941652853-1676368845=:1771
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 13 Feb 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> The subject is "Don't hard code divisor ..." yet it seems to me
> that the hard coding persists. It is just changed from a magic
> constant to a macro.

Yeah, it was a bad wording.

> On 2/8/2023 1:40 AM, Ilpo Järvinen wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > 
> > Presently, while calculating MBM results, the divisor is hard coded as 4.
> 
> "Presently" can be removed. Here and in the rest of the series the usage of
> "presently" and "currently" can usually be removed to improve clarity.
> 
> > It's hard coded to 4 because "NUM_OF_RUNS" is defined as 5 and the test
> > does not count first result and hence 4. So, instead of hard coding the
> > value to 4, change it to NUM_OF_RUNS - 1.
> 
> Are there any plans surrounding using struct resctrl_val_param::num_of_runs
> instead?

Actually no.

What I'd want to do is that the functions which call these result 
calculator functions would specify the number of tests they passed
into the result calculator. It seems safer because the results are read 
back from a file which could have changed (or got deleted due to an 
ipc bug prematurely cleaning up the file) and would better take account 
those cases where the first value is skipped when reading the results.

I think I'll drop this patch for now.

-- 
 i.

--8323329-941652853-1676368845=:1771--
