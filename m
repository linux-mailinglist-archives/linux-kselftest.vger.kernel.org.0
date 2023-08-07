Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4602771DF4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 12:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjHGK0c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 06:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjHGK0b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 06:26:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF97610F4;
        Mon,  7 Aug 2023 03:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691403990; x=1722939990;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oYkA/eVfWqMWYQih0P/5J8PKnMH0gpzlXW9H1/RklVY=;
  b=k846RlCXcqoKaDgnlJv3mN29eqcZgfhH1qg8p7qOdk/O3YObvndTEoSG
   eG5FKwGOsGIcDIyJfUcsO0588nvMfwqJwPibQfR0xnVEk3dfwhozYFJdo
   FiaETGUg681hbTd6zMlGGHMWXE/lXUBSKbXd66i122u0ljyfWqbpBQTDU
   Via+lZEjctpbmZr3j88H2lgVD7Y8lScZtPjdcyOPa4EOBZbJk2eHfPpYq
   tmdTmGuBFKeu1DnU4qNADqtXqF+QQ1OLEhVPLu21xUiwGVspsBvHHCUCh
   XcIsYXakQWR5tfYvNA4RwkgYjEHy86bvApzUT4wZmtc6Qy0goCTA/yKG2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="434357177"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="434357177"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 03:26:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="800897150"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="800897150"
Received: from siminapx-mobl1.ger.corp.intel.com ([10.251.210.150])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 03:26:27 -0700
Date:   Mon, 7 Aug 2023 13:26:25 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
cc:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 07/19] selftests/resctrl: Refactor remount_resctrl(bool
 mum_resctrlfs) to mount_resctrl()
In-Reply-To: <903b5c02-7d7b-11c7-167b-c4f0f3862ae0@intel.com>
Message-ID: <e19fb06b-5dad-e854-3dc-b73c635d7bb1@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com> <20230713131932.133258-8-ilpo.jarvinen@linux.intel.com> <09605219-19db-ba2d-aaad-9e279543f461@intel.com> <2c1f4d5f-7d6f-1178-7ec4-7f8b862b26e9@linux.intel.com>
 <903b5c02-7d7b-11c7-167b-c4f0f3862ae0@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-276558506-1691403989=:9752"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-276558506-1691403989=:9752
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 24 Jul 2023, Wieczor-Retman, Maciej wrote:
> On 14.07.2023 13:03, Ilpo Järvinen wrote:
> > On Thu, 13 Jul 2023, Reinette Chatre wrote:
> >> On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> >>> -int remount_resctrlfs(bool mum_resctrlfs)
> >>> +int mount_resctrlfs(void)
> >>>  {
> >>> -	char mountpoint[256];
> >>>  	int ret;
> >>>  
> >>> -	ret = find_resctrl_mount(mountpoint);
> >>> -	if (ret)
> >>> -		strcpy(mountpoint, RESCTRL_PATH);
> >>> -
> >>> -	if (!ret && mum_resctrlfs && umount(mountpoint))
> >>> -		ksft_print_msg("Fail: unmounting \"%s\"\n", mountpoint);
> >>> -
> >>> -	if (!ret && !mum_resctrlfs)
> >>> -		return 0;
> >>> +	ret = find_resctrl_mount(NULL);
> >>> +	if (!ret)
> >>> +		return -1;
> >>
> >> This treats "ret == 0" as a failure. What about -ENXIO? It seems to
> >> me that only "ret == -ENOENT" is "success".
> > 
> > Yes, it's a good catch.
> > 
> 
> I had an idea about a small redesign of find_resctrl_mount
> return values so it is easier to see what the function tries
> to accomplish.
> 
> When there is an error (-ENXIO for example) it could 
> return the negative error value. When no mount is found
> it could return a zero (instead of the -ENOENT error code).
> Finally when a mount point was found it could return a positive
> value (for example return 1). This way errors could be 
> separate from regular return values and in my opinion the
> function logic would be more transparent.
> 
> What do you think about it?

Yes, it's a great idea. It would be more logical and thus easier to 
comprehend.

Since this already wast applied, it has to be done in another change.


-- 
 i.

--8323329-276558506-1691403989=:9752--
