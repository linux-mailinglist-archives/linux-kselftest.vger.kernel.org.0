Return-Path: <linux-kselftest+bounces-9242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E7F8B9045
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 21:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239991C2136C
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 19:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EF616191A;
	Wed,  1 May 2024 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aNuSTsxd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F6D16132E
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593283; cv=none; b=i07ikV4NT4D+rTkbnotFmzmvXH/ShHerXoPCJc7uYiVgEjGzI+kmaFvbFnbp7eOtPjc0pc8lI+G1XsvrFpv6X9O5FqqY5pB4SHGkBkxhAmWkGp5M7xtrYSdd+I4Mn1lAYtZzzkgIvhqeFEDkaVvDfNivkg4wuAIHCR8XJkeuLiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593283; c=relaxed/simple;
	bh=3AFePkdooPErfFu/qbXBokEPm+8+qcbQdefFXCyvhhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qebbmVHPcfGORYTNxY3TjXUTV6sWgeL9QhbQEa4dzNIRXWoh5njG5zjUZ/yAkWSS2fr1H2G7ZLHIqvfRbjRXywKfzY4+weZNHKx/7NZv8bBB4McgNwsZhMNOjhK7i8ZEoHitdPuzN0OH6IWayFOiaz/RK+wGmcStE1cyScy2xkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aNuSTsxd; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7dee8d177e1so44006239f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714593281; x=1715198081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3qjMSjjDTWfiqOEbDNPmH92wnyK6R57JD3befS8Eeg=;
        b=aNuSTsxdZmgG85sScL/nfJYe1Mbz1e3SPwZGzUqMj5b26GVRWAKXmBYPVlsQjvQob6
         37tcwIzjfIQm5xLLv7s90JjC/OfKdywLrWnxUX0WBblntFnQyijsoBstFU6uZzodU8fM
         jKRVkb8oTiANGs59L4RwaCicFJBpavw9Fo8+6EAooIPp1lkJnVUhglOehiAl6LGBxl3S
         I8ouCYnuSH5jILjiIjYvUC82vDbwFsXLDHAnqu6HSo/nl/rl/y8HJuiCwaNuObguyXf1
         MTRSjrABORasTaMv3I4+vKBuYx5a1EM1M3fQajSHmVjv+PHtbTId1L5xMZ0FNNGdwj7g
         u+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714593281; x=1715198081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3qjMSjjDTWfiqOEbDNPmH92wnyK6R57JD3befS8Eeg=;
        b=f1UbhAQpsi5/j1BVQzSYYSW5vREKuk9igz8oS0oCqYFPzc8JJSPuM7B7uHbfyNmKyQ
         kqOlTWxcIH5deK5zVb/mhVo+rZbcqJLljOmFJ/cM2shcXRNGpjukesrQuEe/ci5bM5EP
         SlmChpiRYcuc/p1nOTUbwTtaIZrNpAj3qwy7ypCktWn8hOzPNNMqQVWnWBje4l6x4HP8
         kAEuGFqGYSdy5REL297/2xS1ADni5l4mmXD2KcBYkARkpZLzsNSV3dKt5eryxIZoUDHn
         HXCIKF5sBO5x7ooKYUTLkIaOSrObX57j+Kr42JhRR1Qi49GfpVwMm17LTx2MBftbUhtg
         Hn2A==
X-Forwarded-Encrypted: i=1; AJvYcCX6LB5uhVEzjYlAju+EnF9aHfbxdr0+mgQAbYp3EfyVEAABjBx6m9TjreYlVnucy9+vIc/ViTSQrid9a/JqVLNWttTR/1EamNjBO5WLNIOe
X-Gm-Message-State: AOJu0YxMLiNpwkp7Nl45o9YW2K4z/Sjr8kTm3mOkuL11tYL6yBJCQdkO
	N2OkxyGj1SjjB9NBshTnbNK4AB+rhPgLDKt9vn3FxiMrmgY0UKzjbinAqMpkHQ==
X-Google-Smtp-Source: AGHT+IFV0Ej1qR/QMLUPSTTY0DQ7vd7qiVQm5fV9ISZXRkhorw2Wgn4KuGk7bnpcpR08pavfAqxO4Q==
X-Received: by 2002:a5e:c80c:0:b0:7de:ca48:4fab with SMTP id y12-20020a5ec80c000000b007deca484fabmr4093192iol.2.1714593281030;
        Wed, 01 May 2024 12:54:41 -0700 (PDT)
Received: from google.com (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id ci10-20020a0566383d8a00b004874d717cffsm3529346jab.29.2024.05.01.12.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:54:40 -0700 (PDT)
Date: Wed, 1 May 2024 19:54:35 +0000
From: Justin Stitt <justinstitt@google.com>
To: Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, "H. Peter Anvin" <hpa@linux.intel.com>, 
	Andy Lutomirski <luto@mit.edu>, linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	llvm@lists.linux.dev
Subject: Re: [PATCH v3] selftests/vDSO: Explicit unsigned char conversion for
 elf_hash
Message-ID: <osgrbhnqlyh5yw4y4x6wjggx56dogsgje5yy3mkpu75ubs3zwg@5tliydzky37k>
References: <20240501180622.1676340-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501180622.1676340-1-edliaw@google.com>

Hi,

On Wed, May 01, 2024 at 06:06:18PM +0000, Edward Liaw wrote:
> Fixes clang compilation warnings by adding explicit unsigned conversion:
> 
> parse_vdso.c:206:22: warning: passing 'const char *' to parameter of
>  type 'const unsigned char *' converts between pointers to integer types
>  where one is of the unique plain 'char' type and the other is not
>  [-Wpointer-sign]
>         ver_hash = elf_hash(version);
>                             ^~~~~~~
> parse_vdso.c:59:52: note: passing argument to parameter 'name' here
> static unsigned long elf_hash(const unsigned char *name)
>                                                    ^
> parse_vdso.c:207:46: warning: passing 'const char *' to parameter of
>  type 'const unsigned char *' converts between pointers to integer types
>  where one is of the unique plain 'char' type and the other is not
>  [-Wpointer-sign]
>         ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
>                                                     ^~~~
> parse_vdso.c:59:52: note: passing argument to parameter 'name' here
> static unsigned long elf_hash(const unsigned char *name)
> 
> Fixes: 98eedc3a9dbf ("Document the vDSO and add a reference parser")
> Signed-off-by: Edward Liaw <edliaw@google.com>

> ---
> v2: update commit message with correct compiler warning
> v3: fix checkpatch errors and indentation
> ---
>  tools/testing/selftests/vDSO/parse_vdso.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
> index 413f75620a35..9e29ff0657ea 100644
> --- a/tools/testing/selftests/vDSO/parse_vdso.c
> +++ b/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -203,8 +203,9 @@ void *vdso_sym(const char *version, const char *name)

Is it possible to just change the types of the parameters of vdso_sym()
or does that trigger even more warnings on the callsites of vdso_sym()?

Either way, this looks ok to me.

Acked-by: Justin Stitt <justinstitt@google.com>

>  	if (!vdso_info.valid)
>  		return 0;
> 
> -	ver_hash = elf_hash(version);
> -	ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
> +	ver_hash = elf_hash((const unsigned char *)version);
> +	ELF(Word) chain = vdso_info.bucket[
> +		elf_hash((const unsigned char *)name) % vdso_info.nbucket];
> 
>  	for (; chain != STN_UNDEF; chain = vdso_info.chain[chain]) {
>  		ELF(Sym) *sym = &vdso_info.symtab[chain];
> --
> 2.45.0.rc0.197.gbae5840b3b-goog
> 

Thanks
Justin

