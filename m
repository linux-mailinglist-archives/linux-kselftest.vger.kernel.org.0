Return-Path: <linux-kselftest+bounces-40537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297A1B3F99A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5694E1C22
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 09:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D46B2EA727;
	Tue,  2 Sep 2025 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4PxB+lU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6872EA49F;
	Tue,  2 Sep 2025 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803841; cv=none; b=QJsOrfYeHuUOe7seGaucm2ArmP6QxtjdrZAim8/t7YT+Al/T4R2sqsWPZKDuZcbpSgmblDHoA+trD+Q3Om3a6ktZSuGUgh9/pAdO4DSiDfMyxhN/9ZsVxFAx3umHCAkq9OyjEDvPhaku/m5kW0Xan/h7g62xjW1F8vqND3a6MSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803841; c=relaxed/simple;
	bh=BAM95ncwu+8be/fE9y5p77JAu7b1gWtjS3DCbOz5JPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNLVM49sXgfhn2/t+K9hlwCbqVrnCuj8tlBg/1QLTvooUWXEbkZp9ajmE6CP0nQ2mD6G8Cj3ykM7V00O3ifI5K2UXp6+ygX2+116zsI2KdrJIFEoTBM+xsz+xjqHV1ErpGm4ibeFatenKqxWcEGPSfKLceQFHvPC8C90oHC39CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4PxB+lU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F314C4CEF7;
	Tue,  2 Sep 2025 09:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756803841;
	bh=BAM95ncwu+8be/fE9y5p77JAu7b1gWtjS3DCbOz5JPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K4PxB+lUcFUKvPFb6bI4cH8eRprxLZUMpzX4CwWTBhtshUqXyXSvNmE5+eupo+skW
	 k9q4tUQLRmFJs71wJnN82D2dLrL/6p+lFYA5FGUYILOYYc4YbBcsu2einHoPhD/6Fb
	 +FcwlMhMEmunK0ujdFdVx3/aTzbOxKOqJrTQjPOmWNN3bv3I4d5aVwWwFOenIgY/rG
	 lOLIMWliO2Uy47w+UGVsx/4JwLiyoDDpbjQ6tuIiS7IHG9FOTQTP6leRtTsxG7LvId
	 Za58fajryTzO/c/sJVswaNGkq5/XNFuzFEZ1B5cvpNlga7x2H4fO15uDHbNtiuc5zV
	 p60iu2GXZm3vg==
Date: Tue, 2 Sep 2025 10:03:57 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, ecree.xilinx@gmail.com,
	gal@nvidia.com, joe@dama.to, linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH net-next v2 2/2] selftests: drv-net: rss_ctx: make the
 test pass with few queues
Message-ID: <20250902090357.GW15473@horms.kernel.org>
References: <20250901173139.881070-1-kuba@kernel.org>
 <20250901173139.881070-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901173139.881070-2-kuba@kernel.org>

On Mon, Sep 01, 2025 at 10:31:39AM -0700, Jakub Kicinski wrote:
> rss_ctx.test_rss_key_indir implicitly expects at least 5 queues,
> as it checks that the traffic on first 2 queues is lower than
> the remaining queues when we use all queues. Special case fewer
> queues.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


