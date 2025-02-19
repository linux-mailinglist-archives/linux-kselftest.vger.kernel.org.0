Return-Path: <linux-kselftest+bounces-27007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21474A3C6E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 19:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002963B7D88
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80BD21480F;
	Wed, 19 Feb 2025 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiYsOzsu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E316F858;
	Wed, 19 Feb 2025 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988002; cv=none; b=rpdlCWog6FdEzh8Z9BasB8/lFQUDynkgaVnupSkX6WyEC7NN5bTegy5c4rbPfL0h59aSirVW+rJ2AaAHgZFHiPMgu+Hs9to60CZYbALDM1jZ8eb0Nb0+ODqVZMxAmaVO6ZxxVu1PWDqPBsDYJGOUw3Gz/nU0x21iCA18YlEiacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988002; c=relaxed/simple;
	bh=8GH4isiEtxx4zmx1wFTQsbmQVm37L4dBhX2XWViqAXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aHSts+aFNUyBydfD3mrt01qM51z4VF3LougY3wV6CAAzcmdReJ03DNV57cn7XptfmYZgrfgORWbCkzJBLF44heyxc4lLlN+O5YWb+ggCWbbQTNUHx8YQ41JwU/tLGPkXQ1ZJ4BjX0HumhHN44CR+nrdUE3yTRp67x6lJ1jKdRM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiYsOzsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40003C4CED1;
	Wed, 19 Feb 2025 18:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739988002;
	bh=8GH4isiEtxx4zmx1wFTQsbmQVm37L4dBhX2XWViqAXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PiYsOzsuNs20ekgUQWtFKLhp3iI9HdjZqHxXNpUVfi/VPSEiMv8mA6oTQoe9j4OzQ
	 4749m/XzzGYqiNjKk6DRhXTl7nc6X4+yRWllT48Pc06bvnwFUDYrWl9lzys+7DUAD9
	 S2uW6qoDoHwsObEbeCwiIKxDBRlT+HrrmCJka4VZBHqAWXp9tzWMjm/LhRq/nBa47d
	 EZimEsEiFsTBRDhSKH1sCxw92o9+enV2eb7Ufkq17omvSKcwb93mXDQQ1puEjUrm8X
	 GhDoiN55tLd4R1iB9p3UHwbebeRiKwU4pzR+Xp3/chLQuTTTFPVJxYFoTGRIkL1uE1
	 BWsHtKThPWinQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC895380AAE9;
	Wed, 19 Feb 2025 18:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] selftests/bpf: tc_links/tc_opts:
 Unserialize tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173998803276.698021.4187184444862727581.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 18:00:32 +0000
References: <20250219-b4-tc_links-v2-0-14504db136b7@bootlin.com>
In-Reply-To: <20250219-b4-tc_links-v2-0-14504db136b7@bootlin.com>
To: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, alexis.lothore@bootlin.com, thomas.petazzoni@bootlin.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 19 Feb 2025 15:52:59 +0100 you wrote:
> Hi all,
> 
> Both tc_links.c and tc_opts.c do their tests on the loopback interface.
> It prevents from parallelizing their executions.
> 
> Add a new behaviour to the test_progs framework that creates and opens a
> new network namespace to run a test in it. This is done automatically on
> tests whose names start with 'ns_'.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] selftests/bpf: ns_current_pid_tgid: Rename the test function
    https://git.kernel.org/bpf/bpf-next/c/4a06c5251ae3
  - [bpf-next,v2,2/4] selftests/bpf: Optionally open a dedicated namespace to run test in it
    https://git.kernel.org/bpf/bpf-next/c/c047e0e0e435
  - [bpf-next,v2,3/4] selftests/bpf: tc_links/tc_opts: Unserialize tests
    https://git.kernel.org/bpf/bpf-next/c/207cd7578ad1
  - [bpf-next,v2,4/4] selftests/bpf: ns_current_pid_tgid: Use test_progs's ns_ feature
    https://git.kernel.org/bpf/bpf-next/c/157feaaf18ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



