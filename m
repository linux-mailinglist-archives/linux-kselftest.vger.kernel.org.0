Return-Path: <linux-kselftest+bounces-18360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6289864C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 18:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14C31F259E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32624C62A;
	Wed, 25 Sep 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLKkrw16"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2C71BC2A;
	Wed, 25 Sep 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281565; cv=none; b=OV1lLAQkbKVH0h+t9uQChxVReJhLsmUUhl1re3UvsPFtWDr8QFb9AHHvPg5teFv0rPXfe6Z43aMK5GWAJBHW9Ki0ifWeU5FlswluduS7PU9nL+DM/GBshPyBlHm9WZfKjeQC2ZNzsj7Ag6C5TvuvQkhNgkboakBVqqzPmIAfSzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281565; c=relaxed/simple;
	bh=cI6lyNFuQzUTS7t+rqJMQnOPi9+rdmD9ZefQND902cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSFryfJfkGKMbL82wSaqzWKDZ1kHdP5iMw+x6BTGUAzA01AA+2+V7JNebWLbTj0Nf9eYnfYZG1GYRApz9MEixhOB5Yek5/MxMwEU/FemcsVV6Lw6wDxbRpdqmiH+XDdTTmlvj8tQBg292IHzpUJw9SpF8E10KaOc1fGC2W3/Y78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLKkrw16; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so88592305e9.3;
        Wed, 25 Sep 2024 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727281562; x=1727886362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H/UtXLfeBskg7av7Jxvz+w2dEjZcwNE7yygFxh5xpPU=;
        b=HLKkrw16Omsmq2k0YWGGgCXCYO4RcVm5KeMv4em2sxcbMITwW/WVX50Bx63l5PrOCr
         QSzjCgkOkuu0cia4IW34OV17EsAfvmoMdyKh8BxICOdKuhSQQL8ORrWLD7J+V0y0LiFy
         SxD5VqFB2G5VZm6HhVHvDP+7GRv/vQnOOYWY32AHOi87ui+0oZfhldHU3tKx77vCOKl2
         N4B0VSzlr5NjuCDt4Q9t0jZh02bpWEI3fOrhUAW7ctLep+O6S3tlsVp0dIFNf4Ge+Y22
         QinJEDu94h0TBngqgvD77PSLsslcoRdr/59IpTWg3UbHnDv7ZOQF/RqHHO9bBjqSbJ/X
         MoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281562; x=1727886362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/UtXLfeBskg7av7Jxvz+w2dEjZcwNE7yygFxh5xpPU=;
        b=vZyn9yzjGlLyvpd+x5+HDLKp7K4f4X+bFvMaWCk8jMI0P9vga2wge2K3rVvU1qoDob
         Sw54QIT0c/55X/ZAj8HxjA2xVFvilz5Y0et8y07TNCO9Qza5DCMnPq7saMRNmDGubYu6
         SOhVdTOSxfXkJGaTxiIkG5MTKNuSmL/XpDZhHjCN7Nh0sk959E+ztj3uu9DvcNBZARLN
         xyYq2VELD2PWkRrmQgy7kE47kZ7ocNOo9LF3kfUUXo1CTM/Pj8eANYY8JUN8V+2mPOoA
         04MLZwfqTblXbn9NMVGVNwjUihgcV1gdHGBW8VvRWxOIwMWciGUZsAg7VV+XCJSPp9pC
         r4GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNkwdc+rDQuQLqLZri9KqnSGKX/xfNUJYBVeRdkwD7NNF3ZMdHTa+DxRZxaPD1esJgYdnaR2GMWlmFHHc=@vger.kernel.org, AJvYcCW8TekLkdkONg9V+xprgNxRzufQ54q+Q4bKj6a1zPMBvEA7xEgtVDZMF6wI03jQQqeY+ETfeoUV@vger.kernel.org, AJvYcCX8CrxdBhkZpRjTZE7nYoBiMHDinQ2H9JIOk6kISEPGI2gV33vC1hbd9z2wf1Mzbh8tcAgMAMWCQZ79yw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6JuHOdrlLI3VE/0MFHb/KB3prrdl4x+TXJ3VJ9Wn4eLoy8ns+
	pUxbnwpQcAfZZfVK57TM+2laIZGDCUSkLizRim622pEQL/JjCLkK
X-Google-Smtp-Source: AGHT+IFnUcAaIeFzw5E9a6d4pDhxJA51W3OA4HKs+9mXTYSBF++MSHEBdMd2l1J6YgLA5fH5oKDXlw==
X-Received: by 2002:a05:600c:1e03:b0:42c:c8be:4215 with SMTP id 5b1f17b1804b1-42e9610252bmr27899125e9.4.1727281562296;
        Wed, 25 Sep 2024 09:26:02 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:ec17:8f60:3966:3e7b? (2a02-8389-41cf-e200-ec17-8f60-3966-3e7b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:ec17:8f60:3966:3e7b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ffa3dsm23280735e9.23.2024.09.25.09.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:26:01 -0700 (PDT)
Message-ID: <70864b3b-ad84-49b2-859c-8c7e6814c3f1@gmail.com>
Date: Wed, 25 Sep 2024 18:25:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests: exec: update gitignore for load_address
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-mm@kvack.org
References: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
 <20240924-selftests-gitignore-v1-4-9755ac883388@gmail.com>
 <e537539f-85a5-42eb-be8a-8a865db53ca2@linuxfoundation.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <e537539f-85a5-42eb-be8a-8a865db53ca2@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/09/2024 17:46, Shuah Khan wrote:
> On 9/24/24 06:49, Javier Carrasco wrote:
>> The name of the "load_address" objects has been modified, but the
>> corresponding entry in the gitignore file must be updated.
>>
>> Update the load_address entry in the gitignore file to account for
>> the new names.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>   tools/testing/selftests/exec/.gitignore | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/
>> selftests/exec/.gitignore
>> index 90c238ba6a4b..4d9fb7b20ea7 100644
>> --- a/tools/testing/selftests/exec/.gitignore
>> +++ b/tools/testing/selftests/exec/.gitignore
>> @@ -9,7 +9,7 @@ execveat.ephemeral
>>   execveat.denatured
>>   non-regular
>>   null-argv
>> -/load_address_*
>> +/load_address.*
> 
> Hmm. This will include the load_address.c which shouldn't
> be included in the .gitignore?
> 
>>   /recursion-depth
>>   xxxxxxxx*
>>   pipe
>>
> 
> thanks,
> -- Shuah


Hi, the kernel test robot already notified me about that issue, and I
sent a v2 to fix it shortly after. Please take a look at the newer
version where I added the exception for load_address.c.

Thanks and best regards,
Javier Carrasco

