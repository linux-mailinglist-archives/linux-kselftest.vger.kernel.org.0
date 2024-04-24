Return-Path: <linux-kselftest+bounces-8756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C308B010F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 07:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704541C22376
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 05:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D174D155385;
	Wed, 24 Apr 2024 05:32:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615B9154BFC;
	Wed, 24 Apr 2024 05:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936736; cv=none; b=MY1bTVX/TvYCYNSWnWpGM9o9wqTXgqfRPs6JtEPkZxxqb7m9xZhMSiB+as9EqEi4p6RdQlvvQCB/QXHTo+wcErLNS+i3Mm0bSBBu/1PpRJHX64jydUU5VxQ/Y+zpxShcbM6IPLY7SweDV6QL4z/vBdnR0mhD5m/utcf7nJsTAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936736; c=relaxed/simple;
	bh=BuZoLx40bHCv2miu1sHKyO/TAtq8OnTW87eDVfAAQs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/ci0BxuHt5EMU2oUKcOpcZglBmzqbKE4YkDQAUeWGo/NygvCi3wx9PMK9qrH+NSGjYS2RC2fhvSljymdHqskx5uSabTi7vrrSbfxbMqwbJ+Y112dWgPVmc+UemOqrehaOyl+iUmtWw9EPMynOvOO43Bd47R4KBenkLF+bsUdZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 43O5W71c030680;
	Wed, 24 Apr 2024 07:32:07 +0200
Date: Wed, 24 Apr 2024 07:32:07 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: run-tests.sh: use -Werror by default
Message-ID: <ZiiZV0oZNUAsB1s+@1wt.eu>
References: <20240423-nolibc-werror-v1-1-e6f0bd66eb45@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423-nolibc-werror-v1-1-e6f0bd66eb45@weissschuh.net>

On Tue, Apr 23, 2024 at 06:26:06PM +0200, Thomas Weiﬂschuh wrote:
> run-tests.sh hides the output from the compiler unless the compilation
> fails. To recognize newly introduced warnings use -Werror by default.
> 
> Also add a switch to disable -Werror in case the warnings are expected.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Willy Tarreau <w@1wt.eu>

Thank you Thomas for this one as well!
Willy

