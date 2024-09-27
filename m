Return-Path: <linux-kselftest+bounces-18503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD748988A01
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 20:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8901C22833
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 18:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4461C1AB0;
	Fri, 27 Sep 2024 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eCmeasou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63547524B0
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727461164; cv=none; b=XMB0RtJb2204SsH6RxHkLGJ5FDNy9hhVy/5PJ28a+/ziFOma64cC03EyInB+J1d1unyT+7tOoLG8ObgFMwsOs/oCpK27tZtaBdZFE85zPgMVetKyE1NIr9ZmKNpu7dt7p7PQyQO5LpeiVd55XiU6K04W80xs11MQuqMobYUAbV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727461164; c=relaxed/simple;
	bh=hPZsk+m6EUhm8EVvWXNN0vIGJHq194e4maM8ldpOdFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkmjqX8YYAfTkm4xXZW+O+/+6Am0FVFlCyzGxaTTLqyrmRicizoY/tgSmmVeuhDbpBNhbIilwHCuL/lsG/9ZPnvoKzeupIFcRcdU/3u/TgJh+IJpdMVCeEvnFbhqksODT1sPavOIL/6GMyCYjeFtYbejgZuv2k+X+FMrUfuAuXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eCmeasou; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82ceab75c27so125653039f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 11:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727461161; x=1728065961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQqrJujpydlp91BVmmyoPafshZVAFUzISmrTF6aV2rs=;
        b=eCmeasouQ/pLiZhA2wFpcUTd23fUUDMYyDr4Mha+38zK4Pkb1wqyuufCQ4jGO2atAL
         VTioT9Xa1seh7Y5ceVT+fcBsVr3QVO6sVD/Li5bDh/zZi9umUh2TtseFebQo+lozvlZC
         t7fvbSP9CZ+wfY+ctGJ8Jp2ictP3MBh/jUyhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727461161; x=1728065961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQqrJujpydlp91BVmmyoPafshZVAFUzISmrTF6aV2rs=;
        b=mr65QxfuiPC0BTQof4YSUZHalYlxDRvztsk3r7N2fHFaa7gwRlr2vg/Z5MsNd+fouT
         RhuY0jZiYqfinuEbdLVG+apwGP4TntKq7KjaWLw2aB0aLn9bvMNUnx6NRSMkEx0mq7h5
         t2OwAAXk4wkPcO40xCXnVVHSLOSojySQJg65+gYIh6KI0Jq7L71Kj4373LMhmS6fbNrE
         yjS/X/F/ZFA4PmNsC67Ik6WFWYsWDrX120pje1cHylBxVsmGsHJkwXfw8ojUMZ/XIHwp
         lJNT6EcAJvs7OvWVtr3QN/WoynJBmhp68jG2jWJnrpkICKtfIfx2Rg2HmSKKuvIfyVOA
         4txw==
X-Forwarded-Encrypted: i=1; AJvYcCUzDAEaaZfMlL30/1E6sbfQEp1mnlHj9KHJNDH0bB/buM+xQEXC7324ke8pzYsruJX9TsTo5cYSX0BBwpcCGiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGS1ISeJseXs3OzeZq4OX52dAHhFuR2O25i06KTgQlTL9XVRD
	VFmXlvRozA5+ao9toHGhojoBzATHVOfyTTDPg8IC0fdXof+eRKrsnzvg+cT2eos=
X-Google-Smtp-Source: AGHT+IGNBttqWmrIjxtKnwZktpXPiai3iHlCQaFi1wD72Iy1t84sF9OeIz7FZLIg0q9kqHxFBLJo6Q==
X-Received: by 2002:a05:6602:2dd2:b0:82c:ee6d:a7ee with SMTP id ca18e2360f4ac-834931b193dmr396304239f.2.1727461161598;
        Fri, 27 Sep 2024 11:19:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888c2f43sm607811173.113.2024.09.27.11.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 11:19:20 -0700 (PDT)
Message-ID: <c38d9510-3cd6-4c8c-be45-f6f15334878a@linuxfoundation.org>
Date: Fri, 27 Sep 2024 12:19:20 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: vDSO: align stack for O2-optimized memcpy
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, christophe.leroy@csgroup.eu,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel test robot <oliver.sang@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <202409241558.98e13f6f-oliver.sang@intel.com>
 <20240924115001.916112-1-Jason@zx2c4.com> <ZvbqNZz547IGq7vy@zx2c4.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZvbqNZz547IGq7vy@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 11:24, Jason A. Donenfeld wrote:
> Hi Shuah,
> 
> On Tue, Sep 24, 2024 at 01:47:23PM +0200, Jason A. Donenfeld wrote:
>> When switching on -O2, gcc generates SSE2 instructions that assume a
>> 16-byte aligned stack, which the standalone test's start point wasn't
>> aligning. Fix this with the usual alignnent sequence.

I fixed this spelling when I apply. checkpatch is good at catching
these by the way.

>>
>> Fixes: ecb8bd70d51 ("selftests: vDSO: build tests with O2 optimization")
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202409241558.98e13f6f-oliver.sang@intel.com
>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>   
> Just FYI, I'm expecting that this is a patch you take through your tree
> for 6.12, and hopefully before rc1, as automated testing is failing.
> 
> Jason

Okay. Thanks for letting me know.

I will try to send this up for rc1 if at all possible.

Applied to linux-kselftest next

thanks,
-- Shuah

