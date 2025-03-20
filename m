Return-Path: <linux-kselftest+bounces-29522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70EFA6AEF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 21:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C94981D9C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 20:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8580204F6A;
	Thu, 20 Mar 2025 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKOC7WUj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA9A2F28;
	Thu, 20 Mar 2025 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742501035; cv=none; b=DqkJBDfXkGAL0vAoRJxkgObeW84yFhPM9D/pH+5FwqAbqKvyY44srUdX/M+3MKJNTM+ROTAUfhYxOL3EZLS9Zq/WmKNG4hHMXt7xIHm22FCR/o8OBCpV+TkauurIGtVNE/+bYWyRKFTMxg9e46PyypOP5xkrMzrL2FPy8afG6QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742501035; c=relaxed/simple;
	bh=qJzbJVnFvHEWNUIi6aXXugB0o+Rv7JzoBQ8qm2JtV3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2ApyKPRzKLoBXubVvPBQ73xSldu+dFfCsRssJNgDl5MuGTTg53aGvFZq2yCMQ7MzRxoJ62v1w1eIOhwy+LcaF94sawab907eJfu8VIUkGzPTnUb5/ZcyhqweEq0iP7QkveYsKOUdRBAWYny5SdV9DTi0mk1l0qxV5K9/9lZXRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKOC7WUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D9CC4CEDD;
	Thu, 20 Mar 2025 20:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742501035;
	bh=qJzbJVnFvHEWNUIi6aXXugB0o+Rv7JzoBQ8qm2JtV3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZKOC7WUjV/iX7bG1sBsD0MKgg6iKsdKIKXl7NereOTgpQ3tXLXg8sLFJ38rKIY6bv
	 5erfZGPK+4a31D5Q58IajeQKZuEMoVVylUnik8Ydxiy9qiuOd2J5FtSk+s3NEwIfTc
	 HI/Ta8N1ahWOXiM3K9EOWrzfeVgqHqaLyOqPmdJj21207o3nT0EVfWj5Fuv1RpiGjd
	 NEpSbX4nTtlzpaA6RO8V/4SpVySEWSRvn2QNEmQoV7ewzQ2sghDqfK7EOHE56AjMq/
	 V8q0fzJS9pLMg6XhDGgrenpAMMCZvubSpuxy0THAn72KsXnpmnsZsrrk5V91nceOsr
	 FuvLZYEouZHZA==
Date: Thu, 20 Mar 2025 20:03:50 +0000
From: Simon Horman <horms@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH net-next] selftests: drv-net: rss_ctx: Don't assume
 indirection table is present
Message-ID: <20250320200350.GK892515@horms.kernel.org>
References: <20250318112426.386651-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318112426.386651-1-gal@nvidia.com>

On Tue, Mar 18, 2025 at 01:24:26PM +0200, Gal Pressman wrote:
> The test_rss_context_dump() test assumes the indirection table is always
> supported, which is not true for all drivers, e.g., virtio_net when
> VIRTIO_NET_F_RSS is disabled.
> 
> Skip the check if 'indir' is not present.
> 
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


