Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096827B4F5B
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 11:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbjJBJqo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 05:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbjJBJqn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 05:46:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E67F91;
        Mon,  2 Oct 2023 02:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696240000; x=1727776000;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yecl4KQ6cTg1O9LGgRMfjZXbOywvYlyUsjIAYh4QoG4=;
  b=VVQt3w9tzmYOuQn1xA3lCEjrmt7xnLJTd/VBO9/E+ufowLVH2yvpFK0d
   fsI/t1XsZ53mDW4Crba5HaQBNv9gOO7xMG8qmEzP2MbuxwIljskaDSx9R
   G3cHSKuhBvNj5/nhKtKDISexr4cfD9hasZsPC3LcUs2wE1DIYcE64a3UY
   4/PfnEQSJi/MDV4V8qMynBprvZfGTrqb4YkCvIziLQBOFL67GMxH3DY2N
   XwbePEd1UhgzN92EnmK7b+k2GOnVuBqOemHwFnYVJP0TGGAyt+cZlLE7f
   wZ/7QoAIRMSxrjFMuy6B4njcYccwEglLPbX4KzV4hKBTgSv6E1oE7Hynh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="372960252"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="372960252"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:46:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1467822"
Received: from roliveir-mobl1.ger.corp.intel.com ([10.251.222.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:45:58 -0700
Date:   Mon, 2 Oct 2023 12:46:35 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/7] selftests/resctrl: Fix uninitialized .sa_flags
In-Reply-To: <0df7f82d-de3b-3e51-ffc1-5aa4e23db62a@intel.com>
Message-ID: <545ef67c-4ca2-9a2-381a-991fda391e8e@linux.intel.com>
References: <20230929112039.7488-1-ilpo.jarvinen@linux.intel.com> <20230929112039.7488-2-ilpo.jarvinen@linux.intel.com> <0df7f82d-de3b-3e51-ffc1-5aa4e23db62a@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-889719702-1696239999=:2459"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-889719702-1696239999=:2459
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 29 Sep 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 9/29/2023 4:20 AM, Ilpo Järvinen wrote:
> > signal_handler_unregister() calls sigaction() with uninitializing
> > sa_flags in the struct sigaction.
> > 
> > Make sure sa_flags is always initialized in signal_handler_unregister()
> > by initializing the struct sigaction when declaring it.
> > 
> > Fixes: 73c55fa5ab55 (selftests/resctrl: Commonize the signal handler register/unregister for all tests)
> 
> Please place the title line in quotes (checkpatch warning).

Thanks. I hadn't realize the quotes vanished without an error when I 
removed the escape from " char in gitconfig alias (I have just migrated to 
use alias instead of a custom tool).

> > Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  tools/testing/selftests/resctrl/resctrl_val.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> > index 51963a6f2186..1e8b90077218 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_val.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> > @@ -504,7 +504,7 @@ int signal_handler_register(void)
> >   */
> >  void signal_handler_unregister(void)
> >  {
> > -	struct sigaction sigact;
> > +	struct sigaction sigact = {};
> >  
> >  	sigact.sa_handler = SIG_DFL;
> >  	sigemptyset(&sigact.sa_mask);
> 
> Could you please add this initialization to signal_handler_register()
> also? I understand that the particular issue of sa_flags is not 
> relevant to that function but there are other uninitialized fields.
> I think initializing the struct makes the code more robust without
> needing to reason/understand glibc behavior.

Okay, I'll do that and add a note into the changelog that then correctness 
is obvious from the code itself.

-- 
 i.

--8323329-889719702-1696239999=:2459--
