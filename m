Return-Path: <linux-kselftest+bounces-12290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEB290FABF
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 03:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51392830BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 01:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DB0C8FB;
	Thu, 20 Jun 2024 01:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Vii7E5rg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29412E4A
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 01:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718845515; cv=none; b=lQXgH+JYgXurIdz8/PJPHf9AHvV38IEDxTZsNlLxeQZWRNKrYarDSWDX3vW+RDptC9IRdpRDPWSpmoL/rQVi/nGOjZnqRtB/Z0yxFa32KQrTCeUy4/iKXkFY/34cuQMHUVZI5dcmQ9TC23+/HkmHHZu+VX3V66k092PVB7xpDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718845515; c=relaxed/simple;
	bh=lp+GG3GoaTI9n94FGwNm9Zmf660rX/a/Rdm97RuaZXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGLWMX8hc2HQ6Zi/xuAebDKOpx+SeGy/V3KP/JJ2QDpX4SW8YxwW9SpoK7xyfIXdKhrh9pstcweKTi3LV5a96FPaOzW4F1RfjC1xdjBLNLWnAk5qhq4OtCMOFaSMYC2HWcwiJsIjL8m+OwvCsefACXFAg0EdWPsy7zZTJelGgnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Vii7E5rg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70631cd9e50so344694b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 18:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718845511; x=1719450311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lTj093P79K2ULCRNhl2VLvyYHssujM99KgD8c+1HoEo=;
        b=Vii7E5rgMZAkHFbVQFCh+xlNQiMKyG1e1NbUjR/9bD5yOGoIDLbPdiZkYdLFoMYIwe
         yItEQxD22mdYNRh2DeAGEhrApFXt1v9GlzlpJtg/NKOvV2v8RSm4LYYABMQi5tMmcLbx
         8tHiew/JI+gYv5s4YyRR2R8r0UWsLE8tJ1Dzl2i0YKVFHaCiB+Cf0L2bk+S6Hm3KxZma
         gl5xgLyqLQ9gv3/zzTaSpKo7YhEn8pBpbeHZ/bvuAR8fJV5dicL/491LiBOkP/ME8ycC
         i+O1IGj394L+GMTNAr1kytfePtBdtRLESvGat9WI6Iuymawd4EyR+PqkqfW0L4tZiIbu
         Htjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718845511; x=1719450311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTj093P79K2ULCRNhl2VLvyYHssujM99KgD8c+1HoEo=;
        b=hY5sV7EfybsiQXUGchTdptK8h53X65d9TJRxX/L6iOsTetN3aCItUztLOng/t8Ltih
         e1sCxFM9URMcw7vKSNcNGRFCWMyHGsBKPTotg+jXoMId4rnJB+NdywyCX5MsQzMHBzIW
         0Yp0bnEe0GsLClu4ulp+VQb4lJD6RUPQVyEzvKxZLAx1UOyXlIEv5u2/1ItMqpa/gLUr
         zfm/9qMi2xJVIXabyNTtSemnvxYUPDkQh3HD5Wm2Z7R3R39jCjCrqZq0rbrgpsRWN4fs
         wJhhwDvvLX5KRLxVFpnQ4Li+O0ifJWPQrIMoIBrUakvf/DLaMOhdGOm0F0w58mQeyu6Q
         ogNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdC5ggdnnweUxWTh74RMKbjn0v02PCTSo1DHNzyUG2il6ecCH9J4zfBdYWU+cVDssRhGoPnvotr1MGXYy63ZS0kcYP0Q22AnPEuTtJH4C1
X-Gm-Message-State: AOJu0Ywv0waM4dw0AQQbG4jPk0s2qYy89vibzRLMKcynj9J2cSIk4byJ
	TSA6p1HO5S1IY2iaTXQ7a8/beF2nPhLwEZ7b4wGUqx56PNJ7YG57LgZPaLSlAlU=
X-Google-Smtp-Source: AGHT+IFHG2YtBQ7dbN3z7grTnecoiBOyImNaiLDLLK/3MPitmfNNntYDhXLJZlDFsG7HRSOmDZO/YA==
X-Received: by 2002:a05:6a20:3c8c:b0:1b5:d00e:98d7 with SMTP id adf61e73a8af0-1bcbb5a8acdmr5418879637.24.1718845511409;
        Wed, 19 Jun 2024 18:05:11 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e5ba93sm124827385ad.3.2024.06.19.18.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 18:05:10 -0700 (PDT)
Date: Wed, 19 Jun 2024 18:05:08 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: zhouquan@iscas.ac.cn
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, oleg@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	andy.chiu@sifive.com, shuah@kernel.org
Subject: Re: [RFC PATCH 1/2] riscv: Expose orig_a0 in the user_regs_struct
 structure
Message-ID: <ZnOARMA1I0yRoNh8@ghost>
References: <cover.1718693532.git.zhouquan@iscas.ac.cn>
 <d4c7da80b72375c75836303bc744e4db9eeec218.1718693532.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4c7da80b72375c75836303bc744e4db9eeec218.1718693532.git.zhouquan@iscas.ac.cn>

On Wed, Jun 19, 2024 at 10:01:27AM +0800, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> Expose orig_a0 to userspace to ensure that users can modify
> the actual value of `a0` in the traced process through the
> ptrace(PTRACE_SETREGSET, ...) path. Since user_regs_struct is
> a subset of pt_regs, we also need to adjust the position of
> the orig_a0 field in pt_regs to achieve the correct copy.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  arch/riscv/include/asm/ptrace.h      | 4 ++--
>  arch/riscv/include/uapi/asm/ptrace.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
> index b5b0adcc85c1..37f48d40ae46 100644
> --- a/arch/riscv/include/asm/ptrace.h
> +++ b/arch/riscv/include/asm/ptrace.h
> @@ -45,12 +45,12 @@ struct pt_regs {
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

This is a good addition!

Since orig_a0 is no longer at the bottom of pt_regs, MAX_REG_OFFSET is
now incorrect.

Can you adjust the value of:

#define MAX_REG_OFFSET offsetof(struct pt_regs, orig_a0)

in arch/riscv/include/asm/ptrace.h to be:

#define MAX_REG_OFFSET offsetof(struct pt_regs, cause)

This is something that is very easy to miss. I think it would be
valuable to leave a comment at the top of struct pt_regs pointing out
that MAX_REG_OFFSET needs to be adjusted if struct pt_regs changes.

- Charlie



