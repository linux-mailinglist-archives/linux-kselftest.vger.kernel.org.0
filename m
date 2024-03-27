Return-Path: <linux-kselftest+bounces-6719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E4388EAF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 17:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2D61F33E86
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 16:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4240D130497;
	Wed, 27 Mar 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gZhVMWfq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C2712F58B
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556363; cv=none; b=iui8ipMFcZHp+u+tlQ9uWgl3q6M94lqu3VVf7lTgj4gIPiKcGYN7RSVSBMbG0235PTduivWH2lmiQ5yIUVtNt70YNrQajRrgoQAqLCNP6KBd0TOD/+RMzf4SYLG0E0m69dRvUUl8QQeoAcECBhEMvYKOkRvvZuSq1ST6KrCTIIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556363; c=relaxed/simple;
	bh=OrY2sRkMGUSl5qS4bbQVcCvtD+x52pQ3Jvu2+0Cf6vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nx3Ep3ob4tm/tYinklGa48WfKIROY2rwiQF26Jf1wq4afCm8qyxHg16stu5Rs2m5cadIgSn/CzqweQ5pmhH7fW4EcrLccm0/l4drShF6nu6GL9yI3yu9Nzn5uNVZ3Svi3YWTDKj+qpTyPZDdoTh29k/N4FhhOIh4v+c/FNidTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gZhVMWfq; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso22282739f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711556361; x=1712161161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+EwpnV1TovlT/K7a9fk3BdjFCSuIGfXvPuki/X3eHY=;
        b=gZhVMWfq39SffqUOh9P6lBRApIrh8XpYkurdi2D+KF3nEw7MBy51+59j0MvYKOePJc
         H2YUxrE25zne1efGXlWgibB405807+6BjNjnPKLdyZTXkhKNenMQZPFGpA33yeaQb2Bt
         anGyHmi7kCo/YVSVVKUUl+9Olcs0i6KF2ys5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711556361; x=1712161161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+EwpnV1TovlT/K7a9fk3BdjFCSuIGfXvPuki/X3eHY=;
        b=CXyTYiwYIhp5sjRptJi0I1SEhUtEvN9d03HuW1wbH9RpHuP/KFFkjorh+Q9PabeeFN
         JtKwrHNIqG0LkDCUcjOIMmp9ODwKM73WR7Tg0bsFvcgQS/0akXp4ho2YLP6TGYRThtfr
         2AydtOHJqNXVTyaTiIfsutj4xvZG14HlKwFbKgTTNPKup8L4vN7IZQy8LnJvOS1hDSaR
         TdzoFBmFSUo4hV5b+ycayG1Bu4vMWRnlfR6OhA+B13qWHWf/9Q4gb6rucO22R8laybuk
         iNqbGl8JMBUPg4M3X1QaGxkRaXlNFHdTRTrS5yCSICGODfM7ooHKyloBXH8QnxYRtdLX
         ol8w==
X-Forwarded-Encrypted: i=1; AJvYcCW6WYcY7NglxXdeGh8VnLjR2EotgA30A08kLwLWFtcGt3coiozGDLRfzB4F7YYpdaUSkgG4Dz7Y8ui054gZSuIA+THbDXaqhQELO067gKvu
X-Gm-Message-State: AOJu0YyyN1IOGcK+jAiVQomC1hGYy2Ee0WnjmlJQ7000tTllQ2GnDt1q
	0X/TO/LA+VhLoqauNPPEneDcO8bICK2ktQmAfa9BkC1/Sj6BY7/fz42P3mi0s4E=
X-Google-Smtp-Source: AGHT+IGFTq5dd597zpcFVDKJzVe2QfZkJrAeL8dZzhpz4JfDnNyVSDojkp6US9cbLAxZzL7lqBXjxg==
X-Received: by 2002:a5e:9402:0:b0:7d0:3d2c:5987 with SMTP id q2-20020a5e9402000000b007d03d2c5987mr672625ioj.0.1711556360742;
        Wed, 27 Mar 2024 09:19:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id q16-20020a02c8d0000000b0047c17c664fbsm2007031jao.115.2024.03.27.09.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 09:19:20 -0700 (PDT)
Message-ID: <cfa1ee01-1480-4869-9ea8-daaff0ce3ac9@linuxfoundation.org>
Date: Wed, 27 Mar 2024 10:19:19 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/exec: execveat: Improve debug reporting
To: Kees Cook <keescook@chromium.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240313185606.work.073-kees@kernel.org>
 <1dd87e89-2306-4669-844f-ffe9e56523b6@collabora.com>
 <fa109cff-5326-4f94-aa3b-d83827d5f968@linuxfoundation.org>
 <202403261540.8F0D7A0@keescook>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <202403261540.8F0D7A0@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/24 16:40, Kees Cook wrote:
> On Tue, Mar 26, 2024 at 02:46:02PM -0600, Shuah Khan wrote:
>> On 3/14/24 02:54, Muhammad Usama Anjum wrote:
>>> On 3/13/24 11:56 PM, Kees Cook wrote:
>>>> Children processes were reporting their status, duplicating the
>>>> parent's. Remove that, and add some additional details about the test
>>>> execution.
>>>>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>> ---
>>>> Cc: Eric Biederman <ebiederm@xmission.com>
>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>> Cc: Mark Brown <broonie@kernel.org>
>>>> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> Cc: linux-mm@kvack.org
>>>> Cc: linux-kselftest@vger.kernel.org
>>> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>
>>
>> Applied to linux-kselftest fixes for the next rc.
> 
> This is already part of the execve tree...
> 

Thanks. I will go drop it.

thanks,
-- Shuah

