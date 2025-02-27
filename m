Return-Path: <linux-kselftest+bounces-27725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8628CA47830
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 09:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 454BD7A20A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 08:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A0F225779;
	Thu, 27 Feb 2025 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CKE1uBGF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF717A305
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646179; cv=none; b=aufCEMyoz4bPR6s2I05t6f4S1gReDC2PfQEwtmv2cX69/BiQMcOlyu2HaBbLOC01jnJSyUHLzd08xk9D/OExUNNd2l0zHjgKbxJYtBJhr8VZbqWjaU7rxH9a+QIGjYI2I4KSNdiyVMtC5mPfQwc3bv48CK5mtCGemUaVfyy/L18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646179; c=relaxed/simple;
	bh=BglBE0o1Xf1pxXgJXs2O4w8c/kffMCOkC4hTg3yAXOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ05Eoas0TzEP0p0RtaoA7Yxw8FzphHb9dzy+js5G1vz1YDYNTCqfjx5yXtt4jZBBR1gr7A/bcvR2mFDTta+uW8QBwXQJtf2KFXPU4ii66YRdSUJkz+kI+TSMcu4xD/xX1+M/6JeF9MHxVswFchpksd0twFSOIsIifLzdyxqe/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CKE1uBGF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43996e95114so4227655e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 00:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740646176; x=1741250976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xwt/QS7TwZTYg2MTdoUft0EF5h6WRYVihzhqZrEMa0=;
        b=CKE1uBGFVgI2XAE+HsCFb6ur/ePlLjy+VhXPbRiJ5Jx/PaN9/Jwh4/uswsaCZ7i8r6
         HjlAuMzk+J+de6y/KJO8k492R/4GoApP4EdCDXpLSapMRD9hpesHKkXZF4CnBDQlkszh
         nf8pIy7PhJzkyYVPxj+QVte7QrKkh/YDW7Mtp7JKRE3zP9yA5rA9X4eqpX9AEZlCXNty
         nv+EsCCiDJ4i81//1MSK6GxRk2zPWO3nbTXNPQbFiHbwXzJPIi4JXU1AUqAFs1wQCS6F
         dP0t1pBilGLIjNZYoqKm33iMHXOKJQgcAiiP9pkrw5w9pdhpxU+qStCNGfLrNDPZHkcm
         a4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740646176; x=1741250976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xwt/QS7TwZTYg2MTdoUft0EF5h6WRYVihzhqZrEMa0=;
        b=CSxp898BLfUghn7rGCjPZVi02+7seW1Qm7Fa1Pjqb5EP8dJ5AaBmVegm/JIl/M43ky
         bsyZ1w/msJ6nLP/McL+ykT+Ffc1qSbzXOb/Qb9ueKtf2Zkrbf5q78XTXfoaDV/ociEgi
         PYYmNmdSaJk8DeQd4nWlttFnThfpfon2Hty1KcL44cMEVXuHmbYe7+5GdoiQtSN2wWdK
         Y8JlBg0uF3EqgOYfSxJiwB/UMNF60WHJqrLkcdSyz9J09V64TvHO9INEyiX643Ung3Jy
         4lYQT2FQk/0RLND+jGsUpM0JdWXcijUouE3GxC+4ZEqbWzsB9YgP5yEk0jOxNcubEFeO
         RZCA==
X-Forwarded-Encrypted: i=1; AJvYcCUbgizhVZQZaQvqI339ZOesqeBr9pt7jJ9W256HEWy9xWzm1A1HrrvjGr9W3S8+pKtMnIUSsvgnpyb2DdUS0DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVchn/hi6wWf0n2tXErlZ74b+mQBfuXr2HMR6ldVBP1t/M+rRM
	9A9MELBNjiymR8LkTqW7kpvnGYr/qe9hI124c+fLKFU9dWZiBGc4UBturlHZ87w=
X-Gm-Gg: ASbGncvT4gWp3aiSxoRAS7M2IbyJhogYLaCd5WclBwPzJVh8njAurchRlb3CBBS3YS4
	9AxGzBZsXom326hE/9NNYhA+B+zp53S2U12YMHjSQFkX6E6Ril/I2/QW5hpHqz1+DOGGio7hThe
	YXh3TdMGZfRpKo3okDaI+/eyaJq7HUDxc1AzYat3e2CsXwjfIWKz2N+p63bJj2i/3k5pHVUrjPA
	58nSzr6MjYVA2I1pAb3JTK/kPnNewjrJKKouVWQO/GjUTEIVYAAcf/7HNImrbGd5jWs8lKInb4c
	FE89NZKvsDFoxQ==
X-Google-Smtp-Source: AGHT+IGsBt36A+nA64K8jmDgdrsH+3epzXLzR2VIcO1N8jO+7h2K8GwaLjrguW+gS8ljkw0FbuPM+w==
X-Received: by 2002:a05:600c:4f47:b0:439:8bb3:cf8e with SMTP id 5b1f17b1804b1-439aebc369dmr183762555e9.20.1740646176499;
        Thu, 27 Feb 2025 00:49:36 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::8cf0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7c43sm1308781f8f.49.2025.02.27.00.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:49:36 -0800 (PST)
Date: Thu, 27 Feb 2025 09:49:35 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/4] RISC-V: KVM: Disable the kernel perf counter during
 configure
Message-ID: <20250227-d64f688ee1df2811528ec2b9@orel>
References: <20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com>
 <20250226-kvm_pmu_improve-v1-1-74c058c2bf6d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-kvm_pmu_improve-v1-1-74c058c2bf6d@rivosinc.com>

On Wed, Feb 26, 2025 at 12:25:03PM -0800, Atish Patra wrote:
> The perf event should be marked disabled during the creation as
> it is not ready to be scheduled until there is SBI PMU start call
> or config matching is called with auto start. Otherwise, event add/start
> gets called during perf_event_create_kernel_counter function.
> It will be enabled and scheduled to run via perf_event_enable during
> either the above mentioned scenario.
> 
> Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/kvm/vcpu_pmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 2707a51b082c..78ac3216a54d 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -666,6 +666,7 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
>  		.type = etype,
>  		.size = sizeof(struct perf_event_attr),
>  		.pinned = true,
> +		.disabled = true,
>  		/*
>  		 * It should never reach here if the platform doesn't support the sscofpmf
>  		 * extension as mode filtering won't work without it.
> 
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

