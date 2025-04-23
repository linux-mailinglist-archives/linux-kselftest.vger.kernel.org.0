Return-Path: <linux-kselftest+bounces-31464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A6CA99BE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 01:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C424636A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 23:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AC521FF28;
	Wed, 23 Apr 2025 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhoYZkrh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655981FC0EA;
	Wed, 23 Apr 2025 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745450174; cv=none; b=KfxlFxujxczrVDdLAMfoA4qcs7Ww2wymPdwYp4ywv6GVR6ZvE8R9b1OYMlg8SX8Uzba/jFbIuKnnmfLsUh673fIpwqqAYjzslW3UHmdQXcOpNLc0xnsnpYVAZvuWZIlGMplSodscixGeOD0UTS1jfKf8zr7MHStdmWpVTCunmkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745450174; c=relaxed/simple;
	bh=NNcdf8wyavIjq8V75Q+5WpjSVOttiC0wv70XgJLK978=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+L0HOmwkvWCJGpUZCvPikJb6V+cgFuOqtEt1HxmjveQkH8aS7KEe25O1Q35UfJ7ITMRisuXZaY2DJiue+gJjV0NV9DPutrx/4QTfybGOOBkvwanlDcKjhZFU5etYbQ4alZ872LoixPV8wuiwh+vbM0J8Q/b3n+GV43lvz6MO6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhoYZkrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F65C4CEE2;
	Wed, 23 Apr 2025 23:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745450173;
	bh=NNcdf8wyavIjq8V75Q+5WpjSVOttiC0wv70XgJLK978=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mhoYZkrh/6PQrecbFzIPV7nC1SCMm+/o4D6peTMth39CUvLyczBz0uynPqozhn99I
	 ob3Rben5hiZ1KRuHsOX87s0ls0nysrZeRlpw0Jt9S2O96GZWikw5IuVhJFlhFEzs0T
	 pUdYcwYArpjuUw5bMR0NpoIUOFIPXwKPqzowAW11wi5vvcD5QSXQ9w4+JSed5OBr+U
	 Nt7gnqQd+R3m9eYBtCXVLDPU9dZoSawhZpYxxD7KxobzLFy2Zw0gd+xBxT1Rt8FmJu
	 ZflJ4n3Iqg40hcnCaGxIv2PsjaZeXjIOU//6VFSkQsTRnAQaY4P+kja0s6PG3ox4uS
	 zfMlbJOljO3Hg==
Date: Wed, 23 Apr 2025 16:16:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, shaw.leon@gmail.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org (open list),
 linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
 bpf@vger.kernel.org (open list:XDP (eXpress Data
 Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: Re: [PATCH net-next v3 3/3] selftests: drv-net: Test that NAPI ID
 is non-zero
Message-ID: <20250423161612.3dc2923e@kernel.org>
In-Reply-To: <20250418013719.12094-4-jdamato@fastly.com>
References: <20250418013719.12094-1-jdamato@fastly.com>
	<20250418013719.12094-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 01:37:05 +0000 Joe Damato wrote:
> +    bin_remote = cfg.remote.deploy(cfg.test_dir / "napi_id_helper")
> +    listen_cmd = f"{bin_remote} {cfg.addr_v['4']} {port}"
> +
> +    with bkg(listen_cmd, ksft_wait=3) as server:

Sorry, not sure how I misread v2 but you are running the helper locally.
So you don't have to deploy it to the remote machine :(

BTW does removing the ksft_wait() from the binary work? Or does it
cause trouble? Don't think we need to wait for anything in this case.
With the XSK test we had to wait for the test to do the inspection
before we unbound. Here once we get the connection we can just exit, no?

