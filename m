Return-Path: <linux-kselftest+bounces-36648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA46DAFA34A
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jul 2025 08:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F65D17E634
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jul 2025 06:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A551A841A;
	Sun,  6 Jul 2025 06:29:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD9514EC46;
	Sun,  6 Jul 2025 06:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751783372; cv=none; b=FOMYPY+1NmOBecAy3i/5BcKovu+e6MWkdZ6Oy5PvuqRppsB7t771qU8X9yjYR05aObaWaun+IFitvSWHikHW5A2hnW9VjScRJLM8X3iDQGBoeijVWgbB65nCqWwUbgjIUvjIlvSlHrDAYSkvon/BrOj8ONOtsAiftZuLgnN2MEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751783372; c=relaxed/simple;
	bh=eUfn7Xgs8EOh+87kSoe/rnbJf8zukp5315HTNz5Pum8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMsSYcdm7y/P8yYW8Y5bUxqQGqso5JzV5/EvPtXfkRoaPUgUbzStwe/oZniv1eNp9I1NVZQUntk9rAK6pfZT8f+/od2VdZCU4erM1pn/fOnTirEH7O+I4QuOux9muBhTcReQhKI8rY2OIqbOBvUBMdZ6N2qEuH7q6ssnE6L49vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5666TPqk029720;
	Sun, 6 Jul 2025 08:29:25 +0200
Date: Sun, 6 Jul 2025 08:29:25 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: correctly report errors from
 printf() and friends
Message-ID: <20250706062925.GC29601@1wt.eu>
References: <20250704-nolibc-printf-error-v1-0-74b7a092433b@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250704-nolibc-printf-error-v1-0-74b7a092433b@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jul 04, 2025 at 03:43:11PM +0200, Thomas Weiﬂschuh wrote:
> When an error is encountered by printf() it needs to be reported.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Good catch!

Acked-by: Willy Tarreau <w@1wt.eu>

Willy

