Return-Path: <linux-kselftest+bounces-13038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FAD91EFB0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 09:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BB11C21ED4
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 07:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F2084DF1;
	Tue,  2 Jul 2024 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vD4PPV+V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AE3EA69;
	Tue,  2 Jul 2024 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903787; cv=none; b=jDiM8Ax9TQPxRb7+8qDTRIbKrVkHB3oyIvEfoQWJF8yhGwWgADn9vZd+BzkDuWFFGya7Z7Odd3BlCw9S0QxdRpoRmg60LOch/a0X0W4hdLMEox8XleqIk5ZEsNIY3cv3EWCalgER15PvQfB5rnkG7dRtO4IHE/Rg+aiT884P6qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903787; c=relaxed/simple;
	bh=EAlAjTE2j2NEybWIE5qbIs3xbMTBjfZi56/puXkBahI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eAMPMFZVq/TxqlQY5JktBtwxaIAGBqn4lQ5IneSciYS75ahtMz1HnU4BhiS2YBzAEsJxrrgYkKeCWhQC/MbZ7VFUigGIbx3kLhbg6EvhV3gFVHS3KrdsjvXiOTU5O/9LxI8GsSDOYbnSmEmvrDFZCPaVivtpCxn5h0FRCA+2CxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vD4PPV+V; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719903783;
	bh=EAlAjTE2j2NEybWIE5qbIs3xbMTBjfZi56/puXkBahI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=vD4PPV+VAy1AfnhV3YBiwLWDu0KFg7QKNIrgmTnH+BwaCGXKmbVbowklokiQc0LAi
	 rzxYc3qX+SFZc8UY08f4TCbac2ZdFKap7R/Lj75xLjtOZACxnoFcddzXT3jibsAULw
	 A40RNCEOOh1z7gQf/R1NfTh/5oJ8YBMIHlL12xcJT1l/P+OwNGjfZ3AAepsRlB8YKu
	 i0+jMqgOj802ath3Py/ZSLkb6qe1K4b2jMYggAqfKtxCf99vbqRyrrU0NKTm1lo15z
	 F93SsUXqEX9jjRuiABKbgdsymwDp2XywWfUVguUzclK9SURw97VRokpcJG9uA58A0g
	 3CUyXS9LTDSFw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8BC973782139;
	Tue,  2 Jul 2024 07:02:59 +0000 (UTC)
Message-ID: <148d4c61-b60a-401f-96ee-b0291bcf87b3@collabora.com>
Date: Tue, 2 Jul 2024 12:02:54 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Al Viro <viro@zeniv.linux.org.uk>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: openat2: don't print total number of tests and
 then skip
To: Aleksa Sarai <cyphar@cyphar.com>
References: <20240522214647.3568788-1-usama.anjum@collabora.com>
 <1fc06a15-f06e-4db1-ace5-b9d52250d0df@collabora.com>
 <20240701.085146-junky.rubs.mossy.crews-uyuNIdHgWxb@cyphar.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240701.085146-junky.rubs.mossy.crews-uyuNIdHgWxb@cyphar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/24 2:14 PM, Aleksa Sarai wrote:
> On 2024-07-01, Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
>> Adding more people for review
>>
>> On 5/23/24 2:46 AM, Muhammad Usama Anjum wrote:
>>> Don't print that 88 sub-tests are going to be executed. But then skip.
>>> The error is printed that executed test was only 1 while 88 should have
>>> run:
>>>
>>> Old output:
>>>   TAP version 13
>>>   1..88
>>>   ok 2 # SKIP all tests require euid == 0
>>>   # Planned tests != run tests (88 != 1)
>>>   # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>>>
>>> New and correct output:
>>>   TAP version 13
>>>   1..0 # SKIP all tests require euid == 0
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>  tools/testing/selftests/openat2/resolve_test.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
>>> index bbafad440893c..5472ec478d227 100644
>>> --- a/tools/testing/selftests/openat2/resolve_test.c
>>> +++ b/tools/testing/selftests/openat2/resolve_test.c
>>> @@ -508,12 +508,13 @@ void test_openat2_opath_tests(void)
>>>  int main(int argc, char **argv)
>>>  {
>>>  	ksft_print_header();
>>> -	ksft_set_plan(NUM_TESTS);
>>>  
>>>  	/* NOTE: We should be checking for CAP_SYS_ADMIN here... */
>>> -	if (geteuid() != 0)
>>> +	if (geteuid())
> 
> This change isn't necessary, != 0 makes what we're checking clearer.
It is wasteful to write != 0 when you can achieve the same without it.

I can update the patch by removing it. Please can you provide a reviewed-by
tag for remaining patch?

> 
>>>  		ksft_exit_skip("all tests require euid == 0\n");
>>>  
>>> +	ksft_set_plan(NUM_TESTS);
>>> +
>>>  	test_openat2_opath_tests();
>>>  
>>>  	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
>>
>> -- 
>> BR,
>> Muhammad Usama Anjum
> 

-- 
BR,
Muhammad Usama Anjum

