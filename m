Return-Path: <linux-kselftest+bounces-47626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAECCC5CC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 03:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DA9A3049B17
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 02:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBDF27FB3C;
	Wed, 17 Dec 2025 02:42:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out198-2.us.a.mail.aliyun.com (out198-2.us.a.mail.aliyun.com [47.90.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC7228134C;
	Wed, 17 Dec 2025 02:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765939341; cv=none; b=aq609+PADpYEiewwZ3SlKjDWwsdLoiKMkV1DaljPodS3AZzmaVUXatqLr91xaxO+wTN90rLJkr25pfihBFdRGFO6FYbVcrpW9MCVjPw9qbQmjybUjL9vh+Xm4Wd6iqT6YSE5hMRVehLZM3zGUK9VSiupXoKLGhl71PNPmFbXxTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765939341; c=relaxed/simple;
	bh=fMXlZjXqeSuObXD4pta6kFcNkMtYvxqnAvn6Cn1iM2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezfMQxFbYaAuNpo8hr9+b09R7Dcp/0ASfDBaJU99MNcddrsXfR8T24ufptGydjafsVhdQm14Mg2ITJ1+SsyTwr/2TOsNsOEzvCoaJLLh5uVrGTrTYJrgzrvH4OwzCywPemMD2JTDFOk9LWO9MEkSI+1eYL6ciePwNdSi40Yq7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from 172.18.26.4(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fmIw6LS_1765938994 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 17 Dec 2025 10:36:36 +0800
Message-ID: <619c0a29-7c98-4b2d-93ad-c5576796480d@open-hieco.net>
Date: Wed, 17 Dec 2025 10:36:33 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] selftests/resctrl: Define CPU vendor IDs as bits
 to match usage
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de, fenghuay@nvidia.com, shuah@kernel.org,
 skhan@linuxfoundation.org
Cc: babu.moger@amd.com, james.morse@arm.com, Dave.Martin@arm.com,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shenxiaochen@open-hieco.net
References: <20251213073811.3016864-1-shenxiaochen@open-hieco.net>
 <20251213073811.3016864-3-shenxiaochen@open-hieco.net>
 <928c9107-22a9-47de-ba4b-bd1fffa749cb@intel.com>
Content-Language: en-US
From: Xiaochen Shen <shenxiaochen@open-hieco.net>
In-Reply-To: <928c9107-22a9-47de-ba4b-bd1fffa749cb@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 12/17/2025 7:26 AM, Reinette Chatre wrote:
>> -static int detect_vendor(void)
>> +static unsigned int detect_vendor(void)
>>  {
>> -	FILE *inf = fopen("/proc/cpuinfo", "r");
>> -	int vendor_id = 0;
>> +	FILE *inf;
>> +	static unsigned int vendor_id;
>>  	char *s = NULL;
>>  	char *res;
>> +	static bool initialized;
>>  
> The changelog incorrectly claims that this should now match reverse fir ordering.
> To be "reverse fir" ordered the declarations should look like:
> 
> 	static unsigned int vendor_id;                                          
> 	static bool initialized;                                                
> 	char *s = NULL;                                                         
> 	FILE *inf;                                                              
> 	char *res;             

Thank you! I will fix it on v5 patch.


> 
> 
> With this fixed:
> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you!


Best regards,
Xiaochen Shen

