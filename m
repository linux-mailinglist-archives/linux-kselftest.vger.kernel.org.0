Return-Path: <linux-kselftest+bounces-15862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0A995A135
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459AE283BB7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF0913C672;
	Wed, 21 Aug 2024 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="FJv7/2Jk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783C136E3B;
	Wed, 21 Aug 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253533; cv=fail; b=CR2C19BLUX3TwZMfyRv2d6jfQOVXzaIiCeXpic80t49VNYbw8+qC8n27GROe9yxpXTupWRsF2xc+kV4pbrltNdsRwdzW4hpCdwnMZLyh4QZ7cv39p/+7ioCrFC4ghXKX7tJqRZq3PueimAzsr+624LbyeywWTrD8sSvI3BsjZtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253533; c=relaxed/simple;
	bh=CXjpyINpxRH6Z7MOmFIfH7fCLD4Jr3usdd/h11T9ixk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQx3AKawwzILe67TaeTxQP5jonu1KVBIdPqB0GErSXpolRrb0fG8jX7QBs21brRcXXKZr710oApDRLWoqtCIdDgE5XY1YAzzIgSbKB9moDKoO1YVoxE0QlgY/UpjEtV714Z7KiEY4XtQvoAvBUirCyFnnZsNl8RgwgFsyMPoRg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=fail (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=FJv7/2Jk reason="signature verification failed"; arc=fail smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724253515; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Lh8vnPytgHq2o5OOeZo6XtCYvapq6Qen4J5DGgNJrzRSfw2sMwxxL11C5NoibU09QhdyQvd3llqZGMeqFTU47uPDx5pwBmtULNnJNrwU45RL0dtsWDTUkGm801Wxo+OUdQ0jI1GPvWNvr9eWbFPVvesh28wAqjrqsPk+zE6dDIk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724253515; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1Fb5atcA7ATnuJjYnZhVOGtdn6H2wHhzoyLNJvImPGQ=; 
	b=QRX4++rYTobm07j+mdrhVOPWcjsobff9gY/ozMGogavGJgEVzgPk1llPP1KjPzSYVABF9pmBWwsKJFFudfIlZzdOfKyIVZab2p0QnkeNx2yx5SggLwq066GGZjBxSuJ4SlmH0VxQFlAKKaKJLC4Goipna/5mUkTskx3oymPfdDw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724253515;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=1Fb5atcA7ATnuJjYnZhVOGtdn6H2wHhzoyLNJvImPGQ=;
	b=FJv7/2JkDtO9f3vkWKHVxB/VBQhvUC9/VIOCAKagJcRwU9lATF3gNOCCFkUwN0Fg
	/LmXovimuGp84hGqbk/byc0wu2d0mNisCz+u3FLRlzuAsC9DefG7DGrLBNlgXETEBMC
	Bf4Xz4UU0xVGa5x9o2rI6/C4aPxhfjooZo7ZXq+U=
Received: by mx.zohomail.com with SMTPS id 1724253512751927.2733355263264;
	Wed, 21 Aug 2024 08:18:32 -0700 (PDT)
Date: Wed, 21 Aug 2024 11:18:30 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kselftest: dt: Ignore nodes that have ancestors
 disabled
Message-ID: <996ff9dd-65f6-4db3-9119-3e1c479e6e2c@notapiano>
References: <20240729-dt-kselftest-parent-disabled-v2-1-d7a001c4930d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240729-dt-kselftest-parent-disabled-v2-1-d7a001c4930d@collabora.com>
X-ZohoMailClient: External

On Mon, Jul 29, 2024 at 04:56:02PM -0400, Nícolas F. R. A. Prado wrote:
> Filter out nodes that have one of its ancestors disabled as they aren't
> expected to probe.
> 
> This removes the following false-positive failures on the
> sc7180-trogdor-lazor-limozeen-nots-r5 platform:
> 
> /soc@0/geniqup@8c0000/i2c@894000/proximity@28
> /soc@0/geniqup@ac0000/spi@a90000/ec@0
> /soc@0/remoteproc@62400000/glink-edge/apr
> /soc@0/remoteproc@62400000/glink-edge/apr/service@3
> /soc@0/remoteproc@62400000/glink-edge/apr/service@4
> /soc@0/remoteproc@62400000/glink-edge/apr/service@4/clock-controller
> /soc@0/remoteproc@62400000/glink-edge/apr/service@4/dais
> /soc@0/remoteproc@62400000/glink-edge/apr/service@7
> /soc@0/remoteproc@62400000/glink-edge/apr/service@7/dais
> /soc@0/remoteproc@62400000/glink-edge/apr/service@8
> /soc@0/remoteproc@62400000/glink-edge/apr/service@8/routing
> /soc@0/remoteproc@62400000/glink-edge/fastrpc
> /soc@0/remoteproc@62400000/glink-edge/fastrpc/compute-cb@3
> /soc@0/remoteproc@62400000/glink-edge/fastrpc/compute-cb@4
> /soc@0/remoteproc@62400000/glink-edge/fastrpc/compute-cb@5
> /soc@0/spmi@c440000/pmic@0/pon@800/pwrkey
> 
> Fixes: 14571ab1ad21 ("kselftest: Add new test for detecting unprobed Devicetree devices")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Changes in v2:
> - Rebased on v6.11-rc1
> - Link to v1: https://lore.kernel.org/r/20240619-dt-kselftest-parent-disabled-v1-1-b8f7a8778906@collabora.com

Hi Rob,

gentle ping on this patch. It's a fix and has been around for a while.

Thanks,
Nícolas

