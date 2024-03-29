Return-Path: <linux-kselftest+bounces-6876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2225892032
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 16:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E579A1C29060
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB536BFBA;
	Fri, 29 Mar 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XjViRqzn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BDB6A356
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724471; cv=none; b=lf5edEOs3/wtDzZdbOKEo4DbvvJouvjSUdCMRpY7Hz+Ibsvlj4qQPGXCaDQwRHswIPBj+SXAkAxyQ/h+AUdC6eTUS+nRF5Sve6mlBht5XUKa2MVrtQ1xK/9eljzoe/HP8Oce/dk4lhWO6JnluQnFVZvt6MZ84gLHA55NrFwFDCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724471; c=relaxed/simple;
	bh=ffdHJ38YwyVCLmNFOjiqvMFT3PDctpIMfDS+lYCox44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwD/dEz1O10Sh7TVWGVfblhCs52O7ttht0kqJ7n6aAhzaNqSvyjxZqLV7BOuppQ4DiMhj7JDHe4aeJ4+sv8BMhSiTuWMQ0c4OsKvQUQ5tHtCxDATcuutgJsXxWSjo/qN3Ly1DMXjtx5+GRfh1G0GTpr8nNgxYXLNXGvbJcbz+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XjViRqzn; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso17923839f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711724469; x=1712329269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtoEDyZIOtyf1NNzpmG9xc+HrwPC7aA39C/nFjVgExE=;
        b=XjViRqznjIrrjk9eo96ZbLoNSR2rTPfkV84nnZA5wBh1gWdC+Jglr39tQW5zS7Q/mT
         I3yvyKKAFIk0/SFbnoQ1oKN2scsZuQa+lwEUUxWdE57rNArUybU7HEKr+QVRwTZUEypo
         Pi7TmKcgy9oc7dXbPJvLdQ4GwJvMbuq6L8O5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724469; x=1712329269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtoEDyZIOtyf1NNzpmG9xc+HrwPC7aA39C/nFjVgExE=;
        b=JLqLv4VoYDe6Wkd91o/7xrITCFgxWkjmwMXCbfUppNwMXww2K4lSRlS0rA0TDuP2tG
         +L1F5FOrsWiWCQVeZW7bWnDNMkSrS+5H/S60UR4a4JCGy/y0/VCZuKE4u7KvtlPX2DEW
         0xhicam/HqDDmEHC8UPAanICu+gP+oSfAVnzRtrtiyKv+k85EnEs+aKdiZNK3SVg5ud+
         zQwqaP8tjmHLRnpYB7JM8WsOHVFOsKN0OLlcV1r6c9TTY7oUp8RM6HAZrv2B4+ojRZ4k
         wuZY4f9zb5FPWVjU4LYnmoU2FZw+kg4RNhJoZ0kfCP2V1+8WpkJ/4FXE8l6ZkG2DqKOz
         KKcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx29ZgdTPuqeWO6fttsKLPpMRcMYAJZeBJ6nAt8QqE7wpwvK52rLXufVgPlYjLAfVMitBDRm4bdKCgR25Vkn9BJCrwOQOQjYm2XaidRbj7
X-Gm-Message-State: AOJu0Yyv6O+zCccKB5qLGA4lK2YYAujzBrAXLMkD+ume/jy8dg6zWc08
	5/9/3foKZIH1Xas7i1/ccFe8rTYBbn3rw/ze6MD8hv0Bf1Z2b5ypquWgfPnKZAo=
X-Google-Smtp-Source: AGHT+IEsg/ZZqDBbVwkvLa12KFDitUrXoXtj6hRWutQdOzYWvVyuAe79yZsw8QVMun+yJkJvJshGLQ==
X-Received: by 2002:a92:4b11:0:b0:368:aaa8:f557 with SMTP id m17-20020a924b11000000b00368aaa8f557mr2132805ilg.3.1711724469043;
        Fri, 29 Mar 2024 08:01:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id h17-20020a92d851000000b003696b5f5662sm134109ilq.49.2024.03.29.08.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 08:01:08 -0700 (PDT)
Message-ID: <70698a24-3794-4621-ac74-7aaeae01a750@linuxfoundation.org>
Date: Fri, 29 Mar 2024 09:01:07 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
To: Ingo Molnar <mingo@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, angquan yu <angquan21@gmail.com>,
 kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240327111720.3509180-1-usama.anjum@collabora.com>
 <1d6418a3-67eb-4a39-891a-7d653a26f1fc@linuxfoundation.org>
 <ZgZvaUbZIr0qpxK5@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZgZvaUbZIr0qpxK5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/29/24 01:36, Ingo Molnar wrote:
> 
> * Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 3/27/24 05:17, Muhammad Usama Anjum wrote:
>>> Skip instead of failing when prerequisite conditions aren't fulfilled,
>>> such as invalid xstate values etc. This patch would make the tests show
>>> as skip when run by:
>>>     make -C tools/testing/selftests/ TARGETS=x86 run_tests
>>>
>>>     ...
>>>     # timeout set to 45
>>>     # selftests: x86: amx_64
>>>     # # xstate cpuid: invalid tile data size/offset: 0/0
>>>     ok 42 selftests: x86: amx_64 # SKIP
>>>     # timeout set to 45
>>>     # selftests: x86: lam_64
>>>     # # Unsupported LAM feature!
>>>     ok 43 selftests: x86: lam_64 # SKIP
>>>     ...
>>>
>>> In amx test, Move away from check_cpuid_xsave() and start using
>>> arch_prctl() to find out if amx support is present or not. In the
>>> kernels where amx isn't present, arch_prctl returns -EINVAL. Hence it is
>>> backward compatible.
>>>
>>> Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
>>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> Changes since v2:
>>> - Update the changelog
>>>
>>
>> Thank you - applied to linux-kselftest next for 6.10-rc1
> 
> Please don't, I've applied the patch to tip:x86/cpu with a tidied up
> changelog.
> 

Thanks. I will drop it.

thanks,
-- Shuah


