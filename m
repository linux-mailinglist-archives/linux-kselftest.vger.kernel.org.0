Return-Path: <linux-kselftest+bounces-3724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153E3841810
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 02:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4779B1C212D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA5F1DFD9;
	Tue, 30 Jan 2024 01:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4gNubVh4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B9F3611D
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 01:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706576549; cv=none; b=jlPCxuPFHZ9ViDY3D12za8jsNHra0LrgKbgImHm0G+y2Wfb/TOqB/EuQSVxlnui5ubvQtFuNGwVwh0JHBjkmDIpW5qsOkVRfhtnrQ0Si8vMzAPNsg7tXdCoRxxTr3e8wRNGM3bxZsf3vd9zxrELnUo7aEtfWRCcnWc5+GGKGKj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706576549; c=relaxed/simple;
	bh=eQQVzNpyQ4k5C+OR/TJK6umpga8oG0wdB6/rTvPba3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KeS0L5qErPeks4xWVJ3NdFYkQwNudMN0tAbYcbU7n4aMHT1ro4cdWX2NmkypgAoxBINyzQHa/GKEb0XUxo54/oWW4pmlNsaPS4FyM87JxEo9jwzl5HkRhIMpSfOlvwIgqMBdv8sP5dLETfy1/Vopt5Whc8sxI3950cPCR1tADCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4gNubVh4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6533e4274so5936472276.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 17:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706576546; x=1707181346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZSrdH5I7u0zNwSNWZORF6UyHmXuWHBABDMeAreYwGg=;
        b=4gNubVh4qRFO+lhGWbIuVgh5rnqbJRuGzjjRSX7xmZVcszTSU32INZingPc31W6b/p
         OghHyj7zOAgQMgavQPFkEgSKxMIADtV8vRyaS8UnCeoTU2wDBK0JCQ5hVjPoPh/L4Ycz
         +sJVn309MBFmhmtjiTHwvu37afaZ1PcsWEIKZ92zQDv+p3PGP9oTdKC2butNLMOWsRDB
         YAr2kQlqe9tPBU7yoOYRGaujI3bpIX59FZoifRSbTs58dFTymPu6MimQnNIGkSgOV551
         clk6qfEe708stggE0XnDWmc9a8fxuxZHTLaWs6rFMGSjD2FzgRGTRwxMMxPot/lEtVAa
         IliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706576546; x=1707181346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZSrdH5I7u0zNwSNWZORF6UyHmXuWHBABDMeAreYwGg=;
        b=CIavv7VU+aBFK7i42z203ZDGzLZzkkK7RliYlkFS631eSkuQIYO9QUTWFH0zS9H37P
         EJ7vjHHDrVeq8rtGh/VVlAzaZdMSMDMt3U29DjYGGxrpcJalzA9RS1tttT16sNtBaivj
         yMcNv7i27s5EJPUnLu9cIvuPaEm7SjPOm6EsnWf4LB0cmOiF/DDpr6ryImJc5Ixg2lFE
         Odzpe3kH6PED4TsEO0Bf8/MgmBj5Z6vvWZhGh4GyPCLPipCbqPWwMecsehfDz2dRH+Rx
         z5MrhTIajCuKL8XHMmJ2D5SSRH53usnq2H6y1VGolo0JNv4yyf7N5Lz/2wdacSWOEH/g
         zZCQ==
X-Gm-Message-State: AOJu0YxHbDew2hvOYBbvXXm0vXlRCrgOVhwkETIiv2/QlM2hkKASWk/u
	RWTree7TnehVOu0kLtAND7NVtSH9EE3fI+YHvEEks6XD7pO7Wojkad7/zSi4E8DgeaSG+Q0miVA
	R5Y0OwS3N738hKoZu/Q==
X-Google-Smtp-Source: AGHT+IE9Mh60TagYwcbyXda/9IpvEZ5n8YwuyQK5UTl98rhZse04NPXV79Dk78e5oca4DqkUwxuVBrGZG2ciKDSn
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2405:b0:dc2:6501:f42 with SMTP
 id dr5-20020a056902240500b00dc265010f42mr2482352ybb.5.1706576546597; Mon, 29
 Jan 2024 17:02:26 -0800 (PST)
Date: Tue, 30 Jan 2024 01:02:24 +0000
In-Reply-To: <20240129224542.162599-2-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129224542.162599-1-nphamcs@gmail.com> <20240129224542.162599-2-nphamcs@gmail.com>
Message-ID: <ZbhKoJ5BcP_RhMt4@google.com>
Subject: Re: [PATCH 1/3] selftests: zswap: add zswap selftest file to zswap
 maintainer entry
From: Yosry Ahmed <yosryahmed@google.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, hannes@cmpxchg.org, 
	tj@kernel.org, lizefan.x@bytedance.com, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 29, 2024 at 02:45:40PM -0800, Nhat Pham wrote:
> Make it easier for contributors to find the zswap maintainers when they
> update the zswap tests.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

I guess I had to check the zswap tests at some point :)

Acked-by: Yosry Ahmed <yosryahmed@google.com> 

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fecebfc4c0dc..5f60faaefaf2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24396,6 +24396,7 @@ F:	include/linux/zpool.h
>  F:	include/linux/zswap.h
>  F:	mm/zpool.c
>  F:	mm/zswap.c
> +F:	tools/testing/selftests/cgroup/test_zswap.c
>  
>  THE REST
>  M:	Linus Torvalds <torvalds@linux-foundation.org>
> -- 
> 2.39.3
> 

