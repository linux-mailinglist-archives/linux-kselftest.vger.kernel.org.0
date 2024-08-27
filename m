Return-Path: <linux-kselftest+bounces-16415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C10961022
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55615280F21
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF1D1C2DB1;
	Tue, 27 Aug 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="R+P2dlS5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD42C1BC9E3;
	Tue, 27 Aug 2024 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771124; cv=none; b=oQgtVDzlANo2gyPZCzlH5DbTtdOeo/kvbHpSb6Wcxm+BzdVBvjPZoniYAYt81S80TFLLqwFjf7AqYmaI9Enoak6YKfvHhIHS4MBt0co5/TZnbsn/qB1FzKf2kNf31MqqwA2xpIC6Lu3zSIVsdP6O+rAmeih/SXSyNA2FFDPMoc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771124; c=relaxed/simple;
	bh=SFmQJTRpuMurKtwHEycNO3UZqSYzhfsgyR9njkzryHc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LMAxZHhsG+m8GZyhe3MF9N5+p1V3/E9Stf5MZgLRPVYC0mF/aYlTDQ5AeoDkECCz1/zaM/fT9/bEI3xkdeDzjpFYsTpmIUj3//TIdEYvDlJ0Nwx8nsOodaY403B5POR5cOs5Sx3lqF9gkjkB1OW5l13GufGOW+3oCtqyN0dZ2IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=R+P2dlS5; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1724771121;
	bh=SFmQJTRpuMurKtwHEycNO3UZqSYzhfsgyR9njkzryHc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=R+P2dlS5o/TgKRvvVY8oftffQ7eu8WO8+fsqFTGN/jjhEPPtdCeAGuwoa7yBMQ/C+
	 gFijLU/wFKiLtBrx2yI84kWGgca9BIXsoQjdrmPXRDPp4KsZeRB/71Dsjn6BNUwVNa
	 3ABLcUf0aoWeALcbUQF51Z6HPv689LXpP9xGooZo=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 0296C66F26;
	Tue, 27 Aug 2024 11:05:16 -0400 (EDT)
Message-ID: <0b540679ec8cfccec75aeb3463810924f6ff71e6.camel@xry111.site>
Subject: Re: [PATCH v4 3/4] selftests/vDSO: Use KHDR_INCLUDES to locate UAPI
 headers for vdso_test_getrandom
From: Xi Ruoyao <xry111@xry111.site>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Christophe Leroy
	 <christophe.leroy@csgroup.eu>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, Jinyang He
 <hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, Arnd
 Bergmann <arnd@arndb.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Date: Tue, 27 Aug 2024 23:05:14 +0800
In-Reply-To: <Zs3qEMQOv5MAipox@zx2c4.com>
References: <20240827132018.88854-1-xry111@xry111.site>
	 <20240827132018.88854-4-xry111@xry111.site> <Zs3blfx1inX_FQLR@zx2c4.com>
	 <019268d4-c177-49e7-aab3-b8fa431905ca@cs-soprasteria.com>
	 <Zs3fhiSlXg2aCGa8@zx2c4.com>
	 <e9a2257f1447ce11e1f22e9a3c64d4b18aa428e1.camel@xry111.site>
	 <0730ca3a-e158-44ea-bb9e-1a7716b45360@csgroup.eu>
	 <Zs3qEMQOv5MAipox@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 17:00 +0200, Jason A. Donenfeld wrote:
> The effect of this patch is to replace include/uapi with usr/include, so
> it will break for you too.
>=20
> What I'm wondering is why yours and mine work like that, while Ruoyao's
> breaks. He makes a good argument as to why this patch is the "right
> way", even if it breaks our workflow...

Because arch/loongarch/include/uapi/asm/sigcontext.h includes
<linux/posix_types.h>, but the files for x86 and ppc do not.

I cannot see how this inclusion is useful anyway, so maybe I can just
remove the inclusion and paper over the real issue for now?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

