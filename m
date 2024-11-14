Return-Path: <linux-kselftest+bounces-22048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6CE9C908A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 18:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA2E1F22495
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 17:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C2F188713;
	Thu, 14 Nov 2024 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="go291JaB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27FD6F307
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604120; cv=none; b=UJl1Uw5p32xpVc6MR5OVKLiCUHfqgqFyF73tCSagBHFxx1Yc7OVe2bYA4eA/S6TnzfrVavSyY/aK4DAzwBlT5S+o/oC6FueJGSxf1m2T33+Sfd3cSd0ioGRIBFD7kat3nGlLt+0YI1733fOeJmmOjfnzwUfUPVQ2ds1IavjvG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604120; c=relaxed/simple;
	bh=yHELOSQhvvHp71OtVk5swb+nNSN0zFC0SuN+AIziXeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZ4DncFIfikQPK+HLET6Khvh+x9A4Jau8g7C5WRPIKl8fTJQIamR4RHFuY9ukg4XpI9b3R0OSl194VQ4++/0BG903gZAmbpVCiSnKjzOUjAySRb63uODsb7aeZut9jhLYJgtAcwmUonypVwKjdxyFZmmJJzbT76s+9yJkmk/25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=go291JaB; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-83b430a4cfdso29673039f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 09:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731604117; x=1732208917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytkqD9XI/BHqVrDHS/oEUwpMJruMLfeh9lCP9HUJDm8=;
        b=go291JaBO/0KbNcbkIzVP4uTa0mUQhOk+u1vrgy/NE0lKA6gWHxUgmemXtUWLDNad0
         5WVxlnM/K/yGCl/0J6aA05Nd07/7b1XIMSgGhaX+DSS/7TzGVM1QEggAZ6cK6gByaWV8
         Emv/0+Et+bX9IblN3MhKr3roRMACRMjZr6J80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604117; x=1732208917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytkqD9XI/BHqVrDHS/oEUwpMJruMLfeh9lCP9HUJDm8=;
        b=I57sSY6hzQd+IWB2Z8ahyLiDyuLyfkh5QVVXVr125RcoBTLq4cxA/TFncaT6ABR0Yv
         ZZIrivU/ykADo2ALPkjyulzY1yGOjXlBAGz2q5ghCnrb87kuCzMvT0ocbj90ktRn2ozs
         aVR0sKBDL1snKeoKOqSZSX0sFDX/jFaz9VOWh84D+YLcIuj2ddUk8Igj4edlNB9XKv+W
         MuVIctSuNZ88k3GTteJLbVb9++9nZU468Nl20wN3HBAAAuESjgHKr4xgWQ5mrxWBQyEm
         VOSBX5VoGZuvMatY95IlSzq4MfNbDn5OBJuwm+qIzN1vSSI/72HpXB8qzFluD+EuwiY9
         j7sw==
X-Forwarded-Encrypted: i=1; AJvYcCXRr7Okg+0pgKqIbKUrs88m1bcKx33HbmRGq09y+8cO5Swi0T+TPRoUNSE/oERpAkUvv8lbOdMX9HwzQJsbS/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/tlBldQQ983fi8PslKYjD9O+iz8vfCp+UXtE9lSqpcE0T5Qmv
	9yeAaxwkGiLW2bYaae954MPjATm8xjr/nq2vF4RIzToNsXb4SpCrJ4IlknJR/40=
X-Google-Smtp-Source: AGHT+IGUZJKnYN5ymfXEvQzdJKzRh/hKLacsxIQ6Yl6xQ9sfR7oYN33P5rDErUzL/+6dybCL0+GDgA==
X-Received: by 2002:a05:6602:641d:b0:83a:931a:13a0 with SMTP id ca18e2360f4ac-83e032e0050mr2741669239f.8.1731604117015;
        Thu, 14 Nov 2024 09:08:37 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83e6064901bsm35300239f.45.2024.11.14.09.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 09:08:35 -0800 (PST)
Message-ID: <196eaffe-c90b-4f44-a748-b786b46fd506@linuxfoundation.org>
Date: Thu, 14 Nov 2024 10:08:34 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: lsm: Refactor
 `flags_overset_lsm_set_self_attr` test
To: Casey Schaufler <casey@schaufler-ca.com>,
 Amit Vadhavana <av2082000@gmail.com>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc: ricardo@marliere.net, linux-kernel-mentees@lists.linux.dev,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241112182810.24761-1-av2082000@gmail.com>
 <52cc8e51-9e85-465b-8ee3-63a7a0a42951@linuxfoundation.org>
 <c16b7517-e490-48d9-a2b6-f0077cbb0eba@schaufler-ca.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <c16b7517-e490-48d9-a2b6-f0077cbb0eba@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/14/24 09:55, Casey Schaufler wrote:
> 
> On 11/14/2024 8:25 AM, Shuah Khan wrote:
>> On 11/12/24 11:28, Amit Vadhavana wrote:
>>> - Remove unnecessary `tctx` variable, use `ctx` directly.
>>> - Simplified code with no functional changes.
>>>
>>
>> I would rephrase the short to simply say Remove unused variable,
>> as refactor implies more extensive changes than what this patch
>> is actually doing.
>>
>> Please write complete sentences instead of bullet points in the
>> change log.
>>
>> How did you find this problem? Do include the details on how
>> in the change log.
>>
>>> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
>>> ---
>>>    tools/testing/selftests/lsm/lsm_set_self_attr_test.c | 7 +++----
>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>> b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>> index 66dec47e3ca3..732e89fe99c0 100644
>>> --- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>> +++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>> @@ -56,16 +56,15 @@ TEST(flags_zero_lsm_set_self_attr)
>>>    TEST(flags_overset_lsm_set_self_attr)
>>>    {
>>>        const long page_size = sysconf(_SC_PAGESIZE);
>>> -    char *ctx = calloc(page_size, 1);
>>> +    struct lsm_ctx *ctx = calloc(page_size, 1);
>>
>> Why not name this tctx and avoid changes to the ASSERT_EQs
>> below?
> 
> In the realm of linux security modules ctx is short for "context".
> I used tctx here because I was lazy. It would be much better to
> drop tctx, even if it means a tiny bit more change.
> 

Makes sense.

Amit, you can ignore this comment about tctx and ctx. Please do fix
others about the change log and short log.

thanks,
-- Shuah


