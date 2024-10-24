Return-Path: <linux-kselftest+bounces-20563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE299AEE80
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 19:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68072B2295C
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1641FF05E;
	Thu, 24 Oct 2024 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pGdBVc4A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27F1FE0ED;
	Thu, 24 Oct 2024 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792007; cv=none; b=Ii26WpN6+QbwS6SuBxBLkT//cCBWxe/Rkz/QyA4qgnSx2BmVDE9eKbrb6D3fVOyYuL35url6LpnDtvtrRnWHr6JXaFtlPClcbV4nJmdvapOsutlLIgWekVEODLg0RwrsmxSJUGA4ihtxAuWOOFcOUmblLJRCdd41S1+gLUq1IRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792007; c=relaxed/simple;
	bh=W3VllNwtqRwVtIeBKaJd3C2VVqpPgbov///WpOSkPlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6Wz/E8A2ZXLf0luQHkyXv/dOvcWE7mQn1EAb77X0MoxnkBWFuN7TUy+jQln5yLZ/BvT+sHtrzzBriDUJGIh9FK4Q2EHx5YzZK+RWvhFH1X5t81ELPq3ipiNlEd//JVr4PR34MuGoh+tYPRClUpWhmr6R6vYHvUfSBbnxteqnRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pGdBVc4A; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729792002;
	bh=W3VllNwtqRwVtIeBKaJd3C2VVqpPgbov///WpOSkPlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGdBVc4ASaPLaghvUgQ0DFhiGKTEDqIoVFn1+HyNer1j93XXc5Cz5BjgV87wgH0CQ
	 B6nsj1eITJ7aMAWhWuAC9FR3zsdafizu1HIG9qFgRpaqxZbx9bzt4byAUFw5Z2MyGQ
	 BbQxFkD3lxxVK9S1FqDJkKWKfCkVuL2nfVUjbNeCIS/bI5w3FVpYYMmV5+XbERHprI
	 DeTa7IdFS/rJb7Kz76JJ/ZL0wYH2NE/1/QvvYzshXNOe0vtqNyDyo2X3dFX1p8mH9D
	 de8N5I/jXKxhNl8NwmS3DALC8CeQif3oOJygSYXrzZs4IJ2uKPB9aRmPcdKHpF/3T8
	 u2h8mOoubrz6g==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 00C2F17E36B5;
	Thu, 24 Oct 2024 19:46:40 +0200 (CEST)
Date: Thu, 24 Oct 2024 13:46:38 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Bamvor Jian Zhang <bamv2005@gmail.com>,
	Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, kernelci@lists.linux.dev
Subject: Re: [PATCH RFC 1/3] pinctrl: mediatek: paris: Expose more
 configurations to GPIO set_config
Message-ID: <a3d6b2b9-1379-4bab-a584-651ca66677ee@notapiano>
References: <20240909-kselftest-gpio-set-get-config-v1-0-16a065afc3c1@collabora.com>
 <20240909-kselftest-gpio-set-get-config-v1-1-16a065afc3c1@collabora.com>
 <01020191e0901d10-d427a5dd-af4e-4ecf-99e1-4bb051ad1475-000000@eu-west-1.amazonses.com>
 <8fdeec5c-5de7-44ae-9086-7930d02d610e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fdeec5c-5de7-44ae-9086-7930d02d610e@collabora.com>

On Thu, Oct 24, 2024 at 05:17:05PM +0200, AngeloGioacchino Del Regno wrote:
> Il 11/09/24 12:10, AngeloGioacchino Del Regno ha scritto:
> > Il 09/09/24 20:37, Nícolas F. R. A. Prado ha scritto:
> > > Currently the set_config callback in the gpio_chip registered by the
> > > pinctrl_paris driver only supports PIN_CONFIG_INPUT_DEBOUNCE, despite
> > 
> > [...] only supports operations configuring the input debounce parameter
> > of the EINT controller and denies configuring params on the other AP GPIOs [...]
> > 
> > (reword as needed)
> > 
> > > many other configurations already being implemented and available
> > > through the pinctrl API for configuration of pins by the Devicetree and
> > > other drivers.
> > > 
> > > Expose all configurations currently implemented through the GPIO API so
> > > they can also be set from userspace, which is particularly useful to
> > > allow testing them from userspace.
> > > 
> > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > ---
> > >   drivers/pinctrl/mediatek/pinctrl-paris.c | 20 ++++++++++----------
> > 
> > You can do the same for pinctrl-moore too, it's trivial.
> > 
> > Other than that, I agree about performing this change, as this may be useful
> > for more than just testing.
> > 
> 
> Nicolas, please don't forget to respin this patch.

I was hoping to get some feedback on the test itself as well, particularly from
Linus as the pinctrl maintainer, but it's also been a while so I'll send a v2
with the feedback here addressed.

Thanks,
Nícolas

