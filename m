Return-Path: <linux-kselftest+bounces-40485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D55AB3EB63
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 17:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF10B16CD7B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1765202997;
	Mon,  1 Sep 2025 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUjiaBj5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568D1DF99C;
	Mon,  1 Sep 2025 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741538; cv=none; b=QH9zXK28Bfs4w6992cjxMM3rVE3jMGCbmNrH592UsmkRId9pEBRmM53pC5BE+HCsSdFGM/7d/fh/EH5LKkzWopTgki83FCrdNcm7m1s5aQ/dGedyN8q10TA0rjGx4qcjBNSG0Q5OcnDCWmJhrvptVfzYGngxIbuHLIqHlkHaM1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741538; c=relaxed/simple;
	bh=7DReLwRtWvWlXnSp8wrZ4WuZxyJ9hshhoM7p5A6SQKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKo2qqBRAWwlqe3fTFa/GerODpapYdkMFtdJ7WXgMs6NO9ceMaBRQVkUvDEwB18285wQBx3K9ugZqZoeK7FZzDtSxv+QaEF8l7UJgRFfpUOeX2xIIovmonw0SRY2D9wDgZFQZo5F2TRiNW5vgTJgOfNr34oHRgxBIGaj3jzMfw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUjiaBj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C568C4CEF0;
	Mon,  1 Sep 2025 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756741538;
	bh=7DReLwRtWvWlXnSp8wrZ4WuZxyJ9hshhoM7p5A6SQKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUjiaBj5Jw38xsC+JT/Xfb3oaENxUMs06rlSXJl6nFRE14Y/BAAlxuJmbvQ9X/BJd
	 gCcU/fIErJPr7X2bshBWqLDCjl4aCDDIrCLVnL9eYYnGDiIWVdMEAvB6clifYdmCQy
	 oad7LuDaMIZy4SEqiH20MwNcWddI9+Kg7qCx4WJJDtx4VLNgAytoU/TA18md+9yiou
	 hOBCXqsLdoVisMqnWnKPjYnl2s8eVPte3Zm6gT4lrEf1q2yP3PlllZ7VtJEq/OYEj/
	 byqDI20XQlxYgwGhyOOmRd2gJelUG0uOBENcUcXOadZ/iz4gHVJ1PUoxGvfyIC+b8C
	 M1mud4qsuUxdw==
Date: Mon, 1 Sep 2025 16:45:33 +0100
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
Subject: Re: [PATCH 1/3] selftests: drv-net: Fix and clarify TC bandwidth
 split in devlink_rate_tc_bw.py
Message-ID: <20250901154533.GH15473@horms.kernel.org>
References: <20250831080641.1828455-1-cjubran@nvidia.com>
 <20250831080641.1828455-2-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831080641.1828455-2-cjubran@nvidia.com>

On Sun, Aug 31, 2025 at 11:06:39AM +0300, Carolina Jubran wrote:
> Correct the documented bandwidth distribution between TC3 and TC4
> from 80/20 to 20/80. Update test descriptions and printed messages
> to consistently reflect the intended split.
> 
> Fixes: 23ca32e4ead4 ("selftests: drv-net: Add test for devlink-rate traffic class bandwidth distribution")
> Tested-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Nimrod Oren <noren@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


