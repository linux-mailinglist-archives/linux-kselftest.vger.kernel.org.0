Return-Path: <linux-kselftest+bounces-31186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A708A93F6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 23:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9197C446AF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 21:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6794022F155;
	Fri, 18 Apr 2025 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nnshqQdl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CAB226D0B;
	Fri, 18 Apr 2025 21:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745011242; cv=none; b=Jregi+dwlRM0Yzd2nHNdRhwXy/t8+afMeOznyichWE+cEnJ0+xyP/0O9RQkkZK6bTtmqD1/65Yar4FwsSxKfM+CU22o9qMvg68QifrtXt0LED9Wh8Ed3kdQFOpDzRj2eaZXhEra8dFEjqQ1rZ0Q8gZvWfr1LeTJ3xun0SSqcS7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745011242; c=relaxed/simple;
	bh=/pGqX4pEXMTj0bPOcVPsKMEKtgwUUJOrrx+plOxhDp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixhnPLBIUIWs/WKYAWqkbKFCP5x3W16Gu9QbB/10aM/En1MYtxTW7iENW2vQOHTg6AOJPeSbHuufFiWF495fNrfUWRyGNkGr0wpIryC0O76Rlwx47zpdYPBENwS23mxfkiWbPhZ+JXyD2/aY/CXvTk4kh2sZMLZJzNEdGjtDVMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nnshqQdl; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745011229;
	bh=/pGqX4pEXMTj0bPOcVPsKMEKtgwUUJOrrx+plOxhDp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnshqQdlE5IuNOJ51s9HUSLQDNv6X6i3+0w5qD9O1w9Xe/EDyny7LawyQNlCTlCvm
	 IfmVeRkYB/DHFU0rQLf38Lla23XPeV0oFipWEc/9UODUT0z3I8p3bWs7lghkheHbzv
	 P4LxlkKShl7hcSCKTNtEyw2VGlSda5yup1Scu+Js=
Date: Fri, 18 Apr 2025 23:20:29 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/6] tools/nolibc: fix some undefined behaviour and
 enable UBSAN
Message-ID: <44ef9e15-d7dd-4079-93c1-5f9cf79d675b@t-8ch.de>
References: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
 <acffaf72-aca5-4301-ade4-ea12571e4392@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acffaf72-aca5-4301-ade4-ea12571e4392@paulmck-laptop>

Hi Paul,

On 2025-04-18 10:32:27-0700, Paul E. McKenney wrote:
> On Wed, Apr 16, 2025 at 08:40:15PM +0200, Thomas Weißschuh wrote:
> > Fix some issues uncovered by UBSAN and enable UBSAN for nolibc-test to
> > avoid regressions.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Thank you, Thomas!  Are these intended to go into the current v6.15
> release, or are you instead thinking in terms of the v6.16 merge window?
> Either works for me, but left to myself, I would assume the v6.16
> merge window.  ;-)

They are intended for v6.16 through the normal process.


Thomas

> 
> > ---
> > Thomas Weißschuh (6):
> >       tools/nolibc: add __nolibc_has_feature()
> >       tools/nolibc: disable function sanitizer for _start_c()
> >       tools/nolibc: properly align dirent buffer
> >       tools/nolibc: fix integer overflow in i{64,}toa_r() and
> >       selftests/nolibc: disable ubsan for smash_stack()
> >       selftests/nolibc: enable UBSAN if available
> > 
> >  tools/include/nolibc/compiler.h              |  6 ++++++
> >  tools/include/nolibc/crt.h                   |  5 +++++
> >  tools/include/nolibc/dirent.h                |  1 +
> >  tools/include/nolibc/stdlib.h                | 24 ++++++++----------------
> >  tools/testing/selftests/nolibc/Makefile      |  3 ++-
> >  tools/testing/selftests/nolibc/nolibc-test.c |  1 +
> >  6 files changed, 23 insertions(+), 17 deletions(-)
> > ---
> > base-commit: 7c73c10b906778384843b9d3ac6c2224727bbf5c
> > change-id: 20250416-nolibc-ubsan-028401698654
> > 
> > Best regards,
> > -- 
> > Thomas Weißschuh <linux@weissschuh.net>
> > 

