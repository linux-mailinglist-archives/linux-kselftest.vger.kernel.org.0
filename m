Return-Path: <linux-kselftest+bounces-33674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C822AC29E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 20:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30649540C47
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 18:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3874A297A61;
	Fri, 23 May 2025 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GkRVW71b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D62218E050
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748025988; cv=none; b=B4bVfkMiUUZ0hvD+A9cdFZZKmru/vIQAyOqysqnnySF3Y3u/qNDiasoXqtbg/fos0xrYzg693m2chgAd9PxgNRNBjXhlY8CJHVpyzTBr6Ug2ojFPsS/xYEfIr52nwmNVYSCBfhAZgt54hACldkU9VSs0RwcR87T4fzzJRMeGJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748025988; c=relaxed/simple;
	bh=dZpgjJTi0MJt9iTrmqEP3ZYL1GmqOyNKh5PQfgkUMis=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dga3mD3Gd8DFBN8HaLV5XDRsfz1Wee27PzzjuY8DfL/I3WE57P3056uLzeMu/YKCWCFIsAEOCvCgMK/TmQ9lx96080q/fzsVM6Xtr68SjwSzmbkGVAJ1qM7P+UbZbvvdagJG6UWvXHN1QIgGa6Xt8w2gaVtrFPWcR8B/fYPH07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GkRVW71b; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-86135af1045so13347439f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748025985; x=1748630785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sx1YiNkbzCH8yAAqTlThmCo4ScduhJ4fEOgmS9RLqNE=;
        b=GkRVW71bjWtpYybLOSUi/B/TGhIUO/esgtd753AQFVj/cm0l2C2xDtzfz7kfU5FW4K
         3tYYSlokmEJHaAXb4brP4lX7G+Aj1mWuB7iPAr/4MnoK+jTwLjKZ0qLYM4TVtwH8IXtx
         EsguG+fnxNClsp+3nXXqBDlIliPYo1VaeohNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748025985; x=1748630785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sx1YiNkbzCH8yAAqTlThmCo4ScduhJ4fEOgmS9RLqNE=;
        b=ZXXJdqkngHe5TP0GZmgo2J7f+jAoAzEWTvPzAUIdFOgPW7dqu0NMu7h8U4FQokpkks
         7qGSwSdAwI1Dr7kf5UhKBu5p+dqq4HF3lgRtnyfiXBIWSLBHpfkyY1DlMIug242aHqbd
         Fz/GXjYbr9Xval2PKzgV+SYuVH9zaRVtKXwJExl/NQEHXhGT8QM8EJm/D9KN1aS1YLaC
         RRpgkTmQnQBSzC/tPi+XnQWespHHxwshHVSvwFPnm9pOC/nOyhsOPigjveZByD5IvBUh
         MfRwg+LlTlFc7YfFF3JLQIc/UVvEu4XU6bS5MrRvk+JjQpZwITgVjEfWPFxiLy5wfFxX
         Kivg==
X-Forwarded-Encrypted: i=1; AJvYcCVYUyzzKo6pMNF/vLgRTj4KKnz7cEJiCucZHQtTIxzpiYljizr2HH1QKUDwjdPfDWOHy15mxQ/N7MWJUmkkKBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBpgyMivxABHuJDV71ffFhmFttEteRYUyD4Hkl5EGtgGxtTb8
	CcCzaElds4rcb26lTJIB63fTyn1Xc7a8c3MRWA42P9zKI6ND2OHVRn4qotVq3SQFaoE=
X-Gm-Gg: ASbGncvnjtHhavqZfj4S5TkQ/Y9wFwEqn+EdB0mTpv/3Od8rZ2HbBJT31Ipne5uDxpU
	J4f35ne0ONgYyc9I9uj9/SgZaefj6FBmll9kPuoG1PoNKsl3NeHweJ5qvnPa3Bw4Sckag3bZXzE
	ulYYp4l6fTupnwvvVH4BsS8bNwXXSApSZ9rV8644zNzXjq6tNoSKOZjYQ5cPru0Asw2oI4D5w16
	6+hqVxPThnf86tWztywMpiUp0af4Z01ExZYDal2E7rJtjhJClUrzbmX0zr0dn1KaDz7ZMPbEkfh
	nMwH0oqU/4npFAGbEGkCDGodpNZxdeiYe/qjTDILF7nzepo6wiZw7h0Uc271Zg==
X-Google-Smtp-Source: AGHT+IGDOo5oijcYfP+wjUEk9FHyzN59Q1kmzheuHARtrPQ6h1ULMxF03dEGfdM26oxYajyQMiejvQ==
X-Received: by 2002:a05:6602:4896:b0:864:657e:caec with SMTP id ca18e2360f4ac-86cbb88d3f7mr47292839f.10.1748025985178;
        Fri, 23 May 2025 11:46:25 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc38a5besm3684310173.13.2025.05.23.11.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 11:46:24 -0700 (PDT)
Message-ID: <bd22525a-dd4c-47b0-8cd0-52c0e8c64ca6@linuxfoundation.org>
Date: Fri, 23 May 2025 12:46:24 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kselftest: x86: Improve MOV SS test result message
To: Brigham Campbell <me@brighamcampbell.com>,
 linux-kernel-mentees@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250523073220.112238-2-me@brighamcampbell.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250523073220.112238-2-me@brighamcampbell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/25 01:32, Brigham Campbell wrote:
> Apparently, this test completes successfully when it completes execution
> without either causing a kernel panic or being killed by the kernel.
> This new test result message is more descriptive and grammatically
> correct.
> 

The change log description usually is in imperative - e.g:

"Change test result message to be more descriptive and grammatically
correct.."


> There are no changes in v2. I'm resending this patch because I addressed
> it to the wrong email for Shuah.

Version change information goes under the --- after the Signed-off-by

> 
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>   tools/testing/selftests/x86/mov_ss_trap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
> index f22cb6b382f9..d80033c0d7eb 100644
> --- a/tools/testing/selftests/x86/mov_ss_trap.c
> +++ b/tools/testing/selftests/x86/mov_ss_trap.c
> @@ -269,6 +269,6 @@ int main()
>   			);
>   	}
>   
> -	printf("[OK]\tI aten't dead\n");
> +	printf("[OK]\tkernel handled MOV SS without crashing test\n");
>   	return 0;
>   }

thanks,
-- Shuah

