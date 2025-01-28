Return-Path: <linux-kselftest+bounces-25350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF10A2153A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 00:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D61F18822CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 23:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644961EEA48;
	Tue, 28 Jan 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq+Rc1gU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390FC19F487;
	Tue, 28 Jan 2025 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738107606; cv=none; b=DT6IntyJ6/QjnWXsJTsvMfdnpIgnQ2aG2924iN2kzS1jr6n4BnDjdsGrpIifPNYwiEFuGLkZ7+farqAmDq+4UShiPpuqmoovnnHJQNryzKyk+7i4F6dVA+9v3UVafHfz3/KijtxcQTwHRSRA5sFTPpm5ykyUUjPK0PuUX0WE57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738107606; c=relaxed/simple;
	bh=7QiyKQhvRCym3RsM9UE+ktbELDJ7OQRGE29MzYgiipk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PX+ALB6CQ5+i+iS0Z3cxENzRXp06djLYKkQ5pe1VYkXtjItv1f8Ztp4pt+C8qai+bzxHtTQxS+1/ZadjBhcM9eSpGTXfE45hVRA1zJtDlygiWX7iElIR2gkxCJMu7gia7xtPRikXlUXz1Eeh0akwBWkrfLasXGuIDR5vvJnRQpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq+Rc1gU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97257C4CED3;
	Tue, 28 Jan 2025 23:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738107605;
	bh=7QiyKQhvRCym3RsM9UE+ktbELDJ7OQRGE29MzYgiipk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yq+Rc1gUS1emh6w74UQ24kFf3Dgwp02XRmB9BiZcQn4G6hNpBHtnKfK32wyO3S+Q6
	 uGMdGAl3HZphxE2x+Vc7yKqrr1aQ7Q0vli8U+hlBuJm4CCFLdxckSdg0IA9xRyjg1o
	 O/JbOsXsoT/HwWjX7nKrcwqzSJ9Q/omo2J3ZY7M5KEKXe5+vjWb/vVyCBAkIeC/z0M
	 l6untPovv2AiitUD2idMc6N20XMfnzhqCW4Nxyk/XuegzQo+maCUSLwa60HFw6iDiH
	 YP9bYEOVrAWV9ULn6BqVIiLxPZByrKlftnds504S2BXp3SPx2qc0e4B93FYkcF8n2r
	 TDOZSgEVsXk3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AECFF380AA66;
	Tue, 28 Jan 2025 23:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix runqslower cross-endian build
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173810763150.3959643.12245006244269731702.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jan 2025 23:40:31 +0000
References: <20250125071423.2603588-1-itugrok@yahoo.com>
In-Reply-To: <20250125071423.2603588-1-itugrok@yahoo.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 24 Jan 2025 23:14:23 -0800 you wrote:
> From: Tony Ambardar <tony.ambardar@gmail.com>
> 
> The runqslower binary from a cross-endian build currently fails to run
> because the included skeleton has host endianness. Fix this by passing the
> target BPF endianness to the runqslower sub-make.
> 
> Fixes: 5a63c33d6f00 ("selftests/bpf: Support cross-endian building")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf,v1] selftests/bpf: Fix runqslower cross-endian build
    https://git.kernel.org/bpf/bpf-next/c/c03320a6768c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



