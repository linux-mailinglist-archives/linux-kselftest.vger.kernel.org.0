Return-Path: <linux-kselftest+bounces-391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C127F36C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 20:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF841C20CB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 19:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1995C5B1ED;
	Tue, 21 Nov 2023 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tp3D93Lo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E405A118;
	Tue, 21 Nov 2023 19:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6769AC433C7;
	Tue, 21 Nov 2023 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700594424;
	bh=EBK1q+oe+c4i9o37VMayPNOAfNEEFOG6EZD0cEsQE6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tp3D93Lofo2iLhrKTpzTvy2Y8ywhNK52/c6y9RRmvNYZCMC9Y3JoFYGjIkwisKgPq
	 KN/M2WIFrZZAsN17x8ZALH6HO0f04RP4XKt7CA8RUMSJ41fPJbGQVxAGioUqdAHtGO
	 ZpAnt5ungxlKyIihIaC4W0YU5JJjHg5cemDgF6xEsnECnlU9jkhL31WSuHjJA11Aj/
	 wB1LTkj6dcSCS9C4MfZV4vfs1OXLWnWjJ08U7CJ6NWx2WhTNvkg/2x3cidHqwp3How
	 Wkz73CpK3rAAllzssxyU1vank8G3+FxeaWmkh/giH8nmeyfu141LjfcyZO9f5B8ZkP
	 dP4RiH2HSKpig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 505ECEAA955;
	Tue, 21 Nov 2023 19:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] selftests/bpf: Update multiple prog_tests to
 use ASSERT_ macros
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170059442432.1779.10625462603877960408.git-patchwork-notify@kernel.org>
Date: Tue, 21 Nov 2023 19:20:24 +0000
References: <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
To: Yuran Pereira <yuran.pereira@hotmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com,
 sdf@google.com, shuah@kernel.org, song@kernel.org, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 21 Nov 2023 05:33:14 +0530 you wrote:
> Multiple files/programs in `tools/testing/selftests/bpf/prog_tests/` still
> heavily use the `CHECK` macro, even when better `ASSERT_` alternatives are
> available.
> 
> As it was already pointed out by Yonghong Song [1] in the bpf selftests the use
> of the ASSERT_* series of macros is preferred over the CHECK macro.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bpf_tcp_ca
    https://git.kernel.org/bpf/bpf-next/c/b0e2a0395312
  - [bpf-next,v3,2/4] selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bind_perm
    https://git.kernel.org/bpf/bpf-next/c/3ec1114a9745
  - [bpf-next,v3,3/4] selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bpf_obj_id
    https://git.kernel.org/bpf/bpf-next/c/f125d09b99fc
  - [bpf-next,v3,4/4] selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in vmlinux
    https://git.kernel.org/bpf/bpf-next/c/3ece0e85f679

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



