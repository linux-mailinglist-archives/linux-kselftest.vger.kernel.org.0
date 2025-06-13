Return-Path: <linux-kselftest+bounces-34922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D90AD92CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 18:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8611E3045
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D2720D500;
	Fri, 13 Jun 2025 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L3fLw5q6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A1620A5E1
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749832107; cv=none; b=mkhIsS5QTNTpTH4jSCr7iUEOLCcVNqyQgN6mvVp1WhsVO7e5wFgx2E6V/pGAw+zTFnDTKkLGGREb4xI0AYd4td5nRrJ5Zz4e69PiYW2qGNtOCl5B/mRSzeT7yMwSnpRg8HCROkeWUWJWQvDPgOeQUXSs2kGMbI8VOd8qEJ7XedE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749832107; c=relaxed/simple;
	bh=oBdNAj0QtAfBfiBdOhBtL6PzLu+q2pxrR0228ms+eow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0cJqBD/omrVQYTuw/2WFGGlGpYweOTPDKBiDG8f8L+XR9BXBcfyHAtY65d7z6/MlBhQiL/UO3nfPXdZ9UOwtmOVM0uqeh0GG5JKdo730DSjqlE+MPaFDLPOGV/hPT0nyD0kh3T67Cg55BD+xBh7ITa9u3N9PacGvi3+t8N1tsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L3fLw5q6; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 13 Jun 2025 18:27:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749832093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gwJb0imNaDB4wZxKL2FWvnsxmxhY/MZ4QeoknxKLKUM=;
	b=L3fLw5q6e7Y2Vm6lBu+gtX2N6Z1Yoi6IJQZL2yjNDwbGm3nZzmJTlYZp724rNI6/UhYZ28
	kjbPUF0nf6bZCnD+svYbhJ7v6aaunpU3lhk4yZHDMMkSpNCvJMbqbMSq8KBHR0iFlVMk32
	6ubBPziJd9SGxVB47zh992wG19nDKQ0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Atish Patra <atish.patra@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Himanshu Chauhan <hchauhan@ventanamicro.com>, 
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [kvm-unit-tests PATCH v2] riscv: Allow SBI_CONSOLE with no uart
 in device tree
Message-ID: <20250613-8809c9eccfc2000c01f298e1@orel>
References: <20250613150313.2042132-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613150313.2042132-1-jesse@rivosinc.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 13, 2025 at 08:03:13AM -0700, Jesse Taube wrote:
> When CONFIG_SBI_CONSOLE is enabled and there is no uart defined in the
> device tree kvm-unit-tests fails to start.
> 
> Only abort when uart is not found in device tree if SBI_CONSOLE is false
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  lib/riscv/io.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>

Applied to riscv/sbi

https://gitlab.com/jones-drew/kvm-unit-tests/-/commits/riscv/sbi

Thanks,
drew

