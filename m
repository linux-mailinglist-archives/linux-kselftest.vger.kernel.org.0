Return-Path: <linux-kselftest+bounces-5891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 610CC8715D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 07:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AEF3B2315D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 06:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F3F7E103;
	Tue,  5 Mar 2024 06:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f0vPPKX0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBFB28E3F;
	Tue,  5 Mar 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619991; cv=none; b=YYo9/vHqiQEl2hxT+lVEsXDhumzZJoKAuW+CPJI5ekSZJI6/iBo0RTRooNqNZKhu2jXpaNk/DW+FfsvBtszomQEFT2Ekkgk1HxJjtzLBso+zaNgOuRgw1mdzigsm7KZJon4Mq/Ji+WF5lxHm7OfwvYb7vEbWmwHyYlj/L05N6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619991; c=relaxed/simple;
	bh=5a8HIqzrX82rzPacl8CmdfWgBErNrkuXsBd+I+i7i5o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lWYUUOEYmxwTlGaV4CFVMI4I8VYAzxRNc8QvhylxChEVTZd3K9mpgdeXP8PYOtNSA4qupaFaNfeLZ2NuqidWP9oGsTJQWdP4OJZXwwcnLs9ef5/7Zidpczx4rvU0FB0zG0GdYYeuVanit3YOd7WcWNzPwGK7iYHzFd/52cXAbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f0vPPKX0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709619988;
	bh=5a8HIqzrX82rzPacl8CmdfWgBErNrkuXsBd+I+i7i5o=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=f0vPPKX052JKjEAwY+97iWsrSxbgUxxKmcdpt7tOotAlwStsiTUwAH84ciL0tuyUa
	 F+zpwzZ0PgKvhmbJGx7loz5Dg3TCIyRZaJcpLFcQQ4ILvrPBptHyojVA5AWs00TV5B
	 Ex9OUCMQmS7vUrTC/qpScZjo1ambv9l87q494Xcw6PBbLyGwgglnBcVi1OpXX39Yug
	 klyKXGk9QRjjfN41b4pFpgzOA2nMsQ74dRLcnOVY7vpLMUCUyGFoAQrxEzuG06HJXW
	 vkQH0PWlBL3TZkxhNdnOLqh17D5WjdoyVkfapYdKq/86ApKfBTmIcV5MVSrTmsSqvR
	 BXwl8D+uiWqYg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E4B1F3782073;
	Tue,  5 Mar 2024 06:26:25 +0000 (UTC)
Message-ID: <2fc8f4d5-0906-46dd-8b71-9425dc96b000@collabora.com>
Date: Tue, 5 Mar 2024 11:26:52 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Eric Biederman <ebiederm@xmission.com>, kernel@collabora.com,
 kernel-janitors@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] selftest/exec: conform test to TAP format output
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
References: <20240304155928.1818928-1-usama.anjum@collabora.com>
 <20240304155928.1818928-2-usama.anjum@collabora.com>
 <202403041256.80EDE9BA2@keescook>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <202403041256.80EDE9BA2@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 1:58 AM, Kees Cook wrote:
> On Mon, Mar 04, 2024 at 08:59:24PM +0500, Muhammad Usama Anjum wrote:
>> Conform the layout, informational and status messages to TAP. No
>> functional change is intended other than the layout of output messages.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  tools/testing/selftests/exec/load_address.c | 34 +++++++++------------
>>  1 file changed, 15 insertions(+), 19 deletions(-)
>>
>> diff --git a/tools/testing/selftests/exec/load_address.c b/tools/testing/selftests/exec/load_address.c
>> index d487c2f6a6150..17e3207d34ae7 100644
>> --- a/tools/testing/selftests/exec/load_address.c
>> +++ b/tools/testing/selftests/exec/load_address.c
>> @@ -5,6 +5,7 @@
>>  #include <link.h>
>>  #include <stdio.h>
>>  #include <stdlib.h>
>> +#include "../kselftest.h"
>>  
>>  struct Statistics {
>>  	unsigned long long load_address;
>> @@ -41,28 +42,23 @@ int main(int argc, char **argv)
>>  	unsigned long long misalign;
>>  	int ret;
>>  
>> +	ksft_print_header();
>> +	ksft_set_plan(1);
>> +
>>  	ret = dl_iterate_phdr(ExtractStatistics, &extracted);
>> -	if (ret != 1) {
>> -		fprintf(stderr, "FAILED\n");
>> -		return 1;
>> -	}
>> +	if (ret != 1)
>> +		ksft_exit_fail_msg("FAILED: dl_iterate_phdr\n");
> 
> I'm for this series, but I do note a weird glitch in the ksft API.
> ksft_exit_fail_msg does:
> 
>         va_start(args, msg);
>         printf("Bail out! ");
>         errno = saved_errno;
>         vprintf(msg, args);
>         va_end(args);
> 
> "Bail out!" is not very descriptive. I think I'd rather this should be:
> 
> 	"FAILED: "
> 
> and then that added prefix doesn't need to be added everywhere in this
> patch, nor the "error: " prefix in the next patch.
If we want to make this change, FAILED should be removed from all the
tests. We should do it in separate patch. I've taken note and will do it
separate from this series.

-- 
BR,
Muhammad Usama Anjum

