Return-Path: <linux-kselftest+bounces-47496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B6CB8200
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 08:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6C863009114
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 07:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736442DFA32;
	Fri, 12 Dec 2025 07:38:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BDC7262D;
	Fri, 12 Dec 2025 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765525108; cv=none; b=dQ9Q1JIwTU83b76BuM7yGIbvCJJJWjzzPgOt3qTBhAtR0igXwsxIvd1iltoM0Z3UfhnuE4mOAx3imNW0NTL4lqrAa135/kIsGRq558ItAWKBBzwR2GVDqncaKqj4pwzPxbnIxMHgQnkScutxtDRzk+VONYANFlPJK951cPK+s+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765525108; c=relaxed/simple;
	bh=amhWS4B1Pe5krfQ+MRhfCNFzZwanR2YugHVFAYyA+QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bo/EDfM1/784rPl9q41kuRl5Dhc4RG+90nblsoZW/ovd3Ev3GOENenU85oEToXLHcCD4XgGE4+DId0i8jO/7Iw8pw8xi8b2Qdy5cWVpvr2V6ylyOpA2z+d9gnjBNjLVlRnVFGaTIi45gd+13B/fcPMyPArGLj0j4RfsPXZwUNTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from 172.18.26.4(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fiddta7_1765525093 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 12 Dec 2025 15:38:14 +0800
Message-ID: <f2c7ec38-f0e6-470d-b40b-c6abecfc6334@open-hieco.net>
Date: Fri, 12 Dec 2025 15:38:12 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] selftests/resctrl: Add CPU vendor detection for
 Hygon
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de, fenghuay@nvidia.com, shuah@kernel.org,
 skhan@linuxfoundation.org
Cc: babu.moger@amd.com, james.morse@arm.com, Dave.Martin@arm.com,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shenxiaochen@open-hieco.net
References: <20251211064632.2344393-1-shenxiaochen@open-hieco.net>
 <20251211064632.2344393-3-shenxiaochen@open-hieco.net>
 <43b8ec69-3a19-48c0-93cf-48f3142b091c@intel.com>
Content-Language: en-US
From: Xiaochen Shen <shenxiaochen@open-hieco.net>
In-Reply-To: <43b8ec69-3a19-48c0-93cf-48f3142b091c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 12/12/2025 1:23 PM, Reinette Chatre wrote:
> Hi Xiaochen,
> 
> On 12/10/25 10:46 PM, Xiaochen Shen wrote:
>> The resctrl selftest currently fails on Hygon CPUs that support Platform
>> QoS features, printing the error:
>>
>>   "# Can not get vendor info..."
>>
>> This occurs because vendor detection is missing for Hygon CPUs.
>>
>> Fix this by extending the CPU vendor detection logic to include
>> Hygon's vendor ID.
>>
>> Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
>> ---
> 
> Changelog is clear this is a fix, does patch need backport?

Thank you for pointing out this issue.
This patch is not a candidate for backport. I will add a maintainer note:
---------------------------
Maintainer note:
Even though this is a fix it is not a candidate for backport since it is
based on another patch series (x86/resctrl: Fix Platform QoS issues for
Hygon) which is in process of being added to resctrl.
---------------------------

> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you very much!


> 
> Reinette


Best regards,
Xiaochen Shen

