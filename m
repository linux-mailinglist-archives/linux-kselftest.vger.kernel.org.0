Return-Path: <linux-kselftest+bounces-7966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 087CA8A52EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30AA1F215A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE574E11;
	Mon, 15 Apr 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYe0tMKv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3283745D5;
	Mon, 15 Apr 2024 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190756; cv=none; b=gg+5/GKWyrWxAA1mEFShCHUZsgrFfQzR2OVrCR2d8d79y/QZxMyn5vXD4HaN7SLNtHKS64O16D+FGFY1H9tTDwtaJvv79gj0SURpfBXk91nLJ6mmsai+rKj3qmpZLrFBpLbm6KVXzA7V8pc31ckZAUW3QsBQYK2ZZc6QeARYFWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190756; c=relaxed/simple;
	bh=JeimtFTkfTL33ihMjHg/VwYTlDLT+C96kk9x0TEuXu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NdlQ3NTElM2UrZgJ82C8Q35rGDsRhQxCc0m6DJUgPhNU9tg4+g20TpiobJDyCO+qa2FtsoD+ZNYf7u5l2+y8fKZKn3XO90lZQwrd0A6EIek3KvStgurWR8rM/TcZyIRbQN+Qr2odh72dXVsiHoZW0GCjyZOeHojoVCVbafba5kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYe0tMKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA11C113CC;
	Mon, 15 Apr 2024 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713190755;
	bh=JeimtFTkfTL33ihMjHg/VwYTlDLT+C96kk9x0TEuXu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bYe0tMKvx1AKM94jO1+abSOn+pv/JdSvHcjJPgSTNz5kt9ixKRKdPN0Wdaej1mxYi
	 DyO0Gzx4fMYMrpo+Gkvn1S5+X7UOBf8l3XlPRiG0P9ZkrbsJDtmusBirQDKYV3bJ5V
	 QSDvADlDL782LRF4o49lUyiRDvPkk3NLD/XJgyrGBZKbH+x9jPtWRZWTyOpWWhdJZ8
	 36tTWcAvlt2tq0xajpvRw8oRiIq7eb6yEji9rkcTpljeffartgmopEXW3K8u+34tBL
	 JUOPiwjQu5ydeMmDeeOstJVQtSUZNe0Rm3JcXfyB1d3DyADDWz8Uu1p/bFYVJNdcby
	 zTxG/j91mvGmQ==
Date: Mon, 15 Apr 2024 07:19:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 shuah@kernel.org, petrm@nvidia.com, linux-kselftest@vger.kernel.org,
 willemb@google.com
Subject: Re: [PATCH net-next 1/5] selftests: drv-net: define endpoint
 structures
Message-ID: <20240415071914.23589fb8@kernel.org>
In-Reply-To: <a80414c647940747c37a8c750bad4290ec81bd66.camel@redhat.com>
References: <20240412233705.1066444-1-kuba@kernel.org>
	<20240412233705.1066444-2-kuba@kernel.org>
	<a80414c647940747c37a8c750bad4290ec81bd66.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 10:57:31 +0200 Paolo Abeni wrote:
> If I read correctly the above will do a full ssh handshake for each
> command. If the test script/setup is complex, I think/fear the overhead
> could become a bit cumbersome.

Connection reuse. I wasn't sure if I should add a hint to the README,
let me do so.

> Would using something alike Fabric to create a single connection at
> endpoint instantiation time and re-using it for all the command be too
> much? 

IDK what "Fabric" is, if its commonly used we can add the option
in tree. If less commonly - I hope the dynamic loading scheme
will allow users to very easily drop in their own class that 
integrates with Fabric, without dirtying the tree? :)

