Return-Path: <linux-kselftest+bounces-40932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CFDB489C0
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 12:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36F83B5FDC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 10:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135A62F99A5;
	Mon,  8 Sep 2025 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qe9MpACX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71E2F7468;
	Mon,  8 Sep 2025 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326438; cv=none; b=UOwcO2RMIfpcLO9tYLoOFf1vzWrXHSZNHY97N0Ksfuz49+ZyULFZ9/Y7RVV8E6uwCoBkgEx81t2a6cPajn/wvXomTFfkx+zXHl3QCM8UmmzR+zFkroN+K83bMiPG/fpR4XpSif6HpNwlu4EiYp8zUaR86Nx71y+EDrE07UMmGcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326438; c=relaxed/simple;
	bh=V94qzqT6EmHCxPQT3ZN6FCJ70fG56TOb8lu9nQhI4D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE1fGZnYJCjxcJr7oMFwdqFiqXPPqXh3IQZBxIx3N67Wyydtm7MwMHWsqc8/JZglOWsntihS6J0HmIhAE5B2Al+J7wRhJQuE4j+K/S6v6wrRhM0tSdOdxki4Ic6bmvXuJV67r2rl++LXuSj/n3fMWPlLWswAVQlWErGVxODEiCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qe9MpACX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983A0C4CEF9;
	Mon,  8 Sep 2025 10:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757326438;
	bh=V94qzqT6EmHCxPQT3ZN6FCJ70fG56TOb8lu9nQhI4D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qe9MpACXkeUd9jHlN1j//64hnAQuYMHeyAldfY/FEO6qlFulWpVjw3Nk153/wETUO
	 2dPXGI7kveHUxJ28u890X2oP8hoyFTsgwp1l5TZIZyFNHXYZuIlLlu7Wp7bns6FHXM
	 pYIfPBGlcf6p1d17B/9C18KfZfsrpwpXCaKxYGhAXkFiVm8Rv6U6gnpqxe+P3sksSD
	 uw5NpW/o6wI81YtfEzn1uuENY5rLBZmH+YfZqIZ7Xur2xWS8uOzYqfPVPUSYJEdX2I
	 skWkN5WUW0VquYPE6/6rWoJf7AXD6KJKWc+WYiDht8R1KkGeeocCNurcgjdjc0PRzm
	 22Doa8LY3Wmpw==
Date: Mon, 8 Sep 2025 11:13:53 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, david decotigny <decot@googlers.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	calvin@wbinvd.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net v3 3/3] selftest: netcons: create a torture test
Message-ID: <20250908101353.GC2015@horms.kernel.org>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
 <20250905-netconsole_torture-v3-3-875c7febd316@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-netconsole_torture-v3-3-875c7febd316@debian.org>

On Fri, Sep 05, 2025 at 10:25:09AM -0700, Breno Leitao wrote:
> Create a netconsole test that puts a lot of pressure on the netconsole
> list manipulation. Do it by creating dynamic targets and deleting
> targets while messages are being sent. Also put interface down while the
> messages are being sent, as creating parallel targets.
> 
> The code launches three background jobs on distinct schedules:
> 
>  * Toggle netcons target every 30 iterations
>  * create and delete random_target every 50 iterations
>  * toggle iface every 70 iterations
> 
> This creates multiple concurrency sources that interact with netconsole
> states. This is good practice to simulate stress, and exercise netpoll
> and netconsole locks.
> 
> This test already found an issue as reported in [1]
> 
> Link: https://lore.kernel.org/all/20250901-netpoll_memleak-v1-1-34a181977dfc@debian.org/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Andre Carvalho <asantostc@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


