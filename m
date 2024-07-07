Return-Path: <linux-kselftest+bounces-13290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ABF92993B
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jul 2024 20:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537EC1C209F1
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jul 2024 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EAB558BB;
	Sun,  7 Jul 2024 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaIrVkzn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0675381A;
	Sun,  7 Jul 2024 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720375329; cv=none; b=tg/6V4J00B3LLP9dz7rb4lqra8s2wd5oiWocM5u+QAGvkB2gyeiEAea3YI0s8lQFuN0QHnJI21yHEG+xmrWQW5fCTuX+aqFIFYvtCxWqV5qA6gli9pZ9RZu9O5W0FRtvkcczfZCZ2R69e/ikBjS4tj44Ek25Sk/dO/EWNYCpbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720375329; c=relaxed/simple;
	bh=YoijC6Vk1pkQnDOd+ZxBUq+s9vUL35PJZT2W3dIs6TA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=mEmRPkGlslxr/x1Kg3/LswCbwpWvpOwNXqwtXaSxV8V3fLGmcCAubxS24+oG07PK0+rY/HkypDA8k65T9NU6EcS+mnOktgzt22KCFnVrk+y+W61/u3dUhJGEKJBhWA5fb5NMuLmE2WmigvshjBtZNGE82/R5qpvWAqVoztQqBJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaIrVkzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618E6C3277B;
	Sun,  7 Jul 2024 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720375328;
	bh=YoijC6Vk1pkQnDOd+ZxBUq+s9vUL35PJZT2W3dIs6TA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=BaIrVkznuAXWqaVhAwxoyitCyyTIFU0/EtMQ2KPWxx2UAggoTQdiTstpBZZ2Fk0XA
	 WjTH5jP27RDRdggBD9J+hkVKEfuUW6JUwqHnoxJi/sici6oNNQj/wu4Dr+okHsL/wZ
	 Tsh7Hnjd3xcw4Z8NTHsr362ZA+N2YvTGa76UEcQ/QELXkaZn5V9gCq48faMDPTDAsF
	 Uzx1oZh5TXOg/wjsdDODlCGeELVt30SRq6Q8ekj6zsWqbQomDimVZDbZ4JqwY13Lis
	 p/LD4F4Ofx9O8j7Uxfjo+E8y39eoadVeM1k4s3DEMJE5VzhRNQxeI2sSscImXlTFRv
	 iHdSa847br+KQ==
Message-ID: <34d38e79a2008ed6e4303e6911b1cf08.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSk93mNY4diXppGWJZgWJhrHpGqECBXNROWkRCaZjFi2tw@mail.gmail.com>
References: <20240706045454.215701-1-sboyd@kernel.org> <20240706045454.215701-6-sboyd@kernel.org> <CABVgOSk93mNY4diXppGWJZgWJhrHpGqECBXNROWkRCaZjFi2tw@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] platform: Add test managed platform_device/driver APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: David Gow <davidgow@google.com>
Date: Sun, 07 Jul 2024 11:02:06 -0700
User-Agent: alot/0.10

Quoting David Gow (2024-07-06 01:04:25)
> On Sat, 6 Jul 2024 at 12:55, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Introduce KUnit resource wrappers around platform_driver_register(),
> > platform_device_alloc(), and platform_device_add() so that test authors
> > can register platform drivers/devices from their tests and have the
> > drivers/devices automatically be unregistered when the test is done.
> >
> > This makes test setup code simpler when a platform driver or platform
> > device is needed. Add a few test cases at the same time to make sure the
> > APIs work as intended.
> >
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Reviewed-by: David Gow <davidgow@google.com>
> > Cc: Rae Moar <rmoar@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
>=20
> Hmm... this is failing under KASAN for me. I'll take a closer look
> next week, but in case there's anything super-obvious, here's the
> report:

Thanks. I reproduced with your commandline and I'll take a look.

