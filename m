Return-Path: <linux-kselftest+bounces-48746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B23DD130BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 15:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40F693002517
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7899220F3E;
	Mon, 12 Jan 2026 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmvlsE75"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CDE28690;
	Mon, 12 Jan 2026 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227404; cv=none; b=b9gc9773lCIWtV6ms+FgcSnx33FznaI2m2FRYJWZxLR4iHh7vJ0KZXyMZR2Uw7yNDml2KVhyFJ0pquR1HxZnXCi6i/3wUtOEyDYTMrl8L8TeLsmfEQlJy1jugA4QJ4CgL/nxWKQ/VHU6H8VFeEJOkVl9qAvZQPolU+jVNz7Ncwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227404; c=relaxed/simple;
	bh=ztHBtvGcybj3dsBPKv0k2gbvi+YFEDr0EbkHLu1JXrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYex3Svx7zvS9w4hmx2J87bc1SoeG5HC+iee3GlmHAx85rMgZp8tdtF3NEHWJKUCu1Qn3fM0WsCAs3Lv5W+vYDQCWIwk4ZumFmA3KosMqk2QFlwPOP+TiAwr+CJ4qPMUVC+hCJ2XOW+k6eKzFoGNqWLAGqoxh2vvJtxLq2472Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmvlsE75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F66C16AAE;
	Mon, 12 Jan 2026 14:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768227404;
	bh=ztHBtvGcybj3dsBPKv0k2gbvi+YFEDr0EbkHLu1JXrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WmvlsE759zT5pmPkDvaJuWQxADawz+RCMCEZWWH3ndAjdcmvNo/Zi/CSXwt81M8wg
	 IxPbF0pUTowBVnrOT0O4q2/kUlYaJpMaAqLP+IA2FRZcNCo3Q/g2+t2O8vqQpmkOPZ
	 5BuLVNXAb8m8DYYRaBCEZ2WG9c0LqEcpW5ymn4iPX2W7FNxao1KQmkuvuhXBAwvmlT
	 o883bivaQJyCIXB/teX/HNBMeeQk0UqjENH5TLLXRmg2OfRTDf/XtWfdI6eTmgbJqy
	 ZwVfw/KpjjJQ0jFMth7MwB20NpTQR/LJijKqRqJNHoF5+xWugf+RicUYqiUnVeaYuX
	 e8pmaZc5uVbHA==
Date: Mon, 12 Jan 2026 06:16:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v10 7/7] selftests: netconsole: validate target
 resume
Message-ID: <20260112061642.7092437c@kernel.org>
In-Reply-To: <20260112-netcons-retrigger-v10-7-d82ebfc2503e@gmail.com>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
	<20260112-netcons-retrigger-v10-7-d82ebfc2503e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 09:40:58 +0000 Andre Carvalho wrote:
> Introduce a new netconsole selftest to validate that netconsole is able
> to resume a deactivated target when the low level interface comes back.
> 
> The test setups the network using netdevsim, creates a netconsole target
> and then remove/add netdevsim in order to bring the same interfaces
> back. Afterwards, the test validates that the target works as expected.
> 
> Targets are created via cmdline parameters to the module to ensure that
> we are able to resume targets that were bound by mac and interface name.

The new test seems to be failing in netdev CI:

TAP version 13
1..1
# timeout set to 180
# selftests: drivers/net: netcons_resume.sh
# Running with bind mode: ifname
not ok 1 selftests: drivers/net: netcons_resume.sh # exit=1
-- 
pw-bot: cr

