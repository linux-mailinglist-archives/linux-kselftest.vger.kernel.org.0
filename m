Return-Path: <linux-kselftest+bounces-37440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7A3B07A1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 17:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A5D188187A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 15:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65F62BEFF2;
	Wed, 16 Jul 2025 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfCGDrmF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44EF2641F9;
	Wed, 16 Jul 2025 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680193; cv=none; b=AKVMMak6tcipGhNOW03a5xmrgfxDP8N29LJybaBN3ifrQ6E/lXGZQbY6vKjNCKjO/vcfRfwfd7MjzJHhytupacdLCc5837q4EtfpIVR+7N6++THyW8stgGYnwmV0nxgqWGMEGN4dg0N6A2q5mrb6Oxg8lU2k4UrHhqbf0lOf888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680193; c=relaxed/simple;
	bh=LfcN58E+wT6X/9bxcUXMGxrSY3+YrRAG6E81uV8kmAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0rcMKmQr3kxQ8oo9KX89ZKOLIIJxlHE1ULl3eEScHPQ9la7AAC9nwVcCHwoe0mU4RmskOfIFCPCXbiYjCwPttstTyFCwFO8uVLw9ZjPF6E+5QEp4W1gt5Baucv2PQPolkrCTvin3zjFEDC2bQ5xrbgYirnVILkHeEC0n/9vTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfCGDrmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B706C4CEE7;
	Wed, 16 Jul 2025 15:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752680193;
	bh=LfcN58E+wT6X/9bxcUXMGxrSY3+YrRAG6E81uV8kmAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HfCGDrmF8iibkidoHw/T9nABaxRIuCaAqfT555BP2AdKpJhiR+g4D7Nqjd4hwvWtn
	 mX7GFARX1/Vg4ao7uQYszuQ3CrjjEJtNPtk6NR+tNK3zg179OoTB3fgFHpcKdXv1iN
	 EVNRTWvHWlZFkZIkB+Snp0x3KVoycNlbhIYwJgZLUHtj6vKcNbi86rr8BCKl//dfdk
	 4VB+V3hEPGJmXfTE2N3Y5uQgDKyfsYmVbcxQySq9FgoLjaF9h3SYgjqMds4c6rCv5O
	 9/om/LKlv1dNTzuwSP21vwOFRDM9djjiNuaoNirFqD84vPCGtzA/sbhEriIVpddJ5x
	 nRA6kOceYncxQ==
Date: Wed, 16 Jul 2025 08:36:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Christoph Paasch
 <cpaasch@openai.com>, Davide Caratti <dcaratti@redhat.com>, Florian
 Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] selftests: mptcp: connect: cover alt modes
Message-ID: <20250716083632.72854bd5@kernel.org>
In-Reply-To: <ae6d333a-f3b2-4463-b930-b4caf56b39f8@kernel.org>
References: <20250715-net-mptcp-sft-connect-alt-v2-0-8230ddd82454@kernel.org>
	<20250715185308.2ad30691@kernel.org>
	<20250716072602.386a8963@kernel.org>
	<ae6d333a-f3b2-4463-b930-b4caf56b39f8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 16:55:21 +0200 Matthieu Baerts wrote:
> >> Looks like the failures that Paolo flagged yesterday:
> >>
> >> https://lore.kernel.org/all/a7a89aa2-7354-42c7-8219-99a3cafd3b33@redhat.com/
> >>
> >> are back as soon as this hit NIPA :(
> >>
> >> https://netdev.bots.linux.dev/contest.html?branch=net-next-2025-07-16--00-00&executor=vmksft-mptcp&pw-n=0&pass=0
> >>
> >> No idea why TBH, the tests run sequentially and connect.sh run before
> >> any of the new ones.  
> 
> And just to be sure, no CPU or IO overload at that moment? I didn't see
> such errors reported by our CI, but I can try to reproduce them locally
> in different conditions.

None that I can see. The test run ~10min after all the builds completed,
and we wait now for the CPU load to die down and writeback to finish
before we kick off VMs. The VMs for various tests are running at that
point, the CPU util averaged across cores is 66%.

