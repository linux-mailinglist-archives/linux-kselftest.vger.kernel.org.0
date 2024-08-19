Return-Path: <linux-kselftest+bounces-15631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00DB9567BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 12:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23431C217F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 10:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3015215CD61;
	Mon, 19 Aug 2024 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gxw4a3vH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13813C81B
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061703; cv=none; b=sfPHqIxWEoD1AAth/YGxwoPkWBawaPox51dUDo1IEG+ZAMSgKrB83cVHhZRSBD0Xq43s2IM74AIg0sRiTsWk5qtUi182uh2fkOJg6Wvl9NeQkE5108sADaASriHqZ9ZIPu2BsmE6yKI5bt7p1qB1KvPufX0aloGMgSNVdtSYyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061703; c=relaxed/simple;
	bh=WKdG1NJmSVs4lziHmvLV1A1Z7PYhGzhh1oJ+XBfjdB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drd9fbhLtSZ7YXRVusUJSYpH0EdJZfj89rCNih2FwKrydawoApFJ3e74Jt1lJxUf97forRbWT9VvqNVnE2oo4VtEnwUu0ZD+24R/+GRmACwqhnBDOFcFtBgcKd9EkRaeAYpE3pQyfmLB3v5g7MdtTvhGXEfDUT/BV8ck3ASQtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gxw4a3vH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201e2ebed48so1592035ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 03:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724061700; x=1724666500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+/dZwR9KXDCL6u85V5/TrKH5gOthmBMTCYnjHJnT94=;
        b=gxw4a3vHC4+3DxdrMsflHcAotLDT0eajY5fNM/PnRjov0rn28a5qiJ3tbidtWvKFBW
         hQawOYidQrnnoiLuatFAzBaUVKOLmQ5e56jyhVWqadg3/V68dekmKUHzOjxcxG8TK7eZ
         sYW7SX1AOI0uHnC93i8eGRDttRHBs/fJQl07c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724061700; x=1724666500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+/dZwR9KXDCL6u85V5/TrKH5gOthmBMTCYnjHJnT94=;
        b=dKWhz+aWVUTa66rWiOUqOImBiASvy5DOPwvADRrW2Js8kgz1vpnb59T79RdJczvzCS
         o5XoBsr6SqFsJKU/Mc08g8Wrqv3gOuSL365D0x9Gnaec4k+mDXJcUOQO793mTvs2lIIp
         OE7my6ASyTTrTTsCIqkxlXYSgB/RLaRmcYMQEXeHxOcc7R43gM1IM9RtOhAx16BT4v7Z
         fDSweDwNYgxZvZFoVPXeCe0tSkdJ7hxIptw9Mad+yKQZglcA9YlsM8a0hg6ZvswUYLkZ
         H0mP+lb764sYsH8j9uLaTHwvaS8OQdM8sTznhofCeudaD1QIBYENRmGuEUo6B7EdEdmc
         sBKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcdxgB2B4nroHUuylTL4UAdPPhCsCCVbGJR0Dba4+QVg6gHJ0S701CzPCwKzYsfX1YyF6EXV2rkAzwt5yLCHCSOlT5G3p9Ah3RdROs1TSv
X-Gm-Message-State: AOJu0YxZcFJyKtX53ON1zqPsQZ2b5qNS2WZ2bvrsLiHveq+m/zo7gO5L
	tlnZZ0mlZb4pQVNmCf5YfYmfDH98MMhgo8sQ9VXIEa53U6jYyxfeCiCnr+oRtwnNxlKRM175jca
	Y
X-Google-Smtp-Source: AGHT+IEnzq1GNpBfStxJF2FcLGudBLyYQ9ABvejE0cVWJmaQbEUmA05IvPq3Sx1v384dEKKa0T1ipw==
X-Received: by 2002:a17:902:da8a:b0:1fb:1ff1:89d2 with SMTP id d9443c01a7336-20203f21a2amr74366705ad.6.1724061699544;
        Mon, 19 Aug 2024 03:01:39 -0700 (PDT)
Received: from [192.168.104.75] ([223.118.50.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03751ebsm60164145ad.162.2024.08.19.03.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 03:01:38 -0700 (PDT)
Message-ID: <59d825c8-bdaf-4077-be0e-d738b42d2dab@linuxfoundation.org>
Date: Mon, 19 Aug 2024 04:01:28 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: kvm: fix mkdir error when building for
 unsupported arch
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, Sean Christopherson <seanjc@google.com>,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240819093030.2864163-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240819093030.2864163-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 03:30, Muhammad Usama Anjum wrote:
> The tests are built on per architecture basis. When unsupported
> architecture is specified, it has no tests and TEST_GEN_PROGS is empty.
> The lib.mk has support for not building anything for such case. But KVM
> makefile doesn't handle such case correctly. It doesn't check if
> TEST_GEN_PROGS is empty or not and try to create directory by mkdir.
> Hence mkdir generates the error.
> 
> mkdir: missing operand
> Try 'mkdir --help' for more information.
> 
> This can be easily fixed by checking if TEST_GEN_PROGS isn't empty
> before calling mkdir.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Instead of ignoring error, check TEST_GEN_PROGS's validity first
> ---
>   tools/testing/selftests/kvm/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 48d32c5aa3eb7..9f8ed82ff1d65 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -317,7 +317,9 @@ $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
>   $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
>   	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
>   
> +ifneq ($(strip $(TEST_GEN_PROGS)),)
>   $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
> +endif
>   $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
>   $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
>   $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


