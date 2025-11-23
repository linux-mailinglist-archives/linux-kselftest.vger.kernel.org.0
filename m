Return-Path: <linux-kselftest+bounces-46335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A79C7DA5A
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 01:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D6103527A0
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 00:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EED72C181;
	Sun, 23 Nov 2025 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="TFG9WLFU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E2B14AD20
	for <linux-kselftest@vger.kernel.org>; Sun, 23 Nov 2025 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763859308; cv=none; b=Bpr/UrdoQbj9EeAX+IPEnF3MYyifPlma9EnVSJ4jM+2Vi1g2Uayv2iIG4QI8jGpXElS42VBy7cmrF4xAHGgIFG+JNY6pmmhUMQJcbO3m1iQv6nNnMj4H7iML/LluslBs5OfnZNHoiDpuJfycGQdAlKxouWapWfzVyi7jxjGdUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763859308; c=relaxed/simple;
	bh=5g1LeAUycCmW1Kor8naf4GZL5hbQ9dFk2VpogfCcdBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIx3O22m2A2eSBoU5WA2j5txx/CtNeN6nVlesJEjVxvOOCvciiLStL9ICQXvXIenPJxoEYmIZ2/Djxf3UoAKfuYn4fj9i/HZjR3PCRIOjPMzbxR2FkKPKLZRfgDejfElrtVbi6Sd0uQQMtmgHycezg24X8JDCtWZUJxB7D5zwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=TFG9WLFU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3436a97f092so4071844a91.3
        for <linux-kselftest@vger.kernel.org>; Sat, 22 Nov 2025 16:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763859306; x=1764464106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+UOwalBslEwvU7tMyhtoNigMXX4m/TZjFjaWohMLbGo=;
        b=TFG9WLFUbpzicB3c999BHODMyAOj/CWVDrVgN8UafaXmk4UuAStP7u7FwWipJljEF4
         NWnAxqn8p5XRMjPSW3sM/loJsK7qLk8Sis3yxrMbbip3MQaiyUn5D0Pdwei2tWCGlo2n
         xBhfpQFk4nRFT6vArjXI3wVFIeOrRaJw1dN1G27SxwX0rECveGMPc8T2Z9YL4+14kFdW
         TUGRTIqfWRXWyhLB5xgFnMUAeGytP98L94iwpLzxs4ckJ2vdJ3YBmM8xcgDLLnIiGnA+
         /+ObN8/VxIXiH6CSv3/QAmqvEPdFllGbtvsEdj8VaEKSzHQlazFrjsFcn9YsNhsl+tIJ
         76NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763859306; x=1764464106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UOwalBslEwvU7tMyhtoNigMXX4m/TZjFjaWohMLbGo=;
        b=Sd23syRCsWBOjLoR5KFpDeXIhEI4ENX+q/8R5Az/sQBimIbos6dZ+B9HP7S3g92v5c
         sOERl6ZEWbEdJgJzSXs/RZ38WOqIk0YTdN17yhbx21AFBbw+8fyv/m37K43Pv3dSrowX
         8S/vjuRZVPL75xi/2aOxoLzlT6pak/uGNNvzTCbOD5QbypaVm3w0MApRg+Z5II4qFHBV
         MZ09RVH68BDXjs1mDByEd03Ic7vJkXqNrQZD4OaCGRCMXfST0DWChxzYC5oM5DvpyGra
         Bq4lcjo6iPYE7fRdmP2MqQTY6buSC6LhTcnMai+Kokh5tknfGoKHv8yGKCw2jQ6/jJRr
         qtqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIxA5786jdPcVrjCx7jijaRpCQCrp/YCuVFnYfb0E2IG5t4vFUDjP7Q3pQdTPiW8/R2sBjzHZcvUrGII1rJpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylbuJnkg86N+BSLwdEmcUI7fYC9/GmsQrL12D5EvvBAig+sYD5
	ZkcqP8zp5i4ty8JJ1ZCJgNR1QLwFxlY1sw7p8VdmBkSJZpuGGWDEVqBXR4/SyvQClgc=
X-Gm-Gg: ASbGnctlLICIaqguO6ZkcuCgkXTyeP2IbOv78I4UtAKsxS4CCE+5wWZz/tmAXuDd4I2
	2MBZA0m20A05HkcRzW58aALVAZIl7fX7scCxRfXHCH3qpgq1Wx+B3dq8oe64Fe06Cg0f/DnQatx
	Yq+XD1HR5wPmDXZHnH91GG2+ccy7bJWgcx08MNLV4dxTHNyMLspR37oZgcRbavk2dlDP3UihP9A
	f1dL5ZGDkobELoUwSrQ4hS44X4NMZ/xWGcA2T712SWXZwQ7mbi9ARAAGsgysn8jqLeztbutt00q
	pcJTR0zvca8T0nJi+MBZ/ZJcmpeSjXiYwcGzD1c8bZruAhrFkkLeBoJKAh905RCrpNUoorobX9I
	OH14pbmjnt4X0oRyZvRdbVAX9ukf6OMvO8zeT6j2GW1Hd+m/5Bh2Wp/MJ0mFkD+w/OqjR7EO7US
	b4YY6Gy6cZXdF7UP7JallJhz6KxBqoUYwMldL6BFpBWW+vNDhJwA==
X-Google-Smtp-Source: AGHT+IG7R08Ld/nK7vPwEXTLUAvfKBFWdEVnMYpKxcwFKtqAy8HGKGuPDR2/ZAqrRfnggbhZC0+rZA==
X-Received: by 2002:a17:90b:50d0:b0:341:88c1:6a7d with SMTP id 98e67ed59e1d1-34733f2a76fmr7748306a91.18.1763859306634;
        Sat, 22 Nov 2025 16:55:06 -0800 (PST)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345af32d01csm6567138a91.6.2025.11.22.16.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 16:55:06 -0800 (PST)
Message-ID: <c8876216-c37d-4d7d-9301-b051273e69b0@davidwei.uk>
Date: Sat, 22 Nov 2025 16:55:05 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] selftests: hw-net: auto-disable building the
 iouring C code
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, willemb@google.com,
 petrm@nvidia.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20251121040259.3647749-1-kuba@kernel.org>
 <20251121040259.3647749-2-kuba@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251121040259.3647749-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-20 20:02, Jakub Kicinski wrote:
> Looks like the liburing is not updated by distros very aggressively.
> Presumably because a lot of packages depend on it. I just updated
> to Fedora 43 and it's still on liburing 2.9. The test is 9mo old,
> at this stage I think this warrants handling the build failure
> more gracefully.
> 
> Detect if iouring is recent enough and if not print a warning
> and exclude the C prog from build. The Python test will just
> fail since the binary won't exist. But it removes the major
> annoyance of having to update liburing from sources when
> developing other tests.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   tools/testing/selftests/drivers/net/hw/Makefile | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 1760238e9d4f..949aeeeb357d 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -1,7 +1,20 @@
>   # SPDX-License-Identifier: GPL-2.0+ OR MIT
>   
> +# Check if io_uring supports zero-copy receive
> +HAS_IOURING_ZCRX := $(shell \
> +	echo -e '#include <liburing.h>\n' \
> +	     'void *func = (void *)io_uring_register_ifq;\n' \
> +	     'int main() {return 0;}' | \
> +	$(CC) -luring -x c - -o /dev/null 2>&1 && echo y)
> +
> +ifeq ($(HAS_IOURING_ZCRX),y)
> +COND_GEN_FILES += iou-zcrx
> +else
> +$(warning excluding iouring tests, liburing not installed or too old)

Would you want to mention the min ver needed (2.10)?


