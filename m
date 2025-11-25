Return-Path: <linux-kselftest+bounces-46406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C37C82F94
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 02:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1683ADD3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 01:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C681A3165;
	Tue, 25 Nov 2025 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEyC+TGi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3EE36D4E8;
	Tue, 25 Nov 2025 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764032735; cv=none; b=SNjRi8q6VHCcKrUk3/HCGg0dH6YsBYyIoc605uUEFWh0pYv+fw/aq/Rn/ij4+0MWoecuUnQrn+8oABl1mV0Y4G3MWEQSlfLxL4HzUJx7qpsOOJ57OhQOQrUL9Ao8jrZ/deF1a7jZ3b5hiUoxlokFtcrPaMsTcTRKR+//FvQWQAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764032735; c=relaxed/simple;
	bh=ctvi1lVs4XUeVFCVz9ysJiaAc39mCPiN/uO0zn1fW1U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cR6U0oPHbDs91GGPiT1x2V7by45gSFxV4cJhLTLCnaPE4WOwjILVQvzmd6NPlokC1gnVPTi4yPDPXJVjulijIoRHv4on+YWxAxXLjEnS5py394DfQynJusw8ogrKRCVtQ0yG4DYNXXNoQbF7iyOkZe2+uL8sp6xm+QsHw58eEoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEyC+TGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2AFC4CEF1;
	Tue, 25 Nov 2025 01:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764032735;
	bh=ctvi1lVs4XUeVFCVz9ysJiaAc39mCPiN/uO0zn1fW1U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZEyC+TGiQV6u8mw9Wj+tcJyMwbzPhew34jlmJREmmeBEg3EllNUBXSOy3RI2E2M9S
	 m/V8jL6Bf2n9xau5k1KWMzw8T6cRietU5xCu+2h5UoD3LLr51n2kVxieFFwbnNz4Id
	 ANHG7NvPzBcljY/YO2+7dhkUbJBgNbQUiu8dlJvejGNYapuyn1OlC0GKo3swqypDPD
	 SoLY0OvV4oRSr6L+rblvvhJikH0Z+gwFOM7GfGz2JaU4woPKC6XNbPca9vVbGVxIF/
	 XXtXJ59zrs6r82ML9aw/aQZtm/VS03b+zmIyVppsbj+//OUJMS9/3+av5OiZts2/Vf
	 PSNB+qxpVgDxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF893A8A3C1;
	Tue, 25 Nov 2025 01:04:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Fix htab_update/reenter_update
 selftest failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176403269752.136716.13070302531247591682.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 01:04:57 +0000
References: <20251117060752.129648-1-skb99@linux.ibm.com>
In-Reply-To: <20251117060752.129648-1-skb99@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, hbathini@linux.ibm.com, sachinpb@linux.ibm.com,
 venkat88@linux.ibm.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 17 Nov 2025 11:37:52 +0530 you wrote:
> Since commit 31158ad02ddb ("rqspinlock: Add deadlock detection
> and recovery") the updated path on re-entrancy now reports deadlock
> via -EDEADLK instead of the previous -EBUSY.
> 
> Also, the way reentrancy was exercised (via fentry/lookup_elem_raw)
> has been fragile because lookup_elem_raw may be inlined
> (find_kernel_btf_id() will return -ESRCH).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Fix htab_update/reenter_update selftest failure
    https://git.kernel.org/bpf/bpf-next/c/590699d85823

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



