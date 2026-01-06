Return-Path: <linux-kselftest+bounces-48258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85293CF631A
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 02:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EE62303ADE8
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 01:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED5D27815D;
	Tue,  6 Jan 2026 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3H75X8/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568E1D5160;
	Tue,  6 Jan 2026 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661800; cv=none; b=VedHREQu0t2fXrTrzG/JMCCPCFnWG5AwzN+BSVgIAr5nERO0NS7FxODMVfhCplj9Nj6nbEdaH6vKcanBSvvrFFxdsIX5QoZH4sILSahvR3oDhRUv1wobNH5bl3ljxRYrevCn4LOqNG64XrZfpgYRo4bCFGdgr/YtlV8987oXX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661800; c=relaxed/simple;
	bh=io+wHevtf4XlT92MFeTbzCNskEB8PKlz8hQEJ9TXdkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWYES3UUoPno0303LUCVbnkzNapOCQ9TbICxBZx+567IDs9Rxy9/YlLB0pr63s105CM5pyuA7qycR5gUhQcKCAHm95lrcSdu6/xch+t+AHckns3l0Xz39CLUgDW+gEQ+usP6ax4Nj1biGkq8U1/3yHFK3JCD6a0/Mn+QmLmNjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3H75X8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A32C116D0;
	Tue,  6 Jan 2026 01:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767661799;
	bh=io+wHevtf4XlT92MFeTbzCNskEB8PKlz8hQEJ9TXdkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z3H75X8/NFLLYn4CKZRlZhoWpNJXLt614D5NIeNwUq4EbcBXpT4w8/ve6xy7aWCu6
	 k3ImxHYDIRZRD8CpE6FMk+cxP08JtTJNR1TvVc/iNEwmbGtHJKN+imVV8jCGMUsOs+
	 R6V7ph6Hl5YE/ax6fNZ+dFoa6LGLuPhFdZJOPzuU8dYBa3yM5G9CBFoIB60M3oJ0KY
	 b8SwQF9GANfQ2/HIvMIjM1r/aJ5CN3hKaM4xag9ATpKJsMDk5q1zjWI5pAyNJYyV7B
	 T41So2p7r8qGBN1OMpiuG8wphZt7LSXBG/iftvPA+ehVSCTXqYbRujH7yTa66r2Xos
	 VtJTt8MSZC7tQ==
Date: Mon, 5 Jan 2026 17:09:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 <adrian.pielech@intel.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, gal@nvidia.com, noren@nvidia.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: hw-net: rss-input-xfrm: try to
 enable the xfrm at the start
Message-ID: <20260105170958.0fcef295@kernel.org>
In-Reply-To: <20260104184600.795280-1-kuba@kernel.org>
References: <20260104184600.795280-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 Jan 2026 10:46:00 -0800 Jakub Kicinski wrote:
> The test currently SKIPs if the symmetric RSS xfrm is not enabled
> by default. This leads to spurious SKIPs in the Intel CI reporting
> results to NIPA.
> 
> Testing on CX7:
> 
>  # ./drivers/net/hw/rss_input_xfrm.py
>   TAP version 13
>   1..2
>   ok 1 rss_input_xfrm.test_rss_input_xfrm_ipv4 # SKIP Test requires IPv4 connectivity
>   # Sym input xfrm already enabled: {'sym-or-xor'}
>   ok 2 rss_input_xfrm.test_rss_input_xfrm_ipv6
>   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
>  # ethtool -X eth0 xfrm none
> 
>  # ./drivers/net/hw/rss_input_xfrm.py
>   TAP version 13
>   1..2
>   ok 1 rss_input_xfrm.test_rss_input_xfrm_ipv4 # SKIP Test requires IPv4 connectivity
>   # Sym input xfrm configured: {'sym-or-xor'}
>   ok 2 rss_input_xfrm.test_rss_input_xfrm_ipv6
>   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:1 error:0

Weird, looking at Intel's results for net-next-hw-2026-01-06--00-00
it's still skipping. What's going on Intel folks? This test seems to
skip / pass on your setup rather randomly:
https://netdev.bots.linux.dev/contest.html?test=rss-input-xfrm-py

While I have you - could you configure your HTTP server to serve the
logs as plain text? FWIW for nginx in NIPA we use:

location /logs {
    default_type        text/plain;
    charset utf-8;

    location ~ (stderr|stdout|retcode|summary) {
        gzip on;
        gzip_min_length 16000;
        gzip_types text/plain;
	charset utf-8;
    }
}

Otherwise every time we click on the link to your logs in NIPA 
the browser downloads the logs instead of displaying them.

