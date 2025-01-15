Return-Path: <linux-kselftest+bounces-24604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E08A12E5F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 23:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEF618878F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 22:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015551DC9A7;
	Wed, 15 Jan 2025 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Faloxm+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085619CC2A
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980986; cv=none; b=LtpHmRTWbdBDMvUrOk8XkYZL5zrlJf5eXjIKoz5ncJ+DFcwsLU0AgDvIofeeK5tFPa+kEFDmUKIHoiGzOTiV7bTT5o1J3V4GyQSwXxscXTQQaht9fQEpPn0Z2ACQbNRp5pqB07LOlPi7Vi9eTrKFPduaa21GsJ5Pa8PJq2oqPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980986; c=relaxed/simple;
	bh=yL6U+qd9McH0WeBiO4msfSFQjHRbrZ8Ebmmtycj45mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEzFK1Mjn3zvbasi2rphOiigEwZT7iJDUTe4isVXRAZoABSqLDNacGIQMEX0gb+nSlqD9ibpjtgxfuKiqQzqFnkmy3ChWyiRRWsIU8vjyi85La/vJqlcJbS90faUrGjnkIv1C/sQT2au9VbR5l1GJ2XQ88cwQhPQCnyPNVQOLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Faloxm+z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216281bc30fso5840075ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 14:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736980984; x=1737585784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1YubPgC/8eI2lbaVxtAtUgVaIXVapt21tVigfpGQfQ=;
        b=Faloxm+zhHaMwNZOyI+Nxi5I53I/aWoXcjWGhCbNBJzwaxCmQLwU1hUdgAiWzRz40t
         9A8fVaabbbIpUzxInDzVUpDQ0tL5HdrypeqTSHeUL/tbzEU2aWZmy7012h9NiIH4BRRm
         rc8rvj9xJwpx2SedyWhl0VCbTy12CnW8mocP/W27DqTzgYXFE4Pz7KUQ/tZWpaTEjv4n
         xNdCa3dBpis7m6P54uweNfDwicw7wiTGACkd6BoUH9GIolRMnSLaa2VktKGnqE5J0+Po
         uMT0IMlqW0LiJKgJRuXutU5jEancL8WToRy1Z0br9WfqVOBMyEyJmcEaAW+67bD3U+hB
         E9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736980984; x=1737585784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1YubPgC/8eI2lbaVxtAtUgVaIXVapt21tVigfpGQfQ=;
        b=ctexJpWycD5pB0XDazlISC53kHO/Cj873qYhsx3EFgNWtIaOzry3qeq20Z577u8Dts
         sI8Pm/bwaxVPJK3R5Q3+zvo1ZWRRPJZHUQ91Bah2JrhguzytdkMAbIkzRSN00AI+bwLt
         8Wgp9oK4SaJ9ZCfpeCAgbLTVY0vLa8dVGBIQG4qGs5KzeSFtSpECKRrbRt9aU4TKC+mz
         SEJFpVeidVuYvBAUJvaREsYgZfUMZfujtnPw3k6uwQll2R/BUGppUt1vRxc/DFd9wUYZ
         qvMwAFGqwWkEz7rL5+NGPKSI3QNySPg3twtd+WNS0LD1nnpW14LstSPaSVbouK7N9grZ
         kjlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKaHHr76OLV2YdvL3idwkWDJYMWleyBKvWPbqpJ9NZW3lU0dptmcf7jKcgHTq8lHPZhduq8RUpauRGTH6nOag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKiKTjXUW9S6nsq8VhyYAl/cqXerJ770KJxkqaFRfI79zS0PZ6
	CO+hp4KF3W32F9LuNRhWlcG1zSxrPhrFx7R8SSE6CezYwYZ/oZBu6R07yQMjcJg=
X-Gm-Gg: ASbGncvyIQrf3dc/Z/uxkhVM56i1y+RRaRFhjhRVL20RndEx0LffQ34ye1gDOlWQWXs
	dW0X+2cRvipHa0BL6dwM4IMs5L20SsVxlR7aQJd+vLL7J52Ek6bwh41h6tT0peKDsGUjr4jpyu5
	kTUGgRdazCtgRhWzwCf4DqTMhgJ+/bGdwV1FyXSfggowTO9cdKhQjl2+90okA0/WHloPnOpqmrh
	9b5kTLXu5dq/BX5Dcb3T0z07VKoJ/Nwbm2VeAmN4qcP7pc=
X-Google-Smtp-Source: AGHT+IHvvdjAhB26TfABelCo2yezRGgIVCLHqbk75eU3TNKSL+BscHjkrJVVlUgyTbGeTyl7z8y3Mg==
X-Received: by 2002:a05:6a00:1385:b0:72a:aa0f:c86e with SMTP id d2e1a72fcca58-72d21f17738mr44987044b3a.4.1736980984037;
        Wed, 15 Jan 2025 14:43:04 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405942b0sm9709309b3a.74.2025.01.15.14.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 14:43:03 -0800 (PST)
Date: Wed, 15 Jan 2025 14:43:00 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>,
	Andrea Bolognani <abologna@redhat.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>,
	Andrew Jones <ajones@ventanamicro.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>, Guo Ren <guoren@kernel.org>,
	Yao Zi <ziyao@disroot.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v6 0/3] riscv/ptrace: add new regset to access original
 a0 register
Message-ID: <Z4g59EaNblLWKPXF@ghost>
References: <20250115-riscv-new-regset-v6-0-59bfddd33525@coelacanthus.name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115-riscv-new-regset-v6-0-59bfddd33525@coelacanthus.name>

On Wed, Jan 15, 2025 at 07:13:26PM +0800, Celeste Liu wrote:
> The orig_a0 is missing in struct user_regs_struct of riscv, and there is
> no way to add it without breaking UAPI. (See Link tag below)
> 
> Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
> access original a0 register from userspace via ptrace API.
> 
> Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
> 
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> ---
> Changes in v6:
> - Fix obsolute comment.
> - Copy include/linux/stddef.h to tools/include to use offsetofend in
>   selftests.
> - Link to v5: https://lore.kernel.org/r/20250115-riscv-new-regset-v5-0-d0e6ec031a23@coelacanthus.name
> 
> Changes in v5:
> - Fix wrong usage in selftests.
> - Link to v4: https://lore.kernel.org/r/20241226-riscv-new-regset-v4-0-4496a29d0436@coelacanthus.name
> 
> Changes in v4:
> - Fix a copy paste error in selftest. (Forget to commit...)
> - Link to v3: https://lore.kernel.org/r/20241226-riscv-new-regset-v3-0-f5b96465826b@coelacanthus.name
> 
> Changes in v3:
> - Use return 0 directly for readability.
> - Fix test for modify a0.
> - Add Fixes: tag
> - Remove useless Cc: stable.
> - Selftest will check both a0 and orig_a0, but depends on the
>   correctness of PTRACE_GET_SYSCALL_INFO.
> - Link to v2: https://lore.kernel.org/r/20241203-riscv-new-regset-v2-0-d37da8c0cba6@coelacanthus.name
> 
> Changes in v2:
> - Fix integer width.
> - Add selftest.
> - Link to v1: https://lore.kernel.org/r/20241201-riscv-new-regset-v1-1-c83c58abcc7b@coelacanthus.name
> 
> ---
> Celeste Liu (3):
>       riscv/ptrace: add new regset to access original a0 register
>       tools: copy include/linux/stddef.h to tools/include
>       riscv: selftests: Add a ptrace test to verify a0 and orig_a0 access
> 
>  arch/riscv/kernel/ptrace.c                   |  32 +++++
>  include/uapi/linux/elf.h                     |   1 +
>  tools/include/linux/stddef.h                 |  85 ++++++++++++
>  tools/include/uapi/linux/stddef.h            |   6 +-
>  tools/testing/selftests/riscv/abi/.gitignore |   1 +
>  tools/testing/selftests/riscv/abi/Makefile   |   6 +-
>  tools/testing/selftests/riscv/abi/ptrace.c   | 193 +++++++++++++++++++++++++++
>  7 files changed, 319 insertions(+), 5 deletions(-)
> ---
> base-commit: 0e287d31b62bb53ad81d5e59778384a40f8b6f56
> change-id: 20241201-riscv-new-regset-d529b952ad0d
> 
> Best regards,
> -- 
> Celeste Liu <uwu@coelacanthus.name>
> 

There is also this series that looks like it will solve this problem by
providing an architecture agnostic way of changing syscall args with
PTRACE_SET_SYSCALL_INFO [1].

- Charlie

[1] https://lore.kernel.org/lkml/20250113170925.GA392@altlinux.org/


