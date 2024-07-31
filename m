Return-Path: <linux-kselftest+bounces-14591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FDB94392C
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 01:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B828F1F227EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 23:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E141316CD27;
	Wed, 31 Jul 2024 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MpeFz383"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F91F1552FA
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722467094; cv=none; b=g5S1x7TSURhUT0eCGffIFcdTuSHZ9oWffHLZtl/NVYzmfi3nu4d10xaSniZx4YzVLom1TQhkLxjTStPe5KysOlgssycf4tfjtCqtkKNDwOVjwlFFs+nK4Qvz49YzHUshxMs5TZr+uebKeP37mSbAb1mSxH/9qQEEu6u/Iza+/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722467094; c=relaxed/simple;
	bh=nR6iB48+sc2V+utiCDRETEq+7Xcu1mt9j9UEGabxaNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SA+zgNu7oFmR03oPB2pVykPNT3SWpPGwO3hBcSUIq1TVxx8ubAcl3pf93itjpWCo3xoaWqIViczTmbxznukZ97PXLqPm8Dvws9vXiWS6gIKo4IZoZZGFRcYjPt6PCFF85P9o8wKBHcpQJbdXBqh8hPTXwO2n1l/9v/4XdvS69Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MpeFz383; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39aeccc63deso1909735ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722467092; x=1723071892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rc1mYDYh45s96NuQaciGq8TqvL9Yep3EQj0f6ctL3fs=;
        b=MpeFz383Si67YKrLMeuXOUHj2mpNls0yEIfcdjIv/CkIbO43m2oWREdD0kE15pJwJ4
         h2n121qt4vrN4UKiCN5n6Z9oDhMQ8Oh/oDt2VjO50nGCIanx0eE5wLnS/Ase911bVUls
         FlLFHjemjaXOWEp2UMpPQ0fOqYKLzju20PNkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722467092; x=1723071892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc1mYDYh45s96NuQaciGq8TqvL9Yep3EQj0f6ctL3fs=;
        b=tLEoaz3SuB/4xSZYpYZnCcLas68er3dLrjv/pzb2AFrSw9xhBy+poBRdz0cdOpijoc
         0jIYb1APDs0F2etrFYwf+bfigBxb8HKOSGyO196ly3H0Lfh7ku5apVWyqhupQI3GGfDk
         8Jl6xMugV4tJYR7jfuxrnxG+pC5jyJlKpgCFW6EopVFQZcXKdKJTPAkyiQYaTy+iI5ih
         zYzvrUB9IxA8N0YRS3/01FdAcokzSaDGdzjYK2BVQCpw0AZdOUqxQrswVUlQvIyvvex9
         bqmSNve4hmi0QFHAeW/kv9SuS04a4ynRmfm/xPGWJv92cTOQwUw+DmOprSmEkp4AQAnI
         6MgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXgFsaWUgcoe/M4TJMx5aAPzNW8mBy7ZyqE5Z+bZIH9x+ht2iUMttfS1gNGXG/vqEK9tGgvJve01xE97loyzM3FZuJSxTV6fSCxZuUhZwx
X-Gm-Message-State: AOJu0Yy9Wf+Ln1M/pXvPJVGTKOTKdEpGEMILrW4kqS407oiTdx5vk9J8
	oTzSSPB/yePQcyRI4wWgYOxh3Rw6YAa+kgF4Rz+QP7i9fvSSExFntj0aIhpDSR0=
X-Google-Smtp-Source: AGHT+IEQq9JC/vWnd7Mmi1lortZtAXTkPlkycj6lilOeQPsFnE8PsK5Sb4+qywTIrc7XIcl/UC00vQ==
X-Received: by 2002:a92:c56c:0:b0:375:a4f9:e701 with SMTP id e9e14a558f8ab-39b183a1dadmr5114375ab.3.1722467092259;
        Wed, 31 Jul 2024 16:04:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39ae7b07a92sm48873055ab.62.2024.07.31.16.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 16:04:51 -0700 (PDT)
Message-ID: <cba9b382-84ec-4170-9935-aee7c0042705@linuxfoundation.org>
Date: Wed, 31 Jul 2024 17:04:51 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: ksft: Track skipped tests when finishing the
 test suite
To: Laura Nao <laura.nao@collabora.com>
Cc: gregkh@linuxfoundation.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 nfraprado@collabora.com, shuah@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <2bb2d338-cd00-4ac2-b8bd-5579eae82637@linuxfoundation.org>
 <20240730103543.33884-1-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240730103543.33884-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 04:35, Laura Nao wrote:
> On 7/29/24 22:06, Shuah Khan wrote:
>> On 7/29/24 08:52, Laura Nao wrote:
>>> Hi Shuah,
>>>
>>> On 7/23/24 18:17, Shuah Khan wrote:
>>>> On 7/22/24 09:43, Laura Nao wrote:
>>>>> Consider skipped tests in addition to passed tests when evaluating the
>>>>> overall result of the test suite in the finished() helper.
>>>>>
>>
>> I am finally with you now. Can you please more information in your
>> short log and commit log.
>>
>> Isn't this a bug fix? Current logic before this change will report
>> tests failed if there are any skipped tests?
>>
>> Can you send v2 calling it a fix and explain the problem clearly.
>>
> 
> v2 sent: https://lore.kernel.org/all/20240730102928.33182-1-laura.nao@collabora.com/
>   
>> This isn't problem in this patch, but I am concerned about how
>> simply calling tests passed without calling out skipped tests.
>>
>> This problem could be solved by printing a message at the end of tests
>> for non-zero skipped test conditions to say the coverage could be
>> increased by enabling config options.
>>
> 
> Right. We can send a separate patch to address this.

Yes please. Thank you.

thanks,
-- Shuah

