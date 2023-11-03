Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D7A7E0134
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 11:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346968AbjKCJTX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 05:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346954AbjKCJTW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 05:19:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D9EDE;
        Fri,  3 Nov 2023 02:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699003155; x=1730539155;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TQaE3gWuPoN+vhn5f8TIU08jANYcXszj149g9Srszg8=;
  b=IcnCg9nCre8cyjOWsHnO3sfnE2irH9nPTalc4BIgONngJG6Bo6/I7hu0
   UC/BMsUX40Umog04o2/gxkkZMnJtMrGmUOrbF7zAnyHeDZjCPpTwwcFmV
   5OatcCvC43wF27T5jDp506zAGXDqSf/OwF9kMGQ6kmCDpxR28xR4WiuLO
   SLow+WdHM+WbeIEpYOy0Q1TbQ6p5zxCan/Hr5lLrFqUnf1f09dwY3Frc4
   /qtN1dgOlI5Ge1gmZCICKW+yL4RGNrbHCe3DBpWwGYle1BJEJBiIVfveH
   7g9XZwggcTo4XBU0LzvHgLDSxcfwBOl4fd64Jf2GvehtyDSWF1vPhtiQ+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="475150034"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="475150034"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 02:19:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="796567814"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="796567814"
Received: from pors-mobl3.ger.corp.intel.com ([10.252.35.38])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 02:19:13 -0700
Date:   Fri, 3 Nov 2023 11:19:11 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/24] selftests/resctrl: Remove unnecessary __u64 ->
 unsigned long conversion
In-Reply-To: <f0252e2b-e3c3-4ad0-b622-53e38f5ea3ae@intel.com>
Message-ID: <6af4deba-eb9d-f796-891b-fc179282b8df@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-10-ilpo.jarvinen@linux.intel.com> <f0252e2b-e3c3-4ad0-b622-53e38f5ea3ae@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-256014211-1699003155=:1725"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-256014211-1699003155=:1725
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 2 Nov 2023, Reinette Chatre wrote:
> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> > Perf counters are __u64 but the code converts them to unsigned long
> > before printing them out.
> > 
> > Remove unnecessary type conversion and the potential loss of meaningful
> > bits due to different sizes of types.
> 
> This motivation is not clear to me. Is this work done in
> preparation for 32 bit testing? This raises a lot more topics if
> this is the case.

So you oppose stating that second part after "and"?

My main motivation was keeping the types consistent when I noted that the 
code does unnecessary conversion to unsigned long (that's the first part 
before "and").

Of course it has the added benefit of being 32-bit compatible but
it was just a thought I added "automatically" without paying much 
attention on whether it's realistic to assume resctrl selftest as whole 
would work with 32-bit or not (objectively, the after patch code is 32-bit 
compatible but it of course gives no guarantees about the rest of the 
resctrl selftest code base).

-- 
 i.

--8323329-256014211-1699003155=:1725--
