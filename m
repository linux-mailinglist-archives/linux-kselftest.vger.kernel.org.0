Return-Path: <linux-kselftest+bounces-8231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3256C8A77BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 00:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B7D1C21F48
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 22:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE6784E14;
	Tue, 16 Apr 2024 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="ShQQv/MH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58D811F8;
	Tue, 16 Apr 2024 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305943; cv=none; b=XLDo3RAHCGnbgHgm9hG5e+H5UPDcWi3YSgw+KOY/JXg4zdeBTX9JyeCbHwYrR9yDo7zYCjd1wLe8Nw3dNOxb2HOibJh9fCu6ZEQYQyaUAoWSGJY4lHJv3H+UScyr1YKjYEnIT6JhUl49FpkynX0lCCEYLNC4bBfmdQpTdEwhb3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305943; c=relaxed/simple;
	bh=2UTgKuAbrwfWuorBNpc3DoDq6mu+gQFxigrPLV5qftU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TitTj6dpCEmX58pbTrJdzubyM6sZw+r7PZDjBfbXLFQ0irTD/IH5SK/CNE/1nWfEJk9LLU3/6vv5Z1avP6eqnj1mZAArY2y8zpPB8ywn62sdQEMhUTIaeKKPLyrkEVGmIKEVax0YljeZ0N9wmF0abCycyU9GYIqkaFd2TRVgT34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=ShQQv/MH; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=LjIgFuPbUWQTQ78rm1vu5j/huuLNGgrNm+YPodOSqE0=; b=ShQQv/MHydPLbBH6mC4Cus80Xh
	Cd/y0Jq20egXeGhhrajocUzcMMi6eRAb27GMj5TF+8l7LGK8uVh8syE4ouMIAiRCqRn9zNVqVXTIQ
	8WxVviYUjOF+H+xopFnSeGciC6EVEuc+kZbUuNGGjNsAuJPUyBAL0InlpHO1pZgGiQY6MvMzry+wu
	V9r57YdjOWQTy1WjEdp/GQIgKJNGVfpxdou5zRROR2EmbA9Cd/63Ki/ZfEicMl+RKmF4MZNQYL2B0
	B28WYRfSUMHQuiQ4Y4KkMCfUlwbvL2dmo5afYjCTuLNxwCIl8fAbJZ/Zpc+fQbtLBID23YRaCWGdW
	fcoIsLbQ==;
Received: from [10.69.139.14] (helo=terabithia.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rwr8j-00GVN4-1I;
	Tue, 16 Apr 2024 17:18:57 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Peter Zijlstra <peterz@infradead.org>, wine-devel@winehq.org
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Elizabeth Figura <zfigura@codeweavers.com>
Subject: Re: [PATCH v4 00/30] NT synchronization primitive driver
Date: Tue, 16 Apr 2024 17:18:56 -0500
Message-ID: <3743440.MHq7AAxBmi@terabithia>
In-Reply-To: <4340072.ejJDZkT8p0@terabithia>
References:
 <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416081421.GB31647@noisy.programming.kicks-ass.net>
 <4340072.ejJDZkT8p0@terabithia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, 16 April 2024 16:18:24 CDT Elizabeth Figura wrote:
> On Tuesday, 16 April 2024 03:14:21 CDT Peter Zijlstra wrote:
> > I don't support GE has it in his builds? Last time I tried, building
> > Wine was a bit of a pain.
>=20
> It doesn't seem so. I tried to build a GE-compatible ntsync build, upload=
ed
> here (thanks Arek for hosting):
>=20
>     https://f002.backblazeb2.com/file/wine-ntsync/ntsync-wine.tar.xz

Oops, the initial version I uploaded had broken paths. Should be fixed now.

(It's also broken on an unpatched kernel unless explicitly disabled with=20
WINE_DISABLE_FAST_SYNC=3D1. Not sure what I messed up there=E2=80=94it shou=
ld fall back=20
cleanly=E2=80=94but hopefully shouldn't be too important for testing.)



