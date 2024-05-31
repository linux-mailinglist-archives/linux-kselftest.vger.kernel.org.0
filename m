Return-Path: <linux-kselftest+bounces-10978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A38018D59C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 07:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1ACB24905
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 05:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29AF78269;
	Fri, 31 May 2024 05:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Qly1+aQX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD3F381BD;
	Fri, 31 May 2024 05:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717132392; cv=none; b=iXamH+lDr8H79E3hklKcRBVQ/N8WUDvB0ZASxwJZOXWVu6p2AkvHXU2gaLYDd8+Y3BmjnKKaJEGoIkuB444+GntdN1C8Tbz8FgL+7CelCAEUOQ1/9vSaGcvnvlu4t5I6HOzdsAr7KCT/gh6w/6vfF/VaZ0ksq+quiRdfovR1gvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717132392; c=relaxed/simple;
	bh=b5oTgEHypoLU04Soul9aD7/hN3gfq8N62zQkzfMozmA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mWtOPcj5s4m/T2wgkwP+P6zorpvt7X7+pa6IW55f0nPAMrJzaN90W8hJTeKzqMb5DxQ+CPPpnf2rY1AdN0WMvoj5n0CiGiUtAfevYNymnMdYR8pVWm7b2xqVzi4hLcvPHvOorPzhLAVchTwgKyZ8k5LO9L0tFIOvs+EaF0XY/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Qly1+aQX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717132384;
	bh=b5oTgEHypoLU04Soul9aD7/hN3gfq8N62zQkzfMozmA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Qly1+aQXX+Q9QgvNB6YeqqXdk4JqGbpD0uuhzzy05r9DOHW8wPXb7/Sv2ntceoBoM
	 FRZn63gay2StC0J25Fj6TYYBeArWWgBWAGuXzf/TTfiGAym/cd5S8aefJ9FIKjh5au
	 onKX4mHg5NGZbM3MNeChtdrknXfVjlRBZVnuUoQEkLWjJHq0tpp65DQ7Ue9C0o6Li/
	 zbo5st5AAGtdkRsTUVnKsqKpU2bILqVz78Q/jgJkU/QPmi/I8jmzAs3WFAHnUiLTNe
	 o+4EKaP8U6PnVBIHqBR3dOWh/yDk8E7AGYTanKScQqJUHrks7KVKmKRZJ9lM0BlEOI
	 2pXht4AEkkerg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 40D4D378148F;
	Fri, 31 May 2024 05:12:56 +0000 (UTC)
Message-ID: <046d2d1d-3583-426b-b745-59f3696fb418@collabora.com>
Date: Fri, 31 May 2024 10:12:26 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 angquan yu <angquan21@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v2 0/6] selftests/x86: fix build errors and warnings found
 via clang
To: John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@intel.com>,
 Shuah Khan <shuah@kernel.org>
References: <20240527210042.220315-1-jhubbard@nvidia.com>
 <4d2c93e8-5ab0-4b28-af24-c00d57f359fe@intel.com>
 <44428518-4d21-4de7-8587-04eceefb330d@nvidia.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <44428518-4d21-4de7-8587-04eceefb330d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/31/24 1:00 AM, John Hubbard wrote:
> On 5/30/24 12:46 PM, Dave Hansen wrote:
>> On 5/27/24 14:00, John Hubbard wrote:
>>> John Hubbard (6):
>>>    selftests/x86: build test_FISTTP.c with clang
>>>    selftests/x86: build fsgsbase_restore.c with clang
>>>    selftests/x86: build sysret_rip.c with clang
>>>    selftests/x86: avoid -no-pie warnings from clang during compilation
>>>    selftests/x86: remove (or use) unused variables and functions
>>>    selftests/x86: fix printk warnings reported by clang
>>
>> John, could you and Muhammad have a chat and perhaps settle on a series
>> series that gets acks from both of you?
>>
>>> https://lore.kernel.org/all/20240501122918.3831734-1-usama.anjum@collabora.com/
>>
>> I had Muhammad's in my queue and didn't realize we had two overlapping
>> series' bouncing around until now.
> 
> Aha OK. Muhummad, after looking through this, I see that our
> test_FISTTP.c fix is identical, and that's about it. My series goes
> a bit deeper IMHO and completely fixes all the errors; the tradeoff
> is that it is more intrusive. Which I think is appropriate.
> 
> Would you be OK with my posting v3 that uses your patch for
> test_FISTTP.c [1], and the rest of my patches for the rest?
Yeah, sure go ahead. I'll test/review the v3 series.

> 
> 
> [1]
> https://lore.kernel.org/all/20240501122918.3831734-7-usama.anjum@collabora.com/
> 
> thanks,

-- 
BR,
Muhammad Usama Anjum

