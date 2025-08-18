Return-Path: <linux-kselftest+bounces-39227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C418B2AA47
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 16:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A5B5A30B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 14:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63549322749;
	Mon, 18 Aug 2025 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uKRtaEcV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B79261B9B;
	Mon, 18 Aug 2025 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526051; cv=none; b=cRmow1JjK3cPzB3TcSNuHlx7h2Zk0jt520z5t9juFBMV7iqnNotfhSTxJOImJEkEB+SxvOHMqOi40O8aUHIMqnzh5nlHWBj7CWycQKO0Q7zYyyWKu12Nq49kjHTz0UoxRH3nge0edlQoT0y17lwHUT+EcA/PV5DQs4d6se4l6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526051; c=relaxed/simple;
	bh=aWJdNsIL+OfTpQ7wAhWqjKJj/AXrvG8KIwRxbSMd0Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGHNYCurfaQF76NxvXLWpmQa9velP5PevzqWPK/olROAawTNbBh5YK6ivpIcIbh50wEDVKNIpbKehBRh5A5L/oYo5ToNnLoJ5CsF+1PruLAytIn96DQUsjDRJAWh+eKnjEnMSs9GA5KD3TDnlvmJGUiOaVXa41QJ+qOro5yd7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uKRtaEcV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755526041;
	bh=aWJdNsIL+OfTpQ7wAhWqjKJj/AXrvG8KIwRxbSMd0Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKRtaEcVKtXTiPWamZvVo+hWvY4SZTAPEAQF6+V7D5SvXfco8IGylDSVS2hFQt4Tv
	 6NNb9/wjTU90ZBUD/TjktLML/FvQD5uT8RWQWyY4NDDhMhyreuCDffRSsB2rHvzS64
	 lr3NbpCuzrO0AoTjHkuKFX5+UQ6x+RqlSqRDe56k=
Date: Mon, 18 Aug 2025 16:07:21 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] selftests/nolibc: don't pass CC to toplevel Makefile
Message-ID: <d742c315-273d-417e-b1c7-00a9cec6a2c4@t-8ch.de>
References: <20250719-nolibc-llvm-system-v1-0-1730216ce171@weissschuh.net>
 <20250719-nolibc-llvm-system-v1-2-1730216ce171@weissschuh.net>
 <20250721025627.GB1886@1wt.eu>
 <ebb84a9c-8771-4791-8a81-b615cecec7c3@t-8ch.de>
 <20250817093905.GA14213@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250817093905.GA14213@1wt.eu>

On 2025-08-17 11:39:05+0200, Willy Tarreau wrote:
> On Sun, Aug 17, 2025 at 10:30:52AM +0200, Thomas Weißschuh wrote:
> > On 2025-07-21 04:56:27+0200, Willy Tarreau wrote:
> > > On Sat, Jul 19, 2025 at 05:38:28PM +0200, Thomas Weißschuh wrote:

(...)

> > > I think I'd be fine with this, but then we need to make it
> > > explicit in the help message and fix the current one, possibly just
> > > with this:
> > > 
> > > -	@echo "  nolibc-test       build the executable (uses \$$CC and \$$CROSS_COMPILE)"
> > > +	@echo "  nolibc-test       build the executable (uses \$$CC)"
> > 
> > I don't think this is correct. $CC itself depends on $CROSS_COMPILE
> > through tools/scripts/Makefile.include.
> 
> I don't understand what you mean by "depends on" here. CC defaults
> to ${CROSS_COMPILE}gcc and may override it if set. So if one sets
> CC, CROSS_COMPILE will not be used for it. Or maybe we could change
> it to this to indicate a precedence if that's the idea you want to
> convey ?
> 
>  -	@echo "  nolibc-test       build the executable (uses \$$CC and \$$CROSS_COMPILE)"
>  +	@echo "  nolibc-test       build the executable (uses \$$CC or \$$CROSS_COMPILE)"

Yes, that is the idea. 
I pushed a commit to this effect to nolibc/for-next.


Thomas

