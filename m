Return-Path: <linux-kselftest+bounces-46598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B75FFC8C960
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 02:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6A5C4E1DF8
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 01:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852D421770A;
	Thu, 27 Nov 2025 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp83jhUP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907220E03F;
	Thu, 27 Nov 2025 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764207410; cv=none; b=sB0ieVtA4Q0DE5x/BvPp1NRxXWKT/x9J0hR0gPuPHlpEBk3cniYEft//t7ISdbyzo1ZqgXW/VcpkpqPNa+3dsloM2djb7gspND9dhDtfaOJOznKoJVHafUj7il58aLTEx6IQ7Ke51tC2GK3gcZxj2kCHj423MP7G9r3VsrRFzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764207410; c=relaxed/simple;
	bh=DkSzyBbm8LAaNI51IZ7Ph7CrpZ9emDRymVlXWzz2Q8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euxf/hQm7OJoCLyACJ0XPtHLQiSFj/3h1TIJAttqP+OVD75NpRcbC3g6/o3Md4sGO4HTgOUJ44s61vjgd7FKE8JJYVfaQzj/CcpIZJocCbZs2/na2CmQXI2JWMsWG7LoCjf9NBnYi0Gy7AkTOCVEU7FA7K1oiA/jl9qbB7lyyvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hp83jhUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756FFC4CEF7;
	Thu, 27 Nov 2025 01:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764207407;
	bh=DkSzyBbm8LAaNI51IZ7Ph7CrpZ9emDRymVlXWzz2Q8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hp83jhUPZLatowt7+3ZPT/a7nFr+rgIKNWdW/CJDwf4WLX6Qsx523ewu6xdSUxP7/
	 79ECMBeV99ltMGQ8Pg1rDKqObeAnRx2kHrd5p1T8qur3t8mIHEJp0TcOe/V4s1s7ks
	 fd9nddEQmSUAGzymOs3Fx3YvmJ0JHLsEWVvd/3mV82/mcZFpO4PHbmY5wzGlxs8UZi
	 HO23lNUiUNca5whQI1InS7ZNPD/YMCtv6Jv0AOSUcz5ehXKllMbLcS/3mTFaC76gkU
	 tnYsjSh+L4A4VSjy0WzX/OBKaPKZ2CLV9NIUM1HQ+Xyt3Zfs80peVsgOOBW3W5D9vn
	 MtJec2DBlqtMw==
Date: Wed, 26 Nov 2025 17:36:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/5] netconsole: support automatic target
 recovery
Message-ID: <20251126173646.696537af@kernel.org>
In-Reply-To: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
References: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 20:22:52 +0000 Andre Carvalho wrote:
> This patchset introduces target resume capability to netconsole allowing
> it to recover targets when underlying low-level interface comes back
> online.
> 
> The patchset starts by refactoring netconsole state representation in
> order to allow representing deactivated targets (targets that are
> disabled due to interfaces going down).
> 
> It then modifies netconsole to handle NETDEV_UP events for such targets
> and setups netpoll. Targets are matched with incoming interfaces
> depending on how they were initially bound in netconsole (by mac or
> interface name).

Netpoll does not seem to handle DOWN events, so I'm guessing your
primary use case is that the device had a HW fault and netdev was
recreated after device reset?

Should we not be listening for the REGISTER event then? On boot
we force UP the device if we find it, theoretically there may
be a case where user space is not configured to UP the device,
and then we'd never resume the target?

