Return-Path: <linux-kselftest+bounces-14590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFD7943926
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 01:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319FEB24BF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 23:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A7516D9B3;
	Wed, 31 Jul 2024 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F6/IkK1t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F028B16D4F7
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722466874; cv=none; b=iu9H7HbstGx43eg3omNLljGHkRcYWYiCFR0e4POhO+Pjy1hjw8q5bWLsx5zAYoUsU0fydcvub8biHj1+zQ48QWEtvY5O0SiuIMLDA40rlX+d0TFRoFZzQNPRsanfYJvCq3/t7qirCCi7wg9zGf73Zon06oX9i0kyUVqPB6fAd9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722466874; c=relaxed/simple;
	bh=XS+XtaKZoRB/ayFSxyFtnEqz9q7ORmchzY5GNKVvXFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJvQzbB0O6ikNp3Rm2cLs6n2zItY1UBTJURAa0Z2QVdl+e98OAV2JmsycchVMw2JRcGgQXh0yt2LdtS5IybvvHDs/PIww/DyWsbf90jo9lfynDhbFbFV8ChAxELdWJ5R3C40i2wMktEb/2gbd4pQp60Q3/8AwOgcwCqHr2zVlGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F6/IkK1t; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-81f7faff04dso40185139f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 16:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722466871; x=1723071671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kDwjdwiPcSpBbMQWeCAjcPyjGJaiNdBEjkZt2AO8miQ=;
        b=F6/IkK1tSHIKDUecNg8wq+VTG+yYExsdpHnAM8A4+UerjsHAvXMDlPAq3IX/FU5Wj7
         AYL6Djl88sHiuSE7GWVSEU9vPhvlI7e7kWZAkjEWFKznixBJ0LQNb4m9zXujVmPnhF9K
         ItZrflwR38xNtu9uDV5GRUxGCDii39q0h3XnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722466871; x=1723071671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDwjdwiPcSpBbMQWeCAjcPyjGJaiNdBEjkZt2AO8miQ=;
        b=F1dXulhO8zsH1yvzmU0aZC2DyKI3l12n0oC5JGIk7pQuAepsHfpzRuz21gsrd74yKP
         q5gUdstn/bj7XOO9qTnKBVmddp+6TySSJ2YNNAgk1poxJqvDTlhTaoUhXuQ63rekTycd
         IqZdvmuts4gI8kQQmQn3eiRIPIkrkgRA/qVn7ZM9+NTMYvVyFfx3ABBAkrw3qneEgqj0
         O+ZBKDEDILKujPLz7KwDo4hZVkpW+eE6ygxromzxAQU6YnFkHUdkvSbMYkfoLpJpx1DR
         3Ze1qX6eyyijp4+PIOXpR23DJcqSheGzz0t5xPvg5lRYXhJI8G3AN3/nvuHq7wrqgvLP
         pupw==
X-Forwarded-Encrypted: i=1; AJvYcCUGQebT/sF0S+eXoZZCcgi5vYLGbx9gxFW5rfZBZpdAwZ38rEuQy32hdX0lA+57kvK0mShyVstUiq1F5bXWj0lwJvhTY0WrgQ7pJYGfeyK1
X-Gm-Message-State: AOJu0YzFPIm1g5v7VS7Z694pb9W0G3Itj5BjW0hqKXgsIaJmdZ4h3A7M
	TmR7umyUrC2Py/43x6rikyFUjoTweGABtROZeJ3T6MLTde5mSsEWKEFWAoXKwlM=
X-Google-Smtp-Source: AGHT+IHyabB8AYt4mXefBvL2HOiAWnjHK9oUHizasDsbvE0cOYxuXwSiVcCgvlXkxRAWnVk0bmukpg==
X-Received: by 2002:a5d:958a:0:b0:803:f97f:59e1 with SMTP id ca18e2360f4ac-81fcbe581b4mr64114239f.0.1722466870324;
        Wed, 31 Jul 2024 16:01:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fbd9d72sm3438040173.98.2024.07.31.16.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 16:01:10 -0700 (PDT)
Message-ID: <3956cee8-1623-42d6-bbc6-71b5abd67759@linuxfoundation.org>
Date: Wed, 31 Jul 2024 17:01:09 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools/nolibc: add support for [v]sscanf()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net>
 <20240731-nolibc-scanf-v1-1-f71bcc4abb9e@weissschuh.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240731-nolibc-scanf-v1-1-f71bcc4abb9e@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/31/24 12:32, Thomas Weißschuh wrote:
> The implementation is limited and only supports numeric arguments.

I would like to see more information in here. Why is this needed
etc. etc.

> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   tools/include/nolibc/stdio.h                 | 93 ++++++++++++++++++++++++++++
>   tools/testing/selftests/nolibc/nolibc-test.c | 59 ++++++++++++++++++
>   2 files changed, 152 insertions(+)
> 
> diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> index c968dbbc4ef8..d63c45c06d8e 100644
> --- a/tools/include/nolibc/stdio.h
> +++ b/tools/include/nolibc/stdio.h
> @@ -348,6 +348,99 @@ int printf(const char *fmt, ...)
>   	return ret;
>   }
>   
> +static __attribute__((unused))
> +int vsscanf(const char *str, const char *format, va_list args)

Is there a reason why you didn't use the same code in lib/vsprintf.c?
You could simply duplicate the code here?

With all these libc functionality added, it isn't nolibc looks like :)

> +{
> +	uintmax_t uval;
> +	intmax_t ival;
> +	int base;
> +	char *endptr;
> +	int matches;
> +	int lpref;
> +
> +	matches = 0;
> +
> +	while (1) {
> +		if (*format == '%') {
> +			lpref = 0;
> +			format++;
> +
> +			if (*format == 'l') {
> +				lpref = 1;
> +				format++;
> +				if (*format == 'l') {
> +					lpref = 2;
> +					format++;
> +				}
> +			}
> +
> +			if (*format == '%') {
> +				if ('%' != *str)
> +					goto done;
> +				str++;
> +				format++;
> +				continue;
> +			} else if (*format == 'd') {
> +				ival = strtoll(str, &endptr, 10);
> +				if (lpref == 0)
> +					*va_arg(args, int *) = ival;
> +				else if (lpref == 1)
> +					*va_arg(args, long *) = ival;
> +				else if (lpref == 2)
> +					*va_arg(args, long long *) = ival;
> +			} else if (*format == 'u' || *format == 'x' || *format == 'X') {
> +				base = *format == 'u' ? 10 : 16;
> +				uval = strtoull(str, &endptr, base);
> +				if (lpref == 0)
> +					*va_arg(args, unsigned int *) = uval;
> +				else if (lpref == 1)
> +					*va_arg(args, unsigned long *) = uval;
> +				else if (lpref == 2)
> +					*va_arg(args, unsigned long long *) = uval;
> +			} else if (*format == 'p') {
> +				*va_arg(args, void **) = (void *)strtoul(str, &endptr, 16);
> +			} else {
> +				SET_ERRNO(EILSEQ);
> +				goto done;
> +			}
> +
> +			format++;
> +			str = endptr;
> +			matches++;
> +
> +		} else if (*format == '\0') {
> +			goto done;
> +		} else if (isspace(*format)) {
> +			while (isspace(*format))
> +				format++;
> +			while (isspace(*str))
> +				str++;
> +		} else if (*format == *str) {
> +			format++;
> +			str++;
> +		} else {
> +			if (!matches)
> +				matches = EOF;
> +			goto done;
> +		}
> +	}
> +
> +done:
> +	return matches;
> +}
> +
> +static __attribute__((unused, format(scanf, 2, 3)))
> +int sscanf(const char *str, const char *format, ...)
> +{
> +	va_list args;
> +	int ret;
> +
> +	va_start(args, format);
> +	ret = vsscanf(str, format, args);
> +	va_end(args);
> +	return ret;
> +}
> +
>   static __attribute__((unused))
>   void perror(const char *msg)
>   {
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 093d0512f4c5..addbceb0b276 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -1277,6 +1277,64 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
>   	return ret;
>   }
>   
> +static int test_scanf(void)
> +{
> +	unsigned long long ull;
> +	unsigned long ul;
> +	unsigned int u;
> +	long long ll;
> +	long l;
> +	void *p;
> +	int i;
> +
> +	if (sscanf("", "foo") != EOF)
> +		return 1;
> +
> +	if (sscanf("foo", "foo") != 0)
> +		return 2;
> +
> +	if (sscanf("123", "%d", &i) != 1)
> +		return 3;
> +
> +	if (i != 123)
> +		return 4;
> +
> +	if (sscanf("a123b456c0x90", "a%db%uc%p", &i, &u, &p) != 3)
> +		return 5;
> +
> +	if (i != 123)
> +		return 6;
> +
> +	if (u != 456)
> +		return 7;
> +
> +	if (p != (void *)0x90)
> +		return 8;
> +
> +	if (sscanf("a    b1", "a b%d", &i) != 1)
> +		return 9;
> +
> +	if (i != 1)
> +		return 10;
> +
> +	if (sscanf("a%1", "a%%%d", &i) != 1)
> +		return 11;
> +
> +	if (i != 1)
> +		return 12;
> +
> +	if (sscanf("1|2|3|4|5|6",
> +		   "%d|%ld|%lld|%u|%lu|%llu",
> +		   &i, &l, &ll, &u, &ul, &ull) != 6)
> +		return 13;
> +
> +	if (i != 1 || l != 2 || ll != 3 ||
> +	    u != 4 || ul != 5 || ull != 6)
> +		return 14;
> +
> +	return 0;

Can we simplify this code? It is hard to read code with too
many conditions. Maybe defining an array test conditions
instead of a series ifs.

> +}
> +
>   static int run_vfprintf(int min, int max)
>   {
>   	int test;
> @@ -1298,6 +1356,7 @@ static int run_vfprintf(int min, int max)
>   		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
>   		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
>   		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void *) 0x1); break;
> +		CASE_TEST(scanf);        EXPECT_ZR(1, test_scanf()); break;
>   		case __LINE__:
>   			return ret; /* must be last */
>   		/* note: do not set any defaults so as to permit holes above */
> 

thanks,
-- Shuah

