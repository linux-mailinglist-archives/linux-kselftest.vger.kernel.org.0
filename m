Return-Path: <linux-kselftest+bounces-2656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C898250D1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 10:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95601F26AD0
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3155522F14;
	Fri,  5 Jan 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gfTWmx/m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A019322F0F;
	Fri,  5 Jan 2024 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704446742;
	bh=aZ24zcBNKaJWIP6FIosOv98hUbWGf/qfduS2Lt50+u8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gfTWmx/m79YffnnCgz2j578ddiq6sAR84RXRB8urhecA3V93DARdufy39XA2Yk1OA
	 QoBb+SUTeIaxDS81yHx/Jz4YNxIy7d0MDLjskXEeEzIkcrxqOc10qz46u4kDEhzVqI
	 +AZYq2m4E9l6CpN8e+rIOP4jtuxRkeQo3ubFHaKnFUQV8kiXZBa6dnpdFMi8p3Hcds
	 2YQz3T0emju6u7kOO3dtgKQPGeQO6mOxJfE4lpvNkhUCldKJjEq95tMOF7HWmlbsLH
	 qU/zNdCP2ibpxaFuBPXmThXpNbWPx0mOpZfe9K4iqlrgRGNmmi6jDRwdoBEeuEhBe+
	 MzTurirxZ6RCQ==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7AA4A378003D;
	Fri,  5 Jan 2024 09:25:40 +0000 (UTC)
Message-ID: <02392379-2fe3-460c-bf38-c24e7c974297@collabora.com>
Date: Fri, 5 Jan 2024 14:25:44 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 Aishwarya TCV <aishwarya.tcv@arm.com>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: core: include linux/close_range.h for
 CLOSE_RANGE_* macros
Content-Language: en-US
To: Shuah Khan <shuah@kernel.org>
References: <20231024155137.219700-1-usama.anjum@collabora.com>
 <9dbda2f9-2bb2-4e79-976a-12856ab6936a@collabora.com>
 <2180095f-1dcd-4542-aafe-aa2b4d039e62@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <2180095f-1dcd-4542-aafe-aa2b4d039e62@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kind reminder

On 12/11/23 4:01 PM, Muhammad Usama Anjum wrote:
> Soft reminder
> 
> On 11/29/23 4:34 PM, Muhammad Usama Anjum wrote:
>> Soft reminder
>>
>> On 10/24/23 8:51 PM, Muhammad Usama Anjum wrote:
>>> Correct header file is needed for getting CLOSE_RANGE_* macros.
>>> Previously it was tested with newer glibc which didn't show the need to
>>> include the header which was a mistake.
>>>
>>> Fixes: ec54424923cf ("selftests: core: remove duplicate defines")
>>> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
>>> Link: https://lore.kernel.org/all/7161219e-0223-d699-d6f3-81abd9abf13b@arm.com
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>  tools/testing/selftests/core/close_range_test.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
>>> index 534576f06df1c..c59e4adb905df 100644
>>> --- a/tools/testing/selftests/core/close_range_test.c
>>> +++ b/tools/testing/selftests/core/close_range_test.c
>>> @@ -12,6 +12,7 @@
>>>  #include <syscall.h>
>>>  #include <unistd.h>
>>>  #include <sys/resource.h>
>>> +#include <linux/close_range.h>
>>>  
>>>  #include "../kselftest_harness.h"
>>>  #include "../clone3/clone3_selftests.h"
>>
> 

-- 
BR,
Muhammad Usama Anjum

