Return-Path: <linux-kselftest+bounces-10593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BA98CC9A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 01:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A8F1F223E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 23:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C2C14C5BD;
	Wed, 22 May 2024 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsLdjpD+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6B14C582;
	Wed, 22 May 2024 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420744; cv=none; b=E4RZuBGAseiTs28B7ialSBcXbd5DZ3qPDdsL2OkjuXiOMJrAGSnReF5PkBQl4sDy7jPmja3pQ9BRBPkyR66bp/tJ1fyLnm1QarqpN2IP8TfTEuURS7dm6EioIzzBURLyVcgRcwLvdf37CCJ7VT4+vqUYzetJejJxp5RfHnSQSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420744; c=relaxed/simple;
	bh=ITZrsOmg5tle9AF+jDyC89IYV8YjFwFBD6zQa+9C89g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GO/Ft4MEaEiKDcmOJRxhV1y2fnmoQ7Nhsn/YKLtGcFMtibPtMupy/HW2PY3sU2l5+l1+bA0T6AsAoq1esjXBblxyLMOofnsY15rrSl/461q3qAQG8aZkqExypZdL58++1KPQ1oEpBwKClz5nUzBfm2vZ8KLOpr5KU+81J5R0XkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsLdjpD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C3BFC3277B;
	Wed, 22 May 2024 23:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716420743;
	bh=ITZrsOmg5tle9AF+jDyC89IYV8YjFwFBD6zQa+9C89g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FsLdjpD+a1E5SGHUUoJ3FG16lJCbNEx2RuOCnWcK4L9Q/H7AaJppG+Qd/mphGNtmw
	 hTaTJdxb/YFJqHhH9ZcTdhuPtWfL0R207u1qOznWG6vcBAK9PkSZ/b8O26aUAXMPNa
	 o4SbXJ3VLEjS56eYPyII4KWmkpW0Scb5Zq06AnpT0qsKzLydzYs6rQLGhCx1ra2dAb
	 95qqo8g4evTfpMbboGjSh7O070UFXYAJbie5jlS16rm2e9eG4kXYmLQeujRfGKd56p
	 uWLpezr/89iiQQYbfkWP1wa/lICMqoLCNb59bAbmIeVbGD1RhLIpqyYdL29nKrHohq
	 M7ssv8wkgfrVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 663CAC43619;
	Wed, 22 May 2024 23:32:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 00/68] Define _GNU_SOURCE for sources using
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171642074340.9409.18366005588959820799.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 23:32:23 +0000
References: <20240522005913.3540131-1-edliaw@google.com>
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
To: Edward Liaw <edliaw@google.com>
Cc: linux-riscv@lists.infradead.org, shuah@kernel.org, mic@digikod.net,
 gnoack@google.com, brauner@kernel.org, richardcochran@gmail.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@android.com,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Tejun Heo <tj@kernel.org>:

On Wed, 22 May 2024 00:56:46 +0000 you wrote:
> Centralizes the definition of _GNU_SOURCE into KHDR_INCLUDES and removes
> redefinitions of _GNU_SOURCE from source code.
> 
> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> asprintf into kselftest_harness.h, which is a GNU extension and needs
> _GNU_SOURCE to either be defined prior to including headers or with the
> -D_GNU_SOURCE flag passed to the compiler.
> 
> [...]

Here is the summary with links:
  - [v5,01/68] selftests: Compile with -D_GNU_SOURCE when including lib.mk
    (no matching commit)
  - [v5,02/68] kselftest: Desecalate reporting of missing _GNU_SOURCE
    (no matching commit)
  - [v5,03/68] selftests/arm64: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,04/68] selftests/arm64: Drop duplicate -D_GNU_SOURCE
    (no matching commit)
  - [v5,05/68] selftests/bpf: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,06/68] selftests/breakpoints: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,07/68] selftests/cachestat: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,08/68] selftests/capabilities: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,09/68] selftests/cgroup: Drop define _GNU_SOURCE
    https://git.kernel.org/riscv/c/c1457d9aad5e
  - [v5,10/68] selftests/clone3: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,11/68] selftests/core: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,12/68] selftests/damon: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,13/68] selftests/drivers: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,14/68] selftests/exec: Drop duplicate -D_GNU_SOURCE
    (no matching commit)
  - [v5,15/68] selftests/fchmodat2: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,16/68] selftests/filelock: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,17/68] selftests/filesystems: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,18/68] selftests/firmware: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,19/68] selftests/fpu: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,20/68] selftests/futex: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,21/68] selftests/futex: Drop duplicate -D_GNU_SOURCE
    (no matching commit)
  - [v5,22/68] selftests/intel_pstate: Drop duplicate -D_GNU_SOURCE
    (no matching commit)
  - [v5,23/68] selftests/iommu: Drop duplicate -D_GNU_SOURCE
    (no matching commit)
  - [v5,24/68] selftests/ipc: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,25/68] selftests/kcmp: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,26/68] selftests/landlock: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,27/68] selftests/lsm: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,28/68] selftests/membarrier: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,29/68] selftests/memfd: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,30/68] selftests/mincore: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,31/68] selftests/mm: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,32/68] selftests/mount: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,33/68] selftests/mount_setattr: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,34/68] selftests/move_mount_set_group: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,35/68] selftests/mqueue: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,36/68] selftests/net: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,37/68] selftests/net: Drop duplicate -D_GNU_SOURCE
    (no matching commit)
  - [v5,38/68] selftests/nsfs: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,39/68] selftests/openat2: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,40/68] selftests/perf_events: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,41/68] selftests/pid_namespace: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,42/68] selftests/pidfd: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,43/68] selftests/ptrace: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,44/68] selftests/powerpc: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,45/68] selftests/proc: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,46/68] selftests/proc: Drop duplicate -D_GNU_SOURCE
    (no matching commit)
  - [v5,47/68] selftests/ptp: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,48/68] selftests/resctrl: Drop duplicate -D_GNU_SOURCE
    (no matching commit)
  - [v5,49/68] selftests/riscv: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,50/68] selftests/riscv: Drop duplicate -D_GNU_SOURCE
    (no matching commit)
  - [v5,51/68] selftests/rlimits: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,52/68] selftests/rseq: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,53/68] selftests/safesetid: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,54/68] selftests/sched: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,55/68] selftests/seccomp: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,56/68] selftests/sigaltstack: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,57/68] selftests/sgx: Compile with -D_GNU_SOURCE
    (no matching commit)
  - [v5,58/68] selftests/splice: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,59/68] selftests/syscall_user_dispatch: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,60/68] selftests/thermal: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,61/68] selftests/timens: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,62/68] selftests/tmpfs: Drop duplicate -D_GNU_SOURCE
    (no matching commit)
  - [v5,63/68] selftests/uevent: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,64/68] selftests/user_events: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,65/68] selftests/vDSO: Append to CFLAGS in Makefile
    (no matching commit)
  - [v5,66/68] selftests/vDSO: Drop define _GNU_SOURCE
    (no matching commit)
  - [v5,67/68] selftests/x86: Append to CFLAGS in Makefile
    (no matching commit)
  - [v5,68/68] selftests/x86: Drop define _GNU_SOURCE
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



