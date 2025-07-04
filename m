Return-Path: <linux-kselftest+bounces-36576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70659AF94CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45334A4CFA
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D593074BA;
	Fri,  4 Jul 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7/t/oVp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B78D299954;
	Fri,  4 Jul 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637309; cv=none; b=gmFkrhr6UJmv7h5i7IvLowopXweusYhAVn3+rLyWjTBIR4WVEbgJB6bEDnxCdvXL+0NntLdiE4dcpbS/KRAsMFbXYl+lRvA4YdjDI636MgxHpcDzCNYZUcb5h4fPl80b8wVeNrVeO2sJfm1VqAAmtvGNmH3UFNeR+EPMT4xdUyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637309; c=relaxed/simple;
	bh=ZQYUz+u7pdboHeN0D+XbT20M/iMRntPRobyPjdXqmDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kw3NCIl2kHXyq7Zh4ILD5T8ETsDbaKN+RchKJ5A4Ly0dkPoK0fnNSqT4DzsUmXqN4m3tZDyKopG5DdZu65/HKdHJRUU+XMZ4X/cu6WFDtHSpZw+ElSGbihxRpi2LxdGyC4s9mmrmEbGfDf8KROcjiTZ7Wc3B7sL5+id63nXIPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7/t/oVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43206C4CEE3;
	Fri,  4 Jul 2025 13:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751637308;
	bh=ZQYUz+u7pdboHeN0D+XbT20M/iMRntPRobyPjdXqmDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7/t/oVpcGg0Kn6mvgAji4c2F6QgnkaheTK3DKzo6l6nBIRL0QQIuq71wLKxC2wBp
	 5ZnYqeK2rDggFVjhYDjxIKzZbuuGCt5eFckY++EN8sVUeH4OgxwkapFdXelrfQY1Y9
	 XxgfGjlSP1/R7mCE5/QY9RjvlPx3hL98mD4Feu1XJW5D5gKC4EAm7omrPZLR6r8ZW3
	 BD7PD5u7nD0davgmzmRuCRfedO2vRwUlFr56BY7rCkl3xpbltodbWbnh2DbbsnHyEh
	 KAVn8hJ0g42bvqm4iKPbVIMjnPi5fEgGqz+eCW3silvD0phwR0pKl6W2wAhFWy9yBh
	 1jPt02QTp+AbQ==
Date: Fri, 4 Jul 2025 14:55:03 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 7/7] selftests: net: Add IPv6 support to
 netconsole basic tests
Message-ID: <20250704135503.GU41770@horms.kernel.org>
References: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
 <20250702-netpoll_untagle_ip-v2-7-13cf3db24e2b@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-netpoll_untagle_ip-v2-7-13cf3db24e2b@debian.org>

On Wed, Jul 02, 2025 at 03:06:39AM -0700, Breno Leitao wrote:
> Add IPv6 support to the netconsole basic functionality tests by:
> 
> - Introducing separate IPv4 and IPv6 address variables (SRCIP4/SRCIP6,
>   DSTIP4/DSTIP6) to replace the single SRCIP/DSTIP variables
> - Adding select_ipv4_or_ipv6() function to choose protocol version
> - Updating socat configuration to use UDP6-LISTEN for IPv6 tests
> - Adding wait_for_port() wrapper to handle protocol-specific port waiting
> - Expanding test matrix to run both basic and extended formats against
>   both IPv4 and IPv6 protocols
> - Improving cleanup to kill any remaining socat processes
> - Adding sleep delays for better IPv6 packet handling reliability
> 
> The test now validates netconsole functionality across both IP versions,
> improving test coverage for dual-stack network environments.
> 
> This test would avoid the regression fixed by commit f59902070269 ("net:
> netpoll: Initialize UDP checksum field before checksumming")
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


