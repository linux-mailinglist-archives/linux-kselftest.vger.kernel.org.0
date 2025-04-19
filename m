Return-Path: <linux-kselftest+bounces-31209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05121A94318
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 13:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252A917FE67
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 11:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2201D5165;
	Sat, 19 Apr 2025 11:31:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0C8189F3B;
	Sat, 19 Apr 2025 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745062264; cv=none; b=gMG/HAJdIHDZQeb6Av0rpkKBgKbb7GM3fhCI41t++lM/gurin2M8yi+WjEkeNRxm88DWa6hgEIRoOTJ2g43kvnhDRNuSazX075wkfjOT8nuy1AWygo56kepwCLgvaLRgcDh7xXtoKv9/Keq4gKSb1afswLvzZufX0awoOAsKH4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745062264; c=relaxed/simple;
	bh=aPT2QynEQAEe/C6i61qDLs88RHtWtsFhUOkdEaLX6M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppmzemB7aSQGVgtJVc+lTiC88ODlHO0o6sZEnn6Y3SrnY7IGfa8BU8s8DEo8jdF1W6c+RmbhSlapxA86R/Gxf4zRepLIzuHme1OCz8Y7F2AyjUlgDhQdYKpe5hAzULbIxuqSi1usd/oznNEGdF8F9OTjQ6iky4HgBnpSaSKRLhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 53JBUtcj002950;
	Sat, 19 Apr 2025 13:30:55 +0200
Date: Sat, 19 Apr 2025 13:30:55 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tools/nolibc: fix some undefined behaviour and
 enable UBSAN
Message-ID: <20250419113055.GA2932@1wt.eu>
References: <20250419-nolibc-ubsan-v2-0-060b8a016917@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250419-nolibc-ubsan-v2-0-060b8a016917@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Apr 19, 2025 at 12:46:17PM +0200, Thomas Weiﬂschuh wrote:
> Fix some issues uncovered by UBSAN and enable UBSAN for nolibc-test to
> avoid regressions.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Introduce and use __nolibc_aligned_as()
> - Reduce size of fixes to i{64,}toa_r()
> - Link to v1: https://lore.kernel.org/r/20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net

Wow that was a fast turn-around! Looks good. For the whole series:

  Acked-by: Willy Tarreau <w@1wt.eu>

Thank you Thomas!
Willy

