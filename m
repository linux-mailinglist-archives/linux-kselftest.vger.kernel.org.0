Return-Path: <linux-kselftest+bounces-8516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470718AB83D
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 03:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9E81C20A69
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCEC7FD;
	Sat, 20 Apr 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2gNOZ2M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C038B;
	Sat, 20 Apr 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713575429; cv=none; b=ME45m/wK89ZRDnhbLwvFvHpJZcfIP4JWAbOritQ7Nxau3HHpsJofgx6tXSjVBsua1t05RzCfA/JXvuITzSFpTDjGzQumYluvh1mJjpOo22fgw2TiEcISmbV7F8tE/k47EuPzpGtSFnVoJvPvE1MspafdzQQ/e4FeAnSymTtuqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713575429; c=relaxed/simple;
	bh=n0CYLBiKhMmQ7MPJypaljL5amf1t56M2BZWaTtraXZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HjVtFeWeFGaB0Pbc7YGQzoUof50k3NJ4RLWcDQen9tNwBThSnRNmyobWWnVc1b/72JxfDT2MenTxyI24EJhpgjsJgbKemaL19AnTjS9+ktVCtqtf838Z6ckdvSyYnK0bjdcgMUdfvfHOSnLzLSJGamJwSWlrLj8hYTuDkhSSDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2gNOZ2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C7A3C2BD10;
	Sat, 20 Apr 2024 01:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713575428;
	bh=n0CYLBiKhMmQ7MPJypaljL5amf1t56M2BZWaTtraXZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t2gNOZ2MAkz/U9QicwZDdlBY+M4ieNWo+8xYnv6fOu07z1qlIyRoOD+FpneLbrsS7
	 jnx1ZwhUystJ0UkxkuGMFytcJkreIBDnvxDADyMEztaT5hNBJvVnRwl9ezXW0h5yNd
	 5lWAxC5VFu/v6yiXdvWtsd71aGyAjI7I6xOkWNR88yOMYHnEXJEtii1SnMWh2ol/Kj
	 hNcWQD7057w1ekq0MXLCfyDZoimsZTlBrztduzvQTNE61RGcdn8EHVUxD9rhWhuoON
	 JZM1gpj077hq00SL9eRAoBsc+1JhYU3ZWb1FejA4wnWkw7HnFTTMwmgx+X7MSY5Wd7
	 V/J8bi4dfLPyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57CBBC43618;
	Sat, 20 Apr 2024 01:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/6] use network helpers, part 1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171357542835.21279.4457437966663023836.git-patchwork-notify@kernel.org>
Date: Sat, 20 Apr 2024 01:10:28 +0000
References: <cover.1713427236.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1713427236.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 18 Apr 2024 16:09:06 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v5:
>  - address Martin's comments for v4. (thanks)
>  - drop start_server_addr_opts, add opts as a argument of
>    start_server_addr.
>  - add opts argument for connect_to_addr too.
>  - move some patches out of this set, stay with start_server_addr()
>    and connect_to_addr() only in it.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/6] selftests/bpf: Add start_server_addr helper
    https://git.kernel.org/bpf/bpf-next/c/9c598a83b7ea
  - [bpf-next,v5,2/6] selftests/bpf: Use start_server_addr in cls_redirect
    https://git.kernel.org/bpf/bpf-next/c/9851382fb369
  - [bpf-next,v5,3/6] selftests/bpf: Use start_server_addr in sk_assign
    https://git.kernel.org/bpf/bpf-next/c/a2e4979536c4
  - [bpf-next,v5,4/6] selftests/bpf: Update arguments of connect_to_addr
    https://git.kernel.org/bpf/bpf-next/c/db9994d022ec
  - [bpf-next,v5,5/6] selftests/bpf: Use connect_to_addr in cls_redirect
    https://git.kernel.org/bpf/bpf-next/c/805b4d90c0df
  - [bpf-next,v5,6/6] selftests/bpf: Use connect_to_addr in sk_assign
    https://git.kernel.org/bpf/bpf-next/c/63a51820d29b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



