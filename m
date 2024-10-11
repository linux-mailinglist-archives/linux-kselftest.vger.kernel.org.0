Return-Path: <linux-kselftest+bounces-19493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0F7999A48
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 04:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D02282E5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 02:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549931E9088;
	Fri, 11 Oct 2024 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCVkFoDd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23269748F;
	Fri, 11 Oct 2024 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613223; cv=none; b=tfl5PbPCMqFhtycEbknAUPkafgOMQGro2ATx14G91gaPsIKxQlOjEP2S3AhtFWcJUDFxJTiBm0kt7P/+rRG6nkKsSlMFndnbWo3S2EHAclxEH50uTcVF0HrDLPxUM4Y/hr+Q5lGea4hnjrH2QLLsW3ARbQVKg01DeaWeIuL51ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613223; c=relaxed/simple;
	bh=XBlu0wpqeZhr7tUmHfD9rqUxoOTmXQlZX1cwZ8Je5Fg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pvJzoxmKkW0I4jsZCPE7EAu68pLu+HItglvmeE/zZZbq+FT5CvgcrqDjorpVeAAnV+xGr6f4wVlNHamjyLcuoxzH2beffuJ9EjYYPw5TbpZUrWnfyYWztS8FAD7SHlGHzCH4tdt35lonb/r1pziR6BDtBpDDncwmxriE4yitGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCVkFoDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8871BC4CEC5;
	Fri, 11 Oct 2024 02:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728613222;
	bh=XBlu0wpqeZhr7tUmHfD9rqUxoOTmXQlZX1cwZ8Je5Fg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rCVkFoDd1IKGG0VzxSKWDlWcTKqcKZKVJECqTj7m1+4bn0DDs4pDiMttJbVBWl0kF
	 u5o5BKdNb3sQPu3uxArE8+odldYolAIODehHBMAaXFrxf9eQx0mmWyLoi5Al9D36YJ
	 dLe5QkMQa2wl0yFCYZ0lWIR5Q+3/RjBPhqroOHr3x/a3xmvHWHgaxlyvf6+zV6LThM
	 7OAUlVggIbUx8FL+m/KONqPYyWWbGFwzuhfANU/dcpO9Pjyz7T4DzkfRpSqA8P+jNq
	 nwejcgGg+0ZxlkTbaNpeYOvw+4nh6Nmqk9cb/FrTnhD9jJXYr3Bf3LAeXWDKDYpuBx
	 ryhnFNyNj/fnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34A963803263;
	Fri, 11 Oct 2024 02:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/2] bpf: fix unpopulated path_size when uprobe_multi
 fields unset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172861322701.2249999.15080735852713427254.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 02:20:27 +0000
References: <20241011000803.681190-1-wudevelops@gmail.com>
In-Reply-To: <20241011000803.681190-1-wudevelops@gmail.com>
To: Tyrone Wu <wudevelops@gmail.com>
Cc: andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kernel-patches-bot@fb.com, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.lau@linux.dev, mathieu.desnoyers@efficios.com,
 mattbobrowski@google.com, mhiramat@kernel.org, mykolal@fb.com,
 rostedt@goodmis.org, sdf@fomichev.me, shuah@kernel.org, song@kernel.org,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 11 Oct 2024 00:08:02 +0000 you wrote:
> Previously when retrieving `bpf_link_info.uprobe_multi` with `path` and
> `path_size` fields unset, the `path_size` field is not populated
> (remains 0). This behavior was inconsistent with how other input/output
> string buffer fields work, as the field should be populated in cases
> when:
> - both buffer and length are set (currently works as expected)
> - both buffer and length are unset (not working as expected)
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: fix unpopulated path_size when uprobe_multi fields unset
    https://git.kernel.org/bpf/bpf/c/ad6b5b6ea9b7
  - [bpf,v2,2/2] selftests/bpf: assert link info uprobe_multi count & path_size if unset
    https://git.kernel.org/bpf/bpf/c/b836cbdf3b81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



