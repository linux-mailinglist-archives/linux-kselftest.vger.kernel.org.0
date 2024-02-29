Return-Path: <linux-kselftest+bounces-5644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0B186CB43
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 15:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9060E1C209F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 14:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AAD145B3C;
	Thu, 29 Feb 2024 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egIENjQO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE54A1420C9;
	Thu, 29 Feb 2024 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216183; cv=none; b=CGG0gfp8qHmLm+CpOBaf33ow055jfi6Rcmxxe0A1Esaj+szQ4pmDy/Urf0mX5dVab36f8EnYTLnyv/t+/d12XttZNZus3YmBh6PYUj9o9cZWhXZ53DaEelfs5scvmV7l+m1IQWdSt2g+lHDdVEPsOhGJTYEeP23XAMKka8PSwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216183; c=relaxed/simple;
	bh=PUK02Cucbp8QURrkbJDRBmCMb/j7fNSM0Xn8Y5zhIkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RIb39mnyI32lzgBHMNFw1x5VdoMENSsZ2JqotEIMjK76xvcwXD4+MM9rqLR9BSGB9bKM3vyWMo8mLQhV1A2IcvMFBvk16yUXmjiG9Me/IleRMPEB07fEiZlOogfSFK12+M2NysCWc1zneGkp15RwohmgkjyGx+7EXw/Na/HTyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egIENjQO; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68009cb4669so3329676d6.1;
        Thu, 29 Feb 2024 06:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709216180; x=1709820980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/W/wZXm/lm7nezS3iJK5hhPJV5z7bm8xrMOjN7sfA2c=;
        b=egIENjQOzhmY5vkoALNg3x+1lOZMiTSDwlaZUAHurP2erzDGExOaRhgUPwFT9Z/Qyy
         1mzsNlBlHHxJeh+eZwPwAdTBDoqYpRh8COppJrez/Fg/EoIyQLDD9lR2zf5J1n0xRcxR
         +mpbE+9axTBe5mZg/LwDkMtK4K/cekcvFQQLFY8VRXcVq4schNiJpoO4ZKTbLh/GPsj8
         srDGr9IIOzRAWYtPg6lTY3UiuZYifpL7AoessODFR7nFtmxsOW6dlRsKqk6TVi9HZlIk
         UmcCssg71Kf3H2DiiLIzkS4rhWaJbYjHxlcugjBmvSk/ipRXCKubEHw46JbH5aPBrP7/
         i80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709216180; x=1709820980;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/W/wZXm/lm7nezS3iJK5hhPJV5z7bm8xrMOjN7sfA2c=;
        b=O1GGIa6KdL4Yc0jsCn3ePZ2WtPeLgMS8VG+EOaMV+0TVVV5dBg50sURU8hh3a+9Nmx
         O8PGqxqnHVdvYLKsTV+ztvIL7RpG8XrruKq1+14mf/xxCOcQ06W6/TOJsMcMbPPcIsRh
         mYBqqj3my7LbTP4aJntMv8SPCymoG+Gvh2u1HhZIjCcLNZNpxexH3f8TkFFxyrCas6uP
         EwGchR9MhLfqS8LnUMv4V1Yl7kd+1WTuh0DUhetXhOjd68vHGEEFDnIZSt5/R223SBKo
         AHXBLtkRcSLINjDw/Nf7VQnxoqDi9vMCY1hsupbt+crzYRbt8tLUT27v6DKYgR+4+705
         Jylw==
X-Forwarded-Encrypted: i=1; AJvYcCXJoXntIPWbWEdUxoPqh6dgCaNjCbwZ2YZL7NPkVKIhREjbq6nv1Xe5J+079uZSUE5jdCQM6zWwghNdNEl9OdTEVWLE8dJnYHu0KME2GoNJcfoxNl7UkOjmCWFe1tkdxNkEAvT9pYGxP/k3gJ64u2KvL+eKqDF3Iv5EqHqYPiXECMi2Zh2USi5p
X-Gm-Message-State: AOJu0YzNK7lB9we21DJexcdQn5QXOMvqHatFVKxsFXYxlzBH4DFbXMIV
	l5N3seE6ug5/Fsmks4OHRyUdVJUYw/Gt+ufRr6/+OjuqIYD5IuNj
X-Google-Smtp-Source: AGHT+IHs1YnZ0esHs1BMxISmBCDSRJY5ZhDnZqGmDP5+mD/g+W2yrpWgUSNeF5GUTRda4q1JIaSsQQ==
X-Received: by 2002:a0c:e80e:0:b0:68f:3058:a0 with SMTP id y14-20020a0ce80e000000b0068f305800a0mr2481153qvn.41.1709216180406;
        Thu, 29 Feb 2024 06:16:20 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id ng8-20020a0562143bc800b0068fa4534070sm770363qvb.83.2024.02.29.06.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 06:16:20 -0800 (PST)
Message-ID: <a5726043-1906-44ba-a6ee-a725a2776269@gmail.com>
Date: Thu, 29 Feb 2024 16:16:15 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel
 Testing
Content-Language: en-US
To: Guillaume Tucker <gtucker@gtucker.io>,
 Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org,
 dave.pigott@collabora.com, mripard@kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
 gustavo.padovan@collabora.com, pawiecz@collabora.com,
 tales.aparecida@gmail.com, workflows@vger.kernel.org,
 kernelci@lists.linux.dev, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 ricardo.canuelo@collabora.com, kernel@collabora.com,
 torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <d99d026e-ed32-4432-bab3-db75296e67d8@gtucker.io>
From: Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <d99d026e-ed32-4432-bab3-db75296e67d8@gtucker.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/24 2:20 PM, Guillaume Tucker wrote:
> Hello,
> 
> On 28/02/2024 23:55, Helen Koike wrote:
>> Dear Kernel Community,
>>
>> This patch introduces a `.gitlab-ci` file along with a `ci/` folder, defining a
>> basic test pipeline triggered by code pushes to a GitLab-CI instance. This
>> initial version includes static checks (checkpatch and smatch for now) and build
>> tests across various architectures and configurations. It leverages an
>> integrated cache for efficient build times and introduces a flexible 'scenarios'
>> mechanism for subsystem-specific extensions.
> 
> This sounds like a nice starting point to me as an additional way
> to run tests upstream.  I have one particular question as I see a
> pattern through the rest of the email, please see below.
> 
> [...]
> 
>> 4. **Collaborative Testing Environment:** The kernel community is already
>> engaged in numerous testing efforts, including various GitLab-CI pipelines such
>> as DRM-CI, which I maintain, along with other solutions like KernelCI and
>> BPF-CI. This proposal is designed to further stimulate contributions to the
>> evolving testing landscape. Our goal is to establish a comprehensive suite of
>> common tools and files.
> 
> [...]
> 
>> **Leveraging External Test Labs:**
>> We can extend our testing to external labs, similar to what DRM-CI currently
>> does. This includes:
>> - Lava labs
>> - Bare metal labs
>> - Using KernelCI-provided labs
>>
>> **Other integrations**
>> - Submit results to KCIDB
> 
> [...]
> 
>> **Join Our Slack Channel:**
>> We have a Slack channel, #gitlab-ci, on the KernelCI Slack instance https://kernelci.slack.com/ .
>> Feel free to join and contribute to the conversation. The KernelCI team has
>> weekly calls where we also discuss the GitLab-CI pipeline.
>>
>> **Acknowledgments:**
>> A special thanks to Nikolai Kondrashov, Tales da Aparecida - both from Red Hat -
>> and KernelCI community for their valuable feedback and support in this proposal.
> 
> Where does this fit on the KernelCI roadmap?
> 
> I see it mentioned a few times but it's not entirely clear
> whether this initiative is an independent one or in some way
> linked to KernelCI.  Say, are you planning to use the kci tool,
> new API, compiler toolchains, user-space and Docker images etc?
> Or, are KernelCI plans evolving to follow this move?

I would say this is an important part of KernelCI the project, considering its 
aim to improve testing and CI in the kernel. It's not a part of KernelCI the 
service as it is right now, although I would say it would be good to have 
ability to submit KernelCI jobs from GitLab CI and pull results in the same 
pipeline, as we discussed earlier.

Nick

