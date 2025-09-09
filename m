Return-Path: <linux-kselftest+bounces-41040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CE4B4A7F6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 11:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948304E71F7
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 09:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520082D0298;
	Tue,  9 Sep 2025 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6CQuOTf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2838E2C374B;
	Tue,  9 Sep 2025 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409886; cv=none; b=DhX4mAFzMZIYapxI4nqP1pa0ZMUEDk0AdrY0A2avypTyjLP/rZFDN6cWFjnbczK+knRp5OZ94+01yb6GZSaWrlCX6NiEjVYBxnRLtZiC7WtlVJG9VpsOy48NC/ZIHC9NN8EhncDapnc5n60EnJuYkAgY8KHua4kG/ALmGb9Q64Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409886; c=relaxed/simple;
	bh=crP1HHzUmFBEyI7U2LL0UP+sAsNP6hV3Iu/cO7wIU6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUeVhleac7EBI6DGKQdw1anjzCYnoPECunPZiwEksKtgzHBjKRUPLaK5qTRL4iKUHQrt88m34+J2hrn4P0tdeIUvSKOC8sFQw3i/ruWkaWVwV74Ll0/rqrrBCvwWpxjnR+m2vyIhkQXDtCc/2JAar1SsioQRh1OFSZtD0GnnzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6CQuOTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D47C4CEF4;
	Tue,  9 Sep 2025 09:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757409885;
	bh=crP1HHzUmFBEyI7U2LL0UP+sAsNP6hV3Iu/cO7wIU6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6CQuOTfKtoiQ/KZtU1Hkxb8kmHFq43k7C2LU67Tc9yTDEP2/rb4MD2cjYuRBQxrW
	 bBrhW3nEpYsiCYgq2JAuk1zUDH50a3mOn2LSYSd6KWatvJuiLjQ7AcXgoaira4tkLN
	 0b5czq7VkMnnf+NCqde3FNb11pT3Bn5kv7zlbHiW7D/A7ZuMANH43M6Lv13zX48yIT
	 tqfuCSj2wI8gAMLc48mbgAjD1Y+LzXL1UnxrS1r+U1ceN6U/PeQdCIwFpbN9ocp3OW
	 2Hjlcenw2uRke3iW50LYNy1o+zUr8Qr+RoFd8wAl+O3kScdsIXKPmX9V5S0tOh4eRB
	 c4r8EeWfG0sSw==
Date: Tue, 9 Sep 2025 10:24:41 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: speed up pmtu.sh by avoiding
 unnecessary cleanup
Message-ID: <20250909092441.GG2015@horms.kernel.org>
References: <20250906214535.3204785-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906214535.3204785-1-kuba@kernel.org>

On Sat, Sep 06, 2025 at 02:45:35PM -0700, Jakub Kicinski wrote:
> The pmtu test takes nearly an hour when run on a debug kernel
> (10min on a normal kernel, so the debug slow down is quite significant).
> NIPA tries to ensure all results are delivered by a certain deadline
> so this prevents it from retrying the test in case of a flake.
> 
> Looks like one of the slowest operations in the test is calling out
> to ./openvswitch/ovs-dpctl.py to remove potential leftover OvS interfaces.
> Check whether the interfaces exist in the first place in sysfs,
> since it can be done directly in bash it is very fast.
> 
> This should save us around 20-30% of the test runtime.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

It would be interesting to know why this is so slow.
But I agree that avoiding unnecessary work is a good approach
if it is slow. And that appears to be the case.

Reviewed-by: Simon Horman <horms@kernel.org>

