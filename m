Return-Path: <linux-kselftest+bounces-18019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AD6979B35
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 08:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E231C229AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 06:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27853D0A9;
	Mon, 16 Sep 2024 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="XPMjxyGx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4C522A;
	Mon, 16 Sep 2024 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726468461; cv=pass; b=QPzJ/pp6IHp//f1tSWeIJe9bIKpuv/UQMT/i29i88eN1Lj7k4lvdDtD8wmGwO0ifvrPVVAliVWRF9whCchCc9OmfHLucnpkopncr00bj4u0i363wDLPRnei2jNFA1XhcS66P92VZCtu8kJPzXZk5hfpqx2BUdbKPjCBUScABQ0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726468461; c=relaxed/simple;
	bh=QBK85ORC+DlGDLML6QniSDfNtTcwsDXZAQ8tT4dJpJ8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uWGDpN+qqpUhU0jZ8lI2iVRjpVBLTibpmnZfmXzaRxQIJZ91fiKAN7Bj/UVDGMUDaFlXOBNICWbbRyWe9obE9CUwEo4CY5JZyErh2scYNM0YcRxa7MI086VKDvOaIcy5Xhv2leaTOIOPpRqptBnBMJTSdvM+MvryHVXgY/XnlmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=XPMjxyGx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726468447; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OGvm7ygvNmrVcMUH3uk/1Ygh3LpR+kRy9v3hEP5a6stjVmEdIiDJDGxkRahnXF0y/ynakkv1s7aW9/UfP3dIIwnHoh2kvlXYZimvf36nJEosLXum9tA3A0SJ3pa0/YEtnGnC1WnZrb7wIm988Oce/ODsZl/5LQ2Arxlu1s0Rjxc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726468447; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=43RYhMal7eFWDuospxEJRYGHTyjhRWaw1O4eSzjv+Zk=; 
	b=HLH8GeLCiQUMGzT2IUbSDAUCxN2Yv05AtbeO++lgcTifwz+xA/MOGGZF5G051GM8AzHlePopRxbznSVHOgf1NsxauBHyGYhvkwtl1L7GPo3X2YCbuVIu4anyLx+W27l1JpxCgXy4No6AupnUks34xn9r1h1UiaX6EchZbriSIN4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726468447;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=43RYhMal7eFWDuospxEJRYGHTyjhRWaw1O4eSzjv+Zk=;
	b=XPMjxyGxnAy9z6Czv46dQNk07NPfKnuQEF13B4wcGAHKvMSnxDS9N8xYdk0KayQr
	8sM4XHLweL4+BrPyoPK6xSyUQwoiNs30NauhM7XKYxhKSuOKWwP9DV78LNb276b7pC+
	LXuPPO6Xr/XYyhImxAtJKPBDm/8trc+q6vXzFGPY=
Received: by mx.zohomail.com with SMTPS id 1726468445372886.5813772455704;
	Sun, 15 Sep 2024 23:34:05 -0700 (PDT)
Message-ID: <2f6cfc9b-4f3b-4f64-9c4d-63e3453b3105@collabora.com>
Date: Mon, 16 Sep 2024 11:33:58 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kselftests: mm: Fail the test if userfaultfd syscall
 isn't found
To: Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20240912103151.1520254-1-usama.anjum@collabora.com>
 <20240912103151.1520254-2-usama.anjum@collabora.com>
 <3b700650-159d-45ad-91a3-59fca3019766@linuxfoundation.org>
 <35f21581-71f3-4234-9b03-dd3e3bda664f@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <35f21581-71f3-4234-9b03-dd3e3bda664f@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 9/12/24 10:28 PM, Shuah Khan wrote:
> On 9/12/24 10:10, Shuah Khan wrote:
>> On 9/12/24 04:31, Muhammad Usama Anjum wrote:
>>> The userfaultfd is enabled in the config fragment of mm selftest suite.
>>> It must always be present. If it isn't present, we should throw error
>>> and not just skip. This would have helped us catch the test breakage.
>>
>> Please elaborate on this to help understand the what breakage was
>> missed.
>>
>> Also this commit log doesn't look right to me. syscall() could
>> fail for any reason. Do you mean to see skip is incorrect in this
>> error leg? Please see comments below.
>>
>>> Adding this now to catch the future breakages.
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>   tools/testing/selftests/mm/pagemap_ioctl.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c
>>> b/tools/testing/selftests/mm/pagemap_ioctl.c
>>> index bcc73b4e805c6..d83dda8edf62c 100644
>>> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
>>> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
>>> @@ -95,7 +95,7 @@ int init_uffd(void)
>>>       uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK |
>>> UFFD_USER_MODE_ONLY);
>>>       if (uffd == -1)
>>> -        return uffd;
>>> +        ksft_exit_fail_perror("Userfaultfd syscall failed");
>>
>> This looks wrong to me - Is missing config the only reason this syscall
>> would fail?
> 
> It should still skip if __NR_userfaultfd isn't supported on a release
> or an architecture.
> 
> The real problem seems to be in main():
> 
> if (init_uffd())
>                 ksft_exit_pass();
> 
> 
> Why is this ksft_exit_pass()? Looks like further investigation is
> necessary to understand the problem and fix.
Let's skip this patch as it'll create more noise on unsupported
architectures than catching failures on supported architectures.

> 
> thanks,
> -- Shuah

-- 
BR,
Muhammad Usama Anjum


