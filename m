Return-Path: <linux-kselftest+bounces-22898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA779E62C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 02:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC722813A4
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 01:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7579413AD2A;
	Fri,  6 Dec 2024 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0ws+dkU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFD1139D07;
	Fri,  6 Dec 2024 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446818; cv=none; b=tBEOCnlzN19/s8n33FnQybH/lDoDiWWFFVG9mS1ew0szcohUpclBFHkukCiCgB0pK5FuXwDecQaUsJMoqq5eYiI5r/LFiX8ctAcoSZlISXBbZo5+BeLx2z44xlmabe2qDLD1qJNq9y0yU+M1hyNZmDtiZ8LTwzrxhIRsk3KmgFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446818; c=relaxed/simple;
	bh=JSeCBICHAlS+JshL8IorhwGCazJYrL3izNGQxBH+qw0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tsHd2Ks9H0W8rVmdmxVf3gPTJRoSQ5dvxQB44cSyBACp267V1X4bIq4qOGfok47hMuE1Kf4ktCag5SJ89NK0mo7ZDhM6YHA/eTfUOXNvb2Db0bHMRPlTvSIHjAivivwuL9KJuyqH8mdn9jZ1w0mSB0n++Td+9+XiTVFBCTO8K00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0ws+dkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EE1C4CEDE;
	Fri,  6 Dec 2024 01:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733446818;
	bh=JSeCBICHAlS+JshL8IorhwGCazJYrL3izNGQxBH+qw0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S0ws+dkUOGkwFPImd5naBWcfxoQG8tQ2d9pc227J8L5omeV9LuKOjh3r40ovj2y7q
	 V/HixBNbHSabUto/sWakjPnETUQNqseXKbTZGll8KeHJmFRk7ajY6m3tyqSx/CphZ+
	 +xBdzi/Pr7zJwdrlx/Xtu8FKDytFDtrAznLUD+j4tlZOyfmDG/+WPDMSrEMv/Ei2Ns
	 8S4kVuGjzSCjMmenUx5y4F3kPUN0UkKC1AgohFeJMVDQSbMAkyYNsbSWguHYl0v+KM
	 e4gSE2SmzYtGeWOeFlUB/Me8ymszGwoBkXUrup328bpATYbdal09n/Kt0RIly10LqM
	 UpAd+SRkUkBPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC3B380A953;
	Fri,  6 Dec 2024 01:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/1] selftests/bpf: Actuate tx_metadata_len in
 xdp_hw_metadata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173344683252.2140008.13676580323917357395.git-patchwork-notify@kernel.org>
Date: Fri, 06 Dec 2024 01:00:32 +0000
References: <20241205044258.3155799-1-yoong.siang.song@intel.com>
In-Reply-To: <20241205044258.3155799-1-yoong.siang.song@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 maciej.fijalkowski@intel.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  5 Dec 2024 12:42:58 +0800 you wrote:
> set XDP_UMEM_TX_METADATA_LEN flag to reserve tx_metadata_len bytes of
> per-chunk metadata.
> 
> Fixes: d5e726d9143c ("xsk: Require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len")
> Cc: stable@vger.kernel.org # v6.11
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/1] selftests/bpf: Actuate tx_metadata_len in xdp_hw_metadata
    https://git.kernel.org/bpf/bpf-next/c/0bee36d1a513

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



