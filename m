Return-Path: <linux-kselftest+bounces-39787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0C5B32836
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 12:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9175E20FD
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 10:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D442441A0;
	Sat, 23 Aug 2025 10:29:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2026911185;
	Sat, 23 Aug 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755944949; cv=none; b=axjHipgz4+qAhQkQVID5sod7OspqAP1LMRWKRGbW8l3OmoMhLrgOwhMk9PlA4udoRGnLz/JOpYJYKsPsk5vy0PnssB+dZA0b/t0Tm8yei0rXzDsGWl1kFuX+fZYdNwll78+hYQfw98BT7mbha/0JR5sE39lr8JPEzYALA1EFXkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755944949; c=relaxed/simple;
	bh=slG1XMPNNk92C8/thr5dy8qgKIlLn5rTwYBH4I00VVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHQTAixnyvVMBcLocCutmV9mEyhVniXhZ+EpsD3J+S+Rz3w2ZtClEW0N4BNldtREk3ROxdJO5r3ByRdQcAhUmOxfGes8eh/cOCvRjYa313hvm9pC1/kOlBQVJ+aDpZhvWJwFIE6f6QmTSUMF9wkXgOKP9Q2bzHROnaILGHdiXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 57NAStdm021216;
	Sat, 23 Aug 2025 12:28:55 +0200
Date: Sat, 23 Aug 2025 12:28:55 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/7] tools/nolibc: reduce __nolibc_enosys() fallbacks
Message-ID: <20250823102855.GA21208@1wt.eu>
References: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Thu, Aug 21, 2025 at 05:40:31PM +0200, Thomas Weiﬂschuh wrote:
> The __nolibc_enosys() fallback is used when the UAPI headers do not
> provide a certain syscall number or any possible fallback syscall.
> This is either because the syscall definition is fairly new and nolibc
> tries to be compatible with old UAPI headers or an architecture does not
> support a syscall at all.
> Many of these __nolibc_enosys() fallbacks have become unnecessary.
> Either because the "new" syscalls or not so new anymore or real
> fallbacks have been implemented in the meantime.
> 
> Unnecessary usages of __nolibc_enosys() as it is not obvious anymore if
> a given function is really implemented on all architectures.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

OK I reviewed it all and it's fine for me. Please note in patch 1's
commit message, s/where added/were added/ :-)

For the whole series:
  Acked-by: Willy Tarreau <w@1wt.eu>

Thanks,
Willy

