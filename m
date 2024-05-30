Return-Path: <linux-kselftest+bounces-10936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417A08D520D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 21:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C21C281FA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 19:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD9156B91;
	Thu, 30 May 2024 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EjI8vXcm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63456B7C
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717095855; cv=none; b=NYl2ZQrETwNSFJqq9Zo9u1zdgRiE6KE1JBS4XLuFi/CkOEZKqA6x+PiP4LvWyezRkCeqgC52Om2sigZiXy7B3NrA1n2rHDNr7xhBDI+r6R6u5Z+DTHTPwrwJ/LT1gNlVT8NV0PpHfQyc9ZRi37ymfX3++KgHeM6x8H2RZy7J0vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717095855; c=relaxed/simple;
	bh=XqkU5JF0xqJNCcqcOzUAWXI74SlBn5htldgYf/jMNnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XY/rr0ZUaWpS/rH2HAYxIAzJaXvx2echLl7bhKU2VTNgwVGn6QgQndRHai38iNT3cfOCTSyljxPzQ37q4iyr6W/WY5NHXD9ryr3HZZRMxMD4O5sE+G4wANpOEODG93ESvi1gkIBFSLCTvF+dgv4iLiwcJ8C7vQiTh1a7GIH3ZG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EjI8vXcm; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7ea12d448ffso6193239f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717095853; x=1717700653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUBR/IKrUPGm3wyGOLSg3Fiy25XwZdoN4lNos6i64TY=;
        b=EjI8vXcmq0kmNg7aKKoGoWcV4o9pXlcLcLoR+TD+m1w+SQY8dNtKILjVGozlBH9fjA
         StTJgAsEct0adGqfTbR11q5HMDuyija/IBXNI7syjQQK1n+Owc3mp5ho9gcj1KHKmB31
         8QcnWdiO5+GyldLpXRtsQdzuiqobok1qFFD94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717095853; x=1717700653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUBR/IKrUPGm3wyGOLSg3Fiy25XwZdoN4lNos6i64TY=;
        b=QmXm8POPlzInEww3It0uEARs5emwEOt5B4FPrEEq02AVINSsSsLjJWuX2coe1cqgBf
         fG+YrqRkYw2aPwNOCnzZmc0KurkQggqMjbD+ZvLX/yiZLGu82A09BFhIznqfr9sqXZ90
         +k6jCbaCVyZhI7JWxaFduxhHT13BqI7QkCLZjcl5vFLvyj2S2D2FPsxAsr63lZuILOjq
         /ULID1OITyBISvrWyLaGw3tV98OevLG4wMib6P90zm2iiqAhOhFT527hdf0Io9zf1AjM
         kBOjbgdln+n2p7eD6iI+I1Cq5aNxIcgPZi3g4kXVcGNUwDriGIuGyvmJHykkM9zrBaI/
         b7pg==
X-Forwarded-Encrypted: i=1; AJvYcCWc/UIh8V5INNdUsuA6ssCaF0T9RpQU6Xddy9uhv2SANT9F6lh8AqJY44W2mDP7wFGqFt+R7Zt2nBQ//aizTrrx1/hrWV6RyESBkevrfoA3
X-Gm-Message-State: AOJu0YybubZ2tMtAjyevLlokg0Aus+8+O2lZZxT1D54rPlxK9i+U+wiG
	1HR3QA2l/ZlHehMlK5BL9R1DL/vNovcwVtr02aIHQBDvS2GDdBOI6ZGYcxj7LXU=
X-Google-Smtp-Source: AGHT+IHDstNgMVZwtRqmSZtTYuTC1xPHQ6r9uQg6kXwAmLCcW28lA/hy5sidfUmU/JPMFdijGRRXzw==
X-Received: by 2002:a05:6e02:180a:b0:36c:5440:7454 with SMTP id e9e14a558f8ab-3747df5104cmr34457525ab.1.1717095852742;
        Thu, 30 May 2024 12:04:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3748a27959fsm668615ab.75.2024.05.30.12.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 12:04:12 -0700 (PDT)
Message-ID: <94fe2649-8def-4f2a-ba5f-19ae8a4226bf@linuxfoundation.org>
Date: Thu, 30 May 2024 13:04:11 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/futex: don't pass a const char* to
 asprintf(3)
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Edward Liaw <edliaw@google.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240529022938.129624-1-jhubbard@nvidia.com>
 <20240529022938.129624-3-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240529022938.129624-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/24 20:29, John Hubbard wrote:
> When building with clang, via:
> 
>      make LLVM=1 -C tools/testing/selftests
> 
> ...clang issues a warning, because test_name is passed into asprintf(3),
> which then changes it.

Please include the warning in the commit log.

> 
> Fix this by simply removing the const qualifier. This is a local
> automatic variable in a very short function, so there is not much need
> to use the compiler to enforce const-ness at this scope.
> 
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
> 
> Fixes: f17d8a87ecb5 ("selftests: fuxex: Report a unique test name per run of futex_requeue_pi")
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/futex/functional/futex_requeue_pi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> index 7f3ca5c78df1..215c6cb539b4 100644
> --- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> +++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> @@ -360,7 +360,7 @@ int unit_test(int broadcast, long lock, int third_party_owner, long timeout_ns)
>   
>   int main(int argc, char *argv[])
>   {
> -	const char *test_name;
> +	char *test_name;
>   	int c, ret;
>   
>   	while ((c = getopt(argc, argv, "bchlot:v:")) != -1) {

thanks,
-- Shuah


