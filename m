Return-Path: <linux-kselftest+bounces-23956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA66A02F53
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 18:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C120F3A37E3
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 17:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FE91DEFE9;
	Mon,  6 Jan 2025 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d0O41+ep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C341DDC0F
	for <linux-kselftest@vger.kernel.org>; Mon,  6 Jan 2025 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185917; cv=none; b=pTQpmFI1enjvXbxHkGs0A9KPWg1MVBK9Inrdml23JwI+X2Lmhzg2km5kkyhY7QvFI1vOAD2d1vd4MooRtxWg9+8Eo+Rd4/U+8VDuusG2dgDqTjVou2hZXA0gI7hPlICM+1jC4oG0xBh8KKWIhqtU0fzWpiEfCjJEmISigKZRJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185917; c=relaxed/simple;
	bh=dSwJhiucIjzviI8zkbOZjizCEDk25fMipu2qo+VGLZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObleLiRJB8DQ063EPKbdMHORLr4bZl0zydUvQle0VQKypkK1Fr6hkQS3vMxvpUC1LvDHolTmqYJU+gTRYnHPLB8L/TTYuHUm2aKvAVe9MqPORdLBTcJdc5iY9rlyAOXaDBkpzkqMhVITCRwhf+VVcU8oRf+8ZP1XlJj7Qh8Jq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d0O41+ep; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a9cdcec53fso135334935ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jan 2025 09:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736185914; x=1736790714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hh7z7hs2L2Q3CKN2LM+mEdcfdq2ua3GmHPxlWRJVTGs=;
        b=d0O41+epzPItuazr2AwiSAa3gSoxJNi94DHhV2Jy8mPR7ZRF8Zsq/9OFo9sLH+iYh1
         eZXvcOcLQ+d8sNVZHA6qDm8oFkCwzWv2gan68qKUQq65X5g6oeKODmy88mkcqvxUaQw+
         l2sNFQLdC1tTGj49A9bFE/56SR3qTyxHh7xus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736185914; x=1736790714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hh7z7hs2L2Q3CKN2LM+mEdcfdq2ua3GmHPxlWRJVTGs=;
        b=WSO+01Bdhdezq0s7aLndLaeafi0TXD0A5vE/STf3wOh38Q8LE1J9s0hiupqvwBg8M/
         dYCipdqls6rQfa/w3yyxgcR1rgnMkGYIxCfWM7P0kVQvA4W4pTyhOd2T5SaRFBQ/m8mk
         8wvWe0JAki3WSoVNAFVwGCQh9ylCxYhgY9Hec+bVSRtaquUkaV5Hh6d8GGNoqfcXBAld
         H6FTUCY9PRiSPk/6lHVwxIULcIf8cmFKBAPnszn7cUk5AxyinWLFXzQ1jhS9eV8vFX1H
         //s052/15CeHW+Byz6ONwnnUTzvBPNoHeHozlVI0btEMLA0+tXBzkhDiq38Iczk5Bqsy
         OSIg==
X-Gm-Message-State: AOJu0YyHSt2GXCFVIBwusdLhNXTqP790r6TuRoAe1H0KkKkTeG+yWs3H
	9HIbKLW26CFr/xiO1G/6BgRKn4udUoElvdzSGf6V5CxghAt0XTAb0Gva79LQD1A=
X-Gm-Gg: ASbGncuZ+kh7178+B9YZ88rtGE+hh0zOQvR4TAlARyxsbVoSsvbNIA1BvkvVlLMVaA2
	W2chvogwrAkj5gFBoCgsWgDvMLFxYzQ2l3U5l42kn2RkdbqEtHT30M5FEzw1l4bIVwaK4XxudJi
	OkQ7R9KsNbZ91nHE5fXgLZixCqh7e28GUJuMBrV/JtjB+EmJVHTuOqqcofnIlY4oVZcM+soBmFR
	qirX/eV1QUAbHalXZAEsTWVim0BA5yZskjIujKR2PIdGXQyu8AKVmu4sxafAys050Pj
X-Google-Smtp-Source: AGHT+IGXRcdZWF2jCRScVMr+t7sXk+A4or8J3uIr1tF5CgNk7sbOvUzn3cQJxoftBgVabFi/w/O2jw==
X-Received: by 2002:a05:6e02:1c8d:b0:3a7:e0e6:65a5 with SMTP id e9e14a558f8ab-3c2d1f753e4mr503355785ab.6.1736185914298;
        Mon, 06 Jan 2025 09:51:54 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c222118sm9453581173.149.2025.01.06.09.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 09:51:53 -0800 (PST)
Message-ID: <333c5179-64f8-43bb-8b34-eaeb912b40f0@linuxfoundation.org>
Date: Mon, 6 Jan 2025 10:51:52 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/nolibc: start qemu with 1 GiB of memory
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241007-nolibc-qemu-mem-v1-1-c1c2f9acd0f8@linutronix.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241007-nolibc-qemu-mem-v1-1-c1c2f9acd0f8@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/7/24 02:10, Thomas Weißschuh wrote:
> Recently the loongarch defconfig stopped working with the default 128 MiB
> of memory. The VM just spins infinitively.
> Increasing the available memory to 1 GiB, similar to s390, fixes the
> issue. To avoid having to do this for each architecture on its own,
> proactively apply to all architectures.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   tools/testing/selftests/nolibc/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 8de98ea7af8071caa0597aa7b86d91a2d1d50e68..e92e0b88586111072a0e043cb15f3b59cf42c3a6 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -130,9 +130,9 @@ QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIB
>   QEMU_ARGS_ppc64      = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>   QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>   QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> -QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> +QEMU_ARGS_s390       = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>   QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> -QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
> +QEMU_ARGS            = -m 1G $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
>   
>   # OUTPUT is only set when run from the main makefile, otherwise
>   # it defaults to this nolibc directory.
> 
> ---
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> change-id: 20241007-nolibc-qemu-mem-5ed605520472
> 
> Best regards,

Did we take care of this one? Apologies if I didn't. We can include
this in 6.14 pr.

thanks,
-- Shuah

