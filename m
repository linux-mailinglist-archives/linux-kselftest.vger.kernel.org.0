Return-Path: <linux-kselftest+bounces-42024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8FAB8E148
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 19:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F242176F7D
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 17:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D762D23E32B;
	Sun, 21 Sep 2025 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mfHn08Xn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18362EEDE;
	Sun, 21 Sep 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758474337; cv=none; b=gvryFdYvAybs101JsZHeoVi60OomaiqhnS/XKADKWnaxkJqNZjuf79gbQuJm8S4zp3UIzYNpbozn1hM688Wax3yQf2+NM8b1ElvOIO+hl7VQcmSDFmp+i0mDmUxxua9GOaIah/G6+PgXM2wOvizzP8dzixzMUTHYzqrB9Pe3OYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758474337; c=relaxed/simple;
	bh=eReR2GSoViQn3mNMgdNgB3AjBZUcZ6d9PEufUO96hxo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZPz3Y6S4o4L3YJxgdpF8rXrWEUqnUUagHfxOyq7/rcAEUUyfpmnzMjmSDpqfcUyPYVQOeoH5H22W0gTY6SOircRHXddIct2IypFR9HPqmQOAF+rxr9t5IRRMSrQhFdjF8nxlL21UiUQQ6IMyxq6PbkweFJn/YPA5L9+ZgZQ2BG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mfHn08Xn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5rovFAtkUkJUenI7BhBsGCj5mVmrWVA5Xd/NvQSts8Q=;
	t=1758474336; x=1759683936; b=mfHn08XnpqLtDF++tKFnY2OIksTelxemIaZ3HTu7rOa927O
	J7csPD55bhzHr6CajhxISsijesbG0Kpk7A9i8qPv0JIeBc/iqr6OVZeN4jdXQB+KDET2ZfuqTeuDK
	0d4yQVYLd1UcD3fm1UckqL7uDtaU54WMcN0K00VtX1G5BK+ptxhdzGNXvocerOReF1bP82/UWHVBn
	Ge1h/JMRHwr4VAin7oh/tl3tLXVdaFq+lpN7r0NXEGziclfjVENP1j7bes6Kgwz8Og0+tDcpCd9qp
	FTF17EJJL5MCXSAq+OjWraHcEjOl53rU9nHwi12puRoglh/nT0HvqeichZUg9qDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v0NV7-00000002iXg-1uFq;
	Sun, 21 Sep 2025 19:05:25 +0200
Message-ID: <54d0bf1d1010530941b595129312a56cfdea7c7b.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Willy
 Tarreau	 <w@1wt.eu>
Cc: linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, Arnaldo
 Carvalho de Melo
	 <acme@redhat.com>, linux-kernel@vger.kernel.org
Date: Sun, 21 Sep 2025 19:05:24 +0200
In-Reply-To: <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
	 <20250919153420.727385-4-benjamin@sipsolutions.net>
	 <20250921075511.GA16684@1wt.eu>
	 <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
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

On Sun, 2025-09-21 at 18:37 +0200, Thomas Wei=C3=9Fschuh wrote:
> On 2025-09-21 09:55:11+0200, Willy Tarreau wrote:
> > Hi Benjamin,
> >=20
> > On Fri, Sep 19, 2025 at 05:34:12PM +0200, Benjamin Berg wrote:
> > > From: Benjamin Berg <benjamin.berg@intel.com>
> > >=20
> > > There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As su=
ch,
> > > the perror function does not make any sense then and cannot compile.
> > >=20
> > > Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the =
errno value")
> > > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > > Acked-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > > ---
> > > =C2=A0tools/include/nolibc/stdio.h | 2 ++
> > > =C2=A01 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdi=
o.h
> > > index 7630234408c5..c512159b8374 100644
> > > --- a/tools/include/nolibc/stdio.h
> > > +++ b/tools/include/nolibc/stdio.h
> > > @@ -597,11 +597,13 @@ int sscanf(const char *str, const char *format,=
 ...)
> > > =C2=A0	return ret;
> > > =C2=A0}
> > > =C2=A0
> > > +#ifndef NOLIBC_IGNORE_ERRNO
> > > =C2=A0static __attribute__((unused))
> > > =C2=A0void perror(const char *msg)
> > > =C2=A0{
> > > =C2=A0	fprintf(stderr, "%s%serrno=3D%d\n", (msg && *msg) ? msg : "", =
(msg && *msg) ? ": " : "", errno);
> > > =C2=A0}
> > > +#endif
> >=20
> > Please instead place the ifndef inside the function so that code callin=
g
> > perror() continues to build. The original goal of that macro was to
> > further shrink programs at the expense of losing error details. But we
> > should be able to continue to build working programs with that macro
> > defined. There's nothing hard set in stone regarding this but here it's
> > easy to preserve a working behavior by having something like this for
> > example:
> >=20
> > =C2=A0 static __attribute__((unused))
> > =C2=A0 void perror(const char *msg)
> > =C2=A0 {
> > =C2=A0+#ifdef NOLIBC_IGNORE_ERRNO
> > =C2=A0+=C2=A0	fprintf(stderr, "%s\n", (msg && *msg) ? msg : "unknown er=
ror");
> > =C2=A0+#else
> > =C2=A0=C2=A0	fprintf(stderr, "%s%serrno=3D%d\n", (msg && *msg) ? msg : =
"", (msg && *msg) ? ": " : "", errno);
> > =C2=A0+#endif
> > =C2=A0 }
>=20
> For the plain `errno` variable and printf(%m) we don't have such
> fallbacks. With NOLIBC_IGNORE_ERRNO the compilation either fails or the
> results are undefined. Personally I prefer not defining perror() here.

So, with NOLIBC_IGNORE_ERRNO, we do not have the "errno" variable
either and code using it will break. I actually think that this is a
good thing and it is part of the reason that I wanted to explicitly set
the flag for UML.

This also ties to the question of the other mail. I prefer "errno" not
to be available if it is not actually safe to use. UML does use threads
in some places (and may use it extensively in the future). The current
"errno" implementation is not threadsafe and I see neither an obvious
way nor a need to change that. By setting NOLIBC_IGNORE_ERRNO any
unsafe code will not compile and can be changed to use the sys_*
functions to avoid errno.

Benjamin

