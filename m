Return-Path: <linux-kselftest+bounces-17849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9DE976E6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 18:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642B62822FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5A413D531;
	Thu, 12 Sep 2024 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CwkJE8ZU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC113D245
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157289; cv=none; b=mYPU5uHszJ4jb6bnRLRlIZykBfUZjwEAMGXYzggxbK1RlhUjsJidu2ht60APQ8R5+K6J3hcdadtqmqhZDacpaI+AVWuJE0hejuh8Ytvyy129shjkXIIRrBRYVab7l4jOw59b7pBPKVbjRsMYdqtScUD2VSrIdLlLQrhMPy6/vpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157289; c=relaxed/simple;
	bh=jlDv07f0uJH2tvHJ8Q3I14k6ePq27Cv6MvyBrLPvYKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0X21amdlg0+O3zVDwr8F/N5+Gnk8zoSHR7u5UpJ2QaFSX1w+miAgsA/sRiDk00qpVGtFUbEVyd5hobb3Zws3fo4Njr8+PsPujojqTtIaxTXv8tYGzPLszTKnyeCzcXfCY6zS7eZs0v40OKEDTbx7fM4NTTjX0Xl4kJ/3tDB9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CwkJE8ZU; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e033e37bc9so497570b6e.0
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 09:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726157286; x=1726762086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NI7OEbpTh45hhxXq/OOmTMo70izGjSuZNxMT6AI6//o=;
        b=CwkJE8ZUGIbN2YV4avCxpnAoRU70T97IfQmHvcXl+XGRexHL4MVVA3j8yr7Gc1GzSP
         5nulKOlkMt/TRVz17wrLA7TETIpFe+HBO4Hq59KNLI4hZQMAgf8NBZjmOhC2FgcSOqxv
         1Ypuc+BtipeP6+spRkIkhryzdXxb2baaGJ9iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726157286; x=1726762086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NI7OEbpTh45hhxXq/OOmTMo70izGjSuZNxMT6AI6//o=;
        b=G4B19Q0gViyDBaPM9kgRMp20H2f04fqLF6dCcQBmR9Sck1R45bgIl7azjGWmho+lRN
         Bo+rY2xluIuu42WMV4i1wBA/MrfcBAfh4P8kf1By4ljLqioiJdOSG6ZGYfnYZXzPDYNm
         jFeRjNkehgmlvdzEfQho8ViOLFhLSobxjf1kR1zP7BkzWckEm6zQt4WBAljXxAK3UTTx
         winUGU+chOXKGtHQv1Q0m6bH1iaHcTNIz5INF4aplTEkNGl4Hyqd7EKzslM3mIhIRNr/
         Kimr30RdLcHJOvTLxHAC9XFxYZ7+Q67JSAq3a94CFTRjW2qzg8/Fiu5ZCTLlIdMkv0MZ
         u/4A==
X-Forwarded-Encrypted: i=1; AJvYcCXUqpwnOFKOkXNJqW4VQ2aEb8Cuw3gqAW208YnIx6D3gclOYnICllp4OztIKd4E/ke76B3N7GUK5npEI4rhAUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuSywr1RKkGyDneAOovzYrJwmoTmGFN0hOlxbhrguNwwIPrvGH
	hOm9Lj5iGk9OcC6I702je1ejH74auR2W4IkCf2NUkOOH1w+6vqGHL38Zy3xHawA=
X-Google-Smtp-Source: AGHT+IEeDlnxBgeSMcMWoxZbKQaLPEEou9RlVyGheJGyi3fFx2gRYmz9PmkXaDTlKl5PVSGqX4pVSg==
X-Received: by 2002:a05:6808:2021:b0:3e0:6fd2:b7d with SMTP id 5614622812f47-3e071aab5bamr1978744b6e.22.1726157286408;
        Thu, 12 Sep 2024 09:08:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f948ecdsm658153173.163.2024.09.12.09.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 09:08:05 -0700 (PDT)
Message-ID: <b207948f-c8e8-4291-bb27-de3b6fa10e04@linuxfoundation.org>
Date: Thu, 12 Sep 2024 10:08:05 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] lib/math: Add int_pow test suite
To: David Gow <davidgow@google.com>,
 Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910011036.15117-1-luis.hernandez093@gmail.com>
 <CABVgOSmpS4GN-iskm2DzebkxF-vcA3iJuba3YnicdNYwy+8mbQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSmpS4GN-iskm2DzebkxF-vcA3iJuba3YnicdNYwy+8mbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 22:33, David Gow wrote:
> On Tue, 10 Sept 2024 at 09:10, Luis Felipe Hernandez
> <luis.hernandez093@gmail.com> wrote:
>>
>> Adds test suite for integer based power function.

It would be nice to see more details on what this test does>
What's the output look like?

I fixed it up with the details from the Kconfig. Please do make sure
to add test details in the commit long in the future.

There was a trailing whitespace I had to fix. Run checkpatch to verify
that there are no issues with the patch in future.

>>
>> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
>> ---
>> Changes in v5:
>>    - Fix kernel test bot warning
>>    - Rebase with latest
>> Changes in v4:
>>    - Address checkpatch warning and make kconfig description longer
>>    - Use GPL-2.0-only for consistency
>>    - Spelling fix fith -> fifth
>> Changes in v3:
>>    - Fix compiler warning: explicitly define constant as unsigned int
>>    - Add changes in patch revisions
>> Changes in v2:
>>    - Address review feedback
>>    - Add kconfig entry
>>    - Use correct dir and file convention for KUnit
>>    - Fix typo
>>    - Remove unused static_stub header
>>    - Refactor test suite to use paramerterized test cases
>>    - Add close to max allowable value to in large_result test case
>>    - Add test case with non-power of two exponent
>>    - Fix module license
>> ---
> 
> Looks good to me, thanks!
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David

thanks,
-- Shuah

