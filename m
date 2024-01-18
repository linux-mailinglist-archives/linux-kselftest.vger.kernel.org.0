Return-Path: <linux-kselftest+bounces-3181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7CB831156
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 03:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA9B1C219DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 02:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C38A65A;
	Thu, 18 Jan 2024 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MrYHicRD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849D34698
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 02:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705544294; cv=none; b=PCyYZWRTNLrRe+XcL2aWq/CHMRPKuYnQi/gOPbP9SkJH79fHmpgPGLLh7tRcDm6zvA/mEyUN4Sa30emiJlgXalteqtwRt+arg4UtWyYy6mkcTLhFlqUtpwO4S7urYhK6DQZ69wSa11oQVqLXU37s6enzXgVid6tpMNHqxAsflsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705544294; c=relaxed/simple;
	bh=7voOXuhfPnskEJZAZbR01eqyMrcXZoKXlc+v/f6hkOw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=OndcC/HfD9cvcl3iP+OLKyNViefx8bKCFtNB5awyjcz10f+Eptl+3RwwP57cC2Hfs7Cs6BiVZig4rG1+WcnWYFQYpSMVtlowPXgqUvjgf8kY34Poe4MgnbLRrD28ZPAouTMVr+OHOsLuwZPZYgL/1LCwzUIGV2Hu4g3H0fYFr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=MrYHicRD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3368abe1093so9139134f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 18:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1705544291; x=1706149091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O8IhQQZ/ZBIwA5q7sDNoEOtDesWDe9PHB37CJuOhzdI=;
        b=MrYHicRDANyv5yjhAwL5Pi5P5XNFDL1EuFV/k1uoSnRBbrUeZh4XACCGgFAQwTd3te
         64q88ZShwuA0Pvlt2Z1zRyp8bCqOvYFULgGVKGi+cfbtuRbHyh6zNBoh0vWz2h0f2sPb
         iARrH9zbZ5MlJI9+tiyrD0H37nLsZYyFdPl1SOTSB+BCwtyq4GzSRAtL1XruOUoRpMwP
         Hnjd15+sJ1ZKuZVf/itUerPB2F412yQrOTSXCGAM9EGLmpJLEK6GQY4JmgAwq8VoDpOu
         vnm5UxdzM5oGgBJejeUYMQfNMgR5QSLKh1Dpmk5p0YBWEYsWht0yp4SsOR5kkgqaZCRy
         Nw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705544291; x=1706149091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8IhQQZ/ZBIwA5q7sDNoEOtDesWDe9PHB37CJuOhzdI=;
        b=Iadd8sYroEgIQ/IHBEog+iJeHHoIJHC8yl0vANniQHVogLC9qO9sRxQn6IRcZxgR4q
         6g042CD1jo9ueBHZ8XO0dIJPt2ossIJH6nVG9nF4ZLLDu9oOB3AwTSgczUcazY5q0o9y
         ou8g4T3iwbwsW/SyP5B2PR1ThF+ZoNfL+2eMeDsaeGYXO6noS8nI7RiDm6AQdiuSzrpo
         SPlBKxgUhR4B9MLzvUouhaCveFI82M+euHdm8zgdq680mQzqmimrwgHBiyYlZZ3xeNnM
         sStyoUtb2E+KVJvXjj4dsERULXJeRfP41cjOdjJY63YBVMdBgqbUwHhXnmDvn2BoT2kO
         3pGQ==
X-Gm-Message-State: AOJu0YyYGgAKNQ3e4XST5KjPK78mIaiaj9tyNEidI9nUXIGumcktGIxr
	+h5FiwXS7kmd75ekmgCXMskUo6CbE8cbVu4xc0gx9cNGvjikighsVs7t7/T1uw==
X-Google-Smtp-Source: AGHT+IHtXYNC47SOSfQFb4kwiq1nGngPEhY8zTv36muO/vJ1sWAEb6kf6o+6aHmK9LIN/ylM4JYarw==
X-Received: by 2002:adf:b319:0:b0:337:c155:d130 with SMTP id j25-20020adfb319000000b00337c155d130mr59418wrd.41.1705544290754;
        Wed, 17 Jan 2024 18:18:10 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n3-20020adffe03000000b003364a0e6983sm2829647wrr.62.2024.01.17.18.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 18:18:10 -0800 (PST)
Message-ID: <fe3d5804-706e-40fc-a4e0-819df06f83ff@arista.com>
Date: Thu, 18 Jan 2024 02:18:08 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/net: argument value mismatch when calling
 verify_counters()
Content-Language: en-US
To: Mohammad Nassiri <mnassiri@ciena.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, 0x7f454c46@gmail.com, mohammad.nassiri78@gmail.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240116214826.10754-1-mnassiri@ciena.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20240116214826.10754-1-mnassiri@ciena.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mohammad,

On 1/16/24 21:48, Mohammad Nassiri wrote:
> The end_server() function only operates in the server thread
> and always takes an accept socket instead of a listen socket as
> its input argument. To align with this, invert the boolean values
> used when calling verify_counters() within the end_server() function.
> 
> Fixes: ("3c3ead555648 selftests/net: Add TCP-AO key-management test")
> Signed-off-by: Mohammad Nassiri <mnassiri@ciena.com>
> Link: https://lore.kernel.org/all/934627c5-eebb-4626-be23-cfb134c01d1a@arista.com/


As I've written you off-list, the patch probably was not delivered to
mailing lists due to SPF check not passing. Please, fix the send-email
setup when/if you want to send more patches.

Related to this patch: I'm going to carry and resend it together with 2
more patches, as this fix made 3 selftests fail and I've looked into that.

> ---
>  tools/testing/selftests/net/tcp_ao/key-management.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/tcp_ao/key-management.c b/tools/testing/selftests/net/tcp_ao/key-management.c
> index c48b4970ca17..f6a9395e3cd7 100644
> --- a/tools/testing/selftests/net/tcp_ao/key-management.c
> +++ b/tools/testing/selftests/net/tcp_ao/key-management.c
> @@ -843,7 +843,7 @@ static void end_server(const char *tst_name, int sk,
>  	synchronize_threads(); /* 4: verified => closed */
>  	close(sk);
>  
> -	verify_counters(tst_name, true, false, begin, &end);
> +	verify_counters(tst_name, false, true, begin, &end);
>  	synchronize_threads(); /* 5: counters */
>  }
>  

Thanks,
            Dmitry


