Return-Path: <linux-kselftest+bounces-25041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AE6A1ABE4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 22:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC86188A517
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 21:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4925D1C5F22;
	Thu, 23 Jan 2025 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljobwWhp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881D1C4A17;
	Thu, 23 Jan 2025 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737667922; cv=none; b=OFDM0NvHWxITpgLB423UCNyujER5qKDv4olmX27zUVvjCwJ7H27Dqf2Iqu0ONoDvcFpyyRTkY9QYoWEsc1Zq/PPzp1tgqwPh7QwSACWC+gRcKxDp/F71MlMRsHajr1BDPQsmBdsqZgMxjHQJZwHAQjTBE88A1mSDIv9R82dA/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737667922; c=relaxed/simple;
	bh=U43wl3m4iytgZwURelg9Dd1JSuKG4wO5ZGgaRjHkiYQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=U/OfztD7JywP7ev5pJEzhgF02bhdpIT7t7sCE0RfVQtIj5tkDqzZGK4LidQ8fb2QCx/V0ckLMBSVTlENg546ubAVhjtO1TtT7ghDpetSVYpKDS4iGLNN4UXn+ebAXGNb9YhUq2v6XGE3omH5KJWUNSUI0tgRDJ+fN8JMAjM0hwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljobwWhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1843DC4CED3;
	Thu, 23 Jan 2025 21:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737667921;
	bh=U43wl3m4iytgZwURelg9Dd1JSuKG4wO5ZGgaRjHkiYQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ljobwWhpPOWbHMWZfcZGBrqTEQWNSW4x8kKE8N10uOnz4Gmjy73R1KA/7PujDQrdG
	 nXfeKQ567VxWcLpobGbsYEY18BsNmEXo/G92okOwf8b+2HTay9aEuwVYZf0HxLZ12S
	 nst6+kC4CMjlsr+yndd9VMTIoofg7PQFUrS3nObaXgk3iZ6KBLCYZskndw5Vci2+HG
	 hfLSlR+3n8KScil9bF4K4fsXKHcy5KlX6OSypjgAEw3xxOA0IkRcbzesvn76J5PV4u
	 nfOFVoa2FcZoV/IBMsO6BAx80S8QMQmcpIDTHlWiqPw4xCNdLm02Se+Kh8AmBPzAQr
	 LYH2BzJvyZenw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jan 2025 23:31:56 +0200
Message-Id: <D79RV8GG76R9.1WM0XRR47WA0W@kernel.org>
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Vignesh Raman"
 <vignesh.raman@collabora.com>, <kernelci@lists.linux.dev>
Cc: <linuxtv-ci@linuxtv.org>, <dave.pigott@collabora.com>,
 <mripard@kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kselftest@vger.kernel.org>,
 <gustavo.padovan@collabora.com>, <pawiecz@collabora.com>,
 <spbnick@gmail.com>, <tales.aparecida@gmail.com>,
 <workflows@vger.kernel.org>, <skhan@linuxfoundation.org>,
 <kunit-dev@googlegroups.com>, <nfraprado@collabora.com>,
 <davidgow@google.com>, <cocci@inria.fr>, <Julia.Lawall@inria.fr>,
 <laura.nao@collabora.com>, <kernel@collabora.com>,
 <torvalds@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
 <daniels@collabora.com>, <helen.koike@collabora.com>,
 <shreeya.patel@collabora.com>, <denys.f@collabora.com>,
 <nicolas.dufresne@collabora.com>, <louis.chauvet@bootlin.com>,
 <hamohammed.sa@gmail.com>, <melissa.srw@gmail.com>, <simona@ffwll.ch>,
 <airlied@gmail.com>, <Tim.Bird@sony.com>,
 <laurent.pinchart@ideasonboard.com>, <broonie@kernel.org>,
 <leobras.c@gmail.com>, <groeck@google.com>, <rdunlap@infradead.org>,
 <geert@linux-m68k.org>, <michel.daenzer@mailbox.org>, <sakari.ailus@iki.fi>
X-Mailer: aerc 0.18.2
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
In-Reply-To: <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>

On Thu Jan 23, 2025 at 11:30 PM EET, Jarkko Sakkinen wrote:
> On Thu Jan 23, 2025 at 3:53 PM EET, Vignesh Raman wrote:
> > We are working towards creating a generic, upstream GitLab-CI pipeline
> > (kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipel=
ine
> > is designed with a distributed infrastructure model, making it possible
> > to run on any gitLab instance. We plan to leverage KernelCI [2] as the
> > backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
> > integration.
>
> Why can't you keep the next version of your great pipeline outside the
> kernel tree?
>
> If there is a legit motivation for doing that, why it needs to be bound
> to Gitlab? Why can't you make script callable from any CI?

To add, most of the distributions have their CI pipelines but they don't
proactively push them over here.

BR, Jarkko

