Return-Path: <linux-kselftest+bounces-14279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E90FD93D8F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 21:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 763B0B22DFD
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 19:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF7838DEE;
	Fri, 26 Jul 2024 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GqnfLT0H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804FB39FDD
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722021780; cv=none; b=XZV8YypPgBPVJKM6yGgrwTcV4nb9AHhLth099X7l8zqjXiW6ucyWNFgx2ofDoYqY6Y73mbYfEM5WQIL2KEA3jJULLh663U5UpHU+N3/rlfEXYf+x3vPJH2ODrGylIpG+NAmP7SZ816sr63vNaDqGlUK+ZmgUvSB+4E6gcE+4C6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722021780; c=relaxed/simple;
	bh=uPi2/QCuL1L6gevpvRup/e/Yocdn5tdYrzX01UdxSUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdvXP8rPr4g+6kv1KAWlV6j18BP0JwBhIYIbwZ4nf4WTMTL2W6g3ad5UYya4Dxx2muXBvJ3xwdGSkqRLZ3UkqCHfw2Goexs8RU3K1IjREZ1AkgrNSUZ53GfSCkf26+JV8BbSXLTbzMeMRCbNJ2AlKgmqSam4DtB7QG3IqMpAIs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GqnfLT0H; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81f8add99b6so8210339f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722021777; x=1722626577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eW06teyGDvI4Lz5n4M9E/YeQcIqHaO4UJHqvG8OK2OY=;
        b=GqnfLT0HmFdWKrBJW1mFy+rDWPeir9q8UIUX+60shxgyOxJpxbCKJlwoP6zSO4HUO3
         XBVH3SmNBQ/rzJKz/4gyWqwV5ba/N49jKbwsX0AVjHkCjlWAtTmSj9L9VYDuUVdGnQrG
         P5A75/kLk77KqjoKc9AjUUJX3E6LoNsQBtub4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722021777; x=1722626577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eW06teyGDvI4Lz5n4M9E/YeQcIqHaO4UJHqvG8OK2OY=;
        b=fQQG/VWx4hAOGgyvJsL4eUN2+Xgu5s6VLVYcrTKeK/GGua3AWMwiTt8yNb+LHxHo49
         bb+fGjH6vI4JYah1S2yUoKS9YJ8JFFl0tLZGkqDU577Qcpfw+MVMuUJV9ffUDvXFSM1e
         wt/F/hoT/7Kjiky75TAEwu1GNwIm+mxgVMKj+GJZmWjtoPHAUpHrzjfFUVPDYDEp8b2q
         CjymIAv73RKfbj4RMwlbcLWRSkzwstaKoDSAIdeGkIjuV56Eo0iVu+BCiRrslWq3Liws
         6RA6vFeWfJ64zE/U85aH3F9ti4P8RDmM0xbTzl683qJxezeUyCAFDgjgMJHFBdJPuMqa
         gKvg==
X-Forwarded-Encrypted: i=1; AJvYcCUZnUMic4t6BYsHYJ7ef67uiVy4AACzITKZ7GXXwhY+Qx9XwvZqdzPi6C0gbwFueMRKnVy3Zi+MKqoGjgn/I8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk+4IWyixuUCdWLMge24HlAHSGf2Cf901CGJ/bGwJh8wt+VTZA
	siqL62bUtw22Wlhl7ZSOocPy3oNCCEpmW6bYnusZbyyr1LpmGF9ln4HmWW7OMIY=
X-Google-Smtp-Source: AGHT+IE/Xpqjus/XbsRArDFYHuM7ATEqowy0ociDJbvuna0HrVkV9l/qKkgJyFzW/YcnXzbdxXVTgg==
X-Received: by 2002:a5d:9605:0:b0:807:6708:e35b with SMTP id ca18e2360f4ac-81f7cf104a5mr471055339f.0.1722021777603;
        Fri, 26 Jul 2024 12:22:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fc414desm964613173.155.2024.07.26.12.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 12:22:56 -0700 (PDT)
Message-ID: <55294e1b-c6ac-4c6d-a9b5-cd3d030468bc@linuxfoundation.org>
Date: Fri, 26 Jul 2024 13:22:56 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests: lib: remove test_bitmap
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kees@kernel.org,
 David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <20240726110658.2281070-4-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240726110658.2281070-4-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/24 05:06, Muhammad Usama Anjum wrote:
> Remove the test_bitmap as it has been converted to kunit test.
> 

Care to give some commit information on this change?
This change will take the ability away to run bitmap tests during
boot - as it will now be dependent on kunit

Why are we making changing like this without thinking through?

> Cc: kees@kernel.org
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/lib/Makefile  | 2 +-
>   tools/testing/selftests/lib/bitmap.sh | 3 ---
>   tools/testing/selftests/lib/config    | 1 -
>   3 files changed, 1 insertion(+), 5 deletions(-)
>   delete mode 100755 tools/testing/selftests/lib/bitmap.sh
> 
> diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
> index ee71fc99d5b51..386c5887c0d65 100644
> --- a/tools/testing/selftests/lib/Makefile
> +++ b/tools/testing/selftests/lib/Makefile
> @@ -4,6 +4,6 @@
>   # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
>   all:
>   
> -TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh scanf.sh strscpy.sh
> +TEST_PROGS := printf.sh prime_numbers.sh scanf.sh strscpy.sh
>   
>   include ../lib.mk
> diff --git a/tools/testing/selftests/lib/bitmap.sh b/tools/testing/selftests/lib/bitmap.sh
> deleted file mode 100755
> index 00a416fbc0ef0..0000000000000
> --- a/tools/testing/selftests/lib/bitmap.sh
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -$(dirname $0)/../kselftest/module.sh "bitmap" test_bitmap
> diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
> index 645839b50b0a2..7d3b1de29d3d6 100644
> --- a/tools/testing/selftests/lib/config
> +++ b/tools/testing/selftests/lib/config
> @@ -1,6 +1,5 @@
>   CONFIG_TEST_PRINTF=m
>   CONFIG_TEST_SCANF=m
> -CONFIG_TEST_BITMAP=m
>   CONFIG_PRIME_NUMBERS=m
>   CONFIG_TEST_STRSCPY=m
>   CONFIG_TEST_BITOPS=m

thanks,
-- Shuah


