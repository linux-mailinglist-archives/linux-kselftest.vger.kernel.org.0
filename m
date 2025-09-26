Return-Path: <linux-kselftest+bounces-42477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26404BA3FD4
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67757188C089
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F332F99B0;
	Fri, 26 Sep 2025 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om3ieic1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17C19FA93;
	Fri, 26 Sep 2025 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894921; cv=none; b=I4b40XjsDQst4yPdxSWV928eDN2A0j9FdNoaIVSBTkQvA1+AqfbE8gbz8rFHrr68v0X3/YWqmlYme43cekfsZw+slYSYWV2MX49bt3KQ0MhiHfc1+hK4TEtjKUVlinidln/gfVRnQx8kf/XTxDdDa8fCGZkhZbqWuhZXWivC/QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894921; c=relaxed/simple;
	bh=p7e5BosKFRwMH+0As1IGCpv1+253jstHcN+X7DxFaiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVO9EaWWN82rDr8fNjuJwHm6Pyjlz9Eht46ilWnQJBODmum5308oQwQur8/PHTVo95zdk/qbvzfNnQba0hGDr0ix4WIsyDzHygUjZ0NKMLH/AP0oKqQAssTDh9VaaeEvA/OYLS0WRCHk6k7N1oyQA3W0pumB+j5PJYBVlrAqQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om3ieic1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA10AC4CEF4;
	Fri, 26 Sep 2025 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894921;
	bh=p7e5BosKFRwMH+0As1IGCpv1+253jstHcN+X7DxFaiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=om3ieic1M0v3cl/9vlkZrKr8ha7VnfUfktUiL2wOSRM99IYJp7T4eLfmzih2cv9P3
	 T+DbKLYEjf3lAl6HYPoLGRHHruEIMmgY0ZtidpJkbmI4KPu6iT61ggUEuKHMnKbVnL
	 zd8AAKm8pyOXc6Q1wyOZKXy2VrhCAda+socw7FggFu3O8x3EC/mZrcgWHzoU2c81zp
	 2HdFBUMBkkOdomKFb6v74H7Rb4LdrLp68ePwQZmwtXNbKxtLlRvQ7RWA/IXnmktelx
	 1dL809MVwtC61D5di0FgUv8F4bHuubpoquPn9dpFxNMITXupATPYaC7NDGivQW2egJ
	 XNDCnqXrUN8vg==
Date: Fri, 26 Sep 2025 14:55:16 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 07/13] selftests: net: lib: Rename
 ip_route_add() to adf_*
Message-ID: <aNabRJaU8g3xrfJY@horms.kernel.org>
References: <cover.1758821127.git.petrm@nvidia.com>
 <403143183373419e4a31df4665d6bfaa273eb761.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403143183373419e4a31df4665d6bfaa273eb761.1758821127.git.petrm@nvidia.com>

On Thu, Sep 25, 2025 at 07:31:50PM +0200, Petr Machata wrote:
> Rename this function to mark it as autodefer.
> For details, see the discussion in the cover letter.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


