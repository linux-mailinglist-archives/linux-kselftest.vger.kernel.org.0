Return-Path: <linux-kselftest+bounces-13132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0CC9263C8
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 16:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C431F22E7D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431C8175555;
	Wed,  3 Jul 2024 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IPLvQ85f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46674409;
	Wed,  3 Jul 2024 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018143; cv=none; b=iGh6dFVu68C/9F8rnbCDEeosFSFYmRuyWzzMB1+vKvXWZ93Wg/CAxx3h0JdOvzNhiDjqZlWsY1MgZ/8misMERF4A1coxV9772tQnbv6sTVGgexJfUyTwbadx6drb8HeZ7qnL7tCpCIgiYVg9U2pvmZOiSHOLSR1EAPqogIv9G9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018143; c=relaxed/simple;
	bh=25gu+WwJyKTENkTQ95Kbel2+YZEIEeQcyr6d71uuPZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrlFIEQ0yjiapRa6oeBQMphBumDIrihyJJpQnsNZr1dIlJO41a2Jd6BIqrSpNM+SKpeRKMGY2TIYERnGkFopQCLJaEhIY74iWC3u/3JMf/oZS8IX/c45lL8rtemAzzPgRq306u4TKCgnFnlIAYk5xOErBMvoV0UGJLBD4UCe4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IPLvQ85f; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720018140;
	bh=25gu+WwJyKTENkTQ95Kbel2+YZEIEeQcyr6d71uuPZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IPLvQ85fDUBG6WUqxP4baLVBBw9HqvANb4ABZVqsBwDWzDmmFdZCSYkQjdPwoKESQ
	 NeBb+v5+sNVfbIh9BVTMOt0PiYcvuX35R97rcPomUycXMNMauAMyeh/EhTjU2ytB7i
	 qHE5zYKEmDAW3JvBqPQALW7pWclzWz9P9ts5vY42qYhpzqXihFFOWfNwVXkrsunA0L
	 OlB9B5/za081GEmvS+0xobP34n098XVyncX8qwA1LhvEToZ7+cocMA1eZrBdC+GD8H
	 t9EffZHaQZ95xJE94pQKzQpDTkdrKlJ8/kSYVJBES5lQR8/yv+0IE30Kx7NTQCbQxm
	 l+nn06ufPBeYw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A869F37821A0;
	Wed,  3 Jul 2024 14:48:59 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: skhan@linuxfoundation.org
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH 2/2] selftests/watchdog: convert the test output to KTAP format
Date: Wed,  3 Jul 2024 16:49:29 +0200
Message-Id: <20240703144929.89966-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <8facf491-3c4c-4efb-8a14-f34011ffe011@linuxfoundation.org>
References: <8facf491-3c4c-4efb-8a14-f34011ffe011@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 6/27/24 20:41, Shuah Khan wrote:
> On 5/6/24 05:13, Laura Nao wrote:
>> Modify the script output to conform to the KTAP format standard. The
> 
> What is script here?
> 

I was referring to the watchdog-test.c file addressed in this patch. I 
understand this could be confusing, I will rephrase the commit message 
to avoid ambiguity.

>> number of tests executed is determined by the script arguments, and
>> options such as -c, -f, -h, -i, and -p do not impact the total test
>> count.
>>
>> No functional change is intended.
> 
> There are functional changes - keep_alive() coupled with changes
> tailored by a script that isn't in the kernel code which isn't
> ideal.
> 
> Why not inlcude the script in this patch series to make it part
> of the kernel?
> 

Right, I'll remove the 'no functional change is intended' sentence from 
the commit message.

Apart from the patches already in this series, no other script is 
required to run the test in a CI environment.

>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>   .../selftests/watchdog/watchdog-test.c        | 154 ++++++++++--------
>>   1 file changed, 89 insertions(+), 65 deletions(-)
>>
>> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c 
>> b/tools/testing/selftests/watchdog/watchdog-test.c
>> index 786cc5a26206..90f32de9e194 100644
>> --- a/tools/testing/selftests/watchdog/watchdog-test.c
>> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
>> @@ -22,6 +22,7 @@
>>   #include <sys/ioctl.h>
>>   #include <linux/types.h>
>>   #include <linux/watchdog.h>
>> +#include "../kselftest.h"
>>   #define DEFAULT_PING_RATE    1
>>   #define DEFAULT_PING_COUNT    5
>> @@ -29,6 +30,7 @@
>>   int fd;
>>   const char v = 'V';
>>   static const char sopts[] = "bdehp:c:st:Tn:NLf:i";
>> +static const char topts[] = "bdeLn:Nst:T";
>>   static const struct option lopts[] = {
>>       {"bootstatus",          no_argument, NULL, 'b'},
>>       {"disable",             no_argument, NULL, 'd'},
>> @@ -52,7 +54,7 @@ static const struct option lopts[] = {
>>    * the PC Watchdog card to reset its internal timer so it doesn't 
>> trigger
>>    * a computer reset.
>>    */
>> -static void keep_alive(void)
>> +static int keep_alive(void)
>>   {
>>       int dummy;
>>       int ret;
>> @@ -60,6 +62,8 @@ static void keep_alive(void)
>>       ret = ioctl(fd, WDIOC_KEEPALIVE, &dummy);
>>       if (!ret)
>>           printf(".");
>> +
>> +    return ret;
>>   }
> 
> Are these changes driven by the script that isn't in the kernel code?
> I don't want to see changes to keep_alive() bevator.
> 

These changes are not driven by any external script; the aim of this
patch is just to conform the output to KTAP for easier parsing of the
results in CI environments.

Returning ret from keep_alive() allows to track the result for
the last WDIOC_KEEPALIVE ioctl and report it to the user through 
ksft_test_result, analogously to other ioctls tested in this
same file.

Thanks,

Laura

