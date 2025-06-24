Return-Path: <linux-kselftest+bounces-35681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A896CAE6359
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 13:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A051925F6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 11:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5782288C2F;
	Tue, 24 Jun 2025 11:10:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95509288536
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763416; cv=none; b=K7F2yOgZfKhXIOKYFWrwn0/ZS2FvWpcNeZIMjIe3NMor2sLIOvli1+iPo9CJnXiqdO/1nYBZjWSWtkH3fRqmNpg2xfpNT8Agj6mtPvw5GHDacrHM5TjLjl0IGP0SDP7pG7GDKEMR1Mi2ZSpmhq7D65Yu9ynn0ohVlhBnVemvCug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763416; c=relaxed/simple;
	bh=Simcz+dPz1lMznCnH08QtMUqetrxTlmKokt29TSkifI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqs7GZF6p4Lqdf3OjjRE8cu3yFJqhqYji2kqwwrf+UniTEFN24QlfI5CW6XdaBoHnYXcSD9OEaXRsZLqk2eEg2CalJ2pwU1fW2g8YCjBYYIeYxKNYA9EYCOin3rXDEkATxqa15vyzz6PkYjydA7IEhFWTMbgB5iSyzJg79oFutc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [IPV6:2a02:8109:aa17:ae00:b843:3b62:2e09:ec2f]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Tue, 24 Jun 2025 11:08:52 +0000
Message-ID: <86bc2557-b9cc-4767-9379-e60786b3f825@sdfg.com.ar>
Date: Tue, 24 Jun 2025 13:08:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/nolibc: avoid GCC 15
 -Wunterminated-string-initialization
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623-nolibc-nonstring-v1-1-11282204766a@weissschuh.net>
Content-Language: en-US
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20250623-nolibc-nonstring-v1-1-11282204766a@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/23/25 11:34 PM, Thomas Weißschuh wrote:
> On GCC 15 the following warnings is emitted:
> 
> nolibc-test.c: In function ‘run_stdlib’:
> nolibc-test.c:1416:32: warning: initializer-string for array of ‘char’ truncates NUL terminator but destination lacks ‘nonstring’ attribute (11 chars into 10 available) [-Wunterminated-string-initialization]
>   1416 |                 char buf[10] = "test123456";
>        |                                ^~~~~~~~~~~~
> 
> Increase the size of buf to avoid the warning.
> 
> It would also be possible to use __attribute__((nonstring)) but that
> would require some ifdeffery to work with older compilers.
> 
> Fixes: 1063649cf531 ("selftests/nolibc: Add tests for strlcat() and strlcpy()")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index dbe13000fb1ac153e9a89f627492daeb584a05d4..52640d8ae402b9e34174ae798e74882ca750ec2b 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -1413,7 +1413,7 @@ int run_stdlib(int min, int max)
>   		 * Add some more chars after the \0, to test functions that overwrite the buffer set
>   		 * the \0 at the exact right position.
>   		 */
> -		char buf[10] = "test123456";
> +		char buf[11] = "test123456";
>   		buf[4] = '\0';

Reviewed-by: Rodrigo Campos <rodrigo@sdfg.com.ar>

Sorry for the typo :)



Best,
Rodrigo

