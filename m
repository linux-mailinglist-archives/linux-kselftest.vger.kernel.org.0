Return-Path: <linux-kselftest+bounces-12830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC02919B53
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 01:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80071F226DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 23:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFDE194159;
	Wed, 26 Jun 2024 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctx85GuY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B146D190489;
	Wed, 26 Jun 2024 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445228; cv=none; b=PAIh86925SPGhGYfhp9iCgb/eQgm4NGPo0zrMOU3emW05RWcWOHQjXuPnkeuHFPPT5tGoTud+k/d9UEfL4QnM9QpeYZeBtBpisUS+Y5jQfPooWpRhSyGRgC3CAI8rN4ka5fGzrnsmZQtiv3c5bXn6XM26VeStEwmqLGawrsh1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445228; c=relaxed/simple;
	bh=v9EZ7JTiSdfy4E9+nJYNIlBDupy1UILGgzDWql0D9qM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=im/SE28t9OEZqeY6qhkwlWPO9FgGG63gGWJQ76KlcD/OCueOi/y0zThDQ3ijGR/1mu5/Cvkto9K+AnOFgr9VfPw4vvRUIWDj3KIihl6xqGQ/Sz+mpdc/9mFbU0hJVDzFFMH0zR+Y4D2WYUaRdhugO/rb1doizj1yItn2u38ZmlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctx85GuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5797CC4AF07;
	Wed, 26 Jun 2024 23:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719445228;
	bh=v9EZ7JTiSdfy4E9+nJYNIlBDupy1UILGgzDWql0D9qM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ctx85GuYMXbCzcC4b7CCGuJDRFwe6VUX4iGFQzKdtae3QhNyGcM4Zx3UUQujtQUwB
	 kd2UPnaRzynE4sI7LTc5I5pMYlbfbBTPW5zzcmTbtAnI42Aw5KUvA2x3FZ8i9k9E86
	 oDmIrMjzRZ4epzbxKnag8qI9N36s+URodhxj6qUvlzgnRzN7cxyaDWMaEyFTUnI3T6
	 335n0B+W0w1UcBK8QzDK4K5QMnuyZOVMSoQexv+zm4karZGlvXF85MwlWbFsg3M0Rt
	 jCc7e1Go0JzuD+0CnZaDIYxuVRA+n1NVi9L0Z7MTQcruMRjh0PEc/VZdvYkuosCaNl
	 N/UgPvTW884BA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49A2EC43338;
	Wed, 26 Jun 2024 23:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: don't close(-1) in serial_test_fexit_stress()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171944522829.32321.18337572049899460698.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 23:40:28 +0000
References: <20240623131753.2133829-1-make24@iscas.ac.cn>
In-Reply-To: <20240623131753.2133829-1-make24@iscas.ac.cn>
To: Ma Ke <make24@iscas.ac.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 23 Jun 2024 21:17:53 +0800 you wrote:
> Guard close() with extra link_fd[i] >= 0 and fexit_fd[i] >= 0
> check to prevent close(-1).
> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  tools/testing/selftests/bpf/prog_tests/fexit_stress.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - selftests/bpf: don't close(-1) in serial_test_fexit_stress()
    https://git.kernel.org/bpf/bpf-next/c/d07980f7373b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



