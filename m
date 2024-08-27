Return-Path: <linux-kselftest+bounces-16418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC16D961271
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859651F231F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 15:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5A71CC142;
	Tue, 27 Aug 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="bA3g4SBO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CB91D1F4E;
	Tue, 27 Aug 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772538; cv=none; b=UmrQPLwWfS54Sw/9vOZauGgPYe0Kc6qRbwvFvCQsEy0ZkUpD1zcr8aDVnpfwR7GiDXklj1pCEqZqKLaBkG3nX61KSmiUHxzYH6ePBg9NKklCC9Ul9V5D5CU2XGvJAED4LNOKjxOKpK2pZHCNaI9nTqUSFwjP/SEG4uF6xrkLtqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772538; c=relaxed/simple;
	bh=8omP4rl5BYw+84ZxOQg77pGbA8nGQhV/5is63uik8LM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OB/9pGUrCNNL9uJ+87PaYATPaahWlDE6pctTuVsFqMydxOscZVORgNX78CmJJckn2gTqEVaptvQJ3zBFj3QST4gTbwAXcDcs616Gj3nM/yHyKVJxotzOV2MGPZ2U7U+o1wp84jmkrzE06UL7g/4o9xh/Ts54KRxj94KMCt03gxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=bA3g4SBO; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1724772535;
	bh=8omP4rl5BYw+84ZxOQg77pGbA8nGQhV/5is63uik8LM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bA3g4SBOD1ZNZn3yIrQvz65f9taQx/3xq3FMxT41TJeFdKZ84QzcexS8AZ8E9sJwR
	 kgB38JBPMSzjfQ97WTjKFURHv+rNBt67Tphn7CZnpKr3ZIWBzZ1Ne4Rps4/Mnbklhk
	 X1R8kRylvziKd2kV1KGhqbRqXrarQik41qgvu+hs=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id C4C8166F26;
	Tue, 27 Aug 2024 11:28:51 -0400 (EDT)
Message-ID: <d1707f9c173f80588c2917f6289c1394802d6229.camel@xry111.site>
Subject: Re: [PATCH v4 3/4] selftests/vDSO: Use KHDR_INCLUDES to locate UAPI
 headers for vdso_test_getrandom
From: Xi Ruoyao <xry111@xry111.site>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, Jinyang He
 <hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, Arnd
 Bergmann <arnd@arndb.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Date: Tue, 27 Aug 2024 23:28:48 +0800
In-Reply-To: <Zs3sVv43djP3W2yc@zx2c4.com>
References: <20240827132018.88854-1-xry111@xry111.site>
	 <20240827132018.88854-4-xry111@xry111.site> <Zs3blfx1inX_FQLR@zx2c4.com>
	 <019268d4-c177-49e7-aab3-b8fa431905ca@cs-soprasteria.com>
	 <Zs3fhiSlXg2aCGa8@zx2c4.com>
	 <e9a2257f1447ce11e1f22e9a3c64d4b18aa428e1.camel@xry111.site>
	 <0730ca3a-e158-44ea-bb9e-1a7716b45360@csgroup.eu>
	 <Zs3qEMQOv5MAipox@zx2c4.com>
	 <0b540679ec8cfccec75aeb3463810924f6ff71e6.camel@xry111.site>
	 <Zs3sVv43djP3W2yc@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 17:10 +0200, Jason A. Donenfeld wrote:
> On Tue, Aug 27, 2024 at 11:05:14PM +0800, Xi Ruoyao wrote:
> > On Tue, 2024-08-27 at 17:00 +0200, Jason A. Donenfeld wrote:
> > > The effect of this patch is to replace include/uapi with usr/include,=
 so
> > > it will break for you too.
> > >=20
> > > What I'm wondering is why yours and mine work like that, while Ruoyao=
's
> > > breaks. He makes a good argument as to why this patch is the "right
> > > way", even if it breaks our workflow...
> >=20
> > Because arch/loongarch/include/uapi/asm/sigcontext.h includes
> > <linux/posix_types.h>, but the files for x86 and ppc do not.
> >=20
> > I cannot see how this inclusion is useful anyway, so maybe I can just
> > remove the inclusion and paper over the real issue for now?
>=20
> The kselftest people might disagree with papering it over and may prefer
> your patch, but your solution does sound better to me...

Oops the papering over does not really work because the compiler picks
up the sigcontext.h already installed to /usr/include/asm/sigcontext.h.
So, if we want to use the "updated" version of sigcontext.h, we still
have to add KHDR_INCLUDES to pick up
kernel-tree/usr/include/asm/sigcontext.h instead.

Or, I can add $(KHDR_INCLUDES) but also keep
-isystem $(top_srcdir)/include/uapi, so "make -C tools/testing/selftests
TARGETS=3DvDSO" will still (happens to) work on x86 and ppc (without
headers in kernel-tree/usr).

If you agree I'll use this approach in v5.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

