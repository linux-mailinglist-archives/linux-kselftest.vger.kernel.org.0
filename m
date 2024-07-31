Return-Path: <linux-kselftest+bounces-14571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B6B9435B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 20:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA96285182
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 18:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2641147F69;
	Wed, 31 Jul 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0AnlpOR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5C39AD6;
	Wed, 31 Jul 2024 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451234; cv=none; b=OA/FV5+KW+MV/+US5+fDXKjnnwmQzys+AgXR4JaMeCUOHXqaK0UiW028IYGYnWNTJklkeHOyFkqzwbf5v/Wbud5/grm1uVkaEhGM2YgvnPzEn3LSVij7xDAZAEb2MZeMpHLCGZiblw23pqwQ4pUi+TIhg5I2bisB4iqlPTWXJBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451234; c=relaxed/simple;
	bh=YMbgkzE9Uguj0W8kWLYpWhp0aUXlNKCM/aTCLMSKp5E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eY1vwoRBZiPW/BB8wbd6jxP+z55VJBinz3CqZK7hQIBs2zMZtP/XG9gaxisMIzAAet0WilO+D8Zm2BbCP7zBQ6BMzcrJN4Dlgygsf0KONftPNNJKA8pyerKusxGxMBja2M095rjAa1o5tJtiHHlBDl4yfmM0XzvmP9talpRpr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0AnlpOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F2C4C4AF0B;
	Wed, 31 Jul 2024 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722451233;
	bh=YMbgkzE9Uguj0W8kWLYpWhp0aUXlNKCM/aTCLMSKp5E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e0AnlpORGAaOoFcAD5q7JZBJin2cRJZUhRMFtcR7tHXi9Uk2tKazvMoHS1lXwcC4i
	 /mLCV+fAA/Me6hUQf92YeUd/+GNiAejlUzTwJqMhdxLpK2JRcWpSg3XDYUxgnWsMqW
	 LanKyiT9IFGfnljkHOMrSZ8ryVpPIKQQvEmghc2KFNCq4O8hPXXH04urHqnuXjEEr/
	 Aks1dLN62GvdfM7x6+FVszkqnm6/VIKLt+wSBMWNJfbKiK48BhWmJaueTETefv9h6n
	 vVSunGAGLgldb2dLdIyxKbw+PKFna+zR3WVDo1uVDGg8Ziphmy8+76MkPzyBdBO1Il
	 GEcIR3/hEvKCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31366C4332F;
	Wed, 31 Jul 2024 18:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] selftests/bpf: convert test_dev_cgroup to
 test_progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172245123319.23492.11789565242662835897.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jul 2024 18:40:33 +0000
References: <20240731-convert_dev_cgroup-v4-0-849425d90de6@bootlin.com>
In-Reply-To: <20240731-convert_dev_cgroup-v4-0-849425d90de6@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, ebpf@linuxfoundation.org, thomas.petazzoni@bootlin.com,
 alan.maguire@oracle.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 31 Jul 2024 08:37:24 +0200 you wrote:
> Hello,
> this small series aims to integrate test_dev_cgroup in test_progs so it
> could be run automatically in CI. The new version brings a few differences
> with the current one:
> - test now uses directly syscalls instead of wrapping commandline tools
>   into system() calls
> - test_progs manipulates /dev/null (eg: redirecting test logs into it), so
>   disabling access to it in the bpf program confuses the tests. To fix this,
>   the first commit modifies the bpf program to allow access to char devices
>   1:3 (/dev/null), and disable access to char devices 1:5 (/dev/zero)
> - once test is converted, add a small subtest to also check for device type
>   interpretation (char or block)
> - paths used in mknod tests are now in /dev instead of /tmp: due to the CI
>   runner organisation and mountpoints manipulations, trying to create nodes
>   in /tmp leads to errors unrelated to the test (ie, mknod calls refused by
>   kernel, not the bpf program). I don't understand exactly the root cause
>   at the deepest point (all I see in CI is an -ENXIO error on mknod when trying to
>   create the node in tmp, and I can not make sense out of it neither
>   replicate it locally), so I would gladly take inputs from anyone more
>   educated than me about this.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] selftests/bpf: do not disable /dev/null device access in cgroup dev test
    https://git.kernel.org/bpf/bpf-next/c/ba6a9018502e
  - [bpf-next,v4,2/3] selftests/bpf: convert test_dev_cgroup to test_progs
    https://git.kernel.org/bpf/bpf-next/c/d83d8230e415
  - [bpf-next,v4,3/3] selftests/bpf: add wrong type test to cgroup dev
    https://git.kernel.org/bpf/bpf-next/c/84cdbff4a935

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



