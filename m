Return-Path: <linux-kselftest+bounces-24429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA363A1005A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 06:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD991887BC5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 05:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC47C2309A4;
	Tue, 14 Jan 2025 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QeA5Mckb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B602595
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 05:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736832769; cv=none; b=Vrd6PUdjCDSzgd9M7+JTGUGDCmc0R2ePqhCicEsOqXdBOyJJZYAsNPFdsvBH7aA/Hizezr2ojshLIutwCvpUjdxRTNPWiHcMzCm4nY2mqYA71zv/eGvw795hC92Mv31phZUP7e/wKl1CsfU1rkyCqCTeY1RXf8PTmYJxICnf/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736832769; c=relaxed/simple;
	bh=QQTufbY/evwUHAS6v3e7UmNDN5npP/AEnyl1/ajoYEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=n6GKN9IM6qt/SQNvVjOzS2Nt6noF3VR2upYkzpjAq+TG5I2cBmptnWr/9ve/IAjcsq+19XjItQiDMyNN4SjAovfAmvgpsLf+FLc+o9R6AMAkQaHfv6v9LS5akVt4lDd9J7mebJsxgrCKpEuWSrj6LF12GBJ8ufX6Hx66Oqga4MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QeA5Mckb; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3cddfa9a331so17863885ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 21:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1736832767; x=1737437567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f1Bp10ZGkW5gD2RlZUXeDywURBlq4mu2M9HqJf63BKM=;
        b=QeA5MckbDTFsXW1gi9zHLfesHwbG6O5OXuYQkgE0X69pnxF7QTUdTvwcpcT1VP07FC
         Xkp0b/xzEFJukr30kc/wqtVee6Jxfr1uHmVqAnsbTIags3kCfarTn85Y4VndxyKULmde
         bzkmbTbC2vqkKnC/hDrCxVh5ptDsAN5kVGbjJD+LL4SoetV73ni0PcBmV8G/0wc8SMnp
         O9tVRbpat3gLhOTD9wjqMoBZBHTqNsGnFOAmfNcWgDOCN54oM1bNc8i0emVlNEumtaY2
         skHZ5x0MI4vWk61RszaXDklUMVgM50CEeDE1DYG3mU6wF+eWfbKD6nBfTZuqsDJw29e5
         ADuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736832767; x=1737437567;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1Bp10ZGkW5gD2RlZUXeDywURBlq4mu2M9HqJf63BKM=;
        b=fAisCT/uRBx+30qfltPlieRgkkEzu4Yk56+wXlC4cGvacjoUDGaTZJEoy3Z2HflcoD
         kRJVbylgS00PJkWqZlssVnr2kPj60tz/svdQ7SM+giZzLqHpVtBP7ind7BUoyf7DEqV4
         9LYQoqF6Ip/jStDPcU5my0u2KVgk7Q89tEFLgLmhq3N/XeYg6QkKU88G6OCX/qa7CJSb
         1spFX4U1e7z0vXGuHIB8upB9kviz/q2Me0YTujYEbxY+AK0wEWQCMGBr8cGZ1tJU5Rai
         2cu7UXZrVvaamlpakfZ231GsM6idi1bjlhmRVIpq2n+D40ydwZNe9Mp1BP16Jc/LA3YR
         aglw==
X-Forwarded-Encrypted: i=1; AJvYcCVJeunfyqLhJPy4jmLTMFVQApzwRqKm6yE2jsfv90auVMijSxPj9qzlf1PnrmqVgPaBQoWtF94Sjolwe9DLNPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPg4fYTW8denm0sbsPU6wQJJE8MJIa8NQAMeDRLDG1krBKGgOG
	LGlhJMt6tz8E+GV5peoIFguCzTBETlATfO1e8K/vSpzZxfYXyFBVegautHCCC/A=
X-Gm-Gg: ASbGncvlFGwbwoyoCiAKctbyJEwKSPuN8JN7EcIpcDxx802yj4F+dyhBR2AUEMgWFTP
	6EJNseG4R0L78qfm8hCu8OwcdBRp6tdkiG1UKACU7K9kGI9j4YfQ7zU0gsM0JgmCuUcnHVEPZc7
	8aGM/5Gfk0hXuz4Qdu6GWZfyUpqpgvf+PB1MQAu6IZgDYqm+bxZxAJQEGqLpNQwvhD+FCZpnjVn
	K+lfjfG8o0GhFAL0K8c9txyrXB74mmB7pKGakRg00+K07JcO0wzbv0dwDN0kfv/5xKmPMsNzG9y
	KI0l
X-Google-Smtp-Source: AGHT+IH4xYP4M6DhMu3ld/by2JdHK1yfyfQFeSU+FypC6PibjVehEMl4FyLmPwAvmuuWc6iZj61OWA==
X-Received: by 2002:a05:6e02:138d:b0:3a7:e103:3c43 with SMTP id e9e14a558f8ab-3ce3aa5af3bmr25675045ab.19.1736832767477;
        Mon, 13 Jan 2025 21:32:47 -0800 (PST)
Received: from [100.64.0.1] ([165.188.116.9])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce4adee7bfsm31862735ab.44.2025.01.13.21.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 21:32:46 -0800 (PST)
Message-ID: <fa984379-29b6-4093-9213-6a291ccc7e23@sifive.com>
Date: Mon, 13 Jan 2025 23:32:45 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] RISC-V: selftests: Add TEST_ZICBOM into CBO tests
To: Yunhui Cui <cuiyunhui@bytedance.com>
References: <20250114021936.17234-1-cuiyunhui@bytedance.com>
 <20250114021936.17234-4-cuiyunhui@bytedance.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
Cc: ajones@ventanamicro.com, alexghiti@rivosinc.com, andybnac@gmail.com,
 aou@eecs.berkeley.edu, charlie@rivosinc.com, cleger@rivosinc.com,
 conor.dooley@microchip.com, conor@kernel.org, corbet@lwn.net,
 evan@rivosinc.com, jesse@rivosinc.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, shuah@kernel.org
In-Reply-To: <20250114021936.17234-4-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-01-13 8:19 PM, Yunhui Cui wrote:
> Add test for Zicbom and its block size into CBO tests, when
> Zicbom is present, test that cbo.clean/flush may be issued and works.
> As the software can't verify the clean/flush functions, we just judged
> that cbo.clean/flush isn't executed illegally.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  tools/testing/selftests/riscv/hwprobe/cbo.c | 66 +++++++++++++++++----
>  1 file changed, 55 insertions(+), 11 deletions(-)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>


