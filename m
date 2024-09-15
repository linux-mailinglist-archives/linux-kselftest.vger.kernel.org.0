Return-Path: <linux-kselftest+bounces-18006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB4C979747
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 16:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD4F281A97
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 14:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CC71C6F6E;
	Sun, 15 Sep 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Or0EBFTy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5191C6F55;
	Sun, 15 Sep 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726411614; cv=none; b=crMlaNcIAqv3abW3ZOjmahZKouVzW7Xzs35HGA+tLnGUAB/ITBO66ZqzqabSn74SlO7z8YCflgzVJWxo8MaCCau1XOnQL9F/WVeJk6DjeW9V4O39KGQjzQHZO1AuR/Xqv0/6x45/igSyiFpJArYE7oSHEgsKjJ1WKQAuKVTcfU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726411614; c=relaxed/simple;
	bh=6ZjIhHpNkhQ25pPxsGDRzZKQrr3kva89/2JqklpBqqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfAFjDRJDD9uY060g+Oij0MAe1YQcaS0PBsU1HzSs2U5+pAWK6ndXTOFV80Kcu76fiTnHIKNZ7pJ1AbYtE2nTWJ5xTf8bLbbmzf3Ms/LzoQkA3tTLM3wlmjIM4XAuV8Ufg+IDDKjOUvmPBIrCIFEpXeHMHSLQB9jRgOh5XAjsoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Or0EBFTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620DCC4CEC3;
	Sun, 15 Sep 2024 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726411613;
	bh=6ZjIhHpNkhQ25pPxsGDRzZKQrr3kva89/2JqklpBqqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Or0EBFTyJ6vxxFgGjkBEJPt4sJJDOLxB+TW1iFRg0BvRVuFywgXKEPcrjO/0JO8QZ
	 WWXiXGPepETxBl4/sGOuCvdiesF2IO3f/xc3+fYj5dyH2uYns/EOGt78IH5ySjN/h6
	 ODdWaw5wjYxaf1Buy6YpaHpr/quJrjh/X48fYstHRmeSyttlk25c5ILbZH1k7NJsTC
	 vmBBuS6ug/LYDGAwNgi1/KYIjJCOnpgEZs9wQNdAAcQzm7QGTvHC0val8svNf7NA+k
	 CubH7AMcRYeq7unJsPdM5kQCMaJwidih4BiIpEVL6OUz0/zp+GHREL6pIvJBD187QS
	 fVwB6uyBL+xWg==
Date: Sun, 15 Sep 2024 16:46:47 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemb@google.com>
Cc: Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: Makefile: add missing 'net/lib' to targets
Message-ID: <20240915164647.5b2e1db6@kernel.org>
In-Reply-To: <CA+FuTSc15f=+zC_p3seVShGMW164Mi+_a-XiSONzx7A83tEPqw@mail.gmail.com>
References: <20240912063119.1277322-1-anders.roxell@linaro.org>
	<20240912082307.556db015@kernel.org>
	<CADYN=9+OTGJtN-z_ffQx9C+UA=a_9rpF7bGtnunFJoq0BWL3vQ@mail.gmail.com>
	<CA+FuTSc15f=+zC_p3seVShGMW164Mi+_a-XiSONzx7A83tEPqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 15 Sep 2024 09:36:10 +0200 Willem de Bruijn wrote:
> > You=E2=80=99re right, the patch is incorrect, I could have explained be=
tter.
> > I=E2=80=99m seeing an issue with an out-of-tree cross compilation build=
 of
> > kselftest and can=E2=80=99t figure out what=E2=80=99s wrong.
> >
> > make --keep-going --jobs=3D32 O=3D/tmp/build
> > INSTALL_PATH=3D/tmp/build/kselftest_install \
> >      ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- \
> >      CROSS_COMPILE_COMPAT=3Darm-linux-gnueabihf- kselftest-install
> >
> > [...]
> > make[4]: Entering directory
> > '/home/anders/src/kernel/linux/tools/testing/selftests/net/lib'
> >   CC       csum
> > /usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/b=
in/ld:
> > cannot open output file /tmp/build/kselftest/net/lib/csum: No such
> > file or directory
> > collect2: error: ld returned 1 exit status
> > [...]
> >
> > Any thoughts on what might be causing this? =20
>=20
> I wonder if this is due to the O=3D argument.
>=20
> Last week I noticed that some TARGETs explicitly have support for
> this, like x86. Added in 2016 in commit a8ba798bc8ec6 ("selftests:
> enable O and KBUILD_OUTPUT"). But by now this support is hardly
> universal. amd-pstate does not have this infra, for instance.
>=20
> Though if the only breakage is in net/lib, then that does not explain it =
fully.

Some funny business with this install target, I haven't investigated
fully but the dependency on all doesn't seem to do its job, and the
install target has a copy/paste of all with this line missing:

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Mak=
efile
index 3b7df5477317..3aee8e7b9993 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -261,6 +261,7 @@ ifdef INSTALL_PATH
 	@ret=3D1;	\
 	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
 		BUILD_TARGET=3D$$BUILD/$$TARGET;	\
+		mkdir -p $$BUILD_TARGET;	\
 		$(MAKE) OUTPUT=3D$$BUILD_TARGET -C $$TARGET install \
 				INSTALL_PATH=3D$(INSTALL_PATH)/$$TARGET \
 				SRC_PATH=3D$(shell readlink -e $$(pwd)) \


Andres, please feel free to test / write commit message and submit this
one liner, but even with that the build for some targets fails for me.
"make [..] install" seems wobbly.

