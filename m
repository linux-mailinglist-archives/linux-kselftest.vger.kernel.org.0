Return-Path: <linux-kselftest+bounces-23099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A2D9EA65E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 04:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16A41888412
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 03:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C311A0731;
	Tue, 10 Dec 2024 03:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="bWrfkcD3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD88CB644;
	Tue, 10 Dec 2024 03:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733800588; cv=none; b=qqE+I7yEwLPaTh6aYxAbN/AtWfAG6qoIwe09bN4Ni9+RloRwkCtznBWmx+kB/pEooXhGlgScRclgUo5hwg/VuhGjzY6t5HemM0O6j8hty/qwDoK2VutC+8DbJo6nbxsVUU1fOcmj08HTmF7HcrVpM+CdR7tGmlO/VewJkbKLnVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733800588; c=relaxed/simple;
	bh=eXGEu4KAz6qcPVQA7lYcrlwsLgscu3BE4eAmubYy8Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q5T5y5INwNWNx9QzBnjM7pbQW5Ox9Py5I+iS0mJN8nV8tBE4HnhG56+ZmuCTh63wAeuN+7DAX1AEEL5Z3vcfPuehZ35ehxgeIJAYH00ZX5U8xFyKfdxXOlZCRPB/8ZhlhDJbeBNdP4+tFj2sspIOO44hvKlAuFlvjWPmKFk/k0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=bWrfkcD3; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LeFG3gl+OryxJybRPXpymOyZvJHgwsSv9cMRRfsqXhc=; b=bWrfkcD3njI+eNuA6NOMNOLgRu
	LB8iQhndZnRzIkGwpPp+zu0Ppcu0SJXYNJQczNIcI41ySOTsKSp5jUAceIxzdpwzyhy2AwbHEY90j
	FsumA0uvS/w/hixhKXiTlqqVflLC6MZ2VV8+DmT9K7dTRm1vdMRygxF14Lx/Zr/X8CmZJtkzEUA1G
	CR/+efVgYfa6WFUJIAyjPGTniT32agj8nMV6D+T/9OoLWgZ2jo1GygD5n21Yse5sGga3dSqJzYdyc
	NxhV/1jizwvdZioiTJXLdb8bSwsaq5Xu7JHJCv9yqVpbKAVRwRq8qKDvmmZb38s+EWs7BzBUQBE5b
	2whjDbOg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tKqWE-000N1U-0A;
	Tue, 10 Dec 2024 11:15:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 10 Dec 2024 11:15:58 +0800
Date: Tue, 10 Dec 2024 11:15:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Enzo Bertoloti <ebertoloti@lkcamp.dev>
Cc: jpleoncio@lkcamp.dev, ~lkcamp/patches@lists.sr.ht, davem@davemloft.net,
	linux-crypto@vger.kernel.org, shuah@kernel.org, davidgow@google.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] Add KUnit tests for curve25519
Message-ID: <Z1eybkns92cjDR1i@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209001335.736045-1-ebertoloti@lkcamp.dev>
X-Newsgroups: apana.lists.os.linux.cryptoapi

Enzo Bertoloti <ebertoloti@lkcamp.dev> wrote:
> This test uses the curve25519-selftest data for testing the curve25519
> arch, generic and the public key generation algorithms on a larger set
> using KUnit.
> The comprises of normal, edge cases, valid, invalid results and others.
> 
> This is partially based on the existing curve25519 selftests in
> crypto/curve25519-selftest.c

Please explain the difference between this and the existing selftest.
Why do we need both of them?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

