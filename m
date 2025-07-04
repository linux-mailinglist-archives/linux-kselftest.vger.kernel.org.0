Return-Path: <linux-kselftest+bounces-36544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6794AF918B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C8B1CA4C10
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23952C15B3;
	Fri,  4 Jul 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rhE5MU9C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF882C15AE;
	Fri,  4 Jul 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751628459; cv=none; b=K3sRgGwxkE1ulahD/cZOVhAl4BCPZfAk81wkaGtAnaxZI1e4xxDUqMacH84WLqacYUqphG9//NmVaU2WvgpOAfU1IyrNC2RoUTOGSiWLG5M/fihH9ztsca3LVJvM/qGqffVj8cBLnWwP7+wCB9G59i4MV7ozU/Eii/ML0LY77A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751628459; c=relaxed/simple;
	bh=t3/010+HIox3JcYzNG1vFfxeAMvyLUTNHCTRTUHcYI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th45zGvbh5RYq11tLNLAKxsEM8U3Kwe+BGgaK77UJsHxDYo0Xqu3rTwwPzSn+5fvGKjw5b2oBbIJgepNI0Djr/ISU/ZyGMSx1GmjbDIz168CwILYtByAkBLRCyStRTgb8lNH9mILS+ien+X0G4kCewGx9r5pDUoBZfOm1XBBw30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rhE5MU9C; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1751628455;
	bh=t3/010+HIox3JcYzNG1vFfxeAMvyLUTNHCTRTUHcYI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rhE5MU9C4JMbn2IuFIChkriZ9OjuVEsKflh0Ab57PM34Bxis505hH1WSc60KxFhGC
	 N2b39HaX2lDEnVWdo/pCozB1WW/mrZRfEbrf3CV1yff0MsfJ8VMZs4/klEzeG0oNhu
	 xaVgVm7N2JeuQ2s/VlIndFiCzt9Ajs2pIeHOxWlY=
Date: Fri, 4 Jul 2025 13:27:28 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Brown <broonie@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Christian Brauner <brauner@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] kselftest/arm64: Add coverage for the interaction
 of vfork() and GCS
Message-ID: <f438fc60-e602-4301-a7dd-bee43c020720@t-8ch.de>
References: <20250703-arm64-gcs-vfork-exit-v3-0-1e9a9d2ddbbe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-arm64-gcs-vfork-exit-v3-0-1e9a9d2ddbbe@kernel.org>

On 2025-07-03 17:00:14+0100, Mark Brown wrote:
> I had cause to look at the vfork() support for GCS and realised that we
> don't have any direct test coverage, this series does so by adding
> vfork() to nolibc and then using that in basic-gcs to provide some
> simple vfork() coverage.

Thanks. I applied the patches, but moved the arm64 selftest patch to be
the last one.

FYI nolibc now has a proper prctl() implementation you might want to use.
Also your vfork() selftest uncovered a bug in the brandnew SuperH support.

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v3:
> - Stylistic nits in the GCS vfork() test.
> - SPARC has a non-standard vfork() ABI which needs handling.
> - Link to v2: https://lore.kernel.org/r/20250610-arm64-gcs-vfork-exit-v2-0-929443dfcf82@kernel.org
> 
> Changes in v2:
> - Add replacement of ifdef with if defined() in nolibc since the code
>   doesn't reflect the coding style.
> - Remove check for arch specific vfork().
> - Link to v1: https://lore.kernel.org/r/20250609-arm64-gcs-vfork-exit-v1-0-baad0f085747@kernel.org
> 
> ---
> Mark Brown (4):
>       tools/nolibc: Replace ifdef with if defined() in sys.h
>       tools/nolibc: Provide vfork()
>       kselftest/arm64: Add a test for vfork() with GCS
>       selftests/nolibc: Add coverage of vfork()
> 
>  tools/include/nolibc/arch-sparc.h             | 16 +++++++
>  tools/include/nolibc/sys.h                    | 59 ++++++++++++++++++-------
>  tools/testing/selftests/arm64/gcs/basic-gcs.c | 63 +++++++++++++++++++++++++++
>  tools/testing/selftests/nolibc/nolibc-test.c  | 23 ++++++++--
>  4 files changed, 142 insertions(+), 19 deletions(-)
> ---
> base-commit: 86731a2a651e58953fc949573895f2fa6d456841
> change-id: 20250528-arm64-gcs-vfork-exit-4a7daf7652ee
> 
> Best regards,
> --  
> Mark Brown <broonie@kernel.org>
> 

