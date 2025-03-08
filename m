Return-Path: <linux-kselftest+bounces-28538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA4CA5797A
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 10:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6F63B43EE
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FEB1ACED5;
	Sat,  8 Mar 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OybY/GP4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DFF18DB2F;
	Sat,  8 Mar 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426201; cv=none; b=cup74glJ6Pj5lCAB96w3DmVk8ztHpRZW7RLVmjTypFOKkvfm0stBQqA8hn9Ux7SoTWmrK0zKotlSuW+BkiCfOJpNzcnHp/8sLJM9PPQkII6Vo96WVjawOJLAWB5jpazgstA4Ua3yJcfYK4+kdAOOmP/8ZcVbFUV0+Bfx/RBuZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426201; c=relaxed/simple;
	bh=aSArHCwE1EiQPS+wEqfrybjts6oYNwDBrpiT+kUqSEk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OVqNq+hP4bZukvxiRv/0XE/tcGhbs67UFxrr9Z7YQFmKz7obCT7Mpe5JcNqjxbavCWN3ojBHLXNsTX7b6z2ArjMvDiOd8tfRmTkF8eO+4S2iDhY0cmkUh45+haqJ8WOHi0XO02wIhNKDVB8QHA7OpXYv63+AOKKNkPXW+dPJE5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OybY/GP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CADC4CEE0;
	Sat,  8 Mar 2025 09:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741426200;
	bh=aSArHCwE1EiQPS+wEqfrybjts6oYNwDBrpiT+kUqSEk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OybY/GP49DZg/eJb4KiRWgDaRBhCk+5fNgWRJ/ZQnPxkX9Guw5qrRrrkSiOGHNs0/
	 nlhr2fheL4azt9JA/MAPxkgsqSmlHBllo4Rfs2qrPDz+t0AMq223+GpMNopL1Efzbi
	 6kjlAm+sqwkeuC7ltZn5Y69WTXHybfs0qIWAReRP5l1aq3TTUfcgjtKlX9bl+sN6AM
	 8YIbfm81jsRkaLPL0rHXoROgxrY8h0rvIPVezLcZzwhrIKYIDIw54Ul8MjOw6UVmX4
	 Njqer/rDshar968VJc4Sq0Tu0lShkVrq47243cEWhy7+SmEKti9Qhxwe4cgFAopF3b
	 0xXZ0LFjqflew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71448380CFFB;
	Sat,  8 Mar 2025 09:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] selftests/bpf: Move test_lwt_seg6local to
 test_progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174142623426.2626975.17450118701682399019.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 09:30:34 +0000
References: <20250307-seg6local-v1-0-990fff8f180d@bootlin.com>
In-Reply-To: <20250307-seg6local-v1-0-990fff8f180d@bootlin.com>
To: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, alexis.lothore@bootlin.com, thomas.petazzoni@bootlin.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 07 Mar 2025 10:18:22 +0100 you wrote:
> Hi all,
> 
> This patch series continues the work to migrate the script tests into
> prog_tests.
> 
> test_lwt_seg6local.sh tests some bpf_lwt_* helpers. It contains only one
> test that uses a network topology quite different than the ones that
> can be found in others prog_tests/lwt_*.c files so I add a new
> prog_tests/lwt_seg6local.c file.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: lwt_seg6local: Remove unused routes
    https://git.kernel.org/bpf/bpf-next/c/359d07044dd5
  - [bpf-next,2/2] selftests/bpf: lwt_seg6local: Move test to test_progs
    https://git.kernel.org/bpf/bpf-next/c/3fb97a2b2f2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



