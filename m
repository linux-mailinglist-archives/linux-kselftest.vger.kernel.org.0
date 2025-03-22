Return-Path: <linux-kselftest+bounces-29598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EF4A6C85F
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 09:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA05A46443C
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 08:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948841D5CCC;
	Sat, 22 Mar 2025 08:33:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (unknown [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0DF22612;
	Sat, 22 Mar 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742632380; cv=none; b=Cy4YWmTH6XqxVHb1zd7wdiARgvTpJdq9qgCcSYlpffEJu2XBzvs5bOx7aUvHNdpVsf/fJbkmy6WH+pigi5AFpaTGmifAmILUr/wyouuPkqVj0AHm5IugVGkCzNZC736Ey7/hmvxbJWA6R8CJwuNa1fV3aLOHtUzwcVULAp4GAyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742632380; c=relaxed/simple;
	bh=8/xJswb6KgLq5kceB4I87mHwZnp6d8ig1w2bTQyPr+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl6aXSBCxRXgEhYlP12oDQ34FqE2Hr9B6ELZ8fL7f1AaPSTMWmXuYfjWuo3X2woR4R1pz1BoFR9I5QUKgMz8ebRKcAM9rIyXbUsEA4l7//fym50AorhypbCjiolzBp+ZzZFELHt7oxeR+ZZ3gqERzWKWFMSB25h/WAKpeZnt6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <sebastian@breakpoint.cc>)
	id 1tvuHZ-00030u-AQ; Sat, 22 Mar 2025 09:32:41 +0100
Date: Sat, 22 Mar 2025 09:32:41 +0100
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
	Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2] tools/nolibc: Add support for SPARC
Message-ID: <20250322083241.RgLcparD@breakpoint.cc>
References: <20250322-nolibc-sparc-v2-1-89af018c6296@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250322-nolibc-sparc-v2-1-89af018c6296@weissschuh.net>

On 2025-03-22 09:10:51 [+0100], Thomas Wei=C3=9Fschuh wrote:
> Tested-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc> # UltraSpa=
rc T4 (Niagara4)
> ---
> This is only tested on QEMU.
> Any tests on real hardware would be very welcome.

I did test on real hardware.

Sebastian

