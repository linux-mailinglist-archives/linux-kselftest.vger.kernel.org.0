Return-Path: <linux-kselftest+bounces-42476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11417BA3FD1
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 150994E2DBB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A0A2F90D5;
	Fri, 26 Sep 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJiREGtf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6842F8BF8;
	Fri, 26 Sep 2025 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894909; cv=none; b=tXO4YVaCSEk6POv4Ri7aO4H4LHW7Dz87w5tx81TneCGULAYby+xYJSPM8qJx2MkKTbjsC4iesSj16bOKxaPfgifd3EqV8B3xxRdoMkz475AJk8awJFThgpKnx9cCeHcopmaqisSiAKqQsmHfIdqKpiZLjZec1OiQWgcHsgIQXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894909; c=relaxed/simple;
	bh=gwZQ0mtfk/LebFS7IVFTx8y9Mg5BevlLsRsYr3enMiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEyIUqqrVCY6dZJdjxXCu2OQh9Hik1sHAbryEwWwE6TLI2qR6hlo8BWovbNz2It5UsCpDmfgOhp+OmEA4Wntjg5ohMcvmQrhq3iTBISDmF5ULyjpVLCBr6IcFYXfEuLxQk1RvLqSpELLunH+8+wWx6Bgy1WQNJ5bO3iC7Ka5mCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJiREGtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612D2C4CEF4;
	Fri, 26 Sep 2025 13:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894908;
	bh=gwZQ0mtfk/LebFS7IVFTx8y9Mg5BevlLsRsYr3enMiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJiREGtfyrFCSNqwtsfgfalzXjcDx9q9WFoSxyAI2QK8R0D4p204rqnsLlM+Pw+38
	 OfEdYvtz5Tax5ldT71/QS970P/l6OFUTx6RXnX150Wkmc8eoHnXKyH0PwRJnE2NUFk
	 SAU9Okd/VdEEekxln5qeq/tQNCITar/jnnHpxuHU5tzhxBvj/G0/ftKVpZ6uT7LDIS
	 lS0nk2ch4msZIPU/+5atxzOeNidLQfv6egZ4gsGIaRR5rDjJorHBqQhXWl7QKQtiT6
	 iBUYYgARt2WwGgAQbQDOR36zygG5wE9nRp/L8/ZHKagveR9YcYd99Z4j7wp0G7SonJ
	 11sx7nlRkkUPA==
Date: Fri, 26 Sep 2025 14:55:04 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 06/13] selftests: net: lib: Rename ip_addr_add()
 to adf_*
Message-ID: <aNabOFIEQ3tQ8J6p@horms.kernel.org>
References: <cover.1758821127.git.petrm@nvidia.com>
 <706327a5db660c7f18ba9fbfba7ce913da065e3e.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <706327a5db660c7f18ba9fbfba7ce913da065e3e.1758821127.git.petrm@nvidia.com>

On Thu, Sep 25, 2025 at 07:31:49PM +0200, Petr Machata wrote:
> Rename this function to mark it as autodefer.
> For details, see the discussion in the cover letter.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


