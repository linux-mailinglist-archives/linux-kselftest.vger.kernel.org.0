Return-Path: <linux-kselftest+bounces-42028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08307B8E176
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 19:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C363BD639
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 17:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69C921A428;
	Sun, 21 Sep 2025 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AkXVSVZ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3F19F11E;
	Sun, 21 Sep 2025 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475016; cv=none; b=nN4a5lMXw6AiJp1rPlLgSPAZWESDsDxrRaTkDbyEUACwS4lM4K3vyUZ6UeRI1KMWNXDnEVgjylq8eF7aAZfTyCOyJ1zSJpoXjwNplt6IDoAq8PyafC6oGc8qmd/50xzasRP2ZZQBJE2uwVS7XVOoOToRBkc46PprnNN1z+oWQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475016; c=relaxed/simple;
	bh=7dCgM0eACjtT8GmknFe+LWicZTU06206JRREMKs92Y0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p9fLpnDMiHM58IJj8Btdk9/bTgWAzdBq2zVthC6BUGojjXdk1+nCrgiW7unASr5vmKCNKGAFejdh68lFqHaNYIZQDyyFxrIJuZ27ggWDjQyl0o8t207vescl35VhQtz2tTfc+IYvlRH0s080vBC72w8F0a4OLEKlvo1MGSjqmzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AkXVSVZ2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7dCgM0eACjtT8GmknFe+LWicZTU06206JRREMKs92Y0=;
	t=1758475015; x=1759684615; b=AkXVSVZ2VD4JU+mlA7YqPDvb4Qz53StutEcH+iKXdVYfzHf
	Ztd/JalVVpn1upqDwpwqjZx40Q+rRLx3GhIgps57SATAo5aZNNhFvca4qE/OVbL8SVmBobNxuWwiS
	MIZ+h4b51sOzrLiAqJQ3EmWRUP/b1xkp8S+OUZ2rUFEkVwPMnRwGUDnvIz9KaI+hR7aLQra0IBeeV
	rdtNgqoiyte1HT8ZttGot02NGqDSAFoXfl0WMGDKN7graSCUegqVrOckyIZGa7ln5OA+Ls5zuvg1q
	SMqzS58MXFEPYxo3eSALiqH7M839zK+2j9NGLvycKYYHptx7FyMWB9bGWju+COmw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v0NgB-00000002jZW-1gGM;
	Sun, 21 Sep 2025 19:16:51 +0200
Message-ID: <25a968dab7cc7e473ff85400a3a824b272121c79.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, Arnaldo
 Carvalho de Melo
	 <acme@redhat.com>, linux-kernel@vger.kernel.org
Date: Sun, 21 Sep 2025 19:16:50 +0200
In-Reply-To: <20250921171323.GC28238@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
	 <20250919153420.727385-4-benjamin@sipsolutions.net>
	 <20250921075511.GA16684@1wt.eu>
	 <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
	 <54d0bf1d1010530941b595129312a56cfdea7c7b.camel@sipsolutions.net>
	 <20250921171323.GC28238@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

On Sun, 2025-09-21 at 19:13 +0200, Willy Tarreau wrote:
> On Sun, Sep 21, 2025 at 07:05:24PM +0200, Benjamin Berg wrote:
> > This also ties to the question of the other mail. I prefer "errno" not
> > to be available if it is not actually safe to use. UML does use threads
> > in some places (and may use it extensively in the future). The current
> > "errno" implementation is not threadsafe and I see neither an obvious
> > way nor a need to change that. By setting NOLIBC_IGNORE_ERRNO any
> > unsafe code will not compile and can be changed to use the sys_*
> > functions to avoid errno.
>=20
> That's the point I disagree with because here we're not using errno
> more than printf() or dirent(). Why fix dirent() to build without errno
> and break perror() ? Why not also break printf() then ? All of this must
> be consistent. We're unbreaking some arbitrary functions and breaking
> other arbitrary ones, that's not logical.
>=20
> I'm totally fine with saying that errno shouldn't be defined when buildin=
g
> without errno, but all functions must continue to be defined. perror() is
> used to print an error message, it's a valid use case just as printf() an=
d
> should remain.
>=20
> If we disable perror for this, then we must also disable usage of printf
> for consistency (and I don't want this either).

Right, fair enough. It is true that it does not really hurt to keep
perror defined. I doubt there is much code out there, but I also don't
really have a a strong argument against keeping perror. After all, it
will "just" result in a bad error messages rather than undefined
behaviour.

Benjamin

