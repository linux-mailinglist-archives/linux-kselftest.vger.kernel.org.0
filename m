Return-Path: <linux-kselftest+bounces-37135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 451BDB02258
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 19:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568B21CA69C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 17:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C382EF9A3;
	Fri, 11 Jul 2025 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzUwla26"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F0D944E;
	Fri, 11 Jul 2025 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253837; cv=none; b=U5jOjo30WUFISXhNjSdDlO6tqnwCTyVYdzLrw5fx+fRsMm1QfB+Ken+uP4o7f16vfybRwqeStsSsd1uU+kxTmjUKJatoZjRopLmusdd1989IabmykllDk5rJF+vgdJj04zeB1LcvfVHaQgQGet3+RwnnH1YGqs6Qu7Z+9AHv4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253837; c=relaxed/simple;
	bh=VLhQ9Jh51KW0cQF5JHhSabHlwYxH+VwefKhfZOhFJH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xhg70XGPp+vyET8xlqzfD/S4yu1tFd71JnT70ESKrpDyZnfi/hAnmavWgIWze3SsJxorwIOt1IU0kfnSDZpWBf8Zbpu+do9sJQ1Mf0LMZSGW+tl3ppmjeRY7y5WxSd2ZINJZquCnY+XN8saUPm3icSQLW4k9iSFc8dz7nvi0PlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzUwla26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D04BC4CEED;
	Fri, 11 Jul 2025 17:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752253836;
	bh=VLhQ9Jh51KW0cQF5JHhSabHlwYxH+VwefKhfZOhFJH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KzUwla26tzOudFb08W23T5fD6xWMyVbyEiWpXVbJpIHZzOBYRCW17hVL6FgYELkuc
	 E/DCX1qxiXr447Hvavpg5WE5gQZnk7AksTZpvmoFNythUsogK0LSQ6EYT6NlD9fhWf
	 93dwTCMSZCwljUHNFDDErqQ5FbjtWyprszW28mBEWPSR2sYWcMwNk9I9MvXLAseFjJ
	 1YwK3IpyByqGH/+Ly2pgQ4OYs/ZnzpLCwLgVbKvzs7iCRxtGdaYO6ZF23vWzxY5vZm
	 icDs51mp1oJ9nWj0JvKxatOrOnzkyAD0uriyqCZbk7CxQQP4jh2UhqELsXdrEn6VkH
	 c3KR5SaoAYP/Q==
Date: Fri, 11 Jul 2025 10:10:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, noren@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, gal@nvidia.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] selftests: drv-net: Add bpftool util
Message-ID: <20250711101035.3caf92c8@kernel.org>
In-Reply-To: <20250710184351.63797-2-mohsin.bashr@gmail.com>
References: <20250710184351.63797-1-mohsin.bashr@gmail.com>
	<20250710184351.63797-2-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 11:43:47 -0700 Mohsin Bashir wrote:
> Add bpf utility to simplify the use of bpftool for XDP tests included in
> this series.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

I'm going to apply this patch already, because it keeps conflicting
with Breno's series. I don't think its controversial..


