Return-Path: <linux-kselftest+bounces-14771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DF2946AD8
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 20:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7028E281C51
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8156A182C9;
	Sat,  3 Aug 2024 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="nKZslrnb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8117BAA;
	Sat,  3 Aug 2024 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722709759; cv=none; b=GPX3O9nJP7y+l64TMJl5IxYDdmO8hTw4Zpx87i2B3ATw2GbpAxxWAou/ez41KXX8ujbhBfe/1PxER3d8/z+eWLu+jC11dTFOA3jy3W1S1ceIjP82UXQTsaxg5wlLTwErU5mxTmlHNHdmaruhvZoJRAO81d6/8pBChqcOBuE5KMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722709759; c=relaxed/simple;
	bh=pMXItrUAqWLNVVo9gc0uOxXbOBJESVBbDc2+tJuder8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XV5dOQV9/0g5+tdnTLTou54wd59LoC/kwS0XzaoEDpJYUyYnz8hAPjV7fpTeXOUtTwVVyKq0a5InsvlpkAuN3Da3OXeOyBtaCP+bAjk5HLjxm4EcmpGhhX8R0O8AX0MOf+Wasgr3ibAhoh948y8rAz5/6MOGreW3hPBZoWXam/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=nKZslrnb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1722709755; bh=pMXItrUAqWLNVVo9gc0uOxXbOBJESVBbDc2+tJuder8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nKZslrnbgPZeeWhM9G0UubOY1kt1yA5/6La9tVlgKxSRz7O9a+1ZAyxDmPVswtPrR
	 WtUub3027/2SExhyLi81HhegK/09k3NcsNzWEEg2oKrLusytB1FAl8dh4JaqF2Qe/u
	 qc7RGZNXEycAMiYxasfN1isXbkPFdVSbkF5vErps=
Date: Sat, 3 Aug 2024 20:29:14 +0200 (GMT+02:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Message-ID: <94a81790-1385-43d4-ab67-9a6029e245de@t-8ch.de>
In-Reply-To: <20240803093355.GC29127@1wt.eu>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net> <20240728-nolibc-llvm-v1-6-bc384269bc35@weissschuh.net> <20240803093355.GC29127@1wt.eu>
Subject: Re: [PATCH 06/12] selftests/nolibc: avoid passing NULL to
 printf("%s")
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <94a81790-1385-43d4-ab67-9a6029e245de@t-8ch.de>

Aug 3, 2024 11:34:03 Willy Tarreau <w@1wt.eu>:

> On Sun, Jul 28, 2024 at 12:10:00PM +0200, Thomas Wei=C3=9Fschuh wrote:
>> Clang on higher optimization levels detects that NULL is passed to
>> printf("%s") and warns about it.
>> Avoid the warning.
>
> I don't see why this would be a problem, we do explicitly check for
> NULL in our printf implementation and print "(null)". Or maybe it is
> upset due to the attribute(printf) ? I don't know what the standard
> says regarding %s and NULL, though. If it says that NULL is forbidden
> then I can understand the warning and your fix is indeed correct. In
> any case it's not worth fighting with a compiler for nolibc-test, but
> it's probably worth mentioning in the commit message that it warns
> despite the check being already done.

It's undefined as per POSIX.
I'll update the commit message.

