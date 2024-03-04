Return-Path: <linux-kselftest+bounces-5830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD488703B8
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 15:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70651C23300
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 14:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF8A3FE2E;
	Mon,  4 Mar 2024 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foYRdYyx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E250B3D9E;
	Mon,  4 Mar 2024 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561427; cv=none; b=N7724+S1dNq+lWxTfozZ379sw57raW3oxkrdaDS70wmM4E7Ae8ac4IpN9nFlkh32W7Fm0kEOqrelZhnrRiHh3958n6ywj8Bsw5EOjLv1VgIg5tV+r/ERBJpkokvKwXB6J2G2uIF3WkyYxGQPdGoRPfO5BtlFoRoJkwrczHZH9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561427; c=relaxed/simple;
	bh=e3vwrozgYttFesjrkEkiWY1DOGCdGg097X1QMijHh14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S+viYT8hO8bXXRE55o85xo09yAraVOyvAly0Ne3QZ5QADpDHA6IbMs+dfKsrtbOKo5Uuh9jGx+hXLGovRUvKKgUTZKARzAK5JXT2F8rklMZ1wMsoCRzEafJlgimie39QXR7fAvvHG/VOzLVI5ij2woDdYR3GiCMBTB+sJ9z30VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foYRdYyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE089C433C7;
	Mon,  4 Mar 2024 14:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709561426;
	bh=e3vwrozgYttFesjrkEkiWY1DOGCdGg097X1QMijHh14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=foYRdYyxuUzzlnIK0ysZ+/h7LUP5HkwK3+MztotHFXqWWcsxXxuQL0fgW7QTDWLW1
	 JiE+/i9DxUhHjkBW0PbYjUDlGNTMNdkitPb1uftZ6yrBVA/XU7g80EDqeImTKoh9kH
	 DzUYAyuDPYXw95glklTZ7nWh3xHQ5cKcg6jSvnh6lRpDi8tGN3hFi4PQsskNy7Bw7K
	 5HMm0o+gpW7U2Tj6iTX1tZTHlmFFJbE6MpZhcMfHL5WWuzkOfvO3kysX9ieU5Ght+C
	 LSAsbtMHEny5mQc99MKLsZAMX0Lf9D+C0nVjZBbbXYZ4XdSJ84ZDBDSjaJN6eNu16+
	 8bzq4osx4vG/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90C7FC595C4;
	Mon,  4 Mar 2024 14:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iwl-next,v3 0/2] XDP Tx Hardware Timestamp for igc driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170956142658.15074.12322285485014543685.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 14:10:26 +0000
References: <20240303083225.1184165-1-yoong.siang.song@intel.com>
In-Reply-To: <20240303083225.1184165-1-yoong.siang.song@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@google.com,
 vinicius.gomes@intel.com, florian.bezdeka@siemens.com, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, shuah@kernel.org, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, xdp-hints@xdp-project.net

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun,  3 Mar 2024 16:32:23 +0800 you wrote:
> Implemented XDP transmit hardware timestamp metadata for igc driver.
> 
> This patchset is tested with tools/testing/selftests/bpf/xdp_hw_metadata
> on Intel ADL-S platform. Below are the test steps and results.
> 
> Test Step 1: Run xdp_hw_metadata app
>  sudo ./xdp_hw_metadata <iface> > /dev/shm/result.log
> 
> [...]

Here is the summary with links:
  - [iwl-next,v3,1/2] selftests/bpf: xdp_hw_metadata reduce sleep interval
    https://git.kernel.org/bpf/bpf-next/c/01031fd47305
  - [iwl-next,v3,2/2] igc: Add Tx hardware timestamp request for AF_XDP zero-copy packet
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



