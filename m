Return-Path: <linux-kselftest+bounces-9559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2408BD695
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 23:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8013A282D42
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 21:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2A15B961;
	Mon,  6 May 2024 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHiq341e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32646EBB;
	Mon,  6 May 2024 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715029229; cv=none; b=Aa8xW6L2b7uL37DXbEIAYFOUlhRcrvPUWFvIQi+vTok78AN3Z+bIe/+DVCAeX0vrKFrkcGcARmW6buAfH+mAIyTWjqu96CCcrtK/zbxH7t0cLiw3tNT+FFlcML29K9n1AWQrQVqSdehughFPTmU57Q6cZeVOefuj+kGiCYsLb0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715029229; c=relaxed/simple;
	bh=euep0cZkBW8JkBqz2qwER9CnPAwCYh/hflWCc3SyRv8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hs9NsVWx/QRc4ma383s1/iPmUSYv9h9gSl59Fi8eEWR7XgPOgPmuy012qvp54R7JijNqMBJ4VkzU1CF8+LpmmNx+4p8y/yCyGEmZNWCFClgT0Q+5IiHCPwCQy0sRaPpt8gLYSpiJcwC0919jXTmmJ9OsbMYfWyDY9zqrlUbcRDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHiq341e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89945C4AF65;
	Mon,  6 May 2024 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715029228;
	bh=euep0cZkBW8JkBqz2qwER9CnPAwCYh/hflWCc3SyRv8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XHiq341eR6eJjhLUMMgLXBcKLu6IuYQr9RrVVuJIHDZ5fM7yeJOWIVO633hoGPEqS
	 cO+B6keGCRykadaZJkRUuA+kRn74Ym/PLH+7cU54lWyeVWDUG6HSyCRBhunq+c9lbr
	 8+ijsHdOF6JCEZOXO/DoyugVMqhRkiP8JVvDLZlg3P8T01Wxnk1knC976Exh0+AM9l
	 CmbKpN4rmtTcpwd5t3ZDyWO6g8cn0Rfbb5sFH12pwYefbwCxENN4YDR655Bzx7+2VT
	 ezzseIDQyUirMbwWZ40Do+208Vun9P6lQTw6q40fbHyZkPKBJL8m1hdADLQua93+WO
	 EG0V47hrFuAAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7774EC43335;
	Mon,  6 May 2024 21:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests/bpf: fix pointer arithmetic in
 test_xdp_do_redirect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171502922848.22261.11157218747353339667.git-patchwork-notify@kernel.org>
Date: Mon, 06 May 2024 21:00:28 +0000
References: <20240506145023.214248-1-mschmidt@redhat.com>
In-Reply-To: <20240506145023.214248-1-mschmidt@redhat.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 aleksander.lobakin@intel.com, toke@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  6 May 2024 16:50:22 +0200 you wrote:
> Cast operation has a higher precedence than addition. The code here
> wants to zero the 2nd half of the 64-bit metadata, but due to a pointer
> arithmetic mistake, it writes the zero at offset 16 instead.
> 
> Just adding parentheses around "data + 4" would fix this, but I think
> this will be slightly better readable with array syntax.
> 
> [...]

Here is the summary with links:
  - [net] selftests/bpf: fix pointer arithmetic in test_xdp_do_redirect
    https://git.kernel.org/bpf/bpf-next/c/e549b39a0ab8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



