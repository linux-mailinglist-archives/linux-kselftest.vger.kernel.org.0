Return-Path: <linux-kselftest+bounces-40520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDD3B3F6AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 09:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645171A8722E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 07:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7512E7196;
	Tue,  2 Sep 2025 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfvKcXOX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DF2E7161;
	Tue,  2 Sep 2025 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798022; cv=none; b=f71LKM5H39KLUGFzBY+4tCtksCfz5r5BEKY4Mac3cBFcXDn+cr/E1EPod2AOc4ll4EQ9lrpccG7Cl1gZ0hoGf91tYofZ0QZSVtY5KlWjnAezayV8cP5QEmkydh47BGfb0h8ilKHzYHZmJzMvhF3objof50r+JjrRCoXTt+m0XBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798022; c=relaxed/simple;
	bh=xTq95Uos8ySKCMSvNlHXkMyVUKtFsnmtWhcOg153asY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnsZB7F5WjP8FU2TwOIHC6NnpKbKv+Dlg82/FlofINAoEHSa9231vVggAEarxEuKscaWV1ktwMrmP3+Y77pRtrSCFrM2vh7v1D9l1zUBPhKEsyvuxNeUbNrHk3jXvvUPku3syclS3Dma5JpLMITfjgNItMUkKf9kPbJNl/bAk6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfvKcXOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED88C4CEED;
	Tue,  2 Sep 2025 07:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756798021;
	bh=xTq95Uos8ySKCMSvNlHXkMyVUKtFsnmtWhcOg153asY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PfvKcXOXMquLx3HcJowTro6dE0pV6mSjwiwi0IrdoZC8RWs6hRpT71f80/6j97Kh4
	 5H5b0lJ5DC3Wag//MSAvjXTOmytsEjctUPJX5L+HxuFYm8QJafckYYFLTsEDpYhGkU
	 PL1ihYeUTtmwhHr7nvtxYw4DullbydALvlo49ga7U8ccrRNiWWy6kycm0WPy3i8Nqo
	 YW8932O74bJDJS9Rai+BScFZp2xL0SxHNhn9bZnlf5fsJzejg6deLW1FONwAxYZiH9
	 we389pwN4nXSRcXTWbXsYF35ixPCNzweAYA3QEN3nrMCOJPvoCZTo7wnSFtsuTm0PI
	 zCxi2ohDnWUcA==
Date: Tue, 2 Sep 2025 08:26:57 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: selftests: clean up
 tools/testing/selftests/net/lib/py/utils.py
Message-ID: <20250902072657.GP15473@horms.kernel.org>
References: <20250901-fix-v1-1-df0abb67481e@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901-fix-v1-1-df0abb67481e@debian.org>

On Mon, Sep 01, 2025 at 03:00:07AM -0700, Breno Leitao wrote:
> This patch improves the utils.py module by removing unused imports
> (errno, random), simplifying the fd_read_timeout() function by
> eliminating unnecessary else clause, and cleaning up code style in the
> defer class constructor.
> 
> Additionally, it renames the parameter in rand_port() from 'type' to
> 'stype' to avoid shadowing the built-in Python name 'type', improving
> code clarity and preventing potential issues.
> 
> These changes enhance code readability and maintainability without
> affecting functionality.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>



