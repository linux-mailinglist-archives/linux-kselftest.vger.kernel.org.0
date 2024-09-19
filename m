Return-Path: <linux-kselftest+bounces-18138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5253F97CBBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 17:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC455284DC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CD819E7EF;
	Thu, 19 Sep 2024 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JTOt8Ofj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2919E7E3
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726761112; cv=none; b=h8jAPy5GpxAs+vheSlO4PrIHI0kXv67QGOeaEFtjKSL4SrXrXXcmv2qbcj7E/DBw2Ce5kbg/HwkHGJtqGk/us7tT2jNUmzK3rBI2GNJxGqFoI6kFgUm0nzPAqWgK9xXN4Kq5lnOKp9A3kyo55AbtO7yMgk2d+/WYxCT4rXAFspg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726761112; c=relaxed/simple;
	bh=Ct5jyYO6I0zb8EVMBPSaFmiYFy8ag9DKLrK/3JY+Low=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lR86F5DQaURLDYS7fWSdtajVDPKk2cOocN1Av6xgsgBKfbQQKRLpu/p2E1Rx5QYALWN/xE4nu7yw66wq1EBvTpsCHHYtgAt6gk5eRmQNuNRaE5h39BiYy82AdpAGdALhFxB9BmdZ6u8X6zs5cTDAbV/dvd7/IH19nOG1anXcTH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JTOt8Ofj; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82ce603d8b5so48701539f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726761109; x=1727365909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Yc9dnUfjYifVW32xxny3iJHEwr/JhiKmFnbSuEtTG0=;
        b=JTOt8Ofjd1LFuK1HZYgiW9d3AIwoGfOuzZlXX9En9PEmJ9WMawqIPX1V9lgGUZPos2
         nE/8MqY3nrmwTCYUYaThuiLtqgO4DMvqamjx8+B7/xqNoH+Q5qZRwgAwFDUuOtUUylDk
         OVehpqES+wIg1kKkACIGFLwDSYOYwq5aPeXio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726761109; x=1727365909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Yc9dnUfjYifVW32xxny3iJHEwr/JhiKmFnbSuEtTG0=;
        b=T+xxV50USFnngQkQ6Ddf8tdDsbLdn4dqubvvw5bth0qTTujn1bDuFAXHEQuSSMrYcI
         1A41cW8vKqEYLSwTwEdqNEyFP81lkEX0UEjITDPsbdC5wpifiWTUuWR3pasOuySONjri
         +SXGYNkEcSbJvaX1X0QXBhbdMr+8YgyLvHc1RA92qaNFmPCj0arQ1yR8lw5XY0ONbIRz
         85chSxX3vysZCtFbSvSGpGyi/dtdGLfdwZJTks7qBAIp30GftKkVCj5gMWabe2JByvCa
         u6P3mNTrX8VfaIFOPtxFJKvuqvXdG+9os3pEw4SUQP1cktsduo5McsEo/UOD/gxPF/CS
         0crw==
X-Forwarded-Encrypted: i=1; AJvYcCX7/bOQKus5oU4rbxjAWTf9c8uMRiTPI4BuVobbRlSQaO2uzNZDJ8VAy+UGJGomtd82Z4Arv5+jMBNqy0hd9gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpeTtcWlhdCs97NC+hYVtGRnUZJQRW9iu8b7U7N5iO6350cy/
	05iXyrfDEqA5IG7/nGZ1LKRH9upZh0ZSr72GU8rkbwbMSPsYBHnrATbSXZ88l/c=
X-Google-Smtp-Source: AGHT+IGQwY3ygyGvp1gAcwAAV6Vc1M8ufZmJxQScJ8GGG++Zos7hrQNdc61tPSGTGHlldv3sha2dyg==
X-Received: by 2002:a05:6602:608b:b0:82d:6a:4cae with SMTP id ca18e2360f4ac-831830edbd1mr1019079939f.3.1726761109480;
        Thu, 19 Sep 2024 08:51:49 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed19ebesm3034416173.112.2024.09.19.08.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 08:51:48 -0700 (PDT)
Message-ID: <952aeec9-c21f-46ce-bf68-e6ffce51630c@linuxfoundation.org>
Date: Thu, 19 Sep 2024 09:51:47 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Makefile: create OUTPUT dir
To: Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org
Cc: willemb@google.com, kuba@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240916075655.4117151-1-anders.roxell@linaro.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240916075655.4117151-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/24 01:56, Anders Roxell wrote:
> When cross building kselftest out-of-tree the following issue can be
> seen:
> 
> [...]
> make[4]: Entering directory
> '/src/kernel/linux/tools/testing/selftests/net/lib'
>    CC       csum
> /usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin/ld:
> cannot open output file /tmp/build/kselftest/net/lib/csum: No such
> file or directory
> collect2: error: ld returned 1 exit status
> [...]
> 
> Create the output build directory before building the targets, solves
> this issue with building 'net/lib/csum'.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   tools/testing/selftests/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index b38199965f99..05c143bcff6a 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -261,6 +261,7 @@ ifdef INSTALL_PATH
>   	@ret=1;	\
>   	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
> +		mkdir -p $$BUILD_TARGET;	\
>   		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install \
>   				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
>   				SRC_PATH=$(shell readlink -e $$(pwd)) \


Doesn't the "all" target mkdir work for this case? Why do we need another mkdir here?

thanks,
-- Shuah




