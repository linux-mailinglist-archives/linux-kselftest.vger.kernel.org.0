Return-Path: <linux-kselftest+bounces-1909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CEE812CB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 11:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C66A1F21247
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 10:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7413B292;
	Thu, 14 Dec 2023 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7KA5EF4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98CA10C;
	Thu, 14 Dec 2023 02:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702549010; x=1734085010;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=se7HV0NwX3ScOn578OoLOlAwYA92v9CPB5k2hm8CIWQ=;
  b=P7KA5EF46YLx4U/oHB7uf/DVs2kZwnVWGtIHwULk0r61ntyFju2QNf8A
   Q/iFhPFQvqdn0G47Q5XStA6PbLRDJ8AXZXfu2IpWUhvhY52VDgOLM3fGV
   kaKClUPneCMPkJWvROVx0f25tPAusCCA365A8cxGYxZyKMYpCZLB+6xq6
   ozzI5QGmFFnCg5MRM1XmxNMhw3MMiptLWSg70k01j1vsvfu3T0psQjzl5
   WgXt3CGdeALcc+eeb+rS2CQGzqf6w4+n0lSvABzJQi7WgOlwx2ndqlyAR
   kbgs0UJFWsPMoPAgIgFetStsQaxvi+UFTIRcdRqGsgNg/Fbuy1p06Fz+d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8495959"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="8495959"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 02:16:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="897699121"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="897699121"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.mshome.net) ([10.237.66.38])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 02:16:46 -0800
Date: Thu, 14 Dec 2023 12:16:43 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/29] selftests/resctrl: Create cache_portion_size()
 helper
In-Reply-To: <0d6cff29-9cda-4501-a29b-48e76fe2a9d8@intel.com>
Message-ID: <bcef4bc4-796e-f0f1-4fa5-8c6a232a3a64@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com> <20231211121826.14392-10-ilpo.jarvinen@linux.intel.com> <0d6cff29-9cda-4501-a29b-48e76fe2a9d8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-204481810-1702549009=:5690"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-204481810-1702549009=:5690
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 13 Dec 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 12/11/2023 4:18 AM, Ilpo Järvinen wrote:
> > +/*
> > + * cache_portion_size - Calculate the size of a cache portion
> > + * @cache_size:		Total cache size in bytes
> > + * @portion_mask:	Cache portion mask
> > + * @full_cache_mask:	Full Cache Bit Mask (CBM) for the cache
> > + *
> > + * Return: The size of the cache portion in bytes.
> > + */
> > +static inline int cache_portion_size(unsigned long cache_size,
> > +				     unsigned long portion_mask,
> > +				     unsigned long full_cache_mask)
> > +{
> > +	return cache_size * count_bits(portion_mask) / count_bits(full_cache_mask);
> > +}
> > +
> 
> Even after you added the new zero check the static checker I tried
> was not able to recognize that this is safe. Could you please add a check
> to ensure that there will be no divide-by-zero here?

Okay. I also now noticed the return type is not what it should be.

-- 
 i.

--8323329-204481810-1702549009=:5690--

