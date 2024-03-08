Return-Path: <linux-kselftest+bounces-6114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709A2876AE0
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 19:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4D01F220BA
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9807C249FA;
	Fri,  8 Mar 2024 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgTNQzUK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F163C32;
	Fri,  8 Mar 2024 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923393; cv=none; b=WBA9Zhtkjh91mX0rtuYE7xrPzXdxvpP+/CrbaXr1G1nkQ7bf/phRJSMvXc9sJ+N4B/zZPZNIDdYEtkZJl+uaqeNVtH1W2+W8I7nOQS3PsKAmBgbI6fCyK2INWgCHqn4ILzw7vjAkkEUc59Rmnl93QP+2k+oEFpI1bUNuDqM4bck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923393; c=relaxed/simple;
	bh=xpbjIkk947s/Pk2+JEVwmDNVEUavN0dMxwiURBoqHks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi5jGwXKoa8ejl8Ns1+jpNGazFfP37ayz/1pOkB0r4SGcYCySEwtvEC55zltQLhOD/t6lLSWNI6EWr1L5YnoAd9mXc97cLsa4MovbNsLtk8o5TJbAG6XivZumHvSZUr8XEgDOd3LO1K/BxGRo2XhNkq+MDk+mW4RrLifZKbO7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgTNQzUK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709923391; x=1741459391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xpbjIkk947s/Pk2+JEVwmDNVEUavN0dMxwiURBoqHks=;
  b=TgTNQzUKrR/6OG1xyczrW1QMYtwzHWE9QY+vjPri/C924ISSSV/Gjfbx
   /V1ShKHYHJeiaMBdkQ+JMFktaTQaTbLhyoBL5hEyE16AGAX88jZ4Xzy32
   nNw2ky02pKPN+F6845Yu7a3/lNSStR/zI+zyDPd6pPovvtScL4zwB1h2q
   MAaGHy/Oa4QOgLK6BlaFv7vDnyYrZ4Lwn9UsO2GC7hnjscl1lgDS9BVau
   EpHhi8ojwAp60+IIvZzNKiEE7/83scWolYWPgilPhCK0fvAZXFawxroat
   fk5NnrlDtWUHmgkQef/LVbxJNJfGrIzynDqyMkseNMAqU5qaT019yhRQt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4524152"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4524152"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 10:43:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="33681531"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 10:43:01 -0800
Date: Fri, 8 Mar 2024 10:42:59 -0800
From: Tony Luck <tony.luck@intel.com>
To: James Morse <james.morse@arm.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Message-ID: <ZetcM9GO2PH6SC0j@agluck-desk3>
References: <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
 <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
 <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com>
 <ZepK4mtoV_J8-UbE@agluck-desk3>
 <eacdc287-24bd-4137-85c8-df055cfd78b1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eacdc287-24bd-4137-85c8-df055cfd78b1@arm.com>

On Fri, Mar 08, 2024 at 06:06:45PM +0000, James Morse wrote:
> Hi guys,
> 
> On 07/03/2024 23:16, Tony Luck wrote:
> > On Thu, Mar 07, 2024 at 02:39:08PM -0800, Reinette Chatre wrote:
> >> Thank you for the example. I find that significantly easier to
> >> understand than a single number in a generic "nodes_per_l3_cache".
> >> Especially with potential confusion surrounding inconsistent "nodes"
> >> between allocation and monitoring. 
> >>
> >> How about domain_cpu_list and domain_cpu_map ?
> 
> > Like this (my test system doesn't have SNC, so all domains are the same):
> > 
> > $ cd /sys/fs/resctrl/info/
> > $ grep . */domain*
> > L3/domain_cpu_list:0: 0-35,72-107
> > L3/domain_cpu_list:1: 36-71,108-143
> > L3/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
> > L3/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
> > L3_MON/domain_cpu_list:0: 0-35,72-107
> > L3_MON/domain_cpu_list:1: 36-71,108-143
> > L3_MON/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
> > L3_MON/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
> > MB/domain_cpu_list:0: 0-35,72-107
> > MB/domain_cpu_list:1: 36-71,108-143
> > MB/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
> > MB/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
> 
> This duplicates the information in /sys/devices/system/cpu/cpuX/cache/indexY ... is this
> really because that information is, er, wrong on SNC systems. Is it possible to fix that?

On an SNC system the resctrl domain for L3_MON becomes the SNC node
instead of the L3 cache instance. With 2, 3, or 4 SNC nodes per L3.

Even without the SNC issue this duplication may be a useful
convienience. On Intel to get from a resctrl domain is a multi-step
process to first find which of the indexY directories has level=3
and then look for the "id" that matches the domain.

> >From Tony's earlier description of how SNC changes things, the MB controls remain
> per-socket. To me it feels less invasive to fix the definition of L3 on these platforms to
> describe how it behaves (assuming that is possible), and define a new 'MB' that is NUMA
> scoped.
> This direction of redefining L3 means /sys/fs/resctrl and /sys/devices have different
> views of 'the' cache hierarchy.

I almost went partly in that direction when I started this epic voyage.
The "almost" part was to change the names of the monitoring directories
under mon_data from (legacy non-SNC system):

$ ls -l mon_data
total 0
dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_L3_00
dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_L3_01

to (2 socket, SNC=2 system):

$ ls -l mon_data
total 0
dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_NODE_00
dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_NODE_01
dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_NODE_02
dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_NODE_03

While that is in some ways a more accurate view, it breaks a lot of
legacy monitoring applications that expect the "L3" names.

> (I also think that this be over the threshold on 'funny machines look funny' - but I bet
> someone builds an arm machine that looks like this too!)

-Tony

