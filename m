Return-Path: <linux-kselftest+bounces-28025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D60C5A4BD70
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 12:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84163A2CD6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 11:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CDB1F30DD;
	Mon,  3 Mar 2025 11:00:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57AB1EF0AA;
	Mon,  3 Mar 2025 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999654; cv=none; b=WMSaftljr8MBz/+Encz2g7SeQ/Yu0lCThtdTKDqxZx51WnQDV527ZDhbTNI5qYj6OmCrIbT3En1zJXSd0m8EzKKzyNEE/kJagAV9WX3XxU/7w207vh4rus+G9jKvaNGInzbp++BAGAaJ4gMNl2BB+hQGb4a0YuQN1bxqUSAhYNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999654; c=relaxed/simple;
	bh=AQzDbz27cyww8YaKKugmTRVzCm2lMH+Jzk/q4qDm4no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJARYJHWVHESpIThqLQl13jzuyPNvE4gUentBeBVWKXkReaVwPWpWgm+yVXWHjZXTVYFmj3U8JNeEL/0qX3RNt235F5ukVBSr1TckOG4cgon9Qyn5YdVQHpwoBuTq0ot2YRgdvoeIxQUCeUstVQqJ/ODMsFTiihkAnNgEaZUx8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23097113E;
	Mon,  3 Mar 2025 03:01:06 -0800 (PST)
Received: from [10.163.38.109] (unknown [10.163.38.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C3AA3F673;
	Mon,  3 Mar 2025 03:00:48 -0800 (PST)
Message-ID: <ca8d7011-5f5a-4270-af8e-44b37aff2bb4@arm.com>
Date: Mon, 3 Mar 2025 16:30:45 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] selftests/mm: Skip uffd-wp-mremap if userfaultfd
 not available
To: Brendan Jackman <jackmanb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-3-958e3b6f0203@google.com>
 <99739a23-9843-4c96-a614-ce2d48431a5c@arm.com> <Z8WJEsEAwUPeMkqy@google.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <Z8WJEsEAwUPeMkqy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+ Muhammad, I guess he has been working on selftests, maybe he can chime in.

On 03/03/25 4:18 pm, Brendan Jackman wrote:
> On Fri, Feb 28, 2025 at 10:55:00PM +0530, Dev Jain wrote:
>>
>>
>> On 28/02/25 10:24 pm, Brendan Jackman wrote:
>>> It's obvious that this should fail in that case, but still, save the
>>> reader the effort of figuring out that they've run into this by just
>>> SKIPping
>>>
>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>> ---
>>>    tools/testing/selftests/mm/uffd-wp-mremap.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
>>> index 2c4f984bd73caa17e12b9f4a5bb71e7fdf5d8554..c2ba7d46c7b4581a3c32a6b6acd148e3e89c2172 100644
>>> --- a/tools/testing/selftests/mm/uffd-wp-mremap.c
>>> +++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
>>> @@ -182,7 +182,10 @@ static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb
>>>    	/* Register range for uffd-wp. */
>>>    	if (userfaultfd_open(&features)) {
>>> -		ksft_test_result_fail("userfaultfd_open() failed\n");
>>> +		if (errno == ENOENT)
>>> +			ksft_test_result_skip("userfaultfd not available\n");
>>> +		else
>>> +			ksft_test_result_fail("userfaultfd_open() failed\n");
>>>    		goto out;
>>>    	}
>>>    	if (uffd_register(uffd, mem, size, false, true, false)) {
>>>
>>
>> I think you are correct, just want to confirm whether "uffd not available"
>> if and only if "errno == ENOENT" is true. That is,
>> is it possible that errno can be something else and uffd is still not
>> available,
> 
> Yeah, I strongly suspect this can happen. This is an attempt to
> improve things but I don't think it's a full solution.
> 
> I've been pondering this a bit and I think it's impractical to solve
> problems like this in the code of individual testst. I think the right
> thing to do is either:
> 
> 1. Have a centralised facility for detecting conditions like
>     "userfaultfd not available" that tests can just query it, so they
>     say something like:
> 
>     ksft_test_requires("userfaultfd");

Agreed, there should be a single point of reporting whether the facility 
is available.

> 
>     Which would do some sort of actual principled check for presence
>     and then skip the test with an informative message when it's not
>     there. There would be a list of these "system requirements" in the
>     code so you can easily see in one place what things might be needed
>     to successfully run all the tests.
> 
> or
> 
> 2. Specify out of band that there's a fixed set of requirements for
>     running the tests and document that you shouldn't run them without
>     satisfying them. Then just don't bother with SKIPs and call it user
>     error.
> 
>     This would require some reasonably usable tooling for actually
>     getting a system that satisfies the requirements.
> 
> But both of them require a deeper investment. I would quite like to
> explore option 1 a bit but that's for a future Brendan.
> 
> In the meantime I'm just trying to get these tests running on
> virtme-ng. (I'm not even gonna add all of them, because e.g. once I
> noticed this one I added a `scripts/config -e USERFAULTFD` to my
> script, so I won't notice if anything else is missing the check).
> 
>> or errno can be ENOENT even if uffd is available.
> 
> I think it's probably posible for this to happen too, e.g. if the
> system has a perverted /dev or something. But again I think that can
> only be solved with the kinda stuff I mentioned above.
> 
> Sorry for the essay :D


