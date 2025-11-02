Return-Path: <linux-kselftest+bounces-44622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF559C28C59
	for <lists+linux-kselftest@lfdr.de>; Sun, 02 Nov 2025 09:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4A324E02C9
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Nov 2025 08:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9DA264638;
	Sun,  2 Nov 2025 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="EAuyzAa6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9EA1DEFE7;
	Sun,  2 Nov 2025 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762073074; cv=none; b=pHByZalb8xkiBSymFeM7NP6pvuJDG+S7jDBOMOUyZdCS2tUdaxM7L+m9T2eEmXCBirviS1lIdI08WHuxmzCRBkI9Driq4OiaiHafl06KbV3IuiCinQOy7kqkSRgkQrbDnuAu9gjSQNtzcZhJuBpHkczQiLuk/QKsCphvg5bgrjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762073074; c=relaxed/simple;
	bh=MMvZZbkp3PNrjM80Icfk8JLbf5QXX2sLirUcqVj301A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbXMx/UNMxfoSdPOugql9xV8Q/H9UVjfjvNTEfnFhEgFxiVzEHTuRyDcWjLmoWg4dSHKYxlGfQlktzc4a60R5ih5q39IVBu0Nd+y3/xrpVHZB03R/iaOshd0E+/42WREmlRe+8sIK0IHV+B6shhUTZ75l1snuers8oZZKQVRoww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=EAuyzAa6; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762073070; bh=7Rx+oyfR5vuNLBTCG3xVKdSQ7H39byCGk34YvTkomog=;
	h=From:Message-ID:From;
	b=EAuyzAa6X28fvY7/Sg069GJsQv9u1UvovcvzmW0kGjW4RKBi6uZBK1EmrlfqRGoVG
	 399YDX1M2IQ+kgwvBciSswbK556bWcVzoS2fN8tQH2t0QMinwfWDYsDWlpMPganC1p
	 KG50+qYQO4YQFBd/lJMuH6l+xUlNpML8ZTP/7fzY=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 47A68C06ED;
	Sun, 02 Nov 2025 09:44:30 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A28iT4o010992;
	Sun, 2 Nov 2025 09:44:29 +0100
Date: Sun, 2 Nov 2025 09:44:29 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/12] tools/nolibc: always use 64-bit ino_t, off_t and
 time-related types
Message-ID: <20251102084429.GD10797@1wt.eu>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 29, 2025 at 05:02:50PM +0100, Thomas Weiﬂschuh wrote:
> nolibc currently uses 32-bit types for various APIs. These are
> problematic as their reduced value range can lead to truncated values.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Thanks Thomas for this cleanup! Overall this looks good to me. I also
tested my preinit code against it based both on latest and older UAPI
headers (5.4) and everything still builds and seems to work fine.

For the whole series: Acked-by: Willy Tarreau <w@1wt.eu>

Willy

