Return-Path: <linux-kselftest+bounces-31612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3287CA9BB0C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 01:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CDC1BA2004
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 23:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559F728BA8D;
	Thu, 24 Apr 2025 23:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ITkTACpp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D656521FF2C
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745535997; cv=none; b=NIDtv3RdF7+PqeDFw3wtz9C/QewySEM6Uvi5SJ1zm9s9duGqCSN0RgmtV1SNGvziGakN2c4uhJubq/A15EOe9uPhpjQzT4dVhS/WiH+beciPEaIn23eCKPcblXAHt3MVeewEK26m42XnaGimzv1Olv47GviG1Em/vKTL7fupyv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745535997; c=relaxed/simple;
	bh=zVdVMpwdwku6hQf89JnqL0nu0gswHMXefZ0dFzVmLJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doj1JdMSvCGbbma+no8N5f6VYVNj4iciB4k/infVoSM7LYwSjwSQeg/cCK0u0D6HzXgW+jx4YmfS0LHd0Rh9d4a8R6RusMlKV4JFtkLk5RemxPmtkkBsOpg7UoZ0mLlNt4a5IvE7kIczg+o6QDykj4LCrvcLsJtEJB0223lJwfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ITkTACpp; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-301e05b90caso1630300a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745535995; x=1746140795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+MTgwFQ11NGU16038peeNMEsxZdt3HC2woATvDfNrx0=;
        b=ITkTACppkwOZ8JjCwlwpPJ4LuLo5NlRjS/lUzjSdWXplhQ2wkkpazZKS1r8nsBcoJt
         uRNZO+nZaTgMiP2JwAxwZR6G7nYNHUvRsICyYDk4pOqIS3AUHN7THn94C8zryzGmRRzn
         ZTNuUr+1LnaSmUkPwT1NkJQkEhrFrogKGZBDbcTZYfzFr7aWD4ZoS0dqW7RyBsd+7hvL
         b1bh8l/USiTanCLve0XQ9JjEfV1YMrcPBnfi0YCGQGoTwl/BQpvQQITE7uHqO5tWM5Oq
         6193Hlzyg788AiG5/uErMp7vDX8ynap0ELzPkDCZU/dKpbPXzu+af6Xop74sHPiyF0Rs
         AN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745535995; x=1746140795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+MTgwFQ11NGU16038peeNMEsxZdt3HC2woATvDfNrx0=;
        b=Ti6E4yv4AiRBQxvR0wMTs/KFeirH/KYCgTBRsQoDAiZX2GXH6Ir7WVcHe3/P58Inln
         YjmxSQ7lYydaLvuVTAxmRmLGJacOVd3MagJ6SP/GSOyel96lwfMa6/cXzFxNXxqR+Zlu
         Qa8n6N61lGZiLnuAdHpeW2Bqxw2ihVZEHJKnKhAOw/nBJEgUno+Yn/X//sq+Y0PXRuQB
         oFBEuTdqL75Bx5Bzv5XpMyRzJCSsok9Q1GZXmXKGsNrtbhEZqautRYKcMf1QodEWJ3wq
         2FObcyj7xMMxVVHgia7ZI6qmDdIFloo0TxeRjb1MTDZJJZOcHwjn/BD/E6WOKdqvLkvw
         DgUg==
X-Forwarded-Encrypted: i=1; AJvYcCWFtbDxhG7Q9l0Bf+x011b4zavYGTrRBpUj2mX22HQUBPoLavmeLFvLU2KvRJf2SHJtZOeiuPAjVqjhT59rnyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7t3INp8B5nK4D3Fj9XhXxPa554i6qskoGtnksypzk2kCnAYZ8
	ZE+/OpL90DNCK+/Jh8ia4ZjaXO+UnOTs18TXq90AfQfz8EOMiwIFtKmfautjSSI=
X-Gm-Gg: ASbGncti7uOTC2NT61TdkuorFvT6wEZvwttq0Bbu5T75vE2kI3cUFydT042UexNzIXN
	8kdVysMcrvLj4yfYA5fuNu3sIdAMVBrWNy4cs5aCVGuxspcPtSSHGkDlR23Q4DGcz0kpPm2VBzR
	p+LO4RJozR0MTV4yJLci0P03WhFCSV4OktiHKp9X7S68vV/X85//rKL5Rrnb6hUft2Q4CAWvLbx
	9MbuF+RXSwl7pMbG96ugXTy6tLqMobncU9QrASK0oARWv2nKHIm1S5gcelN7iNkZ9imLp3I2Eaa
	ZsTL/w2enzHOGF8qLizVSQ7H+kTsY2lIKvC7ItL+JHqBn5c=
X-Google-Smtp-Source: AGHT+IG7bUAE/0tRWQcE15bPOILscwgPxL9KoMihzaNxE5X6mQyp8Gp00b+X+517kcg7/0UnQqovkA==
X-Received: by 2002:a17:90b:5344:b0:305:2d68:8d57 with SMTP id 98e67ed59e1d1-309f7da690amr472342a91.5.1745535995137;
        Thu, 24 Apr 2025 16:06:35 -0700 (PDT)
Received: from [192.168.1.12] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221bf9sm19273655ad.258.2025.04.24.16.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 16:06:34 -0700 (PDT)
Message-ID: <5e6eadb6-17e8-4ff4-bdd3-4ef13ba845a1@davidwei.uk>
Date: Thu, 24 Apr 2025 16:06:34 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests: iou-zcrx: Get the page size at runtime
Content-Language: en-GB
To: Haiyue Wang <haiyuewa@163.com>, io-uring@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250419141044.10304-1-haiyuewa@163.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250419141044.10304-1-haiyuewa@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-04-19 07:10, Haiyue Wang wrote:
> Use the API `sysconf()` to query page size at runtime, instead of using
> hard code number 4096.
> 
> And use `posix_memalign` to allocate the page size aligned momory.
> 
> Signed-off-by: Haiyue Wang <haiyuewa@163.com>
> ---
>  .../selftests/drivers/net/hw/iou-zcrx.c       | 23 ++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 

Reviewed-by: David Wei <dw@davidwei.uk>

