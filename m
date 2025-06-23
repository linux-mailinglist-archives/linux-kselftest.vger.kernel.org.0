Return-Path: <linux-kselftest+bounces-35653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162C2AE51C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 23:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26614A478C
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 21:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491C92222C2;
	Mon, 23 Jun 2025 21:37:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175F519CC11;
	Mon, 23 Jun 2025 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714645; cv=none; b=jgXd1jrsaEP4JTV5sXN38mPSVBxBxXxnLl1SO+FBcRDjxqdQ4UiIvQdbBuQsg7UjUt9erQFINfK/b3DVCBurLazomCWOsZYAid8GHoM4Og9Ww32rnh4LOquaV3Hi11GpMcKCrOqk0bRfDolKSoGj0W1maDn5bHZiFVAUjknF/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714645; c=relaxed/simple;
	bh=DcfKfCLm2YVcIZgp/Vd7WjWZEebMG/m2XBkZBGoUiDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPfMF01T3hCAsF5uju96xF5STmCS7Ekvlvsd6ivpgD26j5gWO2vi375uHvFCwu5ZSoDmEOTCfKh/JAjgY13j2L8BBmKQECUwKMHHh2tA4Um6d322jw+5dTZSAdzrwfiJ653CsPoIgJs0miAj7IgEc65cuzPV/Og8IOUJ6mvYEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 55NLbCtB030370;
	Mon, 23 Jun 2025 23:37:12 +0200
Date: Mon, 23 Jun 2025 23:37:12 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Rodrigo Campos <rodrigo@sdfg.com.ar>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: avoid GCC 15
 -Wunterminated-string-initialization
Message-ID: <20250623213712.GA30367@1wt.eu>
References: <20250623-nolibc-nonstring-v1-1-11282204766a@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623-nolibc-nonstring-v1-1-11282204766a@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jun 23, 2025 at 11:34:32PM +0200, Thomas Weiﬂschuh wrote:
> On GCC 15 the following warnings is emitted:
> 
> nolibc-test.c: In function 'run_stdlib':
> nolibc-test.c:1416:32: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (11 chars into 10 available) [-Wunterminated-string-initialization]
>  1416 |                 char buf[10] = "test123456";
>       |                                ^~~~~~~~~~~~
> 
> Increase the size of buf to avoid the warning.
> 
> It would also be possible to use __attribute__((nonstring)) but that
> would require some ifdeffery to work with older compilers.

I agree with you, that's not an important enough fight to spend time
on :-)

> Fixes: 1063649cf531 ("selftests/nolibc: Add tests for strlcat() and strlcpy()")
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Willy Tarreau <w@1wt.eu>

willy

