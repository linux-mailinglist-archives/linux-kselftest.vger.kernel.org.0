Return-Path: <linux-kselftest+bounces-49426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C414D3BAE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 23:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE98F3035319
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 22:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1182B21A434;
	Mon, 19 Jan 2026 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVs8ySJ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07971DFD96;
	Mon, 19 Jan 2026 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768861859; cv=none; b=Yh6xjZw+Ck3mEG+tBofP2LZQF5RbCq6iqyTKLE7q96JLGi/SaPzUxLbiySztjW4JioxvN/JV75XR5DqoLVU0BvVRKxbDKd+asErEh4BRAS72fRqDF11C2SnnVbIUl4k3M0lIrCZqt6IMJnAi8DN/OAx4Jx9Xk81E6ocVGyfseQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768861859; c=relaxed/simple;
	bh=NgXPV5unaA3nCfYhkbuX0VMeX04lXuYirsqsHatGyB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ULIX2aY64S+e4jIUoCGeJvfdJIklfigTtb0DlxjNsCJMPqcgB0UjgKCV3ZfwjyvFCkSG+MzW0AOtxpj6GElituo7FNSmqU2lcnkAVuzjzthH3blOQVTmHkCVLbd2wgaDo6cOrNwOwZi1VUR2PvB5d0KqxFF+RlRowELYHXzumIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVs8ySJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F911C116C6;
	Mon, 19 Jan 2026 22:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768861858;
	bh=NgXPV5unaA3nCfYhkbuX0VMeX04lXuYirsqsHatGyB0=;
	h=Date:From:To:Cc:Subject:From;
	b=qVs8ySJ7Dfv1nkF54HkWxDKDMuc9Z8IShP++HSblHeZgZlEnV3jeMpQBvdmcojiQ4
	 8m8ykWSlgYYzkFJ9IrvVAA/ipO7Rz4x0tkZelMyWIw1raBsDu8IWCl5NjOu7inlByg
	 h2hmN4TXIrtZYNDOQS6uYJbIYj/qtvcpn3BAaborevmEnKpxzIaISlABUv0gc86qzk
	 wuQY1o2Ty/rHMUIZsei2VzNajcMO4te1AXsnjc93mSjBRA7I9UqwteflWUCaWL6gvU
	 TWHyGwGiv2DFWp/EwMp0FZETgkGZDDTOEr9dV144hhDPXfSGOXaCqjCLwRzZtz6YBW
	 OwhsiDjNYNXeA==
Date: Mon, 19 Jan 2026 22:30:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Subject: linux-next: Tree for Jan 19
Message-ID: <aW6wnF0E3BPovw3m@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h2Pj6ea45PRhsxQe"
Content-Disposition: inline


--h2Pj6ea45PRhsxQe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Changes since 20260116:

I have started verifying the build of a substantial subset of the
kselftests on arm64, some of the skipped builds are simply missing build
dependencies on my machine rather than actual failures - I'll poke at
this over time.  The subset is listed in Next/kselftest-targets.

It also appears that due to having a Rust toolchain on the build server
allmodconfig and allyesconfig have picked up CONFIG_RUST=y coverage.

The vfs tree gained a conflict with the vfs-brauner tree.

The vfs-brauner tree gained a build conflcit with the ntfs3 tree for
which I applied a fixup.

The rust-pin-init tree gained a conflict with the rust-fixes tree.

The xilinx tree gained a conflict with the ti tree.

The perf tree gained a build failure, I have used the version from
20260116 instead.

The drm tree gained multiple conflicts with Linus' tree.

The drm-misc tree gained a build conflict with the drm tree for which I
applied a fixup.

The block tree gained a build failure for which I did a revert.

The iommu tree gained a build failure, I used the version from 20260116.

The iio tree gained a build failure, I used the version from 20260116.

The drm-rust tree gained multiple build failures for which I disabled
the Tyr driver.

Non-merge commits (relative to Linus' tree): 7291
 7092 files changed, 419068 insertions(+), 146354 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There is also the merge.log file in the Next
directory.  Between each merge, the tree was built with a defconfig
for arm64, an allmodconfig for x86_64, a multi_v7_defconfig for arm,
an arm64 build of various kselftests and a native build of tools/perf.
After the final fixups (if any), I do an x86_64 modules_install followed
by builds for x86_64 allnoconfig, arm64 allyesconfig, powerpc
allnoconfig (32 and 64 bit), ppc44x_defconfig and pseries_le_defconfig
and i386, s390, sparc and sparc64 defconfig and htmldocs. And finally, a
simple boot test of the powerpc pseries_le_defconfig kernel in qemu
(with and without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 405 trees (counting Linus' and 122 trees of bug
fix patches pending for the current release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Thanks to Paul Gortmaker for triage and bug fixes.

--h2Pj6ea45PRhsxQe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlusJwACgkQJNaLcl1U
h9B0DAf+PVoLIxUPLhoEE10dFfADF3bzyaqGLMtMtQVjXn6tbi1GmJ8tjoxTzMeA
vYSDri4EbKO5xk3pUEGoSQZ3J8GXyazwYIN0sxNeE3QZKmjkA0V8s6cCjZWbp5ZJ
tbqtLbVZvoiGM6vpar0D/KAQdBYJbvrOAaAB0P2Fq7uIG0FvQHiodCZ0CMQrRnQn
dzhUVVlKjqtHplM7difrt2aRb73Cfus7qFmNvL0wbKosIM6AlRIBvJ6RtUbBE5Kf
9ui8ZYeLSFzeMb+czxZ3n8J9mQj7/19mfmtNMrzLm18Ubc/QJYLvyTvaT7KB1NOT
bonMdvtRnWlVL7OgNls5OS6p6c6kBQ==
=Ubpm
-----END PGP SIGNATURE-----

--h2Pj6ea45PRhsxQe--

