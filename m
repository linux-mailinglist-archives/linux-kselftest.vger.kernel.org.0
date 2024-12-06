Return-Path: <linux-kselftest+bounces-22916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F56D9E72AA
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 16:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A8C285FC3
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 15:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E079C207E0D;
	Fri,  6 Dec 2024 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVPmaSkL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F5154BF5;
	Fri,  6 Dec 2024 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497890; cv=none; b=DrW/E7qnD4KnUGfzD96Twel1zZwlt8nbiEkznjxDEjCiP2cZ5kHit/K547ag3uXkLipOlyT5Xg7tcMdI5sDVRcMoQokMADIm5cDiv9c00lHIqIuhOAvGTpuNUz9K2qJrttL7uQoy9cslfUCNJjdkMJfzY/HH3dsrJZBUj/E/QVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497890; c=relaxed/simple;
	bh=6VrMZatCpHvbAhDbkEIS5aV45kI4BZg8F7MM0PJnu10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKkEG7NQB9ZLigBIejG1+h7ff+qOL81PWV74tWT0rXgkCUVCKEpndrq/7TxIfAnVGTN7rjwmo1kUbM8DLkD/COjeKIse3rDtINkuBBFPVgE3ig6ir6nukvOxgurSTiftSKewIDVyeWbaZ3LUlmxT/xDCiBCoA/dHA2xKfETHaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVPmaSkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BD7C4CEDE;
	Fri,  6 Dec 2024 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733497890;
	bh=6VrMZatCpHvbAhDbkEIS5aV45kI4BZg8F7MM0PJnu10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVPmaSkLqebPY0sOW7e0MnW5/re6pxZDl+sCx86rP7x+XvQOnzFXj05A3dLNy5QAx
	 CqxYR+jmvMreqK0U6t5WL+fEQM3j8QYnXMxFXslQUOhn8nPFFzVZhLDxo6KppI2Y1d
	 U6pqUyc+BwoDaUOCGmq9yYusF5eggTZBSTJHN4vFqi4Ld+fFmqteljiEV/rdTJ9Yh0
	 8MJ/UQyG+Xgdpo86C8tXm/oMx+VHy0fU4rVbBo7008vA0iR7QnI8r2kiXn0h+yAwoO
	 KoQHN2jiFhCwqIy9H74k6TWXI7hrhuwEQZ9NOdO0aFy+mNacJ/X2x3dZtMMrpOWo7s
	 MAJJdvHcP9HZA==
Date: Fri, 6 Dec 2024 15:11:26 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] netconsole: selftest: Split the helpers
 from the selftest
Message-ID: <20241206151126.GW2581@kernel.org>
References: <20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org>
 <20241204-netcons_overflow_test-v1-2-a85a8d0ace21@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-netcons_overflow_test-v1-2-a85a8d0ace21@debian.org>

On Wed, Dec 04, 2024 at 08:40:43AM -0800, Breno Leitao wrote:
> Split helper functions from the netconsole basic test into a separate
> library file to enable reuse across different netconsole tests. This
> change only moves the existing helper functions to lib/sh/lib_netcons.sh
> while preserving the same test functionality.
> 
> The helpers provide common functions for:
> - Setting up network namespaces and interfaces
> - Managing netconsole dynamic targets
> - Setting user data
> - Handling test dependencies
> - Cleanup operations
> 
> Do not make any change in the code, other than the mechanical
> separation.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Tested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>


