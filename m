Return-Path: <linux-kselftest+bounces-13030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E7A91EDEA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 06:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146CA1F231DE
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 04:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11092836A;
	Tue,  2 Jul 2024 04:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aEeuSrFr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89B81F
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jul 2024 04:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719894861; cv=none; b=cOOoT+EY2shK/jb/+9IhkQ6jAmEheWn5FIBft38tfDjwaJo0HU2AviPMMyqhiWJ5FJBsmoojhfa/FFdHvN4IYzdmqUnSMa80oI4xyRV+nj/tMliU2WOIrfy+1n1/tZNt5P5yXDye4GrEo6+hdBRIs0WNTxnCKD2Vq+xHp8ykdi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719894861; c=relaxed/simple;
	bh=q2Cc35SOsDHpJeJOWn7FTe19A5jZWBMPUxY/THw20DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2H7O8kQh8Buue/BI8MJ1/PcQ9CI2U+746l9ZMElj+dX7u2zcdxukH4rUV6exPuSTa6FtS8UjHszlatrWZal3aqyziOlS8vMAhjuBZ8cvxUlBo1HTi+PH6BP3EGvE/U6LtpkPVNbdkp4DP4JDCS6IeYRSE0CC+rZxtZBL4BUhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aEeuSrFr; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e03a0faee1eso47467276.1
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Jul 2024 21:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719894859; x=1720499659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h4yh23E/AmlByOcWJD4eWcZh7D8p3BbXHSztKcWq0cA=;
        b=aEeuSrFrQVtv2G4B7g86L1WmTDy6WmabvepSyX+zHaRVtwLQFrPqhcN/WHj5udzSm5
         zRJlwC1dPR2ILzEUphxHrXaSuQuvl6F9wYUWMNekG4FEXgKOL7ui94xIMykH+/pH8aze
         hp+tGnEJj6lXaIlN86HI6gZm3/5PU08yMWZoOcU5tZvgc1l88WwrTq8eZSEeReKA4GuQ
         oN3NpLk+iXoT0hqbn5oUyZ8FRyWkdOglo+9vRCXVBQFCNymIv7EmI9iZ5Atb2o01Vx0O
         5fqkuDRvzRR/v7dzkscDNy4uUkkmpj6cye0IseqwaX1hCWo41r9zx7NSlifd59UopjUf
         v0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719894859; x=1720499659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4yh23E/AmlByOcWJD4eWcZh7D8p3BbXHSztKcWq0cA=;
        b=IX7akvBIImO/QyU7yv9kLLEFnplhF13CEKQXTgbqTy1QIIutQaCDSI6Zq2ReiZ3Vgc
         qUM30VhoO56Zef+glOq1vhwJaaXHNUmijYyXtkB5GH9zTk1UDqIDjH/QINWHbq0qMgIC
         6uz6WL0DskmwZwTocilSf2FJr/bMcdxRI6qlSdVrMd1AH4apbMEEwgZMe+f9a0+29Zdo
         3ANsnWh2x9D8cVmJsuCOfmD0PRBlNFd3TOe8sSYthE973QchFACSZBEY3AgkO94Uug/v
         73wjgnANUoftMLY+oT2vWyzg/y3C35lw6P7qK0sOvrQdzLdYGmoq5BtCrc2mKjXIAQwv
         mDhw==
X-Forwarded-Encrypted: i=1; AJvYcCUSw+c5ZHwgkar3rTmayH0pMU6ujBKXc6nOn6494mqcenJHKsoHOESTEG7pR8zBucyiSfW3JFsl4njORH8KFHrqsgNd/L3zriNOj0Kf2iih
X-Gm-Message-State: AOJu0Yy5gEYpDpG+bcK6N4zXTCXQbVaGz87+A1+91KhoGL2BpBNQFL7t
	sF1v+3WCRAFsoRX+hP9Pz9y4Y+2uCQ0N7gIUdQ4azOo2OjUCg09qjOUZmUJVK+g=
X-Google-Smtp-Source: AGHT+IFr7sVN2iw1k2zfGO5K3dhcutxzXrXIQmhw11TwtYUrAFSIAsviplllqAK0LOhKsh6tA8qHVg==
X-Received: by 2002:a25:53c9:0:b0:dff:4862:b0a with SMTP id 3f1490d57ef6-e036ec357fcmr8474625276.46.1719894859404;
        Mon, 01 Jul 2024 21:34:19 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:a569:328b:99ad:ce17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6d3efeddsm5826997a12.88.2024.07.01.21.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 21:34:18 -0700 (PDT)
Date: Mon, 1 Jul 2024 21:34:16 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: zhouquan@iscas.ac.cn
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, oleg@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	andy.chiu@sifive.com, shuah@kernel.org
Subject: Re: [PATCH v1 1/2] riscv: Expose orig_a0 in the user_regs_struct
 structure
Message-ID: <ZoODSMYCRbNcZWaY@ghost>
References: <cover.1719408040.git.zhouquan@iscas.ac.cn>
 <a424caf3072d12ef6ba0c56c411789fb3282e844.1719408040.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a424caf3072d12ef6ba0c56c411789fb3282e844.1719408040.git.zhouquan@iscas.ac.cn>

On Thu, Jun 27, 2024 at 11:02:46AM +0800, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> Expose orig_a0 to userspace to ensure that users can modify
> the actual value of `a0` in the traced process through the
> ptrace(PTRACE_SETREGSET, ...) path.
> 
> The addition of orig_a0 also requires the following adjustments:
> 1) Adjust the position of orig_a0 in pt_regs to ensure correct copying.
> 2) MAX_REG_OFFSET should match the new bottom of pt_regs.
> 
> Suggested-by: Charlie Jenkins <charlie@rivosinc.com>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  arch/riscv/include/asm/ptrace.h      | 7 ++++---
>  arch/riscv/include/uapi/asm/ptrace.h | 2 ++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
> index b5b0adcc85c1..380cf54c1f3d 100644
> --- a/arch/riscv/include/asm/ptrace.h
> +++ b/arch/riscv/include/asm/ptrace.h
> @@ -12,6 +12,7 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +/* MAX_REG_OFFSET should match the bottom of pt_regs */
>  struct pt_regs {
>  	unsigned long epc;
>  	unsigned long ra;
> @@ -45,12 +46,12 @@ struct pt_regs {
>  	unsigned long t4;
>  	unsigned long t5;
>  	unsigned long t6;
> +	/* a0 value before the syscall */
> +	unsigned long orig_a0;
>  	/* Supervisor/Machine CSRs */
>  	unsigned long status;
>  	unsigned long badaddr;
>  	unsigned long cause;
> -	/* a0 value before the syscall */
> -	unsigned long orig_a0;
>  };
>  
>  #define PTRACE_SYSEMU			0x1f
> @@ -64,7 +65,7 @@ struct pt_regs {
>  
>  #define user_mode(regs) (((regs)->status & SR_PP) == 0)
>  
> -#define MAX_REG_OFFSET offsetof(struct pt_regs, orig_a0)
> +#define MAX_REG_OFFSET offsetof(struct pt_regs, cause)
>  
>  /* Helpers for working with the instruction pointer */
>  static inline unsigned long instruction_pointer(struct pt_regs *regs)
> diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
> index a38268b19c3d..3e37f80cb3e8 100644
> --- a/arch/riscv/include/uapi/asm/ptrace.h
> +++ b/arch/riscv/include/uapi/asm/ptrace.h
> @@ -54,6 +54,8 @@ struct user_regs_struct {
>  	unsigned long t4;
>  	unsigned long t5;
>  	unsigned long t6;
> +	/* a0 value before the syscall */
> +	unsigned long orig_a0;
>  };
>  
>  struct __riscv_f_ext_state {
> -- 
> 2.34.1
> 

Thank you!

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


