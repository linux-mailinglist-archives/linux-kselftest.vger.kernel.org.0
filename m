Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BCC7537E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 12:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjGNKWj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 06:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbjGNKWi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 06:22:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB932728;
        Fri, 14 Jul 2023 03:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689330156; x=1720866156;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=I5+hRM1CZd6U68X0rZ2pfLztEvlR5kgkNIj373lYSsc=;
  b=j14hoofv0UNyzkzNnArSl114voO2+RCnT1guIgOdKGYTEbb0Qz6zMHTa
   dNAK05fXqYD71i9PuUjKPBe0iXwj3ChSMkWG9dxj+ECWQXv4rngFq44dJ
   x8l9ESC8gsdFqODEV0ePLGELme2NtebmwyPupD6+MfoE2Z2cxtz+qDc77
   yCjM7NsWO/ZEgrej9roM8Q+P53+BniSI4WOkeEFB0aVE9mz57Kiy3kl8W
   V378Tai9J4KUCFDEdS8mxaFw88l6ocQ0TZCYdClQZ9BzGcEVy3SIsVSMX
   HSX3mXdAz07e4mnQrlk4beL7N2RlFYOi7Z7sUq18otLHsEt7TOuTMDqAn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429204920"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="429204920"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 03:22:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716293017"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="716293017"
Received: from rchauhax-mobl1.gar.corp.intel.com ([10.249.35.123])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 03:22:33 -0700
Date:   Fri, 14 Jul 2023 13:22:27 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
cc:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/19] selftests/resctrl: Express span internally in
 bytes
In-Reply-To: <0c94daef-3642-9e8e-0e8a-3f8eaa2953e3@intel.com>
Message-ID: <fce81fed-592e-16ad-b833-735a7b3a186@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com> <20230713131932.133258-11-ilpo.jarvinen@linux.intel.com> <1dd10447-b03d-937a-fe55-ff324864c358@intel.com> <0c94daef-3642-9e8e-0e8a-3f8eaa2953e3@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2079984484-1689330155=:1695"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2079984484-1689330155=:1695
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 14 Jul 2023, Wieczor-Retman, Maciej wrote:

> Hi Reinette!
> 
> On 14.07.2023 01:00, Reinette Chatre wrote:
> > Hi Ilpo,
> > 
> > On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> >> MBA and MBM tests to use megabytes to represent span. CMT test uses
> >> bytes. The difference requires run_benchmark() to size the buffer
> >> differently based on the test name, which in turn requires passing the
> >> test name into run_benchmark().
> >>
> >> Convert MBA and MBM tests to use internally bytes like CMT test to
> >> remove the internal inconsistency between the tests. Remove the test
> >> dependent buffer sizing from run_benchmark().
> > 
> > If I understand correctly the intention is to always use bytes internally
> > and only convert to megabytes when displayed to user space. The above
> > implies that this takes care of the conversion but there still seems
> > to be places that that do not follow my understanding. For example,
> > resctrl_val.c:measure_vals() converts to megabytes before proceeding.
> 
> Doesn't the use case inside resctrl_val.c:measure_vals() satisfy
> the idea of only displaying data to the user space? From my
> understanding it reads the number of bytes and only converts to
> MB when printing the value. Or did I miss some detail there?

It's for printing there yes.

But it's not about span in the first place so I'm not sure why it is 
related.

-- 
 i.

> > While MBA, MBM, and CMT tests use resctrl_val() for testing it seems
> > as though the function still exits with the MBA/MBM data recorded in
> > megabytes with the CMT data recorded in bytes. That seems to be why
> > show_mba_info() needs no conversion when displaying the data.
> > 
> > Reinette
> 
> Kind regards
> Maciej Wieczór-Retman
> 

--8323329-2079984484-1689330155=:1695--
