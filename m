Return-Path: <linux-kselftest+bounces-35214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 171A7ADCE2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 15:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A3F188AC51
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030A62E2679;
	Tue, 17 Jun 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLk18/tS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94482DE1E4;
	Tue, 17 Jun 2025 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168093; cv=none; b=PR9ynY09Kjoo4yTw2UfZNonmWlxPIdA6Fqz8YbYqaL8b71UU4ncfwTjEra3S/vEQm53Bh6i9P4JngGS7gbPt/oTJUloCtECpALB4FfIHhcy2sfDcdJ9zKNkNctR6hIhkiCMgmnQgcWKrp3fzF884sMSuvMaOsBiE5jqW3j/eGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168093; c=relaxed/simple;
	bh=fd4y+lDswDvbSpTkQLBi/lqOL1Y42ddHNclJLmZUuQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbBY0Gi3yujMwYPMFHOXI8whftI2g53F4abHNIOPuGe9zgdkUcNZky7YoqlPGFJhbLTQqEURiWouo9EhRlMRrZ0zxLhaiIsCvKw/Cjk8+MSnBRtT8zGjyP14PgSw41egAbHOjHdN2x7qorp6Ok8miIux3E5jUYbwQUwyPFO80oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLk18/tS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2437C4CEE3;
	Tue, 17 Jun 2025 13:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750168093;
	bh=fd4y+lDswDvbSpTkQLBi/lqOL1Y42ddHNclJLmZUuQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TLk18/tSDBzkkIUumdoXHrKsGoitzuViBjlMEY2DkRatD9c6rWnhabdhB5/EyeJL8
	 1TGuhdbvASYBkuTUuIXU0WXsnezRSj/hu0h1WNw3ONtHdbdfRZ+deN5LvhUNJ7n+2s
	 CO2qzWZX9cFejbaCuIVxdWY9G/p+tTFgVJNIGSzGUR1s8JZRo2db7sn1EHWLf67Ssu
	 jOPqXAaiVqOCJmFz/oTn7Hc/PRr52FycywqDLUugd+I1nxBIAUTAuAuJoMDHfU7KU4
	 mLRB2YcXvu18E/TnmIN0LWTit5D6Bbyjsv1hqXYnwVgemgcREbJZZVq0D19A8AJFCV
	 1UR+RmD/sKCGw==
Date: Tue, 17 Jun 2025 06:48:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH net-next v3 4/4] netdevsim: account dropped packet
 length in stats on queue free
Message-ID: <20250617064811.0d4e1490@kernel.org>
In-Reply-To: <aFFsh6kFOkhGOO7Q@gmail.com>
References: <20250617-netdevsim_stat-v3-0-afe4bdcbf237@debian.org>
	<20250617-netdevsim_stat-v3-4-afe4bdcbf237@debian.org>
	<20250617055934.3fd9d322@kernel.org>
	<aFFsh6kFOkhGOO7Q@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 06:24:23 -0700 Breno Leitao wrote:
> > here we are in process context and debug checks complain about the use
> > of this_cpu_ptr(). Let's wrap this in local_bh_disable() / enable() ?  
> 
> Thanks. I was able to reproduce it. Your suggestion avoids the complain.
> I suppose we should just wrap dev_dstats_rx_dropped_add(), right?

I think so. I hope that makes the preempt checker happy.
The reason for bh_disable rather than preempt_disable() is that we 
should only update the stats from one context, the NAPI poll context.
So we also need to prevent races with another NAPI running on the same
core while we free an old queue.

