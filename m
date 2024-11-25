Return-Path: <linux-kselftest+bounces-22515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFC09D8E8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 23:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3AD4B267BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 22:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4144C1C4A24;
	Mon, 25 Nov 2024 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QftwmXqy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F39169AE6;
	Mon, 25 Nov 2024 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732573822; cv=none; b=s11cvEInaEakDEqDo6iOScPraMK9fQAShPx30XxmzpBiO+/4RWDxmGHyXiLYNh1/t5lkREtvWHSQYav0uH4zrnxz5wcxldsAjvX9X69kniZ3LDeXTIbTZblY36p0S/EFwpJVohCk+H8HgOe3GNMIv+eF3OPcHPGOOtBxq5TYxGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732573822; c=relaxed/simple;
	bh=/IHQU9V83haS+dLeo/M3KvhHm1OXVPaSyKfv79beuW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aGYGZydrF0VGYxYKtbN58ja5Bqz/4fEkS0Nq1rn9CXnI7rc9RGde0P121Sxou/Z8yzaOFcu1+sIvRhfYb+PDnEWDqPcjRQ6Njg58dbycre3I8N5lgZrsDcD3LWFg3HEwroZLaVW+2IfCiyH3j6jf+F9vXM396UZO5haA2F50vM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QftwmXqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88099C4CECE;
	Mon, 25 Nov 2024 22:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732573821;
	bh=/IHQU9V83haS+dLeo/M3KvhHm1OXVPaSyKfv79beuW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QftwmXqynAIOWflUOwUFGdV7H2GSMpX7aDm2l5GSfPOzP6OQecKBjZU0CbDS5G3VK
	 wCkSf7c+CwX3S7shmai+9DiEEgWz63BLmGHfH/zEz3nh0Iodswol71lgWpYsuJD/Uw
	 CuAVlB9TSD6QM1wOGjzzZ8jZr+8srgthc0OOSijUZyW5y+GCbSnHF7DST/gZ9sI0aN
	 reYNZjeOr2N6WscFKb3qxBpICm4Rb+kjyV5c67CRJhFxDb5eyXrEglRFStwFp61Su6
	 SBTnVtKToqgSsgYbGOj2gdtjJU6zYa/QdmF7KUrK9JB38zzHDC0MtzYRVfmnPGkJDq
	 XcMsw9wkHpJCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710AE3809A00;
	Mon, 25 Nov 2024 22:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/4] bpf, vsock: Fix poll() and close()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173257383428.4058254.14371728667735100521.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 22:30:34 +0000
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bobby.eshleman@bytedance.com, mst@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 18 Nov 2024 22:03:40 +0100 you wrote:
> Two small fixes for vsock: poll() missing a queue check, and close() not
> invoking sockmap cleanup.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Michal Luczaj (4):
>       bpf, vsock: Fix poll() missing a queue
>       selftest/bpf: Add test for af_vsock poll()
>       bpf, vsock: Invoke proto::close on close()
>       selftest/bpf: Add test for vsock removal from sockmap on close()
> 
> [...]

Here is the summary with links:
  - [bpf,1/4] bpf, vsock: Fix poll() missing a queue
    https://git.kernel.org/bpf/bpf/c/9f0fc9814521
  - [bpf,2/4] selftest/bpf: Add test for af_vsock poll()
    https://git.kernel.org/bpf/bpf/c/9c2a2a45136d
  - [bpf,3/4] bpf, vsock: Invoke proto::close on close()
    https://git.kernel.org/bpf/bpf/c/135ffc7becc8
  - [bpf,4/4] selftest/bpf: Add test for vsock removal from sockmap on close()
    https://git.kernel.org/bpf/bpf/c/515745445e92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



