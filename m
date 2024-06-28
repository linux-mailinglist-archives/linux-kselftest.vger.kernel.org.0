Return-Path: <linux-kselftest+bounces-12950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC0591C816
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 23:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B077B232A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 21:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD007FBDA;
	Fri, 28 Jun 2024 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O1dHgMdV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FE57F7FC
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609942; cv=none; b=DMeWc6m36XJ3HaVpyu1C1pDJ80kVkxendbe04WCwQrtd1f47GPvBEmhgNtggwudK9eA6y/qQo3w5vwrdn0sIC5C9W8GMT1kZGhLppSTUQD2ZyV3VAcXNVUDV4J1EI1qlUqsWcUBDZBANNjkn5nA9KDLv5AMabWC0O7ikcerrKNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609942; c=relaxed/simple;
	bh=scWs8AjqfrqRGXwxciWVjYMi3tdfJ1iOV0WlCKbBrRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SniUaZFSIbJJm8oYWSGwbY39VmD7oTa91c/NxE9MJmFyDZImCs6ZXmCKfVEa9J4XmAsDuN+k9XblHfLRm541rV+5yy2vKbk+UN9x9EnNv0FDsoUMIPZ2uTm924oueWJMD8mIRjjbrZZbGcJnk7ZCMyR9jcTf7N/V7DYa/q4Uk18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O1dHgMdV; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3772749962dso703465ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719609939; x=1720214739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=It+RDzHG+5ogUHKIy7nb7bB9vaKghvmsmBT3k+kyomY=;
        b=O1dHgMdV2D8QoNBxDpspyNDLcoAT44XjQd8rhcvZ5z7exJ6RHsQhHk79pqCUiMSGAC
         ggyitmoUggrHHJQ8jn21FeUr83ZFFh2l4unT0PnYN3f5+JZMNZorc/3PqiiZ0D2IamJp
         7IlMYrvfLAhsmlqtdr34TztFVS+usZbEkeVeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719609939; x=1720214739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=It+RDzHG+5ogUHKIy7nb7bB9vaKghvmsmBT3k+kyomY=;
        b=mWCvefIH6ZBxbGTyQ1BZstBWWw9JMHEGCe9vPUutCmvVitGax8/928tR5c3ZJ7Foco
         B5dIavD8SCQB3BgAOgNARkH85OctFdrcDkelaEKqqiZ0MJsLvw63OAWhHAhkWtbprPOe
         gwvCP/2GUll81YMXlgjCou0YoZ6olTcEBdLRZ8jeotwMT7xyaNsdQ7RDifwRoDJrHY5W
         02TzIdxBHaMUtlazSa6ITZYgxD8gZzi5UQ/ze0V3qw7dDokrecfJEfFxzZi9M628unGF
         yOxDCTfPbYlXN6iUKT7ERDMjLg7xsnnyPuRI7rsbxVlnHvfMOvn/+1ev+DysVahvUApX
         w3Bw==
X-Gm-Message-State: AOJu0YyWmoTARn6hWp+EsEBpPDYW6DCiDK6CEKQIMiXEzJfsM6BMDH4Q
	3T0dOke61cgF+DoZAi1jAuEoT6kVAvC3P4zU4MNzkhOtwXUysbu11y0aMM9Oz2A=
X-Google-Smtp-Source: AGHT+IHiUQdGE9H3dHPJzOzgKCJ1Ty5wnxw9nJM9Yar3NdvtWjfQ+U2E7MMQ8jVQti8VlicMejQ9yA==
X-Received: by 2002:a05:6e02:1583:b0:376:408f:585b with SMTP id e9e14a558f8ab-376408f5927mr199339285ab.1.1719609938755;
        Fri, 28 Jun 2024 14:25:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad4370bedsm6015165ab.67.2024.06.28.14.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 14:25:38 -0700 (PDT)
Message-ID: <91d2f8dd-0de5-4959-8fd4-4c142b6a4f62@linuxfoundation.org>
Date: Fri, 28 Jun 2024 15:25:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests: kselftest: also use strerror() on nolibc
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240426-nolibc-strerror-v1-0-76a4c9c5271d@weissschuh.net>
 <20240426-nolibc-strerror-v1-3-76a4c9c5271d@weissschuh.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240426-nolibc-strerror-v1-3-76a4c9c5271d@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/26/24 05:08, Thomas Weißschuh wrote:
> nolibc gained an implementation of strerror() recently.
> Use it and drop the ifdeffery.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   tools/testing/selftests/kselftest.h | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index 541bf192e30e..f4bfe98c31e4 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -161,15 +161,7 @@ static inline __printf(1, 2) void ksft_print_msg(const char *msg, ...)
>   
>   static inline void ksft_perror(const char *msg)
>   {
> -#ifndef NOLIBC
>   	ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
> -#else
> -	/*
> -	 * nolibc doesn't provide strerror() and it seems
> -	 * inappropriate to add one, just print the errno.
> -	 */
> -	ksft_print_msg("%s: %d)\n", msg, errno);
> -#endif
>   }
>   
>   static inline __printf(1, 2) void ksft_test_result_pass(const char *msg, ...)
> 

Sorry for the delay o this.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

