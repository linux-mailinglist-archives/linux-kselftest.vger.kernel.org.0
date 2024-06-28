Return-Path: <linux-kselftest+bounces-12951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31E691C862
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 23:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B0E1C20CC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 21:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAF77F7F7;
	Fri, 28 Jun 2024 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="glwPWTWn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADEB48788
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611165; cv=none; b=PkMDNcirPQSDkzBAZgp5JDAnNH0fzmi6J3qMosrrhzSxtaqeQzPJRHWuLoTO7kjHBiGf3qWafuscyRg3d/cEpGDXemV0zw7lBXbnKEJGytoscNVMb2anTRdjM5dRdDBlQ3InXRwQaX0nZ2okEF8BjLjD9trFWCnwD3Ow9/74Clg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611165; c=relaxed/simple;
	bh=OB3Wr2ru3wShEzudQkoJjiRFTKGld9qFcmtWs0Umma0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6Rr5LKK9+7Lm4epJl4aOFZFFxTWoCWAMoou8uz8UO8A369gMWvplHKYhVa7MBhFGPW1atHRRthY6pmh+4gbqypQUojO9oyh0PI4jwvPyA9+cTVjZYjTwwi2vFv9/RgRKfn3b96qjvx1KyRq+rxd3L8B/zAMbytX3BbXUlfu4Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=glwPWTWn; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7f3d2f12d26so2085239f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 14:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719611162; x=1720215962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXD+Wgu9HPieHOq5j7Skd1mCiZ8SACBN4o7XWJsIIks=;
        b=glwPWTWnzCuNlI4ROfXK1HLhdRanR8revQQbmun8/DAFpswzACpc9kf6y6bxKaiJ6F
         rcM4gsHXCeBkwP1PmgIPHh6TI3RrVTCz1mmZTtFc/XgVnjm7J6Bis6Mr7QeSw16ZRTGs
         Er87v27nVnbceEBzb0Ff2b5cEHxPPHhU5KtIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719611162; x=1720215962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXD+Wgu9HPieHOq5j7Skd1mCiZ8SACBN4o7XWJsIIks=;
        b=sR51eHl/rojj5/+fFUrOdSZylXz0CR68tY4lHWeSoTXgOFbKoD6C06J3/oaqc37uET
         uJ5NjR/unxSxZABzkxD79pJuj8qRHWvoRvN/6vixD1G8ZM5kZZ7IfDOrY5Su4LBFoNWp
         6o/2BU6zilo+s6qBULcKDHWJzo6DHhQnomaxrljdjOTNX5We7J8H9oob+jSybj7/jZX5
         loCStotTUd1nVVM/j+7rFNO3iBfQYOuQGC7jSTAcQDZcbTUV54RTIT7IWCcwNGFaBEOH
         MBlfKqH4Lq+gqQvU0vMgkimDWK6jw5/ob+xWHgq7epkhpJjCotgGAL5yWfrgvNy4hj6Q
         XDnA==
X-Gm-Message-State: AOJu0Yw9ZLh6LoHV0geoD3jC33IyWYxQ8vCHlXSbIbs1onJOSa5AJhfL
	YLzEaYwyFwooKn4lx1wnRBEOWVm+4e3LT5OUYaJ26diOvfygAMqHPGkSuI04lz0=
X-Google-Smtp-Source: AGHT+IGo3fWI1OD0BMxUMA1ZPYK2vbnSnMktP0APM8qy7zFHw3P3IMjKDStnU4CheqoJvYjeSTASHw==
X-Received: by 2002:a05:6602:3fca:b0:7eb:2c45:4688 with SMTP id ca18e2360f4ac-7f39dd12493mr2282879139f.2.1719611161714;
        Fri, 28 Jun 2024 14:46:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f61d0fecc4sm67160539f.35.2024.06.28.14.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 14:46:01 -0700 (PDT)
Message-ID: <813c866d-c5f1-4f29-8854-4a789fd035cd@linuxfoundation.org>
Date: Fri, 28 Jun 2024 15:46:00 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tools/nolibc: implement strerror()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240426-nolibc-strerror-v1-0-76a4c9c5271d@weissschuh.net>
 <d6021c7c-271a-4aaa-82af-5a8ac7aac60b@t-8ch.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d6021c7c-271a-4aaa-82af-5a8ac7aac60b@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/2/24 10:10, Thomas Weißschuh wrote:
> Hi Shuah,
> 
> On 2024-04-26 13:08:55+0000, Thomas Weißschuh wrote:
>> Adds a simple implementation of strerror() and makes use of it in
>> kselftests.
>>
>> Shuah, could you Ack patch 3?
> 
> Friendly ping for an Ack of patch 3 of this series.
> 
> After that I'd like to submit an updated nolibc pull request to you for 6.10.
> 
>> Willy, this should work *without* your Ack.
>>
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>> Thomas Weißschuh (3):
>>        selftests/nolibc: introduce condition to run tests only on nolibc
>>        tools/nolibc: implement strerror()
>>        selftests: kselftest: also use strerror() on nolibc
>>
>>   tools/include/nolibc/stdio.h                 | 10 ++++++++
>>   tools/testing/selftests/kselftest.h          |  8 -------
>>   tools/testing/selftests/nolibc/nolibc-test.c | 36 ++++++++++++++++++----------
>>   3 files changed, 33 insertions(+), 21 deletions(-)
>> ---
>> base-commit: a3063ba97f31e0364379a3ffc567203e3f79e877
>> change-id: 20240425-nolibc-strerror-67f4bfa03035
>>
>> Best regards,
>> -- 
>> Thomas Weißschuh <linux@weissschuh.net>

Sorry for the delay o this.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

