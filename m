Return-Path: <linux-kselftest+bounces-2164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13451817931
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 18:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20812B2409B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCDA71468;
	Mon, 18 Dec 2023 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ybtf4nWf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E123371454
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Dec 2023 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c2308faedso41917545e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Dec 2023 09:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702921849; x=1703526649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Occqa1d1wrIZ9JrkFxA0ptrItrzkGFf6vJHCa/yFOBc=;
        b=Ybtf4nWfX+W36bNomyQ67b8ig1z4ey95P3ksvnYWaLtD3j/TXLYm1iUB1lqPz+ZDoq
         aksQun5dEdQiepFHG/jsKTKZphoJYsuOLKh5gbi2dbh3sDjYZZTMGwf48hMUDIaBGCoI
         HqgoWG++SbhAJwKhibnNQAIGTKZ73gvcbKgG0IF+LCbia43uc1nkuuBPwaz6B7V8zPmt
         E2K8KoYGFNPO0TOgydRakwzJwKxZ5XGx7qdXSv67gF7hxWyeF979+OliAifVRBFvuzWG
         cppN/dlOd5cDW4JhQ+bEAR8Za9/gDGGBwizFrgPu/6+wtX/2KLrDR4M1T+ycfhTTEgtu
         FwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921849; x=1703526649;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Occqa1d1wrIZ9JrkFxA0ptrItrzkGFf6vJHCa/yFOBc=;
        b=wRJenIMne4zVsXThq2kCEa1yr/DUYTJAUD0wtkdj39nlOF0sJdZIDoAJVtKpcpx6L2
         UlHL1icqCc0R0XWmoUCGzzc5NovP4erLdQakXAavyhdQOWw1b+bTyLOYIA/12C2vI7Iu
         YUSbudfpjUFrzdgs1FcFaBlOy1+UCF5uKQoN83Fd78QQZXvQcFzskgCHlcqlIbE3E5Aa
         j5QFdT2hTUIEmGTV14tayXVWFI34nwtKqBTxa29wLFhiHdEAClKiOo24PYF9E6NeBID4
         Al7Ef4hBkw+ho+C4GA0hR7VGSLZ7kPnx7JBFyrxULDHIvCfhRD9YY9PLVFoW4DHrlSgT
         BsPA==
X-Gm-Message-State: AOJu0YwUhvNKksApR3W2Mf0uBLkfinu6CvaJuSX/AFxyBds3+qqrzge+
	l8Ty1UhcOleJN8sG7GOuHNQqYQ==
X-Google-Smtp-Source: AGHT+IEzdWkqKi1MfYmTW3wl7a4FaBZpV6heiMEnBKo7jRC4v2GKBHRpFX/j1mba8zTFSD5PlUMeJg==
X-Received: by 2002:a05:600c:a3af:b0:40c:2c36:2a23 with SMTP id hn47-20020a05600ca3af00b0040c2c362a23mr8185591wmb.180.1702921849029;
        Mon, 18 Dec 2023 09:50:49 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b0040b2b38a1fasm43508366wmb.4.2023.12.18.09.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 09:50:48 -0800 (PST)
Message-ID: <3ff06ca1-95ef-4b94-a6a7-1731fef40d8a@arista.com>
Date: Mon, 18 Dec 2023 17:50:49 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] selftests/net: Fix various spelling mistakes in
 TCP-AO tests
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20231218133022.321069-1-colin.i.king@gmail.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20231218133022.321069-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/23 13:30, Colin Ian King wrote:
> There are a handful of spelling mistakes in test messages in the
> TCP-AIO selftests. Fix these.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thank you, Colin.

The patch looks good to me, my grammar and typos - not so much :-)

Reviewed-by: Dmitry Safonov <dima@arista.com>

> ---
>  tools/testing/selftests/net/tcp_ao/connect-deny.c      | 2 +-
>  tools/testing/selftests/net/tcp_ao/lib/proc.c          | 4 ++--
>  tools/testing/selftests/net/tcp_ao/setsockopt-closed.c | 2 +-
>  tools/testing/selftests/net/tcp_ao/unsigned-md5.c      | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/tcp_ao/connect-deny.c b/tools/testing/selftests/net/tcp_ao/connect-deny.c
> index 1ca78040d8b7..185a2f6e5ff3 100644
> --- a/tools/testing/selftests/net/tcp_ao/connect-deny.c
> +++ b/tools/testing/selftests/net/tcp_ao/connect-deny.c
> @@ -55,7 +55,7 @@ static void try_accept(const char *tst_name, unsigned int port, const char *pwd,
>  	err = test_wait_fd(lsk, timeout, 0);
>  	if (err == -ETIMEDOUT) {
>  		if (!fault(TIMEOUT))
> -			test_fail("timeouted for accept()");
> +			test_fail("timed out for accept()");
>  	} else if (err < 0) {
>  		test_error("test_wait_fd()");
>  	} else {
> diff --git a/tools/testing/selftests/net/tcp_ao/lib/proc.c b/tools/testing/selftests/net/tcp_ao/lib/proc.c
> index 2322f4d4676d..2fb6dd8adba6 100644
> --- a/tools/testing/selftests/net/tcp_ao/lib/proc.c
> +++ b/tools/testing/selftests/net/tcp_ao/lib/proc.c
> @@ -227,7 +227,7 @@ void netstat_print_diff(struct netstat *nsa, struct netstat *nsb)
>  		}
>  
>  		if (nsb->counters_nr < nsa->counters_nr)
> -			test_error("Unexpected: some counters dissapeared!");
> +			test_error("Unexpected: some counters disappeared!");
>  
>  		for (j = 0, i = 0; i < nsb->counters_nr; i++) {
>  			if (strcmp(nsb->counters[i].name, nsa->counters[j].name)) {
> @@ -244,7 +244,7 @@ void netstat_print_diff(struct netstat *nsa, struct netstat *nsb)
>  			j++;
>  		}
>  		if (j != nsa->counters_nr)
> -			test_error("Unexpected: some counters dissapeared!");
> +			test_error("Unexpected: some counters disappeared!");
>  
>  		nsb = nsb->next;
>  		nsa = nsa->next;
> diff --git a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
> index 7e4601b3f6a3..a329f42f40ce 100644
> --- a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
> +++ b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
> @@ -427,7 +427,7 @@ static void test_einval_del_key(void)
>  
>  	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
>  	del.set_current = 1;
> -	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "set non-exising current key");
> +	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "set non-existing current key");
>  
>  	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
>  	del.set_rnext = 1;
> diff --git a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
> index 7cffde02d2be..14addfd46468 100644
> --- a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
> +++ b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
> @@ -72,7 +72,7 @@ static void try_accept(const char *tst_name, unsigned int port,
>  	err = test_wait_fd(lsk, timeout, 0);
>  	if (err == -ETIMEDOUT) {
>  		if (!fault(TIMEOUT))
> -			test_fail("timeouted for accept()");
> +			test_fail("timed out for accept()");
>  	} else if (err < 0) {
>  		test_error("test_wait_fd()");
>  	} else {

Thanks,
            Dmitry


