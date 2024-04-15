Return-Path: <linux-kselftest+bounces-7959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6641F8A513F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 15:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6DB5B23F4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 13:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FF974E10;
	Mon, 15 Apr 2024 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ly2DVh5d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB81745E1
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187204; cv=none; b=d+6mgwgg2ZpFGBoWLTxgwVt8fyqIt+ItAJ22lI7AqUHvYYoey05fIiW9S9N+1Nwc7p/tDxl/xi2pI/mQBj3UHeDvMZAL98XHgXd1ZpiS4KDrSGSpea1eYoYv5pBosrSL1aGc00Qvv9WdmdsMKfzlUjHS1/Oo+xCAGUsIVucV8UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187204; c=relaxed/simple;
	bh=xdTgOzFrIrINaykwQW5f5NzvyMD3au3ek0a7qZ3i9fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDBUZSrgDi1aW+0Jn7YDMw4if6zcD4PnkDD25NOGTT8CeFTxpqT5E+/HSsusledhtzHZmwH843i9+HDUylS4mbt5agHk2FMmbKGikCvoJYizD4Zwrb8C4t4pCbM+7oPN8DeDxanzA/c1STpIaAzyE10rBwsKNlxM3tJTMqDikDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ly2DVh5d; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso40557551fa.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713187201; x=1713792001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SXmg35GKlfduv7MXmhtmlNfK7GX2Rv8iwiDs44M8/A8=;
        b=ly2DVh5dlTjCL3gQnVXeKbGjAKC4t6dnPDYNPDY6vcU3SLeDyPJvnbZrrannOYIwsF
         PpMYWWww8TIpXMXtLSxb5Mx2qbyLX6dz10RXd4uwLBFYqcyeJLhPes61wyG2WCiyeoIY
         elimqGJMeCCNjSPMhvZ+IJaAJ39QZjyRd+B7YfSv6jOg1M+Xcvo9JJQJqHVRYnMHkOYy
         AssW8jxJJ9u1zz5adcHnqBqhaZClRUSuySbvQLUZj0OmvuqMQ9zA1VZyMiOqvQCz/ErL
         biqahfdnJiyd8WPKcCqC3Aq048cB2sYygKg452r/n5tIazsMzKRbT9EjtmsKmSNDGAfy
         2ePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187201; x=1713792001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXmg35GKlfduv7MXmhtmlNfK7GX2Rv8iwiDs44M8/A8=;
        b=lTs9Efe5V8oLcX7rxZUOFs0TFbtxw/ruRGE6WeLXdnOSHQ+ciMAdb/BbD6sgg3Hl88
         bLixHXla4HsiSYwJshOvS6UgIHpvehxOzREtur/aXTp4OPGEwkeaIZLQ0dlS4g9BEIbH
         RZ/vzX8GSFc3K3YpFgNOO+7PTkKnCO81PGq0QFAKD2+LA76J4tguatkM9of9akaweJlW
         wBKFRtk4dZCVZl6aI61iMhdnPgmN+AzQUFrdRflD49cK1DRTbFPHJDN91VtPNdeTDnT2
         l+AjefrPVLEHBtMuOy0HYCerAwR6vukfT7b7ijEjweOsHgFy+W/uFEyeG1/tHzEeHeq5
         49Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVgnGw37CI3MG2nWf4H+vW7pUCh7kpUAdWmNgRVtBYCY//5dKgmwULPyJNdPVGZNbt+RL5YIkvHBNSXnN2N7dG6n284g2/TDkxvyImZ2DCr
X-Gm-Message-State: AOJu0YxscLu86UgJqLiB/EwFdary704St4Qz1BaDrySLhnBaLDpHrhlT
	BVfPuolJqS+L2TFKfuVR5hnoyOBZWTEXL+1fqvSVisaVJWPwPWl6CGQNysLQlCs=
X-Google-Smtp-Source: AGHT+IHC4az2rFSCiUuGCh3xwdRVNxly/Qg8h6dhI2uDrhLenj+lI0/6ysFeUkGc4sRDSnzFxzxDsA==
X-Received: by 2002:a2e:9b1a:0:b0:2d8:b2e:7bf3 with SMTP id u26-20020a2e9b1a000000b002d80b2e7bf3mr5838228lji.0.1713187201312;
        Mon, 15 Apr 2024 06:20:01 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c191300b0041663c75ef1sm16363175wmq.32.2024.04.15.06.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:20:00 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:19:59 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Atish Patra <atishp@atishpatra.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, 
	x86@kernel.org
Subject: Re: [PATCH v6 13/24] RISC-V: KVM: Implement SBI PMU Snapshot feature
Message-ID: <20240415-74754b02ead9b89dcaef6d3a@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-14-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411000752.955910-14-atishp@rivosinc.com>

On Wed, Apr 10, 2024 at 05:07:41PM -0700, Atish Patra wrote:
> PMU Snapshot function allows to minimize the number of traps when the
> guest access configures/access the hpmcounters. If the snapshot feature
> is enabled, the hypervisor updates the shared memory with counter
> data and state of overflown counters. The guest can just read the
> shared memory instead of trap & emulate done by the hypervisor.
> 
> This patch doesn't implement the counter overflow yet.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_pmu.h |   7 ++
>  arch/riscv/kvm/vcpu_pmu.c             | 121 +++++++++++++++++++++++++-
>  arch/riscv/kvm/vcpu_sbi_pmu.c         |   3 +
>  3 files changed, 130 insertions(+), 1 deletion(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

