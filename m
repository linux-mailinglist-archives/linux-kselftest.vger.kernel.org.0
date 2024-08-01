Return-Path: <linux-kselftest+bounces-14602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396569446D0
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 10:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66412B22BD9
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDB916EB4F;
	Thu,  1 Aug 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hE2x18Wh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C616DC35;
	Thu,  1 Aug 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501745; cv=none; b=bWOcKh0rybkwLkvQ1GmqKgogWecoKNWEVnAzX/brH131Xup7y4gZ6Qb2Zpm07NBSzlnJZb6Whm4+kOg8EFd+rQxu7OzJvqVLu3OphdOyym5+J61Kus+IFyCGvi6jI2LTqDnpvl3zOC8KUXDBVQ1haPw83W03bFnYqzJ3qKTLW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501745; c=relaxed/simple;
	bh=fiIns+jg/oQOWQBs8nwFSYMltzIBy/DEywfrht+27e8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jdXDxUFgCTKkNk6v1uMPfnww/tE99P45D7hTG6kg28ZVyo0wCmypERFssRzjvM2R9iwy9+B98uvZd2gMXrN7SF22JkiS2vzApwv9DjS0zDl1gutqwObAfVMZ96EJ3A9SubTzGoYpMR6r/aoAHFGuO2yKmcLE6fBgPref2OjMkd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hE2x18Wh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722501741;
	bh=fiIns+jg/oQOWQBs8nwFSYMltzIBy/DEywfrht+27e8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=hE2x18Wh2fQLDLxRSmtrZf7SjkZWgMMI0jyxJl3H+r+LpfHJ8W/HAgshwvC+esoM4
	 mQMX5S+z4rYIPPTy/DQDZVAEw6gujEdvnYab8XCPp7W2UFQ/m1HEvTspOay2oOarcz
	 4Z0npQnfTP7LQsro3vJnOuhg9FR9EDfhsYwf7dDhLa+eY3/pj837cYthtByhELppOP
	 W9gg2J8VThb7QiGRrPuB8pA9kZsGdRhjZ87g4PXzceVXu0oouJGclob1xaqdhg+OKt
	 CAVy+Nu9IQHwUYXOmnoU1g1ShIkoUYcVj9G8OeI/ruRFPzI7REwWuW/PE/Cy2X4cgj
	 SdvkTNAlU1eLg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 28E343780520;
	Thu,  1 Aug 2024 08:42:18 +0000 (UTC)
Message-ID: <d30aa38c-5dbd-4c18-b20f-a6eb9e9e722b@collabora.com>
Date: Thu, 1 Aug 2024 13:42:15 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Aleksa Sarai <cyphar@cyphar.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: openat2: don't print total number of tests
 and then skip
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
References: <20240731133951.404933-1-usama.anjum@collabora.com>
 <c1414d9d-61b1-4f92-bc8a-333679362283@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <c1414d9d-61b1-4f92-bc8a-333679362283@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/31/24 9:57 PM, Shuah Khan wrote:
> On 7/31/24 07:39, Muhammad Usama Anjum wrote:
>> Don't print that 88 sub-tests are going to be executed, but then skip.
>> This is against TAP compliance. Instead check pre-requisites first
>> before printing total number of tests.
> 
> Does TAP clearly mention this?
Yes from https://testanything.org/tap-version-13-specification.html

Skipping everything
This listing shows that the entire listing is a skip. No tests were run.

TAP version 13
1..0 # skip because English-to-French translator isn't installed

We can see above that we need to print 1..0 and skip without printing the
total number of tests to be executed as they are going to be skipped.

> 
>>
>> Old non-tap compliant output:
>>    TAP version 13
>>    1..88
>>    ok 2 # SKIP all tests require euid == 0
>>    # Planned tests != run tests (88 != 1)
>>    # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>>
>> New and correct output:
>>    TAP version 13
>>    1..0 # SKIP all tests require euid == 0
> 
> The problem is that this new output doesn't show how many tests
> are in this test suite that could be run.
> 
> I am not use if this is better for communicating coverage information
> even if meets the TAP compliance.
I think the number of tests represents the number of planned tests. If we
don't plan to run X number of tests, we shouldn't print it.

> 
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Remove simplifying if condition lines
>> - Update the patch message
>> ---
>>   tools/testing/selftests/openat2/resolve_test.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/openat2/resolve_test.c
>> b/tools/testing/selftests/openat2/resolve_test.c
>> index bbafad440893c..85a4c64ee950d 100644
>> --- a/tools/testing/selftests/openat2/resolve_test.c
>> +++ b/tools/testing/selftests/openat2/resolve_test.c
>> @@ -508,12 +508,13 @@ void test_openat2_opath_tests(void)
>>   int main(int argc, char **argv)
>>   {
>>       ksft_print_header();
>> -    ksft_set_plan(NUM_TESTS);
>>         /* NOTE: We should be checking for CAP_SYS_ADMIN here... */
>>       if (geteuid() != 0)
>>           ksft_exit_skip("all tests require euid == 0\n");
>>   +    ksft_set_plan(NUM_TESTS);
>> +
>>       test_openat2_opath_tests();
>>         if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
> 
> thanks,
> -- Shuah
> 
> 

-- 
BR,
Muhammad Usama Anjum

