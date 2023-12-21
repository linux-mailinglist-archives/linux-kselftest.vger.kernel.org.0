Return-Path: <linux-kselftest+bounces-2322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1193381C069
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 22:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50ED1F288EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 21:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D0B76DDD;
	Thu, 21 Dec 2023 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZDd7CR/Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3813E76DBB
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Dec 2023 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7b8529ce303so16931239f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Dec 2023 13:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703195093; x=1703799893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnneZFzTlHoKpJav6pEJp8aS2hixrEs69ZIqivt6hIA=;
        b=ZDd7CR/QKngp8eIJy37FgFsozuboDa7s0JJ++M+9i4AWIoDeAOobCa7GjEgWta+5BY
         bLViSAxwci49FDwKW2P+LAOPPYh7AYg6TZ/5DWyhvd1o89ZZWSiZGWQf2fRGxkc4MjV0
         +9WxUfz0DmPX8eaXO8i8rUgzHE8+irtETEWsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703195093; x=1703799893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnneZFzTlHoKpJav6pEJp8aS2hixrEs69ZIqivt6hIA=;
        b=lmNAZ4BSghvBtRjGRyiXYic4fraX0YM1FsmqWW8aNZ5AGvqWTxUP+Ytm7D6W6EE3bU
         BKFQ+hkUNQwKvThqHrLU5COZdPJYMvC4SBrfUGwZkGfV+Aubb5E+mMwBu0bGhfe9HQo+
         BmVs6DkIrOFGGOMqPvEsyI0kdlMEuO1M0RUxqD3SZBtAqaZdqFTtmXwtGk+U1yh1fn4C
         zRXdVq4KQIGx7Iy9IvIy1dvcJaSnpm9uVxRA3KVeUwYnp8A/26awkuygqzXduXj6t2du
         yRwki8bPnbGfQY0t5Mh7G2bzv6MaiqI0GA2JWoASY+fArHS3841GjPW0rHe4ETFg6f+i
         14cw==
X-Gm-Message-State: AOJu0YybkLh7h4FLrz8CAzFcXJrceFMZ274HGBO4h+6fE0QY6E85IbzG
	UQ2w+EM8is2eOpUMNBJYrasVpi/FODB2ew==
X-Google-Smtp-Source: AGHT+IEYgGoYkLnYECtboI3j/v5GUOG7Gg8Lu3bCOZrY6xy2jYmBgojj3Q7otHob1Gx4HWvSA2oBMg==
X-Received: by 2002:a05:6e02:174c:b0:35f:b559:c2c7 with SMTP id y12-20020a056e02174c00b0035fb559c2c7mr653248ill.3.1703195093260;
        Thu, 21 Dec 2023 13:44:53 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id a8-20020a92d108000000b0035d58d00b7bsm713639ilb.56.2023.12.21.13.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 13:44:52 -0800 (PST)
Message-ID: <f38374bd-bb1f-451e-9d34-9c38029ffd15@linuxfoundation.org>
Date: Thu, 21 Dec 2023 14:44:52 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: uevent: use shared makefile library
Content-Language: en-US
To: Antonio Terceiro <antonio.terceiro@linaro.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231221204908.341677-2-antonio.terceiro@linaro.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231221204908.341677-2-antonio.terceiro@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/23 13:49, Antonio Terceiro wrote:
> This makes the uevent selftests build not write to the source tree
> unconditionally, as that breaks out of tree builds when the source tree
> is read-only. It also avoids leaving a git repository in a dirty state
> after a build.
> 

Why can't you do that using make O= directive.

> v2: drop spurious extra SPDX-License-Identifier
> 
> Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
> ---
>   tools/testing/selftests/uevent/Makefile | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/uevent/Makefile b/tools/testing/selftests/uevent/Makefile
> index f7baa9aa2932..872969f42694 100644
> --- a/tools/testing/selftests/uevent/Makefile
> +++ b/tools/testing/selftests/uevent/Makefile
> @@ -1,17 +1,8 @@
>   # SPDX-License-Identifier: GPL-2.0
>   all:
>   
> -include ../lib.mk
> -
> -.PHONY: all clean
> -
> -BINARIES := uevent_filtering
> -CFLAGS += -Wl,-no-as-needed -Wall
> +CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
>   
> -uevent_filtering: uevent_filtering.c ../kselftest.h ../kselftest_harness.h
> -	$(CC) $(CFLAGS) $< -o $@
> +TEST_GEN_PROGS = uevent_filtering
>   
> -TEST_PROGS += $(BINARIES)
> -EXTRA_CLEAN := $(BINARIES)
> -
> -all: $(BINARIES)
> +include ../lib.mk

This change doesn't get the intended result of not writing to
source tree. Binaries will still be written to the source
tree unless O= is specified.

thanks,
-- Shuah


