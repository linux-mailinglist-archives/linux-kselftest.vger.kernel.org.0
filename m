Return-Path: <linux-kselftest+bounces-37062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AC2B0126A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 06:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C5E7610B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 04:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5251AA7BF;
	Fri, 11 Jul 2025 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="PEmuKkxq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1248158DA3
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 04:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752209609; cv=none; b=icnePxGNvAIepHHxNDL5hxzWgG0tHTg8gD1aZDIZe4WTSi/ufNb5hQEVW9Y2W8P1lvqhng/B0N+XpJpC9JLEkAMfeOWWB2BitcfEaXMjGw3ZvA3ODQCJHqt0VmR3sL2BbWonJ6xqh49xoRHuZwRcypMAaql93zRHZ12ohV7sryM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752209609; c=relaxed/simple;
	bh=GFtV9EwN39oQGXCq8ZlA//AAi3TzAGpm4Bx1hesdz3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qptAkxGH/6yM8tv+WgBUT6EgvwzaVdPOYdZH30OyHGy3tmlssDrd2bK2+VtP1Tn48GgVvP6u/c2PO4YZSchhrGJN3/p0VSn44XPoPT4VBw2A5Qbl0OYoyv1R+B9KOO9op17/1Dqvnc1cVHLvvrt21lL7MleErEdW9vG4rYd1GyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=PEmuKkxq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752209605;
	bh=GFtV9EwN39oQGXCq8ZlA//AAi3TzAGpm4Bx1hesdz3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PEmuKkxqN1Jk61J7Ijws/iBJDOz+sz/ykIxqwr0n/3iCKNaR0MUrc7Y04noq/zGaD
	 9+ImCx3cZ77Z6RuxRSbBmXFfLMgEvl07d3FtIDjoXoTpb+dvgA44QcnQqQwyuDOC2Y
	 ZloUtOXTumsiYQdO0r/iKEadPKI67ZKK6cMNeNNk=
Date: Fri, 11 Jul 2025 06:53:24 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, 
	linux-kselftest@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 2/3] tools/nolibc: add more generic BITSET_* macros for
 FD_*
Message-ID: <660db799-68b8-42a0-b3a1-f57a4706f15b@t-8ch.de>
References: <20250709155512.971080-1-benjamin@sipsolutions.net>
 <20250709155512.971080-3-benjamin@sipsolutions.net>
 <1f927eac-15b4-41f2-843a-5226015da96b@t-8ch.de>
 <20250709184443.GA15954@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709184443.GA15954@1wt.eu>

On 2025-07-09 20:44:43+0200, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Wed, Jul 09, 2025 at 08:36:49PM +0200, Thomas Weißschuh wrote:
> > > +#define FD_CLR(fd, set) BITSET_CLR(fd, (set)->fds)
> > > +#define FD_SET(fd, set) BITSET_SET(fd, (set)->fds)
> > > +#define FD_ISSET(fd, set) BITSET_ISSET(fd, (set)->fds)
> > > +#define FD_ZERO(set) BITSET_ZERO((set)->fds)
> > 
> > These could be inline function I think.
> 
> It's better not do, because man says they are macros, and I've seen
> programs using ifdef on them (not to mean that it's common but it's
> supposed to be possible according to the man).

Ack. OTOH, we could define a noop-macro for the functions:

static __inline__ void FD_SET(...)
{
}
#define FD_SET FD_SET

