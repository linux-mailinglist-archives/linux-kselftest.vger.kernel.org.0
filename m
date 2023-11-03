Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7C97E00F9
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 11:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346383AbjKCIyH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 04:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346435AbjKCIxz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 04:53:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30156D47;
        Fri,  3 Nov 2023 01:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699001629; x=1730537629;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RpKSoI1YFPMAYlXPnP3AXfAHJtXgO1s4DaWH10LmUBE=;
  b=ajS82rk4NGu1CCB7zHH0HdvLvF+yCFybQkIZa3MiOdqId3Bm9MgscjOE
   SvKsyG/a8BZM/ilbqEd/o5s6rvtBEi+Lbrp/I688M8zkmsaqGD75rY1Yb
   W1xuxrGYdk00nEQgRJKBxlF89bdrXnhqS4c5IkB5KbfR1Atun4+4shLHB
   OS828RAkixlHudk6TVXCOG/Yv39y1KHwdpwHwa2w4Z061LuZIzMZqRH9j
   vkJ1pkd54acrR+9jfQcJmkPMnobTOXnxGieJtmUaSSetmnbVF8+C/U2L1
   GT6BhVD9moMvWbrMtGsYCQITGkCnQ13tFlb6GIeEtafdnMpHUlIMUrGZA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="392787124"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="392787124"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:53:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="738019984"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="738019984"
Received: from pors-mobl3.ger.corp.intel.com ([10.252.35.38])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:53:45 -0700
Date:   Fri, 3 Nov 2023 10:53:39 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/24] selftests/resctrl: Create cache_size() helper
In-Reply-To: <3849d986-caf4-41ad-85c7-11f11f986e1c@intel.com>
Message-ID: <12d53aae-177f-ff1f-306a-607eeae17ce3@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-6-ilpo.jarvinen@linux.intel.com> <3849d986-caf4-41ad-85c7-11f11f986e1c@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1015571647-1699001628=:1725"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1015571647-1699001628=:1725
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 2 Nov 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> > CAT and CMT tests calculate the span size from the n-bits cache
> > allocation on their own.
> > 
> > Add cache_size() helper which calculates size of the cache portion for
> > the given number of bits and use it to replace the existing span
> > calculations. This also prepares for the new CAT test that will need to
> > determine the size of the cache portion also during results processing.
> > 
> > cache_size local variables were renamed out of the way to
> > cache_total_size.
> 
> Please do stick to imperative mood ... "Rename cache_size local
> variables ..."
> 
> 
> ...
> 
> > diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> > index 2f3f0ee439d8..da06b2d492f9 100644
> > --- a/tools/testing/selftests/resctrl/resctrl.h
> > +++ b/tools/testing/selftests/resctrl/resctrl.h
> > @@ -117,4 +117,18 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
> >  		    unsigned long max_diff_percent, unsigned long num_of_runs,
> >  		    bool platform, bool cmt);
> >  
> > +/*
> > + * cache_size - Calculate the size of a cache portion
> > + * @cache_size:	Cache size in bytes
> > + * @mask:	Cache portion mask
> > + * @cache_mask:	Full bitmask for the cache
> > + *
> > + * Return: The size of the cache portion in bytes.
> > + */
> > +static inline int cache_size(unsigned long cache_size, unsigned long mask,
> > +			     unsigned long cache_mask)
> > +{
> > +	return cache_size * count_bits(mask) / count_bits(cache_mask);
> > +}
> > +
> >  #endif /* RESCTRL_H */
> 
> 
> The get_cache_size() and cache_size() naming appears similar enough to me
> to cause confusion. Considering the "portion" term above, what do you think
> of "cache_portion_size()" or even "cache_portion_bytes()"?

Yes, I'm more than happy to rename them. This naming was what you 
suggested earlier. (I used cache_alloc_size() or something like that
initially and you were against using "alloc" in the name.)

-- 
 i.

--8323329-1015571647-1699001628=:1725--
