Return-Path: <linux-kselftest+bounces-17918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BD897774B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 05:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAE2284C9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 03:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A7E13BC35;
	Fri, 13 Sep 2024 03:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MnKw2qen"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AB126BFD
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 03:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726197742; cv=none; b=fUUcgOacG9tArj1z7bYWuONwwPL/PHGv0MK7nlCVHsqqJSk6P0xr6hNsIRJS31U1ws43qwkUbXW8qJjUpbAZmkWBhiyOZETgac7TXMdRre16CTluih90JKoQwXMqTBqnctoc7u59ZrV7m7dIK2sQqTgD9/uhgv1Cgdq3YBtH8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726197742; c=relaxed/simple;
	bh=LBKUmZMOk3aPHxmkpJxtDXiScihcj9+OrSYx9MxN8fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJvhW7snIdGbSbG92pd/zOzXGufK36SC4Hzb0F1mwRFgFkLz9yQeobQha/KrcrWbdmxVRR9uRx0XSYnbvMFUXIyrJpK0GCgQdCZgrqwENE6pJ4Jbp7pJfO9c80Ukytqzj4gzz+l6zJcLcfN4pERtY/pMP3Thh3Kf7L8WtIDiKU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MnKw2qen; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1382054a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 20:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726197740; x=1726802540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkPkVDRD0OwFEuQUvV+n2s6XJ6GgG4bakHl8tALnG+0=;
        b=MnKw2qenx7rLfuhv1JSp9EMfyq0ahoj0HOTv6LBoTFKDlc9rsWqM5K6px/1av/b8Av
         sD6HzsxJPyet0qCqPkhchnL8QGTVfxc8ybeubQ+vgIw77qi4aiYUHQ3osC3OCdTArgUi
         yWVjboDucLrjkopVg/MjDTOWdeTYIRMGywAzhm9ZzMzONJtYj/2ifpnczT3ej1N/jPnB
         aTyCgp+oJ/wSPiNKhbABpkih+6zZp93dtQp30ehz19skgW4/Hb68iBfuenToyWkCNb4k
         qa3NrAmB8u8E/5Kfb5TJLORlMsHAcXE/LfAYJzWCO3czhNxJwSKifCyb9B3HDwru64G9
         fHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726197740; x=1726802540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkPkVDRD0OwFEuQUvV+n2s6XJ6GgG4bakHl8tALnG+0=;
        b=bN680D7NgRY5bnjdd0rg/m6H0nJpTkFrY24BHMfVd0KcuVTqG5kO4+bqReOb1Uwyn7
         Hx9Iu20juunrxtDD3Q/sLYY+yAx84/lCrqG5FwaLsx/004qkuOUXMShb/cp6Y3q0k/qM
         9JLb75FXrpG2QdD+El9wo5FnZFs9sToxC85aHsj3/YpyS2sS2yXimJXgcXkJ9PvTBr9H
         7lnE4S3VHMuh49hZy5HVV2Q2KCWCQ41PKiRn8bYvTWC0so9PK6mVEJoXQyjyMGxbYvCf
         p7okkw0qIvgl7fcPtTFVSTTUfvIXuXYr7I6qcFWF3G0bjYxFoOuigF+hdvQA6DVklFlo
         tJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCXYeasahe88TiH1Vzf6i6/sKoez0AUvLhf6AXTuqtAU7yDW89LFgSFb68jJdu5ILyu8bboGgFzCGaF12+/1hEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgk+0CxDIkxK7oTKLMqa2wnqQb0JSLanfUTyeZze3rIxKNRXS
	SO32g5pVzsQ8DbjfeuwQHNW2WfB7ZUUh5UV6ZciWZv5FzAB+b9QUU4LoW6lQqFU=
X-Google-Smtp-Source: AGHT+IEXdu7/jKSiLZPseTbEtvh8wm3jfCToFcsHiweT3cn9stVw7aGwEh7jPsLs5sXKDmpHC50qCg==
X-Received: by 2002:a05:6a21:9d91:b0:1c6:fbf3:a0ef with SMTP id adf61e73a8af0-1cf764c11e3mr7345712637.44.1726197740389;
        Thu, 12 Sep 2024 20:22:20 -0700 (PDT)
Received: from ghost ([2600:1010:b329:66c7:b074:429:f745:d035])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090b273asm5263978b3a.166.2024.09.12.20.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 20:22:19 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:22:15 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 2/2] selftests/mm: skip virtual_address_range tests on
 riscv
Message-ID: <ZuOv55YsorfvhlQi@ghost>
References: <20240913022635.751505-1-zhangchunyan@iscas.ac.cn>
 <20240913022635.751505-2-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913022635.751505-2-zhangchunyan@iscas.ac.cn>

On Fri, Sep 13, 2024 at 10:26:35AM +0800, Chunyan Zhang wrote:
> RISC-V doesn't currently have the behavior of restricting the virtual
> address space which virtual_address_range tests check, this will
> cause the tests fail. So lets disable the whole test suite for riscv64
> for now, not build it and run_vmtests.sh will skip it if it is not present.
> 
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>

Which tree does this apply onto? It is failing to apply on -rc7. Also,
since this is the second version of this patch it is good practice to
put v2 in the subject like [PATCH v2 2/2]. Anyways, the content of this
patch looks good!

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> ---
>  tools/testing/selftests/mm/Makefile       |  2 ++
>  tools/testing/selftests/mm/run_vmtests.sh | 10 ++++++----
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 84573ddfcfa2..912778347213 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -112,7 +112,9 @@ endif
>  
>  ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64))
>  TEST_GEN_FILES += va_high_addr_switch
> +ifneq ($(ARCH),riscv64)
>  TEST_GEN_FILES += virtual_address_range
> +endif
>  TEST_GEN_FILES += write_to_hugetlbfs
>  endif
>  
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 03ac4f2e1cce..7caa624a2e5a 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -347,10 +347,12 @@ if [ $VADDR64 -ne 0 ]; then
>  	# allows high virtual address allocation requests independent
>  	# of platform's physical memory.
>  
> -	prev_policy=$(cat /proc/sys/vm/overcommit_memory)
> -	echo 1 > /proc/sys/vm/overcommit_memory
> -	CATEGORY="hugevm" run_test ./virtual_address_range
> -	echo $prev_policy > /proc/sys/vm/overcommit_memory
> +	if [ -x ./virtual_address_range ]; then
> +		prev_policy=$(cat /proc/sys/vm/overcommit_memory)
> +		echo 1 > /proc/sys/vm/overcommit_memory
> +		CATEGORY="hugevm" run_test ./virtual_address_range
> +		echo $prev_policy > /proc/sys/vm/overcommit_memory
> +	fi
>  
>  	# va high address boundary switch test
>  	ARCH_ARM64="arm64"
> -- 
> 2.34.1
> 

