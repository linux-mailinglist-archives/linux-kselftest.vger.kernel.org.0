Return-Path: <linux-kselftest+bounces-13451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D816492CE3B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 11:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1201F24006
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118AD13777F;
	Wed, 10 Jul 2024 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d+aJps+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B9917FD;
	Wed, 10 Jul 2024 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604004; cv=none; b=ZJFq14uu7tRcnULjM3BKw46ZyyeUtC0qNLTCkM9EW7BgA8VJVOsWXkuR5/XX1hOsQnDmQ/D909+c7CY1Bt03THfKKvxnKfA+9lljZ/3WcW/TdnBLYtPlBOIhQS9r3JqE7NLR20zeSeoCQylhO1qjZK8J5Th62ib9XSqPMqtXDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604004; c=relaxed/simple;
	bh=nyA+aLyLy4sj1aJoJsMA+CGYqE6Xy/V4qF0PTdcoHL8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W2xcWFkdAGdUTZ8TG++a4jYTGGBVJkPtIe00euLxe18QVcMiUgGTUwYzkjrSm/uUMs/5j64MHgsiWmTE5IsAO77EWm94gj38s2chrDM+ey0aJwy38W6qS2XA/qAWwGFO52krbLHnf0SQsxAi9bZvhTYXs4JN4o2wtrEuavr/bYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d+aJps+z; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720604000;
	bh=nyA+aLyLy4sj1aJoJsMA+CGYqE6Xy/V4qF0PTdcoHL8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=d+aJps+zhYPUwSrloLSTontwTOF3pNIOG9i647w/uZHpb68CCwSbGM4yIfRW7LQ/S
	 3pa7Hr5kB6404AAisO7dAExh/DLAzaKKa4y7KNALC7D0k3q5mPbuGWtrLnWgYOD0ik
	 Zmg/HVVDA1+uMM/TFWe++jK6JfxUHBwB7ry9bo1DDlASVX8MhWzSHP/vAMPqYh+GQd
	 yQD4ijsW6TkFN/xabxbs2oY3wQws9JDKBwtr+V4gsa9AkM4FvcfUaOVpDtTthlOCQn
	 6thI0MPGM5tcbkAER2OkOiexL8i/TW15GRrRxw92FmroV+MA3b9okGepwm4YVf1bp/
	 pgwPdDO050Gag==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 759623782192;
	Wed, 10 Jul 2024 09:33:14 +0000 (UTC)
Message-ID: <c0007f80-d44b-42fa-afd4-fdaeb3b89f70@collabora.com>
Date: Wed, 10 Jul 2024 14:33:08 +0500
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
 Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH] selftests: openat2: don't print total number of tests and
 then skip
To: Shuah Khan <shuah@kernel.org>
References: <20240522214647.3568788-1-usama.anjum@collabora.com>
 <1fc06a15-f06e-4db1-ace5-b9d52250d0df@collabora.com>
 <20240701.085146-junky.rubs.mossy.crews-uyuNIdHgWxb@cyphar.com>
 <148d4c61-b60a-401f-96ee-b0291bcf87b3@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <148d4c61-b60a-401f-96ee-b0291bcf87b3@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shuah,

Can you take the patch as is or by removing following from this patch:

-	if (geteuid() != 0)
+	if (geteuid())

Thanks,
Usama

On 7/2/24 12:02 PM, Muhammad Usama Anjum wrote:
> On 7/1/24 2:14 PM, Aleksa Sarai wrote:
>> On 2024-07-01, Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
>>> Adding more people for review
>>>
>>> On 5/23/24 2:46 AM, Muhammad Usama Anjum wrote:
>>>> Don't print that 88 sub-tests are going to be executed. But then skip.
>>>> The error is printed that executed test was only 1 while 88 should have
>>>> run:
>>>>
>>>> Old output:
>>>>   TAP version 13
>>>>   1..88
>>>>   ok 2 # SKIP all tests require euid == 0
>>>>   # Planned tests != run tests (88 != 1)
>>>>   # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>>>>
>>>> New and correct output:
>>>>   TAP version 13
>>>>   1..0 # SKIP all tests require euid == 0
>>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>>  tools/testing/selftests/openat2/resolve_test.c | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
>>>> index bbafad440893c..5472ec478d227 100644
>>>> --- a/tools/testing/selftests/openat2/resolve_test.c
>>>> +++ b/tools/testing/selftests/openat2/resolve_test.c
>>>> @@ -508,12 +508,13 @@ void test_openat2_opath_tests(void)
>>>>  int main(int argc, char **argv)
>>>>  {
>>>>  	ksft_print_header();
>>>> -	ksft_set_plan(NUM_TESTS);
>>>>  
>>>>  	/* NOTE: We should be checking for CAP_SYS_ADMIN here... */
>>>> -	if (geteuid() != 0)
>>>> +	if (geteuid())
>>
>> This change isn't necessary, != 0 makes what we're checking clearer.
> It is wasteful to write != 0 when you can achieve the same without it.
> 
> I can update the patch by removing it. Please can you provide a reviewed-by
> tag for remaining patch?
> 
>>
>>>>  		ksft_exit_skip("all tests require euid == 0\n");
>>>>  
>>>> +	ksft_set_plan(NUM_TESTS);
>>>> +
>>>>  	test_openat2_opath_tests();
>>>>  
>>>>  	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
>>>
>>> -- 
>>> BR,
>>> Muhammad Usama Anjum
>>
> 

-- 
BR,
Muhammad Usama Anjum

