Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D540B68D1C0
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 09:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBGIuy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 03:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjBGIur (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 03:50:47 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B192118;
        Tue,  7 Feb 2023 00:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675759846; x=1707295846;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1Cg0BkZLcjjnL2oGDwOtUOGPwzfbs6tORc0ZeGAodwI=;
  b=erHulSN00x2m4X00S/8RRwyeo5ARoiPw5GfGdI7Z77WsNhJRlv2VCODi
   RLak9iBpmMkNdVZ8Fiu65PSH3rSCXFhrmYkVC+4MXZAvRiWsyfmt1N2Iz
   Olntl/RG91oz+25Nrx3wZa+HmUf9Mdhydg/Wgrbc3AK/3kMa0DiBUZXwx
   ccsDD5BA5b3ATflbDn5TebC8J4TcvgeE0Zc8TkHVV31QdAV6h5q+3TmDW
   OIzqL2HHY5xzI1s/+EHyWFSbSs6rt7rmZkOkhtg7E5XircUmFKqL4a5Kb
   YGUjtpvJDcBf9J5r23suEB7IfGBhWFnpxx9cKzOA/kEr2sGIJQsdR3Bwf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="317472521"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="317472521"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 00:50:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="775482535"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="775482535"
Received: from aamakine-mobl.ger.corp.intel.com ([10.249.36.72])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 00:50:29 -0800
Date:   Tue, 7 Feb 2023 10:50:23 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v6 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
In-Reply-To: <TYAPR01MB6330A24D0B7B52567453FF388BDB9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Message-ID: <406496b7-877b-d9e7-10e-d7b31da51add@linux.intel.com>
References: <20230131054655.396270-1-tan.shaopeng@jp.fujitsu.com> <20230131054655.396270-5-tan.shaopeng@jp.fujitsu.com> <a9ab65a6-f750-7fd9-99ba-1cbd15427d2c@linux.intel.com> <TYAPR01MB6330A24D0B7B52567453FF388BDB9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 7 Feb 2023, Shaopeng Tan (Fujitsu) wrote:

> > On Tue, 31 Jan 2023, Shaopeng Tan wrote:
> > 
> > > After creating a child process with fork() in CAT test, if an error
> > > occurs or a signal such as SIGINT is received, the parent process will
> > > be terminated immediately, and therefor the child process will not be
> > > killed and also resctrlfs is not unmounted.
> > >
> > > There is a signal handler registered in CMT/MBM/MBA tests, which kills
> > > child process, unmount resctrlfs, cleanups result files, etc., if a
> > > signal such as SIGINT is received.
> > >
> > > Commonize the signal handler registered for CMT/MBM/MBA tests and
> > > reuse it in CAT too.
> > >
> > > To reuse the signal handler, make the child process in CAT wait to be
> > > killed by parent process in any case (an error occurred or a signal
> > > was received), and when killing child process use global bm_pid
> > > instead of local bm_pid.
> > >
> > > Also, since the MBA/MBA/CMT/CAT are run in order, unregister the
> > > signal handler at the end of each test so that the signal handler
> > > cannot be inherited by other tests.
> > >
> > > Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> > > ---

> > >  	ret = cat_val(&param);
> > > -	if (ret)
> > > -		return ret;
> > > -
> > > -	ret = check_results(&param);
> > > -	if (ret)
> > > -		return ret;
> > > +	if (ret == 0)
> > > +		ret = check_results(&param);
> > 
> > It would be take this program flow fix out of the signal handler change into a
> > separate change.
> 
> Do you mean this fix should be separated into two patches?

Yes.

Currently, I see your patch doing (mainly) two things:
1) cleaning up the messy signal handler logic
2) fixing the early return in case of error from cat_val() or 
   check_results()

Both are good changes and both are needed to fully fix things. But (IMHO) 
those are indepedent enough that it would warrant to split this change 
into two.

-- 
 i.

> To make the child process wait to be killed by parent process
> in any case(an error occurred or a signal was received),
> I fixed it like this.
> 
> This fix was discussed here.
> https://lore.kernel.org/lkml/2ab9ca20-c757-7dd8-b770-2b84d171cbfb@intel.com/


