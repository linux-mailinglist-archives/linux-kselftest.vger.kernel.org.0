Return-Path: <linux-kselftest+bounces-47991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E847CE6FCA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 15:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F6E4300C5DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 14:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E1A1A2C11;
	Mon, 29 Dec 2025 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="Nw5xg1z3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575C8BEC;
	Mon, 29 Dec 2025 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767017781; cv=pass; b=m9wjC2Km/FgsBn9QX21A8pJyjDAdW2mUHabZB3k252fvajV6ABI/qwsJQzKt/3SNMjZ4sPfHPyPDfuCfAG0bK8iUBcgKMj3whuFcwGRFFFTh5uSjFylybncYi0b30DvG+eDc+skPb8kQJ8Pf+m1tHjMvXCSJOS2gDmeq23MT0oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767017781; c=relaxed/simple;
	bh=gcGoEnrtXDIB7GOHQw70PHm1fFbRAHrLIr2ZLda2Sbo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uwhH5G7K8yCk9XplTSRnajPfA3E5xkNOsmrDKCYOcvvN66JYfhFSpK4YS+IwxWuuW82sVdDmyXsRpv3f0FgoZtzN547CaQeRa9YRVZOw8gh24cJS3xqzbCUFrfttdPNA3VI0w+5gCiY6K2N9nl2SLNZGvHbhQiAlGqzFxc/hniA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=Nw5xg1z3; arc=pass smtp.client-ip=136.143.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1767017706; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c132D8Q3MEQnj5rQMTMNFyDLvy0qPgMPOnZFF6uXrKqrOFvOuLUxaxJrTk8oZVx+zbWusYPdz1g5cXYskX82leIo4qnkaCZi8gWWtNCaZ7KrBeCrEj8J+X8ku2vddzZznHZkon/31rhzfOG0xfqvJjKDLj7wgZa3o5rWZXZAHYo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767017706; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gcGoEnrtXDIB7GOHQw70PHm1fFbRAHrLIr2ZLda2Sbo=; 
	b=JhuqOJfKnmx3A9WVjIxKVMMWNjnDyjI01DYzYK0gQkWvTka0Qr9UB45AC3+R4hJNAl20YAPM0tmLkABCS1jh+ehrxmcsaH4ljpo9K73B5rqEpmeFl5Nr6/0yDa3LmT3SGJyJeNHtUN7ISAC3wO4GJoxA63UxQWQrKD3cmETF5kM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767017706;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=gcGoEnrtXDIB7GOHQw70PHm1fFbRAHrLIr2ZLda2Sbo=;
	b=Nw5xg1z3cLP9VkYemFCEQnqUxQv87FIyfwExUfFBbW16Efglq8oL6Ap19gxrpL6K
	xKRbcDf0GPyPD/FM63TQJaq/1vZSOXRL+p+gIpSwEHmNUF79r4ko21rz8ymMR5GB8Rr
	CH6VE0CvnupjDedRSQa/XHi30VA2XJuY9SAC9fNo=
Received: by mx.zohomail.com with SMTPS id 1767017705278437.0577963304597;
	Mon, 29 Dec 2025 06:15:05 -0800 (PST)
Message-ID: <8caf35529d2825ba98a8f7ea63ce03d23007292a.camel@collabora.com>
Subject: Re: [PATCH v4 1/3] kselftest: Add test to verify probe of devices
 from discoverable buses
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	kernelci@lists.linux.dev, kernel@collabora.com, Tim Bird
 <Tim.Bird@sony.com>, 	linux-pci@vger.kernel.org, David Gow
 <davidgow@google.com>, 	linux-kselftest@vger.kernel.org, Rob Herring
 <robh+dt@kernel.org>, Doug Anderson	 <dianders@chromium.org>,
 linux-usb@vger.kernel.org, Saravana Kannan	 <saravanak@google.com>, Dan
 Carpenter <dan.carpenter@linaro.org>, Guenter Roeck	 <groeck@chromium.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 29 Dec 2025 11:14:59 -0300
In-Reply-To: <20251229145542-059157e7-1864-4407-8734-0a32589f9b0b@linutronix.de>
References: 
	<20240122-discoverable-devs-ksft-v4-0-d602e1df4aa2@collabora.com>
	 <20240122-discoverable-devs-ksft-v4-1-d602e1df4aa2@collabora.com>
	 <20251229145542-059157e7-1864-4407-8734-0a32589f9b0b@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-7 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Mon, 2025-12-29 at 14:57 +0100, Thomas Wei=C3=9Fschuh wrote:
> On Mon, Jan 22, 2024 at 03:53:21PM -0300, N=C3=ADcolas F. R. A. Prado
> wrote:
> > Add a new test to verify that a list of expected devices from
> > discoverable buses (ie USB, PCI) have been successfully
> > instantiated and
> > probed by a driver.
> >=20
> > The per-platform list of expected devices is selected from the ones
> > under the boards/ directory based on the DT compatible or the DMI
> > IDs.
> >=20
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> > =C2=A0tools/testing/selftests/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 1 +
> > =C2=A0tools/testing/selftests/devices/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
>=20
> > =C2=A0tools/testing/selftests/devices/ksft.py=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 90 ++++++
>=20
> This seems to be a copy of tools/testing/selftests/kselftest/ksft.py.
> Instead of copying the file, try to use it from the standard
> location.

This series is almost 1 year old and has long ago been merged :)

--=20
Thanks,

N=C3=ADcolas

