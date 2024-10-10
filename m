Return-Path: <linux-kselftest+bounces-19416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6465A997A12
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 03:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E940F1C219BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 01:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BD122338;
	Thu, 10 Oct 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0OqV00J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7765310A12;
	Thu, 10 Oct 2024 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523227; cv=none; b=UAuIoomG3VMWo86rMGV7LFxanyXo0N4eMpEFnzgTZzcvfjanSyGC/2zE0BCUiUR9+UKboWDai4e+dw3LH1Syn3S5wby7qco1cPV6xwZBxwK0ylVcRDWNbNbB4x2O95KjyKGD/d0Qp8nTOR9ZgD3yTdnH8+XlAeasagRi/LiRTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523227; c=relaxed/simple;
	bh=JNkU9z36v7DhdO57QTSi0+0anL0dqFwwcuKDBVk8Ge0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NtekybOiDLFV5JwFFWXSXhjyvnB51i3L3UnFFtqBc9VTLT6xwTW6TpNUuUSu0zP3xoJhVu+Dv6JLkgBODRU02KDXLz8o5f07flmvnrQlYe7KblIOp3tGUlIf/VZeDvslX5G/N8Qd2ywmWrEhzqVs5ckiJF4I0lNZv7n77PTSQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0OqV00J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF7AC4CEC3;
	Thu, 10 Oct 2024 01:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728523226;
	bh=JNkU9z36v7DhdO57QTSi0+0anL0dqFwwcuKDBVk8Ge0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d0OqV00J9Rlg2RxIr0dRKGR8jOxQAmqNnavbVAeGPBLztzWXPsZdv0U9+TKbKlQXd
	 vWPDrDlhZ2YLd9uRXhMH9GUtSXxYBsXScKnKJ+xi9A22/zXhAFqK9GWR8/8eYxUQjK
	 nMt2XXt3KFgH6DGpFcA1kroUZGVNgdw8pB20//Ehq5txRx0PZc/mgn04IYc0RrUZ0S
	 uIVXjLUMe21BXAaai62kRQ/O86rWjo0g2aIcop+1UhqtSftk/F9092vqOppMfGC2tm
	 KxxHi6XmZYQw9zHr9vkXKm7ac6qAC3uas1Xj/5X2kn4kqDKc6gnlOAMk27yIhGbdrW
	 44Gce92sn4DmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711FE3806644;
	Thu, 10 Oct 2024 01:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v7 1/2] bpf: fix unpopulated name_len field in perf_event
 link info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852323026.1529972.9569668322715269904.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 01:20:30 +0000
References: <20241008164312.46269-1-wudevelops@gmail.com>
In-Reply-To: <20241008164312.46269-1-wudevelops@gmail.com>
To: Tyrone Wu <wudevelops@gmail.com>
Cc: andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kernel-patches-bot@fb.com, kpsingh@kernel.org, laoar.shao@gmail.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@linux.dev, mykolal@fb.com, olsajiri@gmail.com, sdf@fomichev.me,
 shuah@kernel.org, song@kernel.org, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  8 Oct 2024 16:43:11 +0000 you wrote:
> Previously when retrieving `bpf_link_info.perf_event` for
> kprobe/uprobe/tracepoint, the `name_len` field was not populated by the
> kernel, leaving it to reflect the value initially set by the user. This
> behavior was inconsistent with how other input/output string buffer
> fields function (e.g. `raw_tracepoint.tp_name_len`).
> 
> This patch fills `name_len` with the actual size of the string name.
> 
> [...]

Here is the summary with links:
  - [bpf,v7,1/2] bpf: fix unpopulated name_len field in perf_event link info
    https://git.kernel.org/bpf/bpf/c/4deecdd29cf2
  - [bpf,v7,2/2] selftests/bpf: fix perf_event link info name_len assertion
    https://git.kernel.org/bpf/bpf/c/4538a38f654a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



