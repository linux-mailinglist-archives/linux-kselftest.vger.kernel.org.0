Return-Path: <linux-kselftest+bounces-32024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB22AA4752
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 11:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD62B4A1AE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 09:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A9923185F;
	Wed, 30 Apr 2025 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLcIL3rr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760ED219A76
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005803; cv=none; b=kkM+YgbPd5GXToS7lfNAlBLVJ4i93CjZi2UnU3bHIX2UBelgPehWJUMT2JyVcgDo6opxITn7eLdhKFIfb6T4f53XjGPIIGZlVKDTAqq5OBtYtSxuIYLqz+WgFj8kGESFlurrttW5HzzzgDiRBA/Zh63ZPs6quAk2pN/JtIyAvWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005803; c=relaxed/simple;
	bh=LKbgVgvETQL2Z9FMH1hokLD+1a7kjWCTl8cKHjR38Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuFOI6tWKxFlDkLwtIMkwbDedLLAu9dGhJtO5DLP52y4Mr1Q4ALuYMEezxMSKpLuCWQ3MOwdtYFmoaYOaTf0FL/1OlIhu+cft4sZX8hdtnwZ4l7t0RY2toOW7KkuCW2J92dvW047DaM53kPCmWXGkAAB39dWvzFhCnJrSemUqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLcIL3rr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746005800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSPsTTFeEcnCdwW0Vym+XYLIte4DYBrgKfCXQ1hkyeQ=;
	b=PLcIL3rrYc7xiiJ2U116/1UToLGEIXW86cA2We/Tsidg7+dh3y480y6Fa3rHIb3mFBa3hw
	MAY6SCna3WsVDnfSaH+nyxqEO0kkXg1zAboHDG/mWTL8HGZl0CH0Zhog+4VhWIwVrXd6dA
	/jfsB7J0b+c4ch+SwKuBSdpnnk6VcZQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-XjFk_jmiNr2e0jhtKuGx5Q-1; Wed, 30 Apr 2025 05:36:38 -0400
X-MC-Unique: XjFk_jmiNr2e0jhtKuGx5Q-1
X-Mimecast-MFC-AGG-ID: XjFk_jmiNr2e0jhtKuGx5Q_1746005797
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39c2da64df9so3114124f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 02:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746005797; x=1746610597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSPsTTFeEcnCdwW0Vym+XYLIte4DYBrgKfCXQ1hkyeQ=;
        b=X5XaKkJ1Cf+xHSyNv9VmJ3v2rc/QB8MNMHoVc5RejOZIczTAu0FaAw6fzmFMtvD6WW
         +MPMveUtsODapSMmFGQyliB+nFdBiKGUJMNhfCYg+JWj/cTHMIJ3YmPAC8llyewyDF3O
         0GyZl0BuBFwHOuOONFbQoT+w56UKh1T7i4DhoC5b8xuDDdNZmWac06K9GOIZOEtqNeyL
         VtXod6PQTPzN7ruZSQmJHrWn588/ylMCF60UHSsMzf0xXF71X/ftlGadH1vrxo8MKxba
         VfYd4Y6xuXAgUFE1k826DicmN7RLflTi5Fp82AroZFaDvLprC4ExNnc1oxivt6AZUTpa
         w+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEllAl3y+WpPT8olmmr1scHJ0qlFzZRqrx1M135oJaW3xbf+LukISN94Ub135z99O6xTgOWm7D86WfxspaZVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjP9Nea/i6RwoNtrWH3Od9qCuW6PXXFcQYAflPvUa06B4LdakS
	AM76Z7gHgaOFMl2EuzlanYrL83pUcPi3SKIQz4LavFLKk18ynppELi393V+oazkGzcCvpFO6KMs
	A5XtezGZ9/t/NgnhSBFtczKL94yIKn4zOhe82GbMd2CrMdCasl4CpsAgQPL3vuyl23w==
X-Gm-Gg: ASbGncsSc9jgKcN483XOOncltdIJayVYxcAUxN6ghpuSvywHdbFS22Tq7ZEYNcSTlqp
	0YWiM5v/V1VTJcEk6M1lorzOx3l3JUV2IAnFLfRZGkXZ2vSStetbNtSYU+QsRvZUQeZCaj9wCVr
	8M8SzIA/xUSUE23nprW8S8HA3FGaXjxa2refAbHUXiYc6rpam2NaynGr6yJ3kTYhiHVW9Ar2shX
	OjRwWNDtfMjSibeCFBGOgal8ZzvqsMf/X5LOAp3cHM9iCzYvq00XgUAPyXSDV8nDyGZZ+FL+5Mr
	/XS9xPDtIDf3zt25hJWFwNaJGbBWEZI6gvtmSGPNUN4O
X-Received: by 2002:a5d:59a8:0:b0:391:3915:cffb with SMTP id ffacd0b85a97d-3a08ff465b4mr1716265f8f.43.1746005797563;
        Wed, 30 Apr 2025 02:36:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgdj7osQIlrwBtpolueyo0OCJRGNsPw7nP/YnjWorltc/OOlGv2Ls+W6kZFmWgAkKIRYm6lA==
X-Received: by 2002:a5d:59a8:0:b0:391:3915:cffb with SMTP id ffacd0b85a97d-3a08ff465b4mr1716245f8f.43.1746005797110;
        Wed, 30 Apr 2025 02:36:37 -0700 (PDT)
Received: from [172.16.17.99] (pd9ed5a70.dip0.t-ipconnect.de. [217.237.90.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca4e50sm16867435f8f.30.2025.04.30.02.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 02:36:36 -0700 (PDT)
Message-ID: <69d35507-f4aa-484c-8e1f-f2a766b4ffd1@redhat.com>
Date: Wed, 30 Apr 2025 11:36:35 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests: can: Document test_raw_filter test cases
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dcaratti@redhat.com, fstornio@redhat.com
References: <cover.1745323279.git.fmaurer@redhat.com>
 <710557cef8fb8472628862d9b65edcf7aeb32bb5.1745323279.git.fmaurer@redhat.com>
 <CAMZ6RqKcp=JNcbZjX6xSGo9Hyw=1nXbpS9Nc36xuDkbGG+=wtA@mail.gmail.com>
 <a28ff624-c73a-4e16-867a-66e423315c29@redhat.com>
 <08cb8dd7-5685-4a41-b6a9-c8758a804ed1@wanadoo.fr>
Content-Language: en-US
From: Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <08cb8dd7-5685-4a41-b6a9-c8758a804ed1@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24.04.25 17:08, Vincent Mailhol wrote:
> On 24/04/2025 at 23:02, Felix Maurer wrote:
>> On 24.04.25 09:44, Vincent Mailhol wrote:
>>> On Tue. 22 Apr. 2025 at 21:03, Felix Maurer <fmaurer@redhat.com> wrote:
>> [...]
>>>> diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/testing/selftests/net/can/test_raw_filter.c
>>>> index 7fe11e020a1c..8d43053824d2 100644
>>>> --- a/tools/testing/selftests/net/can/test_raw_filter.c
>>>> +++ b/tools/testing/selftests/net/can/test_raw_filter.c
>>>> @@ -101,94 +101,113 @@ FIXTURE_VARIANT(can_filters) {
>>>>         int exp_num_rx;
>>>>         int exp_rxbits;
>>>>  };
>>>> +#define T_EFF (CAN_EFF_FLAG >> 28)
>>>> +#define T_RTR (CAN_RTR_FLAG >> 28)
>>>
>>> I do not like this
>>>
>>>   >> 28
>>>
>>> shift. I understand that it is part of the original design, but for
>>> me, this is just obfuscation.
>>>
>>> Why just not using CAN_EFF_FLAG and CAN_RTR_FLAG as-is for the
>>> expected values? What benefit does this shift add?
>>
>> I agree, that looks like magic numbers and the original design is not
>> very nice here. The main reason for the >>28 is that later on values are
>> shifted by T_EFF and/or T_RTR, so they shouldn't be too large (with the
>>>> 28, the shift value later is in the range 0-14). See below for a
>> slightly different idea.
>>
>>>> +/* Ignore EFF flag in filter ID if not covered by filter mask */
>>>>  FIXTURE_VARIANT_ADD(can_filters, base_eff) {
>>>>         .testcase = 2,
>>>>         .id = ID | CAN_EFF_FLAG,
>>>>         .mask = CAN_SFF_MASK,
>>>>         .exp_num_rx = 4,
>>>> -       .exp_rxbits = 4369,
>>>> +       .exp_rxbits = (1 | 1 << (T_EFF) | 1 << (T_RTR) | 1 << (T_EFF | T_RTR)),
>>>                          ^
>>> What is the meaning of this 1?
>>
>> The 1 means that a packet will be received with no flags set.
> 
> OK. Now I understand.
> 
>> The whole rxbit thing took me a while to understand and the result now
>> is not straightforward either. Let's see if we can come up with
>> something better.
>>
>> The exp_rxbits is basically a bitfield that describes which flags should
>> be set on the received frames. Maybe this could be made more explicit
>> with something like this:
>>
>> .exp_rxbits = FRAME_NOFLAGS | FRAME_EFF | FRAME_RTR | FRAME_EFFRTR,
> 
> This is better. But yet, how would this scale in the future if we introduce the
> CAN FD? For n flags, you have n combinations.
> 
>> And in the receive loop something like this:
>>
>> rxbits |= FRAME_RCVD(frame.can_id);
>>
>> Of course, the definitions of these macros would still have the >>28,
>> but at a central point, with better explanation. Do you think that's
>> more understandable? Or do you have a different idea?
> 
> The
> 
>   >> 28
> 
> trick just allows to save a couple line but by doing so, adds a ton of
> complexity. What is wrong in writing this:

I don't see anything wrong with it, I like it :) I'll send an updated
version of the patches soon (probably squashed as well).

>   FIXTURE_VARIANT(can_filters) {
>   	int testcase;
>   	canid_t id;
>   	canid_t mask;
>   	int exp_num_rx;
>   	canid_t exp_flags[];
>   };
> 
>   /* Receive all frames when filtering for the ID in standard frame format */
>   FIXTURE_VARIANT_ADD(can_filters, base) {
>   	.testcase = 1,
>   	.id = ID,
>   	.mask = CAN_SFF_MASK,
>   	.exp_num_rx = 4,
>   	.exp_flags = {
>   		0,
>   		CAN_EFF_FLAG,
>   		CAN_RTR_FLAG,
>   		CAN_EFF_FLAG | CAN_RTR_FLAG,
>   	},
>   };
> 
> And then, in your TEST_F(), the do {} while loops becomes a:
> 
>   for (int i = 0; i <= variant->exp_num_rx; i++) {
>   	/* FD logic here */
>   	ret = FD_ISSET(self->sock, &rdfs);
> 	if (i == variant->exp_num_rx) {
>   		ASSERT_EQ(ret == 0);
>   	} else (i < variant->exp_num_rx)
>   		/* other relevant checks */
>   		ASSERT_EQ(frame.can_id & ~CAN_ERR_MASK ==
>   		          variant->exp_flags[i]);
>   	}
>   }
> 
> Here, you even check that the frames are received in order.
> 
> OK, the bitmap saved some memory, but here, we are speaking of selftests. The
> priority is readability. I will happily get rid of the bitmap and just simplify
> the logic.

I fully agree, thank you!
   Felix


