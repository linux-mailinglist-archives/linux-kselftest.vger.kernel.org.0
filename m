Return-Path: <linux-kselftest+bounces-9289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B58678BA28F
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 23:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7202128E5D6
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 21:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA6057CAC;
	Thu,  2 May 2024 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJe1SsLc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2957C9E
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685969; cv=none; b=K0mi3YOKXS5T7JBHW+6GXTtP1Rn+PFDr8SfOuuK9UXDfwrb867UAVv6YFtv0rOJcHgdKfKb9hHT4JZMuVUh+jcxI/TNhr0TJ38HxR3U5lPynPvGMy4qxaQlild6/DWeJiDoDPWEoth4uZHnqjTYvIJJv3E5mtkylcGm0QqPk3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685969; c=relaxed/simple;
	bh=Wm/1C//AkN9PdJ3LzN9yNom+r/A4DPzG9JHrHIXt+A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cI64n/2nGB/vO3mIb7ui8u6y5UKcOGDUS1vURRhyJqcNO3H8jRGiXh+0EJRbciIBQP6dQIccV0AkUFWTzgxnwDpaW/MEDwRS5gVh4SXCmAjylGq1MXppZGCA5gpZ158LD1ok9XD5jOC6cMMwHU/t8BVVX72VehGjWit4IW3jjbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJe1SsLc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714685967; x=1746221967;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wm/1C//AkN9PdJ3LzN9yNom+r/A4DPzG9JHrHIXt+A8=;
  b=cJe1SsLc1zqRSSBLq88Gt5kW9iFUPjIuPhQ9ES1slqN7iOp9uHYvfQ6R
   ngxZ9Is+3gng2h8AaX/3TWhQXLhevuPXUgLb1QQ5tT4DMdCSCcQIVR20O
   dTtXZs+vh2EN6H8PVfDPL8i7h4w7bbGIMmKtuC7U8tRI15JrkYkgdOJs7
   pEpg8A3w/AvI+UAn0ipB9GtnwevcmgEFROMZyOxxBTRrq05PoIFiwGqjm
   xBNMqAeO73/vtWXzAYDauP5qlhwe3z91CZ1vs+rC7XsDhhlMniTpPprBn
   Go4wC31Di3qhURQkpULmyr/qZpmYTxppvjnvCim2chK/O1ieJasWeeftk
   g==;
X-CSE-ConnectionGUID: kjVLpFceSgOoBeiodBo3Ug==
X-CSE-MsgGUID: WADNWV2ARFSZiQ04LYgHSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10643342"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10643342"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 14:39:27 -0700
X-CSE-ConnectionGUID: 6jHWKCuSTiOIw0gA5T9tJA==
X-CSE-MsgGUID: TtS8OteDSjyi/dlKHdELiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27369931"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.57]) ([10.24.10.57])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 14:39:28 -0700
Message-ID: <949f8b38-b3a3-4584-b207-3d7315894a33@intel.com>
Date: Thu, 2 May 2024 14:39:26 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] KVM: selftests: Add a new option to rseq_test
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
 donsheng <dongsheng.x.zhang@intel.com>
References: <20240429233435.19003-1-zide.chen@intel.com>
 <ZjO48cDeqOBGCH6K@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <ZjO48cDeqOBGCH6K@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/2/2024 10:40 AM, Sean Christopherson wrote:
> On Mon, Apr 29, 2024, Zide Chen wrote:
>> Currently, the migration worker delays 1-10 us, assuming that one
>> KVM_RUN iteration only takes a few microseconds.  But if the CPU low
>> power wakeup latency is large enough, for example, hundreds or even
>> thousands of microseconds deep C-state exit latencies on x86 server
>> CPUs, it may happen that it's not able to wakeup the target CPU before
>> the migration worker starts to migrate the vCPU thread to the next CPU.
>>
>> If the system workload is light, most CPUs could be at a certain low
>> power state, which may result in less successful migrations and fail the
>> migration/KVM_RUN ratio sanity check.  But this is not supposed to be
>> deemed a test failure.
>>
>> This patch adds a command line option to skip the sanity check in
>> this case.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> Co-developed-by: donsheng <dongsheng.x.zhang@intel.com>
> 
> This needs Dongsheng's SoB, and your SoB should come last.  And the attributed
> name for any tag should use the person's full name.  Given that I have emails from
> Dongsheng that show up as "Dongsheng Zhang", I _assume_ "donsheng" is incomplete,
> but that's a big assumption on my part.
> 
> Dongsheng, can you provide your explicit SoB, with how you want your name to show
> up?  Thanks!

My bad, will get it fixed. Confirmed with Dongsheng that going forward,
he will use his full name in all the tags.

> From Documentation/process/submitting-patches.rst:
> 
>   Co-developed-by: states that the patch was co-created by multiple developers;
>   it is used to give attribution to co-authors (in addition to the author
>   attributed by the From: tag) when several people work on a single patch.  Since
>   Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
>   followed by a Signed-off-by: of the associated co-author.  Standard sign-off
>   procedure applies, i.e. the ordering of Signed-off-by: tags should reflect the
>   chronological history of the patch insofar as possible, regardless of whether
>   the author is attributed via From: or Co-developed-by:.  Notably, the last
>   Signed-off-by: must always be that of the developer submitting the patch.
>   
>   Note, the From: tag is optional when the From: author is also the person (and
>   email) listed in the From: line of the email header.
>   
>   Example of a patch submitted by the From: author::
>   
>           <changelog>
>   
>           Co-developed-by: First Co-Author <first@coauthor.example.org>
>           Signed-off-by: First Co-Author <first@coauthor.example.org>
>           Co-developed-by: Second Co-Author <second@coauthor.example.org>
>           Signed-off-by: Second Co-Author <second@coauthor.example.org>
>           Signed-off-by: From Author <from@author.example.org>
>   
>   Example of a patch submitted by a Co-developed-by: author::
>   
>           From: From Author <from@author.example.org>
>   
>           <changelog>
>   
>           Co-developed-by: Random Co-Author <random@coauthor.example.org>
>           Signed-off-by: Random Co-Author <random@coauthor.example.org>
>           Signed-off-by: From Author <from@author.example.org>
>           Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
>           Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
> 

