Return-Path: <linux-kselftest+bounces-17152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD4796C456
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 18:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B881F21606
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 16:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC141DFE27;
	Wed,  4 Sep 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQoezaqW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481484A21;
	Wed,  4 Sep 2024 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468360; cv=none; b=UFE75WlIHXorxYPY3tgntia5fg+jTnIWwRcDGIHIel60lqtrU1soNB5Gz5kaTLqODvqFY/HxTw9QRb1yJ+/rnyb/jR9oljAa6Mk0G2WQDvrZeUvdmt1iY3Vf6l7NFvYiNLTiid+pKyfgyoKj0bRLU2jULl4mG77HDb5K2TY8zUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468360; c=relaxed/simple;
	bh=QE1dAfuJjh23uOwz2cziMmYmNkROlFpfLarHflaYQIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW72sal8TKkxeQgGPotuEQpr56fvV7uBZIsPfYcmFpcIniyPjUWDFMcujnDPclKshLtQhbGAR1uiY6Ptn9I1BdmBeLwSoUgppMM5Z9wPrkRf1kj0VWr/esqYoZ3n0C7LAqud/f0OHBTv/lqBxt9pats+j0PwNJd8fQ7l7SOqXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQoezaqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85A7C4CEC2;
	Wed,  4 Sep 2024 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725468359;
	bh=QE1dAfuJjh23uOwz2cziMmYmNkROlFpfLarHflaYQIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQoezaqWmCuNcOljGAP7UPbPJVagKScXJEpbZV/Crm8Mju2wHDgeil92vxmgXKmXe
	 pFgZmw1GoKysf/vT6locO6FqgoAy86vgQgYKqBpKdWNbVwEMMIg26qJRYWZq1P5sSF
	 pBoFpYCkn5MHSkwX5RWR+rMbApCdmqANyrSKKK7cDX6zZX6gntHVLN20S+FNH/cVyO
	 JLXr6DU9Z+7IIfRqFaXeyweRhFyJqGACEDA/Fz8u97qg5HQrjlKL0vLruPtcyxO7gk
	 iiNDq/A4iC7aSGHyqMgDkQiKpoTISEYTaSZBD07SjCWASuTjPUXWRs85GqeVeB4g3e
	 TNz3d/c+4L1Zg==
Date: Wed, 4 Sep 2024 17:45:55 +0100
From: Simon Horman <horms@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: net: convert comma to semicolon
Message-ID: <20240904164555.GB1722938@kernel.org>
References: <20240904014441.1065753-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904014441.1065753-1-nichen@iscas.ac.cn>

On Wed, Sep 04, 2024 at 09:44:41AM +0800, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Update commit message.

Thanks for the update.

I checked and I was not able to find any other instances in this file.

Reviewed-by: Simon Horman <horms@kernel.org>

