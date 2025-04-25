Return-Path: <linux-kselftest+bounces-31622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1E3A9BC57
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 03:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F41466752
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 01:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC90645C18;
	Fri, 25 Apr 2025 01:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYgxEWUa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CD44C7C;
	Fri, 25 Apr 2025 01:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745544740; cv=none; b=mYMFCOGEK1GXZIXE72dkmx7aFhETWrcuPIoIGqyMHl9hYaxhWNHrpwxsqwR8fbYXMj1AWHT5zVYW5S0FL1wn75/rCUyRFkPpYfQXkl3RyS7kqEdjGsiisSHwaSy73ib/EcpaWzbUdncz2yKW4d1JzxIMOLUUwVDjI8z3nGA5+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745544740; c=relaxed/simple;
	bh=cBh+gfyXnG/5zUX1OThb0E6PXd8Fgz9lj5nqMPSzYWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hn30k+K/xroOkvvI4wKrRIJjAnxYOkrq7sckQcNrvjzyekBdAhZdZOqSoXz5rkQD/uroc1js6WuNniEyhOGvwu2Z8F+Q0gU8k8AM9VPVwVZ4EifM9p+96AOJMakFzhBzx9zp5GPNiV5mD6kplKzSmurpLuUb2Hve1wWREVM8A/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYgxEWUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D7DC4CEE3;
	Fri, 25 Apr 2025 01:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745544740;
	bh=cBh+gfyXnG/5zUX1OThb0E6PXd8Fgz9lj5nqMPSzYWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uYgxEWUa54NLntI8dwz7h1qP9ZngEsXNCDdUZ2X4P0bzCgpqvG1B/ox9YJkSqhkwj
	 cWWUX9DRSi9cFSNM7STQHIuQcmPESjPByqYhuVy92A4UjxNYq5rLyD1yBF2IBZleqr
	 9Ot67acG0v3G/u7onE+4+H90jGD3gH1k2v66C4ntZxTodBYROyq4p9ZX0nZAaF1dLP
	 rXKSRr2iQGS7eZznCfCJXVbuFW7sUKSq5ubXjQuXO585YmtviiRIUsK9OmLcXOlnDO
	 qkRRq5a4puWvp9T6GaFqqXk4gQcxErwty7f+xge1wWPtLnsx7jXPcskKPjsdcXYDdL
	 Mt63bNe1h4twQ==
Date: Thu, 24 Apr 2025 18:32:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, shaw.leon@gmail.com, pabeni@redhat.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org (open list),
 linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
 bpf@vger.kernel.org (open list:XDP (eXpress Data
 Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: Re: [PATCH net-next v4 2/3] selftests: drv-net: Factor out ksft C
 helpers
Message-ID: <20250424183218.204e9fd1@kernel.org>
In-Reply-To: <20250424002746.16891-3-jdamato@fastly.com>
References: <20250424002746.16891-1-jdamato@fastly.com>
	<20250424002746.16891-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 00:27:32 +0000 Joe Damato wrote:
> +++ b/tools/testing/selftests/drivers/net/ksft.h
> +static void ksft_ready(void)

> +static void ksft_wait(void)

These need to be static inlines.
I'll fix when applying cause I think this series may conflict 
with Bui Quang Minh's

