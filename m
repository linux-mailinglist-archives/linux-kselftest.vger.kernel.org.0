Return-Path: <linux-kselftest+bounces-23405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B65169F2EC8
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 12:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1F318851A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A1B203D78;
	Mon, 16 Dec 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRgZXaed"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B91C5F01
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347044; cv=none; b=DhrNJtYhz6siy2T5wDoJ/JWCuzkoiHNJNCpNFszAxUxD9WNx9NwAs78Zi4/DBb8RgXDzV0Y0M5o0rbS0KdZN52SDQ5CfYYzBYoldsrVK0pkRe5rgQ7OGgKXFLaAuPJyO1QEnRwvHSA9oG4hbuQ8X1fuMxApanQMevIo6BN5RwTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347044; c=relaxed/simple;
	bh=S2OVesPPUfaLh56CfyznLDIQlxZOw94gkrloQEe3NGk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=NHtHn8ZocJaPITwlZIWFoFK4prcJ6gwsSKOIglYSSgoU4J2vUkPTPea8rRZnH9j7nA3xaC6vMokg41WPjGzIa8gKOjbsm2r2iyUy5NJL1JYtqaAXgnvZt9aDZvBnsBbfMc9cHZxDw6e/IposlN5O+SXdT84mb+KIUyNtmiJiMoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRgZXaed; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f1459b6f84so2598194a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 03:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734347042; x=1734951842; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gnyomrbbH71hy5x29CyLw5kngPIRQhxtjeFPjHZ4daA=;
        b=hRgZXaedpxUyxgI4PTKXpNzNB9hDRsKgg7d9sPz17BMhSUHqBkyT9WaZODLupPYM5v
         YmzVYlOy7TywA0LD7sv6QKwwNVm3CCvpe+7MiAgvEYimITlGhY3zULpec7DvNXmjazYN
         nJTBr7nm2u3kA44NaB6G5PyMvH+N2H7gzy/VGlz74EGn6UzNjLPKE+V0Ek959oTnrao+
         X9OFgPaxFErYBN299e+CRSl0QB5GvnEInsfEr+Z+5QuOVs4me/q0NEGioP0WU8r0REFD
         +94F7fFTNGBmgqWhYUJDhAH4ThlTijJKIpIhiU07yAXW/l+ZMEjZbu8vhlFKVNsutIBe
         9CFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734347042; x=1734951842;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnyomrbbH71hy5x29CyLw5kngPIRQhxtjeFPjHZ4daA=;
        b=Hp2iZw4DDqIqjyJ7FIjl3PXUlyDHmwK3+Q6dxPQXxdC3+TQgTwvCbJlSqUhPZsqQwX
         Q+9NgXG45FkMNgD9udCPmlnJYpeP2GaKtlX1qfw/bGKAhZdbCidgebdM8ctKfRSNb9aJ
         eNKLkJfsvU68xKYbRWe+2pOQlBl4rvIlcEH87tIFmOSo80dNqojaO6j7b0BaaLdvNi+h
         VDtkkIpJvTLV9ldWhUlwpVIJcMA90lpVAaSYtMwkvFwanIVtK+pJl2uyLvyGuG9HzZ2Y
         xKlK2T8LUPsWILxWefk2vVgqBCzehw2j6ZilKzhC/XgPzXtH8N3IteZKPWWmiRzNCTmM
         CbBw==
X-Forwarded-Encrypted: i=1; AJvYcCV/4HFDNcbjXAyDEwJ3RGJBbm8CF7ySOjJCXHoJh0rz6OW6FD8iym/oIhK2e2giA4Jcda0Sc2YePz7+jN69tbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgdwgz75bYsC9OXHo2Y76Gwd9Z7Bgm1bmT3ebAMkOgJnP6ge2
	AAEADjEuW64YMpBtkOc83kioYiyPtUU8TQKZHGBpegzw24vsugb2
X-Gm-Gg: ASbGnctnAfD9t6IlHpdxlEYNlin/7JEuutfkz6LT3+Hk7alI+0V2dnUQHjlwHbQCXkc
	3XV8doEwtCrfwJtISuuEbMxW+wKxH/jvbROJJd7+6Q8v5+UDlIfk7Ud49NJr9cdeC6L3UM6go2J
	vtLNpH2KRlgxwRO1GY3hJTn29odQwCsur2COqvly1yC+4Mr8RCvY1v9z2Rce7fg6bdCKO6msRme
	1ppd2YPo0mGqN/s8D3dsKc3kGVoWIp6PgU1JJpGBSFr7qEgKw==
X-Google-Smtp-Source: AGHT+IHv/dKmYY49IAGHVjgEthrBcbNdF2QQcOvVyzK3tdGCnz0JYSPwnkBeaAuUqwtxjbmP0WyFLg==
X-Received: by 2002:a17:90b:3902:b0:2ee:c91a:ad05 with SMTP id 98e67ed59e1d1-2f28fa55be2mr16492998a91.3.1734347042392;
        Mon, 16 Dec 2024 03:04:02 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a1e7e348sm4404198a91.8.2024.12.16.03.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 03:04:01 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH 3/3] selftest/powerpc/ptrace: Cleanup duplicate macro definitions
In-Reply-To: <20241209151418.348085-3-maddy@linux.ibm.com>
Date: Mon, 16 Dec 2024 16:27:03 +0530
Message-ID: <87ldwf520w.fsf@gmail.com>
References: <20241209151418.348085-1-maddy@linux.ibm.com> <20241209151418.348085-3-maddy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Madhavan Srinivasan <maddy@linux.ibm.com> writes:

> Both core-pkey.c and ptrace-pkey.c tests have similar macro
> definitions, move them to "pkeys.h" and remove the macro
> definitions from the C file.
>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
>  tools/testing/selftests/powerpc/include/pkeys.h      | 8 ++++++++
>  tools/testing/selftests/powerpc/ptrace/core-pkey.c   | 8 --------
>  tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c | 8 --------
>  3 files changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/selftests/powerpc/include/pkeys.h b/tools/testing/selftests/powerpc/include/pkeys.h
> index 51729d9a7111..3a0129467de6 100644
> --- a/tools/testing/selftests/powerpc/include/pkeys.h
> +++ b/tools/testing/selftests/powerpc/include/pkeys.h
> @@ -35,10 +35,18 @@
>  #define __NR_pkey_alloc		384
>  #define __NR_pkey_free		385
>  
> +#ifndef NT_PPC_PKEY
> +#define NT_PPC_PKEY		0x110
> +#endif
> +
>  #define PKEY_BITS_PER_PKEY	2
>  #define NR_PKEYS		32
>  #define PKEY_BITS_MASK		((1UL << PKEY_BITS_PER_PKEY) - 1)
>  
> +#define AMR_BITS_PER_PKEY 2
> +#define PKEY_REG_BITS (sizeof(u64) * 8)
> +#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey + 1) * AMR_BITS_PER_PKEY))
> +
>  inline unsigned long pkeyreg_get(void)
>  {
>  	return mfspr(SPRN_AMR);
> diff --git a/tools/testing/selftests/powerpc/ptrace/core-pkey.c b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
> index 31c9bf6d95db..f8ff05e5bf6e 100644
> --- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
> +++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
> @@ -18,18 +18,10 @@
>  #include "child.h"
>  #include "pkeys.h"
>  
> -#ifndef NT_PPC_PKEY
> -#define NT_PPC_PKEY		0x110
> -#endif
> -
>  #ifndef PKEY_DISABLE_EXECUTE
>  #define PKEY_DISABLE_EXECUTE	0x4
>  #endif

We could remove this as well right. Since pkeys.h already has this
permission defines i.e.
PKEY_DISABLE_[ACCESS|WRITE|EXECUTE] 

>  
> -#define AMR_BITS_PER_PKEY 2
> -#define PKEY_REG_BITS (sizeof(u64) * 8)
> -#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey + 1) * AMR_BITS_PER_PKEY))
> -
>  #define CORE_FILE_LIMIT	(5 * 1024 * 1024)	/* 5 MB should be enough */
>  
>  static const char core_pattern_file[] = "/proc/sys/kernel/core_pattern";
> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
> index 6893ed096457..5d528d0ea9d1 100644
> --- a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
> @@ -9,18 +9,10 @@
>  #include "child.h"
>  #include "pkeys.h"
>  
> -#ifndef NT_PPC_PKEY
> -#define NT_PPC_PKEY		0x110
> -#endif
> -
>  #ifndef PKEY_DISABLE_EXECUTE
>  #define PKEY_DISABLE_EXECUTE	0x4
>  #endif
>  

Same here. This can be cleaned up, no? Since pkeys already has this defined.


-ritesh

> -#define AMR_BITS_PER_PKEY 2
> -#define PKEY_REG_BITS (sizeof(u64) * 8)
> -#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey + 1) * AMR_BITS_PER_PKEY))
> -
>  static const char user_read[] = "[User Read (Running)]";
>  static const char user_write[] = "[User Write (Running)]";
>  static const char ptrace_read_running[] = "[Ptrace Read (Running)]";
> -- 
> 2.47.0

