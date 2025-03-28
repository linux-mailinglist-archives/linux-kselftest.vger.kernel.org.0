Return-Path: <linux-kselftest+bounces-29902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184D6A7531C
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 00:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A859516F9BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 23:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45471FDE08;
	Fri, 28 Mar 2025 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YcPv1t0+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010A31F866A
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743203644; cv=none; b=jsPkO+SXmMFhCXEI7liGPQ1JI5HJIER+2uBWjzcjNN9+kwtCZbt7i3uhm07FmZpFfrfD5HVrH1KE/HnjcZQPnWM6bpijCBIz1vtt7PVPpXckrLlGGgIBTchp+PhHo21ItuGwCMbas6lUfc7HOhLaYEx65ref555+O+/spI0LmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743203644; c=relaxed/simple;
	bh=t94ZB/a5qQUmwcFfEIDjBB2U+w06Wmg9G7OaftUk6+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I2kGJrZMZpzXchtCpqpiiigxyzPXEU86OCD6MTPXJtfdgkeN4PJIlrlTNH5bVO4hgT2oFnYxJYHIIR0DP9px/M2bRP5kVKzRewprHWFbhhi5gX7eZpjxBUCCoa/i5sKiHBrTVRGG4nzOQXz6slrpTDztjSroBRvopayouajcIXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YcPv1t0+; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d45875d440so11103845ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 16:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743203642; x=1743808442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yr92lcwq5x0ZFyCbkIww3KuTV12e93SVlPMAsCMg51Q=;
        b=YcPv1t0+mNWmv3g2d5Of0qd5+ZUd0O2LibiMv34xU/XVep4hJRVk1vzOOmAKq0ua1W
         Xwx3rTHs/Wpt8ZNyyN7T/fw1EmGAe6gC2Nl/4v+raiwOFnu55XSlonlr0Xs7PKRRWleW
         TivksR/IyNbOOm/geiZwG/QodpbEoiw5GDWfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743203642; x=1743808442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yr92lcwq5x0ZFyCbkIww3KuTV12e93SVlPMAsCMg51Q=;
        b=j8vjc0Y0qyoCWHGExVJEloB+oBNneg4zb0cSOYfhgBl+Y48/fJ295/VXK3gx2VsLCL
         KZAk387UvYpy0jft+x1hWGL3Ep3z9TUQXypUa6JvAPrzlxAWj7D496nBgU2hAjMp/KCf
         igKt+wPBNHQ6OaprrrtJEnYuyOtSHbO0XMXMY59Rk7NuEKjr4Q3DsEyuU/p9bRI//8gI
         o2tZwEu7WCgRu1K7fJUKe5HMxxJGsI4PSgKZJnS6FOMQ+aJi2WGmG+2yh6gdODP6LUeF
         HwJrEXETPpUeYSSxSB+K53/93yCOd/y0i3tePo9mslQvrtykyG8VkxEFn7NWm7VNS6ms
         OBsA==
X-Forwarded-Encrypted: i=1; AJvYcCUscPMvPLrdRonVEecCSz3oA2e/kMLz/CP0Y0KeTYMZz5etRsZ6c+JL3w1lT3klgy09nDRoiFhI4CCQxmIUubA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Ygd82UYRFvUKGMKQFnegR1jLlBap3xKIuVe3SUvB/H41+/KD
	NuYtGbNfiUXd3OjrlpoQKkHjIOJGDZQUWYiz1ogVqZYoSkc6/vxB++7lRWtnT04dCzlx9R+txFu
	3
X-Gm-Gg: ASbGncs++lEAIDoumM9v2zXLjcZXz0m8KeuVgw7CPQrZuWouM4mAgh7LdkqlN3q66rY
	l6YggIuxPFJQORm7tkvMOzMC3FjRunoO8ttwgTJO0tLlA77OkJUesFeUkJNVCp97srdZdquCh2w
	HC3PUNmmYVOUKsolBpJGcIaKs8yZqHuCvr85aSTnF4zlWdmweouClFpLM0bazv1OtHWjWVkNMRF
	xBo/r84sxuN71sLQnJMqJq2wlrWGGVg6VKPTz5Yo+lriO9PToh+9IkbgPTznvVVD99CTgZd6DvV
	odH6WTaAd8/4Bv6NpBJQOE1Ysi4PzqGwONwNsNILFO+JfSjoZhxeUB4=
X-Google-Smtp-Source: AGHT+IH70oQnJuM39SPUEueHTkjRUfH10oglLKDNJ/rt0bF923Ls3rYLJLdj2umTWLyd5RtMW24WAw==
X-Received: by 2002:a92:cda4:0:b0:3d3:fcff:edae with SMTP id e9e14a558f8ab-3d5e08eb18amr15510035ab.3.1743203641817;
        Fri, 28 Mar 2025 16:14:01 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d5d5a6c6b1sm6921945ab.17.2025.03.28.16.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 16:14:01 -0700 (PDT)
Message-ID: <341f69ce-2af2-4c13-8144-146f1aa9fb07@linuxfoundation.org>
Date: Fri, 28 Mar 2025 17:14:00 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug report for
 linux-6.14/tools/testing/selftests/mm/pagemap_ioctl.c
To: David Binderman <dcb314@hotmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <AS8PR02MB10217315060BBFDB21F19643E9CA62@AS8PR02MB10217.eurprd02.prod.outlook.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <AS8PR02MB10217315060BBFDB21F19643E9CA62@AS8PR02MB10217.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/25 13:25, David Binderman wrote:
> Hello there,
> 
> Static analyser cppcheck says:
> 
>> linux-6.14/tools/testing/selftests/mm/pagemap_ioctl.c:1061:11: style: int result is assigned to long long variable. If the variable is long long to avoid loss of information, then you have loss of information. [truncLongCastAssignment]
>> linux-6.14/tools/testing/selftests/mm/pagemap_ioctl.c:1510:11: style: int result is assigned to long long variable. If the variable is long long to avoid loss of information, then you have loss of information. [truncLongCastAssignment]
>> linux-6.14/tools/testing/selftests/mm/pagemap_ioctl.c:1523:11: style: int result is assigned to long long variable. If the variable is long long to avoid loss of information, then you have loss of information. [truncLongCastAssignment]
>> linux-6.14/tools/testing/selftests/mm/pagemap_ioctl.c:247:11: style: int result is assigned to long long variable. If the variable is long long to avoid loss of information, then you have loss of information. [truncLongCastAssignment]
>> linux-6.14/tools/testing/selftests/mm/pagemap_ioctl.c:435:11: style: int result is assigned to long long variable. If the variable is long long to avoid loss of information, then you have loss of information. [truncLongCastAssignment]
>> linux-6.14/tools/testing/selftests/mm/pagemap_ioctl.c:490:11: style: int result is assigned to long long variable. If the variable is long long to avoid loss of information, then you have loss of information. [truncLongCastAssignment]
> 
> The source code of the first one is
> 
>      mem_size = 10 * page_size;
> 
> Maybe better code:
> 
>      mem_size = 10ULL * page_size;
> 
> Regards
> 
> David Binderman
> 

Can you send a patch for us to review?

thanks,
-- Shuah

