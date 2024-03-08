Return-Path: <linux-kselftest+bounces-6113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A048876A76
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 19:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8B31C212BF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF89D4B5C1;
	Fri,  8 Mar 2024 18:06:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4EB2A8C1;
	Fri,  8 Mar 2024 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921216; cv=none; b=OoOW9ytSTiFc0FF0598nWCA06OkFDV0YWOhwdrtcxbrMDs6+QfAeMRgELuStsjCxxSCIr7+qlfn5lat3y4huKIHO9Fwl315fGqd6K6nmAfO8h67SpRdW9Hk5b54qL7rcwVB265qIiGsnjhWxUX0OMzLaLpDMi9vI52jtD+yKHOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921216; c=relaxed/simple;
	bh=ROE3uYVoQdalc9qxMEBafin0xWxDiJexqDsB2sDZKtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbhCIXZZTx3bG0OWsdJUpb294DIDALBCNSRydWf/GM0FGqtFD+4AXTSrSBMthn85rImWpI4BreUS4Ni3nh/Ffj74A3XMwVmI0GPa0MoNP/7bxP7ktDi5vRkHWmx3k6k4WbLw+hCF+c5F5HJ9GiZZifTnwXNwNTtAhnrd3mFxT0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F631C15;
	Fri,  8 Mar 2024 10:07:28 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06CAD3F738;
	Fri,  8 Mar 2024 10:06:49 -0800 (PST)
Message-ID: <eacdc287-24bd-4137-85c8-df055cfd78b1@arm.com>
Date: Fri, 8 Mar 2024 18:06:45 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Content-Language: en-GB
To: Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
 <8a158ada92f06b97a4679721e84e787e94b94647.1709721159.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
 <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
 <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com>
 <ZepK4mtoV_J8-UbE@agluck-desk3>
From: James Morse <james.morse@arm.com>
In-Reply-To: <ZepK4mtoV_J8-UbE@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi guys,

On 07/03/2024 23:16, Tony Luck wrote:
> On Thu, Mar 07, 2024 at 02:39:08PM -0800, Reinette Chatre wrote:
>> Thank you for the example. I find that significantly easier to
>> understand than a single number in a generic "nodes_per_l3_cache".
>> Especially with potential confusion surrounding inconsistent "nodes"
>> between allocation and monitoring. 
>>
>> How about domain_cpu_list and domain_cpu_map ?

> Like this (my test system doesn't have SNC, so all domains are the same):
> 
> $ cd /sys/fs/resctrl/info/
> $ grep . */domain*
> L3/domain_cpu_list:0: 0-35,72-107
> L3/domain_cpu_list:1: 36-71,108-143
> L3/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
> L3/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
> L3_MON/domain_cpu_list:0: 0-35,72-107
> L3_MON/domain_cpu_list:1: 36-71,108-143
> L3_MON/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
> L3_MON/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
> MB/domain_cpu_list:0: 0-35,72-107
> MB/domain_cpu_list:1: 36-71,108-143
> MB/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
> MB/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000

This duplicates the information in /sys/devices/system/cpu/cpuX/cache/indexY ... is this
really because that information is, er, wrong on SNC systems. Is it possible to fix that?

From Tony's earlier description of how SNC changes things, the MB controls remain
per-socket. To me it feels less invasive to fix the definition of L3 on these platforms to
describe how it behaves (assuming that is possible), and define a new 'MB' that is NUMA
scoped.
This direction of redefining L3 means /sys/fs/resctrl and /sys/devices have different
views of 'the' cache hierarchy.

(I also think that this be over the threshold on 'funny machines look funny' - but I bet
someone builds an arm machine that looks like this too!)


Thanks,

James

