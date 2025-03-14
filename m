Return-Path: <linux-kselftest+bounces-29023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3226A60EB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 11:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBF74616E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 10:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDCA1F3BAC;
	Fri, 14 Mar 2025 10:23:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 79CF61F4281;
	Fri, 14 Mar 2025 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947813; cv=none; b=onCVgM6r6R2XfLMPuFaEA2oq0ObQoCVdYuC8+EZnu72MqF2n8vlT0tV90dlUyOfhSRjw2kOxmEGHVTNOu2jdLdJ2VjjJrvxiHY2yiD/ZyOFqAa3etljZbLXwDvLxc3FlQMXo/CFbWb93zEqykqKCy4drBgeH7dA6gh8ex9+L7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947813; c=relaxed/simple;
	bh=1Rvm+bbQVb1ulpBi+GfDKCzq8OJ76Qm+O8qoLIRL7YQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type; b=THykp7F0ju3szjdxx4KZu1YtpMXeWBiRPI6wtKgsbFU+fnbhwY8DbRVl2MHNYutrj2XSAfjA3jQ/FrvmZ1UO+7T4ukGMpduvcbdFcjX0b2NRDxgg4f/YgeEYwb6oJWhMAH+vopwnrlYNIk4pVTZDGduHqaq6XiLuQXQmos5t8AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 1B7BD606FFD51;
	Fri, 14 Mar 2025 18:23:26 +0800 (CST)
Message-ID: <b8e5405f-fd79-49df-a3d3-ca10fdeee094@nfschina.com>
Date: Fri, 14 Mar 2025 18:23:25 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] selftests: ntsync: fix the wrong condition in
 wake_all
Content-Language: en-US
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: zfigura@codeweavers.com, shuah@kernel.org, wine-devel@winehq.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
In-Reply-To: <00d17d6d-19c9-4431-a3ac-c0f767c533d4@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/3/14 18:14, Su Hui wrote:
> On 2025/3/14 17:21, Dan Carpenter wrote:
>> On Fri, Mar 14, 2025 at 03:14:51PM +0800, Su Hui wrote:
>>> When  'manual=false' and  'signaled=true', then expected value when using
>>> NTSYNC_IOC_CREATE_EVENT should be greater than zero. Fix this typo error.
>>>
>>> Signed-off-by: Su Hui<suhui@nfschina.com>
>>> ---
>>>   tools/testing/selftests/drivers/ntsync/ntsync.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
>>> index 3aad311574c4..bfb6fad653d0 100644
>>> --- a/tools/testing/selftests/drivers/ntsync/ntsync.c
>>> +++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
>>> @@ -968,7 +968,7 @@ TEST(wake_all)
>>>   	auto_event_args.manual = false;
>>>   	auto_event_args.signaled = true;
>>>   	objs[3] = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &auto_event_args);
>>> -	EXPECT_EQ(0, objs[3]);
>>> +	EXPECT_LE(0, objs[3]);
>> It's kind of weird how these macros put the constant on the left.
>> It returns an "fd" on success.  So this look reasonable.  It probably
>> won't return the zero fd so we could probably check EXPECT_LT()?
> Agreed, there are about 29 items that can be changed to EXPECT_LT().
> I can send a v2 patchset with this change if there is no more other
> suggestions.

Sorry for the wrong style of email:(.

Su Hui


