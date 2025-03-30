Return-Path: <linux-kselftest+bounces-29924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73398A759BA
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 13:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276CF168AD2
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 11:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53C81C3BEE;
	Sun, 30 Mar 2025 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="An30oobd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47099175D50
	for <linux-kselftest@vger.kernel.org>; Sun, 30 Mar 2025 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743333182; cv=none; b=Rk3/L1YSaRlj6dQqBnZhakrkpUris3kXCK1JZbwMB7CYB6ev7NWqCn24jICVmDNy2Vj2rPjF4OGipiSbAv4Q7gwYWl+2CwBnQkHV21NMenCuYxCJahic3THgH5hHRXeC1E9G7Jc23FKsNEg2pmNwrtF10ovYNRZfOLgFnHgZ624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743333182; c=relaxed/simple;
	bh=LnWQlUy0Obb41LuuYcG29m2i3AkxpTw3bT9Z6HbqeoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9I641RP6pqDb40VlAMLPIBzzu540nPtt39Bf3+PphzKKBPUBh3hwIGaS11vIUjPIz9p76x1/z3wCCwOLjU+MMwnbDMG4t1pS/H5EDVulA+/G8G1S4NGwjiLbbvB4EM1nmRUoNZZ/oarNMtpCuoJ1ybu/8k5+x9035tVpmaGaog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=An30oobd; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Message-ID: <14e0cc95-95d7-4e7d-949b-d944366510a3@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1743333168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJY3OLhP2SkmfexLon8hzKLe4fDSbbfUy/idzgYz8bg=;
	b=An30oobdO9LFf0QQeb0gDKl+YJQCJivOaMuyVu1pPFaynt3+Ue61jxmEiUC6ouLugMvMst
	kN3ZFifMDLqlyIj8VnA9284owVulaFeSA062+b6Zn+OhXyvrr0NWcrbqdMUgJAU0SpZLnh
	CNPnID6XrLh/kIit6F1L/M4lsfIVJR8rdtVCy+Zj2gSzeKpAXT+nGzxSo24kBWFqcNA6tR
	qOLK+mvmtb88T+CfR3GxerP7HPgkwH5Jw6KMRWYO5PORxXmfh+DPW8L6CXpU4VeOoBwzF1
	n4bnN7Zt5KppamvM8SYNCglFPb2I/DhGI8+/VAgrx65OGarD1mex7uawOLGIMg==
Date: Sun, 30 Mar 2025 13:12:39 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] selftests: riscv: fix v_exec_initval_nolibc.c
To: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
References: <20250306-fix-v_exec_initval_nolibc-v2-1-97f9dc8a7faf@iencinas.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <20250306-fix-v_exec_initval_nolibc-v2-1-97f9dc8a7faf@iencinas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Gentle ping :)

On 6/3/25 20:49, Ignacio Encinas wrote:
> Vector registers are zero initialized by the kernel. Stop accepting
> "all ones" as a clean value.
> 
> Note that this was not working as expected given that
> 	value == 0xff
> can be assumed to be always false by the compiler as value's range is
> [-128, 127]. Both GCC (-Wtype-limits) and clang
> (-Wtautological-constant-out-of-range-compare) warn about this.
> 
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> Tested-by: Charlie Jenkins <charlie@rivosinc.com>
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
> ---
> Changes in v2:
> 
> Remove code that becomes useless now that the only "clean" value for
> vector registers is 0.
> 
> - Link to v1: https://lore.kernel.org/r/20250305-fix-v_exec_initval_nolibc-v1-1-b87b60e43002@iencinas.com
> ---
>  tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
> index 35c0812e32de0c82a54f84bd52c4272507121e35..4dde05e45a04122b566cedc36d20b072413b00e2 100644
> --- a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
> +++ b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
> @@ -6,7 +6,7 @@
>   * the values. To further ensure consistency, this file is compiled without
>   * libc and without auto-vectorization.
>   *
> - * To be "clean" all values must be either all ones or all zeroes.
> + * To be "clean" all values must be all zeroes.
>   */
>  
>  #define __stringify_1(x...)	#x
> @@ -14,9 +14,8 @@
>  
>  int main(int argc, char **argv)
>  {
> -	char prev_value = 0, value;
> +	char value = 0;
>  	unsigned long vl;
> -	int first = 1;
>  
>  	if (argc > 2 && strcmp(argv[2], "x"))
>  		asm volatile (
> @@ -44,14 +43,11 @@ int main(int argc, char **argv)
>  			"vsrl.vi " __stringify(register) ", " __stringify(register) ", 8\n\t" \
>  			".option pop\n\t"					\
>  			: "=r" (value));					\
> -		if (first) {							\
> -			first = 0;						\
> -		} else if (value != prev_value || !(value == 0x00 || value == 0xff)) { \
> +		if (value != 0x00) {						\
>  			printf("Register " __stringify(register)		\
>  				" values not clean! value: %u\n", value);	\
>  			exit(-1);						\
>  		}								\
> -		prev_value = value;						\
>  	}									\
>  })
>  
> 
> ---
> base-commit: 03d38806a902b36bf364cae8de6f1183c0a35a67
> change-id: 20250301-fix-v_exec_initval_nolibc-498d976c372d
> 
> Best regards,


