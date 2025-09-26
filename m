Return-Path: <linux-kselftest+bounces-42511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F6EBA5379
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 23:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17659188BFE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 21:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EE63002CA;
	Fri, 26 Sep 2025 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/e+NpXW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381A528D8D1;
	Fri, 26 Sep 2025 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922213; cv=none; b=CDptWOF3/AHKp5oopicwqQj4aveIQB/NYFJzcyL+6+KmXREWvq61QuXD1bHFDyp5bDlYw/dMw95qwMQ2eCjmlwhRnXulXhyo9Kq8dXMhlsOPBYslOxN6vP8WjBQQprLS6z1XsBkLgL2IN1gIm2d4icSD7c5UR+wr9T86IRTXpjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922213; c=relaxed/simple;
	bh=iPBkIsznMKr6GtXKDcBN0UdYe1bAeiH4sQ8BicTV9/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=czowydIGg7wCaMmFJdrd0M9Qscb1AZxByrsIkUu3HD77Hpdp2hgNZJZhYMxOeu3gYw9x7oQN/b5D684GdMj3yc/Evcp6o/YD7wdCeBEq8+cmKEx4zKUgPJiHoSY+L4CYGXFsSbP7LaXJEflHFxLc4fir5OBCEBxliftwcHGt6jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/e+NpXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D97C4CEF4;
	Fri, 26 Sep 2025 21:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758922212;
	bh=iPBkIsznMKr6GtXKDcBN0UdYe1bAeiH4sQ8BicTV9/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u/e+NpXWqolTyDMsYTuCGpT6LpTw4nsUIibAE1tOIsPJZpwoLVYQsmArkNOJo0+MJ
	 52Ks5I08+L/BseLAFnRNf+RQohbixMoArmqTCbNoKIPZUsgO9nZ+gnOcz1wRV+YKMN
	 ar44KBtL7WoC0OWLR8YrPsmm1jMFkYCcInzeTcdQ5EnFZYPxVoaEESPniliaxFXeAk
	 uGj/hEWm8qlS8H35RfBu85jwatv0OHwI8Zirik3KQyR3uC0KCz79iKe5ubyeX7D+Md
	 KxIs6X/OWRqxOyrSOs4YyjvHBBWRlR16KTM/VyjnshLzo9a6ImadUt8im3hjD1P0NB
	 V+ZjBV2bkRNUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 31E6039D0C3F;
	Fri, 26 Sep 2025 21:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: Enable BTF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892220800.64518.6633677086051129890.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 21:30:08 +0000
References: <20250924222518.1826863-1-sdf@fomichev.me>
In-Reply-To: <20250924222518.1826863-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Sep 2025 15:25:18 -0700 you wrote:
> Commit fec2e55bdef ("selftests: drv-net: Pull data before parsing headers")
> added __ksym external symbol to xdp_native.bpf.c which now requires
> a kernel with BTF. Enable BTF for driver selftests.
> 
> Before:
> 
>   # TAP version 13
>   # 1..10
>   # # Exception| Traceback (most recent call last):
>   # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
>   # # Exception|     case(*args)
>   # # Exception|     ~~~~^^^^^^^
>   # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/drivers/net/./xdp.py", line 231, in test_xdp_native_pass_sb
>   # # Exception|     _test_pass(cfg, bpf_info, 256)
>   # # Exception|     ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^
>   # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/drivers/net/./xdp.py", line 209, in _test_pass
>   # # Exception|     prog_info = _load_xdp_prog(cfg, bpf_info)
>   # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/drivers/net/./xdp.py", line 114, in _load_xdp_prog
>   # # Exception|     cmd(
>   # # Exception|     ~~~^
>   # # Exception|     f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdpdrv obj {abs_path} sec {bpf_info.xdp_sec}",
>   # # Exception|     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   # # Exception|     shell=True
>   # # Exception|     ^^^^^^^^^^
>   # # Exception|     )
>   # # Exception|     ^
>   # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/net/lib/py/utils.py", line 75, in __init__
>   # # Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
>   # # Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   # # Exception|   File "/home/sdf/src/linux/tools/testing/selftests/net/lib/py/utils.py", line 95, in process
>   # # Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
>   # # Exception|                          (self.proc.args, stdout, stderr), self)
>   # # Exception| net.lib.py.utils.CmdExitFailure: Command failed: ip link set dev eni30773np1 mtu 1500 xdpdrv obj /home/sdf/src/linux/tools/testing/selftests/net/lib/xdp_native.bpf.o sec xdp
>   # # Exception| STDOUT: b''
>   # # Exception| STDERR: b"libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?\nlibbpf: failed to find '.BTF' ELF section in /lib/modules/6.17.0-rc6-virtme/build/vmlinux\nlibbpf: failed to find valid kernel BTF\nlib
>   bpf: Error loading vmlinux BTF: -3\nlibbpf: failed to load object '/home/sdf/src/linux/tools/testing/selftests/net/lib/xdp_native.bpf.o'\n"
>   # not ok 1 xdp.test_xdp_native_pass_sb
>   ...
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: Enable BTF
    https://git.kernel.org/netdev/net-next/c/47f78a67d35e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



