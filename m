Return-Path: <linux-kselftest+bounces-14189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD53193B9B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 02:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E551B23C72
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 00:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3114A1C;
	Thu, 25 Jul 2024 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbWgHY9V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100976AB9;
	Thu, 25 Jul 2024 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721865639; cv=none; b=XKcTaYIZj9mZHTsNxJYtnLi6179Zc/l2IbtQZTnjNnkc/YTCiMg3gCqVU2CFZUE0w4CKdKdGgl08rBDDeYPJTb+tMlrbro4LcX6LkFHgqQekMBYeIMQO2mU2jIZybwmkT8BGx9QcunHT2tvGLk0v2MVucPUBi0yS8b7F647r3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721865639; c=relaxed/simple;
	bh=kSbuh94a5bX0nbzJoyMesJr2Y5ZvwRKjV5p3eaiu6sA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=haJmw6Zn98pI0gVoPsCpcqSmNEv/AdBDHx9BMHEjh/Rj5XLAIJ0AaZzVqcvelmjrU65fk4yyAggG1uRpWIDQ45kg6iygj7kdJN/s76A8Phw8uv0rLUVV6zLFANKdYyb67WJzfuY60UWrbyzMnDWBVhR9dujcCFoh2/UL0lHFEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbWgHY9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E93DC32782;
	Thu, 25 Jul 2024 00:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721865638;
	bh=kSbuh94a5bX0nbzJoyMesJr2Y5ZvwRKjV5p3eaiu6sA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YbWgHY9Vsx0Pbt82RgjBSGoqfk0IKTA0PPNYFqwtqEeRK4GpdsFAWG1L22peBfqBE
	 fnP04aYg1sqw0UnlPWG7F6fxP5//GvItRomIlUsyTXvL6rpvBkCfcYoU+kbF9iqvir
	 rTNf9WLhliBuMHKM4MmpvjAtJflMQx7CCutiqy3x2YdLSnY3krfCHjbjW37zfvinmb
	 fVut/SAANFmYXReDDP7lunhOEdKjfiGjPRxrJD3uXIHvay1rGut4cLtnl1ARM7PSL2
	 qYAKT5RiFQ1u06dDc0XLNQgC3K325ZOotF/1Q0FlH5W4VxveaB5NmEZ8O5C617la6s
	 8YWB+hN6doqMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78E76C43445;
	Thu, 25 Jul 2024 00:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 00/19] selftests/bpf: Improve libc portability /
 musl support (part 1)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172186563849.27258.13005531127342303614.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 00:00:38 +0000
References: <cover.1721713597.git.tony.ambardar@gmail.com>
In-Reply-To: <cover.1721713597.git.tony.ambardar@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 sunyucong@gmail.com, edumazet@google.com, kuniyu@amazon.co.jp,
 jakub@cloudflare.com, davemarchevsky@fb.com, void@manifault.com,
 cneirabustos@gmail.com, joannelkoong@gmail.com, ppenkov@google.com,
 willemb@google.com, yan@cloudflare.com, vadim.fedorenko@linux.dev,
 zhuyifei@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 22 Jul 2024 22:54:27 -0700 you wrote:
> Hello all,
> 
> This series includes the bulk of libc-related compile fixes accumulated to
> support systems using musl, with smaller numbers to follow. These patches
> are simple and straightforward, and the series has been tested with the
> kernel-patches/bpf CI and locally using mips64el-gcc/musl-libc and QEMU
> with an OpenWrt rootfs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,01/19] selftests/bpf: Use pid_t consistently in test_progs.c
    https://git.kernel.org/bpf/bpf-next/c/afd8169d2724
  - [bpf-next,v1,02/19] selftests/bpf: Fix compile error from rlim_t in sk_storage_map.c
    https://git.kernel.org/bpf/bpf-next/c/bb3b965ee3a0
  - [bpf-next,v1,03/19] selftests/bpf: Fix error compiling bpf_iter_setsockopt.c with musl libc
    https://git.kernel.org/bpf/bpf-next/c/6c3a808171a2
  - [bpf-next,v1,04/19] selftests/bpf: Drop unneeded include in unpriv_helpers.c
    https://git.kernel.org/bpf/bpf-next/c/80fd6c991e95
  - [bpf-next,v1,05/19] selftests/bpf: Drop unneeded include in sk_lookup.c
    (no matching commit)
  - [bpf-next,v1,06/19] selftests/bpf: Drop unneeded include in flow_dissector.c
    (no matching commit)
  - [bpf-next,v1,07/19] selftests/bpf: Fix missing ARRAY_SIZE() definition in bench.c
    https://git.kernel.org/bpf/bpf-next/c/9dc46fdb679b
  - [bpf-next,v1,08/19] selftests/bpf: Fix missing UINT_MAX definitions in benchmarks
    https://git.kernel.org/bpf/bpf-next/c/6898506ee0ae
  - [bpf-next,v1,09/19] selftests/bpf: Fix missing BUILD_BUG_ON() declaration
    https://git.kernel.org/bpf/bpf-next/c/b855ef609329
  - [bpf-next,v1,10/19] selftests/bpf: Fix include of <sys/fcntl.h>
    https://git.kernel.org/bpf/bpf-next/c/f9d6628b2f54
  - [bpf-next,v1,11/19] selftests/bpf: Fix compiling parse_tcp_hdr_opt.c with musl-libc
    https://git.kernel.org/bpf/bpf-next/c/81c60e36c31b
  - [bpf-next,v1,12/19] selftests/bpf: Fix compiling kfree_skb.c with musl-libc
    https://git.kernel.org/bpf/bpf-next/c/787a2e4f1b9e
  - [bpf-next,v1,13/19] selftests/bpf: Fix compiling flow_dissector.c with musl-libc
    https://git.kernel.org/bpf/bpf-next/c/c2e6d8c605ac
  - [bpf-next,v1,14/19] selftests/bpf: Fix compiling tcp_rtt.c with musl-libc
    https://git.kernel.org/bpf/bpf-next/c/2a6a6956f616
  - [bpf-next,v1,15/19] selftests/bpf: Fix compiling core_reloc.c with musl-libc
    https://git.kernel.org/bpf/bpf-next/c/231c5446bfbc
  - [bpf-next,v1,16/19] selftests/bpf: Fix errors compiling lwt_redirect.c with musl libc
    https://git.kernel.org/bpf/bpf-next/c/7ce34ba2b21a
  - [bpf-next,v1,17/19] selftests/bpf: Fix errors compiling decap_sanity.c with musl libc
    https://git.kernel.org/bpf/bpf-next/c/352d541fae2d
  - [bpf-next,v1,18/19] selftests/bpf: Fix errors compiling crypto_sanity.c with musl libc
    https://git.kernel.org/bpf/bpf-next/c/a88580ba22aa
  - [bpf-next,v1,19/19] selftests/bpf: Fix errors compiling cg_storage_multi.h with musl libc
    https://git.kernel.org/bpf/bpf-next/c/56b0ab53657b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



