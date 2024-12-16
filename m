Return-Path: <linux-kselftest+bounces-23427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B529F37AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 18:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59222188C29E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF652066E0;
	Mon, 16 Dec 2024 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YirRE0bH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5013E20765E
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370571; cv=none; b=hIOH93clKuO03yOteybMBvbITm7kkrvT+6RcwkXb0BJcRGRh3bjwJEiMmO4pSsTKoa8lAV8axuOIvHyxp5DBJynqgt4Fuov5siwfN79LVavXhQ+HuJUoQPKO4rTQgTlxJ2LVtuIFONYflwCE/d+jV8mIKjZQKPGXRLZjw8oY/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370571; c=relaxed/simple;
	bh=Coc7NOpbdSi1XoEVAQEV/4mMo/dNRQykeG5v1vlYuaA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CsL+1o2JgSEO8/vMS5Nx+idXfi2ag2IAR3uJ7am3DbiSuNU2Nbyojxvs9ankAZGKrBdl4/n9rhy9kSDSLlON/BeDSSPYOQtwMbNRwpaFHSXmPQWLz77bfvySKQ6NKfQ6Vl3PHwZ/RhAfyfMVMC8qsngMcFKK7FF3UmM/SONz5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YirRE0bH; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725f4623df7so3771071b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 09:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734370570; x=1734975370; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FSidIYogNXz2GKEcIpG1NgqD/WO+bMgS5pOibDpj814=;
        b=YirRE0bH7LKEu7f1aGAABWBgSejQMTTgZvEgsRgNJsLOY2HcqmSpkMtsoHVBECKlOQ
         5D40uuBglbtasuz86bf25WEwHz7YoH/MMP1I+E6rsxyENg4JVRuYVF0oqEzjO3fPjdWj
         kqU1bKNO97ogrWAPCGHrXc0LBy6GAn+U5acLummWtF1p44iO9p7zKbt0RTZJCnMeJMRN
         0LSpdr4RuJ7g/5n63CrDPcKhoudv2Y+CJPltwptsZvWR4HBuFpiNeMW7Ij1R/RmxK/g8
         /g6OYxtsId3ExkuY7gX7JZBhZ8I2kgO0/il96tRyc4vVTWsNs9zVGBI0qBBk8ziJJmkk
         fDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734370570; x=1734975370;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSidIYogNXz2GKEcIpG1NgqD/WO+bMgS5pOibDpj814=;
        b=bsISeq/Hqt0tZt4DpuaTNP9umTey4M8RfTRMCFfhptlBpqHlVWLeoIQNevZY9skotE
         PyUSUTT1WDjmzjNSNlHj/vyYl4mfATGkNDsiJt7eeGjb9YHR8ohBSVHlnUB7BGa6RQP+
         g4JNXdhwSFVGbs3hP9O2VA/2TBN9XXh+5hbsWEmsrwOqkVY22LLOo+As4sOlRTnjDOIn
         DxqRAdUKDCt0CJxTC9bvBhfJcb3j4VEqkXFjtoLSyZ80CanqqeOCCTlXmcr8gIbSd8be
         0wfUnVO0a0GgHu7VPAQG1SocLvrcRyM/Xg0Cfy0XLpIdUGh9nvV9i8/KsJrEbTL4wgoY
         lpqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbw4RWQvh8FvM//dFKHIlNZDme2KaFXm3VNPQD88df917uyp3X7lYflNTLXbISSBrUZ3YHAf1nMtAnxHxwD54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Sj6fjXzxI2ztIsjveUDAq4IgXlLLwESWk0D1tY0c71y1u5uK
	DFkW89tf8iLwuod1U6O6Z4pjImJCyrVmg555pBdwJmgZiKPB6XX+
X-Gm-Gg: ASbGnctIvY5zEm1EGADgThZBzKgwaAl0WTkJudTGina2l8kmsJopbN0LIjGe+W1j8GY
	1mnhAYlPtR6AJiAUSwYVDTLOS7wpaJj5XE/e2DjJpxbHSf9VnolquA+r0ZxdoCF35jpRZWK3OZL
	D8RWtJBj/JXmkRcwVUrsZ8bu/0zpApB7SQ3IbELfishJAfOqPgzrAahXWYvy8ii74eZ9vHWIgp1
	7FrDtKQiVn+vpKOCu2ZG91GuU/sVvmp2DTYYCKvsBD3Xxt0kA==
X-Google-Smtp-Source: AGHT+IExEQkn+NPoAaYjM4wJoDfBmC62mhKiXO92/+2AgclJqqMbMv84UkJ6llvY+HQqci7zKrX/ZA==
X-Received: by 2002:a05:6a20:9c8d:b0:1e0:cfc0:df34 with SMTP id adf61e73a8af0-1e1dfd3ea15mr20259089637.16.1734370569570;
        Mon, 16 Dec 2024 09:36:09 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b78986sm5008691b3a.91.2024.12.16.09.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:36:08 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] selftest/powerpc/ptrace: Cleanup duplicate macro definitions
In-Reply-To: <20241216160257.87252-3-maddy@linux.ibm.com>
Date: Mon, 16 Dec 2024 22:54:02 +0530
Message-ID: <87ikrj4k3x.fsf@gmail.com>
References: <20241216160257.87252-1-maddy@linux.ibm.com> <20241216160257.87252-3-maddy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Madhavan Srinivasan <maddy@linux.ibm.com> writes:

> Both core-pkey.c and ptrace-pkey.c tests have
> similar macro definitions, move them to "pkeys.h"
> and remove the macro definitions from the C file.
>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
> Changelog v1:
>  - Removed additional macros pointed out by Ritesh
>    which are duplicates and are avilable in "pkeys.h"

Thanks! The changes looks good to me. 

Please feel free to add - 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


Gave a quick run on my lpar too - 

# selftests: powerpc/ptrace: core-pkey
# test: core_pkey
# [User Write (Running)]         AMR: 3cffffffffffffff pkey1: 4 pkey2: 5 pkey3: 6
# success: core_pkey
ok 9 selftests: powerpc/ptrace: core-pkey
# selftests: powerpc/ptrace: ptrace-pkey
# test: ptrace_pkey
# [User Write (Running)]         AMR: 3cffffffffffffff pkey1: 4 pkey2: 5 pkey3: 6
# success: ptrace_pkey
ok 13 selftests: powerpc/ptrace: ptrace-pkey


-ritesh

>
>  tools/testing/selftests/powerpc/include/pkeys.h      |  8 ++++++++
>  tools/testing/selftests/powerpc/ptrace/core-pkey.c   | 12 ------------
>  tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c | 12 ------------
>  3 files changed, 8 insertions(+), 24 deletions(-)
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
> index 31c9bf6d95db..f061434af452 100644
> --- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
> +++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
> @@ -18,18 +18,6 @@
>  #include "child.h"
>  #include "pkeys.h"
>  
> -#ifndef NT_PPC_PKEY
> -#define NT_PPC_PKEY		0x110
> -#endif
> -
> -#ifndef PKEY_DISABLE_EXECUTE
> -#define PKEY_DISABLE_EXECUTE	0x4
> -#endif
> -
> -#define AMR_BITS_PER_PKEY 2
> -#define PKEY_REG_BITS (sizeof(u64) * 8)
> -#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey + 1) * AMR_BITS_PER_PKEY))
> -
>  #define CORE_FILE_LIMIT	(5 * 1024 * 1024)	/* 5 MB should be enough */
>  
>  static const char core_pattern_file[] = "/proc/sys/kernel/core_pattern";
> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
> index 6893ed096457..fc633014424f 100644
> --- a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
> @@ -9,18 +9,6 @@
>  #include "child.h"
>  #include "pkeys.h"
>  
> -#ifndef NT_PPC_PKEY
> -#define NT_PPC_PKEY		0x110
> -#endif
> -
> -#ifndef PKEY_DISABLE_EXECUTE
> -#define PKEY_DISABLE_EXECUTE	0x4
> -#endif
> -
> -#define AMR_BITS_PER_PKEY 2
> -#define PKEY_REG_BITS (sizeof(u64) * 8)
> -#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey + 1) * AMR_BITS_PER_PKEY))
> -
>  static const char user_read[] = "[User Read (Running)]";
>  static const char user_write[] = "[User Write (Running)]";
>  static const char ptrace_read_running[] = "[Ptrace Read (Running)]";
> -- 
> 2.47.0

