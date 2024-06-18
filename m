Return-Path: <linux-kselftest+bounces-12172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAEF90DD87
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 22:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9981DB223C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DB71741E8;
	Tue, 18 Jun 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSpS3+ZV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C511741D4;
	Tue, 18 Jun 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743229; cv=none; b=P8CRSVOPjGnjsHpcnBF5fDAuI1fw7ZzZZ1M7Xcpt6NI7HKgdx5PSHlO0hwezM6oAExrUlJVbvynQgPbDhh0N++uYLkGkTUHmHSKBlRaGtmSrl2/V4n2Um3fAjRXdmtQUbLK4vKX7gT03lC8CJs+jzQHlefiWgmXKQq5yh+5nJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743229; c=relaxed/simple;
	bh=TFQS08Rf0J31730kOyc5E8otLYfflV9G6A7JRrDKQ1Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mF1vXzp+gvpdeRRaIeIuGgsJm8fPlZdiNcgKlDuB2tq2bbwJQYOinj/6SyHkfE52luTotsiiACP8Av6LmNKoyXNy7+3u2RVKE7UH/EFowl+7il+8oXu6a3AAh32Q0u89kpIs+1u8I+nIZuSi87coDOKbRduZt2k+Z5y9V1TTbnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSpS3+ZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 102CFC4AF49;
	Tue, 18 Jun 2024 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718743229;
	bh=TFQS08Rf0J31730kOyc5E8otLYfflV9G6A7JRrDKQ1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GSpS3+ZV1nt98yT1Cl/Xu9Jj/hP/7h/I8+ieMaMQrV4mjI9HSm/Nn/2NFSzTDNQ9H
	 ufrHgkYLlBjZqsnW4PeNAjzscy7Hs2WVPdX4WdiGMpNCnjUVbO/xclh324591x7sT4
	 mJpzjaSMsoc8T+WgH763fhHWrHeQOkuR9txTUs3g+TVe4oWbcKSIoiMleiJBTPSGA+
	 ZYt0o8sQzku48nyjtRb26zCHjjTWnVQqpaFjZqvdb3O+tEpzw6ni+X8v3NZu3lTx+r
	 VwYAcPbBa1v4UugcJrXRd85+dnmEMTP2wPRyYitryVV0zqwb4EBnlVg1E7fygPMwZC
	 Z90NTtS+1ugTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECCD9C4361C;
	Tue, 18 Jun 2024 20:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: openvswitch: Use bash as interpreter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171874322896.29933.7972622263031294700.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 20:40:28 +0000
References: <20240617-ovs-selftest-bash-v1-1-7ae6ccd3617b@kernel.org>
In-Reply-To: <20240617-ovs-selftest-bash-v1-1-7ae6ccd3617b@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, aconole@redhat.com, amorenoz@redhat.com, pshelar@ovn.org,
 shuah@kernel.org, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jun 2024 09:28:33 +0100 you wrote:
> openvswitch.sh makes use of substitutions of the form ${ns:0:1}, to
> obtain the first character of $ns. Empirically, this is works with bash
> but not dash. When run with dash these evaluate to an empty string and
> printing an error to stdout.
> 
>  # dash -c 'ns=client; echo "${ns:0:1}"' 2>error
>  # cat error
>  dash: 1: Bad substitution
>  # bash -c 'ns=client; echo "${ns:0:1}"' 2>error
>  c
>  # cat error
> 
> [...]

Here is the summary with links:
  - [net] selftests: openvswitch: Use bash as interpreter
    https://git.kernel.org/netdev/net/c/e2b447c9a1bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



