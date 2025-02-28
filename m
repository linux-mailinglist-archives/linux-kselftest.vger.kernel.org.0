Return-Path: <linux-kselftest+bounces-27877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80231A49918
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49FF37A9358
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E27626AA83;
	Fri, 28 Feb 2025 12:22:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EC01C5496;
	Fri, 28 Feb 2025 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745377; cv=none; b=OM0ZXp732Kz49TLV3e+DKGAL9qOYHq8BhB2Ac4giDf7rNNI27zZIeotmUSdNSskqEnW01/gw/Ba2EkjtpiZvafB5gPyGV5HATZAklGUPvY+N06bnt4gABQfK1GM/ng/oJ7UXDlP17K/ilav5xxAk8umLU6e4dpBLYGJCTLnXh1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745377; c=relaxed/simple;
	bh=MHbTwnqBrBd0xBuGqPeLEKnnWa+OI56CGCm/aFKtFI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9+M+3taDZhU82L1A+RyeCCgJsqGElPLqQGu9qA3r5Mre9J8pMv3xlY+g4vU3puLbNkZvM4wKRVc9cosLsZ/SqUz/AzT//L7KZm+O6cX2EjGx09ItDHCJUbPHAp5hOvdNhbDyrn8mZOw7jGj1iOYE5GswOh/xnY9g4hYY5m66yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72F071688;
	Fri, 28 Feb 2025 04:23:09 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFCF33F6A8;
	Fri, 28 Feb 2025 04:22:51 -0800 (PST)
Message-ID: <fe2c2f1f-8d6e-4f0d-8a25-9fa180d9062c@arm.com>
Date: Fri, 28 Feb 2025 12:22:50 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] MAINTAINERS: Add vDSO selftests
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
 <20250226-parse_vdso-nolibc-v2-1-28e14e031ed8@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-1-28e14e031ed8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2025 11:44, Thomas Weißschuh wrote:
> These currently have no maintainer besides the default kselftest ones.
> Add the general vDSO maintainers, too.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa06545e2861abe46ea7029f9b4d3628e..959c8a86844eb1e5c6218e8fdbde6c3ebf68e25d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9777,6 +9777,7 @@ F:	include/asm-generic/vdso/vsyscall.h
>  F:	include/vdso/
>  F:	kernel/time/vsyscall.c
>  F:	lib/vdso/
> +F:	tools/testing/selftests/vDSO/
>  
>  GENWQE (IBM Generic Workqueue Card)
>  M:	Frank Haverkamp <haver@linux.ibm.com>
> 

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

-- 
Regards,
Vincenzo


