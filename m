Return-Path: <linux-kselftest+bounces-17185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE5696C9E7
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 23:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0311C24B1C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DFF1714B4;
	Wed,  4 Sep 2024 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJqIymxa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456AB153812;
	Wed,  4 Sep 2024 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725487039; cv=none; b=qBeE6sZ4UwZcjDuPlWsEvcxWJRyoX+itENxpHucV0RD8Dz/Vmok+RZTaPrptuF5rXXDU19gRexL+hIbwhLrZMKuNCdlJnGLW2eE3r4nUvSy30uKpc7dG70lPzz2ELP5D6vqaFGd9c9XkRQTXGys0/jIVpsDRqEPKv1rLNUclDio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725487039; c=relaxed/simple;
	bh=pWXLQi9HAt8TD80TUlEHOmmJNEUgzTpEdEY+qoZNg50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0YKnLFBumDlFymt7LolOBxGL1r/zNg3DxaHCprC2YwphvMN+U8jo/MYC4N8bIrlRf4rM+8O08yxwdVaTpWgBNfeW7+0vZljOIEry01cbFZSmP0JLDYQ3JWnFCqdCBbwfeuK7Of6m28K78d7ttIMlssgn/72zQCUoFAgNp3SBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJqIymxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872F2C4CEC2;
	Wed,  4 Sep 2024 21:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725487038;
	bh=pWXLQi9HAt8TD80TUlEHOmmJNEUgzTpEdEY+qoZNg50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJqIymxabVXbkQOwXq1ziARBYNlHVYEIFli6ezCLTtQrYsHGxeQrfzuEJP7L+0jO5
	 1jIhVy48y1lwsSAfHq/hqW25vx1lgq8mKIeLehVcFHqN0ymW+XYuxp+FVtBW4nyRSC
	 RYTuCETJEcvECcAzL5d5yHdIDKhUSge0OavrwZX/ff5Cxt9MUc4CthlKewvTriKquR
	 4SsXDQtyiKMs8pCn9D3+EHlAj+yhQZfObGPNduqHFxFclpM7srQ4ZAvbJpvTyYSxb3
	 dAGY63EZ6Pe7qlSZryCoaEcOHcaCWRgCrFCp2YwTLBFHUHnw5Nag9B8ZonPLerT2Co
	 IqHU+CvNgoAXw==
Date: Wed, 4 Sep 2024 16:57:17 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Saravana Kannan <saravanak@google.com>, Shuah Khan <shuah@kernel.org>,
	kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kselftest: dt: Ignore nodes that have ancestors
 disabled
Message-ID: <20240904215717.GA3398497-robh@kernel.org>
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
> ---
>  tools/testing/selftests/dt/test_unprobed_devices.sh | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Applied. Sorry for missing this.

Rob

