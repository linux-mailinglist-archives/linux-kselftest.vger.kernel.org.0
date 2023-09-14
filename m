Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E8E7A0108
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 11:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbjINJ6k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 05:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjINJ6j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 05:58:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1539C83;
        Thu, 14 Sep 2023 02:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694685515; x=1726221515;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hnQVigd3wbWNyLREzYmFSMr7jEjmzPyKWb+jRnxEQXM=;
  b=nyNyQVEBoYgcUQgDKHYxlI6pbY96dHygPrxiFur2v/u6TGVnJ+uBDfUC
   WPU7mrHGU13uZ7QJMdCvZ+2H8sPMRS12m9rdJMVhl8vhtv6fegbOd6sue
   BZ7uP9sUbStPZLTs0y2zkTmnR0YHE86ZngQF3dcDpJKLYCrLsH3l9eP7e
   iBmwqsB489aGxXr7rp8l0yBlKdCJeDTJNKjIIAgoYftdd9RjDn8zLWn0M
   PDhIuUOKhZi/kk7bEnrpbfAP+t/SFxqwJcudksYa/gPbMXvfGioU89jwq
   hqvqKxbyVjE3YeWDg28Tg5c2pfxyIQLX8StAKcW5FlxRMh7pcn4x2uNCI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="381592735"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="381592735"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 02:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="721188878"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="721188878"
Received: from skolhe-mobl1.ger.corp.intel.com ([10.252.36.254])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 02:58:31 -0700
Date:   Thu, 14 Sep 2023 12:58:26 +0300 (EEST)
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
Subject: Re: [PATCH 2/5] selftests/resctrl: Remove duplicate feature check
 from CMT test
In-Reply-To: <fb32abc8-4381-00bf-c07e-b28066f51cdb@intel.com>
Message-ID: <82c78269-324-5f49-e33f-55364d94c8cf@linux.intel.com>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com> <20230911111930.16088-3-ilpo.jarvinen@linux.intel.com> <40ba8890-32d1-e440-29fd-b8f8db69acc5@intel.com> <80695068-4a6-b8e9-107f-8d29ab3543be@linux.intel.com>
 <fb32abc8-4381-00bf-c07e-b28066f51cdb@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-162618733-1694685514=:1814"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-162618733-1694685514=:1814
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 13 Sep 2023, Reinette Chatre wrote:
> On 9/13/2023 4:11 AM, Ilpo Järvinen wrote:
> > On Tue, 12 Sep 2023, Reinette Chatre wrote:
> >> On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
> >>> The test runner run_cmt_test() in resctrl_tests.c checks for CMT
> >>> feature and does not run cmt_resctrl_val() if CMT is not supported.
> >>> Then cmt_resctrl_val() also check is CMT is supported.
> >>>
> >>> Remove the duplicated feature check for CMT from cmt_resctrl_val().
> >>>
> >>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >>> Cc: <stable@vger.kernel.org>
> >>
> >> This does not look like stable material to me. 
> > 
> > I know but when constructing this series I had 2 options:
> > 
> > Either convert also this when changing validate_resctrl_feature_request() 
> > or remove this call entirely.
> > 
> > Given it's duplicate of the other CMT check, I chose to just remove it 
> > (which I'd do anyway). As patch 4/5 requires 3/5 which in turn requires 
> > this, this has to go stable if 4/5 goes too.
> > 
> 
> Understood. This makes it a dependency of an actual fix, which is addressed
> in 4/5's sign-off area. This notation is new to me but it is not clear to me
> that the dependency should also be tagged as stable material (without a 
> fixes tag). Since it is not an actual fix by itself yet is sent to @stable
> I think it may cause confusion. Is just listing it as a dependency of the
> actual fix not sufficient (as you already do in 4/5)? Perhaps as compromise
> this patch can also get a note to the stable team. Something like:
> 
> 	Cc: <stable@vger.kernel.org> # dependency of "selftests/resctrl: Fix feature checks"
> 
> I am not sure though - I would like to avoid confusion and not burden
> the stable team. If this is a flow you have used before successfully I'd
> defer to your experience.

I came across that dependency format when Greg KH replied to somebody how 
to deal with the cases where there isn't yet a commit id 
(the cases mentioned in Documentation/process/stable-kernel-rules.rst 
assumes there is already a commit id). Unfortunately it's long time ago 
so I cannot easily find the link.

Documentation/process/stable-kernel-rules.rst doesn't state that the 
stable address should be only used for the patches with Fixes. In general, 
I believe this doesn't matter much because whether something is Cc'ed or 
not to stable@vger.kernel.org doesn't seems to impact the decision if a 
patch goes into stable or not (even if even some maintainers seem to 
pretend leaving it out makes a difference so I tend to play along and 
smile myself how incorrect that assumption is :-)). 


-- 
 i.

--8323329-162618733-1694685514=:1814--
