Return-Path: <linux-kselftest+bounces-13819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2AE933412
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 00:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E281F23F39
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 22:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F867405A;
	Tue, 16 Jul 2024 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YPmLbW6N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B46E1860
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167549; cv=none; b=nF/7K0OL/aOiHq7O44ojh7AgFyCA4i4K3RZ4piyGK7nEKxF9rkCjPAxP65IpsxBjEJaa0nT8CzfFuf28+9oe6CvLSW0tfqJIQ70U4BYES1I03N33pFIYOLnULdkNcXxm8+El57viTMP4JbMbzx6eUik7k6msaeRCdcaJnJ6D2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167549; c=relaxed/simple;
	bh=CkJucEGBKi1vFXk+FISBw52fe94XEUxPABdSrJGtnik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCaXsKN/RU20SYm86V7jOMFRVzshW59POudN/p/1IiD0Rh46teS71PDoqGpV3VdK8e5pZK6UoYyGWSySMFgQkJV8KeULwek/jnjIg5+fQLtjwFnU7EtGRLfrixIxfFDd8O2G/FEdjoupaiVrM4v/DVdhZ+FyxQqYlWcr5VdEI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YPmLbW6N; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7fb3529622dso1328339f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721167547; x=1721772347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTy42Fs8+Jr95ikyca40F3ZZbw68C7koXGwHU5+AQvI=;
        b=YPmLbW6Nidm326ajsTyBNUfVf0nQQmO2D4fjVqbxDFjBdNkaJHFyE0qW+/Yzyyea/V
         gWbOA5KO20Pglw1+b/z1LWF5O1/gdehIyrbSCvnESKe09vuYwmfsQHeq92sHBxzY73Cx
         pwQwSmb+WRE1X6G62NqjLIQtvmaOS6fYdeftE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721167547; x=1721772347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTy42Fs8+Jr95ikyca40F3ZZbw68C7koXGwHU5+AQvI=;
        b=MxymMtAyKMX4N1Y/8cCjCYJcZsEugIFjoZtb+jwuxnGtMfz5+Bdy6P+9x5Z7sNvryv
         RUi1+yqo3s597k12l1etg6HK8Rkx1D4azPzzARZfqlOxMfxlF4zBKXBh9vHHlYGsOh4m
         rLrW7BzaQcFpQAEXraIwtfAcEouRiWcdu3lzZlzRuI7SsSpfNsyF+93NbMqczbZ5HN9B
         5OZet8agAFJA5M3p+W8hz5/UYoyGbM0XT166/JURLi0gnr9XAu0rDBSj6TWPnKCAo2oh
         WAKBGq7H3VqF8wlEicn8voGMfN6noagJF2XRFDdC7za19trsKV3ripFifYdW8/+inegA
         lxNg==
X-Forwarded-Encrypted: i=1; AJvYcCXbrIb71FSSMGYVJkB+2cT0Xoj8P1PUju61WwrGvPLmEQUdtdvIoMfbVGdMbvwzMAGmP8JF1TXtR+vYCEjPHZrFP4tgD40Py+JSEK63L0x2
X-Gm-Message-State: AOJu0YyL/rYz18XwjWMZIJm0zzQgHD/SFKz1TeSNDCDX8tSY/5vGIziE
	D4PERTpV5GDs2+gyfZjjAUQSYoxyp6GZs489dYaT2CdtlvxhOUHzJQhpqjC4X9MIN2zYgVrg8pm
	V
X-Google-Smtp-Source: AGHT+IE2IqcYbobmy7qTVhbdZ3wHj43JwoI1DCRUg7A9WkyucXMp8aVsR4PxvOlGGhZEtgFjK7AWYw==
X-Received: by 2002:a05:6e02:1ca5:b0:383:297a:bdfb with SMTP id e9e14a558f8ab-3950caf0331mr6268715ab.2.1721167547604;
        Tue, 16 Jul 2024 15:05:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3950b6ad7bbsm2002345ab.42.2024.07.16.15.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 15:05:47 -0700 (PDT)
Message-ID: <4fe7c1f5-e2bd-41ed-8302-876d2eb73a50@linuxfoundation.org>
Date: Tue, 16 Jul 2024 16:05:46 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] selftest: x86: conform tests to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240712084625.297249-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240712084625.297249-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/24 02:46, Muhammad Usama Anjum wrote:
> In this series, 4 tests are being conformed to TAP.
> 
> Changes since v1:
> - Correct the description of patches with what improvements they are
>    bringing and why they are required
> 
> Muhammad Usama Anjum (4):
>    selftests: x86: check_initial_reg_state: remove manual counting and
>      increase maintainability
>    selftests: x86: corrupt_xstate_header: remove manual counting and
>      increase maintainability
>    selftests: x86: fsgsbase_restore: remove manual counting and increase
>      maintainability
>    selftests: x86: entry_from_vm86: remove manual counting and increase
>      maintainability
> 
>   .../selftests/x86/check_initial_reg_state.c   |  24 ++--
>   .../selftests/x86/corrupt_xstate_header.c     |  30 +++--
>   tools/testing/selftests/x86/entry_from_vm86.c | 109 ++++++++--------
>   .../testing/selftests/x86/fsgsbase_restore.c  | 117 +++++++++---------
>   4 files changed, 139 insertions(+), 141 deletions(-)
> 

Please check the submitting patches document on writing change logs.
The change logs in this series are bullet items without complete
sentences. I would like to see before and after output for the
changes you are making.

thanks,
-- Shuah

