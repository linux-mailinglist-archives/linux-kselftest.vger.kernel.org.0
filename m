Return-Path: <linux-kselftest+bounces-43343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034BEBE4A5C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 18:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46F15E23E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 16:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7A832AAC3;
	Thu, 16 Oct 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rsr8z8gQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17E92E4274;
	Thu, 16 Oct 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632822; cv=none; b=El9scQRcKsF0kW8EYu6gWMpztVGfOkZOcs6gMATe93Dnune05h9NYGDyYAOKBi+711+NN74Mj5vCYMqMErDvvpi6NEC+a7cWU33dZx8bFu0DPB3MxvhFDzoAgo44V2/wFZoStb26q4u3EnEX4YY3Z0zJHgVn3V/OgvrXaau4FUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632822; c=relaxed/simple;
	bh=SpBqnPhly5I5BfGDCluDE0y/fqMod46B7uTkxDnBf4o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MAwd1e0MxVdzKIDZ19+ZBKZD4ac+rMYc0TR3JCjweVkzCwqW07izgJyREDvGbInAUTH7wwD/8EhRsGZeHYsNzvyBdjmbTHx5mHWs/Kdna9oVRxr6SDIlV1YaW28BDuHMiQiKdjxpgpa5M+75gAwnJg/ZCRK1oFsJgoiliBRKYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rsr8z8gQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124B1C4CEF1;
	Thu, 16 Oct 2025 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760632822;
	bh=SpBqnPhly5I5BfGDCluDE0y/fqMod46B7uTkxDnBf4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rsr8z8gQvqKiIzFYNxRp/wHZs/qzrg5Xp6R4pj/l71fgDWhEHvZ0PPL8/Dw6yBPVU
	 jhrPBFCRPdqgBnucz8ezcdsw2BIL9nVI6FaHX/87T7qJpsH5ous17OixjFkXWDFwvf
	 58JLtwKh/CNq7PbMK0E2HYjZIeQXiZop8eDAa6Jrw5mxqdgklMVVHn0fPIdCk+Y/+J
	 E+aZyiBiG7lcWN79/yX7MO1xixDDWYm6PzmJVKzrIFKx5mhRvJE3e7YIT2ZdyysUDu
	 oBNR0kf30xWSUhuvMPqyEPKEvBUGQ2cqzw9d7dJwC/QkWyh+m2u6iIl9Ibt3bjrRAx
	 k1q8wGvqjGwLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71442383BF5B;
	Thu, 16 Oct 2025 16:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v6] selftests: arg_parsing: Ensure data is flushed to
 disk
 before reading.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176063280609.1812042.13178072528554083965.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 16:40:06 +0000
References: <20251016035330.3217145-1-higuoxing@gmail.com>
In-Reply-To: <20251016035330.3217145-1-higuoxing@gmail.com>
To: Xing Guo <higuoxing@gmail.com>
Cc: andrii.nakryiko@gmail.com, alexei.starovoitov@gmail.com,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, olsajiri@gmail.com, sveiss@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 16 Oct 2025 11:53:30 +0800 you wrote:
> test_parse_test_list_file writes some data to
> /tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
> the data back.  However, after writing data to that file, we forget to
> call fsync() and it's causing testing failure in my laptop.  This patch
> helps fix it by adding the missing fsync() call.
> 
> Fixes: 64276f01dce8 ("selftests/bpf: Test_progs can read test lists from file")
> Signed-off-by: Xing Guo <higuoxing@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf,v6] selftests: arg_parsing: Ensure data is flushed to disk before reading.
    https://git.kernel.org/bpf/bpf/c/0c1999ed3372

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



