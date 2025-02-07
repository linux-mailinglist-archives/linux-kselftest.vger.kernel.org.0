Return-Path: <linux-kselftest+bounces-26025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78020A2CBDD
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984B23A43BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB791A8F6D;
	Fri,  7 Feb 2025 18:45:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF3F19CD19;
	Fri,  7 Feb 2025 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953946; cv=none; b=csf6pGhDv3RzvjbV3UvDqH6T9AhGMszw+c4WTgXMLDHckVLQDbKOZrZIhUT4YxmEuwGSbzEkdjJvEyJHuHwWe/BB2N8snX/LSugJ700G/dU0mYUQVCSyU3yqxi/I2y3YIWx9TbuAUcvSs8ULFgXKChKHaNEL+mXbsuY3GQOQO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953946; c=relaxed/simple;
	bh=G08VBEyiJJ6tR5NpSaqtSnJ8b/jJyircUmEMF27A+NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIoHov2ohflqahHw72UWyyergCGtTlERGmp3lh/9kjBIV/UVnk3YFMQ1xxWLwFxCkyUBnR8VRLoVfSS72LtZ5VsMrarQT1kOfEh7XyCHJ2Sa2T/Qpxa1JVAjGWAH0mPj7s5iOwg7eW3jtoHwFK3zysMb8k90k55TeVciHR8HXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dcef27deecso3538990a12.1;
        Fri, 07 Feb 2025 10:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738953943; x=1739558743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9VhtexnXVY7QzQMUAllx3j3vLs0pu8Zqa/G9m/NY7Is=;
        b=m7+Kq4m+rEjPUvojINjofKZqdxl5Z0+F6Y5ADmtfJNtJtgVsEqDJFvzc4pZKzsPOi6
         h0kHf+mXWtralaU/Zl0D6onLfBRSmw6Im1pGi95827OS6G+pZkO50T5zzJLprXJ0/WUs
         wH7Bz2/++Qs4R0l2kp8R6zuvasfV3Ec5BKgMPfi6c4VmNeA3Z+iElXRinSW/O0ef3eRE
         tCXxSYHLLyLEfVNLEtembU4pzno2IMGg7AoZsf4m2XTLEF4etw7oK+jFFfSrjx3e+mRu
         WwSjkhfR08Jn6qDXTHMjNxunCzeZ2YFwWPpEK/28B34SU0S9569gYZ4wVaDcLegl6PCG
         gj2g==
X-Forwarded-Encrypted: i=1; AJvYcCXa80UfyHBkq30PSfUd4a5W4KpHl9UOJ+Rh6NB1qRwqm1mThkqZzwB3Icf3nZITS8UbyAMPNQu1+npSIbmOJrVH@vger.kernel.org, AJvYcCXhHjdcw3kWoGKN3ayZMt0RQvZky/ABmrYCcY39Mv2xeULunyNjoy75WhqpZt4uc60QvN7+auAm33q1f1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNPbw6PToN5DrkkfiTpBhy9GjwZITy7bpOWKwWVmrm+ZDMzlMt
	mOytrDZ/JIT2VqH59dhgwmAaWjDpX44VWryv8WzqRmZvkeO5c/ej
X-Gm-Gg: ASbGncvMuLzrUONLBmXqfmGS7VadgPN8syEyqt01RHbBLyD5V6X7K01XVu4ymPzczc3
	+zGHCqPIajMFgZNNSaE9vZwEfCj81NpINoHc9Sqk0Vj38lGFZfVXlH6Vwsan2QyZ8yoX47FOqT1
	ZURMsKDr6kUxbZESY6wBH81qoJzL48LuQBYmjAwI1eLMKpq+6FNdzN7nVyXJK7IiTW8SL6NdHTN
	fvGFsvF1Lvxiu8qKc7qEY5dfn/eWbIx372LyzIPxBk0sUQI0AkxAa7aePzQ/ce5f0n/AjqD++Qc
	qpxNAA==
X-Google-Smtp-Source: AGHT+IHAR6axEQ9+MHkvZntvG8d4OS0CceWilbre6crnARE2tUy/m826mkvKKvBjhjA1TdvTgvMfIg==
X-Received: by 2002:a05:6402:3483:b0:5dc:c9ce:b01b with SMTP id 4fb4d7f45d1cf-5de450048camr4278947a12.8.1738953942726;
        Fri, 07 Feb 2025 10:45:42 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b81608sm2898142a12.35.2025.02.07.10.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 10:45:41 -0800 (PST)
Date: Fri, 7 Feb 2025 10:45:39 -0800
From: Breno Leitao <leitao@debian.org>
To: Mark Brown <broonie@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Fix uninitialized variable warning in
 FPMR test
Message-ID: <20250207-small-marmot-of-opposition-e7afd3@leitao>
References: <20250207-arm_fix_selftest-v1-1-0d6eeb04299e@debian.org>
 <89da135a-8c14-478f-9830-0b03ecd0b14d@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89da135a-8c14-478f-9830-0b03ecd0b14d@sirena.org.uk>

Hello Mark,

On Fri, Feb 07, 2025 at 05:26:06PM +0000, Mark Brown wrote:
> On Fri, Feb 07, 2025 at 03:06:42AM -0800, Breno Leitao wrote:
> > Fix compiler warning about potentially uninitialized orig_fpmr variable:
> > 
> > 	testcases/fpmr_siginfo.c: In function ‘fpmr_present’:
> > 	testcases/fpmr_siginfo.c:68:25: warning: ‘orig_fpmr’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> > 	                         fprintf(stderr, "FPMR in frame is %llx, was %llx\n",
> > 	                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 	                                 fpmr_ctx->fpmr, orig_fpmr);
> > 	                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This seems like something that should be reported to the compiler
> people, we only print the FPMR value if have_fpmr and there's an
> assignment to orig_fpmr in that case.  Which compiler is this?

Good point. I am using:
	# gcc --version
	gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-2)

Clang, on the other hand, isn't upset about it.

	# clang --target=aarch64-redhat-linux-gnu -fintegrated-as -Wall -O2 -g -I/home/leit/Devel/upstream/tools/testing/selftests/ -isystem /home/leit/Devel/upstream/usr/include -I/home/leit/Devel/upstream/tools/include -std=gnu99 -I. -Wno-address-of-packed-member -Wno-gnu-variable-sized-type-not-at-end -D_GNU_SOURCE=  testcases/fpmr_siginfo.c test_signals.c test_signals_utils.c testcases/testcases.c signals.S sve_helpers.c -o testcases/fpmr_siginfo
	# clang --version
	clang version 19.1.3 (CentOS 19.1.3-1.el9)


