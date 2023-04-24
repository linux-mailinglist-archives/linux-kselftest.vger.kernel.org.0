Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39F6ED0C0
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 16:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjDXOzh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 10:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjDXOzf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 10:55:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AC96A72;
        Mon, 24 Apr 2023 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682348132; x=1713884132;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=rItGWlNLTd9zQw0ple5th7e2vNOrmGsJxIxk7/cmGBg=;
  b=iSBDJN4z/1RY1KqhfskgVg9WTGmtbXCYb4M+bnKD/s1HHkp6u6n1Izrd
   3tQ+v3vQGsjAPpvnerysTGAmdht9DWxVZK57fPreCyK++rEQn7eIUh1ta
   9GQFitq/1AzBjzg9gLq1nigQe/Q4LCvPG7sFPe4/Hr9C2UckIlpxkf7xd
   8EE45qR6o5M+9PKHG8jIB6OTgc0MO+EX0M1gTdqU/+uBL1adHtE7plMkN
   vJEfLgUJQX7nWQ/waTNoMF85/AqJgtDSh/BjD+pEdS1uajYVfN7XJSHfZ
   e5dgX6NYR5Gci7gYVMemsEGXDsJ4Qv7sRDSlKR7PQpoV3wxEIDL1iUbeg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="349271827"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="349271827"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 07:55:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="837009506"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="837009506"
Received: from wlwpo-8.amr.corp.intel.com ([10.251.215.143])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 07:55:29 -0700
Date:   Mon, 24 Apr 2023 17:55:27 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v2 04/24] selftests/resctrl: Remove mum_resctrlfs
In-Reply-To: <3df815f8-345e-7089-1c05-f46592ffa393@intel.com>
Message-ID: <70609aef-f449-b371-9554-527a207946c3@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-5-ilpo.jarvinen@linux.intel.com> <3df815f8-345e-7089-1c05-f46592ffa393@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <744aa094-c3e6-5796-3431-de36ff4a1cb5@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 21 Apr 2023, Reinette Chatre wrote:

> > -int remount_resctrlfs(bool mum_resctrlfs)
> > +int mount_resctrlfs(void)
> >  {
> > -	char mountpoint[256];
> >  	int ret;
> >  
> > -	ret = find_resctrl_mount(mountpoint);
> > -	if (ret)
> > -		strcpy(mountpoint, RESCTRL_PATH);
> > -
> > -	if (!ret && mum_resctrlfs && umount(mountpoint))
> > -		ksft_print_msg("Fail: unmounting \"%s\"\n", mountpoint);
> > -
> > -	if (!ret && !mum_resctrlfs)
> > -		return 0;
> > +	ret = find_resctrl_mount(NULL);
> > +	if (!ret)
> > +		return -1;
> 
> This seems to assume that resctrl is always unmounted. Should the main 
> program thus start by unmounting resctrl before it runs any test in case 
> it is mounted when user space starts the tests?

I thought that was the wanted functionality. I've now added a change to 
the series which does this umount before starting a tests.

-- 
 i.
