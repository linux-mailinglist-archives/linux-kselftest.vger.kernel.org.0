Return-Path: <linux-kselftest+bounces-40615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F08B4090A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBB74E7338
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C44324B27;
	Tue,  2 Sep 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="T2Y5ChM9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF404322DCB
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827374; cv=none; b=oncfr1yU1B6bM4ne5NuZSzJW/uy6ABUdCgZaaEnVTgvEthDoR2IOvw8VgxY3NNIion/Y9A4Cp3oiZ5XvYbtGVA6WWCVIKClYtHLteGTw5IOGzdN7uETTSkbWaKEKa2URecIAwJ+oXimTRbGtaEC4CzT1jASp9OFZDznIRogG+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827374; c=relaxed/simple;
	bh=pQfx5rbbo9VQV6yem/9gGiPAtj7wlmVzU3U4hgkJ1I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSavvD3w1JfCyOUrskehOzLQGXnY2spHxB8poXG96yd1Y3+92Z4Dy5BPWqnM9SWdeC7fIBfelJEij996Q6DnlrSI8aFDZdx6lN1TV1B9B8V+vESs91ClLOhNe7ZqHEg/yKU5BfzXZByAUOwdBjzQVmgRG0cLqCvSJXpZKC32TDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=T2Y5ChM9; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ea8b3a64c4so21126715ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1756827371; x=1757432171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9s+kfAE8HRXPT1H9Bh1Vhsm3UofgSwfxkPjIm95TJo=;
        b=T2Y5ChM9hTNIdeDM5yJ1one2K7VvP7XcE2iK+G198VkCs3N1rdlI0hxHDjZuRk5jnb
         xPSWnnSwceWN6cmrLHZUN1p6e3LcVSp7KAlCGY36zm8/rdZFutCg6Qi28oUmpYEAEaII
         qCqQegFYf+jXfijc2xtFEtXW1HnJMJJmeG90BWIrDBALZFOvfs70Djo9WzHmkMl3lm41
         6jAO61b1hO3WsDnJnYryszEgeYMi0pRDT6WM/h7xTYFPsJtfvkWSwfx1uY1IjC2uz8Bs
         4SVoxvt+B+7pAOPgOUhEyfritekaFAWs5mxJS032uonpPQ2AgFsN3cxUtdyvHNAtDTJw
         ygGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827371; x=1757432171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9s+kfAE8HRXPT1H9Bh1Vhsm3UofgSwfxkPjIm95TJo=;
        b=DRaHQSFbD/1Gg0OYhCaI9dn/Lwsnr721un9W/6/XjNHPmRPe6QI0SsyRXRCY1UPt5q
         yuymQcAUzLdm7qV4K6ss3UAXUGgIocgWKSAEr6xs0XT6e03GngYyjLG3Fs0pui4W/5IN
         KfPQqDq/hsr3UnguewIB0cwy0uVDJGWbAsE4UjhWgSZFoJHsKbYi5LsZBRnONYOx29vt
         HbY+ME6GzxQHcEAYxHfaKLEj3iyzlrgeq6xTcNIuIQ5zcYPR1xSMNGX7eH1ragE0vT4C
         9wPgENR5duLZziRt5Id7jLVR5KCTrkCTCPWUZN/MULcsZ/3VpX/LA3NEbqdGV0HpfzL2
         gF0w==
X-Forwarded-Encrypted: i=1; AJvYcCWUEy9FgqHlTMcpOsGc+hN3Ehs68FmkBd48KWdvpL7c5bRZx3Z8Ilj49WVoVuFN5sPeOiMubXi2yoNZSLk1rqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjp1ejb5AkhVCMtWPUqh8efQGM1MaEwtWyN/DchATuUC/79Uvw
	1xsTLlE+1C+veJ851PLk6hzCo+lCm0Ujb48RWuBDhIxwW6bzOml02chKIf4LztD7jBM=
X-Gm-Gg: ASbGncvSpShVLAk+bCK8xgHkLt6NdwDlwqSvDMzT2OBM5C5X8VEzxSBdhi2WiJYhI0l
	OF8nKA82laCmBuueBtFoEaaa/qjeY6kjuqV5mNYDVKN7NT/2SEtS4+3AG4kuJJY9eibpBlBg8Ms
	i5JydeYCfVMWvAkmIRiBJPIqX/xIS3bpYnUXUHfZfwAdyc/gEtForZi7KxgoNYyvjFOVUrlcVQo
	6uLxU7wo/H7EwBED7V53NE1tQ7o9QGIAHQSzN08tAwcvKiraiKCtacywVv4JqKhm7K97sSCQBAU
	bl2lvuZgublxDzPtc5tald7bK2gmX6xYO1f2kgb/3gRz+4YUpfUdh8DpQ7DVnN7xhaCC4BsCkfG
	k+qDmfM01/ARVZWZ4xZW3kEFP
X-Google-Smtp-Source: AGHT+IES7nRiJ9CHZ2JkifKal6ueldn9qBf26MOJ0udQNkIKmIhptPxDm7X55cZKJRjHHzBvZ9JRfA==
X-Received: by 2002:a05:6e02:2302:b0:3f0:62bf:f23 with SMTP id e9e14a558f8ab-3f401aee1b6mr224147135ab.15.1756827371527;
        Tue, 02 Sep 2025 08:36:11 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f35cd88sm3180471173.59.2025.09.02.08.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:36:10 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:36:10 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: dayss1224@gmail.com
Cc: pbonzini@redhat.com, shuah@kernel.org, anup@brainfault.org, 
	atish.patra@linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/3] KVM: riscv: selftests: Enable supported test cases
Message-ID: <20250902-9cc0d0dad59ba680062dbbf8@orel>
References: <cover.1756710918.git.dayss1224@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756710918.git.dayss1224@gmail.com>

On Mon, Sep 01, 2025 at 03:35:48PM +0800, dayss1224@gmail.com wrote:
> From: Dong Yang <dayss1224@gmail.com>
> 
> Add supported KVM test cases and fix the compilation dependencies.
> ---
> Changes in v3:
> - Reorder patches to fix build dependencies
> - Sort common supported test cases alphabetically
> - Move ucall_common.h include from common header to specific source files
> 
> Changes in v2:
> - Delete some repeat KVM test cases on riscv
> - Add missing headers to fix the build for new RISC-V KVM selftests
> 
> Dong Yang (1):
>   KVM: riscv: selftests: Add missing headers for new testcases
> 
> Quan Zhou (2):
>   KVM: riscv: selftests: Use the existing RISCV_FENCE macro in
>     `rseq-riscv.h`
>   KVM: riscv: selftests: Add common supported test cases
> 
>  tools/testing/selftests/kvm/Makefile.kvm                    | 6 ++++++
>  tools/testing/selftests/kvm/access_tracking_perf_test.c     | 1 +
>  tools/testing/selftests/kvm/include/riscv/processor.h       | 1 +
>  .../selftests/kvm/memslot_modification_stress_test.c        | 1 +
>  tools/testing/selftests/kvm/memslot_perf_test.c             | 1 +
>  tools/testing/selftests/rseq/rseq-riscv.h                   | 3 +--
>  6 files changed, 11 insertions(+), 2 deletions(-)
> 
> -- 
> 2.34.1

In the future please CC previous reviewers on the entire series
(particularly when they have reviewed the entire previous series).

For the series,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

