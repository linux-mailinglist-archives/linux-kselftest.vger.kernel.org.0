Return-Path: <linux-kselftest+bounces-7188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2E58986B6
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 14:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21AD1F271B1
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1625A84FC8;
	Thu,  4 Apr 2024 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="H7hHb2Pq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD1083CDE
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232123; cv=none; b=d7WqLvu/sx5Zaj1cEFtFgXt/OI9evZjhG4h7yGWF6nq25eAbdvR/lllUEJGuEIKkIqUzFg+pqsNJqCq33GhIn+tU4QOi7mUR6UhtpujuVbWDBOsUcjBuWSs93nl1BjSgKSPOl4rMsq9yWFFMT2f80uT+vp9gJ60S1WXgjcg29Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232123; c=relaxed/simple;
	bh=W9ko0RfNE+S1DiS7+KgLkrYBPHmkmYztpcltRdxaN5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6BO4GC9trS/dTwxjPIs07DYf2PhnwC+nHsAHb5I0ElQP6AyVx3kUuEX8rL7sB6IdoAruBoGF9soSzU3BzxkNv0J8ars92s/+JfKDue6dF0FGPJv2hK8z8UiT4qYeaFv5WwDcBe9yKqnDNTmd6x2Vd4LF0GYQ+IoU59uk7ZdpvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=H7hHb2Pq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4a393b699fso146265866b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 05:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712232120; x=1712836920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i6sgTwxk9jhbJgHBwC7uiEgEw3bNU/OxwYHoyLaglJk=;
        b=H7hHb2PqfDTZ0NdF7Lkzz3dEXUQZSTEF2o/9++LqNBz1yUbtOkix5A4WdbHQYmp5JV
         vIrUWS3gclXDWHvip4umv8wY6JnirVc8g7xVotMJ4oMA618NhFHw/resoT99254DmdoJ
         otHIbUSq/r+LcS0B8WA6WrghL1gajvik9TiaSd/kJp+Be7+cVBxsW3hvAvKG/xi/C9bm
         KXq09/+uUGhAabkvzmdepeoT3Rwz2p82HEoINFJ0wgqOSUyGzCQofFLPKj95+12+uC/c
         SXCKnVRifUw1DXGxENAQThnkB5kOtp7IIRp+4MOj7OszVc8rXFac3UNRe1V0wGenhVMG
         4ZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712232120; x=1712836920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6sgTwxk9jhbJgHBwC7uiEgEw3bNU/OxwYHoyLaglJk=;
        b=JncHB3EBj/iTBuvk5otbSLe/GnW7xGzMo/x8eBHvNYT7scIxksUwwJWiheYDi5qoCb
         ck59pVW+3VTooSu78qUa3cOrYBGD/0xQmbHJaMu1R9jiWEnOKmFqbChGpgEPoaSZHgRx
         MHni8/XHMBJXEEdVkg4JHNApKYWHm1CcVjDlhPWjLQ6Nl3zJwxhg3s56FYSGYcwX9G5r
         l8Y8kTNfSHCfdQnVhmUTqlmzi7DEBIy0bnUedXAAE4qk0ZU+Bcs1Q8iBfIbJ30K3RINS
         fjrYwbVEKpfbd2CLsaWkIbYc2pDQ173BI9seL6Bvq0amL5hafJcZm/rEJ3Yo0meEwFLV
         xSog==
X-Forwarded-Encrypted: i=1; AJvYcCV+iLFWKmWZkap758rK7+kwx1O9YVBb5OabK9NWIce6IxF6uiqlScDbNGow8+zwBr8qdrr+CyVR2YF3nwzodzMx3E2GodNYaXM1R/Q3w76E
X-Gm-Message-State: AOJu0YzmFhHzjq+QaCbm9ihOrtCfMAjzZdXCLCwNfH6r+6O9R70eBUxR
	4PS//jD8F1VmAb/G0HnOPTCWLvN9VMFYwIQmMk70fkOYLzd8YJaOJijEcXERfU4=
X-Google-Smtp-Source: AGHT+IFp9TuLXZRqsWbkDSS4HE72CGMNStdZzxnFkRk5hlzliQxjfRqdZTW+nZQ93k29lkL/Bq+HhA==
X-Received: by 2002:a17:906:f912:b0:a4e:13ee:5dec with SMTP id lc18-20020a170906f91200b00a4e13ee5decmr4834184ejb.17.1712232119747;
        Thu, 04 Apr 2024 05:01:59 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id la6-20020a170907780600b00a4e2db8ffdcsm8202481ejc.111.2024.04.04.05.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:01:59 -0700 (PDT)
Date: Thu, 4 Apr 2024 14:01:58 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
	Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 06/22] drivers/perf: riscv: Implement SBI PMU snapshot
 function
Message-ID: <20240404-bbfb02e3aec944f9e11745ae@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-7-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-7-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:35AM -0700, Atish Patra wrote:
...
> +static int pmu_sbi_snapshot_disable(void)
> +{
> +	struct sbiret ret;
> +
> +	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM, -1,
> +			-1, 0, 0, 0, 0);

The "Rename the SBI_STA_SHMEM_DISABLE" patch should come before this
patch so SBI_SHMEM_DISABLE can be used instead of the -1's here.

Thanks,
drew

