Return-Path: <linux-kselftest+bounces-10366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A438C8C84
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 21:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C543D286C6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 19:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC9113E3F0;
	Fri, 17 May 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCUiYhqb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D721046430;
	Fri, 17 May 2024 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972662; cv=none; b=B0olTL7qvstkLxLLMap6CKLGhdO9sBwcPO7YJMVoyv99o6E+1c340a9zDzwGG1u4lTFwB73nZYFmtypF3lLe1WtMd2Cm1VVcZzKnH2dl+wXW6EnZsY2EYOYHwKYzRX9GEfAP2l70rIy3ZJSLtEj+VNZAreoc6hS7sB6W4CyByiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972662; c=relaxed/simple;
	bh=6Q08qzjH3mByLRnf0wCGvpEntm1gnTw+Dyh43j9WtaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0xm8JHMLD+pWaQa7EcJY9le32PEB2jcrlUN9YdXPCaOi8xia2+fODfSc6Z2JXQQkrzUzzFg1qzf+sSl+sYo19TJjnuSsKBLOTgerun/ulkJTBK+lpywMtJoX0XjfPyDgcrnnyDyCMp5YizYdPYwa/w6w9TOGcOuTxMwPGPPv8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCUiYhqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72F7C2BD10;
	Fri, 17 May 2024 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715972662;
	bh=6Q08qzjH3mByLRnf0wCGvpEntm1gnTw+Dyh43j9WtaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CCUiYhqbVBjPqNL2fYvv2/0NTKB8BTC1w2+Dzv7RlkctKLI4z6syvqA1j+s65dAgE
	 JbCV+6CNIB3RpGZohJ0v7A7BFVkQvQ/OAr4UzMQB8Ti7m4zRKmAD3otzjwfrqwxIyn
	 KZ/yFLRhaVYwVDBfa7iO8z5JWwhofOIvqekqftRzUcA6e56h0og4Xkl7C4SdEnLstt
	 r5T08z3pB20JKtsWY2pMt5jjgFasCrAZ539H9uaojvJt1hm/kbTtt6qU99StNGAvFI
	 3X1nmJs7fwjibsqzlT0R+EhtSj2nhmWyREj7UrbBSSSygF9rBc29RbAro66MmM4ksp
	 FqrBl20fid5sQ==
Date: Fri, 17 May 2024 12:04:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Petr Machata
 <petrm@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>, Ido Schimmel
 <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Jaehee Park <jhpark1013@gmail.com>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net] selftests/net: use tc rule to filter the na
 packet
Message-ID: <20240517120420.6d2d34a2@kernel.org>
In-Reply-To: <20240517091402.GD443576@kernel.org>
References: <20240517010327.2631319-1-liuhangbin@gmail.com>
	<20240517091402.GD443576@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 May 2024 10:14:02 +0100 Simon Horman wrote:
> Jakub, is there a way to tell how long a test took to execute?
> Perhaps it's obvious, but I couldn't see it.

It's not obvious, and it was broken. There's an 'info' file with
extra metadata in the directory with results:

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/599300/39-arp-ndisc-untracked-subnets-sh/info

but it's currently reporting fractional seconds rather than total
seconds:

https://github.com/linux-netdev/nipa/commit/fb7c45fd3b68b379b7bceb8f79c8df06aaf53ee0

Once we have a proper DB (any day now), I'll add it to the JSON output
so it appears in the web UI.

