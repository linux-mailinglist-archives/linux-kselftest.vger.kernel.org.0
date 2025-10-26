Return-Path: <linux-kselftest+bounces-44057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23149C0A1E6
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 03:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9AA3AF6D9
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 02:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717B4261B91;
	Sun, 26 Oct 2025 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESWzTYYS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885E2609D4
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761447397; cv=none; b=L1kZRpPqwN2SaxsUQvrmLHfWV5u6ZWO1lSWlsiO1heAPG2HPyhfDC7ZYve/yjTTpwwhTtq/DhgQodNEUozjR/OFS+jQVg82sZUeuaQdqLFQoqbuGj8k2tj5Pj2OzvcXyV57pmsIz0d2yYlwzUFDhbr1hGK5eANIWe0+tqqSx1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761447397; c=relaxed/simple;
	bh=WMIoHeGDeQN9kTV67+ZtxnZ2djlpcLNFGvv/kEgUiRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1on3gktvXFI3+5xuaj2Hwpnh32yURtDqgpnf5dCXQMiJY4cPsxOf1ZBZ6g7OH1MCskMHOLLpfkagmeC5qJY5WY8pQx8d0XDq44c/QqZ/XgEIwmqfcqnSZTFOEVMSPGT4ZBBxYRv9RtjQhj0XPq1/QOf71nIp9WxUeXWqZIFw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESWzTYYS; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-932bced8519so2894668241.1
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 19:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761447394; x=1762052194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IfE2kMhhbNGjJf4FBWUzEJkfsNPGT4ktOzq6Ee9jcQo=;
        b=ESWzTYYS23IUDHqlPUO/Ob+neFQJ/wgJ+TXiQXNLHyz8EDrKnitYefO8Lu5nbznrXD
         6sPVcMZ7xpxpFoOUC3uLGNAAHQ7poTFpCFx3DZnC8kcOdXOvqY8dmpktvmAc3smfeIaj
         gOzA2QI9oZG7CX9mVbbHhG03Ey/vXI/bj7OZndRjsbvkiC7u3jC+mGdxKR0n8eNXRQ4X
         g3CZ7V4wyXzTlXxk8fzXVgOcGaKBmZznDqtqpGmHYkGuELe7ZSscPVP5BfJ2+c/u5VIK
         F1r/fdYFCPh8j2mVVa0Ia1MXG3c31SEZ9+X3UWvOTWC/EqyJD63Gciehx04orP/rCWB1
         SpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761447394; x=1762052194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfE2kMhhbNGjJf4FBWUzEJkfsNPGT4ktOzq6Ee9jcQo=;
        b=K+nSE4LDuskUcrgo0f8RtEvAtZa4eU2ytJgC4D0is6Z5rRDproC+hmzJXzyzR8a8t8
         loWZPFF/oF8V8OGnsJW4j9Igr7W4RaPAG8HnZhbDGhQbmKZx8tuGh4mD01fpPda2CTU1
         mSBi9i/xGbBe0Qh5OQEr2QjMTM8hTxSz9trED/8ODUsB4l0VPfA9xHhb/DTMnWgu9Wv1
         vHVYvFYvKd4uClfAsC7FHQqnpuGWX3sQbMqv9ASEJ61IwaAOPD7oM+pqnNmC5cWLUPMP
         zST7cezVxwjwbp/4aG3fumFtXlOPA3tRiAZrYFXFeAXl8yu/WMR1Ahq6XQfB1bj9kxlt
         j1Zw==
X-Gm-Message-State: AOJu0YxwWLGZ1mynFKe9B+MyYzO3XnctzvnkNVvEkIBXHd0WKTSekmSi
	lCfdceMFndzNCWvHBudT2CcZgKAXgrmyOndUCtmYkKW2yhg8fmQklsVl
X-Gm-Gg: ASbGncuZ6MyrSLwZl/JdrHeUZQHbxb/sFoGJDKgQ4v8SPeKI4wC5mDnkbsZfnTfHI0o
	FXaW1Ga5MIdXwqBvOTnE4WChB7qMf6x3l8Tt4l1rHWq7ITGTbBl7CtsT5NvV3pMbYypCQbhjCmg
	dMu9eB6sXjB+POMZtJPSYv6MxdMdVE9X++LhAcXYfFJUSzxKGHDkMA+7jlJrPIrNkwLUQQZiC1y
	GcLAvjHjNalacQhHjgBBHCjW0sLjQ/hKsLT7ophHAjmAdVGMOFzzZf62xR2N7RD3BgaWce5qIfd
	ELhKqYPJoUvrr286UeJiOuoHHZ+T55FNC2SaUxONSijN/8WJsfevld4x010SXl1GutfYWrYoNiQ
	YkITykRxkCAmEx5nwcC6fYbFWa/3QSdGWWrt2Kh2GK3L/jtBP+x5eBv1ZErxHt1ws886L/iyrUy
	+rsiA6O7Z4t4Pxc04T
X-Google-Smtp-Source: AGHT+IFEvi5BCIpNjIAk+L8wx9AmdLN0mDrqj0eQcdBvzBhQkclB5kD87AXiHagxZsym14ibMVgy2g==
X-Received: by 2002:a05:6102:50a0:b0:5db:242e:71d with SMTP id ada2fe7eead31-5db242e0a11mr5274445137.37.1761447394606;
        Sat, 25 Oct 2025 19:56:34 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5db4e592e61sm1359406137.13.2025.10.25.19.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 19:56:34 -0700 (PDT)
Message-ID: <d1a483dd-5405-4e8b-8a38-816d49fffbc3@gmail.com>
Date: Sat, 25 Oct 2025 22:56:32 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tty: add tty_tiocsti_test to .gitignore
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 khalid@kernel.org
References: <20251024161909.327158-1-krishnagopi487@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20251024161909.327158-1-krishnagopi487@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 12:19, Gopi Krishna Menon wrote:
> Add the tty_tiocsti_test binary to .gitignore to avoid accidentally
> staging the build artifact.
> 

Why do we want to ignore building this artifact? When submitting a
patch, it is important to list "why" something is needed. Not just what
is done.

> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
>  tools/testing/selftests/tty/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/tty/.gitignore b/tools/testing/selftests/tty/.gitignore
> index fe70462a4aad..2453685d2493 100644
> --- a/tools/testing/selftests/tty/.gitignore
> +++ b/tools/testing/selftests/tty/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +tty_tiocsti_test
>  tty_tstamp_update
Thanks,
David Hunter

