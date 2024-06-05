Return-Path: <linux-kselftest+bounces-11275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3EE8FDA15
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 00:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D781F249FE
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 22:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235E715FD1D;
	Wed,  5 Jun 2024 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0TQV0nVv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83902C153
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Jun 2024 22:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627951; cv=none; b=I3BcMPaP+5oL2YxW/2uvJdeAmsnZdVYwlZzdaZ3D6PO66PaaFWjyrr5RJ4bwwmCiYcajOqVqEYXVIjYhY8bLQc7x2Tdv19yamEdTiFQuZR06ldOeVBBB6wAg4dVXKitxKL5jpGyQsksVPsu5Qcfum4DuMimgTcCLd1Nu4/uqkSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627951; c=relaxed/simple;
	bh=0cwXZcxCdrSifwf2gN5a3Jk2vxotO1McJQe9I4GT33w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAQmCFwAbAabIY+rSi8bbJOcPQtryA4bOXJxG3RQ3NAF/J39/GhJ+5xD+RhDeKFvynWB6mca1mPz5YL7A/V44mC+CugifAdQPFW+VkAbVxCtlSWepLtFknlVDSTU9bzvUcpiI/zP68D1jf24YAsBLlDbwadwjrl6LICD9ebUdLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0TQV0nVv; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7eb41c9260dso17303439f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jun 2024 15:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717627949; x=1718232749; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YSDCArb6+iGdyUdtqqd9pStleb4MvKmGGngMGBUDMQA=;
        b=0TQV0nVvgn5hofYK1/x1fw40rnfd31W7fUoKze5PMgysPLu2vxMmRU404Vfos9gH/P
         1Xtc/1sI3WtVPrs3buN8eS2n4GnFRygCvg7YQmw7QHFX8A7NBsfh/1+mGkCkclwsSnhQ
         2h8pYtJ8bZoclrlm0HCDAISVNW5/vnoDphrPE04iW5m1NFSAzW7BSx2NPrWdYxFlKmc8
         AWmIoDbc6XDaK9bxlBBy1m1mhPLnpALDjfLu6S9Go+Zf7YDFYx7tCRQ5WN+D8Z8qBv5a
         c+6HLoX/J6NNI4f03xC2kf1PpPloM19x8FsjDpZZ3l7d+77QDQ5274Xa5Q/ZCwTSvOrj
         X6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717627949; x=1718232749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSDCArb6+iGdyUdtqqd9pStleb4MvKmGGngMGBUDMQA=;
        b=uPTvOAL6w1bII/toBxtUB3D1phZmHOX8d5SF/MDmYX5HGuWm45RBbk4fzGzXi1KQ6j
         HENJutimLoZo5GQSx/s4xk/1hohs5j/+uK23pVo/mrAoLsf9LTPMWSM6r6NDfxwiikLr
         nj725IddHAYZVbBsoXguBEiUII+nnWoX3zqwhIA9DrNAT0mbZweySysZFo303YylHU+N
         6cD6UsKiO6eduV0fYkb/QGmN7biF9k+fA8ZTSaRZQhllILT6tiIPPzxlXOblcMzzuARl
         O0T6uyvRZYDztUYue0ZoniqRyxyIbt/ZESLWdswYEJrkP1up6w/0lisE5t2D9aDzSu6K
         DAYw==
X-Forwarded-Encrypted: i=1; AJvYcCVjqAjZMw8cK4rGaEkuNMdq/7s/RJQnfwp10IJH/bE4z+ZI7xTWoQad0vf0C30WMqGoB93dUxAdVENfoBYSB9SDpUggCK9Nr1FsobSn0bNv
X-Gm-Message-State: AOJu0YzHOTfqAVbnNC6cYAgex4UtEWIxxbLrklpVORSs99WdaXxgLC+c
	6ekuAsUDcAeaq2AeSIaGlq+Ga8JkLkW3F7oE8yXzax7Fq6Tb2rZ0/B6SJ8cE3w==
X-Google-Smtp-Source: AGHT+IGzKiuu7Olg+ErkMrLVtXTStiQhWRPUfQmlopnZPzGP8VPYwj/Ku5f0IqDPhNz9a6uiFJwWyw==
X-Received: by 2002:a05:6e02:1fed:b0:374:9c23:a06a with SMTP id e9e14a558f8ab-374b1ee216fmr42265675ab.6.1717627948503;
        Wed, 05 Jun 2024 15:52:28 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de28f37482sm47423a12.94.2024.06.05.15.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 15:52:28 -0700 (PDT)
Date: Wed, 5 Jun 2024 22:52:24 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, llvm@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v1 2/2] selftests/mm: Guard defines from shm
Message-ID: <ZmDsKBrkh43-Zn8H@google.com>
References: <20240605223637.1374969-1-edliaw@google.com>
 <20240605223637.1374969-3-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605223637.1374969-3-edliaw@google.com>

On Wed, Jun 05, 2024 at 10:36:35PM +0000, Edward Liaw wrote:
> thuge-gen.c defines SHM_HUGE_* macros that are provided by the uapi
> since 4.14. These macros get redefined when compiling with Android's
> bionic because its sys/shm.h will import the uapi definitions.
> 
> However if linux/shm.h is included, with glibc, sys/shm.h will clash on
> some struct definitions:
> 
>   /usr/include/linux/shm.h:26:8: error: redefinition of ‘struct shmid_ds’
>      26 | struct shmid_ds {
>         |        ^~~~~~~~
>   In file included from /usr/include/x86_64-linux-gnu/bits/shm.h:45,
>                    from /usr/include/x86_64-linux-gnu/sys/shm.h:30:
>   /usr/include/x86_64-linux-gnu/bits/types/struct_shmid_ds.h:24:8: note: originally defined here
>      24 | struct shmid_ds
>         |        ^~~~~~~~

I also hit this issue while using bionic. I have a thread reporting this
issue here: https://lore.kernel.org/all/Zl4LC9lTNptB2xTJ@google.com/

According to Andi Kleen, glibc and others should add these defines in
their headers. So it make sense to me that we would need indefs to
prevent a redefine macro issue.

> 
> For now, guard the SHM_HUGE_* defines with ifndef to prevent
> redefinition warnings on Android bionic.
> 
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/mm/thuge-gen.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> index 034635317935..d50dc71cac32 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -34,10 +34,18 @@
>  #endif
>  
>  #define SHM_HUGETLB     04000   /* segment will use huge TLB pages */
> +#ifndef SHM_HUGE_SHIFT

nit: I see this file uses the form "#if !defined()" above for
MAP_HUGETLB. Perhaps it makes sense to use that and keep things
consistent? I'm fine either way.

Reviewed-by: Carlos Llamas <cmllamas@google.com>

>  #define SHM_HUGE_SHIFT  26
> +#endif
> +#ifndef SHM_HUGE_MASK
>  #define SHM_HUGE_MASK   0x3f
> +#endif
> +#ifndef SHM_HUGE_2MB
>  #define SHM_HUGE_2MB    (21 << SHM_HUGE_SHIFT)
> +#endif
> +#ifndef SHM_HUGE_1GB
>  #define SHM_HUGE_1GB    (30 << SHM_HUGE_SHIFT)
> +#endif
>  
>  #define NUM_PAGESIZES   5
>  #define NUM_PAGES 4
> -- 
> 2.45.1.467.gbab1589fc0-goog
> 


