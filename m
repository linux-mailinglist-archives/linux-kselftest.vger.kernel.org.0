Return-Path: <linux-kselftest+bounces-42226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DC9B9AF75
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 19:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1F13B97DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 17:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428323148D9;
	Wed, 24 Sep 2025 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1UWVeBi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F003064A4;
	Wed, 24 Sep 2025 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733414; cv=none; b=sGolWgT13INidtxU8w8yLSWG1sbIMAAlIlYHkDAa1wMafYy6PQWgUnrYTEOIL3mUBPnIes2hwYCf5YRFS3dWdST2OQS/5BK3rdBmOAVk4plEw+ExRMeHLhm+poaWSqQCYd5GvfAtxic5/dC/sD9hY0+wMLzAagBr4qvgvZy29Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733414; c=relaxed/simple;
	bh=MFlntLLdJ18QYfJ01LQOG1s3Wqq+b5FzXiZa5LTgl/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJqYu89hJzly7As6vCjRQOKDK50U+0vPFoztluJlcSVmhLeCkah8CJ2Vgtc0p7IYe7AbeW8oNSQ2QUryvmB2bvU+eaoHQwoUiVakflBjC39Oq2EGH/U+gfSmkRurNF5M/R7OVojYYohum/OWJal6irQFrhBMM8Re1HwabpdpmHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1UWVeBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9159C4CEE7;
	Wed, 24 Sep 2025 17:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758733413;
	bh=MFlntLLdJ18QYfJ01LQOG1s3Wqq+b5FzXiZa5LTgl/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1UWVeBiei/mzKSJvoJ1XVfJ1jrbljCdtFlQxVSLq6xH4jDSz5fLaQf95BdTa03GQ
	 bmg7XIqxzFa6biew3wsSP6oeW01W+P/LUuw+hxJHVzwCGmlwr7JXPdHREJO6aVOTwU
	 2BBCkY5dyKzIu5AbMcrD+NrNckrWtitWjy94ttpX1XFyZ0k08MOXT8EmTRtAJ5etJN
	 X6EX6oTu8J00Rx88XcBS0ASyu88DCoAcyetCvYoRms/yS/YXj8OnZixJr1g8CIrGAy
	 T0m7qBXrk0FY6Zlo6dKT09jKyyUSSXOk5EWC5eeQUX+awk0P3TWaR71yRxEkuTleti
	 AC5DRyDNoNGRQ==
Date: Wed, 24 Sep 2025 18:03:28 +0100
From: Simon Horman <horms@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, john.fastabend@gmail.com,
	sd@queasysnail.net, shuah@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v4 1/2] net/tls: support maximum record size limit
Message-ID: <20250924170328.GR836419@horms.kernel.org>
References: <20250923053207.113938-1-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923053207.113938-1-wilfred.opensource@gmail.com>

On Tue, Sep 23, 2025 at 03:32:06PM +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> During a handshake, an endpoint may specify a maximum record size limit.
> Currently, the kernel defaults to TLS_MAX_PAYLOAD_SIZE (16KB) for the
> maximum record size. Meaning that, the outgoing records from the kernel
> can exceed a lower size negotiated during the handshake. In such a case,
> the TLS endpoint must send a fatal "record_overflow" alert [1], and
> thus the record is discarded.
> 
> Upcoming Western Digital NVMe-TCP hardware controllers implement TLS
> support. For these devices, supporting TLS record size negotiation is
> necessary because the maximum TLS record size supported by the controller
> is less than the default 16KB currently used by the kernel.
> 
> This patch adds support for retrieving the negotiated record size limit
> during a handshake, and enforcing it at the TLS layer such that outgoing
> records are no larger than the size negotiated. This patch depends on
> the respective userspace support in tlshd and GnuTLS [2].
> 
> [1] https://www.rfc-editor.org/rfc/rfc8449
> [2] https://gitlab.com/gnutls/gnutls/-/merge_requests/2005
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
> Changes V3 -> V4:
>     * Added record_size_limit RFC reference to documentation
>     * Always export the record size limit in tls_get_info()
>     * Disallow user space to change the record_size_limit from under us
>       if an open record is pending.
>     * Added record_size_limit minimum size check as per RFC
>     * Allow space for the ContentType byte for TLS 1.3. The expected
>       behaviour is that userspace directly uses the negotiated
>       record_size_limit, kernel will limit the plaintext buffer size
>       appropirately.
>     * New patch to add self-tests.

Hi Wilfred,

Unfortunately this series doesn't apply cleanly against current net-next.
So you will need to rebase and repost after waiting for some more
meaningful review from others.

Also, please include net-next in the subject, assuming that is the target
tree.

Subject: [PATCH net-next v5 1/2] ...

See: https://docs.kernel.org/process/maintainer-netdev.html

Thanks!

...

-- 
pw-bot: changes-requested

