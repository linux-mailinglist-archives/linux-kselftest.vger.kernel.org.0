Return-Path: <linux-kselftest+bounces-31553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD46A9AE2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 15:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F6E3AEF95
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E91427BF79;
	Thu, 24 Apr 2025 12:59:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521BD27B517;
	Thu, 24 Apr 2025 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499573; cv=none; b=K1bBrI4ZMpNd4/aQ7uwGBCzldP3uJkspAN2NKOA2NRnsozH1zFxNLG8mI/BhdID+pnF7xc7eiAKMw86VRbrX2COlaDWH4gZuj8WbAhEXBZ/Mf0sTvermPzfbGdbHM81SErwrpL3ggYUeMWaJvhNhNOHRnLjYtsNDrmR+WaxlHN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499573; c=relaxed/simple;
	bh=gfirCOB8zzFpOG+53gxCTqJLceHrN9rNqDBbYgX72uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0wQaKCIORm4lxZAUgBxKbjluD9dzpn1llnlAjKNPlFKPPP4Jp7FZOcaYIOParx0MQeke52auhVAqXq28Hw3eKXd/KNqwTm8RajvBNBSTCyNHKhnEjLNgKBarwCVQfkcC4F0Tre5oJeetXFOe4MTYDckIVzGF+OTWmpDcX8ifi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 53OCx3UX030607;
	Thu, 24 Apr 2025 14:59:03 +0200
Date: Thu, 24 Apr 2025 14:59:03 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/3] tools/nolibc: make all headers usable directly
Message-ID: <20250424125903.GE30489@1wt.eu>
References: <20250424-nolibc-header-check-v1-0-011576b6ed6f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424-nolibc-header-check-v1-0-011576b6ed6f@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

[ quick response ]

On Thu, Apr 24, 2025 at 01:48:10PM +0200, Thomas Weißschuh wrote:
> Make sure that any nolibc header can be included in any order.
> Even if nolibc.h was not pre-included already.

I've been wondering how to do this already and didn't come up with any
great solution. I think that your approach is the right one, indeed,
to include it out of the guards will force to respect ordering. That's
a great idea.  I'm all for it!

Acked-by: Willy Tarreau <w@1wt.eu>

Willy

