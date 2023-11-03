Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476957E0298
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 13:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346671AbjKCMKD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 08:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346673AbjKCMKC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 08:10:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74C5A2;
        Fri,  3 Nov 2023 05:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699013396; x=1730549396;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZyAO1NfYqvuM2pcUqTrAtWeSTSyLXfDA+sye3MrCqIk=;
  b=Nya2q8m6VseUzuM38zhzMU7HtaRKpetlbsUDVKlwcTJFX+/PVxKuEZVn
   S/IloHECatZD7eiJY6vnkHek006d5BgDAJ/DAjgFOX6BnH5GPlWLcwVI9
   /65YVHt7gSiWRqYy3Zph0BfOVJBcuyyVVpDeSz9MzOtgLRS12CX3y9/dm
   +r27E8eruKMd0Vu39j9Wh+15Ets1Dn60okkU5f7L+DziItsf2pLah5NT9
   wIAghL4I6M4b8Oc+M/0TrCnfONv88DCYaUw+2VFzJwZ4K+Xtn04+zUBNJ
   +eBpqn3tqehwL1VR8l4piB3mqsqaYMwFisi++VTJoGGMN2NWzFZDMR3zn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="388761204"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="388761204"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 05:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="761597682"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="761597682"
Received: from pors-mobl3.ger.corp.intel.com ([10.252.35.38])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 05:09:53 -0700
Date:   Fri, 3 Nov 2023 14:09:50 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/24] selftests/resctrl: Refactor get_cbm_mask()
In-Reply-To: <575b4c53-34c4-48ed-906d-b9dedb80e0ef@intel.com>
Message-ID: <964f1078-7e36-7e39-9bbe-687d5b2458de@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-4-ilpo.jarvinen@linux.intel.com> <575b4c53-34c4-48ed-906d-b9dedb80e0ef@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1072741397-1699013395=:1725"
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

--8323329-1072741397-1699013395=:1725
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 2 Nov 2023, Reinette Chatre wrote:
> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> 
> > @@ -229,6 +228,31 @@ int get_cbm_mask(char *cache_type, char *cbm_mask)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * get_cbm_mask - Get cbm bit mask
> 
> I know you just copied code here but please keep an eye out for acronyms
> to be written in caps.

Yeah, Maciej also commented on this. I've already made some changes but 
I'll incorporate some of your suggestions too.

> This needs not be named to reflect verbatim what the function does.
> Looking ahead I wonder if "get_full_mask()/get_max_mask()" may not be a
> clear indication of what this does?
>
> Something like:
> 	get_full_mask()/get_max_mask()  Get maximum Cache Bit Mask (CBM) 

Having max in the name sounds useful.

Also related to this, the local variables called long_mask should be 
renamed but perhaps not in this series to not block Maciej's work with 
neverending stream of cleanups :-).

> 	@cache_type:	Cache level(? or should this be "type") as "L2" or L3".
> 	@mask:		Full/Maximum portion of cache available for
> 			allocation represented by bit mask
> 			returned as unsigned long.
> 	
> 
> > + * @cache_type:		Cache level L2/L3
> > + * @mask:		cbm_mask returned as unsigned long
> > + *
> > + * Return: = 0 on success, < 0 on failure.
> > + */
> > +int get_cbm_mask(const char *cache_type, unsigned long *mask)
> > +{
> > +	char cbm_mask_path[1024];
> > +	int ret;
> > +
> > +	if (!cache_type)
> > +		return -1;
> 
> Just to confirm ... error checking on mask is intentionally deferred 
> until get_bit_mask()?

I tried to put as much as possible into get_bit_mask() since every caller 
will have to do the same things anyway. I cannot avoid checking cache_type 
here because snprintf() is using it.


Once again, very superb review of the whole series, thank you very much 
for all the effort! It's really appreciated!


-- 
 i.

--8323329-1072741397-1699013395=:1725--
