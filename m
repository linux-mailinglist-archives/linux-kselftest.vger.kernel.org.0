Return-Path: <linux-kselftest+bounces-17165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9898296C6F9
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F192DB22388
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 19:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBDB12C54B;
	Wed,  4 Sep 2024 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOTp5RlV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635EED528;
	Wed,  4 Sep 2024 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476432; cv=none; b=K/B0jy4bfOLM51IYw7HpZhJi1Os2YjgfXgoPQY5v4sF+DpaUp+f5ppNFqPgXr2Hsms4yM4RYFGFI61VsXY3AL/xwBxSnputMKAkoWgpbeVSs7uuKPaPnFZ7FE8tgV5BiMLNWDpOOB531EKkTkpP1B/JyeR1FwC3pc/gj3yUxSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476432; c=relaxed/simple;
	bh=kTO7DG9z763F5WEliwGpTDF7UfWcYxUplyPxoVZxZWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P2aqbQw4PmO0dcL5GZHIrg0U03UMVNGj2XNL8q9enPuiaEzXIm1tI5WVhxgic1eLMfNPNvEHGuzxDg1KAmnt3e1YddKHSpF08YwuTcmqqNiLtnox0JX8J0391q+zNMETh7X7gMhm0wNF5uBdtazyg62lBwI9Dz7BYOPzLi+m1pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOTp5RlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C12DC4CEC2;
	Wed,  4 Sep 2024 19:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725476432;
	bh=kTO7DG9z763F5WEliwGpTDF7UfWcYxUplyPxoVZxZWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SOTp5RlVHEKlWiYJ6c8WYZZfseMtM7/iw4EOEolC+RLGAxd8azdKRJDKJJ0nZOQvt
	 ULHbWeCkMIanZQmVzMk3BziRGPanJ6L/nlSUd9UtGhMNKUMnNBrm6zsUGMBVUuo3y2
	 TmRGcmKkW0K9LP+50I95wfpcQqdO+ATmzzA+77pXOmbVYRl8j/v+ozOl+8t+t1gOwU
	 G+PL6z1KTCNbFPTtqO3BaDwaYSMLDohKRefx42GAG2VTOAZpCTmDosHrAVCvjYG+AF
	 RE3BpJGsPw50J94A30AzJ+xHlZWFszRh94pC9ckxJihTwlfJ/XVjf9XRu6ABwRCNT9
	 hKtgTP9XHfwxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 347143822D30;
	Wed,  4 Sep 2024 19:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] selftests/bpf: Fix procmap_query()'s params mismatch
 and compilation warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172547643301.1133672.14786879825802356513.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 19:00:33 +0000
References: <20240903012839.3178-1-chenyuan_fl@163.com>
In-Reply-To: <20240903012839.3178-1-chenyuan_fl@163.com>
To: Yuan Chen <chenyuan_fl@163.com>
Cc: andrii@kernel.org, olsajiri@gmail.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Sep 2024 09:28:39 +0800 you wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> When the PROCMAP_QUERY is not defined, a compilation error occurs due to the
> mismatch of the procmap_query()'s params, procmap_query() only be called in
> the file where the function is defined, modify the params so they can match.
> 
> We get a warning when build samples/bpf:
>     trace_helpers.c:252:5: warning: no previous prototype for ‘procmap_query’ [-Wmissing-prototypes]
>       252 | int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, size_t *offset, int *flags)
>           |     ^~~~~~~~~~~~~
> As this function is only used in the file, mark it as 'static'.
> 
> [...]

Here is the summary with links:
  - [v2,1/1] selftests/bpf: Fix procmap_query()'s params mismatch and compilation warning
    https://git.kernel.org/bpf/bpf-next/c/02baa0a2a677

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



