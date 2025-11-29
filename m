Return-Path: <linux-kselftest+bounces-46732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2528FC94616
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 18:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B55B3A65CD
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2577330FC31;
	Sat, 29 Nov 2025 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf4/Nr0K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE46522759C;
	Sat, 29 Nov 2025 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764438811; cv=none; b=KY4DojI+Kel6i9Kd8CueMvZ5mRgfMRa+TxjZ/cwQB2xM7l2VPdXq7l14IKuu7kYWXExCkx3ao7Tr5ANtLvH5yDytdJaaO41Om4RNRec4QuY/wvPGfTaq6lHKmqrD4HwY7u0Ted4BSo8wzrKo2d3OIBAy/+hQLYgr256EGKIJo+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764438811; c=relaxed/simple;
	bh=bpLupyHmgmLkGi1PnXaMm1ivkPbmOrefUjyqsIM3txA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZsMobrevhvGle/NPvbpXKC7LxUmccIeOrx0pYmp1kYGpaJ9v6+QeCpU+fRrdS4zfy9EPwWZcRM6q7TewOOYH+ZZEltvj1wWN78kA4duHjj9RHSPsBFJ97ft/VSYp5dNLIDrNI3RwWTvDesq51ux+6deN5+KUh4xtYudDINSXVRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf4/Nr0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAEBC4CEF7;
	Sat, 29 Nov 2025 17:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764438810;
	bh=bpLupyHmgmLkGi1PnXaMm1ivkPbmOrefUjyqsIM3txA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mf4/Nr0K81SSttsGPLvxMEEbvIVp/mMktNj9uOtb4enFE9jtApzGHlNVYkkEuLZjj
	 fAU2wbCpWarijN5fAHh794PnoBUD5pVnDqxOo3TWfEkNyNIGIGxE9Htc72N9WB0i9J
	 GSXuf5tL4aovO9VRAAi6scUR3v5C/UGFedk7NySlUoJE5bCqMZ7iw2A3XrYHLZCazP
	 dBbPwHtlsnIlOkqsG9RgRo838dBGH/BT2sslJabACAcn0AJU+1yF7sZFhl3pQgXHrA
	 7yuIraOjlW54BzlD4btHyBZCG/sbr/trPVtPmev9yX9rflXcrI9cmWwyLn4HpSwY/A
	 Nn3KySgu4DKcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F28763806934;
	Sat, 29 Nov 2025 17:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] selftests/bpf: convert test_tc_edt.sh
 into
 test_progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176443863152.1061209.3711056116732805531.git-patchwork-notify@kernel.org>
Date: Sat, 29 Nov 2025 17:50:31 +0000
References: <20251128-tc_edt-v2-0-26db48373e73@bootlin.com>
In-Reply-To: <20251128-tc_edt-v2-0-26db48373e73@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ebpf@linuxfoundation.org, bastien.curutchet@bootlin.com,
 thomas.petazzoni@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 28 Nov 2025 23:27:17 +0100 you wrote:
> Hello,
> this is a (late) v2 to my first attempt to convert the test_tc_edt
> script to test_progs. This new version is way simpler, thanks to
> Martin's suggestion about properly using the existing network_helpers
> rather than reinventing the wheel. It also fixes a small bug in the
> measured effective rate.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] selftests/bpf: rename test_tc_edt.bpf.c section to expose program type
    https://git.kernel.org/bpf/bpf-next/c/4b4833acc63e
  - [bpf-next,v2,2/4] selftests/bpf: integrate test_tc_edt into test_progs
    https://git.kernel.org/bpf/bpf-next/c/b0f82e7ab6fb
  - [bpf-next,v2,3/4] selftests/bpf: remove test_tc_edt.sh
    https://git.kernel.org/bpf/bpf-next/c/50ce5ea5f792
  - [bpf-next,v2,4/4] selftests/bpf: do not hardcode target rate in test_tc_edt BPF program
    https://git.kernel.org/bpf/bpf-next/c/1d17bcce6a0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



