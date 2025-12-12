Return-Path: <linux-kselftest+bounces-47495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC944CB81F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 08:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABE7330275FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 07:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355AB2874FB;
	Fri, 12 Dec 2025 07:33:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71C274671;
	Fri, 12 Dec 2025 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765524787; cv=none; b=KRExI8k1lr5bNFksmYeZ6gidhCm5rqgBbjAccnRaq92wQfjW9sjvpHtk5ArIey5Qch8RrLm5LhBXowuCapzECR/1ciqhzVX0heTXFiUJrSKfhP7OYIS/TGRsEn30VDGghSw4Jcp3KwTYN7mDzRUvcGdLXc0lo+kV1Co2upfLxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765524787; c=relaxed/simple;
	bh=ep+I5nY5hzqGdlCe10OSsnk+G+zFar7irdaDsPWowEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=or2icCBCGIjQFHV2CJA2d5QXfyD66mL2/G5aw5AmC6k0eKJllcOnpqZaQXh81zMhXDT911VOiFXLpGFxP6if6SUH/WUypI5P3fqW4Wkcs8biFgdbxt5v5B2I84LR4+OiG2Ggly8O28ewx1Ern6jA3Ew1vNIV42Rzj++F+gYl+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from 172.18.26.4(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fiddmFT_1765524768 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 12 Dec 2025 15:32:51 +0800
Message-ID: <182c2515-3658-423c-8521-4dddbd5e16b8@open-hieco.net>
Date: Fri, 12 Dec 2025 15:32:47 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] selftests/resctrl: Define CPU vendor IDs as bits
 to match usage
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de, fenghuay@nvidia.com, shuah@kernel.org,
 skhan@linuxfoundation.org
Cc: babu.moger@amd.com, james.morse@arm.com, Dave.Martin@arm.com,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shenxiaochen@open-hieco.net
References: <20251211064632.2344393-1-shenxiaochen@open-hieco.net>
 <20251211064632.2344393-2-shenxiaochen@open-hieco.net>
 <075748c3-a82b-4e7e-b7e9-6f8900ba2020@intel.com>
Content-Language: en-US
From: Xiaochen Shen <shenxiaochen@open-hieco.net>
In-Reply-To: <075748c3-a82b-4e7e-b7e9-6f8900ba2020@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 12/12/2025 1:22 PM, Reinette Chatre wrote:
> I tried this series against latest upstream kernel and found a conflict with some recent kselftest
> refactoring via commit e6fbd1759c9e ("selftests: complete kselftest include centralization").

Thank you for pointing out this issue.
I will rebase on top of the latest upstream kernel.


> 
> Usually the strategy for resctrl tests is to base them on "next" branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git ... but I notice that the
> conflicting change was routed differently and thus difficult to have anticipated.

Thank you for the information.


> 
> Since we are in merge window the maintainer repos are not ready for new features yet.
> Until the repo is ready, could you please base on latest upstream?

No problem. Thank you.
I will rebase on top of the latest upstream kernel, and then send out v4 patch series.


> 
> Looking at the series it is not obvious how you want these patches handled though. Patch #3
> is the only one with a "Fixes:" tag (and thus candidate for automatic backport) but it is in
> the middle of the series. It is usually best to have fixes at beginning of series to 
> simplify their handling. Even so, all patches are fixes but only patch #4 has a note

Thank you. I will re-organize the patch series to move patch #3 to the beginning of series.


> not to consider for backport. Could you please consider how you want these patches handled,
> communicate that clearly in cover letter, and re-organize the series to have the ones needing
> backport to be at beginning of series?

Thank you for your great suggestions.

I plan to add the maintainer notes in patch #1, patch #2, patch #4 (in original patch ordering in v3) and cover letter:

Patch #1 (this patch):
In my opinion, it is an improvement (to these two commits) rather than a real fix:
   commit 6220f69e72a5 ("selftests/resctrl: Extend CPU vendor detection")
   commit c603ff5bb830 ("selftests/resctrl: Introduce generalized test framework")

What do you think?
If you agree with me, I plan to add a maintainer note that it is not a candidate for backport in v4 patch series.

Patch #2:
This patch is not a candidate for backport. I will add a maintainer note in v4 patch series:
---------------------------
Maintainer note:
Even though this is a fix it is not a candidate for backport since it is
based on another patch series (x86/resctrl: Fix Platform QoS issues for
Hygon) which is in process of being added to resctrl.
---------------------------

Patch #3:
A candidate for backport with "Fixes:" tag. I will move this patch to the beginning of series.

Patch #4:
Already has a maintainer note. Keep no change.

Cover letter:
I plan to add a maintainer note outlining how I'd like these patches to be handled.


>> -static int detect_vendor(void)
>> +static unsigned int detect_vendor(void)
>>  {
>> -	FILE *inf = fopen("/proc/cpuinfo", "r");
>> -	int vendor_id = 0;
>> +	static bool initialized;
>> +	static unsigned int vendor_id;
>> +	FILE *inf;
> Please maintain the reverse fir ordering.

Thank you. I will fix this issue.


Best regards,
Xiaochen Shen

