Return-Path: <linux-kselftest+bounces-32681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CD4AB0475
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 22:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676C67A8516
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 20:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C3B28C027;
	Thu,  8 May 2025 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U4gXf7Lu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2DF28B7DA
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746735546; cv=none; b=p2upTetbFlrO3bJ8j5Pp0QOOhkW4HvzfPEcXv3CBxZp6IgmzKCvbDqOIIxrNjX/1pbXU5tovyRieJuKY2cuyHDjzuGWfoA5W7E0XhBTt0FQveUQQ6JWiwB1oNcgv5iv2PQfRy1P21RIKmUhjV+qYFEfq4tTJWDGtQ5RxWInQTEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746735546; c=relaxed/simple;
	bh=x0TNRpz53QFAXapinD45Ke2DQpGv3VcwVjqoltUeo6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AP4aCsJPuOWLwTciBt55qu9ZgBAbltKleJ2vjlhyg4orPJDgddSV1Jr/GtOBuItraaJq4h++bJGsKAS269/8wHPKxxk7o8qj4vF/5/YZsKKjdbx1rwKUIa+4Qm1Eb6efJNnaEkCdZFdZ2GbMRhTS5vH3yKoQ5wVAeaqbnT4Sm9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U4gXf7Lu; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <edd8751d-dd5e-48f9-8c08-853d89c90130@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746735540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8ZPULVhkBmOhXVI9D50gyESuyxY/qERnIvpj+8HrdQ=;
	b=U4gXf7Luz4uxvOHjIGxizGSXyq5/BbkbqhZlxMzHw7xLH6MKTN21LM14oIanbJ3iuryHJ2
	gQUupmCPVGHvaNnUYCxN617JcFqj0wb4bA/VR6YLF1kfwJE8mjMfyvB90Y5+AZaZXYRUFT
	KOjZqKc/7Vf7S/rabeeTXe1Ja5Q9o34=
Date: Thu, 8 May 2025 13:18:55 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 03/14] riscv: sbi: add new SBI error mappings
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>, Deepak Gupta <debug@rivosinc.com>
References: <20250424173204.1948385-1-cleger@rivosinc.com>
 <20250424173204.1948385-4-cleger@rivosinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20250424173204.1948385-4-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/24/25 10:31 AM, ClÃ©ment LÃ©ger wrote:
> A few new errors have been added with SBI V3.0, maps them as close as
> possible to errno values.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/riscv/include/asm/sbi.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index bb077d0c912f..7ec249fea880 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -536,11 +536,21 @@ static inline int sbi_err_map_linux_errno(int err)
>   	case SBI_SUCCESS:
>   		return 0;
>   	case SBI_ERR_DENIED:
> +	case SBI_ERR_DENIED_LOCKED:
>   		return -EPERM;
>   	case SBI_ERR_INVALID_PARAM:
> +	case SBI_ERR_INVALID_STATE:
>   		return -EINVAL;
> +	case SBI_ERR_BAD_RANGE:
> +		return -ERANGE;
>   	case SBI_ERR_INVALID_ADDRESS:
>   		return -EFAULT;
> +	case SBI_ERR_NO_SHMEM:
> +		return -ENOMEM;
> +	case SBI_ERR_TIMEOUT:
> +		return -ETIME;
> +	case SBI_ERR_IO:
> +		return -EIO;
>   	case SBI_ERR_NOT_SUPPORTED:
>   	case SBI_ERR_FAILURE:
>   	default:

Reviewed-by: Atish Patra <atishp@rivosinc.com>

