Return-Path: <linux-kselftest+bounces-33522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB15AC163F
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 23:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F62C7B9A19
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 21:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E2525B690;
	Thu, 22 May 2025 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mhjb2SQV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779B22687A
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950747; cv=none; b=rKJQn82kViMiSN1uQgWMV7aBPifC8fsS5eDqmgLyTUb3c9JX26S2etB2PwCgI9kBHsj/XylMvwqJ3VDCqyRxZYw/ip0wmHUMgPZl+8dQ2sTw5OK5//pCGE95Nx1SKPuIPJvUBiW6YwxjA7esm9jGn9eNXMV0PQLlNKzgJg8I6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950747; c=relaxed/simple;
	bh=h3gxn9cuXoddDKHE83elseHrpfGuY2/pgmGAoap5d/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HS4EbV4+zr8wScyHNf9aawgjSDvnrh+KIwx5rhooVPxlK+c1XCQ3lf6ZAn15N8ijf3lcYZTHCETlXfvpYJrukxlrGPVfWF1QnVGV2FdbQzHbBmkPKZJ2paZfiJEGRdqdQf2dTMH/QkjVcMA8Ke5VDVdULEu8GDb0kDixGjfKKFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mhjb2SQV; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3db7b3de375so62025925ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 14:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747950744; x=1748555544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3gxn9cuXoddDKHE83elseHrpfGuY2/pgmGAoap5d/8=;
        b=Mhjb2SQVX3bac/4Vqm0LaturAOnByhS4eol6tJIAV/nrLWV5x51Fs8dBj2ird/PMjP
         aj44G5thvQUXI5Ek2xKom7BHNvY3xcPCgS3QYUHQ6N/1fG4kpmzlt5TVSxV3xcKj2fE7
         yeXYaHonkl2TsGkGMPYCWcPB/42KD6hPyptFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747950744; x=1748555544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3gxn9cuXoddDKHE83elseHrpfGuY2/pgmGAoap5d/8=;
        b=qMapfteoXRy74M/V/kPmGm7zw1JdvBBO10ax1eC9Vab9Iaul1kVGt+JZloOoXsciyO
         ujuoXHOiflETjy7n+sDZfaXYNUKfoULZ1kST7/+nxKmCEHIviUFgZ7bYQ6th+6H+ARxK
         PjqjD5es1MrRINxThn9EDgWk8MP+BbMk8TXbRIbL9IbRYdrLkykEkk988ufJt0d9Dg4V
         E1KMauTx9YegPVIz3/Kn0EHX5EpaL1jRZhi2dufT+JUYrcsFkFZQ3QxFqj5w2jvaqnjD
         vMtHZ6AxjNM+HjoHIbaV40jQhYyxIhfO5qbHHwtRD1Rhtv09ta0/SsUBkHb1xknCAoCM
         6S4w==
X-Gm-Message-State: AOJu0YyLctBUw9uxjpf7BeWy6SmI5bMyxGxFw1wHSxESvTJsSWNuVfeF
	x7DWIrh7aAiw/chHs0JOUWFGEHh0+oBEe9WAVCUbu4Tm9xl/NiOW3QayxFvMPl1rPuQ=
X-Gm-Gg: ASbGncuIe855CYUwWRq4wFHgBtj9iA+PPz+Iz/aDeNtQKJKQw/ZLv8AmfvAHsgYqUr7
	PpfRGnt1B9qms1lNKM1etBMz6nUq6Njw3azgqosBV4YlLJJIM56/MLJydx6N4AQY4o1TWcEooie
	ir7ltaX0dsHDFYqNA3EwzZmHvN6ZO2SzoIKsuRklHnF+8it021Ln7M5xmONjFkvO8rn1Kwwh/DS
	DN2IFKgIUvyROuKP8sYPJOamk9ej9IQgx1s8JrQ8GlnrtyTw5B1LTW8sFZOg/hAfB5lnhZzc3O2
	gjExf3uMuBPNn6GD0flTkV1kRX1S+kVDvC+8I1i9pd3VZmHsPpl8KtTZUwP2JA==
X-Google-Smtp-Source: AGHT+IGDkDoKX26+mZpUKHL9ezkJ1Wm3f/pt0o5Qwk3JRyWzB8+ExKX2tHk3jPeY0mXqaoYvPkV82A==
X-Received: by 2002:a05:6e02:380c:b0:3dc:7df8:c822 with SMTP id e9e14a558f8ab-3dc7df8cf18mr116514675ab.14.1747950744575;
        Thu, 22 May 2025 14:52:24 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3db8444924bsm37442605ab.72.2025.05.22.14.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 14:52:24 -0700 (PDT)
Message-ID: <d1908709-dc6e-48cf-8a94-d03e173c6cea@linuxfoundation.org>
Date: Thu, 22 May 2025 15:52:23 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: timers: Fix grammar and clarify comments in
 nanosleep.c
To: Rahul Kumar <rk0006818@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250514222112.396705-1-rk0006818@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250514222112.396705-1-rk0006818@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/25 16:21, Rahul Kumar wrote:
> Improved the clarity and grammar in the header comment of nanosleep.c
> for better readability and consistency with kernel documentation style.

This patch isn't really fixing anything. I won't be taking this one.
Sorry.

thanks,
-- Shuah

