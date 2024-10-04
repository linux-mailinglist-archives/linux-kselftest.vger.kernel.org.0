Return-Path: <linux-kselftest+bounces-18994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A927498FB4D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 02:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05901C2236D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 00:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E067C1CC8BD;
	Fri,  4 Oct 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWj5ILNO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0A1D0B8B;
	Fri,  4 Oct 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728000031; cv=none; b=I8laOqnDGcZGdm6OGiyqneEMKv8E0J9KiRXasTrG7mqY9EROE6pVdfRtx1YagIcxjcI+33DNp5o1LrxBG+/YjWXFaOQM5lyGZwZkpy84XM1qf9z7c+EOr/Nt00etKvIZ+rGjmHB7geoOpLbfKwDdg5BFhwCpG6VsFoREXx2t5kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728000031; c=relaxed/simple;
	bh=+xvAIX6IJFp5VUob+EF6es/jA7D5vA7Q0y9G0s+Uvis=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ASPt0YpqAhOS4316zaS3niRhhKdXISov6v0zf7RZMoEuYfdbSHwBWpTJHXWKpkOEqyIBSzTD+M1tweeyim7jUR8uEKpnuAnmElTq+HuDb9XSSZ0rbvbZF6b32BSdZFwtO8TrbDM0T523JbBYYyD1K4v0vPPqBULaYlTqGwpjaRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWj5ILNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418E7C4CEC7;
	Fri,  4 Oct 2024 00:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728000031;
	bh=+xvAIX6IJFp5VUob+EF6es/jA7D5vA7Q0y9G0s+Uvis=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UWj5ILNObymFnthWJ043Bs7QJwUOFAN3+39bezt06Cg/NqqBRg9RlpNlMGzPzvBXT
	 3ACqN3i5SSiBDZlpD+ZsJw+ET7CzXPoxEpIRwNnuE7cOughzLQeTYgWLC43MveHNou
	 AJpOJOaPL0DZDVcNJLiQ774WRPTpGJUAx8aetKg2355NsZnIPRf6wl60/uWT7+1J9A
	 fUhAHz4O1nwepv96YNIgrPzP4kmgCNDX4l/aUN/Oaa7FRd8dsyXWTgiOwwr0z9hKzQ
	 XzoZbu7Z5VchQ8quIgA9xuiB1EfDDFEgZlEgNkL5hF+JLDfcmKTgMMlv3Hq1/3djzf
	 RsAswhqQNHW2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5BE3803263;
	Fri,  4 Oct 2024 00:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: csum: Clean up
 recv_verify_packet_ipv6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172800003451.2035955.15765832023119892490.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 00:00:34 +0000
References: <20240930162935.980712-1-sean.anderson@linux.dev>
In-Reply-To: <20240930162935.980712-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, willemb@google.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Sep 2024 12:29:34 -0400 you wrote:
> Rename ip_len to payload_len since the length in this case refers only
> to the payload, and not the entire IP packet like for IPv4. While we're
> at it, just use the variable directly when calling
> recv_verify_packet_udp/tcp.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: csum: Clean up recv_verify_packet_ipv6
    https://git.kernel.org/netdev/net-next/c/d772cc25ccf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



