Return-Path: <linux-kselftest+bounces-30488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C43A84800
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 17:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC761B81E26
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 15:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006C61E990A;
	Thu, 10 Apr 2025 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XdvUjbOQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F81E0E0D
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299224; cv=none; b=VpTkviiAJEdb/XxDrFJoGH3Mtzh+2a/jPKRTCSouMn4Ys9JQoo+bAiJZa7Sl9T8sZM7pksqfG7SRtjuX7D2YiKweyovhIFl/CpXVZaYTzzNz7nfnM+HST78jKesNHAiLbaAtea5ItFQc/lrqhMsrql2WCabH/kWdbZrjyx2Sz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299224; c=relaxed/simple;
	bh=v99tiqhZEPNc+au+zsTlLfO+UL4lnCpGAj55KgcQOyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+yADvXjR7DOuIvwL38rQU6mxeNoIsZ8999ppWDXTU94Csh13g5dzsHkVPNs+KOrbieHHOVtMAZF2NzRJgnNZQXSAc1VB2NFvqHsYDl253dVG75fQbSL0ikUITtlOhvTNbYpflAdmz3ZIbyTDIZS87mgQJaOORA+IbWYMs0rZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XdvUjbOQ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d58908c43fso2749875ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744299222; x=1744904022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TWuu0TVvkVtEFQtTM518BO6Po0Ztx9T2clp/sbsG4gU=;
        b=XdvUjbOQSZ2FbCmM7yrk1oQiK0qVCi7pOOZYrF2G7x7xU+6jlqt+TcxVLoN8D5T3PV
         o87psddCbCZyzCdmbgJCyW1G2gudqolRdqyrB6B8UMlGtq+MjxR52VZBaO55hY27YiSB
         fdE90Ymu3KKhIJyZomFAaxRtz3/TBxnl+sNt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744299222; x=1744904022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWuu0TVvkVtEFQtTM518BO6Po0Ztx9T2clp/sbsG4gU=;
        b=McxsGmRfW3dHz7SSr2XTaeJPmmLXAKvkwn4A31olsGa1d/IhiBql1tMV7qsNV41EeS
         fID/YgHT32gz9EYvXHik2W72h6XEkVcVDQ7Aj0jX/VnaHuN7sz7wx9ohnan+oYfGlWrL
         DGB40RdXsHJT3rM3hQpeuWXCZi3Xbru7ehcXJPAj8af/50kZL7EV1bPPwXRFRdUunHuT
         WtDUQcvzHQiThMA3htyo8dssUuAsoeuPFgTPSGr5AcmpPo14Pkt2MHWNa6cVcADdwYSd
         RMLi2PY4+SuQuwz0Z7a0tP8xC9r0xBG3OStqBpuRpaWcsUD8W92f9SN45iJFFgM3uZcZ
         I7rw==
X-Forwarded-Encrypted: i=1; AJvYcCWJIpJ95862PaMLQuJ5A1FrEX1axgzVb5pkjxN6Q68GDSrn6QTypLAozQF12kyUX0rvD9SY6xBqTM7sfOGXZVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wPex4I3LsXJR1pP742FLMNAjmsQuipiBOAo9dnC9dVvKdMeb
	0wc9IzDoXtXBpB20Nn+gbi14jZ6Fjd7KMUcTtoNcAMpYns2g5IeR1J4F16aYfeoa8y69AFPSpT/
	T
X-Gm-Gg: ASbGncve+E+4t/m6K2XL7iU8fukrlNP5EIfzicIGrWeKF3z2H2Q91JeSTSAYnkgLOPt
	AyB0w2moCEUr8Jb8oUYhQFZXC6375ZBQNAasZ55ItY/Zihtjrhs7bSjnvgH8JFNrTAdfpaG9xl8
	5swXZYCELm01EWIFH6wReQwOkINP/mGBJCJbciKqWsWaUNydk8E/9ietui2cvpL9T9Njm3R/zrL
	QTDU0NUGR5IdadQXTI0fcNrK6BATVnGQQMEVD2bhzSzRHvhs97iuOZA+TxiqEeDp7oUNZHL2x7M
	SpMpDnCe7Tzf6ndGyorrXPkaVcqdShZOZ2OSrbFBSFylDRDvMEI=
X-Google-Smtp-Source: AGHT+IEMrgXmJRRAoLU7m+PL1i/g4DJ8Gi+/jcEloYQwuzmWrc2QtQdxI25WU5XntnT2B7cItRJfPg==
X-Received: by 2002:a05:6e02:194c:b0:3d0:21aa:a752 with SMTP id e9e14a558f8ab-3d7e5f50684mr32572795ab.2.1744299222246;
        Thu, 10 Apr 2025 08:33:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dc591f6csm8208425ab.69.2025.04.10.08.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 08:33:41 -0700 (PDT)
Message-ID: <f72fcc0c-b0b5-4131-a5b5-bf1d1320c85c@linuxfoundation.org>
Date: Thu, 10 Apr 2025 09:33:38 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/32] selftests: harness: Use C89 comment style
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Shuah Khan <shuah@kernel.org>, Willy Tarreau <w@1wt.eu>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
 <20250407-nolibc-kselftest-harness-v2-2-f8812f76e930@linutronix.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-2-f8812f76e930@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/7/25 00:52, Thomas Weißschuh wrote:
> All comments in this file use C89 comment style.
> Except for this one. Change it to get one step closer to C89
> compatibility.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   tools/testing/selftests/kselftest_harness.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 666c9fde76da9d25fe6e248a7f2143c113473fe1..bac4327775ea65dbe977e9b22ee548bedcbd33ff 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -983,7 +983,7 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
>   	}
>   
>   	t->timed_out = true;
> -	// signal process group
> +	/* signal process group */
>   	kill(-(t->pid), SIGKILL);
>   }
>   
> 

Looks good to me.

thanks,
-- Shuah

