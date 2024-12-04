Return-Path: <linux-kselftest+bounces-22839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEDF9E41D3
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 18:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C84167E18
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 17:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D8B1E2306;
	Wed,  4 Dec 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz/m5ukH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F836768FD;
	Wed,  4 Dec 2024 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332214; cv=none; b=T8N4V1c807dmpN0dZC6zpTyv0CUCM2twGKtJx9V8lB3fo2KlR8QM7/TcRJH60l1yZmFJOPnvCWEa0EbHf/ypf7Iw4ce+bL74QIM+nN3m8t5o4rVEFLIZ2unAOnNKHOwbVzlBhTKSNz6dDQ1uTyQRueC8a3H12ql+nLAWY/6L9Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332214; c=relaxed/simple;
	bh=srhR42igPHOP88vC5+31EX3+TZIitMY6D0mNNuXDRkE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e+S6tlYFiWp2/1LFkxTeSOxnerC8W1GGkQ3SPovkOVbglEGUGA+g3qiSL7ZmW/LDoADoEw7RbXwNdFnQJ9dNiCA5NZsJu149yEiWVRW+ZmbdZ6QtsYea07JWVZJKuLzwFlHZDHoZ9kqQDM7fRSITTSwq7QSUIMjADUQCOeR5rTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz/m5ukH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9B7C4CED1;
	Wed,  4 Dec 2024 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332213;
	bh=srhR42igPHOP88vC5+31EX3+TZIitMY6D0mNNuXDRkE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pz/m5ukHO+JFf5myDR57agTDiLQwze+wDGy/I+x6glQi/paUofY7JkTxdzAHkTicI
	 IkJfFOUJS7wkDxdpqEnQqEzy3K5GjyYT2Jq3HrV5zIdT6x5jRhsJw33gDN5+Qt7krW
	 g0v5CTnLG2cH2Znyy1I2cew3Q7fpMbgzTB1SJUNuEXs9QnzzbBYcn+8Qd/FL1s7N7o
	 M1v1RP/FXJnHcX8qhdxvyi+tPkOJz6C5GtAHwYkf+KRAJm2+4+MiNlLC8Aerbnbj4x
	 EOf1//FAnBUIKqMXsTvCvSJhnZkJmAq5cFwmUUmC1fcVgF0DlckantaoGHmE/q6Gtc
	 0M3dv60ALUoSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710503806659;
	Wed,  4 Dec 2024 17:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] tools/testing/selftests/bpf/test_tc_tunnel.sh: Fix
 wait for server bind
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173333222826.1270267.13827895138847245146.git-patchwork-notify@kernel.org>
Date: Wed, 04 Dec 2024 17:10:28 +0000
References: <20241202204530.1143448-1-leogrande@google.com>
In-Reply-To: <20241202204530.1143448-1-leogrande@google.com>
To: Marco Leogrande <leogrande@google.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 alessandro.carminati@gmail.com, willemb@google.com, zhuyifei@google.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  2 Dec 2024 12:45:30 -0800 you wrote:
> Commit f803bcf9208a ("selftests/bpf: Prevent client connect before
> server bind in test_tc_tunnel.sh") added code that waits for the
> netcat server to start before the netcat client attempts to connect to
> it. However, not all calls to 'server_listen' were guarded.
> 
> This patch adds the existing 'wait_for_port' guard after the remaining
> call to 'server_listen'.
> 
> [...]

Here is the summary with links:
  - [bpf-next] tools/testing/selftests/bpf/test_tc_tunnel.sh: Fix wait for server bind
    https://git.kernel.org/bpf/bpf-next/c/e2f0791124a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



