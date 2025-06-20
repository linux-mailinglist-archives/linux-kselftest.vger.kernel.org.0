Return-Path: <linux-kselftest+bounces-35408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A82AE1534
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA9AF7AA6C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 07:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F3622D797;
	Fri, 20 Jun 2025 07:48:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FB722D4D7;
	Fri, 20 Jun 2025 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405688; cv=none; b=WwbZ+a2x5nZ8fYDDr3TJEMCnlsiEz3GYdAKHPjVsU4kdwn4x2OzyOrDlt6Y1xuLg6uVlAQX24sr2Cd2d/a5iEiZe4jiSYzwEdYhG6+lOHSft8qJlxfvRfZRs2EaFB++nFTfAlQdeJxn9wfPvxliXCZDf+PUHEsBWiTT2DXDiK2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405688; c=relaxed/simple;
	bh=K/9E0Rna/8vdvK/ihc4HMC8NaJSoKS4B1swdubMU4iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PN0fTX/IgE8EmWyUz10MkCJsykmMUXwgcTjOdWGfZfX930dOLxbjE9pJJeuGoH0t3v/j80ZGR/bNxMyQmZ/A24dwZDq6o6er93m+X57puW+U37fSDXShM+uB023ztDEFpCABFCLnYPT6vrhCW5q93sDC1rvhe7vCRi2OHZexPEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 55K7em13022553;
	Fri, 20 Jun 2025 09:40:48 +0200
Date: Fri, 20 Jun 2025 09:40:48 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: make stackprotector probing more robust
Message-ID: <20250620074048.GA22550@1wt.eu>
References: <20250609-nolibc-stackprotector-robust-v1-1-a1cfc92a568a@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-nolibc-stackprotector-robust-v1-1-a1cfc92a568a@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jun 09, 2025 at 09:39:16AM +0200, Thomas Weiﬂschuh wrote:
> nolibc only supports symbol-based stackprotectors, based on the global
> variable __stack_chk_guard. Support for this differs between
> architectures and toolchains. Some use the symbol mode by default, some
> require a flag to enable it and some don't support it at all.
> 
> Before the nolibc test Makefile required the availability of
> "-mstack-protector-guard=global" to enable stackprotectors.
> While this flag makes sure that the correct mode is available it doesn't
> work where the correct mode is the only supported one and therefore the
> flag is not implemented.
> 
> Switch to a more dynamic probing mechanism.
> This correctly enables stack protectors for mips, loongarch and m68k.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
(...)

Acked-by: Willy Tarreau <w@1wt.eu>

Willy

