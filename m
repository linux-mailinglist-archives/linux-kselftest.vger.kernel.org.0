Return-Path: <linux-kselftest+bounces-40790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A749B44258
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 18:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA691C83DC7
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 16:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6022FF655;
	Thu,  4 Sep 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZExgXj1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E32FDC27;
	Thu,  4 Sep 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002213; cv=none; b=U167+CqOiIzRppywS33i2E/hty2udQEO0Q3dPewe7SAtTxfLobeVkmOhOrTqnJ93kjlVll2FSYXFNLq+k0jM+j47hGyPicrH0qWoNnm6iH+PMalW+GHt3TtAkIimAkZBPPdoUP7EY7oGFaZ/HaUvDr1rSYRzIqoaUwceYIpSX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002213; c=relaxed/simple;
	bh=s1giyZx/blD4q7nHsz0e0ugtoCgL2LdPT+lWMuBz2pU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XncVE705SVkZICPB8nURtbK3pGJEwqHjamiOfyuSJI3ntTJWaI0NrB26cuUiQz4vQ3aLdU0hM/RXRq7Drvv6wXjeJMJecTfXGAzeQytDvgKAFbevBrO7vJBN1EZteytFv4x6SPOaB6SJII1DOWwOyjE4+102CmQ4Ju4jydNmKYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZExgXj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B81C4CEF6;
	Thu,  4 Sep 2025 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757002213;
	bh=s1giyZx/blD4q7nHsz0e0ugtoCgL2LdPT+lWMuBz2pU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BZExgXj1N8ZDmBnHeXU3wO4wkWg1WEnus6T9ca77T7n4XrsQ7qWy69gcjT5J1ZFIo
	 8Q/BlwJTIBBMRiSsQHTAhswriGOQLPQQhSiBFSDMnfX83drANBSvPzlsZWoHowMc/r
	 kDmJ7HrmnfBG8H1Icp+NmF7izyEkca/V97SgdSzRynOqQtFx1EpbM3eqJJAM04WCTx
	 mV1XSC+IZjvf90Q89GgqvRSrStQjyKYEc90N2eSN+PsaneQUq/zWTdCZDRY5ZTInaE
	 jspjwYb0QouH2kOvj0a8hg1gnAWlMYFy6Kmb+6XfS5IIMqwrXPtKLiVGglMMEZX/MP
	 W8ZAMZcZTsfbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADB7383BF69;
	Thu,  4 Sep 2025 16:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/2] bpf: add bpf_strcasecmp kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175700221751.1866840.15214120196740713686.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 16:10:17 +0000
References: <tencent_292BD3682A628581AA904996D8E59F4ACD06@qq.com>
In-Reply-To: <tencent_292BD3682A628581AA904996D8E59F4ACD06@qq.com>
To: Rong Tao <rtoax@foxmail.com>
Cc: yonghong.song@linux.dev, andrii@kernel.org, ast@kernel.org,
 vmalik@redhat.com, rongtao@cestc.cn, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  3 Sep 2025 07:47:10 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> bpf_strcasecmp() function performs same like bpf_strcmp() except ignoring
> the case of the characters.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: add bpf_strcasecmp kfunc
    https://git.kernel.org/bpf/bpf-next/c/19559e844184
  - [bpf-next,v4,2/2] selftests/bpf: Test kfunc bpf_strcasecmp
    https://git.kernel.org/bpf/bpf-next/c/abc8a952d4aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



