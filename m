Return-Path: <linux-kselftest+bounces-34850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620BEAD7E35
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 00:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5303A1C56
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 22:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD4C2DCC0C;
	Thu, 12 Jun 2025 22:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlUeoS/v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E16B79E1;
	Thu, 12 Jun 2025 22:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749765944; cv=none; b=C/GJ29c4u8Nz29esdnMKwC3Zz86EwMBG578znJBwEny31/4r3J5PgGvFa2h17JFTX1XnkQIG8zPhBqN/hwZgX8SI2kCHoGOt81Rel1zSu3iRCpdUXWGnnQbw64IQnGU69WraveWpGm8hZkONr5krpdP6TIDPO5+yJMy0+HUpJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749765944; c=relaxed/simple;
	bh=0Ec/5pPmG5khox1fV4h8x10KFEPU9qR+cjWZHft8eqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jw2y+6+t+z3FNmYMeAnxawK40BGNudPdv1u14egiaAecYv0Pm2BRJlWprOWzm2VTl04jNOkgj942NUMqEOfPTIbAR+JU6jt3QQJCDRwVKq48FAW4BaXBGjufIJkhZfovmBXg+M21F/rmqTWzDhbFvVTmj5eA3iXfqw3MXl0HEvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlUeoS/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768CFC4CEEA;
	Thu, 12 Jun 2025 22:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749765943;
	bh=0Ec/5pPmG5khox1fV4h8x10KFEPU9qR+cjWZHft8eqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QlUeoS/vDT/Q2HLbqsoTNtBbzmzsWMbMuo4KrRBCX9PtPSgH92WxHze7a/GyrTUHd
	 9fbc9hiyzvx5mdksaHcCT20AwNbgD6MJpbJATaI9DTrgusJhzRKMrS4CgJNwaFNfIn
	 /EF6CsSgxCnaME8DrXG1PZddZgmWFCsYs6SBboFhh8l95SfMpE9fvm+GES5TCm3IAI
	 I5Yeg5dUb2O3r/pLy9OnqFRprZQXqvGirSKY3KAxXosQwNypz6NDucVfNvfoBoKp+q
	 UtRAIVLE/V694GP1ZzNqwmyouh1ZKSKQKZbYNwPeCGpo1bn8BfH/x3QlV077tVS29D
	 7VTXeAX9e8ADA==
Date: Thu, 12 Jun 2025 15:05:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 7/7] selftest: netconsole: add test for
 cmdline configuration
Message-ID: <20250612150542.0b4a7d71@kernel.org>
In-Reply-To: <20250611-rework-v2-7-ab1d92b458ca@debian.org>
References: <20250611-rework-v2-0-ab1d92b458ca@debian.org>
	<20250611-rework-v2-7-ab1d92b458ca@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 07:18:56 -0700 Breno Leitao wrote:
> Add a new selftest to verify netconsole module loading with command
> line arguments. This test exercises the init_netconsole() path and
> validates proper parsing of the netconsole= parameter format.
> 
> The test:
> - Loads netconsole module with cmdline configuration instead of
>   dynamic reconfiguration
> - Validates message transmission through the configured target
> - Adds helper functions for cmdline string generation and module
>   validation
> 
> This complements existing netconsole selftests by covering the
> module initialization code path that processes boot-time parameters.
> This test is useful to test issues like the one described in [1].

I think this leaks the IP address, because if netcons_overflow.sh
runs afterwards it skips with:

#     inet 192.0.2.1/24 scope global eni370np1
# SKIP: IPs already in use. Skipping it


if netcons_overflow.sh runs first everything is fine.
-- 
pw-bot: cr

