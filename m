Return-Path: <linux-kselftest+bounces-47363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAB1CB2894
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 10:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8A243005097
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E06230FF28;
	Wed, 10 Dec 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Prkew8MV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF26B3B8D6A;
	Wed, 10 Dec 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358600; cv=none; b=WXRdyqBG2VrI+fbc5dZb2VzPUG58Yd0wdZ4Seu4XVoBuq3HJmJWILa5anUfw26kv6lAiNZ6ab9A0i7ekN6iZngP60lYB0zC5+a65MZhACMttmrjRWB2yc1j9Cm5fz5HgrcMbN5VIDd7hFn188ZwCZPHCXcUUAA16ggJO5GfXaqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358600; c=relaxed/simple;
	bh=nSXaGQyn3GMiTlmiGFa5o8nysAMOlxs79eW/FrWmqmM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kh3oft76ELpKtcdPgsFGKWBLisBz9An1uqGJp1Frzq5X3DoQJlyUbnK4pOkEp3mufSmwLDOJzUGz+AnhV6LMEKAdgnrY/eKFeLsZxfCxNZoPdmopV3Iv9pSuIDGs2meqUUByytV7MjhHkJLYLNOKN4XcL+PCQAW/0QcpecGkoKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Prkew8MV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C35C4CEF1;
	Wed, 10 Dec 2025 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765358599;
	bh=nSXaGQyn3GMiTlmiGFa5o8nysAMOlxs79eW/FrWmqmM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Prkew8MVLr/c1LOshHUngb+MypHlPwgJF177RA90OoJtDT5kXxHHcT1T4R4zO3rLw
	 Y53TNXyDsePF8oFFd69TIW0bEWJg27HIW8cOo8dH+OC66Ah5x/qvYMRRadz+rBYMQn
	 y8JCmNc6GBVG7D8tuZ9S/ok2p7OIqPgbIeMscsXWlQbkB5HbhlXOi4E9VJY+wHZ18t
	 LRo3941B6cokIvUdoxxFkeD8ZQg/8GJJ6Ebhp69XaMxP53lskcQmDAheB8a+H/+PAq
	 r5F7k+iD7w9+uVL99sUfY9zaMLG8KeDIYolAg4tX7vezDXCy8M7F2MXVfwilVcVOE9
	 tru6CU5ko3zXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BCCE3809A18;
	Wed, 10 Dec 2025 09:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/13] selftests: Fix build warnings and errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176535841403.523551.9003145966659603890.git-patchwork-notify@kernel.org>
Date: Wed, 10 Dec 2025 09:20:14 +0000
References: <20251205171010.515236-1-linux@roeck-us.net>
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: shuah@kernel.org, kuba@kernel.org, brauner@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, edumazet@google.com, kees@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Dec 2025 09:09:54 -0800 you wrote:
> This series fixes build warnings and errors observed when trying to build
> selftests.
> 
> v2: Emphasize that the patch series fixes build warnings and errors
>     which are seen even if -Werror is not provided.
>     Fix usage of cc-option.
>     For "ignoring return value" warnings, use perror() to display an error
>     message if the affected function returns an error.
> 
> [...]

Here is the summary with links:
  - [v2,01/13] clone3: clone3_cap_checkpoint_restore: Fix build warnings
    (no matching commit)
  - [v2,02/13] selftests: ntsync: Fix build warnings
    (no matching commit)
  - [v2,03/13] selftests/filesystems: fclog: Fix build warnings and errors
    (no matching commit)
  - [v2,04/13] selftests/filesystems: file_stressor: Fix build warning
    (no matching commit)
  - [v2,05/13] selftests/filesystems: anon_inode_test: Fix build warning
    (no matching commit)
  - [v2,06/13] selftest: af_unix: Support compilers without flex-array-member-not-at-end support
    https://git.kernel.org/netdev/net/c/06f7cae92fe3
  - [v2,07/13] selftest/futex: Comment out test_futex_mpol
    (no matching commit)
  - [v2,08/13] selftests: net: netlink-dumps: Avoid uninitialized variable warning
    (no matching commit)
  - [v2,09/13] selftests/seccomp: Fix build warning
    (no matching commit)
  - [v2,10/13] selftests: net: Fix build warnings
    https://git.kernel.org/netdev/net/c/59546e874403
  - [v2,11/13] selftests/fs/mount-notify: Fix build warning
    (no matching commit)
  - [v2,12/13] selftests/fs/mount-notify-ns: Fix build warning
    (no matching commit)
  - [v2,13/13] selftests: net: tfo: Fix build warning
    https://git.kernel.org/netdev/net/c/91dc09a609d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



