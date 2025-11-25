Return-Path: <linux-kselftest+bounces-46465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4DAC875DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 23:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D00424EAB67
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F1333B6F8;
	Tue, 25 Nov 2025 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVdxS+06"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880433B6DA;
	Tue, 25 Nov 2025 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110458; cv=none; b=eGrgVZaySo/wnUOOoI+4+VnCLiv9qoJMW6Ocb3EhMeYt2OgheCFAG0uy9YA5kge/VAa8WFlmhv1tcBosrHSMMX1VozwhFSoUsZqvhqnpnYp6icghmIWjFH3GSJM+ZSJM8M8xXsV97e748Or+Js292vIXjSxolgSDARuI5aspODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110458; c=relaxed/simple;
	bh=qzcFAHmdt6cx3hUzQ8nN9tYa2RaITTR87CCtlOy0yF8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IbJGT4YcTSKM+lx+GtGHhy3neWHNxQG4nl5pO7JHcAEeHm+o4+IFPEaluc0jLF+aQXd75nrFZACjR85Vd/TcPmD0X+eVZUcqriG7yW3rLofOrijNwmyMGNjeivursrh5o535/qXAjBQ84rjvHGhW7v3hUeeSkfo4TvoKEvSQc68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVdxS+06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C2EC4CEF1;
	Tue, 25 Nov 2025 22:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764110457;
	bh=qzcFAHmdt6cx3hUzQ8nN9tYa2RaITTR87CCtlOy0yF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RVdxS+06MAUSdpO2wOORdsnFLK7/twe6ohahemOrcxA3aehhUjzY0pptxw7TMhVy0
	 P3RZKXodRd6AEMTLTLn/o1ywWws7N/gkRWRqau09SbMIlTghMdJSmDBOXQnDxEHnns
	 o1/tZNYkP4jAKzLEQQhp0L0TfKI0UCgYnWfa71xSzCLyhgOeUz70/0soj4qcJE+NkH
	 9P1NOojV+oCJDpvcc8GqJjG05KcBRljkrR5o3i7AvGxB49rQxeQ33g6qY45boYknOn
	 5FR3md+U+icQiOlljzD0hi+flVo40hLpEykbkqWfP6j7DZoed8Ism8JkuALZ7Mmaly
	 MYOStlOXfjJ7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ED3380AADF;
	Tue, 25 Nov 2025 22:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: call bpf_get_numa_node_id() in
 trigger_count()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176411042002.938389.8098195696684849372.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 22:40:20 +0000
References: <20251116014242.151110-1-dongml2@chinatelecom.cn>
In-Reply-To: <20251116014242.151110-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 mingo@kernel.org, jiang.biao@linux.dev, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 16 Nov 2025 09:42:42 +0800 you wrote:
> The bench test "trig-kernel-count" can be used as a baseline comparison
> for fentry and other benchmarks, and the calling to bpf_get_numa_node_id()
> should be considered as composition of the baseline. So, let's call it in
> trigger_count(). Meanwhile, rename trigger_count() to
> trigger_kernel_count() to make it easier understand.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: call bpf_get_numa_node_id() in trigger_count()
    https://git.kernel.org/bpf/bpf-next/c/f2cb0660ac99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



