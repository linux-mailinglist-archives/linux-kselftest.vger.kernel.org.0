Return-Path: <linux-kselftest+bounces-12944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A11491C7A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 22:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF4B28A374
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 20:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D70C824B2;
	Fri, 28 Jun 2024 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZsTbAIrS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FDE7710F
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608186; cv=none; b=WEJ0Omzyjme8w5Hm/dksgt2BgBLD+FiG7mY1v29FEsmUTvMzgr+lnsPpvtr+bFV3qLf/+LdrGIGDx+eTNcOmERj3bHY9XJQjuuKxOn0NeUGlwlzhHp2RUXhW9yHSzBftFdL/upi/vjg6DJ6hP3QmgrjnTSwELOg1A6nbWLCA7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608186; c=relaxed/simple;
	bh=sVVLZyRz+Y2ocJx/Z/miUk7woF9fQ39aiLjmsqWPRP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NF5aAtKu6Po+XYU9EnznxPz9mD7biErR97rFwGILitaz85LUHzrNGzTJvcAr2gQ3e60sZHRpT5jl0f/HtRRxEw7ma0nAIUb8a56Rh4Az7vacIi4/LzX9S09y3AUZ2XUuexVZ81ejXPnNKdx1xr/+o9ef3XXX2T9yJxBT4kDhHkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZsTbAIrS; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3745eb24ffaso677995ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 13:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719608182; x=1720212982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cxBzF/3g//5unyTrsCD2pQgSwnKMNUq26lWEwzop2AY=;
        b=ZsTbAIrS3wCSckC4P8tps8DvInI9VbQF+hW0fFVJFb3uxc/k2eGXSppFyVRcxk084B
         SkMqwFz9Ghsb+QAqXIOx35r63oqdXiQclntRwowwZL1+Oxcn3R1EjGE0+gYS5BFW6f+i
         ZIX+w03B7NIVmd1mnyZkYWUTuPzX4QDITXV54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719608182; x=1720212982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxBzF/3g//5unyTrsCD2pQgSwnKMNUq26lWEwzop2AY=;
        b=EceDiVe8eLv9XGlPDVAqY2jomNQI05f6elNN1qS1XabrwmQbVGu8qAoer/C9eCdF1A
         E0r4NiAukaAiK8/ExjHD1N18iplhPMG56k0jimsn0C3CJsELxbsMWxdKmM1t9LLD262p
         KUhAKSfGss2C8t5HEs+GaUc971+b6Wv3Linay5NNCCLAMQdjzhlvYR69RQRCmtOjqaRV
         fkBegS2KW4WMsM9/NDQfBI0RVywZ0uqL9A/L5XoF5JvobUEaQ5/pcWBiE3eTgW8etiWE
         K1ONGCluSsyQFNGIrIP6XIPv+S3B7T5rPddTW4UUSfSL84vDkIhlL0SvSjaWFtCowyje
         WimQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHiW5d5anuHK/g9V9HKVBHa5EbWBcVjbl6NYLjrgAFPlfIXlrT4PnPxuYnTAV8i2eNjyDof9p3jIKAIzMnbjZu9KSf8owp6d+MRsDZYB9J
X-Gm-Message-State: AOJu0YyEfG3YOhk5VZUeS9B5V7tyQ0LN+KjW1OkVvLEB0TSma4jbrOB/
	Ekdh0zlT94o2rEFrLPMv2sPMES94Du2/xjaiBTiF4swSBl5aNag/Z+Izp9hYhsb6S6H5FSbtt9l
	q
X-Google-Smtp-Source: AGHT+IGhg+mM7B81Awx2TVEDdIc2OvHNDuUeXlc6e5PUETIM5puxKztiIZ1KRgU0iKtgkuS9BUjEFg==
X-Received: by 2002:a6b:4f0b:0:b0:7f3:cd61:32f5 with SMTP id ca18e2360f4ac-7f3cd613354mr944356139f.2.1719608182677;
        Fri, 28 Jun 2024 13:56:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742b1acfsm710492173.123.2024.06.28.13.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 13:56:22 -0700 (PDT)
Message-ID: <4e02d3d6-935a-4184-b8aa-cbd537633783@linuxfoundation.org>
Date: Fri, 28 Jun 2024 14:56:21 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests: kselftest: also use strerror() on nolibc
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Shuah Khan <shuah@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240426-nolibc-strerror-v1-0-76a4c9c5271d@weissschuh.net>
 <20240426-nolibc-strerror-v1-3-76a4c9c5271d@weissschuh.net>
 <56ea48ee-e278-4f37-a80f-9fd70d9d8d3b@t-8ch.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <56ea48ee-e278-4f37-a80f-9fd70d9d8d3b@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/27/24 10:11, Thomas Weißschuh wrote:
> Hi Shuah,
> 
> Could you Ack the patch below to kselftest.h?
> 
> Thanks,
> Thomas
> 
> On 2024-04-26 13:08:58+0000, Thomas Weißschuh wrote:
>> nolibc gained an implementation of strerror() recently.
>> Use it and drop the ifdeffery.
>>
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>>   tools/testing/selftests/kselftest.h | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
>> index 541bf192e30e..f4bfe98c31e4 100644
>> --- a/tools/testing/selftests/kselftest.h
>> +++ b/tools/testing/selftests/kselftest.h
>> @@ -161,15 +161,7 @@ static inline __printf(1, 2) void ksft_print_msg(const char *msg, ...)
>>   
>>   static inline void ksft_perror(const char *msg)
>>   {
>> -#ifndef NOLIBC
>>   	ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
>> -#else
>> -	/*
>> -	 * nolibc doesn't provide strerror() and it seems
>> -	 * inappropriate to add one, just print the errno.
>> -	 */
>> -	ksft_print_msg("%s: %d)\n", msg, errno);
>> -#endif
>>   }
>>   
>>   static inline __printf(1, 2) void ksft_test_result_pass(const char *msg, ...)
>>
>> -- 
>> 2.44.0
>>


Sorry - this git lost in my Inbox.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

