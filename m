Return-Path: <linux-kselftest+bounces-18563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0C398999C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 05:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3A11C20FFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 03:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F6F1F5EA;
	Mon, 30 Sep 2024 03:50:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3535A1878;
	Mon, 30 Sep 2024 03:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727668200; cv=none; b=uK/KLNAut8+Uok76TXf5pIDeWfrbgo3tUe7MZJ2hYOENpjNWRX10RvTWN7ewVmM5/FuLbvtYYFFV0aG5ymRSb5L2XrSupM58z68T1S5A5ORhX/gXy355qrwLgY20rGPY8Il5stagWm5P1ekpAbGQZSRWU5PBtBZv6MUeINwzZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727668200; c=relaxed/simple;
	bh=csPcHVQHvBvl68tXieUjtZxzQSNZqNLqUC+nsW49kPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5tEGNkonGVZpkobh5UtFqRGQteqQEqSwiS0jPiepLgC6HnaQ6vgtntCPaCTtkRJW2g+va5cO1qfSFDoEkjPhiBVNLzPBZca3Pr4aNS+xkWVeMUFoqAceBA4sUiMsPVcZreA63C+m9CvS2gwaXPFWrWtv8hRaEqhRVKurOqhndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 48U3nkO1018157;
	Mon, 30 Sep 2024 05:49:46 +0200
Date: Mon, 30 Sep 2024 05:49:46 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Guo Ren <guoren@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/5] tools/nolibc: add csky support
Message-ID: <20240930034946.GB13730@1wt.eu>
References: <20240929-nolibc-csky-v1-0-bb28031a73b0@weissschuh.net>
 <20240929-nolibc-csky-v1-4-bb28031a73b0@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240929-nolibc-csky-v1-4-bb28031a73b0@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Sun, Sep 29, 2024 at 11:47:39PM +0200, Thomas Weißschuh wrote:
> Add support for the C-SKY architecture, which is very similar to
> LoongArch.
> Only v2 ABI is supported.
> Optimizations are disabled as the compiler[0] seems to misoptimize the
> code, especially the r4 register gets clobbered.
> Compile the initramfs directly into the kernel, as qemu does not support
> passing the initrd via OF.
> 
> There is no qemu mainline support for qemu.
> Testing was done with commit 1f172a2c7cd5c2e7 of the downstream csky qemu [1].
> Some tiny changes were necessary on top [2].
> 
> [0] gcc 13.2.0 and 14.2.0 from kernel.org crosstools
> [1] https://github.com/XUANTIE-RV/qemu/
> [2]

I think you wanted to place a link or something above for [2].

> diff --git a/target/csky/cpu-param.h b/target/csky/cpu-param.h
> index 80554cc0fc03..9181b602a26f 100644
> --- a/target/csky/cpu-param.h
> +++ b/target/csky/cpu-param.h
(...)
> diff --git a/target/csky/op_vdsp2.c b/target/csky/op_vdsp2.c
> index a9985a03be33..d953f5ea94fe 100644
> --- a/target/csky/op_vdsp2.c
> +++ b/target/csky/op_vdsp2.c

Also, the first two patches look like fixes for the arch itself, they
should really go outside of the nolibc development tree, at least
because they might have to be backported to some stable branches,
or later fixed/reverted in case they wouldn't be optimal.

Aside this, it's been a long time since we last added an architecture
and it's pleasant to see how easy it has become over time, even when
requiring specific settings ;-)

Cheers,
Willy

