Return-Path: <linux-kselftest+bounces-40487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5397B3EB84
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 17:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2722A3BD35F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8572D5924;
	Mon,  1 Sep 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu76J7gR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E426D4EB;
	Mon,  1 Sep 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741577; cv=none; b=jaJOkm+dIQs8QM/Z1hv1OlNH+1RN/sfcgDNGs0fHqbKxrwU9ACpLrKu2putyd5RwAeHl6pXgu6c5gDSl5SMVmo2W/UITVUpG2wWHFzZUYaE3w4jpQ1qxDmMbkTvqOH2kgb9gNQvlg4aT2KhOPMiMcatLDeSz3xq3hmjReWrFNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741577; c=relaxed/simple;
	bh=uGpQLSmEJyi6CiXowuvVwuKCocaJtrwfT6XZ7F7fc6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Us/BMufgC/FtuOlhloYc4w0FlXd5RmLb+aBiqiTwPnaq080xQx6k1ECNsTZ6IEZnbHGCJo9YUObcH8arPipThJszz8M9sl42tQMlaykjXMqy6zQ8GLbDOeARlVsclDVjkfCS6xggY9FXmDlB2h/gw3bwGAR9Kn81uDO50XO3mJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu76J7gR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89ECC4CEF0;
	Mon,  1 Sep 2025 15:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756741574;
	bh=uGpQLSmEJyi6CiXowuvVwuKCocaJtrwfT6XZ7F7fc6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tu76J7gRauacf/POp9Z2tEaNpYShDULpxOhS4zY5WG0SLrS/nzI0PRPd0k/GHmYRI
	 J9f9TiCcDYPA6fWDHv+qfrPmzcHIrJYb6NPLg2EIhnp7IzidFiu6Y8cMnmIqZwBJsc
	 mlcglvaI5HhOhOw9XIsOIJ0pDtG3SJS3DDDmzXuPfHc9WnJLdjnmqq/BBsG/Mottcw
	 +r9nKHV3dYFEvS54gFnYXVOXOmJuSxb7vgcieG29sFKgy50zD+WKahNv9AllMMept/
	 ZwiKGvaKqbekmSg8lkq8d9aUiJaKLbnefintwb/rhHR/zHXYyGyzTetfpWIKcKUuWq
	 NoM0iePS9zUhQ==
Date: Mon, 1 Sep 2025 16:46:09 +0100
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
Subject: Re: [PATCH 3/3] selftests: drv-net: Relax total BW check in
 devlink_rate_tc_bw.py
Message-ID: <20250901154609.GJ15473@horms.kernel.org>
References: <20250831080641.1828455-1-cjubran@nvidia.com>
 <20250831080641.1828455-4-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831080641.1828455-4-cjubran@nvidia.com>

On Sun, Aug 31, 2025 at 11:06:41AM +0300, Carolina Jubran wrote:
> This test is meant to check TC bandwidth distribution, not the tx_max
> of the VF. The total bandwidth check is only there to make sure that FW
> tokens limit traffic, because the per-TC share is only meaningful when
> the link is fully saturated.
> 
> Because the measured total is the sum of two iperf3 streams that do not
> always start or stop at the same time, using a strict 1 Gbps target
> caused random failures. This change adds a tolerance parameter to
> BandwidthValidator, keeps per-TC checks tight at +-12%, and relaxes the
> total bandwidth check to +-25% around 1 Gbps.
> 
> This avoids false failures while still confirming that the TC share
> validation is meaningful.
> 
> Fixes: 23ca32e4ead4 ("selftests: drv-net: Add test for devlink-rate traffic class bandwidth distribution")
> Tested-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Nimrod Oren <noren@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


