Return-Path: <linux-kselftest+bounces-31965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E03AA3C50
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 01:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0778A3A8872
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 23:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7158A2DAF98;
	Tue, 29 Apr 2025 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FIjXBDyF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15D274FE8
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 23:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969681; cv=none; b=taJKB107YxcAmEd6enY1AP9D7PsaM1vj3Y4otln4S7VUrrS0Z1KHnIsU6iZr1MmZoL0YhDmTIyJ8mE3wO7UmDsUbOZ6jynnfHAG3gVVHo4jBBDu+Ml1xSkzLUGIwmLR7Q05QSeNQCNkKpvvZysjePZ+T8jNJz1qTsbJTmqjKwoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969681; c=relaxed/simple;
	bh=5PpGCLInumY79oCa5QN8pCEtkY3g3aL7RVIL8qW8exs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3ZSKNPTAMRkbJIfx7p/VJ7OfJhCbmGXsnJmxOX/q+jsH2sjFmBVNtJACzThznuwQbj3vKZAqKIY+dDBAPUff26UYmFrw3Wum4M2BhaLtdW9+bMYmLqUcWdE3ZbpNCT1DuMcP2E6u3OP65DfjGB6rq8hqgPzZKxBBKKiB82LR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FIjXBDyF; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d9189e9a06so22775525ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 16:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745969678; x=1746574478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4gYzRxDTMG8a8m2JVbMN+mLEBXzCwIBH9qxkDPGLkE=;
        b=FIjXBDyFl88sVU3HjaMuUwgelG7rsXRL05jT7yq7qmgYDFCRzIUGkqQBIruLmN2DoF
         agR23e3CeQ8m3xUBTJYcQ55vkNL/QIQcfTR1h7r+Z0zmQrb1hY4wZEeUCoFZwq5S4bEd
         CGoamXcOdUOqGF/Tk7w/hWcnH/lcA6zD11GjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969678; x=1746574478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4gYzRxDTMG8a8m2JVbMN+mLEBXzCwIBH9qxkDPGLkE=;
        b=bDimI/r1yen4Ekc/febfyAIrXEcsVL46KKRe/eoxF7QOVDuJT8+xfmedV/4sWseY+t
         9mbMljpeC+6CyYdqQA7qoyglk3d3XI+2gM6BCibUHQgWnplLCLxp3r2allzS0BkytLze
         b6JhqNSm21/ZDKrvANHK4rga2N7OIXULF8NnRtYvEuJ0RKN0MiWGxRprnRVOODJpZEbD
         B64KDs+mmIFBFPvYF0rVLn44vUk2Ij+qUonerGeFFdPdIIbS0pDZGbEgeVOuF7dtZGyX
         mTMdP6TMmc3WbfRYMIFBAQ79O02S3Tr/gt4xSNYgjpHJ54Ki3ye7mFW7RBzcC1ODsy7L
         BIUQ==
X-Gm-Message-State: AOJu0YxxOgaSj85rqqjdfCTSnmOpUhAydP8HpYuEYe+AM8DwKtru85ov
	X0dHtjU6wU5kxj8/A2HEjX4d9pqD+Ac+MIC5ETlv8EWWd7NtEsEkLdYVNBLl22c=
X-Gm-Gg: ASbGncsKtyMo7l/ZDxBGEXuJbhp5kPo1bCjBLI8d2qioyGAldhKhA2f10lgm3F4k2BZ
	JFRXlCqxGMgofbF8blw6EHNi3R8mQKixk+eUXT4J5CgMF0HGk2wI9B10b1Qfv3J6TjxYMrRhuxt
	VGZFSITGbrX4Bj0p+8vTBthvv7iabyBW2wEOO+Ma0OAZjySXlIHa/2pdgcCymDvFr0wjMB7tIgS
	2SDOk3nBjc8AU/T153LyJUE1eP9sKdv8mxWvMfOla4FjhaxnmmU3c4pSQ5DVVH2yA56Zg+Z157g
	Z5QWTih+pM2v3RwQHRaH0fhwIOzwS6b6rArSGzyYGfO7y5Mjl1Y=
X-Google-Smtp-Source: AGHT+IGOjy3LeocKf8YYHPxXWO9DsgVyLTc1222evmd5AAMOYmg3KWF6p2nXzH2m9ZsGo+Z4im+xEw==
X-Received: by 2002:a05:6e02:1a0d:b0:3d0:4e57:bbda with SMTP id e9e14a558f8ab-3d967fa17f0mr5478365ab.1.1745969678668;
        Tue, 29 Apr 2025 16:34:38 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d95f48030asm5366935ab.70.2025.04.29.16.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 16:34:38 -0700 (PDT)
Message-ID: <9477f8e9-b17b-49c3-a957-849198251082@linuxfoundation.org>
Date: Tue, 29 Apr 2025 17:34:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kunit: add tips to clean source tree to build help
 message
To: Jonathan Corbet <corbet@lwn.net>, brendan.higgins@linux.dev,
 davidgow@google.com, rmoar@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1745965121.git.skhan@linuxfoundation.org>
 <dc8f4035a8d493be9ddc0e868a3ffd67626cca00.1745965121.git.skhan@linuxfoundation.org>
 <87selqlh0q.fsf@trenco.lwn.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <87selqlh0q.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 16:49, Jonathan Corbet wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
> 
>> Add tips to clean source tree to build help message. When user run
>> kunit.py after building another kernel for ARCH=foo, it is necessary
>> to run 'make ARCH=foo mrproper' to remove all build artifacts generated
>> during the build. In such cases, kunit build could fail.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   tools/testing/kunit/kunit.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
>> index 7f9ae55fd6d5..db86a396ed33 100755
>> --- a/tools/testing/kunit/kunit.py
>> +++ b/tools/testing/kunit/kunit.py
>> @@ -583,7 +583,7 @@ def main(argv: Sequence[str]) -> None:
>>   						'the options in .kunitconfig')
>>   	add_common_opts(config_parser)
>>   
>> -	build_parser = subparser.add_parser('build', help='Builds a kernel with KUnit tests')
>> +	build_parser = subparser.add_parser('build', help='Builds a kernel with KUnit tests. Successful build depends on a clean source tree. Run mrproper to clean generated artifcats for prior ARCH=foo kernel build. Run 'make ARCH=foo mrproper')
>>   	add_common_opts(build_parser)
> 
> Nit: could perhaps that line be broken in a bit more readable way?

> 
>    	build_parser = subparser.add_parser('build',
>          	help='Builds a kernel with KUnit tests. '
>                    'Successful build depends on a clean source tree. '
>                    'Run mrproper to clean generated artifacts for prior '
>                    'ARCH=foo kernel build. '
>                    'Run "make ARCH=foo mrproper"')

It improves readability. Will fix it.
> 
> (fixed "artifacts" while I was in the neighborhood :)

Thanks for catching it.

thanks,
-- Shuah

