Return-Path: <linux-kselftest+bounces-32056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43108AA5919
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 02:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12084E3EC1
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931861A38E3;
	Thu,  1 May 2025 00:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IchzMFys"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C21219F42D
	for <linux-kselftest@vger.kernel.org>; Thu,  1 May 2025 00:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746060020; cv=none; b=Z/jBCMx7FpFjw7K1ploUqqxtNgD4R+EdiAQvF5mGZApNI1JfD5SifBHliX25KWtbg85wA7Uh9TBWDAkvokNDGzzJ8IohRciN/qJ7mqvnOOI0VjS2GtzDXXM5/WLYeV5bIT+nmnVmjy9t1jCAwYUEVrv3Spz7T9vZv0qpAh3dbf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746060020; c=relaxed/simple;
	bh=552tRLcpTCtKGHW+KggBdoahEXInHzfBOErT/0f9miI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lG8AGyX7jcRp9XoqImFnIIso9VnCto3AmVh7/3L4RyW0V2QGzgv7ULpa48fXujYd3UhGxNDQiRRxy1kPdV0gD7uJ8Zt8C/dcmR0B9ETA5sT65Rg49ZgpXXakHQZNu5j++m+A9ai96GEiXbTJ6DDUAxThC9kNtPcTTPuPzFqqIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IchzMFys; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85e15dc8035so15522439f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 17:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746060016; x=1746664816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81Imi5jthw6ckQVVKqp6SOrhZOqAy++fKyUkHYMDBAM=;
        b=IchzMFyszbG/A9A5vnpws5289Upz7M2m+B/HnlR++20oh1bvghL48p30A+exeFm7kT
         Tb5Iqta9u8svgegF9sJLjGLfrHJ7YELMUIEv3UKdY54VCaaGqVZ6dINmGbeXgYAFs5EP
         +ExrYufMLuu2v3Osk6auJ+0S+ybzU98ydS42E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746060016; x=1746664816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81Imi5jthw6ckQVVKqp6SOrhZOqAy++fKyUkHYMDBAM=;
        b=FgzD/aBykz0oCMFwDG88q13grEEMdXhmyIx8j+9ijk+lDurwhnXl2Nxs0oO2p3KM6l
         isv6Dl8jw92TOkkUCeEDoCta8yYjLdTemqBagfKIQ2ZPSjrkYzIWnUTLtv89Ec/UyeNv
         M+1Wu76nyJCJDda8BFOjAu1nsXNdea639Yl6gi2t/J48ju4WCwxNGDWhBLA2rQ4qeb2y
         4xE8413XaMjnGywKTYruTbEAefOWmcKcYsHmZSLAS+2MRE1zzVfNzlEKDPH3hj+SkECG
         c5OraBTnQovf8VmQZyHODS/QTbhNTDypZyhNUt7llwjx8anDeaaqZqgWeGqVzeiWf/qh
         9c7g==
X-Forwarded-Encrypted: i=1; AJvYcCV5qr2egLXh/YhI0TEydwMBDAfNI/vx5BDp88VwmW/mqPnFJ7352nJHIVtkIw/G3fST347N8wNtuwiAIXLdbNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyHJX3swTuZmNbFF2lcpcdumrdMN49kn96ug+BKCdlFM643rqr
	jgbF4pJi1xOzzE9HMPM60otKT/jXqoLB2dc3OmxPBz83rtG1FvRSOVJLRWJym/k=
X-Gm-Gg: ASbGncvRLB7ESEn1Igd0NZ67E1psMllEbiMAqCwEmm5RY2DVwVAgwpfbL7bXtVdpNXx
	e7oH27fhPp2sQxypAHbp/OAOWvKuNRwEQStWjGMdsujNSXm6GLULveKpaRnvKfn2DfUm6N+YV+0
	0uQr878S/zdpC04+T15Qdv+Sf0HRa69twywsWX5zHtFkCaxXgfac12yDbclxgUGcpQk44OmfcUI
	sPAzKGp/8YiDo/fXGQKkE+b0MpdPizhv+hHtdioWWFzU5p6bcyR6x2eaIFgTbb1FEmD3sqge1vR
	GQyWnKcb9AGvZDc2TTvVZCtpVItCsmHlmMEfjG1Cj+IezrgEnAhzM5qEI57q/w==
X-Google-Smtp-Source: AGHT+IEqgjRflu+1J1ow23/oxPjAJWAFmuKPdOwmbO4yPHSPfoz6dXuQvghS/4uINgdSWOrZCkv2pg==
X-Received: by 2002:a05:6602:36ca:b0:861:1ba3:3e50 with SMTP id ca18e2360f4ac-864a2051d04mr182168439f.0.1746060016528;
        Wed, 30 Apr 2025 17:40:16 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f862e0fcbdsm995927173.5.2025.04.30.17.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 17:40:15 -0700 (PDT)
Message-ID: <949a6ddc-4663-4b41-9f08-a3c0d07307af@linuxfoundation.org>
Date: Wed, 30 Apr 2025 18:40:14 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kunit: add tips to clean source tree to build help
 message
To: David Gow <davidgow@google.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, corbet@lwn.net,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1745965121.git.skhan@linuxfoundation.org>
 <dc8f4035a8d493be9ddc0e868a3ffd67626cca00.1745965121.git.skhan@linuxfoundation.org>
 <CABVgOSnKPPLH9BASOZ0b3mMOUuiVXxsdXQcoQqyTKd5UYONpUQ@mail.gmail.com>
 <4d1acc28-3645-461a-97e3-316563f468e0@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4d1acc28-3645-461a-97e3-316563f468e0@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/25 15:25, Shuah Khan wrote:
> On 4/29/25 21:54, David Gow wrote:
>> On Wed, 30 Apr 2025 at 06:27, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>
>>> Add tips to clean source tree to build help message. When user run
>>> kunit.py after building another kernel for ARCH=foo, it is necessary
>>> to run 'make ARCH=foo mrproper' to remove all build artifacts generated
>>> during the build. In such cases, kunit build could fail.
>>>
>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>> ---
>>
>> Thanks for doing this.
>>
>> This looks good to me, save for the issue below.
>>
>> I do wonder whether there's a more general fix we can do in the
>> makefiles, but I'm not sure how that'd have to work. Maybe by storing
>> the architecture used somewhere and amending the error based on that,
>> or hacking around the specific x86_64/UML incompatibilities. But let's
>> go ahead with this fix regardless.
> 
> I agree the right fix is to see if kunit.py can suggest the right arch
> to clean. I will take a look at that.

It is an easy change to the main Makefile. Will send the patch tomorrow.
We won't need the documentation and help message changes with the main
Makefile change.

thanks,
-- Shuah

