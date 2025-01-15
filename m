Return-Path: <linux-kselftest+bounces-24556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C526A11D3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 10:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37AC13A3AE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E648C23F265;
	Wed, 15 Jan 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="K6kkjoQ+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4A820B81B
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932639; cv=none; b=rnhKVH8KB89w2TOfeYU6qsOjemwlQ/L1YU56E2WZV6x+wEKrvIOGe77mxzweMpC7z+W6VB0z0Yz2OYbWj7fzbLA/PEHgEQYlWRhQJsmU5/WKZ9pPVhn2wnfp2GBiSASABCeniMpiH4sMcjk8l/GyZgPzZjjgd6C5YdhRn8ItEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932639; c=relaxed/simple;
	bh=GOGQNtJtB4irbMbSiJEjSkZXN0utpLCZZos/RwC6DhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLyRcIfHIMz5r/pGa1iadfnsJkI7tIMg/xfOOw2z5ANpRa06SS98kxBSeYicnN+WphcvulfHg9MLLA6z0+8txRo5QIxeIqQQV6+IdNo1+TqUxaH08PX4WcJjMaIH4a2h60q+caHe/TI6wyz3yFh9SZLVLkRw1Yv+toKqZu1bBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=K6kkjoQ+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43635796b48so3648265e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 01:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1736932636; x=1737537436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPR0vSrKJLMo0r7/wQPbLykYZGu5on6q/CBisXInbBg=;
        b=K6kkjoQ+iGsYsC/DDehG8vOPCcuCm6ZOYJXlt3mubArtloeLEffQcFr2QksUPVVM9D
         tKtO/L2uiAzBEeMwKbiYvMd9cRbf8neE9QqtQWBLUe40nnbv3svi5OKU3Sbbf2zZTijp
         aK1jPKHwHDEM+pQNlrosHkxYWKUz8TEh9Ii8IukXNxdDCMYtqITdGQZYr+g3GXx+b0TP
         qyHfT0EUsX0jivTqKkhQUD26lw0P76GBA1usxTkgeZb6MbUzgMMeMicfEqgjBKAlHZnx
         tb5N4MbR2L1E3t7krE5ODRjoRkcp9NhAN9M89Cm1jvMq8cstecJhgHQMJe0YnfBQIxpv
         JP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736932636; x=1737537436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPR0vSrKJLMo0r7/wQPbLykYZGu5on6q/CBisXInbBg=;
        b=XEpZ6H9jC4ipcDPEtTDvgfxhegnnpPdi+7SsltlOliY28E56gm62f0RwrovXEQmKd7
         r+/1QQxqoY01nMgqDjb/yrr1uB9sHEBJOrbXGbMVdVntVEuDUCv5LgXw3PN5SvFdmobp
         LbT9x3vMA7Lq1M2B2EF0zENCtjB80JrVz0zdnjIYrYPmA/A+1z+GDUKQkWfzylVBH+PI
         Rn1pn39HIdYzQXupFzQDXWwSdWElQLvkbhatZhNBG6kmhZEEBq8zAE6DBZBDG+gKu61C
         BIF3seEIDC4bUO79jq3NE9qiOAhBG+txDX1QQ/kPsSMFfcH7X2qriMPmjkkQiAG7o0DQ
         ZFLw==
X-Forwarded-Encrypted: i=1; AJvYcCWcDLjj5vz3Ya1xzEjLH43fgdtd6ANDXjR9zfom69DSZrXI2Y3x89WRq11cC266EIzc753OQeh4wSNgY2RH1a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwigqyLIIRH0Vw0ofDnb/qyY8gbnGz3FBwTTYB/vNpbXjnjCmKh
	3lZKWNO6dHioMZFXljogGwC1h9flU+HL1nj59HGMB+CJJVxLyY6cG0wK1HMNFU4=
X-Gm-Gg: ASbGncuC7RGYkfyD6+ljsj9hdUL3zQ1lDdFAnGhzyHAO9o8tahq26dO4bQugZIr+ACj
	2q18gsHjTImWg435Xob6/WcXSP/eBMA8m4s3x+7eqEZuWF4SP6nT8CcCkQvedzwc6metzoShbJM
	7T8QHO0/HRAjpM2cY6T0ZwqrlvgB01D2RypkXM1Nop8y35EwbiNgKhoKP9sYXcQbPyAYDDrYKFR
	ot8edTTtU+HKjMDKSNXGlwM+7y1YlPa5jyJ8I9WG5z5wcFMYmUvgLuh3TO2mELZEcKNsDdaZXAf
	MfMUIqlbQsqcVyG50U8iBC/zBwrVfKHEReDfdlWz1A==
X-Google-Smtp-Source: AGHT+IEKwUbajcfYL3oDiXKeywStAiA7ujSjd3p63sWc1z3chviVk4GQ+jyIXySBHFmI84rSHpJJ0Q==
X-Received: by 2002:a05:600c:c06:b0:434:fe3c:c662 with SMTP id 5b1f17b1804b1-437c6b26e74mr15223725e9.12.1736932635833;
        Wed, 15 Jan 2025 01:17:15 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74ad59fsm16180155e9.16.2025.01.15.01.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:17:15 -0800 (PST)
Date: Wed, 15 Jan 2025 10:17:14 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: alexghiti@rivosinc.com, andybnac@gmail.com, aou@eecs.berkeley.edu, 
	charlie@rivosinc.com, cleger@rivosinc.com, conor.dooley@microchip.com, 
	conor@kernel.org, corbet@lwn.net, evan@rivosinc.com, jesse@rivosinc.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	samuel.holland@sifive.com, shuah@kernel.org
Subject: Re: [PATCH v5 2/3] RISC-V: hwprobe: Expose Zicbom extension and its
 block size
Message-ID: <20250115-6a3da5301a44634ae704491f@orel>
References: <20250115024024.84365-1-cuiyunhui@bytedance.com>
 <20250115024024.84365-3-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115024024.84365-3-cuiyunhui@bytedance.com>

On Wed, Jan 15, 2025 at 10:40:23AM +0800, Yunhui Cui wrote:
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
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

