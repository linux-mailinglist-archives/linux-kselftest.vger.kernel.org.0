Return-Path: <linux-kselftest+bounces-4461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70384FAEA
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 18:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD0E1C26762
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 17:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D76C7F485;
	Fri,  9 Feb 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjKFXlGw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560E7F480;
	Fri,  9 Feb 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499214; cv=none; b=X158OVcT7MglXFaSH+WWcqFhk8E9V5XpmZ60m0kVozSyCu3W2iSVQk8z2aZqMVKe+9EuqgSMqpxy4fPdWuXsqb8AEI27QDJLGVnu2JY0R6UflSaMyjrS1p90uWVv6+hIcVi4cQY721a1SsbqVWiBsVUdFJmKfWVkOC4jhlV/WTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499214; c=relaxed/simple;
	bh=biXrXtUUMc8bsD9DKAzd1JgINnjgpBuCRZyKhuA727g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBELN2q1L6sb//Gx1h1DizBsp9Fg1HN/Fz0JBY943kRi5nXLpcXmFJ7Jl+5/gnm7nDRPqEHolS3P75fpcipaNJWI2VdH9vO9W99HFIVs8vjayGZJ1FBMbWz8MPiEh3t/e3VGj6c44zKJCk84qJwR16Ol6YpQwOTyWqi79eCNDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjKFXlGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A39C433C7;
	Fri,  9 Feb 2024 17:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707499213;
	bh=biXrXtUUMc8bsD9DKAzd1JgINnjgpBuCRZyKhuA727g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WjKFXlGwithoO2azOmtmRTQfj+llpCUvLZLyfnbbjqSkb4tVbbBUmN/1PdHpKiUWQ
	 EP7CqFp+U2neNF6aED5V6Yh0BQ7JmnkvE6wosvSkRwuEHiNJ22zMsHlhC0uu4fEQ46
	 TWov8j0tWGakv6Q/ofR5GQq1TLFhIPFE7szQeujp1wBscM6FVskKh0VXaegVyxp5LN
	 wSrPuD0YMI/YeQ1cE4qaORfNhMpvo1hS6gwxUm6Xr4F4DrLbgsjKS4a61LkBts8So9
	 ZTRT8k/japOvD0CQ69Mdrt+eIGSjCKvt5+GMavdQiczaarv4UTsE6nfgoDK8201zNE
	 5tW6ZIAHrq4eg==
Date: Fri, 9 Feb 2024 17:20:09 +0000
From: Simon Horman <horms@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, shuah@kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next] selftests: forwarding: Add missing multicast
 routing config entries
Message-ID: <20240209172009.GF1533412@kernel.org>
References: <20240208165538.1303021-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208165538.1303021-1-idosch@nvidia.com>

On Thu, Feb 08, 2024 at 06:55:38PM +0200, Ido Schimmel wrote:
> The two tests that make use of multicast routig (router.sh and
> router_multicast.sh) are currently failing in the netdev CI because the
> kernel is missing multicast routing support.
> 
> Fix by adding the required config entries.
> 
> Fixes: 6d4efada3b82 ("selftests: forwarding: Add multicast routing test")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> Targeting at net-next because this is where 4acf4e62cd57 ("selftests:
> forwarding: Add missing config entries") was applied to, but you can
> apply to net as well.

Reviewed-by: Simon Horman <horms@kernel.org>


