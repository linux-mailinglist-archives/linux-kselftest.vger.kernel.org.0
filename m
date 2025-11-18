Return-Path: <linux-kselftest+bounces-45826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E13D4C66FB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 03:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C98FC29ADE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 02:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FE2309F1B;
	Tue, 18 Nov 2025 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmgknfWF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360272FFDDB
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431895; cv=none; b=XWK6knROzUFuM+uIZJQP0Mnr+YwbYHTJvfPjXvhTA2/aJV72ovmTf9+g/aj+2RnbBk95aUYRylv++GqpncyFy2o4zT/wg620vRANy+3O1YX2ySo40aUYjH9MQf+CbjaBPatq3ZjwPcmN+BpK/WpzfTcRiy41UERPS3F22HM90fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431895; c=relaxed/simple;
	bh=gyY7WV1Wzxl043qvEn0hHsBdG2b2C70TUY7KApCszTw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XEVhMfFGWvxfYMfZdth7YzKhjQEGzJG9xMVJO37DiLB+iSXEyGKZsf0Jbdve1ccBVCcmZ3xwgaRquOd5KGNFmTzUHK35H7VvXtRpxHwhC4p+zI8CO/ubEXPTZOYWMRpwbUlcKrDqvCOEkgi1sg8YUYmro/DKXjUQaYhs/4TkgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmgknfWF; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64107188baeso4510460d50.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 18:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431893; x=1764036693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tv/ZgeiRPcv1LDz/7V5oxrd6Xuy+RZn3CBBx5mE8xY=;
        b=NmgknfWFoJTOkZCXtAPccx08Ehi+fhBzkvJ337Q3xbZwIgXKd0OGUSVcwm9G70IaAF
         ZxRIFnf4dc4tpluB1r2KCtmUYllyhOnojQTfKHx1q+mbUX28Y2Ca6RleqEJAhtSMln6M
         xZhp0E+FyISDwbdaQySOuCCw3eOH4X4ojNbhr1mKBgSc+fURq0iZJA/UksTRKKTTQ1fy
         ghFe8uF4ofIt/Y/4yZaJZRAz7M4KJFG+uEJnpbGcGGAdg1S/cmaMpKMoOb0fHcjL9zhW
         a4bOteQe9GV5LEXxTBvTTjPHfan0JXQGKD58EzaurB2ohxvbJ3IriAjuBpOL47+wKxKp
         mANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431893; x=1764036693;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0tv/ZgeiRPcv1LDz/7V5oxrd6Xuy+RZn3CBBx5mE8xY=;
        b=vrhIhyatWn0Wjl1sNBDJArHi55zeJXu3HzNtQztmYRyCEKYZ6CDKzaFYOn93KtlhSV
         7A6vjU3Vlnmwr3dprEf+oQfw4Bzyx+tbdSg+Fw16qaDyy02d8iqRMP3bPZnB6lXifw+p
         8t0yw7hgKdAzmaKvSLCHQrqTJVdOsBfa0pfeyeN0byrn1+xTWeu9/7mxWsn4Xo2X5bKo
         9dVgbJlQ3SvSGGl/dBN768YvcFoXSVPpWU3Q1V0Xxmv2ezvlgaNHS2eNb9/EM7YiR+Nj
         ZxPDIytyZfruQI1hKJnwGeyhFFsFtYuZUGGztVZfICH2ol0QIVi9e6A3/84AKJnnwAeD
         GgDA==
X-Forwarded-Encrypted: i=1; AJvYcCVZwgNcbjhO9f8wV00ImetK9r2tF/McUEGlnhHw9h1q6Uciiy/spMLbaGYYGCxJ0HCEDUi8Xri5AGNF2eVUcFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdL+f6XQ0jHtBTTB6seHduOqq4Qe6szJZoQGK2Q0LWVVGYhX/V
	Yw/0DOj4GygoDRXMMhbmdolvOtNe1XM//0xk0NZH1KSKQSiPVhrfSFU1
X-Gm-Gg: ASbGncuXjHvAu813hxhAR1gedp684mLXEkAsiScqD+Z7vsZFQesOT+X4MgQ+yUNnn2H
	nP1rulHFRJE4FR2MxBvy326aJDEovZ/VIrBsRWX/AgQIzISi5JN9usIq03rrOqiBB6okuCrxuUK
	9XRAkW3EGrHL0UrlAx7CiGi8QRe+YMhi2iF6HwoHqmozspbouxibh9Fcb9qOnEFiV8DyPOmtoFL
	KvDCK57F0vpbieh9yjxMVmRIgtfEPJKIJtVyvdnRbMMzQqqnVndfTAZ03UJ64qIsE6aQD+c6uV9
	mOPFIPvXKVxWqYqTrwC7rkoX7MxchXAYQ2L8V8ej8j6qG+EQwbZU1eenGqPPcUxn78mM2ON3pbB
	3qtR3JiFv3NnuhXJkcgebh7wFLIVsvwDWwScoo6Us49xHr1tH5Fqx74JqG+DoB7LNyH+EUitZpC
	iEjB66qJdOmCmN3gxWkgnQGpmj4mplHSt9E/uzRUZeCASIau/LphEs8Zfs
X-Google-Smtp-Source: AGHT+IGlyZXbpAc4FMrl63x+aCIc7nbnDZkFH9Gh+Dw2gNE8Pm1S5ViPDKo1zgyuxUCgQz/c4m19pw==
X-Received: by 2002:a05:690e:d86:b0:642:84a:7ba4 with SMTP id 956f58d0204a3-642084a7c6bmr3585674d50.85.1763431893027;
        Mon, 17 Nov 2025 18:11:33 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6410ea037besm5292626d50.9.2025.11.17.18.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:11:32 -0800 (PST)
Date: Mon, 17 Nov 2025 21:11:31 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 krakauer@google.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.31c286e47985d@gmail.com>
In-Reply-To: <20251117205810.1617533-1-kuba@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
Subject: Re: [PATCH net-next 00/12] selftests: drv-net: convert GRO and
 Toeplitz tests to work for drivers in NIPA
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Main objective of this series is to convert the gro.sh and toeplitz.sh
> tests to be "NIPA-compatible" - meaning make use of the Python env,
> which lets us run the tests against either netdevsim or a real device.
> 
> The tests seem to have been written with a different flow in mind.
> Namely they source different bash "setup" scripts depending on arguments
> passed to the test. While I have nothing against the use of bash and
> the overall architecture - the existing code needs quite a bit of work
> (don't assume MAC/IP addresses, support remote endpoint over SSH).
> If I'm the one fixing it, I'd rather convert them to our "simplistic"
> Python.
> 
> This series rewrites the tests in Python while addressing their
> shortcomings. The functionality of running the test over loopback
> on a real device is retained but with a different method of invocation
> (see the last patch).
> 
> Once again we are dealing with a script which run over a variety of
> protocols (combination of [ipv4, ipv6, ipip] x [tcp, udp]). The first
> 4 patches add support for test variants to our scripts. We use the
> term "variant" in the same sense as the C kselftest_harness.h -
> variant is just a set of static input arguments.
> 
> Note that neither GRO nor the Toeplitz test fully passes for me on
> any HW I have access to. But this is unrelated to the conversion.

You observed the same failures with the old and new tests? Are they
deterministic failures or flakes.

> This series is not making any real functional changes to the tests,
> it is limited to improving the "test harness" scripts.
> 
> Jakub Kicinski (12):
>   selftests: net: py: coding style improvements
>   selftests: net: py: extract the case generation logic
>   selftests: net: py: add test variants
>   selftests: drv-net: xdp: use variants for qstat tests
>   selftests: net: relocate gro and toeplitz tests to drivers/net
>   selftests: net: py: support ksft ready without wait
>   selftests: net: py: read ip link info about remote dev
>   netdevsim: pass packets thru GRO on Rx
>   selftests: drv-net: add a Python version of the GRO test
>   selftests: drv-net: hw: convert the Toeplitz test to Python
>   netdevsim: add loopback support
>   selftests: net: remove old setup_* scripts

Thanks for converting these tests!

No significant actionable comments, just a few trivial typos.

