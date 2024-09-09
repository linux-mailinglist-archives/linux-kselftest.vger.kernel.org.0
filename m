Return-Path: <linux-kselftest+bounces-17553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CE2972582
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 01:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF8028574E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 23:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9EF18E04E;
	Mon,  9 Sep 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVSO/dy3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C8318E03E;
	Mon,  9 Sep 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725922832; cv=none; b=CEJ5j2w7ij+xmBbWOM8HJbXuIo3Lo1bsv8ODp7V7Ox5U465wnbuq8SG/HpCclC//+5FG9iSJ5I7qklo6qg1CldX6XVeWa0/cNXXCQMGTvyWTgZFOiQeAAatkQUcsA2MYlTiJsP3cpsyB+d4Wk2U4ypVpfxxJi+a7A5yMBBBz25Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725922832; c=relaxed/simple;
	bh=FVU+e0uUbeUPEEjSwOVvbkcKHW7sTPraTqYrzbKWPJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GCNlW/TQF+FLD0qEAgvmff8PzfSqKeK3b9kySUjDK+74YDV7IuBVLfyrtCvlY5idFlZ4af/LkDpxH41XWcIKT92yrmTuxLLxs6DIQkCe4a8L2rm3G03E963O4EvYUAarU5f5Gfozeej3oL0afWC4cd00Ch23aoSurtApN8s3s8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVSO/dy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810EEC4CEC5;
	Mon,  9 Sep 2024 23:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725922831;
	bh=FVU+e0uUbeUPEEjSwOVvbkcKHW7sTPraTqYrzbKWPJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CVSO/dy3Z8HTdqeZ6UhpD6jeA21IOUm+ADrcbcUDNwL8SQqarICs1QJTolnMCPSSH
	 /YNSnvwLH15bOYy8ge7MdEbuD1ROCv2VGNcDgDT9/McMIYUKjldRMEQx/di0toq0zC
	 T8jugT7TLBx5dSeZOdIhIGruN89/LTNNhqaPW11CMzcOWUv+T0q7TpEJSxSP5fRC+F
	 jmUZ98BV60SmzLlyH+l+iG9UYcTSfE8HFJJur0E8s69qRaFVNQgkee36+kZlzke1gg
	 mRY1rU7ul3H3G70t9CBhJoXQ2c4BIIjFTTfQWoPdfebF9FMTyisT1EQdcu6iPkoxni
	 zIn3hpf1sDUYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFCC3806654;
	Mon,  9 Sep 2024 23:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix error message on kfunc arg type mismatch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592283251.3949024.7942929079715382663.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 23:00:32 +0000
References: <20240909133909.1315460-1-maxim@isovalent.com>
In-Reply-To: <20240909133909.1315460-1-maxim@isovalent.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 maxim@isovalent.com, alan.maguire@oracle.com, memxor@gmail.com,
 andreimatei1@gmail.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  9 Sep 2024 16:39:09 +0300 you wrote:
> When "arg#%d expected pointer to ctx, but got %s" error is printed, both
> template parts actually point to the type of the argument, therefore, it
> will also say "but got PTR", regardless of what was the actual register
> type.
> 
> Fix the message to print the register type in the second part of the
> template, change the existing test to adapt to the new format, and add a
> new test to test the case when arg is a pointer to context, but reg is a
> scalar.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix error message on kfunc arg type mismatch
    https://git.kernel.org/bpf/bpf-next/c/bee109b7b3e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



