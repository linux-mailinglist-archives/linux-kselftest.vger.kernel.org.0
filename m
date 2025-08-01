Return-Path: <linux-kselftest+bounces-38192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C068B18915
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 00:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983F016BC24
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 22:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31704217F35;
	Fri,  1 Aug 2025 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OE8yYfkl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146B2E630;
	Fri,  1 Aug 2025 22:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085747; cv=none; b=Bpu0/5+FzraLtxLUKgy11xMvxW1wRsl6MP/PzGgllICE6WmseAtG1n+L+sE9B7Y62U2WP/6gle8vksabFijvqmY2ICMokIqcpMLWzia+Cp2tGDz7WOt/x1o8x0OW3ql7IM4Ss0bqCdzL31AQtNerogbEkdjLH/UEizLnDPeeaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085747; c=relaxed/simple;
	bh=4F6coz0MQMZE0I8tpxLsayuZ26sod/oOCtXdM8eyugE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kLkqgolNcpTL/48Ycyhu2J9UD9D7cpsayYJQCnU3wbRbQUDitYUgs3eBqMKX8pYasfY7b0xWGICMtdFO8WR6CTDkIdcL6/cxq7+PEPOhGDprKRWLhwoMiLh1wdTCc4xgfEErodYpAa8UA9MWO8HF+CuCfyn6/yFZJFXt39v+PuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OE8yYfkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E024C4CEE7;
	Fri,  1 Aug 2025 22:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754085746;
	bh=4F6coz0MQMZE0I8tpxLsayuZ26sod/oOCtXdM8eyugE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OE8yYfkltKGteePz9G6PQt3VxFdg6L088voeIglN9qAsQFxrfGJnCXKjV3w1PhX+h
	 sxPtJ+WjjTLeAl3/ZOpip4gQT7E0Ei88WWhjaqaYOfHJZBF4DQ/vA7BV9jdpqc+g5j
	 7vljBY63yUCgmmA3MXQ/5ZB68kH/esIk5rMvsRuE=
Date: Fri, 1 Aug 2025 15:02:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: Fix typos and improve output messages
Message-Id: <20250801150225.2f32b042735d68f8aec203a5@linux-foundation.org>
In-Reply-To: <20250731000251.5412-1-swarajgaikwad1925@gmail.com>
References: <20250731000251.5412-1-swarajgaikwad1925@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Jul 2025 00:02:51 +0000 Swaraj Gaikwad <swarajgaikwad1925@gmail.com> wrote:

> From: Swaraj-1925 <swarajgaikwad1925@gmail.com>

We prefer that real names be used, please.

> Fixed spelling and grammar issues in test output messages
> to improve readability.
> 
> Signed-off-by: swarajgaikwad1925@gmail.com

Ditto.

> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -48,10 +48,10 @@ ifneq (,$(wildcard $(KDIR)/Module.symvers))
>  ifneq (,$(wildcard $(KDIR)/include/linux/page_frag_cache.h))
>  TEST_GEN_MODS_DIR := page_frag
>  else
> -PAGE_FRAG_WARNING = "missing page_frag_cache.h, please use a newer kernel"
> +PAGE_FRAG_WARNING = "Missing page_frag_cache.h, Please use a newer kernel"

A capital letter after a comma is incorrect.

>  endif
>  else
> -PAGE_FRAG_WARNING = "missing Module.symvers, please have the kernel built first"
> +PAGE_FRAG_WARNING = "Missing Module.symvers, Please build the kernel first"
>  endif
>  
>  TEST_GEN_FILES = cow
> @@ -202,8 +202,8 @@ ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),01)
>  all: warn_32bit_failure
>  
>  warn_32bit_failure:
> -	@echo "Warning: you seem to have a broken 32-bit build" 2>&1;		\
> -	echo  "environment. This will reduce test coverage of 64-bit" 2>&1;	\
> +	@echo "Warning: you seem to have a broken 32-bit build environment." 2>&1;		\
> +	echo  "This will reduce test coverage of 64-bit" 2>&1;	\
>  	echo  "kernels. If you are using a Debian-like distribution," 2>&1;	\
>  	echo  "try:"; 2>&1;							\
>  	echo  "";								\

Overall, this patch is hitting the too-trivial-to-merge threshold, sorry.

