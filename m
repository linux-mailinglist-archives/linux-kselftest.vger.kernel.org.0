Return-Path: <linux-kselftest+bounces-27427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33817A43B66
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CFC3A8DB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 10:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A099F267713;
	Tue, 25 Feb 2025 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUdWeKNv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7D265610;
	Tue, 25 Feb 2025 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478821; cv=none; b=ZnyPYgLEMzu2GMYP0feUysVaHGnfw84RysAMgeuchx1udwE238aq61VGEvNsUT27V9OOplev0HwJXMi1rZQUiWJ9ops3TZbRY3b/MBaA3Ak/uwcZje8cXYK/GdE3dBuXs8K84zdrsJmBYYGlJVJ+SGAFODJi8z5AqfqLnQ5na9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478821; c=relaxed/simple;
	bh=lYM4lD+scZacbH4xPuSPV5g1oNE8/gag3PHCknE58nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeUPvPKkwZcpYiLebboqqpJKFKyj1F/8CFKzpSIvjQAP3Dzirt49PlGq4ozv91o38Blcmob5IkcopgGtFhWoNdizpIw1reYfd6n5LdwxH/e/CRMK27jALgDq/FnCW1NTn4aVVA4MVoTSDnXOfVk9CsZXF5Qi2wZudrBz8gW45pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUdWeKNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D89C4CEDD;
	Tue, 25 Feb 2025 10:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740478821;
	bh=lYM4lD+scZacbH4xPuSPV5g1oNE8/gag3PHCknE58nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUdWeKNva59QntulRJg48j3lOUbPcTzPz88yR3ZQs3Dv+SF4xILyQjhEDt8AqtjmZ
	 6dYIm2fYC5Jci5CuAyTekifWgebJUR+/TH0xXDb3s6a73iEtPgthrIYox1qbML9CjV
	 2Hy/Og1SCQxRqDs2SiQ3GaCLRrOqPZN71rh1m1d3aRZhIoPagR+ESYJG0VxRF+rTyL
	 WfZBYo5XCmqW0EyimPvRgCBcny7CEFzkyxlpL9ES/VARLTZPUsgpLFhxloKsDFQL3o
	 OInYfIWZe4XDHYCyjp6+AGV7pJ6MCOT99B5lelF2tjgwWuuyG4F8S0i6+ehaxHUIK2
	 Q4nQLB/DEZF9Q==
Date: Tue, 25 Feb 2025 10:20:16 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 3/7] netconsole: add taskname to extradata entry
 count
Message-ID: <20250225102016.GO1615191@kernel.org>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-3-21c86ae8fc0d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-netcons_current-v1-3-21c86ae8fc0d@debian.org>

On Fri, Feb 21, 2025 at 05:52:08AM -0800, Breno Leitao wrote:
> New SYSDATA_TASKNAME feature flag to track when taskname append is enabled.
> 
> Additional check in count_extradata_entries() to include taskname in
> total, counting it as an entry in extradata. This function is used to
> check if we are not overflowing the number of extradata items.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


