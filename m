Return-Path: <linux-kselftest+bounces-41112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C44AB51180
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 10:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C4417E0FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 08:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890C1311C1B;
	Wed, 10 Sep 2025 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq1uY9YF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5692331197A;
	Wed, 10 Sep 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493323; cv=none; b=K6a1Y1UvQLay7EjJsDeHupK8ThAZczf0VeiaM+Rf90cVadX1nRaccbLWjo5gRu2ZeOB7Qu9xhKsAFXHdBpdl6OGBUCB3sviPpO9eA1BQgVBQJJF8dCeXyQMrbVkaVFk3MGk5l8GuXMoNJs38HUKPo1k5N9uz4ZK2J6E7iLZ7pZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493323; c=relaxed/simple;
	bh=f8b9GQIgtIHJdZeG5M1ukYpg/MvaoYCOfZJKs4K1KYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbwlTb7w3ncue+A9JnV4QBz5/T5QeGTX63JXmdHYdBbje0HHnLmjGLNCySoWhDzewk2Sg8+pm+lmYX0XfJKQRk/UUfUmD9ES/khW6eHdRPfNjudUF3G8Chf9XbsTrj+gW/MJmwYNRKPYLwYIIopxwZ3PB4dRyv7J4dKdqSSBrGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq1uY9YF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DE6C4CEFB;
	Wed, 10 Sep 2025 08:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757493321;
	bh=f8b9GQIgtIHJdZeG5M1ukYpg/MvaoYCOfZJKs4K1KYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pq1uY9YFtSy+h08oDWh04KV1buOhAvauU+FilTHHjStG3WlDbl9KE9lWGTuDspaZm
	 UhmY1xBNAGbEpTRokVVQDRIHYDCgx1iBc2qdToPQgdVlcU/w10kxQpAtTf6VAEhdSs
	 Qjm9Ana8kHYN5VCm5fYv5ctsJcRMX85fBK2PmJIsPw//6F0jg1Ei8ZPlY4MkJUG4/4
	 F7482g2Pz+Bp5CyBo7dI3af4DP5VljzfoAmJRhoHN9ZdzTDBbeoU4QCzXvlsKt0xOb
	 T/fRpWUvqIgo4IuXZlM20r+WLJIAGsdq2qUWZjCeF9iUIH0/+/U56dfu8G7MWZVUvV
	 GPsBdZPygHtOw==
Date: Wed, 10 Sep 2025 09:35:16 +0100
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
Subject: Re: [PATCH v2 net 2/2] selftests: drv-net: Fix tolerance calculation
 in devlink_rate_tc_bw.py
Message-ID: <20250910083516.GH20205@horms.kernel.org>
References: <20250909101353.3778751-1-cjubran@nvidia.com>
 <20250909101353.3778751-3-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250909101353.3778751-3-cjubran@nvidia.com>

On Tue, Sep 09, 2025 at 01:13:53PM +0300, Carolina Jubran wrote:
> Currently, tolerance is computed against the TC’s expected percentage,
> making TC3 (20%) validation overly strict and TC4 (80%) overly loose.
> 
> Update BandwidthValidator to take a dict of shares and compute bounds
> relative to the overall total, so that all shares are validated
> consistently.
> 
> Fixes: 23ca32e4ead4 ("selftests: drv-net: Add test for devlink-rate traffic class bandwidth distribution")
> Tested-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Nimrod Oren <noren@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


