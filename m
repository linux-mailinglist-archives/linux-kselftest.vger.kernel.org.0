Return-Path: <linux-kselftest+bounces-37220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 461A2B0334C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 00:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C15176510
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 22:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375FE1EE7B7;
	Sun, 13 Jul 2025 22:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJjPqClp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE0D2AE6A
	for <linux-kselftest@vger.kernel.org>; Sun, 13 Jul 2025 22:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752445324; cv=none; b=OFPN70VogZyc06Rg1zi9nPLh1GGPy4K9dIGAxKDO5a9lb9xeUR/GH/t2TAVcke+1hF7t3RtJxzOFHA/g8JegVJzAAW9vFtyTeLAPcN4pZmUqnoxnv3DzIcLWBcOVxWEsA/DUJH7APo45+SakWPTbEMZSEJLYhcsT5oPwCSFGPdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752445324; c=relaxed/simple;
	bh=2M05FiEV9oioJZ+K+AycdJhhGPNaMof4obeYtnotUlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOsZIhPEzdkcYvvQmAS+mZyIcKat2cC3zFc9p+xlXw5nZnSCAjJSoFEz+77yeQ8khclGWgM1UVyYJF2oQVZey2f+v0JNnJdfTWlwHGxzY68Rh1JKc+VfOU8fLLPVa1K4q7HHg/2v/O0kPwXnIf7KIlGhEdtAk2aBzSKuEV4G+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BJjPqClp; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-611a7c617a7so771164eaf.1
        for <linux-kselftest@vger.kernel.org>; Sun, 13 Jul 2025 15:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752445321; x=1753050121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNQNXDV+LG1KwYa30nsj5pHp/8wtAgv4sSv2jyxQ0YI=;
        b=BJjPqClpEjeAfzj+kQB4D8osc1Hzl0LmeKEcI6iyka+IDbDcvzY6ghH6cp9KXdz0fS
         9Lf3ltEWw7Tehc/SIeqzUil3yuJ/2sXpWBsSKN03FUKSjSWs4iUbldzR2ItSxsTBxGlj
         RNyeaIxqM/p/hAEobsobrq6CuTDn264EW+KzA5YHImPTWbbvsnzhCSLzY2wre3YfVLqd
         cFOUwLxa5p2YBbmuxlZ9zQ5dnhXpfbW8MCDL3PULX03XVxYFJDwPlD/nrm88UC22xNn5
         joFCahlQyrdbpQN0GJeDDyREhMTjah1fTo/idtpk9gyFvMzk04iVqxQMG6LL37iWQdPC
         q7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752445321; x=1753050121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNQNXDV+LG1KwYa30nsj5pHp/8wtAgv4sSv2jyxQ0YI=;
        b=lGMcM09FGFnrj4TRv78ccwJHxaDIaTDJ+kjcsu/2LNFxeJe+AmxkMdOc4L+5kT7ZAF
         PuaBwAVG9SHKwwl6bzeAQT9NLwwxNUcEMl5VLFFVuqSoRXboVB6CxG3Nwv15r785gT+K
         vOVNIMI6Qw2iEsif+zcKxJdIKYv77hTZ5xCfAtrQR8uJ8wSVIaeNwBhkYsoTDPkUCQKH
         MR/8PNFOR1ZrJuY4TBBdkO0oEoXFZz65jLJ7ZNEzzKZ+z6KS/zdpJUZx4cMO4e7JAByL
         gGDNmMYImdGwXRTWckQ4PdLcf2WOhTJ6SuPEmjlcROoUSK600odjAryybz42Je0ZodEe
         dydw==
X-Forwarded-Encrypted: i=1; AJvYcCX/I09prbIuC4QiFvMc48YnIbQHuiFjO1ss5oEYIZSDblYUi+nHjQRDTswyFMIdKWE9rc7EFxqO+uPKTgR9uI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8RXYC6a9joMkN4lpXhlDwp27SqEN0xC13QEEW2PSlikwZoYXu
	qMs8iIcUhxT+2kbbB4gaqReftej+OKkPLDOoVJlkBhKhKi2EFS4Seiu5W3Me3nDlyyU=
X-Gm-Gg: ASbGncuvKp4x09VDTLpmBrVPGstreLrUGMwcdSfMw70R+Q85aFO3BvKhMdTVFfjWkpD
	D1ocH7ZBsTVZBAbgjGA8IQgwTkNknJNmoCwOPqB1th2oPmq2IYmhO1qove8xbBLQ+qh4MOhyD1V
	YKGH7qt8JRL1YazcIHgl/YVJt9y4RiQHJ2mJ4Lw/tHM/o4yNkvT8+A0WSsithmN9y8lWBTdWPNZ
	o9Gy3u0mDfj5kXRPXqw/6QVlRzwuO1vnpV4/d0y5zGAwyijn7vPXfFYJIYb9YJjPVCgLJ6h666J
	B4xSFXAsQlrr5UeP8DWKBZjMTlFRsUiMnfPyRLwYSJNtSsrSBDJO3idMR90KxZo5AfftVjKZn6y
	A+w1CHelD5hqScJHx4Ii+mb2o+iKFTMjbbFfBLmw=
X-Google-Smtp-Source: AGHT+IEwQsLEd/PvvlHThIaSsW4kNZExxQdlVLZn5vrAx4CPWSh7+UlvjFpD889J6qWA4s1GSDuYiw==
X-Received: by 2002:a05:6820:2d04:b0:613:c7cd:3b2b with SMTP id 006d021491bc7-613e5f854aamr9473019eaf.2.1752445321545;
        Sun, 13 Jul 2025 15:22:01 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9d836a4sm1072154eaf.14.2025.07.13.15.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 15:22:00 -0700 (PDT)
Message-ID: <ceef9e43-5591-4c03-ba51-af1ccc68a05b@linaro.org>
Date: Sun, 13 Jul 2025 16:21:58 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/nolibc: add support for Alpha
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
 Matt Turner <mattst88@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20250713-nolibc-alpha-v1-1-10216333d308@weissschuh.net>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250713-nolibc-alpha-v1-1-10216333d308@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/13/25 14:08, Thomas Weißschuh wrote:
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -709,6 +709,10 @@ int run_startup(int min, int max)
>   	/* checking NULL for argv/argv0, environ and _auxv is not enough, let's compare with sbrk(0) or &end */
>   	extern char end;
>   	char *brk = sbrk(0) != (void *)-1 ? sbrk(0) : &end;
> +#if defined(__alpha__)
> +	/* the ordering above does not work on an alpha kernel */
> +	brk = NULL;
> +#endif

The syscall api is different for brk on alpha.
A change to sys_brk or brk in include/nolibc/sys.h is required.


r~

