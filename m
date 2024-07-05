Return-Path: <linux-kselftest+bounces-13247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFBF928D29
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 19:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4337E1C2111A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 17:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D3016D9CD;
	Fri,  5 Jul 2024 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KmAuRrDB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196E114A4C1
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Jul 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202011; cv=none; b=KUgiC0q+OZXTgaBraw+Q4NlKoP3JHDej7Y2aX0Yu0YuBkAI3qrMrpS+IjNvmkFEuifzyS5fw1/A3fJohXsQv7+gmCql5VLGFmxZ93H4aphxllFtjKWyXXnXuiVoqpvHOEltozYAqoxuwNcBcJhtGKmvwGYhLlSMht27lG1yHVfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202011; c=relaxed/simple;
	bh=uyFT9HitKgqEW01zxE70/QdEA0bRn6fCTZf+R820kl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQWoq+SRDjB5zNR5+l2JzC5xGz7DQRa2IfEvHCsJJzhCx1H5FHcGri3Y4rWBDnkuma++hbgJsYr5HBAbIzGz7tM1QkwLeFWyRhPAvZdzZO5h55dTY9OWZ7aR+/tqCbz4wclBmFYDNrfw9dySJJm+BQ+B/xwfk7DkHVfEKihXKGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KmAuRrDB; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f608ed30e9so7586039f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jul 2024 10:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720202007; x=1720806807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOteYgqQJ+bgjXyE03h9KjUtRQZzhDobMs9njBVn+Zg=;
        b=KmAuRrDB6E0FJn4fIBGDp7OrKam+i3ix7Fujcgij5dGsjZTdFSyPXTbJS/SJJPU7lZ
         fVRk3c/VZhFMfTUYRdVD2DpOr51MGQxkpTWrSLqo86JIDzwaVFpxdkiGgcUJrPtZ+Hnl
         ZSOy70MW6XjadhCsPMvuI7+HU0eqvgJKA6y5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720202007; x=1720806807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOteYgqQJ+bgjXyE03h9KjUtRQZzhDobMs9njBVn+Zg=;
        b=M2MQ1K0tBOTpH4bT+MOxYJXwgplMcFimaDq7sJrKkNqLCcuPzOHTdIRTWibnqd6xC7
         XUPh2ahtLmsuuYkDDGEuGx1HNn7DkEfuo0ys0+a+uUgyGRx8lzH2rtXYa1+YkePMCbNU
         zqJxCtKgagwCAzfvXJrd8DzuahqPQtTvE0KMcpcLo+0h2deAx9W8xtBHWwuOJb7ahtCh
         G6iWXcBIGii2POtNABXVth7cF+wxV1kxZAkyrZK+PmndsFNU6zLPfVKzMxN0HZxj3K4v
         qe51dxoWatTf/k46nbTh6KV2fU6Ok35v9dYhp2sgcGmrkY1wU1GtiZF2XexT2XQ5d1cy
         Dogg==
X-Forwarded-Encrypted: i=1; AJvYcCV6bybCzo26NID5cd3jkn9NeS9fXxsz27xdzPgexjk8lnv7ZuaMhVZVS45BaO/7eot4tYgUAAWRMw2uBd96NugsubZzGWX+NnOPJ8ZlEOe3
X-Gm-Message-State: AOJu0YwwoOc7jkoiwAYJhDcIvIwKryIYB/upvnsJcn57OqvxA0z59Zh3
	3mKA3QVnUtkPDlXPjjXZstgaDVYa6wuiETsbGkp89FHW4G5dr5LuNNeeHlIzCFk=
X-Google-Smtp-Source: AGHT+IHK4jmkVN706hYjIYQoimuJ3Ci3Gxn4jUrYR13K4WQUbZ0Trl+AvDCNQiX6/4Mz9j++jcnWfg==
X-Received: by 2002:a05:6602:6103:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-7f685d1fa0bmr38315939f.2.1720202007303;
        Fri, 05 Jul 2024 10:53:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f6375116c3sm333608239f.30.2024.07.05.10.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 10:53:27 -0700 (PDT)
Message-ID: <9b59fc84-2d78-4304-9f39-3a495e438af8@linuxfoundation.org>
Date: Fri, 5 Jul 2024 11:53:26 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] selftests/mm: remove partially duplicated "all:"
 target in Makefile
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240704023324.83564-1-jhubbard@nvidia.com>
 <20240704023324.83564-3-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240704023324.83564-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/24 20:33, John Hubbard wrote:
> There were a couple of errors here:
> 
> 1. TEST_GEN_PROGS was incorrectly prepending $(OUTPUT) to each program
> to be built. However, lib.mk already does that because it assumes "bare"
> program names are passed in, so this ended up creating
> $(OUTPUT)/$(OUTPUT)/file.c, which of course won't work as intended.
> 
> 2. lib.mk was included before TEST_GEN_PROGS was set, which led to
> lib.mk's "all:" target not seeing anything to rebuild.
> 
> So nothing worked, which caused the author to force things by creating
> an "all:" target locally--while still including ../lib.mk.
> 
> Fix all of this by including ../lib.mk at the right place, and removing
> the $(OUTPUT) prefix to the programs to be built, and removing the
> duplicate "all:" target.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Why does the summary say mm ?

  selftests/mm: remove partially duplicated "all:" target in Makefile

> ---
>   tools/testing/selftests/vDSO/Makefile | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index d53a4d8008f9..209ede5de208 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -1,16 +1,15 @@
>   # SPDX-License-Identifier: GPL-2.0
> -include ../lib.mk
> -
>   uname_M := $(shell uname -m 2>/dev/null || echo not)
>   ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>   
> -TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_test_abi
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_test_clock_getres
> +TEST_GEN_PROGS := vdso_test_gettimeofday
> +TEST_GEN_PROGS += vdso_test_getcpu
> +TEST_GEN_PROGS += vdso_test_abi
> +TEST_GEN_PROGS += vdso_test_clock_getres
>   ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
> +TEST_GEN_PROGS += vdso_standalone_test_x86
>   endif
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
> +TEST_GEN_PROGS += vdso_test_correctness
>   
>   CFLAGS := -std=gnu99
>   CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
> @@ -19,7 +18,7 @@ ifeq ($(CONFIG_X86_32),y)
>   LDLIBS += -lgcc_s
>   endif
>   
> -all: $(TEST_GEN_PROGS)
> +include ../lib.mk
>   $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
>   $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
>   $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c


thanks,
-- Shuah

