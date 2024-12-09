Return-Path: <linux-kselftest+bounces-23096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8359EA191
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 23:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525131888476
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 22:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656CD19DF4C;
	Mon,  9 Dec 2024 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1QbAgK+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398519CD1B;
	Mon,  9 Dec 2024 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733781615; cv=none; b=VF/gUwbEqAnl7sQ8slPANrh7GoP4jYhF1bQcGuiW2la9fDELJH/kXaLb/mXkMuavbAuY8ONl0ZMUJh5vCOE8xMSNNYcONVWtmy+r7bmNFUwOh3huT5pubFDD1wy6nbNQY8000DXj8DLfLDtyNqRxF0ZAnA+5ChjBFbIC9iiScbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733781615; c=relaxed/simple;
	bh=8Dm1hG2kb7+PSjtWpTrC00g1Pi1+QOn/P5etwxi4f7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qz6v2Gwb/m64Wqx1jSgsZxEdzuG0Zma/TidgcWYnoKCUvjxX0nw0qb6kv1nlACBqmqZRb9Prz0KY1zhudlWvFnjjCez7APi5bFAsScSHqgw5kKl/1Vv68Y0YKXV+Mj2CRx1HDcR2iC8ET2V+yiZs8sgmTrW9gkoQVTR2rr22nTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1QbAgK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7EAC4CED1;
	Mon,  9 Dec 2024 22:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733781614;
	bh=8Dm1hG2kb7+PSjtWpTrC00g1Pi1+QOn/P5etwxi4f7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T1QbAgK+ZcQHkHoYtv4yxQErvrd1VbH9vbrla0HsNw3NaV4AbnuzgH+oWyRUycO9I
	 JnZkGjjkMlfjxuOIMdkJOGg3Fh596sbVLBXOWjFavhJ3qNzAJibMvhdK8dqm6Vx66w
	 dAALee7kZP5cPRE3CFENXBZUuvYl8s/sTmxITzrBUUUmLvg1Q7L0rj5kRbxxhu0jzL
	 eof7TESMmGKQSlgdTfCK26dNKnKikewy/yaMxMUo/6SpXLT+HU9Fte8epSzMauZjgM
	 ddsRz8zJdo50wSj3eXXflUONzl/7xgsVrcDlhZcNK84dogByb6r4fbaqmuINJ/br+s
	 XGiUlJ9loAA9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71389380A95E;
	Mon,  9 Dec 2024 22:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix fill_link_info selftest on powerpc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173378163026.254913.9571999335210274445.git-patchwork-notify@kernel.org>
Date: Mon, 09 Dec 2024 22:00:30 +0000
References: <20241209065720.234344-1-skb99@linux.ibm.com>
In-Reply-To: <20241209065720.234344-1-skb99@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, hbathini@linux.ibm.com,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  9 Dec 2024 12:27:20 +0530 you wrote:
> With CONFIG_KPROBES_ON_FTRACE enabled on powerpc, ftrace_location_range
> returns ftrace location for bpf_fentry_test1 at offset of 4 bytes from
> function entry. This is because branch to _mcount function is at offset
> of 4 bytes in function profile sequence.
> 
> To fix this, add entry_offset of 4 bytes while verifying the address for
> kprobe entry address of bpf_fentry_test1 in verify_perf_link_info in
> selftest, when CONFIG_KPROBES_ON_FTRACE is enabled.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Fix fill_link_info selftest on powerpc
    https://git.kernel.org/bpf/bpf-next/c/4d33dc1bc31d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



