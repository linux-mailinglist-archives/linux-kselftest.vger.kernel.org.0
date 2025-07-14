Return-Path: <linux-kselftest+bounces-37246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE8FB03F03
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7417167A7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 12:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD4E246BD9;
	Mon, 14 Jul 2025 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uEf3Y9xH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B28635C
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497549; cv=none; b=JbgoOu4VnBb2eGvsWKw819u//iHZ7t7H9uBdBoSFF30DRiNczq8euIp93t6fJkfXSGy16EI/gZOKcq5ZqUULmzVjV4314C1/bkW7B11m5dAk5rvMXIFwFBAcc1ANGsG0jbHKIamqHsyodWtVi7ke/PLK4dK2oOjECd4x0QMn1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497549; c=relaxed/simple;
	bh=dc8DUL8Wo8Y7qvSAyRZhIhWq8ghnFS7tDUafdMsN3jE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=euU86mGSJhW2zBQAHuxGYj691wvYgHKa7YphnuAlI40OH5Gu0w8Qw/xLt7dNigYXx8ufmZ1gAPPZCyI/5IdsniXmsoqaNilU8XIXNR+9B/3pvErbJxa0wr3kcYMEkSdVVR7YMUpE5CX5ceBqtJ/YVg/k+wQdksuA2NqL0ktgWd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uEf3Y9xH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dc8DUL8Wo8Y7qvSAyRZhIhWq8ghnFS7tDUafdMsN3jE=;
	t=1752497548; x=1753707148; b=uEf3Y9xHhOCFdkiWE/5Kv0MGRodGtTo21lrmoBQcbEz3kp3
	I9cKjU8L2a+4OTysPPztZKBIT9lu5tPCw1ArLyGWT18Au+MEEqHb64evqvSPb75yggoo2RXRkw5Ka
	TqgXV3cBLvljwVu7TBpe+SWSTkfQiOwawk0gM58MWUtwAzlWoLbKljvy4w5PygEf5WKMScCgWwAUM
	S7MzZoqlrAM4ei+bmWqLSqGQeLwJ6cNfHk/sDAy72l3ML4PjEAvAIywUoBjeh8234G7HEn8MLWlOl
	CxpXj6LiFu/TtwbLyt0nzyVruvUknsYfS4oHmEzV2OhJjzJ4/Zd/4lhsyDWZNrQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1ubIfQ-000000045gg-41Xe;
	Mon, 14 Jul 2025 14:52:25 +0200
Message-ID: <e4dd8d10c8d27fa9b939a3381df86a82a4d791f0.camel@sipsolutions.net>
Subject: Re: [PATCH v2 4/4] tools/nolibc: add signal support
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
	 <linux@weissschuh.net>
Cc: linux-kselftest@vger.kernel.org
Date: Mon, 14 Jul 2025 14:52:23 +0200
In-Reply-To: <20250713155002.GA25876@1wt.eu>
References: <20250710103950.1272379-1-benjamin@sipsolutions.net>
	 <20250710103950.1272379-5-benjamin@sipsolutions.net>
	 <f72ddf71-40e4-49d0-92b6-da219e33bd29@t-8ch.de>
	 <b1c3684e1e299f787a88c58a063ab4d0485a59a7.camel@sipsolutions.net>
	 <3f901ecb-d6d1-4fb4-9159-a6b817b0dd39@t-8ch.de>
	 <20250713155002.GA25876@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2025-07-13 at 17:50 +0200, Willy Tarreau wrote:
> On Sun, Jul 13, 2025 at 05:02:27PM +0200, Thomas Wei=C3=9Fschuh wrote:
> > On 2025-07-11 09:25:26+0200, Benjamin Berg wrote:
> > > On Fri, 2025-07-11 at 07:40 +0200, Thomas Wei=C3=9Fschuh wrote:
> > > > On 2025-07-10 12:39:50+0200, Benjamin Berg wrote:
> > > > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > > >=20
> > > > > Add support for sigaction() and implement the normal sa_mask help=
ers.
> > > > >=20
> > > > > On many architectures, linux/signal.h pulls in compatibility
> > > > > definitions
> > > > > for the old sigaction syscall instead of rt_sigaction. However, t=
he
> > > > > kernel can be compiled without support for this compatibility
> > > > > syscall
> > > > > and it also results in sa_mask to be too small for realtime
> > > > > signals.
> > > > >=20
> > > > > To work around this, the includes are handled separately for each
> > > > > architecture. This way either linux/signal.h or the asm-generic
> > > > > headers
> > > > > can be used to get the correct definition for the rt_sigaction
> > > > > syscall
> > > > > including sigset_t.
> > > >=20
> > > > I checked this against my WIP alpha support and there this scheme
> > > > breaks. linux/signal.h provides the old compat types but
> > > > the asm-generic variant provides an incorrect SIGCHLD.
> > > >=20
> > > > Any ideas?
> > >=20
> > > I had a quick look, and I don't have a good idea really. For sparc
> > > there was at least a #define that permitted to get the correct versio=
n.
> > > But here, there is nothing.
> > >=20
> > > Probably the best is to just copy in a modified version of signal.h
> > > with the correct definitions present. i.e. replace the "ifndef
> > > __KERNEL__" sections with something reasonable.
> >=20
> > But then we can just have our own copy for every architecture, no?
> > To me that looks like the best solution right now.
>=20
> I generally agree. Originally in nolibc, lots of stuff was copied and
> we only used very little of UAPI. As new architectures were supported,
> we took this opportunity for cleaning this up and relying more on UAPI,
> but that doesn't mean we need to get rid of our local definitions all
> the time, so if that helps, yeah clearly we can have our local copies
> and definitions.

Not sure our own copy for every architecture is the best solution. Many
of them work fine with the asm-generic headers, and using those where
they apply seems pretty reasonable to me.

So, maybe that would be a good compromise? i.e. use asm-generic where
possible and copy in a file otherwise. That seems slightly less
convoluted and still avoids having to actually fix the architecture
headers.

Benjamin

