Return-Path: <linux-kselftest+bounces-6439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A9088081E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 00:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB91B21E30
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 23:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304D75F569;
	Tue, 19 Mar 2024 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdaLhh37"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00326364D4;
	Tue, 19 Mar 2024 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710890428; cv=none; b=MkL0oNp+Mf14m8e/x+mxyzLPKVvj6MAAB3L4BwK2aTXg+hJQpR6Bu9KfjCHwFM1Fm9zhFc3T8dDsvSsIDS7g8xqwQuFPBr2nm/J7pgwJ9pisWrzwY9q2A4SbJ0CGQrFCj0b7ZBtxwPzKs8z4bU10M9E81lSakSMFYltz2QqYyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710890428; c=relaxed/simple;
	bh=CQKbFkrVkDYh/llXbWxxM3JwFbyg1gkNdIvlA/llHQg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KXIgDVaAISyWXqYniqiSn8qa6Tqp2RKdE097SxG/AgyEJc9hysJkJa41FsLR7zLynJIKrPR/Et7b1ZIQVKVU6DgqJVftK0cX5Y9Fqng8buy4H7XhE5GSiiIUIBovU4oslElTs3axcK95wlYU6mU+RrsJjgU0oLSC6AhxejNGvDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdaLhh37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 523E9C433F1;
	Tue, 19 Mar 2024 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710890427;
	bh=CQKbFkrVkDYh/llXbWxxM3JwFbyg1gkNdIvlA/llHQg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RdaLhh37gd8OOwXuZblOjmi5Q63P1keLkG8dua+AmT9ioknX7bOkd1fd2oIrDUto3
	 NCLXKpq+EYDT7d2b2M94y6Ypk5D/VaUWEVnMXlaP7WTU8pXTAwmw6tJ4NFkeszPnWF
	 GeG7CbrFWcFtMmJmCRS8lYSagBJ6uNVWMZ27eexu5IBVBInvXR+2U/95/U7gdsyDa9
	 EoYwDxWV/fbnTq9BHPF1sZWpQHssphSBrOmAGETmm8kslUv9/dLiTxKacgaOSyvCHw
	 c86yyYj1M6CRgt4vIbwc0rZANC+ZqlyUD6keupUba+4DYxytFsJGbtOlheWeI3mUmF
	 4asiQzbrI9w0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41BC8D84BB3;
	Tue, 19 Mar 2024 23:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] tools/testing/selftests/bpf/test_tc_tunnel.sh: Prevent
 client connect before server bind
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171089042726.26358.17979567034735426753.git-patchwork-notify@kernel.org>
Date: Tue, 19 Mar 2024 23:20:27 +0000
References: <20240314105911.213411-1-alessandro.carminati@gmail.com>
In-Reply-To: <20240314105911.213411-1-alessandro.carminati@gmail.com>
To: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
Cc: andrii@kernel.org, shuah@kernel.org, martin.lau@linux.dev, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 14 Mar 2024 10:59:11 +0000 you wrote:
> In some systems, the netcat server can incur in delay to start listening.
> When this happens, the test can randomly fail in various points.
> This is an example error message:
> 
>    # ip gre none gso
>    # encap 192.168.1.1 to 192.168.1.2, type gre, mac none len 2000
>    # test basic connectivity
>    # Ncat: Connection refused.
> 
> [...]

Here is the summary with links:
  - [v2] tools/testing/selftests/bpf/test_tc_tunnel.sh: Prevent client connect before server bind
    https://git.kernel.org/bpf/bpf-next/c/f803bcf9208a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



