Return-Path: <linux-kselftest+bounces-3710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45918841665
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 00:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7212D1C215B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 23:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D05051C30;
	Mon, 29 Jan 2024 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/Y6ioA4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2A023741;
	Mon, 29 Jan 2024 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706569217; cv=none; b=SDhKebSn879JQmzAo+d3HvOFwOhP9IDIs7IXojIfrID5+YspuwYYOUGWovu669qKENPk38rBp/GuSxpmMWGI5cYryFyew4w7R8iQQQonZhc2Xz41Kp3q/NScsyJWxQ3W/D/YX2ayX5BJCkYFu7kMSsC+MS4JGzf5DBYGc+QxVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706569217; c=relaxed/simple;
	bh=Q8zamyCfq9B5+OQaLxHjO6IQbHlUKQGt8O3hsn43kqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8bQjC8p4f0irWzsabMb1Jv6QcRmz2hiShEvR/tuhb36sdydvLuyzmb74TWKvpb33zzebTlxuK3tCv3d9vPzy7qyFtIpEn4csGWPk1HFBVJSZtXGRa7qdz9mWrbp/v7txgq4tOlU6UE0KxPXT5QLLhMZpctX/tlot6niObjXWgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/Y6ioA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307AEC433C7;
	Mon, 29 Jan 2024 23:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706569217;
	bh=Q8zamyCfq9B5+OQaLxHjO6IQbHlUKQGt8O3hsn43kqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/Y6ioA4ULP80zpgmClkivCFZxBCmiAlUcqdUOm6NiKC5BJO9uqqgsSYrOuzHvYQ7
	 4oJiD1cKJdpY2hUajy8B5aoTHuVG41cNBPK5Af1lYJq7VqDU0avyNLr+u+Gkp70egE
	 HDXIPJPp0Zj+fjLjHpJ57fexjplSM8vO1CjYbfGXmnz7Q0r8MkGNeUgRDksEHvKKsf
	 JoPakaF5TJ/f88oBl0uu38albUGpXTRinbSvPPrhvSCN+pMv/tWXwn/jIUM6xvLWyd
	 1p9fIqExhUlJ8Zb+UOwqIzH2uv2tH3WcbA1lsPJmJyfifdQZSuRrnt5zl4bpzu3UnV
	 cQkhltTzdYMlg==
Date: Mon, 29 Jan 2024 23:00:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v2] kselftest: dt: Stop relying on dirname to improve
 performance
Message-ID: <6e978244-c3be-4e28-bb3c-2b61bdb5a08d@sirena.org.uk>
References: <20240122-dt-kselftest-dirname-perf-fix-v2-1-f1630532fd38@collabora.com>
 <20240122154043.GC601827-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6IUGtYfkaTHX7W28"
Content-Disposition: inline
In-Reply-To: <20240122154043.GC601827-robh@kernel.org>
X-Cookie: Justice, n.:


--6IUGtYfkaTHX7W28
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 09:40:43AM -0600, Rob Herring wrote:
> On Mon, Jan 22, 2024 at 11:29:18AM -0300, N=EDcolas F. R. A. Prado wrote:

> > When walking directory trees, instead of looking for specific files and
> > running dirname to get the parent folder, traverse all folders and
> > ignore the ones not containing the desired files. This avoids the need

> Applied, thanks.

Is there any prospect of getting this merged as a fix?  It's causing a
massive number of false positives in my CI when run on slower boards
with larger numbers of devices.

--6IUGtYfkaTHX7W28
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW4LfsACgkQJNaLcl1U
h9CaDwf/TzYtMT+9Bhswz64lDl1RMjxsAlPB1r171FTDP8K7K1cdLJwu+RjrPBGn
dHVyMVZW++n+ZytShCvZt7puA2LHUQCEehC7zvake2122Hgg7mnfA3nepHylkH/h
32bEiTzAFcvVRXxspr3lxAVKH82tt/3JDCPgUQPd4SUpTEAYgSLmSeP9xotFax1U
/es6hm2q8QyCcy8JkVNjlx514WjHGbkXd8o04txoHjOAZczevA5x+sW7Toh0SkRH
GZIq/h3uBW8BpPzMuWqKb3zuGjhM/wz8kGQpO8AZOCquooc5Ig46VuZSiZqXNNxw
7Gyw+DIsdc0A/GX3MGmIdKMzcAwMQA==
=p2cI
-----END PGP SIGNATURE-----

--6IUGtYfkaTHX7W28--

