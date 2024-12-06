Return-Path: <linux-kselftest+bounces-22897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371A39E62C5
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 02:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E392F283FC6
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 01:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395E928689;
	Fri,  6 Dec 2024 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkwkSNtm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BAB4C62;
	Fri,  6 Dec 2024 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446817; cv=none; b=qL854V464WLm7F9YOZHyzD+yFwGUOBYvKUuZ/whHLvrymbm+xNZrqqt9rvSlBOdb2NxD27EkZJCH4Fn+lrLgK4HnxHE4n4CJohuQBFOnc1sHmdqkQSWE7y7y1Uvkt4xtcUlehe1BLXUEjJuzcIl/Bqm5sg7k/IoFh9Zobv32chg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446817; c=relaxed/simple;
	bh=RRp/+FLPo/bs5FepXu5/siU2ckJNsKC5qSbR8wuh9EA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fAG3u4yuYff2LwWgCx39hs+MLvCbteqchoseY2G0NwqsvuGp8Ch98omOSeJPFIW/a9CbJ6xFzihgUAgPn+oHGeFQh4qAkSlnSppvbcQl7VY7cVm2GlLqOCGuvGd7dRl6GfAlHzN1XYO6Wct1C+dVHRTzZ2l4NPklXXYBcYBTbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkwkSNtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5DFC4CED6;
	Fri,  6 Dec 2024 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733446816;
	bh=RRp/+FLPo/bs5FepXu5/siU2ckJNsKC5qSbR8wuh9EA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PkwkSNtm81/RZ4kXvDC+d9znuMKDLyxEbhETfw3wO7h3gSjm6LtKaFZqsVT/UpoNH
	 5Gxpj8kGtkwMwbDi5vQz0+OL2s2ARxUoNQefeA5idmWb561heqCOvB4PaQYfVNEzd8
	 h9MEIFtKLt+5gI/zBJSsx3fuqqxHwHp9c2ORGQPYb8tqOk1QLfa1vUJihPy94mAzwf
	 Dvp4L17ci+K7Wvh/rndMZtOJRbXBUMcvt6WNso9mRzCuirhdpgkMbcxEVS+Kcm+snw
	 t1E/EWFor2xGV/K9aU4zNBc1jwOl7EdMuW0Ua10lYcs+2X5JL6J5gKPFcVTRH5SpZj
	 kcLk/okFKrsiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7155C380A953;
	Fri,  6 Dec 2024 01:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/1] selftests/bpf: Enable Tx hwtstamp in
 xdp_hw_metadata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173344683126.2140008.17912475384599050958.git-patchwork-notify@kernel.org>
Date: Fri, 06 Dec 2024 01:00:31 +0000
References: <20241205051936.3156307-1-yoong.siang.song@intel.com>
In-Reply-To: <20241205051936.3156307-1-yoong.siang.song@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  5 Dec 2024 13:19:36 +0800 you wrote:
> Currently, user needs to manually enable transmit hardware timestamp
> feature of certain Ethernet drivers, e.g. stmmac and igc drivers, through
> following command after running the xdp_hw_metadata app.
> 
> sudo hwstamp_ctl -i eth0 -t 1
> 
> To simplify the step test of xdp_hw_metadata, set tx_type to HWTSTAMP_TX_ON
> to enable hardware timestamping for all outgoing packets, so that user no
> longer need to execute hwstamp_ctl command.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/1] selftests/bpf: Enable Tx hwtstamp in xdp_hw_metadata
    https://git.kernel.org/bpf/bpf-next/c/2309132fc5d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



