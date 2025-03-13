Return-Path: <linux-kselftest+bounces-28948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16363A5F55D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 14:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B32D37ACFE4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D730B267AF2;
	Thu, 13 Mar 2025 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="J1Lgso/9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309D26772F
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871174; cv=none; b=HUWRRVnz6HC1wZGeV55rW8rCHSNcgLqOk9dzTgRH/mXEGWLDevGriFMaSACRki6VgY/Xqmm7OVvK7XT/oo+WXLLQDTlYxrxZP+o/C7KqEQgDTBBflynf+xmcJxadBtEPbqzCyFC7IOWLg4/iqPOXG2NL5vxmMajV5Brqw57DPJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871174; c=relaxed/simple;
	bh=fIDudF5HjifkvRrbLC104K9OM6Yle4HKyCDfYCYSVCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/K6bLe5YptMeA/LMFMyDvRWMSncX7KUz/xhyaqyCNDqG0UMQSMyY3f5I4qXsDyfOv/G4qIWHCHj05gtkulnjwbrEQ4MaP45EQAa9CSxe8LIdRyG/QpTC5dy59ok2rgha37a39mdCVgUU0IFa2V2RhzIbVogVeQRQ3z5vQUYYtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=J1Lgso/9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfe574976so5683875e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 06:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741871171; x=1742475971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JykEzm+QtlDREfjY9aCf97M8p4eU9HkNtWKu9+Cs/cE=;
        b=J1Lgso/9SeTyTtYo1LBuVXTKidpIUIN8k2LJVz4dd7kNqEKHmLkuEsjRQodm/b04MT
         k0fy78APUjZiKJAjryvIRG5T7JrdIsQNZyDHofV8G46A+sJiZWI/R5OJFTqyt1hK4Us3
         C5Xfbrjn5Oa7GpsYqoZ7H5CjJOI0YLvuB4fkUW2fwFfdX0aAA9GIKWGM4j77qK6Cq0Bt
         8V/lSvq0uJcV8HxQdJVU6yS/BLt/4RO9x4Ff/vpBv4IiKv3aFuUEtjoOo+eLEozk9ZV5
         wSgttPDCYGBF11hmH7/7BT1QIzKOBDfiAdbbpsRbPztA6VxLa2WbRj7nKqFbLXR9MaQ2
         fB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741871171; x=1742475971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JykEzm+QtlDREfjY9aCf97M8p4eU9HkNtWKu9+Cs/cE=;
        b=b/wEjXsazhRMjEv6CkDKqARBivso9HiHpTGqm73Ln74cTmfA/C2ZBVtg5rixqE6Dnx
         wujnEzs+nkqcinGKkja7oG3jAdbEuGQqGtovjhOT7u7RDrQr34MapM6jsRxu6F6KhRuH
         a802jn5Tvb2GDcuTbjkCHszZYLsAKJTtkkfXsFTbMqQs0elTLLjI3Jvp8DtL83OSBGTy
         9v5JbWh59tWh1dWhb6QUu6yhID22uWNn6iLxU2ehRCv0ppuM6gdo/BAUL5e1PgM7wEQJ
         Gcfc9i11ROZ3DIyd9N7ueOiS9qFetsUjfIm9Dj7/nYFhltZ57qwzWtWvnlzoHskpupMH
         wBPg==
X-Forwarded-Encrypted: i=1; AJvYcCVdBzcUMXb7NxQjjJyOpqXdeLt5NUvURqAnGQ3gWgM7R99Vj9gdASYdHvyrLVKsqhi4MNqNg2B2KVEA9DC5PB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiB3Drh/BUHNGV0lmgO2kCa1CIxwxR+I9NIiWCJTZK3NuawpC+
	o2NJwIUhX3OP5nsMFxb97+saShHxZJboHYr4GCWS3scak9tuQaOpq9gKfHMzAno=
X-Gm-Gg: ASbGncu6OGNnhuSIL0R60AJuYm7qKfVgFVp0o+aRnzc6VEXFBb8fBRoU1wz+qZpOpFJ
	1FICfbRFndzApHNXGufzAUlkWUFTJnZhQeAhnogxxkm3Iv/Vo3TtKyhBnSHRUW07mVxSpBpI+Sr
	Cy1c6wiVIPqdVcW/1LsUf4bmLl3eNh/AH3kMZq4EGoUUfVpDOmpbpHn+XlG7QUpX6QAZaXYmdFq
	1vCPWbLZOJ76mtlxiYXqsZboTv3oVgebohB7U/G0HUBaI5kllew410ocsERUe2y3LgH0hqoh1q9
	kyLKQjG/GMvUMm2Fb9B0oYCKW/e+MvMb
X-Google-Smtp-Source: AGHT+IHbHWsyXLkkKJFKW9xqRqjCmH9M6Hc04X13GIMAwv1uQuG0cXmClbOatlbE9Co87YMRA/AdwA==
X-Received: by 2002:a05:600c:3b13:b0:43c:e9f7:d6a3 with SMTP id 5b1f17b1804b1-43d01be652fmr113577215e9.13.1741871171136;
        Thu, 13 Mar 2025 06:06:11 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df413esm2048987f8f.20.2025.03.13.06.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:06:10 -0700 (PDT)
Date: Thu, 13 Mar 2025 14:06:09 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v3 06/17] riscv: misaligned: use correct CONFIG_ ifdef
 for misaligned_access_speed
Message-ID: <20250313-a437330d8e1c638a9aa61e0a@orel>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-7-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310151229.2365992-7-cleger@rivosinc.com>

On Mon, Mar 10, 2025 at 04:12:13PM +0100, Clément Léger wrote:
> misaligned_access_speed is defined under CONFIG_RISCV_SCALAR_MISALIGNED
> but was used under CONFIG_RISCV_PROBE_UNALIGNED_ACCESS. Fix that by
> using the correct config option.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/kernel/traps_misaligned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index ffac424faa88..7fe25adf2539 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -362,7 +362,7 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
>  
>  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>  
> -#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> +#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
>  	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
>  #endif

Sure, but CONFIG_RISCV_PROBE_UNALIGNED_ACCESS selects
CONFIG_RISCV_SCALAR_MISALIGNED, so this isn't fixing anything. Changing it
does make sense though since this line in handle_scalar_misaligned_load()
"belongs" to check_unaligned_access_emulated() which is also under
CONFIG_RISCV_SCALAR_MISALIGNED. Anyway, all this unaligned configs need a
major cleanup.


Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

>  
> -- 
> 2.47.2
> 
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

