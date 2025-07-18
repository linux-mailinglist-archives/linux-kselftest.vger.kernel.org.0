Return-Path: <linux-kselftest+bounces-37540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C706B0992E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 03:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FEC4A4DE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7786719066D;
	Fri, 18 Jul 2025 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5ITosej"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449AD18CC1D;
	Fri, 18 Jul 2025 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802428; cv=none; b=G3fmwhh6TAmv8sMyX+seME+LVEIUVFvJ9VZmJEp7uMJfWRYmH4VgijdV6jizNuA3qIyKFm7Sfeq7X/Dxp21wl2XM+6Qh0CVEPfVD5vRwl8ijszpmeJNl3NoTg1KEBXEaH/SMUWxOvcdAyuXHiRr8Znl3Hw5/ZbTaBae09ovVdVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802428; c=relaxed/simple;
	bh=sW4Vrjc4tMf4nUOY5B4U0mIARiZwu9fFJqT+gzf5HaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hp06KPfuVx6VoQUKPlpELT3/SuxgP7QkJWkqYIkru10WuefXZvcVAgmQkOBFJK11JvX+i17W/saNbzSD2+0bW0U60NrcKsmvUwrovRJfpuQnOVycKub82zlFIV7IFFQxAnQR1XRjzx5PGYRhaVTHrNqgeEwKS+/rM0AOWEpHtzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5ITosej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFB0C4CEF0;
	Fri, 18 Jul 2025 01:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752802427;
	bh=sW4Vrjc4tMf4nUOY5B4U0mIARiZwu9fFJqT+gzf5HaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N5ITosejOjpgqJZB1zDWN1Y+EnurkQiIyrj297hKgMha/BvNABeWIrCsR5Tx9hgJN
	 gqlWhoRv4eOgSQVTHxYE/bkExZEZicn+8oj1oZzjdzmjLJMe74pEn/JOiEoRqiQoTq
	 DKa9WB6xzcoSOLMUOmX97Sr+rbggI8V9xaPBoTnqvONE5ixSKkjQHX+4SWKX2IkYRo
	 ekxqc1/N3zt/qW1Hj66AtLXaL6lHUzt8/UMU+KtgtHmpGwX4y7eqi8UIfNRHsHxfRz
	 gZaDqQ2+3A5V6p8twtZKiZMiMnne0Pct4y1KRM8ywRwSuuewCj/etJXliRsl1W2jYr
	 OvWkEvcbDe3Lw==
Date: Thu, 17 Jul 2025 18:33:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Christoph Paasch
 <cpaasch@openai.com>, Davide Caratti <dcaratti@redhat.com>, Florian
 Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] selftests: mptcp: connect: cover alt modes
Message-ID: <20250717183346.06576698@kernel.org>
In-Reply-To: <9175b633-b61f-4ca0-9023-c99dff4f53f0@kernel.org>
References: <20250715-net-mptcp-sft-connect-alt-v2-0-8230ddd82454@kernel.org>
	<20250715185308.2ad30691@kernel.org>
	<20250716072602.386a8963@kernel.org>
	<ae6d333a-f3b2-4463-b930-b4caf56b39f8@kernel.org>
	<20250716083632.72854bd5@kernel.org>
	<e46aadbf-51c6-4e09-bdaa-374698b406f3@kernel.org>
	<20250717074242.1ef5d441@kernel.org>
	<9175b633-b61f-4ca0-9023-c99dff4f53f0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 01:49:24 +0200 Matthieu Baerts wrote:
> I see that you already marked the mptcp-connect-sh selftest as ignored,
> so I guess we are not causing other troubles with the CI. (We could then
> also apply this series here and ignore the new tests, but it is also
> fine for me to wait.)

If you're okay either way I'd rather wait. From our perspective the new
tests would go straight into the ignore bucket.

