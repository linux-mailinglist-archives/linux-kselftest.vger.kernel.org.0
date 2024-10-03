Return-Path: <linux-kselftest+bounces-18985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A427398F9C7
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 00:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649112847DA
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 22:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D3C1C9EDF;
	Thu,  3 Oct 2024 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V0Xv8QTZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0371824BD
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994093; cv=none; b=n034xSBDkUjuas60RqF4wIQAT7gThJiRxY38A6nvsFfRozsYTbnKjc00JWOuaKKAhsA8rkLYaD77o2KlotkXBQA0krgoGx/kGLNkjvfIVHooMbpiYzCHEEsoc6Mr0K7k7a8fuUsxA6jyTOmAjs8bzn1VLKZJHmJJbF9UzZCikEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994093; c=relaxed/simple;
	bh=OHyoJebI7E/zmh77wDoBaOAYwoU9zA6n+0AgohtEJjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+inpOB+3gcJkgmI17Gz5CL1Ud5TaKCRlWimm1EcXgzpRXTggGcwz7yJ7bIpCDwHmkyntelwxH+6+90dAW2E9xM38g4kZLDZDr+i5lBpgwth0MLLRNpAKDnDKe+KpTTt7X8Pho17KjUEW7bvA7Ku/aLLSLB953j4ZbFsycS6FLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V0Xv8QTZ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a1a90bd015so5168805ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Oct 2024 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727994091; x=1728598891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJYxjwKUfvb2gopYuUlZQJmzXvSJGMYWzcnS2aVlrTk=;
        b=V0Xv8QTZUXwPFAmtAdSiUDo6pXfiiGrgQtR0m1Rgg1L8MydKxVpQ29QF9I47QrctWb
         EfzmpDuTB7GMKuvOEo7CqIi193CNEpgiTrSsjqAyJEz+BLq+AiPnebcOmdl3+IJdlSDF
         hkFiElKG1eMBIV2JUL9OBoIfHxZQACNGcpcbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727994091; x=1728598891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJYxjwKUfvb2gopYuUlZQJmzXvSJGMYWzcnS2aVlrTk=;
        b=jkfU6TX4ojn4LRW5TERbNLOOVFLbJU61eKsdyZL8jOH8ayedjiGvVfghAff33J9eqG
         qFdX+e+ZltHGXXl37wIZjasmxOrZE9rNxlRhXUes2Ahnz6C/h73pDDJmcfy1wriDj1UP
         ciHk9ZuYjm3hy93Q0+MSTBapeDnVI1BLvZPDKD6b6ZNB1A7z1fNa7dDA2YJzT8pCXxij
         KMzFNHiAnQS5+D9BpaJmnsP6WrSDcg3Q3ooMVSZQI1V1Q5DYXnKRgKEgQRH579wg9W3a
         LGYbeln32Xr1fU5+z/bv5sSwdkXwakGmdvB5bJuycu35T0P08Ih0+UALX4jvUWTS3G0h
         Xt4A==
X-Forwarded-Encrypted: i=1; AJvYcCUKcF7qfIiH10UvIyCT8obAIYQDgQaCXoH1sZFvgb6Nsoe4PGYlQ+kA7vLe9NRqOIijTMxJm3Xv6HkJY7B7axQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Ui2LuzRZxxumZxYG5IQGcykdaePlOECzvAcZ+o/lP5XP90o+
	vne3P/8AEN7hzTez9517aFb+oIq/fiPifBtHgAXBdcMW7tlNEcV4jxTevsE0cwc=
X-Google-Smtp-Source: AGHT+IH4SyskZQycld8bBGiJmBC0+c9KqMCxwLOnldKRcc0y3Vs98Md6YTu6gD/qYhBIntoXWcHPhg==
X-Received: by 2002:a05:6e02:1c29:b0:3a2:6cd7:3250 with SMTP id e9e14a558f8ab-3a375a976bfmr6217515ab.10.1727994090657;
        Thu, 03 Oct 2024 15:21:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db5585f252sm460260173.27.2024.10.03.15.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 15:21:30 -0700 (PDT)
Message-ID: <c491b362-5ba1-462b-a033-8a5de45c406a@linuxfoundation.org>
Date: Thu, 3 Oct 2024 16:21:29 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: vDSO: fix compile error for
 vdso_test_getrandom
To: Yu Liao <liaoyu15@huawei.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: shuah@kernel.org, liwei391@huawei.com, broonie@kernel.org,
 linux-kselftest@vger.kernel.org, Xie XiuQi <xiexiuqi@huawei.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240919111841.20226-1-liaoyu15@huawei.com>
 <20ef1a1d-db00-44a7-a550-0b293d6e0d0e@linuxfoundation.org>
 <0010d5c7-388e-d648-8320-83b9fd16e615@huawei.com>
 <3e3507d8-f17c-4af8-83cb-682190f5bf67@csgroup.eu>
 <CAHmME9p9iy+d2wx3vpD1XbVde9WvcJ1agTOqcNw4z=WABVn5XQ@mail.gmail.com>
 <87684869-4565-4a4a-845f-4301242be52a@linuxfoundation.org>
 <702f6d09-5216-eef5-299d-6445cfca8233@huawei.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <702f6d09-5216-eef5-299d-6445cfca8233@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 20:57, Yu Liao wrote:
> Hi,
> On 2024/9/23 23:30, Shuah Khan wrote:
>> On 9/20/24 09:31, Jason A. Donenfeld wrote:
>>> Indeed probably <sched.h> is what's wanted here.
>>>
>>
>> Yu Liao, Please send v2 as per the review comments.
>>
> 
> CLONE_NEWTIME was introduced in glibc-2.36, which was released in August 2022.
> As Christophe mentioned, <sched.h> is already indirectly included by
> <phread.h>, so this issue does not exist if glibc version higher than 2.36.
> 
> Additionally, CLONE_NEWTIME was introduced in Linux 5.6 in March 2020, the
> CLONE_ macros are also defined in <linux/sched.h>, which is part of the
> kernel-header package.
> 
> My environment is Ubuntu 22.04 (Linux 5.15 + glibc 2.35), after upgrading to a
> newer version of glibc, the issue appears to be resolved.
> It seems to me that including <sched.h> might be unnecessary. I would greatly
> appreciate your guidance on how best to handle this situation.
> 

Please send me v2 with sched.h included explicitly. It is better do do so
than having it come from <phread.h> indirectly.

thanks,
-- SHuah


