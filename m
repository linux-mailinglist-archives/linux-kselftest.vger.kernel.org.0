Return-Path: <linux-kselftest+bounces-9302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E928BA4F8
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA844B22BBA
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 01:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE96FC0C;
	Fri,  3 May 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8r4gGEw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62154E541;
	Fri,  3 May 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700429; cv=none; b=BDG3UyWeS7Slnhz2onEkHcKxytZX1CYeInmIS/Oyd6XfQsSnSmP06KO3pkKGGV3m+BhupsgLxJIbPgNJF33ePzLBd8GKtrsO0SMaLHbRdKwlOeWkUCK2Ch4b02K/hloX6t9t4DpKnPDtTzjfpoS0LsW7VmEHWGK2DWt8zKNt/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700429; c=relaxed/simple;
	bh=nwrKFe9hQgZiz44Eq+VW1JSjoQmrmTla6VEEFsn0Xfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e339J4Z2d8JtLrHfKReoqVTXT5gaxAybOx8gFbErc/ql9bZdDka4OqZpboANVAfkNNj57jRmxLKXBnv4W4EpU5V1HfO6EnA93l7eAl9TBmtijBTM9kS9Gap+6/zTFVtZh/l7xJuGG/CZFkUTx7J+Y265E8putWB949GrXdFtGwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8r4gGEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA9B9C4AF14;
	Fri,  3 May 2024 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714700429;
	bh=nwrKFe9hQgZiz44Eq+VW1JSjoQmrmTla6VEEFsn0Xfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j8r4gGEwn1pX5J0orfSw6shGAaZu9sUR0NQrRdeZwGfbpRj+jKB6CCmoIgBMz+FE/
	 54J+3b0DHSkvTirbwVYhfnZrRS7d3WiUwrVk5xdciZpMgcPNi6xllhyznnpYeF5KzT
	 GS4M4NxsMflp5dBCvtzRgiutaKmLM+dicLmyazAsuJ7OI7EsnuScY7tnUDLGJDeu99
	 cNjJG5MmPMn2VwvOTO9KklD/ESVWhFR0OYrWebN1nFu+X+UQGteSJckJY9N1+M69Yp
	 zqcjcDNmKhnE0mZuIXRIYoW3fP/Z2JDZCNVm6RLXsr2U16HUUCiDS1suNYQCWmU4ga
	 55c1AHmdrxhKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA642C4333B;
	Fri,  3 May 2024 01:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: skip partial checksum packets in csum
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171470042889.13840.15070043718193243105.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 01:40:28 +0000
References: <20240501193156.3627344-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240501193156.3627344-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kselftest@vger.kernel.org,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 May 2024 15:30:22 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Detect packets with ip_summed CHECKSUM_PARTIAL and skip these. These
> should not exist, as the test sends individual packets between two
> hosts. But if (HW) GRO is on, with randomized content sometimes
> subsequent packets can be coalesced.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: skip partial checksum packets in csum test
    https://git.kernel.org/netdev/net-next/c/ec6f25bc8aba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



