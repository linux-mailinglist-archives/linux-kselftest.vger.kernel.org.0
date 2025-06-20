Return-Path: <linux-kselftest+bounces-35454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEA8AE2012
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 18:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C021C4A71BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 16:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BD12BEC5F;
	Fri, 20 Jun 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEXIE9z4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2791E3DDE;
	Fri, 20 Jun 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750436839; cv=none; b=e73V/7XW9FVQlu7Baxnct8rVE6+fx1YXZMoG/Q772luhCjiVj3a5mZTkJ7lC20XJBH3CW/FHmHUc02I4pkzozFnnm6adjm78++gHD8zFp8MIeQL5DdhazzQ4gVk4nNCBG4Qv0En9UEr8Mr6//qXO1qQkr9eFUuiSBJnLZksLR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750436839; c=relaxed/simple;
	bh=uv43RhwxkKp/Bgy6bf9x40MHBG3ulwekMinVPvA+rZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMVPcTQS3cTGc3Ne2hCAfwEpZA0DrNahl1O5GTltXAgk5c+ao9Lcp2X+lWzld6g5aMWYjPMcmb44chq9D+dNgqLAIZXLmXtAVaVcd2BU32ZC7zJGtV9BET52pCg0kx6DZHNDTf+rT8tSh6vhQT8l+AbdjStbSAqtGG7lVRvlOeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEXIE9z4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604DFC4CEE3;
	Fri, 20 Jun 2025 16:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750436839;
	bh=uv43RhwxkKp/Bgy6bf9x40MHBG3ulwekMinVPvA+rZs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tEXIE9z4YLEObkeueEOpHWzTtuNktqmT8vMPyeExJ3840vk+cSTCHRRoSOhQeyf6h
	 CvJWdwiuJZdEgyAjuiXv5dep/TRDn5lOtBJ44J7GF4sUZJZduwqFWX06LloxGGi9mO
	 uTwrcRUXKDfEytkvL+D4fjuDa7CSI96R7x0F8q1mzLs2c4dzsIsr0IBetu7FnzdLOF
	 a/8/ZtXedJa/oDcjXA6sAg+webIOMP8ynzpJ+M0gqdzL7LtYajFyK+PSd8zSq/zZAM
	 RShDPLisTQjYOZxpiJrrC7+pqOzGo9hGObBsYHiIM/KAyjs82b1+OiFve8pTuNtCft
	 ydbWAGuNx1C+A==
Message-ID: <9a355692-246e-4bdf-a636-96b5859bb6e8@kernel.org>
Date: Fri, 20 Jun 2025 17:27:15 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add test for bpftool
 access to read-only protected maps
To: Slava Imameev <slava.imameev@crowdstrike.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 justin.deschamp@crowdstrike.com, mark.fontana@crowdstrike.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250620151812.13952-1-slava.imameev@crowdstrike.com>
 <20250620151812.13952-2-slava.imameev@crowdstrike.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250620151812.13952-2-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-06-21 01:18 UTC+1000 ~ Slava Imameev <slava.imameev@crowdstrike.com>
> Add selftest cases that validate bpftool's expected behavior when
> accessing maps protected from modification via security_bpf_map.
> 
> The test includes a BPF program attached to security_bpf_map with two maps:
> - A protected map that only allows read-only access
> - An unprotected map that allows full access
> 
> The test script attaches the BPF program to security_bpf_map and
> verifies that for the bpftool map command:
> - Read access works on both maps
> - Write access fails on the protected map
> - Write access succeeds on the unprotected map
> - These behaviors remain consistent when the maps are pinned
> 
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>

Reviewed-by: Quentin Monnet <qmo@kernel.org>

