Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BAA1D9E13
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgESRmr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 May 2020 13:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgESRmr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 May 2020 13:42:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60FB220708;
        Tue, 19 May 2020 17:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589910166;
        bh=EDW0r9lJB/mHdT/CnCUjsSuOup1WvyQq3lR+MbgJ72Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rLep35nFUAC9lusx069fAz2hCtlAiZbDPfxFIisOvUoOIxsmokDWMRnO6ecDtewPQ
         uHkHwpfi1bzkhlIjX3/tIf3LK7qxvwZAVG5dRU6Q7cy8zHmJ8G4H2qXQ+6eaJL8pup
         4I8J94evRcDhF9siWbP9jXBvKHpRc6DJGyK9jIPA=
Date:   Tue, 19 May 2020 18:42:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests: vdso: Use a header file to prototype
 parse_vdso API
Message-ID: <20200519174244.GQ4611@sirena.org.uk>
References: <20200505174728.46594-1-broonie@kernel.org>
 <20200505174728.46594-3-broonie@kernel.org>
 <aaeb0619-68d2-18f8-f72a-b8b37f348b4e@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1WN/MJ7JJGqVzwIW"
Content-Disposition: inline
In-Reply-To: <aaeb0619-68d2-18f8-f72a-b8b37f348b4e@kernel.org>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--1WN/MJ7JJGqVzwIW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 19, 2020 at 11:29:10AM -0600, shuah wrote:
> On 5/5/20 11:47 AM, Mark Brown wrote:

> > - * These are the prototypes:
> > - */
> > -extern void vdso_init_from_auxv(void *auxv);
> > -extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
> > -extern void *vdso_sym(const char *version, const char *name);

> > + * These are the prototypes:
> > + */
> > +extern void *vdso_sym(const char *version, const char *name);
> > +extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
> > +extern void vdso_init_from_auxv(void *auxv);

> You don't need extern here - this should be in scope?

This is just code motion of existing code which has the externs.
There's no cases where you *need* the extern, it's just syntactic sugar.

--1WN/MJ7JJGqVzwIW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7EGpMACgkQJNaLcl1U
h9Czzwf+IVIiFVSlDi8A7NrBX4YywtYThN/lz3dtf0srr2ukyAILvb6tHYOu7ZU0
CiNU48pATalu6i+t7eoLAT9oFuXt78I11rd0cideTEocVPW6GMxxT4pXdml4sp41
iJuKBccXIyxqgQN7ixkjqZ8v+Yr4K0IcZZ1UyDDABZwSnVdwnkza1lcdg3CId6ob
D/lLIjJK86RApuxqfZ+WhTJlFC7cO38YOcyWVXtnlyiVMKQg9UvQ2IEfmjNH5cCS
q/ASpev+jgxtywqjKMZ+/muaQae30uO1kfwGUGtrXb5OhqD2/z8HtEsYC4XfWfBk
SSWd+tqNvVo0tNnf/RTNwuNTBay+vA==
=PW8Z
-----END PGP SIGNATURE-----

--1WN/MJ7JJGqVzwIW--
