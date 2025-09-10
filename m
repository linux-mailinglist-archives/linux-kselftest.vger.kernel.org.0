Return-Path: <linux-kselftest+bounces-41113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBDCB51188
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 10:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4452018879E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531B730F801;
	Wed, 10 Sep 2025 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSy7CkpF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BFA303C8A;
	Wed, 10 Sep 2025 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493415; cv=none; b=i6cAdAJDz5XYjw54xciVtniDN4meAhw75/hOMn9HEvjBRG/YMUX5pRaZXkemY7vhrbBoPIctu8Du3v5DhAMGLH9zrE8OgupOB9MadBN8VRKZZbuCC6+7nSWLMaTYgWIHiYRlr4upBv0+nwSdAFRVzWV40BvZ/AJYvBbIzxidfn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493415; c=relaxed/simple;
	bh=kL8JdtYxkCjMHxc3tftWuYV1C7ek+ybfz3gA+i5iLcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6t2mdtdJBDK8oxHXPaTzgGfTpeve+faUxrdP8xVJhpFe5fNDPTTAM6FrZJ4csAjcFz7vf8xhD4zCuPUAMA0piPvqFhj7BN5K4sMPd6JIbZiqjhXcz9D6oNEBzNI4KEnJh2Uak25munglT6ylXrVB1K135enSE/7NhF+f07Mcus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSy7CkpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CABC4CEF0;
	Wed, 10 Sep 2025 08:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757493414;
	bh=kL8JdtYxkCjMHxc3tftWuYV1C7ek+ybfz3gA+i5iLcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cSy7CkpFKtJfvYuQFBHnPomdbuLhLUcylOxxd4C3YX296LXTl8QpPyhhD8yhx4AJe
	 6MSzWvlnJBc1a6mLw2wtYrV6SOIbXZ0sSMCcrDhbOQn0yJnIjUooUSSdHeyrMUfyha
	 tr0IL1jM8LiTNR9AZxJjC6GUKU13Qa5XXwdUNSqltD4sR/SpLpRgtO8bnondXLL7Vz
	 BnN59i2gO/J+0CUKy9YN7S1AeTxDPTCpGf7rktAzRwESLTM12cpoazsR3SgLUnOLjw
	 YU08vIR5OEEuulaQ2kt4K47O5HZmwn2jllJR2kIexel0GzmsCbVQ9Q21Q1sda/FvKv
	 T/bvbG10EZ7WQ==
Date: Wed, 10 Sep 2025 09:36:49 +0100
From: Simon Horman <horms@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net 0/2] selftests: drv-net: Fix issues in
 devlink_rate_tc_bw.py
Message-ID: <20250910083649.GI20205@horms.kernel.org>
References: <20250909101353.3778751-1-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909101353.3778751-1-cjubran@nvidia.com>

On Tue, Sep 09, 2025 at 01:13:51PM +0300, Carolina Jubran wrote:
> This series fixes issues in devlink_rate_tc_bw.py selftest that made
> its checks unreliable and its documentation inconsistent with the
> actual configuration.
> 
> V2:
> - Dropped the patch that relaxed the total bandwidth check. Jakub
>   suggested addressing the instability with interval-based measurement
>   and by migrating to load.py. That will be handled in a follow-up.
> - Link to V1: https://lore.kernel.org/netdev/20250831080641.1828455-1-cjubran@nvidia.com/
> 
> Thanks
> 
> Carolina Jubran (2):
>   selftests: drv-net: Fix and clarify TC bandwidth split in
>     devlink_rate_tc_bw.py
>   selftests: drv-net: Fix tolerance calculation in devlink_rate_tc_bw.py
> 
>  .../drivers/net/hw/devlink_rate_tc_bw.py      | 100 ++++++++----------
>  1 file changed, 43 insertions(+), 57 deletions(-)

Hi Carolina,

It isn't strictly related to these changes.
But CI flaggs that devlink_rate_tc_bw.py should
be present in the Makefile for in the same directory.

Given the wildcard in the Makefile I'm unsure if that
is true or not. Could you take a look?

