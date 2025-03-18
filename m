Return-Path: <linux-kselftest+bounces-29347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43780A672DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 12:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3AB3A9FCD
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 11:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0931220B207;
	Tue, 18 Mar 2025 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vD7Ikxmk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C1F1FCF47;
	Tue, 18 Mar 2025 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297855; cv=none; b=rjVZsBqFvEBeMpxYRNBZu1zeb9/2/94yIsDoXsYnRuFj4+/t/K8HYyL6wWr/XChhTdke038YuFRuOO+UjtqfuGuC1pNlQTWg+IEY6yANMN7fzahasYtdbQJalWy0KnAlsuEllt0ybDB0GxMRKHncOmeUbq3Vvrp5BG27sRycCyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297855; c=relaxed/simple;
	bh=8dfaj8OhiL8tCmJ2IDbZH8CfigT2oeIo7gW2nLBhHzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWKwjzY+7lKuHPuLPEirOqhbwYCC7Muo/05kXw8yyrhTQkO2K1b+47otjLgT0Ntv6fJt3z3OOK+rgRbf0GOafgnlnGr3Az+ytXu5wuUNRnNCLv1CObHGf9hebj1n8zL621htw1cAFleV9dYN3z19B+B85zXjTZwv7ruPoKZuy+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vD7Ikxmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B04C4CEDD;
	Tue, 18 Mar 2025 11:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742297855;
	bh=8dfaj8OhiL8tCmJ2IDbZH8CfigT2oeIo7gW2nLBhHzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vD7IkxmkWIrsCw0xHXhyQuisxyWfr5qUMmprP0o2xvMuAFXU5zVihUmckjvDG3sXd
	 JHiVoWGI1/2m032/XUSOfSxVonLGe7NrBiESatXLiDFbyfzHzYaOE2ZrPE3LGFgJdq
	 pfqGs1/oDzKk9HE8FsY9PLVXYFoHEk7IaWmVVa/jmOaFpRfB/Scsn4pkAx81awMcNb
	 dhLabArDBIVXaGWChnTNynPHx5cJkkJc/lqKDpyF3hdgSLRvs48aRFTanIywRJdwUZ
	 rY0hKKQlNOg7LWW0XmJpBJjNp2GZFHehUVIuv/Zy+Bxmpoi3Dkuk9rZtmV7YHmj1y+
	 61ZBPonT3SBiA==
Date: Tue, 18 Mar 2025 11:37:31 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	ap420073@gmail.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: drv-net: use defer in the ping test
Message-ID: <20250318113731.GO688833@kernel.org>
References: <20250312131040.660386-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312131040.660386-1-kuba@kernel.org>

On Wed, Mar 12, 2025 at 02:10:40PM +0100, Jakub Kicinski wrote:
> Make sure the test cleans up after itself. The XDP off statements
> at the end of the test may not be reached.
> 
> Fixes: 75cc19c8ff89 ("selftests: drv-net: add xdp cases for ping.py")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


