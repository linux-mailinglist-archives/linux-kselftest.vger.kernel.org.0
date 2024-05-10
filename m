Return-Path: <linux-kselftest+bounces-10014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 367308C24FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 14:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BB11C215BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 12:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2C685938;
	Fri, 10 May 2024 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxNsuXWc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339D487BC;
	Fri, 10 May 2024 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344419; cv=none; b=Dbi3hPIB1N8NNr4L4iLHCpYh+zThinkNOJJMk6iAaAyZzRGw1qeeVWPrQrnQ8MMJaz2hmJ4fjxTjebJCczbcAAKhdNBwBhP4+jp1DZQghJkUvRuIUL5s04VDE4Ag1nh83KilHfJvDipq3o82Jxh0wsmmO//xVIbynaM9Lqgg3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344419; c=relaxed/simple;
	bh=Tgo2D4za2BYVnRy7ETnxwBHzjmFrWzfpqQD+qoX+F9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQjwQmjw5yErgnCW+F60teUym2KkceAlQU+RUqS13gnppgrJeTgEjPiBpXuOBiLdcz+5ULSthaD3t3GbOb1WypHTkH0WLfJ0pYb8w3hn9ca7ATe5oFHrvJr075rGi3kCmAXb4NPUKo51mzaiG6y2JbHeVJst54efX1sQdWWKFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxNsuXWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB43C113CC;
	Fri, 10 May 2024 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715344418;
	bh=Tgo2D4za2BYVnRy7ETnxwBHzjmFrWzfpqQD+qoX+F9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IxNsuXWcUt0KuB2ErWS+RtoO71I9k6wYj2v9IWhtMuivutgf8Zf3RZv+cycc7rDy8
	 46XV4A/Sgyc9RL2JBhpSLfIigsSWvSqDYD4L+1fiks8BzZ9EQlN/616GhcsFlnm494
	 UQKmwJFQdpCcU5myS+25ZQZV0OqWbsy+gF7EDbJzw5Lh7LD8fvW1uo2ffbARPyify5
	 CWmVPEegd25K+9WOrhI5/ldPMiZCMjS0I+895jWZfr/T+xHY5ALYL5HnyHxZWSZZT8
	 Y2McP8wy3Zg68+KNMLNFZD3pcj6Kc92HPDb2Lbr0rh8MnoXaZWfBEg6svbZ8f23opI
	 W2MDXD9h+nQSw==
Date: Fri, 10 May 2024 13:33:30 +0100
From: Simon Horman <horms@kernel.org>
To: Tao Su <tao1.su@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
	edliaw@google.com, ivan.orlov0322@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, shuah@kernel.org, seanjc@google.com,
	pbonzini@redhat.com, bongsu.jeon@samsung.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alexandre.belloni@bootlin.com, jarkko@kernel.org,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH v2 2/2] selftests/harness: Use 1024 in place of LINE_MAX
Message-ID: <20240510123330.GZ2347895@kernel.org>
References: <20240509053113.43462-1-tao1.su@linux.intel.com>
 <20240509053113.43462-3-tao1.su@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509053113.43462-3-tao1.su@linux.intel.com>

On Thu, May 09, 2024 at 01:31:13PM +0800, Tao Su wrote:
> Android was seeing a compilation error because its C library does not
> define LINE_MAX. Since LINE_MAX is only used to determine the size of
> test_name[] and 1024 should be enough for the test name, use 1024
> instead of LINE_MAX.
> 
> Fixes: 38c957f07038 ("selftests: kselftest_harness: generate test name once")
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


