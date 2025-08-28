Return-Path: <linux-kselftest+bounces-40202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66EBB3A732
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 19:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBD8563B98
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1160332C31C;
	Thu, 28 Aug 2025 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abx6U8xD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF7326D6E;
	Thu, 28 Aug 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400400; cv=none; b=RmxiyzjH+FiHNcCnfaQVbsIHUUs3s7j1567FnabDKQtqWB5Mq5KfYxa3dTLIg9mwmt3BKnWxZ+CIQCxcU1T7ZJrqqGOKgI571KQT1fnWF9IExRZqIQ+LgsfLDOzaUHlFBfWgSPcaZCJFPrU8tdKgqamosVLgGdRd638naffmm5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400400; c=relaxed/simple;
	bh=XEvwDNjnAT8jj/HiOmr+bo+aUTVwtSilJOz+oEMKONo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NDc5HAmrO8crTOO4ZV0W2hDgba/10SnZxJD81dlINsF4vmu5Y0hTLFQUt43FbZvAQL/W+6HkrBVA9rs8DyhjJ8fhhVE+8xapfk1aOODHipGF05QNFASxDTGJknZVmqqNrYRFUuu2cH07V363Qq3oGc8s5V9o6etdT9z+guQlp9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abx6U8xD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A76C4CEEB;
	Thu, 28 Aug 2025 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756400399;
	bh=XEvwDNjnAT8jj/HiOmr+bo+aUTVwtSilJOz+oEMKONo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=abx6U8xDYVE/NgcoLi4fz0fXKAQ5RggU3o3I/pqrOB92xsBSa9FQvQcmKz4eCSogB
	 N7hbe5/V9608CvoVNMCHLr/AuJ0muX7k8SKZZNq2JlGiDwKKbn9O9QXoLiGUnwbB/m
	 NoqBi+YudG9jPN7s1Bhsfzi2w1PkypApV9EosOPnm2NX5/0jvezc88p5qjP8YxTze6
	 UYR32BddQRm4WEqX5jOBm51cUL8R4RbJcxKzyHBn+LOLLWdB/WbKSzeZYbH4ijC20G
	 3qEvlZ6+7JOL1XKEoIoxVXLizxsMYTgPqu2BgO+AWRKx2IQUW2h/tDAVx7M3V5JWG7
	 26SViAC5rxa8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0E1383BF63;
	Thu, 28 Aug 2025 17:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix bpf_prog_detach2 usage in
 test_lirc_mode2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175640040653.1537046.2241081272775332692.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 17:00:06 +0000
References: <20250828-selftests-bpf-v1-1-c7811cd8b98c@suse.com>
In-Reply-To: <20250828-selftests-bpf-v1-1-c7811cd8b98c@suse.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4=?=@codeaurora.org
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 28 Aug 2025 10:12:33 -0300 you wrote:
> Commit e9fc3ce99b34 ("libbpf: Streamline error reporting for high-level
> APIs") redefined the way that bpf_prog_detach2() returns. Therefore, adapt
> the usage in test_lirc_mode2_user.c.
> 
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
>  tools/testing/selftests/bpf/test_lirc_mode2_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Fix bpf_prog_detach2 usage in test_lirc_mode2
    https://git.kernel.org/bpf/bpf-next/c/98857d111c53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



