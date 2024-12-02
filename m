Return-Path: <linux-kselftest+bounces-22710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFC89E0D3D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 21:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A9EB2D157
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 19:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F21D1DE3B0;
	Mon,  2 Dec 2024 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5wi7z1c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B941D958E;
	Mon,  2 Dec 2024 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166618; cv=none; b=NPxPTaE3A4T0pu3yzmKuwv6oEbb1HqkrlRRbnHCp78xMdsmiSO5EkircmWciuSGoDbSS17VKjsgFtfw52HyA2IaHZFVfTbESrN3h1x5lIBtF0Cn4tDmIjRN3gIIrtARmtk1I5oC6kFApQvHBTkJO5U+R2WaTX5AjH2xUjvusz2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166618; c=relaxed/simple;
	bh=ZGFbZdJpcVF+ykcNUVYpHlJJtgl0OTf6D8u4VfjhV+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oFHv6J6uEvTZEwHAYy5IMy+dIZrtFk25Vj1CmHeBMtQ08sTRuaVicrMQpWgF6bK/abuhCRlBqItoXEB+bo5SAVXmuTQqeBrgOE+tvEerAsMiE4u6P23nUlE8tqVybdhi/RL1GZ5l1aAQ9/6bio6i566FliKpc4t5zYnBabD4wks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5wi7z1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9E7C4CED1;
	Mon,  2 Dec 2024 19:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166616;
	bh=ZGFbZdJpcVF+ykcNUVYpHlJJtgl0OTf6D8u4VfjhV+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S5wi7z1cUlWqpVzDovQdvc23q5Htz0j8lO3kRHauo+EMQ0etGHW+vzXUvSdLOBWfM
	 Gdfbx7a0FSwnCPRUoVk5A471OKc4hrwa9x4ji0f62MZnuWBP1TX/Ri3FQ1y1bVPtAz
	 0RQbHhnE5ftTrcf59Ng41zu4XCnydpi+BkS4qlfl/SAF9VkAznQtUKfLz1xgG8IDXq
	 cnWewh33/okkZMEXlejNyjlhIeZkzj11xZmH4Ia0HPHEb+qlHMeKZHYvPhOSFtLWsw
	 gBPSV3dcNkDEBqYHKtsHPRR0KfdkDsVwVH+p8JS9D3bF+YuL99eVUusOMsX61qC9z0
	 K6nRydIbmkVOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBA113806656;
	Mon,  2 Dec 2024 19:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: ensure proper root namespace
 cleanup when test fail
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173316663076.3863605.13296851451395910783.git-patchwork-notify@kernel.org>
Date: Mon, 02 Dec 2024 19:10:30 +0000
References: <20241128-small_flow_test_fix-v1-1-c12d45c98c59@bootlin.com>
In-Reply-To: <20241128-small_flow_test_fix-v1-1-c12d45c98c59@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@codeaurora.org
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ebpf@linuxfoundation.org, thomas.petazzoni@bootlin.com,
 bastien.curutchet@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 28 Nov 2024 15:38:43 +0100 you wrote:
> serial_test_flow_dissector_namespace manipulates both the root net
> namespace and a dedicated non-root net namespace. If for some reason a
> program attach on root namespace succeeds while it was expected to
> fail, the unexpected program will remain attached to the root namespace,
> possibly affecting other runs or even other tests in the same run.
> 
> Fix undesired test failure side effect by explicitly detaching programs
> on failing tests expecting attach to fail. As a side effect of this
> change, do not test errno value if the tested operation do not fail.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: ensure proper root namespace cleanup when test fail
    https://git.kernel.org/bpf/bpf-next/c/c721d8f8b196

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



