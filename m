Return-Path: <linux-kselftest+bounces-25089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC12A1B582
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 13:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717C316BF5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9601EE7C5;
	Fri, 24 Jan 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWQQv3Ug"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B36C3594D;
	Fri, 24 Jan 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721017; cv=none; b=TtT2o7p0j8OhbS6hxToNQIVTm5OK802Lg/OW+J4glf9/ERs6xVqwcxosX+RG5MroY0T72iRLmQ1Fg6Fy9KwqI6fUwn9GvnMwpwhC6TVhHzby34qY/7J1Vh/7pxNzHEgRpMB6L+DAvTTyhpuwQM0J7jvmU8GejqrsjgCAXH6i1bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721017; c=relaxed/simple;
	bh=9/zDMqN6hhaBomecOPelO7rWtXLPgec1udymjzwGahE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QcrTLObIqTqsff0fNDoyX6geCMJ6PfXM5pin+X892YNR28Q0nyF6CRbvcjSK/oCc54tVP5HvgxxD7s7NpQpbaxYIYW/0ow2SGBED4Vi+2DCQbtORSmDdca+K/jvPMg2vyCl/4DPlI89xos0DfGD8MTK5lkaBBCAjzwzL/7cOk2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWQQv3Ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67084C4CED2;
	Fri, 24 Jan 2025 12:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737721017;
	bh=9/zDMqN6hhaBomecOPelO7rWtXLPgec1udymjzwGahE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=eWQQv3Ugf4xoyIoBxAR8/sos283LO4tfdtueimw31HSVDOwgMGB2kNZZjf66Dh0hz
	 a6I1ULEjZyhOvrOUc6AeIeqjkUJNyN1XggtE5/hweH1G/K00T8rfWPCVrcG7yaIRPA
	 x6u3EX8rgtXrld9535e+lpZovv6mPWAHhz+p9KKX3xEGzGgW66k4DaL+AU/wyGeIBG
	 d8ukAc8lExSOcWXjbHtFdQ1e7We3n4HIl24sN4qcJNDa+BdbKRAIKXlK31y52ODIq9
	 IA5m48dT88TqN7E8sRAKrgIRUrPcpk7CXYyYrKvjz6WQYrhTeeORinbGugexmKmiGa
	 d0joC22bDyNIw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jan 2025 14:16:52 +0200
Message-Id: <D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
Cc: "Vignesh Raman" <vignesh.raman@collabora.com>,
 <kernelci@lists.linux.dev>, <linuxtv-ci@linuxtv.org>,
 <dave.pigott@collabora.com>, <mripard@kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kselftest@vger.kernel.org>, <gustavo.padovan@collabora.com>,
 <pawiecz@collabora.com>, <spbnick@gmail.com>, <tales.aparecida@gmail.com>,
 <workflows@vger.kernel.org>, <skhan@linuxfoundation.org>,
 <kunit-dev@googlegroups.com>, <nfraprado@collabora.com>,
 <davidgow@google.com>, <cocci@inria.fr>, <Julia.Lawall@inria.fr>,
 <laura.nao@collabora.com>, <kernel@collabora.com>,
 <torvalds@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
 <daniels@collabora.com>, <helen.koike@collabora.com>,
 <shreeya.patel@collabora.com>, <denys.f@collabora.com>,
 <nicolas.dufresne@collabora.com>, <louis.chauvet@bootlin.com>,
 <hamohammed.sa@gmail.com>, <melissa.srw@gmail.com>, <simona@ffwll.ch>,
 <airlied@gmail.com>, <Tim.Bird@sony.com>, <broonie@kernel.org>,
 <groeck@google.com>, <rdunlap@infradead.org>, <geert@linux-m68k.org>,
 <michel.daenzer@mailbox.org>, <sakari.ailus@iki.fi>
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
 =?utf-8?q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>
X-Mailer: aerc 0.18.2
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
 <20250124081250.GA24731@pendragon.ideasonboard.com>
In-Reply-To: <20250124081250.GA24731@pendragon.ideasonboard.com>

On Fri Jan 24, 2025 at 10:12 AM EET, Laurent Pinchart wrote:
> Gitlab as an open-source software project (the community edition) is one
> thing, but can we please avoid advertising specific proprietary services
> in the kernel documentation ?

I don't think we should have any of this in the mainline kernel.

One angle is that "no regressions rule" applies also to the shenanigans.

Do we really spend energy on this proprietary crap to the eternity?

BR, Jarkko

