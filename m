Return-Path: <linux-kselftest+bounces-40334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFC5B3C2C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 21:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982223ACB18
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F93C23816C;
	Fri, 29 Aug 2025 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smvsPoBu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616962376F2;
	Fri, 29 Aug 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756494004; cv=none; b=adxstZ/BAxmTh/LLXF1OvUdJo/A0IB/IwpZw2pBo3IC9tQA2HnJTkgqTeUFBgFIhZ4iMQEUh44tfCj0iiWIRtcne2gnXR5t6N7Ra5A/+FGA9sQh3ODSJxoYkvUfF0P/O8NgwtFVsj8OpefwJG+yEE1YGBwwaqQYT1IzDe/ZPmWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756494004; c=relaxed/simple;
	bh=i6tDdIDs9ubee1gDISiT3rIyWAiXOFRuZFgHy12Cg8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r0obgUBeTdQ0wywwUkbm4kaRtsjloai3cQVPtUCPL/wRsjgm4rE8hcDEymRdVYTw/6vhaAHDK/DiQumW1+8qayQlnU1XEDotpK+IyFIszgY7CSYaoL8lWXTIEod3vF5kd9RNF+LZtIYwNSBCDb+2l85Ozsikk4zJxpzTMgrq7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smvsPoBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D269EC4CEF0;
	Fri, 29 Aug 2025 19:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756494002;
	bh=i6tDdIDs9ubee1gDISiT3rIyWAiXOFRuZFgHy12Cg8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=smvsPoBuKqZpPV6/HD/HgUZB9RU3v4qJcDRynEZjoWLbpGPDhCLtJzfMPF/+TJ0u4
	 1AlGJwWTcjxeXqBYbaQNSARAU5tIcyqRWHTgXuGmbtY77J8HIvRe2a9EhQq6dTVby4
	 Td1F7yQqj3bdCU0PkuaAsPpj6NcxJ90vHkV3r86zxKBLNMAmlujXZ1I6QT7kQUxoGe
	 Pe03FglpEBDpjmQ0uymr9iEY3tRAJfQ3Rjb4ovGh3Kb2B6lo8R5ozA4bhyKfRr3F75
	 N9T4b8ToVigVNg4PvWC7k830XdYu1UVDS76191ABboCZCcxeQm6NntS88Ia+Nnr1rW
	 BEaJjr82svFwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B0307383BF75;
	Fri, 29 Aug 2025 19:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] Fix bpf_strnstr len error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175649400852.2313311.339778074846590009.git-patchwork-notify@kernel.org>
Date: Fri, 29 Aug 2025 19:00:08 +0000
References: <tencent_E72A37AF03A3B18853066E421B5969976208@qq.com>
In-Reply-To: <tencent_E72A37AF03A3B18853066E421B5969976208@qq.com>
To: Rong Tao <rtoax@foxmail.com>
Cc: vmalik@redhat.com, andrii.nakryiko@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, rongtao@cestc.cn, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 30 Aug 2025 00:30:16 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Fix bpf_strnstr() wrong 'len' parameter, bpf_strnstr("open", "open", 4)
> should return 0 instead of -ENOENT. And fix a more general case when s2
> is a suffix of the first len characters of s1.
> 
> Rong Tao (2):
>   bpf/helpers: bpf_strnstr: Exact match length
>   selftests/bpf: Add tests for bpf_strnstr
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf/helpers: bpf_strnstr: Exact match length
    (no matching commit)
  - [bpf-next,v5,2/2] selftests/bpf: Add tests for bpf_strnstr
    https://git.kernel.org/bpf/bpf/c/19139f45999a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



