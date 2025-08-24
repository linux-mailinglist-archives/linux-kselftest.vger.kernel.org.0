Return-Path: <linux-kselftest+bounces-39802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C17B32DD1
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 08:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BD84831CD
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 06:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F6423D2A3;
	Sun, 24 Aug 2025 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM0+Xttm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E573419CCEC;
	Sun, 24 Aug 2025 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756018412; cv=none; b=Ilps86Pc1hSpQBAt4OhaEuJNg1ud+akowkILJFuAjA9Vm/CmvXMpcaZTfUGW9nrSfwB94bxPcay1Wc/Q9F5MlrSrSvxmRVdlL8Be6iGF2En3yxZNknwplebNynUoisoR6ZcXSkgfjgjH/5Q7i3p7NuO0JwBq9PdzUbLZkKjFWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756018412; c=relaxed/simple;
	bh=opYPibA2Sr9YIXZopgqov/R7HF/4sfaIh3TYnZ6b6/M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsrgT87jXo33ni+c5DkyCOcDwqk9X+EfgMaYPIr4/R1WThpIGc7JcYYUwKtSRfZkOU8eo6Gk/+e+HX6Xb1U3jyV28p0IYg7bJ/zFlWMtWKS1BiGwtfIl7pbusW7M1W7auwX7xrcwZIfmeI762sRd41GtV6rj640dIqh7CeEgthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM0+Xttm; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f3ec52a42so639503e87.1;
        Sat, 23 Aug 2025 23:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756018409; x=1756623209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/bXdnPZsdYDL296YXs8gclNDn06nl0Bznj+TQgOZaAc=;
        b=VM0+Xttm/Ux/gq6jtrgL86Gx4XtYGNborDePF3lia13G1qJAXELS3fXhqoYhN17s0a
         9zQ1oZjJjz9tla0MjHoMPkKWIdmFnODrH2lL1dMxoRP5fGv7eweG0v7vVZnMXGJYlfRr
         NSqqc+cce/dJodzqCMXG8MwFE7EvCkcfX9nYLDhXf+DsQcwMM1fCF2yBqBdxQY0drP1x
         emDpa2Fr/VaX27N+z7H+VJOd6j8jTT7Esv8Or/v/mQtPR4i+HggqKWw6MGz8puykbIf7
         KvmPIFKQJ3qH6aSmQRyQjAZdkuu2EutFCIGy1H76eStCRxN+heOrbyvTQz/GKXx365+e
         vC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756018409; x=1756623209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bXdnPZsdYDL296YXs8gclNDn06nl0Bznj+TQgOZaAc=;
        b=g2PYNwLMdtC6gndEUBb20oqiu/ho4Z8nhXjrkCjqB5rfLVYqlSLyC5AY7C30DuxgQi
         LprBA2CY3ahoBPILtITUNe0XPo6sSFUi9ghVU7fpqibI/CPWPEgGVF8yL2zaUZMdfKAn
         VFaQ5wct2LCxEogSfkXHkDFOjeLg2OzCvOYdwQBUEYfQG8nYxesH2pzPn/6xp1QPov09
         T48HF8lfkFolmW5szwMgwCj8EDZfJgGBiLQl2qL7jfjq5Dbk4aiciRS3HwbanXFvCBx7
         wwhWEwCsCawjPi20BO2fjBdUyRTfQaK8Ywq22XwO4Mm2NHmDosQoHTUqovLbJ0/e9W6l
         n5cA==
X-Forwarded-Encrypted: i=1; AJvYcCWowF17Htr5glN5yRkehoUsQ9+WIZMdrvsUHoWyUQNBIGmXBlf0tG7Aoin7D4U6woGt6M/ReQkNkBOeXoEB/FI5@vger.kernel.org, AJvYcCXQmhtSC9f6d2eFcx3t1bOdywz6QyWf4HRVH82KeakUyumqywTCMGdJ5ARICL8EMHUQeQmpBivNaEg5hTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWsp3dKUVqGkOwQBUNonbWfZq0puKhjAsJ9KRXRdcNhfC65hZS
	tSRZiCZpDDm3GACvuI314T7A5p8NyOXyMG3xgwchPX9RwOSs0eye0RTVbP6Nnw==
X-Gm-Gg: ASbGncuNnLtiwCBmHAMdw/NoZ0e56VVRH/PC/cIJr8V63gIzZrsQ8hZa1HO3EbMnI4X
	LG7N1rq2weDxkdMwHJEx1g3g0pafRKMhKMnZdAw1JPUy/GuRJA5RN1CZWlDZLhEbpkdY4FSgpw8
	yDactxN5yrW52SHm+OrcVX8YgUGe6GI5g5ZvXTaD/1GOZz7vyNJWhIJwD/NEx8vA2Wr6EmAgJWd
	Mq73WFFnYK5CkeNCqYJ+j/RQ6j9yUhp1cTq6gH83F73LGbFy/uBViOxh1G7Sw2kg3KizcI+EUe1
	EB+EgSoaF2GvD2mgZsxNQWNxBPDJJf/vXE3QHZCD3TTAjiumdkJyXkxFBzqkY2BI
X-Google-Smtp-Source: AGHT+IH/HPvnrblsXaSYujeCUTXfUVCuyyVcsNVaDSTH8D8zOs9u2C0kscdWCGCLeYgjhPWllLFAgA==
X-Received: by 2002:a05:6512:150b:20b0:55b:8aa7:4c1e with SMTP id 2adb3069b0e04-55f0ccfdfcamr1678570e87.53.1756018408643;
        Sat, 23 Aug 2025 23:53:28 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c8bb59sm902838e87.91.2025.08.23.23.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 23:53:28 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sun, 24 Aug 2025 08:53:26 +0200
To: ally heev <allyheev@gmail.com>
Cc: skhan@linuxfoundation.org, akpm@linux-foundation.org, david@redhat.com,
	shuah@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest: mm: fix typos in test_vmalloc.sh
Message-ID: <aKq25rlqbyYDaWVo@pc636>
References: <20250823170208.184149-1-allyheev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823170208.184149-1-allyheev@gmail.com>

On Sat, Aug 23, 2025 at 10:32:08PM +0530, ally heev wrote:
> Signed-off-by: ally heev <allyheev@gmail.com>
> ---
>  tools/testing/selftests/mm/test_vmalloc.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/test_vmalloc.sh b/tools/testing/selftests/mm/test_vmalloc.sh
> index d73b846736f1..d39096723fca 100755
> --- a/tools/testing/selftests/mm/test_vmalloc.sh
> +++ b/tools/testing/selftests/mm/test_vmalloc.sh
> @@ -47,14 +47,14 @@ check_test_requirements()
>  	fi
>  }
>  
> -run_perfformance_check()
> +run_performance_check()
>  {
>  	echo "Run performance tests to evaluate how fast vmalloc allocation is."
>  	echo "It runs all test cases on one single CPU with sequential order."
>  
>  	modprobe $DRIVER $PERF_PARAM > /dev/null 2>&1
>  	echo "Done."
> -	echo "Ccheck the kernel message buffer to see the summary."
> +	echo "Check the kernel message buffer to see the summary."
>  }
>  
>  run_stability_check()
> @@ -160,7 +160,7 @@ function run_test()
>  		usage
>  	else
>  		if [[ "$1" = "performance" ]]; then
> -			run_perfformance_check
> +			run_performance_check
>  		elif [[ "$1" = "stress" ]]; then
>  			run_stability_check
>  		elif [[ "$1" = "smoke" ]]; then
> -- 
> 2.34.1
> 
> 
./scripts/checkpatch.pl ./0001-kselftest-mm-fix-typos-in-test_vmalloc.sh.patch
WARNING: Missing commit description - Add an appropriate one

total: 0 errors, 1 warnings, 24 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

./0001-kselftest-mm-fix-typos-in-test_vmalloc.sh.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Can you add a commit message?

Thank you!

--
Uladzislau Rezki

