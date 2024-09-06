Return-Path: <linux-kselftest+bounces-17419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BDC96FC48
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 21:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40DE1C218F0
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 19:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780C81D45EA;
	Fri,  6 Sep 2024 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D/arF1Ov"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42D1140E38
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651650; cv=none; b=awg5GCeVPCWcLdiBp4KEdBBz9YxJsZ7SVXylrBG3Oe+6eBnbjr6JaoKT+VAVoTz0uDXuP//rGRFEqhx2mB+hfuRMyIx+2bv2oQEc6MFQYhjiJ/5hCH18tUcm0PHzzlsqCYrRf0soo7IRg9KmkLH8wlfR8ge7KfP5AgwlCMd4JXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651650; c=relaxed/simple;
	bh=jhViSLXMJzrHPVOesOXvpd9HoIZaRS2+UFztELHhZaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMdc9aQLq7dZ2bhzXMwyJ4INNxBGXHBKZG9mzXlvxUvpqC3Cc/v9IAchsvegcN4evbnU3mHWvW4pKhWwLimnXXtYdMp4P0/KCHQNjIaDEeJzlRM7vDZ/j8vhUddyedj/jC6z9oSLKtbaA8y/60ltsglArTsmutBHzLKg5+XvT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D/arF1Ov; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso1851436a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 12:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725651648; x=1726256448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HrEsjy45YRnX+PymgGFi2pgFxGDhRIIg2mDvIP2KwAo=;
        b=D/arF1OvqMMuV6JbYzw9tFmCNULMRXnqj7tEfmuWraNk/BnQpeqZ/OUCOdfnrqD9SZ
         Pm55jPAs/X9VAGxZsHEbKN7KQLAzOd93cX3hvSMSn1mIVfKubcXvYOJe9aT7g8gVLNJu
         Gu+1r/twQmR52om2Ic9lf/cvUf9Lk7c2XsqN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651648; x=1726256448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrEsjy45YRnX+PymgGFi2pgFxGDhRIIg2mDvIP2KwAo=;
        b=SUxjRehH/f1muji6yzaGf26HA30AeJ0thYpNc17SI/g4te6W7yNSqfFpJBMv2Mmih2
         C1+9P1IQZCDLXaLj/jQcxr9zWp2wJMz/I7ESqKj7XhzWdqhqkkF0icmCmexm+j/ZW9xj
         MqSh7V2eRO5Fr0Kg4pZjtE5KJ6OAb8u5tbe3jIwzM65xn8SqG9DcHxWtICj8rLMu58Ah
         a6SyVUpblwyzfYcC0yKAdLc5GufiIx/YQKoBpbIyv8aVi0OCwYJQh5wGXBrewrHAtTCB
         3FURK3F1VmJNNO5GjZQDAFKSZMzw/lSWQ3vjHiL+VKC+cQwbknkqnauAOtgDXojYmRPu
         C2AA==
X-Forwarded-Encrypted: i=1; AJvYcCWLUBpCNsmW0bcOoaELljg8giM6PJMj1CridSWcjpcACmrVSfYGKzFZ5mz1yZYe479WK75CYtlKSPn9ZAQuPg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgm1hsJFUCHG3BsQdY7RU1ZbmLnxQwPGW1e+J3IJK42NA4pQ/F
	RsBgqzC2rPqgnlREPy3OSlQx27Ax1p7bSz8phSbtY2ofBg/uKNdE7IEyoAPv5WZrQWrTlSEM5FB
	O
X-Google-Smtp-Source: AGHT+IHsEpJceWyiBJkzlj6FZMYa/abknsI9SBsUlsfx0t8W8s3I0dKVunW6uE926QUodgwTTe1XGQ==
X-Received: by 2002:a17:90b:1092:b0:2d3:ce99:44b6 with SMTP id 98e67ed59e1d1-2dad517f7afmr4069198a91.29.1725651647783;
        Fri, 06 Sep 2024 12:40:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0843a9sm1995011a91.42.2024.09.06.12.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 12:40:47 -0700 (PDT)
Message-ID: <b84546c4-374a-457f-94ee-509db6fd0044@linuxfoundation.org>
Date: Fri, 6 Sep 2024 13:40:46 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/timers: Remove unused NSEC_PER_SEC macro
To: John Stultz <jstultz@google.com>
Cc: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, anna-maria@linutronix.de,
 frederic@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, tglx@linutronix.de,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240906025259.3822-1-zhangjiao2@cmss.chinamobile.com>
 <49d07daa-622f-4c04-9d00-221f8abfb4f3@linuxfoundation.org>
 <CANDhNCqZitCt2ffrbEKKJtuVJPNAw8y_BdoZ3iu_5BhH1j2b+g@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANDhNCqZitCt2ffrbEKKJtuVJPNAw8y_BdoZ3iu_5BhH1j2b+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/6/24 11:02, John Stultz wrote:
> On Fri, Sep 6, 2024 at 7:29 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>> On 9/5/24 20:52, zhangjiao2 wrote:
>>> diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
>>> index c8e6bffe4e0a..83450145fe65 100644
>>> --- a/tools/testing/selftests/timers/skew_consistency.c
>>> +++ b/tools/testing/selftests/timers/skew_consistency.c
>>> @@ -36,8 +36,6 @@
>>>    #include <sys/wait.h>
>>>    #include "../kselftest.h"
>>>
>>> -#define NSEC_PER_SEC 1000000000LL
>>> -
>>>    int main(int argc, char **argv)
>>>    {
>>>        struct timex tx;
>>
>> This looks good to me.
>>
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>> John, I can pick this up with if you are okay with this change.
> 
> No objection from me, if you're ok with the commit.
> Acked-by: John Stultz <jstultz@google.com>
> 
> thanks
> -john


Thank you. Applied linux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah

