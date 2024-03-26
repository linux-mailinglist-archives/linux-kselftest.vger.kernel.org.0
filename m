Return-Path: <linux-kselftest+bounces-6618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7DA88C15F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 12:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F062B232AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBCC6F06F;
	Tue, 26 Mar 2024 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btkLELeR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F836F060;
	Tue, 26 Mar 2024 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454373; cv=none; b=Ti12yrqBdtrUmZj/2NDLUGdreTXMydkO7H66SXu2gjgoN/F4KIxh8X1YqFCp0WyUH36bYALFgquIv+tOhDc9W7sX0seEoH2AiE7ElzSI1rJGKMgUTZ26yj+octM8UkFetcSuyb7YZWRkRlOql3eG/ynlLNqIecTVMYHM2CfdG9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454373; c=relaxed/simple;
	bh=staRgg3gzbLITS0e4pRWsJcx//2CF8dAZPbjAdbyxAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFvr4MtyqVfBP+M3D/6GgPhpoI3VH0t1I53XToQNmeBogcmTt9K61E15DZwyUYCOVY+Uy2Bsw9JmkSq+Q6xLwWsMHs8KCpvkIPH6MgV3ZKWlS5Terfp6dYhzIcFJ3CpMSglKxSiQ7T8wKYqAXqz5RzTUxBoxthLXnur65/K2Cws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btkLELeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1A6C433C7;
	Tue, 26 Mar 2024 11:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711454370;
	bh=staRgg3gzbLITS0e4pRWsJcx//2CF8dAZPbjAdbyxAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btkLELeRKcmI3Ie81lwvVV1GhVMzthcBlC4BpVnBJNIG/4I/ncL+wWVZGGDzFJZWH
	 /5G8agJQLPAF8XOhlObDsHJVnJsTDhHR9DpJd4b4cG7eMyCC8ARUYL0GuggYRrX3eZ
	 9ZXaAjK2wKDLYgeRiN/CFrSlGHUZ/RZOD4QcwCpN9VhzY70qeADzIJVwDfzzvIHlF1
	 7ZMOq0dzkc2S5arzmpQ2fTzRqMWs3SaxhiUcXV1zrsdfKceQpc14yrJbVPxHR3vbV4
	 GUOP08JibVEkoKHhba9Ig1ikEXoiKgr55nMsrp7rtgSJUFhm+v/5XGYtTPBRfuFSdn
	 6WDInjH6WRFZQ==
Date: Tue, 26 Mar 2024 11:59:26 +0000
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 3/4] selftests: tls: add test with a partially
 invalid iov
Message-ID: <20240326115926.GR403975@kernel.org>
References: <cover.1711120964.git.sd@queasysnail.net>
 <720e61b3d3eab40af198a58ce2cd1ee019f0ceb1.1711120964.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <720e61b3d3eab40af198a58ce2cd1ee019f0ceb1.1711120964.git.sd@queasysnail.net>

On Mon, Mar 25, 2024 at 04:56:47PM +0100, Sabrina Dubroca wrote:
> Make sure that we don't return more bytes than we actually received if
> the userspace buffer was bogus. We expect to receive at least the rest
> of rec1, and possibly some of rec2 (currently, we don't, but that
> would be ok).
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


