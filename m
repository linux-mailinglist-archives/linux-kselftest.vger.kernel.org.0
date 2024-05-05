Return-Path: <linux-kselftest+bounces-9477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F4C8BC081
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 15:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E36A281C00
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891201C695;
	Sun,  5 May 2024 13:21:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209B1BC5C
	for <linux-kselftest@vger.kernel.org>; Sun,  5 May 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714915274; cv=none; b=YBsf2aVJm4i55JYtrMPgFPjzhbxhbMcL3SRqWeopRqORcDEEq+DPsguOqswRvY5i95NEUJropnK/VSTthsMygHzu5iLzEibRFco7fjvWM221jC0UjJpOK3mHtWV9MfWCr4CxJ3PHPNJlR9uPBQt2kej6n8+drLGc16XZtUQ+bRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714915274; c=relaxed/simple;
	bh=U8Zx21yumKBwvNpxrOL9i9gF2EPUJJL7/L/GmWttG2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=XmoJsFDnlywCQk23wWu1SJnCSPJAvvKo+b7Zw4h5IakZfeQMjRMWkcsgz3Zg+RdjSrkd8I3as2VbcTKpubgubk2v3jtH53Rwbezw9usDepivShtFBMoGBsLZayPWhGraxYPgdpWtoZpZRA6DAebG+0rb3b71Hhb3WrnLAO8yqa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-89-FQgjpD-sPLqqUMvw5kHpyg-1; Sun, 05 May 2024 14:21:09 +0100
X-MC-Unique: FQgjpD-sPLqqUMvw5kHpyg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 5 May
 2024 14:20:35 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 5 May 2024 14:20:35 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Justin Stitt' <justinstitt@google.com>, Edward Liaw <edliaw@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shuah Khan
	<shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, "H. Peter Anvin"
	<hpa@linux.intel.com>, Andy Lutomirski <luto@mit.edu>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel-team@android.com" <kernel-team@android.com>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>
Subject: RE: [PATCH v3] selftests/vDSO: Explicit unsigned char conversion for
 elf_hash
Thread-Topic: [PATCH v3] selftests/vDSO: Explicit unsigned char conversion for
 elf_hash
Thread-Index: AQHanAFdbmzmhwAPx0KMYxInfI6/rrGIpXPg
Date: Sun, 5 May 2024 13:20:35 +0000
Message-ID: <b55272cb757743548c789aa8c0efa448@AcuMS.aculab.com>
References: <20240501180622.1676340-1-edliaw@google.com>
 <osgrbhnqlyh5yw4y4x6wjggx56dogsgje5yy3mkpu75ubs3zwg@5tliydzky37k>
In-Reply-To: <osgrbhnqlyh5yw4y4x6wjggx56dogsgje5yy3mkpu75ubs3zwg@5tliydzky37k>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Justin Stitt
> Sent: 01 May 2024 20:55
...
> > static unsigned long elf_hash(const unsigned char *name)
...
> Is it possible to just change the types of the parameters of vdso_sym()
> or does that trigger even more warnings on the callsites of vdso_sym()?

Isn't the problem the definition of elf_hash()?
A '\0' terminated string really ought to be 'char *' not 'unsigned char *'.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


