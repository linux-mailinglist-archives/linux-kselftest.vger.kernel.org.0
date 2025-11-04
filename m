Return-Path: <linux-kselftest+bounces-44690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85087C2EE76
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 03:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1CC1892D64
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 02:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421A91A8F97;
	Tue,  4 Nov 2025 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cx5/kz6O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DB534D3BD;
	Tue,  4 Nov 2025 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762221644; cv=none; b=FuH80VKTml3vLpahYJ64UVdNbD253l2R2WlU2BgKSu1BehnT2164RNroiizz730oasGZn/HMAgcWkes0iWT4LuTl/c/yD6/rRfqgwQriOpAqzP+TXYNFZGFow7PunMJQOkiav18b7yW8zPeAKp3JrqPb3FfnfBl/6/cQej62BDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762221644; c=relaxed/simple;
	bh=nEPXZx80eny23FSBcFiXyhd/C4UeVlgnlwkJ8T5FR1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b7PBkTOqS01O7XeGfPPdFPw3Pr3xL5y0qZZUP5P1jKW/uFbBX365I7fBcguyfTLyE2MWaLKJjOC+cc5KThHvKsB4jXFDDW3WwgFiI1X5RWhR4QBFQyEDcf+5JsphU9O9TfQptu9+UNlgHwhc6p+sCM3tMJ9Sti6eX0GCOzINbhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cx5/kz6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A501CC4CEE7;
	Tue,  4 Nov 2025 02:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762221643;
	bh=nEPXZx80eny23FSBcFiXyhd/C4UeVlgnlwkJ8T5FR1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cx5/kz6OAcq9Qoq1EjA37+E7Myq30qoOcRasNJHDbz3JChdKMTguDANSG01Py+XYB
	 CcDuFlVPLsCom+uTLaXmhvnlCDepacBdV/54QG5sB0ZfndqaA3QRMbGb3kPlrboQGA
	 m23w0RBmPlhCW44YGpDKdHzTW2w62hIYJt1iJ8C3dxjKKvwcKANJmFdYkUrEj3wKid
	 RTLU9yAFSeotHiCmOKp9ZzfSQP1ctvuEgez+UVMXCimffyXk8+fanT3KwgtJLs71BO
	 vlwXgqGvXVKqXp6B4KLXg+gCA74TiOP1mZO3+6p82xTqTVUi1u3W2DNRjVTi8bz5AI
	 rAg/LNvKKbfQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7E380A95C;
	Tue,  4 Nov 2025 02:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf: Skip bounds adjustment for
 conditional
 jumps on same scalar register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176222161773.2291263.14482517778610810582.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 02:00:17 +0000
References: <20251103063108.1111764-1-kafai.wan@linux.dev>
In-Reply-To: <20251103063108.1111764-1-kafai.wan@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 paul.chaignon@gmail.com, m.shachnai@gmail.com,
 harishankar.vishwanathan@gmail.com, colin.i.king@gmail.com,
 luis.gerhorst@fau.de, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  3 Nov 2025 14:31:06 +0800 you wrote:
> This small patchset is about avoid verifier bug warning when conditional
>  jumps on same register when the register holds a scalar with range.
> 
> v4:
>   - make code better. (Alexei)
> 
> v3:
>   https://lore.kernel.org/bpf/20251031154107.403054-1-kafai.wan@linux.dev/
>   - Enhance is_scalar_branch_taken() to handle scalar case. (Eduard)
>   - Update the selftest to cover all conditional jump opcodes. (Eduard)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Skip bounds adjustment for conditional jumps on same scalar register
    https://git.kernel.org/bpf/bpf-next/c/d43ad9da8052
  - [bpf-next,v4,2/2] selftests/bpf: Add test for conditional jumps on same scalar register
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



