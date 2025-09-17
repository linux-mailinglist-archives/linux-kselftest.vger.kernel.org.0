Return-Path: <linux-kselftest+bounces-41681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B6EB7F43F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 15:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D3C468079
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 13:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D70D1946C8;
	Wed, 17 Sep 2025 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y2I6/2WU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BF41369B4;
	Wed, 17 Sep 2025 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115169; cv=none; b=TnBStYNeXNWg9rAkD7nUv438wf2sQ3pBV6uiH8RrV4Td88H08XJ+8Khfc1EbDJQ2g1TpWRUZUwzf2qAbv6T9H2BoCG8uaQYGVuW3iJ85SGbPdZOgd5842Kt+kIdp1/YO2ApdMG8zjIPFxgSKHhWDg3BHFwRAYijmok0N64mbVaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115169; c=relaxed/simple;
	bh=8fDzET2DHAN8Coe05EG8PaKabIekv2IuAyKG6xpeMS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGlZ5wCNAI3GSw4N0NfOTLpMtI6dVRuUK51iIVzx+hcmMta4V7YNesYOzclBreDUR6rsHxD2ZBwJkcwsHkGUpShuEEupHlsk/+Zss0TUx8xz0gWVpwz75CY9xt6BMmh0LeBiMeYvSA61ArYRYCjnpcTmT3MOjKtF7L9B2S1QmIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y2I6/2WU; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <706bbb76-1204-4377-aeb8-0c1b21792014@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758115165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9QswkncU+CGDiwp7p0zaOAY3Ki4lJbtpA5gKQhu94o=;
	b=Y2I6/2WUOg6vSZuxcq6xNpgVJeuCh5jNqZQztf2duQDilHBJJUBfxaxjjF9q0V4A06szXK
	PtBGicahkDSZx6Brz9jGacqzxiUTpQroNZk+CWLICfTZ61TpVrv+kY6kFbE6jiQcPDNcog
	FfkcNO35jnoys04OeK0UShmDLogYogE=
Date: Wed, 17 Sep 2025 21:19:18 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] selftests/mm: skip soft-dirty tests when
 CONFIG_MEM_SOFT_DIRTY is disabled
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: shuah@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com
References: <20250917122750.36608-1-lance.yang@linux.dev>
 <ada1b1f9-bd2b-4164-ae8c-80264d4f6dc0@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <ada1b1f9-bd2b-4164-ae8c-80264d4f6dc0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/17 21:08, David Hildenbrand wrote:
> On 17.09.25 14:27, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> The madv_populate and soft-dirty kselftests currently fail on systems 
>> where
>> CONFIG_MEM_SOFT_DIRTY is disabled.
>>
>> Introduce a new helper softdirty_supported() into vm_util.c/h to ensure
>> tests are properly skipped when the feature is not enabled.
>>

Oops, I missed "Suggested-by:" here ... will add in v3.

>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/ 
>> selftests/mm/vm_util.c
>> index 56e9bd541edd..ac41d10454a5 100644
>> --- a/tools/testing/selftests/mm/vm_util.c
>> +++ b/tools/testing/selftests/mm/vm_util.c
>> @@ -449,6 +449,25 @@ bool check_vmflag_pfnmap(void *addr)
>>       return check_vmflag(addr, "pf");
>>   }
>> +bool softdirty_supported(void)
>> +{
>> +    char *addr;
>> +    bool supported = false;
>> +    const size_t pagesize = getpagesize();
>> +
>> +    /* New mappings are expected to be marked with VM_SOFTDIRTY (sd). */
>> +    addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
>> +            MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
>> +    if (!addr)
>> +        ksft_exit_fail_msg("mmap failed\n");
>> +
>> +    if (check_vmflag(addr, "sd"))
>> +        supported = true;
> 
> Reading the code again, this could just be
> 
> supported = check_vmflag(addr, "sd");

Nice. Will do ;)

> 
> 
> LGTM
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks,
Lance


