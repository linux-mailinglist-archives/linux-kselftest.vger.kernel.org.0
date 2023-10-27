Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CDF7D99D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345882AbjJ0Naq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 09:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbjJ0Nap (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 09:30:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E762CC9;
        Fri, 27 Oct 2023 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698413442; x=1729949442;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=QCDoj2tqsubRZPmLxziPZaPfWsoY1N+hG+KAi9DSmew=;
  b=erdwTc4jdJWcHDkizPryviQfbnJY/J50pYNwh3v167MeFEooQC8MgNlV
   X8hK7tpUjuQr/xmvVSem5Ojo1DDY6NpqU9qs8G0dwcaMyNrEJ4JNr92Nb
   UrPMUtEBvwhTirIM8sBKITvtvNaZA1OmZMWezeAqOdTdgZRIuclclTPvP
   rM/PQa3nvTPOr5y3ZwqTbVqsYuDfEWQkreMQiAqYOrcNuDHnu7elybOeN
   OqY0w4S/j8uvDi/Njp2hR+Zy2A/FFjsvSSLtZ+PF+LeCtJ2gTTSM9FXEW
   GCYO7fro9KOcQnf7W92AWaEDLaN5mCqwz7kg8ITMHVZVWTufxKvZfgS9f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="387588301"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="387588301"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 06:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="825338480"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="825338480"
Received: from scoltan-mobl.ger.corp.intel.com ([10.252.33.159])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 06:30:40 -0700
Date:   Fri, 27 Oct 2023 16:30:38 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
cc:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 21/24] selftests/resctrl: Get resource id from cache id
In-Reply-To: <cb2ctfignowlom7lb2t5zhdgtm4s2jlzlvtumlnvxecwwtjk34@ysgepmgkv6bb>
Message-ID: <ab4c6aa5-ea49-363a-ff7b-2215665f185d@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-22-ilpo.jarvinen@linux.intel.com> <cb2ctfignowlom7lb2t5zhdgtm4s2jlzlvtumlnvxecwwtjk34@ysgepmgkv6bb>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1571728692-1698412161=:2740"
Content-ID: <966c938-5a3a-e5ed-cbb-b79630fb836a@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1571728692-1698412161=:2740
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <a6d0bdae-c091-16e4-f178-c374f5edad8b@linux.intel.com>

On Fri, 27 Oct 2023, Maciej Wieczór-Retman wrote:

> On 2023-10-24 at 12:26:31 +0300, Ilpo Järvinen wrote:
> >Resource id is acquired differently depending on CPU. AMD tests use id
> >from L3 cache, whereas CPUs from other vendors base the id on topology
> >package id. In order to support L2 CAT test, this has to be
> >generalized.
> >
> >The driver side code seems to get the resource ids from cache ids so
> >the approach used by the AMD branch seems to match the kernel-side
> >code. It will also work with L2 resource IDs as long as the cache level
> >is generalized.
> >
> >Using the topology id was always fragile due to mismatch with the
> >kernel-side way to acquire the resource id. It got incorrect resource
> >id, e.g., when Cluster-on-Die (CoD) is enabled for CPU (but CoD is not
> >well suited for resctrl in the first place so it has not been a big
> >issues if test don't work correctly with it).
> 
> "not been a big issues" -> "not been a big issue"?
> 
> "if test don't work correctly" -> "if test doesn't work correctly" / "if tests
> don't work correctly"?
> 
> >
> >Taking all the above into account, generalize the resource id
> >calculation by taking it from the cache id and do not hard-code the
> >cache level.
> 
> In x86/resctrl files group of CPUs sharing a resctrl resource is called a
> domain. Because of that I think "resource id" terms should be substituted with
> "domain id" to match core resctrl code.

Okay, I was just using the terminology which pre-existed in the selftest 
code.

I've really tried to look how I should call it but things were quite 
inconsistent. The selftest uses resource id and reads it from cache id.
Documentation uses "instances of that resource" or "cache id" or "domain 
x".


Documentation/arch/x86/resctrl.rst is very misleading btw and should be 
IMHO updated:

Memory bandwidth Allocation (default mode)
------------------------------------------

Memory b/w domain is L3 cache.
::

        MB:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...

It claims "domain" is L3 cache (and the value we're talking about is 
called "cache_id" here which is what you just called "domain id"). I 
suppose it should say "b/w resource is L3 cache"?


-- 
 i.
--8323329-1571728692-1698412161=:2740--
