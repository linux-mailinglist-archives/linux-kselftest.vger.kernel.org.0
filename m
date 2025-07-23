Return-Path: <linux-kselftest+bounces-37881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB00B0F4F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 16:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299F71884BBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728072D3723;
	Wed, 23 Jul 2025 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STy9M1Ev"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE2422F755;
	Wed, 23 Jul 2025 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279976; cv=none; b=HZBhNv9rvUdKoNkb/Lp3sEAgq9U5QCndtdA1iPTLbXjZn2Ew1hTSbgZe51dnyvTffYp/bh6xvRsM30mPZVgr9vgF3QkO3FIUFKvgud/SLE14tNdrDgeh3wtYLzZg80iixYiu08BaEcVCrGumdvnLsJTX2sMun4YDc/WZ5V5troY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279976; c=relaxed/simple;
	bh=dcKCD/aF7xJwbKKl79LFdtsYfWfciBaVw1Uci7MOVO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+p+kIYH8nsxxYBkQRpvjLMjNF+jMLXQgTnLgSOr3otlajL/TXToHUOCmO4rNxNqsPjfvHNIR7EXa0abkYfCpCGWG0qmGzG8M/3kSui6ngtRdGXWJjyvmSghp3xKQA34m+YsmfxgPt2ye+K6JiS5IToXuvfaev5sMJOjzHXzcUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STy9M1Ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D4DC4CEEF;
	Wed, 23 Jul 2025 14:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753279975;
	bh=dcKCD/aF7xJwbKKl79LFdtsYfWfciBaVw1Uci7MOVO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=STy9M1EvNUe1+oGFgEUF9aZiKVHmPLZGiOOr/g2KMSC9iu+MX7aLfYDBAgaqg1IvE
	 flypRPN/g5sFxt8ErJiLMvVxYc2z47IeC/iwXkn9ndjQtV8NNmP841hSx7ZyPCbuBC
	 oIK0a2q1QIeIyXqNSYKkTZgOMXUS3tVV+2Duv+QFhW/aCwZq0r18giRlQuya2yZtr6
	 uovy+UfNesOJK3RSdErTNxan3v+bxx04+P//0XfWlzV/D2G0CLFAt9xxHG7Woau5EC
	 5l1crr3fM14jKNi3mMXmRgMBodJUsAeuQfIEbEQ1cBEoJD39AaubIE5x3+vwxURfpZ
	 TApGW2ISFrCXA==
Date: Wed, 23 Jul 2025 07:12:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 horms@kernel.org, cratiu@nvidia.com, noren@nvidia.com, cjubran@nvidia.com,
 mbloch@nvidia.com, jdamato@fastly.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, Mohsin Bashir
 <mohsin.bashr@gmail.com>, patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net-next V6 0/5] selftests: drv-net: Test XDP native
 support
Message-ID: <20250723071253.54a97c65@kernel.org>
In-Reply-To: <48bb190e-073c-4ad8-841b-f6d0572cb0fd@nvidia.com>
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
	<175323423849.1016544.9128937268934260157.git-patchwork-notify@kernel.org>
	<48bb190e-073c-4ad8-841b-f6d0572cb0fd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 10:11:57 +0300 Gal Pressman wrote:
> On 23/07/2025 4:30, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> > 
> > This series was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:  
> 
> Jakub, the test was still under active discussion, and you knowingly
> merged it with buggy code, ignoring our comments.
> 
> This is *extremely disrespectful* towards people that spent time
> reviewing, replying and participating in the netdev mailing list.
> 
> I expect better from you, and other netdev maintainers which allow this
> to happen. Please uphold your responsibilities as maintainers towards
> the community, this is unacceptable behavior.

Man, I just want tests upstream. How hard is this to understand.

These tests even work on mlx5, AFAIU, just not if LRO is enabled.

Please at least try to think about what's good for this community.
At least try.

