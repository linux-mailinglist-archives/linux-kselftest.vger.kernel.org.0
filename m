Return-Path: <linux-kselftest+bounces-8354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B84D8AA10D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 19:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7A61F22097
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 17:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25148173359;
	Thu, 18 Apr 2024 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kRuaGJy0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70523171085;
	Thu, 18 Apr 2024 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461239; cv=none; b=SRYx8N0uPrOR8lteKce4gRG6VdjA7PHJfCL5P3ZCuw0MCcR6g41py/Bn4uIt+nPtBQPO+o2ZAH149CAvLYWPfFvuO7XigG9NtJGgJ7q5OzFTejZnpG+Y+7hSVWWynhEv+Ay/iPY8HEeZAwFQ6+vSwB2uNbAB8UbO5bREqvjzXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461239; c=relaxed/simple;
	bh=HVXdP9+hdhPa8t0waMIBMqruj5ig5/COewl3jY0u/u0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f13KDrMNLT5FtIrbt4Eq40I0Dn1ZsFcuyA0OQKn8lna5jPhcwL2O3QCoX7mokDMgHaqVR/KHqrd+gEDq3NXzcGon91BlIgexl5mMiOtkGZXDT7Fx6vjU+91CLnP76pw9CtI4x/Ckn3z6Es1aZiLiWxhsRIPKoPFCB+REUdoVo90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kRuaGJy0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713461235;
	bh=HVXdP9+hdhPa8t0waMIBMqruj5ig5/COewl3jY0u/u0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kRuaGJy0ZsiFIrzLhYIk20HwhjjEwqSqBNszu7ky4ue1t9t8soJjdiqtV2Mxwdfo3
	 BwoWC4eps1qGzic59IBvclqfPbNmU1B32aZJAWibvncEQ378/7T+FIzEwqprvveVVz
	 SAWW4N4ingLQTSa1/k40bzGBAZfXNmhl5FVeHNVszZhzxs3OpyFWANj5U/ycz53V+V
	 S/R1MzbRU/QN/Bfr14rwVwhF2FPliE6MvN9NWThnXy3d6IU1RvVYqUV+hXhPZcCUB6
	 YmPtUxZ/xNs24Bhg4m/VRaFx/oI3NURqTOHUNrJDL9J2IbWCc1sQfbqd9Z/NMPAwqe
	 QvRtImGGjADzQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 981C037813E3;
	Thu, 18 Apr 2024 17:27:10 +0000 (UTC)
Message-ID: <bfe97309-f9d6-4ca8-8e68-da9fa584c5ef@collabora.com>
Date: Thu, 18 Apr 2024 22:25:05 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 kernel@collabora.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: mm: restore settings from only parent process
To: Joey Gouly <joey.gouly@arm.com>
References: <20240314094045.157149-1-usama.anjum@collabora.com>
 <20240418125250.GA2941398@e124191.cambridge.arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240418125250.GA2941398@e124191.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/24 5:52 PM, Joey Gouly wrote:> Hi again,
> 
> On Thu, Mar 14, 2024 at 02:40:45PM +0500, Muhammad Usama Anjum wrote:
>> The atexit() is called from parent process as well as forked processes.
>> Hence the child restores the settings at exit while the parent is still
>> executing. Fix this by checking pid of atexit() calling process and only
>> restore THP number from parent process.
>>
>> Fixes: c23ea61726d5 ("selftests/mm: protection_keys: save/restore nr_hugepages settings")
>> Tested-by: Joey Gouly <joey.gouly@arm.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  tools/testing/selftests/mm/protection_keys.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
>> index f822ae31af22e..374a308174d2b 100644
>> --- a/tools/testing/selftests/mm/protection_keys.c
>> +++ b/tools/testing/selftests/mm/protection_keys.c
>> @@ -1745,9 +1745,12 @@ void pkey_setup_shadow(void)
>>  	shadow_pkey_reg = __read_pkey_reg();
>>  }
>>  
>> +pid_t parent_pid;
>> +
>>  void restore_settings_atexit(void)
>>  {
>> -	cat_into_file(buf, "/proc/sys/vm/nr_hugepages");
>> +	if (parent_pid == getpid())
>> +		cat_into_file(buf, "/proc/sys/vm/nr_hugepages");
>>  }
>>  
>>  void save_settings(void)
>> @@ -1773,6 +1776,7 @@ void save_settings(void)
>>  		exit(__LINE__);
>>  	}
>>  
>> +	parent_pid = getpid();
>>  	atexit(restore_settings_atexit);
>>  	close(fd);
>>  }
> 
> After more testing, this is not actually enough. It passes sometimes, which is
> why I gave my Tested-by, but it can still fail the same way as I originally
> said.
> 
> assert() at protection_keys.c::812 test_nr: 19 iteration: 1
> running abort_hooks()...
> errno at assert: 12
> 
> I think the parent process needs to wait for all it's child processes (recursively).
> This is due to the test_pkey_alloc_exhaust() calling become_child(), where it
> exits, and that exit may be from the original PID.
Thanks for reporting. I'll have a look at it.

> 
> Thanks,
> Joey

-- 
BR,
Muhammad Usama Anjum

