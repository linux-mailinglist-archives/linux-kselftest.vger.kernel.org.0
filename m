Return-Path: <linux-kselftest+bounces-47989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B94ABCE6E5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 14:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16BC130054AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 13:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279593195EA;
	Mon, 29 Dec 2025 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="bC783KNG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682E15E97;
	Mon, 29 Dec 2025 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767015772; cv=pass; b=ujSnpW7RZEgL2cEzPQvnkwaguk5YPZTmFL8pBpBFep23rQvBKhJA580ZECaY1w+5SDatY/VwlH04lheoGgZMWX0/q21QA+dnNcBZIhXUNuB+obvz/x4g22lHHcwUGfjGeVlUQRGNXbdOejmij1emlVh1etzXllnMynKGVSRSOMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767015772; c=relaxed/simple;
	bh=loCDhH16hbvH6uwGQ8ZSORTaqZeAjRiHnxvhaBLqn4E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yd6wrKHfeBjowfRpN9soXIVHmj1mBjFV7n8RwPpXCNDUOUES/vpcre62MfPzliJo61rSTyCSaARkLHpVhcRqiEizXLPhUxFsYbqUX6xwh1/Djo2m1J/jbT/0THR6D82DWv9vjcJ1Z5TBV9KMZsiBmZek7TO9Frc7w6cBXMMn1p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=bC783KNG; arc=pass smtp.client-ip=136.143.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1767015748; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DPWRYSMaaqsR9iLHuzeqRrSSXj/wQvdIqJnuhyfrriWbQwcK0TCOX3fDWbIrILheiGdZOBIGN1i+alM46y4dPbrkWFmzfpUk5ZuyPpFUVSIEcFnxxjjsdmkrTVV//uQZvr/8b1G/eI4jbKR48gtFvIgY+EkbmsPI8D6t0BOaqDA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767015748; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=loCDhH16hbvH6uwGQ8ZSORTaqZeAjRiHnxvhaBLqn4E=; 
	b=JCtK0jgedzPwFGeo2Fgk5J84uuogg5MYhx+0qrKm4N33b7vRfQMpTWzZENVxT1hoifIau/cMhJ0rdNzIMWh0XDuX7lHdt/Ytuvpp05rf1urq7rsjunug8LeZ7FQAE9AoY76/0EmkG1M4CPc/YKKPZj+KtYBUW90itdbrwFTW9EY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767015748;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=loCDhH16hbvH6uwGQ8ZSORTaqZeAjRiHnxvhaBLqn4E=;
	b=bC783KNGrgv9DveVtr5RCCqZ6mUyzC+OoHS6PCY/4kKXGA7e94MvQM/YHjrK0IaY
	59nb3lRUMP5ZrrgXZwHfwo5tyaMJYEnJpHpqzeLFsOZTf3kIYw9OJWzRinDL9whtgcM
	lUA9WLOfYeVBdqeSVUrymyFns+ZHjLZQ3Vg5UkFw=
Received: by mx.zohomail.com with SMTPS id 1767015745491743.7293494404073;
	Mon, 29 Dec 2025 05:42:25 -0800 (PST)
Message-ID: <78b4f1f60563fc854f5f4a54b42e0bac60715070.camel@collabora.com>
Subject: Re: [PATCH v4 3/3] kselftest: devices: Add sample board file for
 XPS 13 9300
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: Askar Safin <safinaskar@gmail.com>
Cc: Tim.Bird@sony.com, bhelgaas@google.com, dan.carpenter@linaro.org, 
	davidgow@google.com, devicetree@vger.kernel.org, dianders@chromium.org, 
	gregkh@linuxfoundation.org, groeck@chromium.org, kernel@collabora.com, 
	kernelci@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-usb@vger.kernel.org, robh+dt@kernel.org, saravanak@google.com, 
	shuah@kernel.org
Date: Mon, 29 Dec 2025 10:42:17 -0300
In-Reply-To: <20251228054804.2515185-1-safinaskar@gmail.com>
References: 
	<20240122-discoverable-devs-ksft-v4-3-d602e1df4aa2@collabora.com>
	 <20251228054804.2515185-1-safinaskar@gmail.com>
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

On Sun, 2025-12-28 at 08:47 +0300, Askar Safin wrote:
> "N=C3=ADcolas F. R. A. Prado" <nfraprado@collabora.com>:
> > Add a sample board file describing the file's format and with the
> > list
> > of devices expected to be probed on the XPS 13 9300 machine as an
> > example x86 platform.
>=20
> And now "Dell Inc.,XPS 13 9300.yaml" became the only file in the
> repository,
> which has space in its name:
>=20
> $ find . -name '* *'
> ./tools/testing/selftests/devices/probe/boards/Dell Inc.,XPS 13
> 9300.yaml
>=20
> I kindly ask you to rename file. New name should not contain space or
> comma
> in it.

While I understand it might be inconvenient that this is the only file
with a space in its name, that is exactly the string that is reported
by DMI, so it is natural that it would be used for the filename.

Besides, I'm not aware of there being a style guide rule that prohibits
space in filenames in the kernel tree, or that could have easily be
detected by checkpatch during submission.

Furthermore, not containing a comma is not even feasible, there are
tons of dt-binding filenames containing commas in the tree.

>=20
> The file name in its current form breaks tools. For example, it
> breaks
> "xargs".
>=20
> For example, the following will work in "fs" directory:
>=20
> stable/fs$ find . | xargs chmod -w
>=20
> But it will not work in root of source tree because of this
> "Dell Inc.,XPS 13 9300.yaml" file:
>=20
> stable$ find . | xargs chmod -w
> chmod: cannot access
> './tools/testing/selftests/devices/probe/boards/Dell': No such file
> or directory
> chmod: cannot access 'Inc.,XPS': No such file or directory
> chmod: cannot access '13': No such file or directory
> chmod: cannot access '9300.yaml': No such file or directory

You can use 'find -print0' and 'xargs -0' instead so the space in the
filename is not an issue.

--=20
Thanks,

N=C3=ADcolas

