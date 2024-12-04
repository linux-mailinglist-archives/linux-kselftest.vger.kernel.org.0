Return-Path: <linux-kselftest+bounces-22798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 589049E3035
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 01:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19259281719
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 00:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919FE1E3DFE;
	Wed,  4 Dec 2024 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K2MZ+iJn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FBD1E1A25
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Dec 2024 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270415; cv=none; b=pcEaBmaRSM08FmYz3jKl2wTruKzOb6Ssqsy8GORDas7ENzO5uNFb5ejLumGRo0QS1UeVAewRB3GMNRAQOFx2NG3Hgicnn0ACaLLlcXZdJ5FUiRcMEOIloT+ORIchoFX2Bt5/AQWQZhWKdzn8vjwAQ+dCHKhygvM/weWQq6s70LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270415; c=relaxed/simple;
	bh=4C3zy/3Xtoq5FHcNAlmFgia243qYTIlXnb/820E1Fi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkfjyopYPimngvsJTEHTL2SOivI8gWeIa7VelEeuo6tJgT8Tcy8kPOOskGWzhNu53Dw4rTqO0xszwS6SvC4XSFZRjvLNglYHabE+D1C19++A3PBWkGUjiXEsbJlyXeJAHh40ib3pHeTQA4M9BEOf4FM7zYUeVp2J+Nd/lsfdaJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K2MZ+iJn; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a75eaaab59so1479755ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 16:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733270412; x=1733875212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mc1ZGS9lQ0b/EeRQlcxev0IXuC4T041+iJYm/1vazoI=;
        b=K2MZ+iJndRFX05a5zRFim9M4zrplqvZS2TK1lgpy05mEXtMav+hZrnkK5osr2kRlhi
         K2yiP0whlO/JzKBbQplaVBBrbMJ/XpAXvjkl0dtdiA5qIjmEp8ItZFXkOtM+C0YYj+HM
         2Oq5soZm5SJYzPJ9joz7D5req07bNT1Y2+krM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733270412; x=1733875212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc1ZGS9lQ0b/EeRQlcxev0IXuC4T041+iJYm/1vazoI=;
        b=ZfT6Gn7+ihO8Id1VKQCtGDZcW7OamthsLSbQqA2KtWfUm6dskJEuSO31dThPlXmiwP
         P6F7WW8+ZlI04Vu421LHGo+Ws7EkNQoIaZa+rlLkpNfvGze7w6pfQx/ugIkZdcH6CHey
         NXd4hB1qN1ezy8ucKuVV0UeqnzVWJXqEyQuDqalEbRXYVqYuXdYfk2Ga7J5LqGc01ISg
         Ebnhml2rGahjtIdb6JGKRp7hZ15BGYa02rFY8h8gcSesc/4z/5qtrm3CUsrhEvH+QWLm
         Oi2JKD8GBqLYo8PuhEugAQHoebVHyXEgVojplfrGrh7rX8txdqR5DzoWUFb+eij6pcon
         lb3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP4xNOUBckrZMbG84LCeoge8K41M7PWMo6cRtz2PL4HqF1VggSNrqoMddsCAPYM1EdMDOxfxVGk2GPO9YFi2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg1SiqZoBGzWYaRG8k13AXFLOIIvm1MnwU3BQNwMxfB7dfPQ39
	Tl/oFobvuWWi/MGs8o6wcwAEDB2pXdQzWOJk1dBgP49R3KMQBpNCRrhP1aw7Cb4=
X-Gm-Gg: ASbGncvZ9IxzpC/Uul0RBGBQEdqEk1au0wNjQIPf7b9IzK5ZljU2KRzljv1pMpnUXNb
	Q/p37stAHhAzGq02rY1r8gRdvPeT6GypbM/6RHBIU4Z6q2wr6Uob61x/rJI11Q1TYUhx2TS2fpo
	cDx1tia0q1OhWqHtgk9OVZZ27v54tHndVTpV0pKnxXtI650rshrSfMWh79LKtae2aJ/kTfU8w1S
	wgprcMRVcnFjaumIsKxFtPPxAFeQjrbLnV+UmnVpUif0GtOqcUURQwOBupVaA==
X-Google-Smtp-Source: AGHT+IEgl8XCJT5Pb5WmR2bg9AoPfQLC2H0rmjg7RtKpc6R4ckuWbh6gosnC/HaecwtdaxRcwGAf2A==
X-Received: by 2002:a05:6e02:1c24:b0:3a7:ccb2:e438 with SMTP id e9e14a558f8ab-3a7f9d82b53mr35356965ab.11.1733270411617;
        Tue, 03 Dec 2024 16:00:11 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7dd1c55d8sm23394655ab.64.2024.12.03.16.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 16:00:11 -0800 (PST)
Message-ID: <e8e6824c-61d4-48f9-8547-628bbbd3063a@linuxfoundation.org>
Date: Tue, 3 Dec 2024 17:00:10 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: lsm: Refactor
 `flags_overset_lsm_set_self_attr` test
To: Paul Moore <paul@paul-moore.com>
Cc: Amit Vadhavana <av2082000@gmail.com>, jmorris@namei.org,
 serge@hallyn.com, casey@schaufler-ca.com, shuah@kernel.org,
 ricardo@marliere.net, linux-kernel-mentees@lists.linux.dev,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241112182810.24761-1-av2082000@gmail.com>
 <52cc8e51-9e85-465b-8ee3-63a7a0a42951@linuxfoundation.org>
 <CAHC9VhTJERn54qNDDOwNrJ09VWrmq5Qn+sPQV__LyeEUgSi5pw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAHC9VhTJERn54qNDDOwNrJ09VWrmq5Qn+sPQV__LyeEUgSi5pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/26/24 20:38, Paul Moore wrote:
> On Thu, Nov 14, 2024 at 11:25 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
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
>>>    tools/testing/selftests/lsm/lsm_set_self_attr_test.c | 7 +++----
>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>> index 66dec47e3ca3..732e89fe99c0 100644
>>> --- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>> +++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>> @@ -56,16 +56,15 @@ TEST(flags_zero_lsm_set_self_attr)
>>>    TEST(flags_overset_lsm_set_self_attr)
>>>    {
>>>        const long page_size = sysconf(_SC_PAGESIZE);
>>> -     char *ctx = calloc(page_size, 1);
>>> +     struct lsm_ctx *ctx = calloc(page_size, 1);
>>
>> Why not name this tctx and avoid changes to the ASSERT_EQs
>> below?
>>
>>>        __u32 size = page_size;
>>> -     struct lsm_ctx *tctx = (struct lsm_ctx *)ctx;
>>>
>>>        ASSERT_NE(NULL, ctx);
>>>        if (attr_lsm_count()) {
>>> -             ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, tctx, &size,
>>> +             ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size,
>>>                                               0));
>>>        }
>>> -     ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV, tctx,
>>> +     ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV, ctx,
>>>                                        size, 0));
>>>
>>>        free(ctx);
>>
>> You have to change this tctx for sure.
>>
>> With these changes:
>>
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>> Paul, James,
>>
>> Please do let me know if you would me to take this through
>> kselftest tree.
> 
> Amit has already posted a v2 with the requested changes, but I wanted
> to get back to you on this even if this patch is outdated ... Shuah,
> what is your preference for things like this?  My general policy is
> that patches only affecting one subsystem tree should be taken by the
> associated subsystem to minimize merge headaches and other ugliness,
> however, the kselftest is an interesting subsystem in that it relies
> so heavily on others that I'm not sure my policy makes as much sense
> here :)
> 

kselftest patches usually go through subsystem trees because of the
merge problems you mentioned. I take them through kselftest tree
if subsystem maintainers want me to. Some do and I pick them up.

I pick up patches if I don't see response from subsystem maintainers.

thanks,
-- Shuah

