Return-Path: <linux-kselftest+bounces-3446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DAF83A696
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 11:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E60F1F21B4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 10:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE8818E0C;
	Wed, 24 Jan 2024 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQr/u80N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3179019472;
	Wed, 24 Jan 2024 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091560; cv=none; b=jPwZPcENwEhw4tkLxxzE3MsCGxzuLd0N/0uTzEdPSP5DeiK6oiBlgRbmmyjoagRGugoEieIjPZp4cRPFVQ7pNsuT9kTxpCshIBQzZGozoRa7Q7A3J9h4Nc5smyTagueYHH3f7o7OtybPrpSSgHSl1yOk3TfNuEXiM7ooNImo7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091560; c=relaxed/simple;
	bh=mGMTyl3kfPcBZp4R0TAG62m92lioFORAfux+5AXY2ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9JP2LH5inq14k6K+FteUTTQwm1uz7njgzghFOZ2ORWKm6wJ8H6QTNRcMhdu08/qWJI9C0yyFtLUtvqa7cUUSjOHKAV86PGXw10BzL1ZpEPeZnted5JlrHa5F5DMO6oR6F5+dOEr98SMQyGfVDpb/VWh05SWtaQH9C89+XoOV+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQr/u80N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B01C43390;
	Wed, 24 Jan 2024 10:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706091560;
	bh=mGMTyl3kfPcBZp4R0TAG62m92lioFORAfux+5AXY2ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQr/u80Nk1Q1iZ6R022AvEem2ea1jVjdM9vibwZjnSntwng9Cc/977CXXYONivG3v
	 dHxc7XXjWesve4wCV3ga8iKqi0VOpvqkwd/wmPAcHDYfr8dl88yrB/uuv3Z1yCuYEG
	 FLAeL+3CNz7fwZzbi/pUKaKB2/Ig4BoszQT1xvYknxOVjjhUg2Nx8S0WjxW5MrZ/tE
	 h93tt3088vSJSfbFpy+nbj6IL/ZyDFzJL/WqpNDS5j9KxBZZcZgmQ2IxCwTOb0hylN
	 zWDf64VH9I6MRR9cCkf7UyzzbEkun3k6JU8XBBswGb4CxRQSjsPdyjuKU/LiXTw5oE
	 Tg1B5/rZcPfkQ==
Date: Wed, 24 Jan 2024 10:19:15 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: netdevsim: fix the udp_tunnel_nic test
Message-ID: <20240124101915.GV254773@kernel.org>
References: <20240123060529.1033912-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123060529.1033912-1-kuba@kernel.org>

On Mon, Jan 22, 2024 at 10:05:29PM -0800, Jakub Kicinski wrote:
> This test is missing a whole bunch of checks for interface
> renaming and one ifup. Presumably it was only used on a system
> with renaming disabled and NetworkManager running.
> 
> Fixes: 91f430b2c49d ("selftests: net: add a test for UDP tunnel info infra")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I see some discussion of a follow-up to move away from ifconfig which I
agree with (which century are we in now?). But this patch looks good in
it's own right.

Reviewed-by: Simon Horman <horms@kernel.org>


