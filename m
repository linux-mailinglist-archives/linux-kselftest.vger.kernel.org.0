Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31526EE129
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 13:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjDYLlz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 07:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjDYLly (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 07:41:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B54468A;
        Tue, 25 Apr 2023 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682422912; x=1713958912;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=92nD2nFX4b4wdJozm12atNE8oXhLy20Dg1Gg1HUpNUU=;
  b=A7DnH6bwq5RrT0SU/v7zmWltGr9eq98uTlGMXfkv1MZY8kCbh6tlGC1X
   7JJ6qKixO7KOFk5uY4+y3tSJHKSiuiPRZA+uLrUadfKATQetuE/lT870H
   n7AJE6vpmz8Gd/cOAGuOc6J3sY/afcfakXDssp9hQjFJeonndTc9eo7uI
   XKAE/L5G5HNq83MjwTuIyveb8JdZhr5qI/Q/Byqa/CmviMhPQVoIM/Hz8
   t6O+WmY5qkVV+xbz15Pw92PKYysDdZfdBBWiJZy3bEA0sWtnuftFQafqY
   KVH66McOlWrBnCjZO8qLvdiAPKlibIR1GgtEoPZfdfkXDgH3Nye8BrLsu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="345492856"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="345492856"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 04:41:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="817658146"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="817658146"
Received: from rolfneux-mobl.ger.corp.intel.com ([10.252.34.113])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 04:41:50 -0700
Date:   Tue, 25 Apr 2023 14:41:48 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v2 17/24] selftests/resctrl: Replace count_bits with
 count_consecutive_bits()
In-Reply-To: <455c986a-0d51-0302-d5c3-c6c0f1cc6bad@intel.com>
Message-ID: <7bb3f116-2f4d-b81a-3f49-dae7175e82c1@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-18-ilpo.jarvinen@linux.intel.com> <455c986a-0d51-0302-d5c3-c6c0f1cc6bad@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1286874631-1682422390=:1992"
Content-ID: <8aad71a6-8ed-59f9-388-47bba28647c@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1286874631-1682422390=:1992
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <6d1bdaef-dd2d-13ca-344a-21a83bd677c5@linux.intel.com>

On Fri, 21 Apr 2023, Reinette Chatre wrote:
> On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> > CAT and CMT tests depends on masks being continuous.
> 
> The term used in the spec is "contiguous", using it here
> may help to convey the goal.
> 
> > 
> > Replace count_bits with more appropriate variant that counts
> > consecutive bits.
> 
> Could you please elaborate why this is more appropriate and
> why this is necessary? What is wrong with current solution?
> 
> Please note that cbm_mask in resctrl will always be contiguous.

Hi,

It's good that you asked this question.

This comes from a change (not by me originally) that also excluded the 
shareable bits from the mask the CAT test uses. I assumed (w/o better 
knowledge) that those shareable bits could create a hole into the mask.

It could be wrong assumption and the shareable bits are always at one end 
of the CBM mask.

Do you happen to know how the shareable bits are positioned within the 
mask?


-- 
 i.
--8323329-1286874631-1682422390=:1992--
