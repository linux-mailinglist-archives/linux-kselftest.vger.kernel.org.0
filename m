Return-Path: <linux-kselftest+bounces-20455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B5A9AC9EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 14:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FA41C23E4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 12:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8C91ABEC6;
	Wed, 23 Oct 2024 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3VefHzG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B26130AF6;
	Wed, 23 Oct 2024 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686094; cv=none; b=BK0doXoc7HT5VPSgp6vqjEkxIG2JqDTpUIzI1ONUzEOjH4VvdTw1wj3YCfg/7DRB0ZuXOkuq/4XEuHxTAoNZk6+Ei/8kNsv0XuQpm6IbAc8LKelcHXssVNg9iqbrU+9M6zsWsZVJnJTcGzxKzLaYjoDjfQ33VCWtssaPXL0z93w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686094; c=relaxed/simple;
	bh=dE8gsfJuB5sXdnBlViRbdT2SvbwyYF8eDW7UxnKv4K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prx/unmTgSxf8Nppg6zOP6Waym4TAX9ME3Y4RXyCBL2H2+/2S2TAAybVZvKumVxvxw1CIYrhsk//NyWU8Cny3S08hatcUh2Nl/CeNIOBJ83ulEavBb+ND7NXJOsGamYIQM6vdU9oyQeHir2p2BYDgLc3przGbrgAeFyOx9DyHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3VefHzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C10DC4CEC6;
	Wed, 23 Oct 2024 12:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729686093;
	bh=dE8gsfJuB5sXdnBlViRbdT2SvbwyYF8eDW7UxnKv4K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3VefHzGhG4D1LfAx/S+bMxOUYx6H9IUxueBGxfY3DRkLh9PXS/JPoDlHkRMigSrw
	 KxLu22ngqlM/vOVrO/bu8MZaPJ4jQhCL0r0MuEl7ndTJAdVMtJ8eyTRcwurLLbCZBY
	 WtRGVMbcSzKSHxLkQk/u4c3uHBBndd0W0ScHNxfsb2Eg52iIGMRfZ7oVIeQyIRy3qw
	 ZT9iBKrnVPHWqzpFe03j8m62iBYqcb0cWI1Gedmjv3zqFZYr4FENNiO+lFzb+HLCP7
	 3G3cC+JXxYUMrKho/q1Pb84r0GNrZV9Jzpd9kZZjb/z8kdgeCeY74vLLb3pa39dcko
	 ebDSVHVpXtIyQ==
Date: Wed, 23 Oct 2024 13:21:28 +0100
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregory Detal <gregory.detal@gmail.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 2/3] mptcp: remove unneeded lock when listing scheds
Message-ID: <20241023122128.GT402847@kernel.org>
References: <20241021-net-mptcp-sched-lock-v1-0-637759cf061c@kernel.org>
 <20241021-net-mptcp-sched-lock-v1-2-637759cf061c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-net-mptcp-sched-lock-v1-2-637759cf061c@kernel.org>

On Mon, Oct 21, 2024 at 12:25:27PM +0200, Matthieu Baerts (NGI0) wrote:
> mptcp_get_available_schedulers() needs to iterate over the schedulers'
> list only to read the names: it doesn't modify anything there.
> 
> In this case, it is enough to hold the RCU read lock, no need to combine
> this with the associated spin lock.
> 
> Fixes: 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers")
> Cc: stable@vger.kernel.org
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

I do wonder if it would be more appropriate to route this via net-next
(without a fixes tag) rather than via net. But either way this looks good
to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

