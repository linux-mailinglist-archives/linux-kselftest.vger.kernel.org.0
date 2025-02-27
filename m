Return-Path: <linux-kselftest+bounces-27791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD71EA48544
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 17:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4D93A53FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539E31B3935;
	Thu, 27 Feb 2025 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3naGwzD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689554EB38;
	Thu, 27 Feb 2025 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674173; cv=none; b=HYxfSoZ8fz0sq/es52L6Y+4ivOWv/+p29MvFsOgl8NgXBknsMoIo1EOagm9VIyvzF4EaQLhyOnG9R2lR8VJN2zCLit5clroU8DDHnG1JpS58xO2LB6cA7v9L1hASyMpxgspzqeOH5mCzpZ4I26OZWogx7/QKr/7PYTdKhSBqKFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674173; c=relaxed/simple;
	bh=tW6s2JKeVYmMjgRZ0LxOh+ZtmueuEyrTI2i0CLDEnCA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tNrPYQsnOm+wo2JfnBDIq+oobRmpGt2spQIXflQVOd4LyBy23Taze5pz2EOmkm9HRHjVI2tpo0O5BWB+oMWzRybmuWO57tiSlLg8XN2e985USN9I/93M/u+0Cw8zmPjiS3pXh0jhjHEl/AlGzOndz1d5fzvD3Uge1hO8j4eXeEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3naGwzD; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e889e77249so10284536d6.1;
        Thu, 27 Feb 2025 08:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740674167; x=1741278967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLuG7vjn/hSKib3SZKgP6rgyU2H+3BpnRfZM3277BQA=;
        b=X3naGwzDxFd2n/juLJmVg9Ny9khVmzLCbtx62DaODl0y0UEEzymk0wTOlz0IOmCVoR
         PNgS8fCNu6vPmXr0p0CGz/sywuNQaFq8U2hAj4OdlLBQwRZseem25H2nXtgezxsSlNk+
         j1zRIAfLYaffgwaFuqXPij7zYU+31BByk7LQWxuxg0PFiq4FTy53GG0FwfJ/sbgDfLXR
         WGDWVNim2o/rfuULyzx3h4k0aChT5VITm2HU8kOSp6wyT7oEF59pTVaP4ANBzjThbo1B
         qLfN4VLgG2C+eOt3IV5VlqEBXF4sLZ7S5cDELn9XQLLT2rj8NpO7iwNdQW9X3FpoKaCd
         4gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674167; x=1741278967;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YLuG7vjn/hSKib3SZKgP6rgyU2H+3BpnRfZM3277BQA=;
        b=aJdFt72erBp3+eUhltzxPRZoMc75yisJNnAKgUByZPF1qf2G7Jva6FTj2nBulmtK6I
         DnnYVeqlGPZZdrz2hBDp8tLJ9ar9H5RM5E7R6+HOI57yZjPUmOrQhZ8zGGeaUSbXiTdx
         7XnGq9RNHayEn9m7+INIAHsl7YwI0X1m45aoKRVZ8WgOTCkS64qC5x5bBVXuxoX7gjZS
         pjvsRUe/zZ3vFdM8kijU/Yf/d6jc/bw28Kgd/dlqjg1KTBYVr7DEz6k1tAeCc3uB7M+d
         YHF+uZGF+3kfzVSQyKMNAAjbWNc0RCqqNMVocWvcA+OGyUOvyn2+TN+HMKDPAUFjgSTB
         4UBA==
X-Forwarded-Encrypted: i=1; AJvYcCW6JhOG+/wLbQHm0/yPXffBVQtnI8JICM2FmuSifxyUtg11SWsvFgGR9eA6xeDwUojH4cXU8ynR2nUBzBx5imo9@vger.kernel.org, AJvYcCXTdzyqS/q1WWEOHkzeyExzC8P6REh8pAz/BQcdXUzuh8hnJsqvywx1yUFUDKfjOH3wq0+92PNfDkicfhs=@vger.kernel.org, AJvYcCXktGFKEwn0FqlOQYjpU9FUW/nI5221H/SB84PorwnGPCpmaTqRgJs5OnDa8GgGybcvphY7+Vvy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4m5dDzQkYQZx7H/5jexhq8PTOUMR9eEvozwWrn0eGm3Mv+ByE
	GI0Jjw++sgsfahHgNByeTzWdgjOuvlTkUmRBAL/X6J+xU33ZWKBZ
X-Gm-Gg: ASbGncv20xY10jYH7ueSwIgpltXOaR0J41lWAtk8hivl2Qrm3ngOht6FeLCOBq5xXUo
	T+/S2t3MxzJe6WOrIvaZ61GS4/UCLerD9CQcumJQr96oThLBZ9KPyoZWNoRlqo1Co4QCb6U26JX
	F3548HA1WEK8s9X7X9AZySZl8cZpzzjh8HGDf6CJhYPrEmMadSNtUuDTSq+Qg8Ggdbu1+wo6h0H
	x+InukQc2651Z4HyuIGdDMQdJUlF0ueGJyAb0gSebTjovsZ9uOVya+Lj1xgpSYm65iqBNFL7+aC
	ci5num24ZthP4ocJ9zDiyPeXjOpzVelP++IERkhN8pK8ppNj48LZB759bGWieA47wDQvPZ3c2Hc
	1jBo=
X-Google-Smtp-Source: AGHT+IFNLlyGHLJ8yNyFO5ni48kZW3U6VXxOlfgUtSsr3Wug6ZtI+rA6mhO8eVO9q1umiyhsXnA4pQ==
X-Received: by 2002:ad4:5f0a:0:b0:6e8:9444:7ac8 with SMTP id 6a1803df08f44-6e8a0d093a0mr1377866d6.17.1740674167401;
        Thu, 27 Feb 2025 08:36:07 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897634d3esm11507256d6.11.2025.02.27.08.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:36:06 -0800 (PST)
Date: Thu, 27 Feb 2025 11:36:06 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kevin Krakauer <krakauer@google.com>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 Kevin Krakauer <krakauer@google.com>
Message-ID: <67c0947690e22_37f92929444@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250226192725.621969-1-krakauer@google.com>
References: <20250226192725.621969-1-krakauer@google.com>
Subject: Re: [PATCH v2 0/3] selftests/net: deflake GRO tests and fix return
 value and output
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kevin Krakauer wrote:
> The GRO selftests can flake and have some confusing behavior. These
> changes make the output and return value of GRO behave as expected, then
> deflake the tests.
> 
> v2:
> - Split into multiple commits.
> - Reduced napi_defer_hard_irqs to 1.
> - Reduced gro_flush_timeout to 100us.
> - Fixed comment that wasn't updated.
> 
> v1: https://lore.kernel.org/netdev/20250218164555.1955400-1-krakauer@google.com/

For next time: add target: [PATCH net-next]

 
> Kevin Krakauer (3):
>   selftests/net: have `gro.sh -t` return a correct exit code
>   selftests/net: only print passing message in GRO tests when tests pass
>   selftests/net: deflake GRO tests
> 
>  tools/testing/selftests/net/gro.c         | 8 +++++---
>  tools/testing/selftests/net/gro.sh        | 7 ++++---
>  tools/testing/selftests/net/setup_veth.sh | 3 ++-
>  3 files changed, 11 insertions(+), 7 deletions(-)
> 
> -- 
> 2.48.1.658.g4767266eb4-goog
> 



