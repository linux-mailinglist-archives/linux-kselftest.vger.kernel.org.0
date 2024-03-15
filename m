Return-Path: <linux-kselftest+bounces-6364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831A087D32F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 19:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B9B4B23451
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3884C635;
	Fri, 15 Mar 2024 18:02:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117B646548;
	Fri, 15 Mar 2024 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710525736; cv=none; b=o6YNFC1TWl+9nizk+ZoeuAvjCTki/Zi5lRYiLU55rakPvAItKPSuzM/qGXR6077PNDaxy6V4xL6pFnWTNe5bmxCC4oot+BdToJUx2WKJBtOEQmCgFsQm03zV/E1S3FyJfRRFTgy5+rou3J35KlbWGw0tfRh/0epToQTbaoRz9pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710525736; c=relaxed/simple;
	bh=Tcuht5PH6shYhP4N68qoB2RRRoW6Kd4Ty8D7HYyBhM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCxZRRW7+p/66Wf67dAm6bkaeoov7sht+KpZUZ0dF/6Y/xYNoXMrya3x9LctRAP1LyiQBZq8s1tsnlr0LvgADkrTVhEjGiEzvmLh8oaD2p4uhUS2Zt4vufhKuy6ua4r3GR5d6h2fppPXKWAOTQI4YZLqeEqAZeheeSH3NmqtaAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48E31C15;
	Fri, 15 Mar 2024 11:02:48 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3C073F762;
	Fri, 15 Mar 2024 11:02:11 -0700 (PDT)
Message-ID: <88430722-67b3-4f7d-8db2-95ee52b6f0b0@arm.com>
Date: Fri, 15 Mar 2024 18:02:10 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Content-Language: en-GB
To: Tony Luck <tony.luck@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
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
 <ZetcM9GO2PH6SC0j@agluck-desk3>
From: James Morse <james.morse@arm.com>
In-Reply-To: <ZetcM9GO2PH6SC0j@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tony,

On 08/03/2024 18:42, Tony Luck wrote:
> On Fri, Mar 08, 2024 at 06:06:45PM +0000, James Morse wrote:
>> Hi guys,
>>
>> On 07/03/2024 23:16, Tony Luck wrote:
>>> On Thu, Mar 07, 2024 at 02:39:08PM -0800, Reinette Chatre wrote:
>>>> Thank you for the example. I find that significantly easier to
>>>> understand than a single number in a generic "nodes_per_l3_cache".
>>>> Especially with potential confusion surrounding inconsistent "nodes"
>>>> between allocation and monitoring. 
>>>>
>>>> How about domain_cpu_list and domain_cpu_map ?
>>
>>> Like this (my test system doesn't have SNC, so all domains are the same):
>>>
>>> $ cd /sys/fs/resctrl/info/
>>> $ grep . */domain*
>>> L3/domain_cpu_list:0: 0-35,72-107
>>> L3/domain_cpu_list:1: 36-71,108-143
>>> L3/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
>>> L3/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
>>> L3_MON/domain_cpu_list:0: 0-35,72-107
>>> L3_MON/domain_cpu_list:1: 36-71,108-143
>>> L3_MON/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
>>> L3_MON/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
>>> MB/domain_cpu_list:0: 0-35,72-107
>>> MB/domain_cpu_list:1: 36-71,108-143
>>> MB/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
>>> MB/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
>>
>> This duplicates the information in /sys/devices/system/cpu/cpuX/cache/indexY ... is this
>> really because that information is, er, wrong on SNC systems. Is it possible to fix that?
> 
> On an SNC system the resctrl domain for L3_MON becomes the SNC node
> instead of the L3 cache instance. With 2, 3, or 4 SNC nodes per L3.
> 
> Even without the SNC issue this duplication may be a useful
> convienience. On Intel to get from a resctrl domain is a multi-step
> process to first find which of the indexY directories has level=3
> and then look for the "id" that matches the domain.
> 
>> >From Tony's earlier description of how SNC changes things, the MB controls remain
>> per-socket. To me it feels less invasive to fix the definition of L3 on these platforms to
>> describe how it behaves (assuming that is possible), and define a new 'MB' that is NUMA
>> scoped.
>> This direction of redefining L3 means /sys/fs/resctrl and /sys/devices have different
>> views of 'the' cache hierarchy.
> 
> I almost went partly in that direction when I started this epic voyage.
> The "almost" part was to change the names of the monitoring directories
> under mon_data from (legacy non-SNC system):
> 
> $ ls -l mon_data
> total 0
> dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_L3_00
> dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_L3_01
> 
> to (2 socket, SNC=2 system):
> 
> $ ls -l mon_data
> total 0
> dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_NODE_00
> dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_NODE_01
> dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_NODE_02
> dr-xr-xr-x. 2 root root 0 Mar  8 10:31 mon_NODE_03

This would be useful for MPAM. I've seen a couple of MPAM systems that have per-NUMA MPAM
controls on the 'L3', but describe it as a single global L3. The MPAM driver currently
hides this by summing the NUMA node counters and reporting it as the global L3's value.


> While that is in some ways a more accurate view, it breaks a lot of
> legacy monitoring applications that expect the "L3" names.

True - but the behaviour is different from a non SNC system, if this software can read the
file - but goes wrong because the contents of the file represent something different, its
still broken.




Thanks,

James

