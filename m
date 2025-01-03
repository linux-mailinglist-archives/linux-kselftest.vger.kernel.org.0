Return-Path: <linux-kselftest+bounces-23878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9B3A00C6D
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 17:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7D63A40E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 16:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D3C1FBC8E;
	Fri,  3 Jan 2025 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hceakV/z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A21BE4F
	for <linux-kselftest@vger.kernel.org>; Fri,  3 Jan 2025 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735923128; cv=none; b=WfQUF7kE6DVWAO4k2yprEX+qU2y8Ccy8iRY3V4fcyVm+6Ys3OxVfJKiDP6SgZHYpSuK8eyPpvGK2x9NxOwC6rIFVNVTT+jPocPIQr6fvIU60ERvV+B/wQI89QD2Y2Yo6nkrn3ZmEsNw1BlWGq076BBcX/qKMzUN53ruUeqtR0qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735923128; c=relaxed/simple;
	bh=mjiYXGCODLkQXzX1DOwC3J88sECqKnzrrSBYySr/wnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jm+/HodQZFUAo/feZwSKRRlyogmT1skpq/aNtWso4mWVC0JbNF/cIDJnkkve+JN/i4cYmDG3OLEBbI21TOtgxsAfHPD1PiEBcItCiQ3OVqAq5pLLglKKgs75PYe6DR9qy5bsrV0om8IuKAotP/di4kN/pWXisZBJ5qFqkPxOTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hceakV/z; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a78b39034dso44230965ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Jan 2025 08:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1735923126; x=1736527926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8y20AKvrlhHT/NR7chuzvdZkYAaY6m67XQn554j7Zuo=;
        b=hceakV/zBo6ZVGDdRw8bMx4+qb4yrIIlhH2gf2XaTh/FdUBwWT92HudVZygDM7Zc9D
         RZL1ydqXPCIgTiXhpY2B5ulU+rK/702pwrprdNyqAdNVybQa3VDlriKxlnHYFxAvo2ic
         9l9hZjK+0A2+nhuai5BHvQMAgkigyosNkk9KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735923126; x=1736527926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8y20AKvrlhHT/NR7chuzvdZkYAaY6m67XQn554j7Zuo=;
        b=Q+q5mXPrTs5/EXyxaASpANl6REDHOfs9mRq3GVlVS8SH5UXfnh0VK6beX9AZz1OCKr
         w3bI5U/bGB+MynFs5+sy5etSIJLVVQInN32E3Qi09pwrGpemJnCQpQVlX3EqWXHelMVk
         8gkfImYISVurCNqMMLksms3Mu9xPqjJVxjxrEKu2gL8eLvlAwJttmF2La17o64jdk7IE
         yCpo83WD2RBzB4lIgEF7d6FYiCHs90nVNcO8P6zD2mXykzGOxRAsYOEtd05HmggV3TgE
         0sktpvjUVjVUMn7RhCs1P5JDRkLciH9p+7NOJxdvxSzSWoADUv6Pa35xFAtQhSxcgt5U
         5Fog==
X-Gm-Message-State: AOJu0YyQCPSqjO5KUarYMqkljWCOzpB5ypMNY5vojMDXLMb/EsPXUc1i
	lB/ie6egX0etH+WfGCgWTOiMDamSoA7GKHi8SJPoQA9C2ZZyLG1vtgtN/wayNvk=
X-Gm-Gg: ASbGnctoJdfpOJs1/AqsZPGgf40CuNB7YQnNcevPANnASgAm3hGLf3F3c6KXk2wFs7J
	4muBLKroslx2eVFuCKkpvz2koWqh9XC6E7kGNH327yrCb7R5pl+EEFyahHgKuhMUBg+fcq4xCg9
	L4gpEswi/IvDmrSUBp2Tfmm2pon1bTZOqyKTWK5EDHHJQw79puBHj+0fC/NaHzzqwKdRS1sR8cj
	0qewPHSJVwLTC8ZnwUNKMrunJSRaXANIkP5TYA/gMsTquWLx9MN9ysK4O7flkUQ6TBN
X-Google-Smtp-Source: AGHT+IEugjV3zliG7kw7326pTYTQNLAMH/Xk38n1hocZsMo5qMppbROeVqxLez+objvIxR4DQ5xt0w==
X-Received: by 2002:a05:6e02:b2e:b0:3a7:91a4:c752 with SMTP id e9e14a558f8ab-3c2d5919b63mr514894615ab.23.1735923125881;
        Fri, 03 Jan 2025 08:52:05 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0dfb32128sm83710575ab.48.2025.01.03.08.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 08:52:05 -0800 (PST)
Message-ID: <6554116e-0fa9-4a2b-baa2-1c9b82c31460@linuxfoundation.org>
Date: Fri, 3 Jan 2025 09:52:04 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] selftests: tmpfs: Add Test-skip if not run as root
To: Shivam Chaudhary <cvam0000@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250102100459.1291426-1-cvam0000@gmail.com>
 <20250102100459.1291426-2-cvam0000@gmail.com>
 <e6d8cb36-089b-41cc-8ab7-90338bcda8de@linuxfoundation.org>
 <a5bf80c4-0062-4f3d-94e2-a40c1cac2934@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <a5bf80c4-0062-4f3d-94e2-a40c1cac2934@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/3/25 09:36, Shivam Chaudhary wrote:
> 
> On 03/01/25 3:24 AM, Shuah Khan wrote:
>> On 1/2/25 03:04, Shivam Chaudhary wrote:
>>> Add 'ksft_exit_skip()', if  not run as root, with an appropriate
>>> Warning.
>>>
>>> Add 'ksft_print_header()' and 'ksft_set_plan()' to structure test
>>> outputs more effectively.
>>>
>>> Test logs:
>>>
>>> Before Change:
>>> - Without root
>>>   error: unshare, errno 1
>>>
>>> - With root
>>>   No, output
>>>
>>> After change:
>>>
>>> - Without root
>>> TAP version 13
>>> 1..1
>>> ok 2 # SKIP This test needs root to run!
>>> Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>>>
>>> - With root
>>> TAP version 13
>>> 1..1
>>
>> How are you running this test to see the before ad after
>> results?
> 
> I'm doing the unit test, meaning, I'm building the test separatley and running it
> 
> to ensure the the code works as expected.
> 

When you run "make kselftest TARGETS=tmpfs", do you see duplicate
ktap output?

Rum the command and send me the output.

thanks,
-- Shuah


