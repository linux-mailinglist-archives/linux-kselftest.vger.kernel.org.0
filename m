Return-Path: <linux-kselftest+bounces-215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F027EE16C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 14:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109C11C20976
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 13:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86AA30650;
	Thu, 16 Nov 2023 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdsUeGXq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73526181;
	Thu, 16 Nov 2023 05:20:21 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc3bb4c307so7384695ad.0;
        Thu, 16 Nov 2023 05:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700140821; x=1700745621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2XflPwdTyJWS9B5cLq55m5fzTSgF5IpCemsZrZkGPI=;
        b=fdsUeGXqbZFXkdm2g1t0nLXSVuuWL1GYqrq6zM2ks7kSEA4jqEfcbglpviXUCCjoFq
         RqXBZVx35ROo82wpZOXzLFF9herX4RkuQcvL8OFwsmvBPNnvpT5RdT9NgO0YjmQmIwEd
         u3y243xbMoBt6JikD6AnYqs5Vi6wjEFEiVFNcU9WUfRmmt0CpurRKrQxLAyyMxyAQFqg
         8vJcka6+DLR5HmyyC1lm45is8J+nBxmWLltPQWdJae1+9zlvylMRXLcgm9E04QDc3I4s
         HgARe2g/r9xO9kZRgLMG2T3ArxUQv/dCHHGcB4FoLRkUnXsAqP/mOY7vXCd6SdI5Q8Z5
         CgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700140821; x=1700745621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2XflPwdTyJWS9B5cLq55m5fzTSgF5IpCemsZrZkGPI=;
        b=I1H68/rTMNUTCJe+0e5vu0fPIjfUMWOj32uXOuIqDCfknF7bmO8C8dBzVQFzX9/ic3
         jO7+X1cNkPoEDnHDfFrMPWNCU1wDmE/dDCJ30RovxoKMT45lYy82qEqjh3QsyKAdwu83
         mKJXvTTTkJg228Bq+6l2+Gebejwrd7VhZK1eNxTqzVTo+a8XDrCH3lliIADk264n47wh
         zdAweGT6XSZU90dI/fwwIbc9i2BXo+dLcKLVMnYRCXwJo56RRndWiHl33h+ZuR+TuLqZ
         73ZdRc5qm48E5kGaSLF8v77y18WwiRofS4IQqEqOQRPCwnkv4Lbbhk3Yor3SVaTxxBb7
         sYdA==
X-Gm-Message-State: AOJu0Yw7TvgAK9yGaypfbtj+HC8pauxkJUVg5mTtsjtSr+fMlWPS9Ous
	2nSW1VvMQdZbe7LtJEoPp3Y=
X-Google-Smtp-Source: AGHT+IHdEhG8HmRvd+96XU5XATRxmwZpSuHqHTrSJ7n/ZhLDynMAFsvUmOr6SrxJmBMisUEAdwOCXw==
X-Received: by 2002:a17:902:e545:b0:1cc:3bfc:69b1 with SMTP id n5-20020a170902e54500b001cc3bfc69b1mr9304626plf.24.1700140820712;
        Thu, 16 Nov 2023 05:20:20 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b001bc930d4517sm9176312plg.42.2023.11.16.05.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 05:20:20 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 16A6610D5B837; Thu, 16 Nov 2023 20:20:18 +0700 (WIB)
Date: Thu, 16 Nov 2023 20:20:18 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
	workflows@vger.kernel.org, Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Charles Han <hanchunchao@inspur.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Unit Tests <kunit-dev@googlegroups.com>,
	Linux Kernel Self Tests <linux-kselftest@vger.kernel.org>,
	Veronika Kabatova <vkabatov@redhat.com>,
	CKI <cki-project@redhat.com>, kernelci@lists.linux.dev
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Message-ID: <ZVYXEry40HTCis00@archie.me>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/52Cd+M7ZZaAYRXH"
Content-Disposition: inline
In-Reply-To: <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>


--/52Cd+M7ZZaAYRXH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 07:43:49PM +0200, Nikolai Kondrashov wrote:
> Make scripts/checkpatch.pl ensure any added V: fields reference
> documented test suites only, and output a warning if a change to a
> subsystem doesn't certify the required test suites were executed,
> if any.
>=20
> If the test suite description includes a "Command", then checkpatch.pl
> will output it as the one executing the suite. The command should run
> with only the kernel tree and the regular developer environment set up.
> But, at the same time, could simply output instructions for installing
> any extra dependencies (or pull some automatically). The idea is to
> get the developer into feedback loop quicker and easier, so they have
> something to run and iterate on, even if it involves installing some
> more stuff first. Therefore it's a good idea to add such wrappers to the
> kernel tree proper and refer to them from the tests.rst.

Does it also apply to trivial patches (e.g. spelling or checkpatch fixes
as seen on drivers/staging/)?

--=20
An old man doll... just what I always wanted! - Clara

--/52Cd+M7ZZaAYRXH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVYXDgAKCRD2uYlJVVFO
o75JAP0cfZYKSutbwH9x71KI13pvS1fgdOAvvcN9kaUBzg0vnQD+LUG82FmYKG63
JUcGvcrvno/pxKXp/R7iYPVC1/wijQQ=
=hAKi
-----END PGP SIGNATURE-----

--/52Cd+M7ZZaAYRXH--

