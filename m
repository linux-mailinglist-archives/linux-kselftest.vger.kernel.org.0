Return-Path: <linux-kselftest+bounces-37775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F2BB0CBC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 22:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2546A170D96
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 20:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC4123A9AA;
	Mon, 21 Jul 2025 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEm8yKRf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D043819CC28;
	Mon, 21 Jul 2025 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129453; cv=none; b=sf8EgWI3DEVLJB7zAar96zcLBBn1qyHHprfasCtloYf1cqJ/Q6y9glCi1o+jD6kA37bhoyhWre4K2ksB9OSxNLVcVC3qXrQXakdkwLxO14ox6akk+7pH6JrNLW+2ZleHHiGROjvV+2yUUf5XjHhWFrmqyldhEbE6tfdTrqtphUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129453; c=relaxed/simple;
	bh=lGWojFlqKceOPEIC8jz6krfuXA/VX+FAXpX33gZ/PRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RN4HS4U1NDIwOw/yoFFZq7M6DxKtTNOFqLrsEIp/LSm4AKyggLR1gO+N/bpzoxNG1sF/ZPMt3oRAfdquKZiEx06wSjhCSMOYiUtlDlJS8Yu8KZxr08Af4BA8oR66iOGE5YuqoSjzIkylKftb39YCk1ZMWZAMzOaMzKglVN2MzCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEm8yKRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A387C4CEED;
	Mon, 21 Jul 2025 20:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753129453;
	bh=lGWojFlqKceOPEIC8jz6krfuXA/VX+FAXpX33gZ/PRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iEm8yKRfT8+4ntN766Gs4C9LpIh63LWRdue3MRHBQ+FgQqLHVlH/SsaF+sMMY+1oS
	 KBoFV4RpNaS4bMp7AiFDnM0AkA2yDNXAXizhIJM55UMZX/C+vB6JDCm9HvAH6O3y+J
	 baZejecSevkzN2ZYNCRR7HdwcwC9B2fDbkVRik5OCF9Ttp5BwEPI7XYq/GuRLl7J1S
	 vZQehMwGX9cFBVGs4IG23QmQhHktYrlJWUzQbivT378/nL2aqUA4C4Q4uVXpjUJIUf
	 v2YxgmI1OH9nlnMnn/Eeyanc1NryXg/aAX8LraCIbprJ8t8cEPpLKWrkZgOxMENHt8
	 GeB51CfnjDiGQ==
Date: Mon, 21 Jul 2025 13:24:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nimrod Oren <noren@nvidia.com>, netdev@vger.kernel.org, Mohsin Bashir
 <mohsin.bashr@gmail.com>, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, gal@nvidia.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, tariqt@nvidia.com,
 thoiland@redhat.com, Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH net-next V6 2/5] selftests: drv-net: Test XDP_PASS/DROP
 support
Message-ID: <20250721132411.05d9d0fd@kernel.org>
In-Reply-To: <fd195e9f-e584-4546-ac29-86ae4995c6ff@linux.dev>
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
	<20250719083059.3209169-3-mohsin.bashr@gmail.com>
	<ab65545f-c79c-492b-a699-39f7afa984ea@nvidia.com>
	<fd195e9f-e584-4546-ac29-86ae4995c6ff@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 12:43:57 -0700 Martin KaFai Lau wrote:
> On 7/21/25 4:43 AM, Nimrod Oren wrote:
> > To ensure correctness across all drivers, all direct accesses to packet
> > data should use these safer helper functions instead:
> > bpf_xdp_load_bytes() and bpf_xdp_store_bytes().  
> 
> Not sure if the test will be run on the older kernel. fwiw, there is a 
> bpf_dynptr_slice_rdwr() kfunc which was added in commit 66e3a13e7c2c.
> It uses bpf_xdp_pointer() underneath, so it can avoid a copy if the requested 
> data is contained in a single frag.

We discussed running the tests on stable but nothing materialized, yet.

