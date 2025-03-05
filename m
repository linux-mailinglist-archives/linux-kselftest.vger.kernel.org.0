Return-Path: <linux-kselftest+bounces-28346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA52BA50E25
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 22:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A6D1638A5
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 21:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61268263C6C;
	Wed,  5 Mar 2025 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QLRmIH4Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5A262D09
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 21:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211356; cv=none; b=FNG+mzdTNHA987Djl6vK1Zdm5ywqKq3ALF8uPAUGrlxXz/jLazGGLLb0CslQ6HQQEVMnAm6mDWq98pzCYOe6nUO0OWrMx7TUB8zSkfDXe84jcEyblKnXwv+L7LuC7cSEsEbjL0hT+bJZG65RLS0nwgT3c3iFOp9PqJRNIWjvEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211356; c=relaxed/simple;
	bh=EkMRTYZI41o9lStwnMlleZqWRQi6QzJ1U+G8jqGCdrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sA8Hm9Xt7Wwnn6QPVos49MkGBv7Zfvn6RzXIrXG1HgzFRcpeQHCn2aAYE8Oso5ju7qJ4BnH1er+hP67/D/L0RT6HKiQqqS0Hiflx4YQKA12+nxoKx0USBcWi/J3rFZXCnap8WHJAklx8nAIHQLOekyi7oNPpx5kPdd7ApRKbwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QLRmIH4Z; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223378e2b0dso107181545ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 13:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741211353; x=1741816153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kjoSc6E8cjM2Yo8eK5HFN8pI09NM2S8qt1nM/UlA0TU=;
        b=QLRmIH4ZyLWQJZ8hm6XZLv0qJLQEdiJTPx9Hq2QiLHxtHKnYkR3/SPXGrJMuyHnfD8
         CfprSDwYBHl/PkTQsJQPYzNWnZd3o7NkQTFPy2CL9CyPsZKR69QJzfrTkGOxSFtJRr2Z
         fjr1s7TkC2qID8oMeRsY6uXTmMd7pJVho1NttA040EfBbTrxHTIUO27b0HB75jZwolnr
         iaOFp4NZ4oTposwty3Lwa8QTW36UmsqFrUxupV9MH1H9aeuXhruV5y4TLiYSEAsK6ZSX
         JuRY5iHWcc6SP4l9bKnb1a3xWvmrywShXFj6QFf+lMDhf4v7+AchCGS1zKzl0o+34Vc3
         iXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741211353; x=1741816153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjoSc6E8cjM2Yo8eK5HFN8pI09NM2S8qt1nM/UlA0TU=;
        b=U5mpmMo19ZGtCqbjtdEhzS222jB373+vCdM84tDxkJN1HtNvfLoaNBZUhOO9J91GRY
         WMZgWHBjLqMGwRyaiEYHdgAHUvvQcBZkpKAWFswVBYMCYhL5vmhYRS/bSzNrrB8QAqFY
         DZU+Fzopveh093yGPPG3wAHPHAd1NTQlw7EN3nmn7fJOlm3bE+MWx5TOu+NxVQylp5pl
         1gO1R8iILM23N7TPmU7D2a4guoUjj3DEqBglOuunVKHYL6j9UDwCn+VE9HuC5JXAsO1l
         lMB/wnmInov62KhzuovCCdwfwNKLMMjKfPrG8BqfiZOnrTilzoAL45DaA/fqeEuDSH5U
         9Tvg==
X-Forwarded-Encrypted: i=1; AJvYcCUsmmgNoW/pEDTYw7iav1KtGrL5TT58yieGDXAgHAR9ETi4CQ0qAhR/fLLxWBBXM3JS6iuQtIxF5ClBK50mZPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLblyOlCjUFKarebpHmSJiBPRjbcXa3DgJ0jPWXwD6gT1eXath
	t1C1fDqaaHqiFA6ElElufh3mUdCbPb6N6geelCXn/aQJ1389Ek0wFxsW1bo7gjU=
X-Gm-Gg: ASbGnct09IOZiegeM9MxxXYRmSoJVD4qInnG4bOmfQhGlAOqIUmXNs1E5mGqHij4gcw
	YXmZdWubxTFWt3Lsy2ni3bvtqihlddHMl9c2JsL9lnzS9zobGSGk4RtfZ7SlOCFY/1ymVXgkr9V
	JUEuIYY9SYsNcbRm0AcWnZIayhAjj3Yixb+QzHSzkyve5zvvxqgFSBdm/3TWsujvnZmEd0hARqL
	bJ2MZIGo2huZSup8K4Mz+vxMmjUx8HKkIYP11aJBLMhVM3YT/KFNjzfh1Y0Yc13cvDb8KXE32PZ
	iJnr3VEK1eEi/GC11kWW6dCn7YLRzqLOL1DVLw1F
X-Google-Smtp-Source: AGHT+IGiq/MXIy1PesAIjd/q+Uj1GRVM25G7HYgqYDLVTQNdRiqv0JEG2/8H91arLf8HKxgXjRaCBg==
X-Received: by 2002:a17:902:f693:b0:220:ca08:8986 with SMTP id d9443c01a7336-223f1cdae3dmr83408555ad.22.1741211353117;
        Wed, 05 Mar 2025 13:49:13 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:9b3c:3246:a388:fe44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8fdsm117591535ad.76.2025.03.05.13.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:49:12 -0800 (PST)
Date: Wed, 5 Mar 2025 13:49:09 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: riscv: fix v_exec_initval_nolibc.c
Message-ID: <Z8jG1ViOUbw79cEN@ghost>
References: <20250305-fix-v_exec_initval_nolibc-v1-1-b87b60e43002@iencinas.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-fix-v_exec_initval_nolibc-v1-1-b87b60e43002@iencinas.com>

On Wed, Mar 05, 2025 at 05:39:28PM +0100, Ignacio Encinas wrote:
> Vector registers are zero initialized by the kernel. Stop accepting
> "all ones" as a clean value.
> 
> Note that this was not working as expected given that
> 	value == 0xff
> can be assumed to be always false by the compiler as value's range is
> [-128, 127]. Both GCC (-Wtype-limits) and clang
> (-Wtautological-constant-out-of-range-compare) warn about this.

This check was included because the "dirty" value is an implementation
detail that I believe is not strongly defined in the ABI. Since linux
does always set this value to zero (currently) we can safely remove this
check. 

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
> ---
> I tried looking why "all ones" was previously deemed a "clean" value but
> couldn't find any information. It looks like the kernel always 
> zero-initializes the vector registers.
> 
> If "all ones" is still acceptable for any reason, my intention is to 
> spin a v2 changing the types of `value` and `prev_value` to unsigned 
> char.
> ---
>  tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
> index 35c0812e32de0c82a54f84bd52c4272507121e35..b712c4d258a6cb045aa96de4a75299714866f5e6 100644
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
> @@ -46,7 +46,7 @@ int main(int argc, char **argv)
>  			: "=r" (value));					\
>  		if (first) {							\
>  			first = 0;						\
> -		} else if (value != prev_value || !(value == 0x00 || value == 0xff)) { \
> +		} else if (value != prev_value || value != 0x00) {              \
>  			printf("Register " __stringify(register)		\
>  				" values not clean! value: %u\n", value);	\
>  			exit(-1);						\
> 
> ---
> base-commit: 03d38806a902b36bf364cae8de6f1183c0a35a67
> change-id: 20250301-fix-v_exec_initval_nolibc-498d976c372d
> 
> Best regards,
> -- 
> Ignacio Encinas <ignacio@iencinas.com>
> 

