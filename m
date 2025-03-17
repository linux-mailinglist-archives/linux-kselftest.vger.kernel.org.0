Return-Path: <linux-kselftest+bounces-29175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F675A63A5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 02:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50176188AADD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 01:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8729753E23;
	Mon, 17 Mar 2025 01:33:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 56AA3DF71;
	Mon, 17 Mar 2025 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742175238; cv=none; b=GkU2igZQnL4b87Ar4O5G5Wy9MXKcZq6bCzNl81G7hwM2qeVETu7CKIrpXQAIbZwuku7+KBu3u1d8NYY8ywf2Dkl74Ba2WAoz7GzjgXyhRmNUMXaWZ1kl8SMx5rkqEE1k8QYyilITb/wFNU1OdBILHsb88qm+a4UU0f5chpS7hDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742175238; c=relaxed/simple;
	bh=7mLWhIaj0gljG+t/JUlukM9ob5yv5rUFn/dW4zETZfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=OIQR46DN7+cmLNPsG8jEv2Tt+tyi2U1KgsKLf0CU+YjxMnOOryCJryFLi02PNDWRDBrwvSpPZ7CIDVHNJkEY1yYJ/Mo5Jf3L26V6Y33KQJ615gCNE85gk2FkX0XmuNLv1M+kgOOqdjHFRQuxFEgQfkheE5BG73fQt0L1GV+0NX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id F32BC6019982F;
	Mon, 17 Mar 2025 09:33:42 +0800 (CST)
Message-ID: <5d5caaea-4031-44a7-932e-2cf3f6fa4d6e@nfschina.com>
Date: Mon, 17 Mar 2025 09:33:42 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] selftests: ntsync: fix the wrong condition in
 wake_all
To: Elizabeth Figura <zfigura@codeweavers.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: shuah@kernel.org, wine-devel@winehq.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Language: en-US
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <1961744.6tgchFWduM@camazotz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/3/16 04:29, Elizabeth Figura wrote:
> On Saturday, 15 March 2025 04:39:46 CDT Dan Carpenter wrote:
>> On Fri, Mar 14, 2025 at 05:13:50PM -0500, Elizabeth Figura wrote:
>>> On Friday, 14 March 2025 05:14:30 CDT Su Hui wrote:
>>>> On 2025/3/14 17:21, Dan Carpenter wrote:
>>>>> On Fri, Mar 14, 2025 at 03:14:51PM +0800, Su Hui wrote:
>>>>>> When  'manual=false' and  'signaled=true', then expected value when using
>>>>>> NTSYNC_IOC_CREATE_EVENT should be greater than zero. Fix this typo error.
>>>>>>
>>>>>> Signed-off-by: Su Hui<suhui@nfschina.com>
>>>>>> ---
>>>>>>    tools/testing/selftests/drivers/ntsync/ntsync.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
>>>>>> index 3aad311574c4..bfb6fad653d0 100644
>>>>>> --- a/tools/testing/selftests/drivers/ntsync/ntsync.c
>>>>>> +++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
>>>>>> @@ -968,7 +968,7 @@ TEST(wake_all)
>>>>>>    	auto_event_args.manual = false;
>>>>>>    	auto_event_args.signaled = true;
>>>>>>    	objs[3] = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &auto_event_args);
>>>>>> -	EXPECT_EQ(0, objs[3]);
>>>>>> +	EXPECT_LE(0, objs[3]);
>>>>> It's kind of weird how these macros put the constant on the left.
>>>>> It returns an "fd" on success.  So this look reasonable.  It probably
>>>>> won't return the zero fd so we could probably check EXPECT_LT()?
>>>> Agreed, there are about 29 items that can be changed to EXPECT_LT().
>>>> I can send a v2 patchset with this change if there is no more other
>>>> suggestions.
>>> I personally think it looks wrong to use EXPECT_LT(), but I'll certainly
>>> defer to a higher maintainer on this point.
>> I'm not sure I understand what you are saying.  Are you saying that we
>> should allow zero as an expected file descriptor here?  I don't have
>> strong feelings about that either way.
> Yes, my apologies for the ambiguous wording. That is, EXPECT_LE looks more correct to me than EXPECT_LT per se.

Got it, I think there is no need for v2 patch that using EXPECT_LT(). 
Thanks for your feedback.

Su Hui


