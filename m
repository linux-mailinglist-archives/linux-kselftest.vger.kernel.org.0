Return-Path: <linux-kselftest+bounces-24621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ED4A1322B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 05:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7485C166793
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 04:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB25B14884F;
	Thu, 16 Jan 2025 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="k+um2YUX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AD824A7C0
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 04:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737003509; cv=none; b=Z3QnV3PWKkBhGukfzwISOhCJNx9Bb8/XuBw8jNGvjjmGktjBzX0LiwnUAErXNKKDgpCl7saGMcD7u4e6UpZ7r8M5rvhoHxs1PW6a+lQt1KdtFto20j0TNn5akAbyGjpdRKSCqfC6mK4Op6/wSebu12QKZMPAi8bSRybryI0PZ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737003509; c=relaxed/simple;
	bh=pM4jq/+t6yMPA0cvFRGfhhuFmtipKif0c3FMYxgpqss=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=JEDrv0xuIlQPysjo+3x9WKxwhsOUeYh+w2JSa8PsonKsbq3QJxp1nO8Ga2mCM469fiYXtt4l23AntYgg/Lk9TUEvflPdmcNncGSTyHdDK7apFMrGFbZ+E3VbhMGoZMQcmzSK2pnDdFjxHsSNVIIbZ6vAoN7aROIKRyO6Ku8FaVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=k+um2YUX; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844d5444b3dso23177039f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 20:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1737003506; x=1737608306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AFLg8GSDpsapBIGiAyBWLlK/6kmfSioivJ/IsRLirXs=;
        b=k+um2YUXMbe0fDxxWVXwrCQWYptmBxfGBbbQ0mQHTUmnpDXGD9xjWxPjCPp12HFDdm
         WMHn+Yv62cUNRW/DOVunZUGp1BKA9QUCtXdgqNGRYC7Y0JPHeu8+6lXUyH7uidgOvjG1
         +R+EQNHw91zrfCT6R+yqWDN8YKd5N92tDR24vcVCE4bS0B077vRaykiyjfmy5ytNueAm
         pllR7bwvbtXQKOteZJvF0hqu3H/swgTmPyTFH3D8YMT+jh0Kae3Hm64XiikppZMAMv3Q
         KCvHdLgNc6wlbNcnN/qZxoTMvtC37M5x38EzJU9pln8uBQMJKaDx+qpyCGr+2JO2jm10
         ytjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737003506; x=1737608306;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFLg8GSDpsapBIGiAyBWLlK/6kmfSioivJ/IsRLirXs=;
        b=iYw1yV1Ah53kXhF2iN98i4aB53Z6dRz9rU4/6S7cBIgd4zpar/wM1h+8U5HQsuAPQP
         sP5arrR33zGX6aMbZi14+/GKQRTU1l1R2lN9PkM4/h1UTUWoloUEhw2w8TFQB/YEMqnQ
         2A9avKQKBQJ5w1aaui4UHKjkhZ+zWTioTRHpWTLdV1wEE+AyR3C4/9GauiOZtp5e/k1z
         Q5kc3krT2CO8mJKnKyJH/RD7t6iNEszWrZ1EIZazEncD61LaPxM+c1TgK1fXvpzYgcH6
         9hoFDHQs0aFC+IDqeDlBKKQ4e+FbHZwqKyNedb/jxKlAvtYPa23n+WQfGodtR4agJQw6
         mXqg==
X-Forwarded-Encrypted: i=1; AJvYcCWo6JPQn4BxAtiZIlHV6TGwARJXx8bgAnPuFU6mkRf9e9bUs7iTgvbSaCeCkT4Dkk9kGTaZVI8Ojo7ol9QDzrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEMxxaJeh/oglEIisXPeITGVlPUaZbZTcJs4kjDWu/m0ONfnHG
	+tQaPQn379O6vDMbLx2aV0pxogmH9cbcsEDGzbBjnXIvlJ/iNJXrfxpFquu2F80=
X-Gm-Gg: ASbGncs/uHzutE/XeL/Lt9XEFLvqYJvKuq18XutcMsoUNTJ2u1Q2MCwRutlIWVskdIC
	Q19M/zgLR6moVzFD5V/2OEn/mQzaN1nmT/vgqAyjIV6EoO6ctWORZ/GJM2O2pLRiaQh+n25VZ3y
	gHBIDP2sgK4XZGJrggtRuH5gfMXJB3VcZam9B+alDP0HBooCrQv4/sbN9BPWNE12qXCQ6YFDkcv
	epjtqUzCKJxi6FXzXTLmDJ4Y5XdK3q2uPny0Aw6QHM33a8N8EDyHULebIEl6KjjnBOLgbgGW6mB
	piLm
X-Google-Smtp-Source: AGHT+IGCURJWIVYousmDxQfZtWRFVgJilSrZTA63b4XTXZvjX1GtlsFKkKGE3cWs27mtEc5QXAwz2A==
X-Received: by 2002:a05:6602:7288:b0:82a:a4e7:5539 with SMTP id ca18e2360f4ac-84f672d8530mr532921139f.2.1737003506302;
        Wed, 15 Jan 2025 20:58:26 -0800 (PST)
Received: from [100.64.0.1] ([165.188.116.9])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84d61fca4f0sm425517139f.44.2025.01.15.20.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 20:58:25 -0800 (PST)
Message-ID: <8d03404e-c9eb-485e-9280-27a06937c347@sifive.com>
Date: Wed, 15 Jan 2025 22:58:23 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] RISC-V: hwprobe: Expose Zicbom extension and its
 block size
To: Yunhui Cui <cuiyunhui@bytedance.com>
References: <20250115024024.84365-1-cuiyunhui@bytedance.com>
 <20250115024024.84365-3-cuiyunhui@bytedance.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
Cc: ajones@ventanamicro.com, alexghiti@rivosinc.com, andybnac@gmail.com,
 aou@eecs.berkeley.edu, charlie@rivosinc.com, cleger@rivosinc.com,
 conor.dooley@microchip.com, conor@kernel.org, corbet@lwn.net,
 evan@rivosinc.com, jesse@rivosinc.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, shuah@kernel.org
In-Reply-To: <20250115024024.84365-3-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-01-14 8:40 PM, Yunhui Cui wrote:
> Expose Zicbom through hwprobe and also provide a key to extract its
> respective block size.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
>  arch/riscv/kernel/sys_hwprobe.c       | 6 ++++++
>  4 files changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>


