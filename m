Return-Path: <linux-kselftest+bounces-21291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 211A79B90E0
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 13:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59841F23427
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C687E19CC17;
	Fri,  1 Nov 2024 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V8kGI6/O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CDE19DF41;
	Fri,  1 Nov 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462700; cv=none; b=dm0HdeFjF9TgUXRL+QPV8PPdFmLJZ1vikphc9CRtXPqJybUNGiddI+s03rU/ZJ2CqYXGgOYZGj4qkQD3pSL8eBmeVyqq9tUKJhvajgk6wGI/g5i0UnjIr/ul4Z+kln47uS2/zxDnv5sZDERFYpwmI2mV0AMlUVl6gL00PhdVG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462700; c=relaxed/simple;
	bh=VUpg8swfaMH8KH/YYd4yjICcXgkMLBMqp0RubHiLe2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jomQxWUKuKrKOV5AosG0HxK8mkOntwxwLFvYUXQlXWFkkkRXxG2+rgIFiJ4chp2pZniNJDWLj3VyUKrqnoYCR113ahIY1bhEbMsiFYA31BC96e8cGRmDSI1w/WyaoGyoyVAfbiByY/52KWBcGLAT7lJ9KARqT+UKy3PtxrW5axk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V8kGI6/O; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730462695;
	bh=VUpg8swfaMH8KH/YYd4yjICcXgkMLBMqp0RubHiLe2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8kGI6/OGf9VC0m9ypPCHAgD5grp8peLL1jVHBsKMKcQUcN/w1MyDpUQY5TngyiuY
	 SucTeTCT8+2RkPrpgp8k7dEipBeaEWF98mOy4iG6iP3vfIxvI28XhvJ7o/ChVp3H19
	 21n4VMIeO+z4mcyVF3/476PbEfeHQBb7RFqs2XeHru0kW6p+OqyQaVY8OHvi0unIIy
	 pvIDS4tBcJePoA9cHV1VgnOhQ6MU/6xMDc2S9EVnxfvbG+KzfKrTmsPnKHfJq6yTjJ
	 1XpH7imWfxuJOaz76QdRScHfYdOyYPqsR9zYrnAca0hj4SMYQS3Ei6QPaIfIYcqJbr
	 PtQg4h8JEmMPg==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B7E7717E1574;
	Fri,  1 Nov 2024 13:04:53 +0100 (CET)
Date: Fri, 1 Nov 2024 08:04:51 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bamvor Jian Zhang <bamv2005@gmail.com>,
	Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, kernelci@lists.linux.dev
Subject: Re: [PATCH RFC v2 3/5] pinctrl: mediatek: common: Expose more
 configurations to GPIO set_config
Message-ID: <4ed22f25-ad10-461c-be68-8472590db44d@notapiano>
References: <20241025-kselftest-gpio-set-get-config-v2-0-040d748840bb@collabora.com>
 <20241025-kselftest-gpio-set-get-config-v2-3-040d748840bb@collabora.com>
 <CAGXv+5H9OTCn033yoi6oxxRKG1G=vbrBK+aw+ZWwGPWbn=uWuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5H9OTCn033yoi6oxxRKG1G=vbrBK+aw+ZWwGPWbn=uWuA@mail.gmail.com>

On Fri, Nov 01, 2024 at 03:54:58PM +0800, Chen-Yu Tsai wrote:
> On Sat, Oct 26, 2024 at 5:16 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > Currently the set_config callback in the gpio_chip registered by the
> > pinctrl-mtk-common driver only supports configuring a single parameter
> > on specific pins (the input debounce of the EINT controller, on pins
> > that support it), even though many other configurations are already
> > implemented and available through the pinctrl API for configuration of
> > pins by the Devicetree and other drivers.
> >
> > Expose all configurations currently implemented through the GPIO API so
> > they can also be set from userspace, which is particularly useful to
> > allow testing them from userspace.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

> 
> Missing signed-off-by?

Huh, I don't know how the pre-send checks didn't catch it, will take a look,
thanks for pointing it out! I've added the SoB above so it can
still be merged if no further versions are required.

Thanks,
Nícolas

