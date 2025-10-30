Return-Path: <linux-kselftest+bounces-44419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A692C20D0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 16:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC471899287
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEF32857F0;
	Thu, 30 Oct 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Oj/Ddl/p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EgNGwUjt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC109243968;
	Thu, 30 Oct 2025 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836203; cv=none; b=VdKhnYC8B2dOenvf7yTcydchl/cY6AL2dkIcqZhQTjpO1OqO88jwdQRMeqdHvayhpMNr4XJ6Z+ja0lT+Syt3mgNtRKPLYxZHi5fvaxrI+InOfvVwqHtlZCtDvFNpCOqzheVSDaofIIkNVXgpWwCEduKaCiNB2B0Sm711G7KdsR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836203; c=relaxed/simple;
	bh=c2BK3WHxLANraikKdYCXJO6WoebIYoIS2U7VOwWgQVI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dRX9FZjzrFaEtHNG3BNgLoH8R8+H7lSh0hwPXL44K9nyahuHpgMTza+X+mj0fZFe26+crySuRzTpkGiUtJu9C86W5u/S7w/irGJ+e0IvVC+WsUkLw8jxf/x4XOfOQBplM4OWlB2FYegBYA66V4GlrpB/frvD7FVcJUDegIGBSmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Oj/Ddl/p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EgNGwUjt; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BC1151D00112;
	Thu, 30 Oct 2025 10:56:40 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 10:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761836200;
	 x=1761922600; bh=k8LscHRVr5StbVgpWIhTiPBUvOyGR/V9XAyNZxxwQFQ=; b=
	Oj/Ddl/pOGER+UXiXv17UreATMvRHzZkrH9g19WkcATMdz+Xa2xeAJXKjHOkDiCR
	GsAXV5/vXclGVF8YWWlI5NJcp8RdaA240vm/KBcgdneGLzRUU7BaaM/lawkO22RR
	ge0uQtX96mebX57WAz+1se5GOKjqU9WV7vMv32SeQOrOYO+orlCv19PxHXUa7Pkd
	A1J0EpGo/oqIFOwmagp3fFekgu671qY0wCXCXmZIxT/lbu1TYd2dX05m/EjevmTc
	h4ayMdGxTW/gx+eHGgW/ZmOnvH+kiGDlYjCq7yy0uCQv4d+2LgMx3A+HS2GfGP74
	8ylkyuMGU2NW/n9KbiS4GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761836200; x=
	1761922600; bh=k8LscHRVr5StbVgpWIhTiPBUvOyGR/V9XAyNZxxwQFQ=; b=E
	gNGwUjtTvjHGnWm2mePDhGES2OBe8zxgtnweOjCfleyyTsCT1N7pkl8ozIREi/Cw
	R/Q7Vqk6/EM4LnErnT4bfHzv99q+8nmuC7FfcGz1eNdJwVp/IIk5NWokPqiF/eAx
	R0kPhtUttF6GtUblaSc8KwkJ6Us2TAgHfr4HBMEPeWTPWG9BYiDyHwiYOuY05YyF
	G7f+qmVu8BhW0ZJ8JVSD+FmfsMSriMIddlwH4x8uPINeYH0yoTkw3Rjlb+YTjC5Z
	g3j/9HJTy6CxdUMtO42MiuR/041HGZgwcUNOUsuMdMe95uwI5kXE7C4sEWIi5J3d
	veao3rOI1n8rh+G8digAg==
X-ME-Sender: <xms:qHwDaX9Qn-DLdxu5BuYUkeWIiVsFt1RJ2d4n348PYNpQ3D96s1ezbA>
    <xme:qHwDaegzyvjJJjUvU3kv7P-Mb1iiI0QjLTdHHU-upzLT13Ccyq-6zmaYCVLZ6Ha5u
    1ui4neioyNIK615kVFIBYvACBmLrFlT_EbGjCi8QTcCOegYq8uyLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeileduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghr
    nhgusgdruggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvle
    ehvddvgeejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtth
    hopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifsedufihtrdgvuhdprhgt
    phhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugiesfigvihhsshhstghhuhhhrdhnvght
X-ME-Proxy: <xmx:qHwDaWI-vNksSNHTECU0KpLQQH-ePUDKbJ29C9Km2HhA3YLyk0BOpw>
    <xmx:qHwDaXH1hleYHOEyaJH4HOuh9-bGrKf19BJq134VKCMFFqRvnQL1Zw>
    <xmx:qHwDaSRPXx2x0f_OLn7ykjtf0PPbvHznhXCPweQiikVxl6FgiZVoKw>
    <xmx:qHwDabdLUEe8_-5JJI1O19GPiQUD99TBJVDXiEMwPt1KBGrjWrOQ8g>
    <xmx:qHwDaRMQuMPmOfs_i9G-OrUHKjjLpClrAMIAfvag09w_MGMAVs3cya2D>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 43C2A700054; Thu, 30 Oct 2025 10:56:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGMnaZTMArBF
Date: Thu, 30 Oct 2025 15:56:19 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Willy Tarreau" <w@1wt.eu>, shuah <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <d0c6b2fd-1bba-4a9a-add1-b7c29ada7dd2@app.fastmail.com>
In-Reply-To: <20251029-nolibc-uapi-types-v1-2-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
 <20251029-nolibc-uapi-types-v1-2-e79de3b215d8@weissschuh.net>
Subject: Re: [PATCH 02/12] tools/nolibc: handle 64-bit off_t for llseek
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025, at 17:02, Thomas Wei=C3=9Fschuh wrote:
> Correctly handle 64-bit off_t values in preparation for 64-bit off_t on
> 32-bit architectures.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/sys.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 386ed80aead0..321a3bd16ff4 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -599,8 +599,7 @@ off_t sys_lseek(int fd, off_t offset, int whence)
>  	off_t result;
>  	int ret;
>=20
> -	/* Only exists on 32bit where nolibc off_t is also 32bit */
> -	ret =3D my_syscall5(__NR_llseek, fd, 0, offset, &loff, whence);
> +	ret =3D my_syscall5(__NR_llseek, fd, offset >> 32, (uint32_t)offset,=20
> &loff, whence);

Acked-by: Arnd Bergmann <arnd@arndb.de>

This one is easier than some of the others because it passes
the two halves explictly. It's a bit trickier for preadv/pwritev,
preadv2/pwritev2, fallocate, truncate64/ftruncate64, sync_file_range,
and fadvise64/fadvise64_64, all of which have slightly tricky
calling conventions. Not sure if any of these are currently
supported in nolibc.

    Arnd

