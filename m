Return-Path: <linux-kselftest+bounces-48664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A071D0D2B7
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 08:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF52B301EC55
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 07:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AEF23D7FD;
	Sat, 10 Jan 2026 07:31:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A238D1F12E0;
	Sat, 10 Jan 2026 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768030312; cv=none; b=GmeWVPgUAtptLR/dt3XcXTmrVc6mQvjWa+I8NyDRUgUPLX4pkxTldLNr3N0t53mhWuICFRIUMgtUhCKnaxZEiY/PFjENtiDrLROYunanVmX61b7f62cYR1PSWJXcZ7KZEjDMlzK8t+AEh36tpKpjecnDFltgcMrH1/Djqw5pSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768030312; c=relaxed/simple;
	bh=/wB05W6e84K94JmMQZWaHmkeKOaXajSrHLtnZ52TTyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDv7aMQMZAQi5BZnXT0WrcuCOTGfgX517WZ7lhE6BneBVurT38s6kk/L8ZamBvFA6vT84BpLDT+tvepeEa/2VAsXzlZZL2dJKAd03ENBxkRaDlQWNOYs7ollO5ALGdnrzqFy31rQoVvZglmwHrghPGSpCt5bRn10FF7wFbj5izE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from 172.18.26.4(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.g31FqaW_1768029983 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 10 Jan 2026 15:26:24 +0800
Message-ID: <2abf5456-919b-437f-acc3-a251b453ad39@open-hieco.net>
Date: Sat, 10 Jan 2026 15:26:23 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] selftests/resctrl: Add Hygon CPUs support and bug
 fixes
To: Reinette Chatre <reinette.chatre@intel.com>, Shuah <shuah@kernel.org>,
 tony.luck@intel.com, bp@alien8.de, fenghuay@nvidia.com
Cc: babu.moger@amd.com, james.morse@arm.com, Dave.Martin@arm.com,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 shenxiaochen@open-hieco.net
References: <20251217030456.3834956-1-shenxiaochen@open-hieco.net>
 <bdecae64-5f6e-42d4-a05b-3334b95e6ec0@intel.com>
 <3692e9fb-b827-413f-902e-a57d6d3aca20@kernel.org>
 <bea4807f-fb01-4bbd-a5d2-66b78d524c30@intel.com>
Content-Language: en-US
From: Xiaochen Shen <shenxiaochen@open-hieco.net>
In-Reply-To: <bea4807f-fb01-4bbd-a5d2-66b78d524c30@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shuah, Reinette, Tony and Fenghua,

On 1/10/2026 8:02 AM, Reinette Chatre wrote:
> 
> 
> On 1/9/26 3:51 PM, Shuah wrote:
>>
>> Applied to linux-kselftest next branch for Linux 6.20-rc1
> 
> Thank you very much Shuah.
> 
> Reinette


I truly appreciate your great help with the code review and patch merge - thanks!

Best regards,
Xiaochen Shen

