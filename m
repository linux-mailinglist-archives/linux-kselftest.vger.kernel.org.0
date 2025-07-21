Return-Path: <linux-kselftest+bounces-37761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2046B0C7D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 17:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FE43AE699
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 15:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3862DECBC;
	Mon, 21 Jul 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgbipwdA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9F1ADC90;
	Mon, 21 Jul 2025 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112449; cv=none; b=YEYB+JDgpVHjUf17TH+LGBShIq/XX7Hpt47BVlTUw7IDq14dRVKhhSzJ3h848jxSvePhTApPIkInaw24f81A7+n3h+6DqIrUNeU2KFpDKCfQPhQVwAHHpldiNg7q1BBZ60k6uGY99djma1zbXc+//q7AQnl8CP+uOTI8hxjkgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112449; c=relaxed/simple;
	bh=DgSOmx6CYfdPt7+e2WdBwvaKwxEtjgphHOCiRnjXtZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+GbIOmG/xJvQCRep8HLDNNOmwq3PM0Citp361a3zm7K9ruOM9qaMKQxt5n9fa/8BbXg9xp2LszU4lOy5pjejjpuPxapeU2sVuXsTa5Tw6Q2G9cE9WVfOoDZqe0yekRBL7ZjZcZ2AZbjES1filRjD9c0+8VYPta+t06a6kYtMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgbipwdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D713C4CEED;
	Mon, 21 Jul 2025 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753112448;
	bh=DgSOmx6CYfdPt7+e2WdBwvaKwxEtjgphHOCiRnjXtZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DgbipwdAAx2zGAN2XoiTG4uovy2DPLWpJcb64mQnfoxOeUK4DUxxArYiam1/bie/N
	 OjFIbjr3d/gRfefLGE21r1h1FlwRCC5off8vGDRaNBcBjSmzzBckwVdxdYp3xVE3OF
	 4n6pM+W2nhqvarobVMm76vv4KGBvCDbcBWWAKSiWSEnYh5tg5ibRsmoFIJZhWpJfip
	 YgTkcM14e94Eg3U0sXLdADgBHbjY1UlazUOHP80+ahVb6ZDKfZBMqrLXT+HYZ+D/XR
	 SBZrcVHoqVBqJ3JLoXNolzd3J3nfXhywFOfLJUYQSjSzR+7Qk8ddGJl5wMcEnVDruR
	 as1CoggGZroCA==
Date: Mon, 21 Jul 2025 08:40:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nimrod Oren <noren@nvidia.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, horms@kernel.org, cratiu@nvidia.com,
 cjubran@nvidia.com, mbloch@nvidia.com, jdamato@fastly.com, gal@nvidia.com,
 sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 tariqt@nvidia.com, thoiland@redhat.com
Subject: Re: [PATCH net-next V6 2/5] selftests: drv-net: Test XDP_PASS/DROP
 support
Message-ID: <20250721084046.5659971c@kernel.org>
In-Reply-To: <ab65545f-c79c-492b-a699-39f7afa984ea@nvidia.com>
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
	<20250719083059.3209169-3-mohsin.bashr@gmail.com>
	<ab65545f-c79c-492b-a699-39f7afa984ea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 14:43:15 +0300 Nimrod Oren wrote:
> > +static struct udphdr *filter_udphdr(struct xdp_md *ctx, __u16 port)
> > +{
> > +	void *data_end = (void *)(long)ctx->data_end;
> > +	void *data = (void *)(long)ctx->data;
> > +	struct udphdr *udph = NULL;
> > +	struct ethhdr *eth = data;
> > +
> > +	if (data + sizeof(*eth) > data_end)
> > +		return NULL;
> > +  
> 
> This check assumes that the packet headers reside in the linear part of
> the xdp_buff. However, this assumption does not hold across all drivers.
> For example, in mlx5, the linear part is empty when using multi-buffer
> mode with striding rq configuration. This causes all multi-buffer test
> cases to fail over mlx5.
> 
> To ensure correctness across all drivers, all direct accesses to packet
> data should use these safer helper functions instead:
> bpf_xdp_load_bytes() and bpf_xdp_store_bytes().
> 
> Related discussion and context can be found here:
> https://github.com/xdp-project/xdp-tools/pull/409

That's a reasonable way to modify the test. But I'm not sure it's
something that should be blocking merging the patches.
Or for that matter whether it's Mohsin's responsibility to make the
test cater to quirks of mlx5, which is not even part of NIPA testing -
we have no way of knowing what passes for mlx5, what regresses it etc.

Not related to this series, but I'd be curious what the perf hit is for
having to load the headers.

