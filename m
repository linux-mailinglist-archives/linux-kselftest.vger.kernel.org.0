Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDB87E011C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 11:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjKCKYv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 06:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjKCKYu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 06:24:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7FFD49;
        Fri,  3 Nov 2023 03:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699007084; x=1730543084;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LlQQi1KjSosZ+dc2G65NQEkutFXgUbLaWoiv3vhldOk=;
  b=mQzt2Y8BAp/KjqzSweoqFS0Lq3+B40BH0CGEjh+LvqnFPUriZ0qVBTGV
   MK9/z4Oup47NBzvkEmAp0QWIDgb/QT+qiNqD1n4MUKR3kYqy44rwwBHrp
   YsK9TvhaGJjJVUsufsTqPhcr7ccs0sws8Og3WhzEo8ucQ3J0UXpksNGLP
   VnsqlBSuxWkHF/Zrz/3wiE+hZEpk15nftqOC9IUKVVnXMxB1SDxKLqnxG
   l6kWztczvrtxI29og9ydmObB2mWAoPLNlRwVY9twmxDXIXOXgmlvH4pAS
   YxWxKdpbdeC7mdb18SsnePjyunV5vjSc+Xx2I3/NPeHKEmu0vcHg0D48H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="10455032"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="10455032"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 03:24:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1093028701"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="1093028701"
Received: from pors-mobl3.ger.corp.intel.com ([10.252.35.38])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 03:24:40 -0700
Date:   Fri, 3 Nov 2023 12:24:37 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 24/24] selftests/resctrl: Ignore failures from L2 CAT
 test with <= 2 bits
In-Reply-To: <a5160a37-7778-49ff-8c25-92846d42e87e@intel.com>
Message-ID: <6426a6be-5e92-6c5d-7025-6308c1f3c24@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-25-ilpo.jarvinen@linux.intel.com> <a5160a37-7778-49ff-8c25-92846d42e87e@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-695283249-1699007082=:1725"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-695283249-1699007082=:1725
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 2 Nov 2023, Reinette Chatre wrote:
> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> > L2 CAT test with low number of bits tends to occasionally fail because
> > of what seems random variation. The margin is quite small to begin with
> > for <= 2 bits in CBM. At times, the result can even become negative.
> > While it would be possible to allow negative values for those cases, it
> > would be more confusing to user.
> > 
> > Ignore failures from the tests where <= 2 were used to avoid false
> > negative results.
> > 
> 
> I think the core message is that 2 or fewer bits should not be used. Instead
> of running the test and ignoring the results the test should perhaps just not
> be run.

I considered that but it often does work so it felt shame to now present
them when they're successful. Then I just had to decide how to deal with
the cases where they failed.

Also, if I make it to not run down to 1 bit, those numbers will never ever 
be seen by anyone. It doesn't say 2 and 1 bit results don't contain any 
information to a human reader who is able to do more informed decisions 
whether something is truly working or not. We could, hypothetically, have 
a HW issue one day which makes 1-bit L2 mask to misbehave and if the 
number is never seen by anyone, it's extremely unlikely to be caught 
easily.

They are just reliable enough for simple automated threshold currently. 
Maybe something else than average value would be, it would need to be 
explored but I suspect also the memory address of the buffer might affect 
the value, with L3 it definitely should because of how the things work but 
I don't know if that holds for L2 too. I have earlier tried playing with 
the buffer addresses with L3 but as I didn't immediately yield positive 
outcome to guard against outliers, I postponed that investigation (e.g., 
my alloc pattern might have been too straightforward and didn't provide 
enough entropy into the buffer start address because I just alloc'ed n x 
buf_size buffers back-to-back).

But I don't have very strong opinion on this so if you prefer I just stop 
at 3 bits, I can change it?

-- 
 i.

--8323329-695283249-1699007082=:1725--
