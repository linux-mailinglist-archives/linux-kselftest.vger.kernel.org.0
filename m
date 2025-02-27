Return-Path: <linux-kselftest+bounces-27794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3C6A487F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 19:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF1577A61FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45221E833D;
	Thu, 27 Feb 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjQl7a++"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98754270023;
	Thu, 27 Feb 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681598; cv=none; b=OcyPDdXH8moBfZg9YT8HEbDntoOlPW4H9HOa13s4u7/SJ6K9/ChYhXNd07/BJe7QYNTyuOrnt1TskkayzWg+UdTdrBxjqhMUPhWPofUIuvFfnYdowg9pLWQ42+bjr7WjLe75bXVtan/jr77wRdBky0J8qQkSJA1V3RFy2PaafJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681598; c=relaxed/simple;
	bh=9JxcV8DByVOuCAju7rp3CM7HpTlI82fPLJS8ZDOW6Lc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kWFaX6LwcuEDLQq3+m2Kd1KkJkA5uzfNJn9xk7K+NCgNfRixEnMYsrYHULtzvtx+A9zPKkj7y9IcRkg8SzfRQhliBIaUvYkKQiI1afSC9+1yW2kfFTXYWk064g6QEFMGjElvDhqtxyP81jSvSOf2dV20gQk7E0Uy83U4eOun2co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjQl7a++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71228C4CEDD;
	Thu, 27 Feb 2025 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740681598;
	bh=9JxcV8DByVOuCAju7rp3CM7HpTlI82fPLJS8ZDOW6Lc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JjQl7a++dv2I37RvOmSjAhWtu6N8GV7/0sT/CeqeFk+dp7RxN28b2SQkWkwBWBXLA
	 UCckl3kgoptzxpzjv1O25zQbeRWh0nK73bkcGqtMXM/ZIWLrzRx4woGAxd3DqEczCF
	 pgwNgrFyrNap6wcqm2B8z2qU0yKspyFAEuXPyaCsh0haiyatSBDTF+YyI6H3FhszTs
	 oKqbr5cgIfrXx6Qwp6j++QMGjAtGF/le+IQEGBVkSnmGF2A2GKnyxuj2YSqhdXSBg+
	 W5DDbRDz5al2wvN5tQY/tSlbHbVsqeN5Og/lqzPQI5fDTKQESeQQvkpWq7MFWJ0zQx
	 bKnSKLX9pTSDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE81A380AACB;
	Thu, 27 Feb 2025 18:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf/selftests: test_select_reuseport_kern: remove unused
 header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174068163051.1525690.12908480621215552864.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 18:40:30 +0000
References: <20250227-remove_wrong_header-v1-1-bc94eb4e2f73@bootlin.com>
In-Reply-To: <20250227-remove_wrong_header-v1-1-bc94eb4e2f73@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, ebpf@linuxfoundation.org, thomas.petazzoni@bootlin.com,
 bastien.curutchet@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 27 Feb 2025 15:08:23 +0100 you wrote:
> test_select_reuseport_kern.c is currently including <stdlib.h>, but it
> does not use any definition from there.
> 
> Remove stdlib.h inclusion from test_select_reuseport_kern.c
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> 
> [...]

Here is the summary with links:
  - bpf/selftests: test_select_reuseport_kern: remove unused header
    https://git.kernel.org/bpf/bpf-next/c/0b9363131daf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



