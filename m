Return-Path: <linux-kselftest+bounces-25506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9FDA2481A
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 11:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903BC162060
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 10:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C96E5FEE6;
	Sat,  1 Feb 2025 10:04:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFC425761;
	Sat,  1 Feb 2025 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738404246; cv=none; b=ZRkEohOac5R2vL69KV90X5lMBsHdcBKyqhd7AZAp3v1bO7nClsSiyc2aBFUc5UzEH44Wh1x93hDmVuo8yWdlUJZSrKhF4Hu/zN8MQg6gW6fALKH+sr6W+XnPxwEPDD8Ni3NxHP4xdU1ht7CA3tKsIV6cT6aOa7FGUYPK7hX8k9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738404246; c=relaxed/simple;
	bh=P8rs2CA/Um4iKZuxR479kyWFRvJoBzjiUdjh7wnFCcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARDbdjIVTHsbjkMABmnUuKwvGPUg86by3JnRPIHVS5mrN1dBvH/KX5iMpAwTPIFgbn6z2s4aslBoXIbyPlq5IIBdkruMQoOGEyC7Ppb4Jl78Ieo3GEd6jQnEh2L5mfYAxxMlR6cjfU8ajhhYBkuXveoH01FafjqbrhBd3A/lHDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 511A3h49006005;
	Sat, 1 Feb 2025 11:03:43 +0100
Date: Sat, 1 Feb 2025 11:03:43 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] selftests/nolibc: drop call to prepare target
Message-ID: <20250201100343.GA5849@1wt.eu>
References: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
 <20250123-nolibc-config-v2-2-5701c35995d6@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123-nolibc-config-v2-2-5701c35995d6@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jan 23, 2025 at 08:37:38AM +0100, Thomas Weiﬂschuh wrote:
> The "prepare" target does not need to be run manually.
> kbuild knows when to use it on its own and the target is not even
> documented.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index ba044c8a042ce345ff90bdd35569de4b5acd117d..464165e3d9175d283ec0ed14765df29427b6de38 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -261,7 +261,7 @@ initramfs: nolibc-test
>  	$(Q)cp nolibc-test initramfs/init
>  
>  defconfig:
> -	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
> +	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG)

I'm pretty sure that in the past I had to manually do it for certain
rebuilds (out of the nolibc-test context), but I cannot say for sure
when, but I did definitely discover it when trying to fix some build
issues. It's very possible that the issues that it used to fix have
long been fixed and that it remained in fingers memory, so I'm fine
with dropping it and we'll see. If we ever discover we need to bring
it back, at least we'll explain why in a commit message this time.

Acked-by: Willy Tarreau <w@1wt.eu>

Willy

