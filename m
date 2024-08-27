Return-Path: <linux-kselftest+bounces-16409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76DE960DCC
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 16:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EB62847D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 14:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5B81C4EF6;
	Tue, 27 Aug 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="M6dvFFiH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE51C4EE2;
	Tue, 27 Aug 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769713; cv=none; b=nnzN6bgkoG3NMvHopSVEg1VhiW/aW7bXOHfNSoMFyjeR6NGuXjIcI9WV+i6TSeIL58hniv6eTg33WK8afGkeFL7pCBCXws5cOwDJ5Ou4n0CsoWMUcvzWcG+rWoiytGZ59cJ7PDgOxIAeyEY1DK8ZJpJEptu91AA8iC9f8wghyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769713; c=relaxed/simple;
	bh=V0Itv5m3lu3hmCk19f2gFuYwJvxq26bNT4Jyxrj18uc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DfLulVXLGHIDkhkzQgr6qOfluVgWyhW/V+5E8gmCUYBtmjUW8dNRsb1Mhn5OxJ4x8dt6k8PxqPt8eNYmvt3srxIL7eX6nRTr54NR5IitpVx7ry83OwGm0nxLfzlQnplhZZzSR1TVWXMPoeULZ0eXdO0fns9FBpN25TTQX1Z1AJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=M6dvFFiH; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1724769710;
	bh=V0Itv5m3lu3hmCk19f2gFuYwJvxq26bNT4Jyxrj18uc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=M6dvFFiH9PSFumpf6XYstX2PXfs2MCLEBf3TR9m0cukkf/O1yafvBYw6Jhy3H+HGx
	 4WnNtrI1ZHHb2/6BprHAZR1+QGpbS/62YNi2ihfOA87G/+Cb1wEuqASlmmYlR+sMPG
	 Ks+wb7l9JNbtyJ2rCuDTqTy2j4RzUHd9rrjLzQHE=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id E709C66F26;
	Tue, 27 Aug 2024 10:41:46 -0400 (EDT)
Message-ID: <e9a2257f1447ce11e1f22e9a3c64d4b18aa428e1.camel@xry111.site>
Subject: Re: [PATCH v4 3/4] selftests/vDSO: Use KHDR_INCLUDES to locate UAPI
 headers for vdso_test_getrandom
From: Xi Ruoyao <xry111@xry111.site>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, LEROY Christophe
	 <christophe.leroy2@cs-soprasteria.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, Jinyang He
 <hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, Arnd
 Bergmann <arnd@arndb.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Date: Tue, 27 Aug 2024 22:41:44 +0800
In-Reply-To: <Zs3fhiSlXg2aCGa8@zx2c4.com>
References: <20240827132018.88854-1-xry111@xry111.site>
	 <20240827132018.88854-4-xry111@xry111.site> <Zs3blfx1inX_FQLR@zx2c4.com>
	 <019268d4-c177-49e7-aab3-b8fa431905ca@cs-soprasteria.com>
	 <Zs3fhiSlXg2aCGa8@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 16:15 +0200, Jason A. Donenfeld wrote:

/* snip */

> gcc -std=3Dgnu99 -D_GNU_SOURCE=3D -isystem /home/zx2c4/Projects/random-li=
nux/tools/testing/selftests/../../../tools/include -isystem /home/zx2c4/Pro=
jects/random-linux/tools/testing/selftests/../../../usr/include=C2=A0=C2=A0=
=C2=A0 vdso_test_getrandom.c parse_vdso.c=C2=A0 -o /home/zx2c4/Projects/ran=
dom-linux/tools/testing/selftests/vDSO/vdso_test_getrandom
> vdso_test_getrandom.c:43:41: error: field =E2=80=98params=E2=80=99 has in=
complete type
> =C2=A0=C2=A0 43 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct =
vgetrandom_opaque_params params;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~
>=20
> $ ls /home/zx2c4/Projects/random-linux/tools/testing/selftests/../../../u=
sr/include
> headers_check.pl=C2=A0 Makefile
>=20
> Since I don't build in there, this directory is empty.

In the toplevel Makefile:

kselftest-%: headers FORCE
    $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*

So running "make kselftest-all" to build the self tests should have
already caused make to build the "headers" target, which puts the
headers into usr/include.

I don't think it's supported to build self tests w/o invoking the
toplevel Makefile: many other self tests use KHDR_INCLUDES as well, so
generally building with something like "make -C tools/testing/selftests"
just won't work.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

