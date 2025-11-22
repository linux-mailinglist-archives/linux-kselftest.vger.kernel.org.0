Return-Path: <linux-kselftest+bounces-46316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCFCC7CE16
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 12:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346ED3A9759
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 11:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9072726ED41;
	Sat, 22 Nov 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="ja08NRID"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0981B19C542;
	Sat, 22 Nov 2025 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763810399; cv=none; b=dyaGQX0gNJFjSqlWZzytxmdWHXuNmE3hYzqgVZhybAbeL92N6JePHUXj7O16K2Glq6JnwaPAAN9HRQ3HtEZMiEzrukNqVjdT1gAmVQOiT5RQBPK1aiVoUE1+hfKwCgJ1hTD1weoh7QoFqdlH4GC41uF64KEMsaHQDxdq53f0UZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763810399; c=relaxed/simple;
	bh=3UG5yQItKZtuRMX7+K9SRTEFGP7LUAsM0XWi0oLEPMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmdXjBgqrIRsV5Ff/NGKBAyPX1ku0kJQuX+OfDR9lbI38c6TBBm7lwOBUhu3evaUSviaadlqEsPRo0JZZ5Y94VcU5Y7yykJbp7QkWheNIeFqxMrjtEc8FihheSFvukAf57S1c2E4aLpIyMVJW9sd+QjIuw5ivR7+WlhwbCuKuwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=ja08NRID; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1763810042; bh=I/SoqfEvKedbqcVVuKT6DOk0L8HAaiOnIHNlM5zAFLc=;
	h=From:Message-ID:From;
	b=ja08NRIDfJjsmNGpInhCjps1HYPIncsbHjrmxU+IqIuUKQUI4XpIE1uWW+v2Xt1r/
	 DH9lay0ANI5QuKgTr9UQglMJJBfytc+yVYJXNcLIzC/mZ2MWD4J7SQNYdHHKkTDijc
	 k/6QGI3GJKK5cOteX4FwAnAL4XAibBOku1zTNOtY=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 4FD01C06F5;
	Sat, 22 Nov 2025 12:14:02 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5AMBE2Dj017245;
	Sat, 22 Nov 2025 12:14:02 +0100
Date: Sat, 22 Nov 2025 12:14:01 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: fix loongarch build with recent
 versions of clang
Message-ID: <20251122111401.GB17183@1wt.eu>
References: <20251122-nolibc-lld-v1-0-5e181e228c6a@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251122-nolibc-lld-v1-0-5e181e228c6a@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Nov 22, 2025 at 12:01:56PM +0100, Thomas Weiﬂschuh wrote:
> LLVM 21 switched to -mcmodel=medium for LoongArch64 compilations.
> This code model uses R_LARCH_ECALL36 relocations which might not be
> supported by GNU ld which the nolibc testsuite uses by default.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Both patches make sense to me, thanks Thomas!

FWIW for the whole series: Acked-by: Willy Tarreau <w@1wt.eu>

Willy

