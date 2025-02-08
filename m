Return-Path: <linux-kselftest+bounces-26075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E956A2D323
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 03:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB793AC5C8
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 02:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EB613D503;
	Sat,  8 Feb 2025 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2OB7y+k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C938A41;
	Sat,  8 Feb 2025 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738982403; cv=none; b=lAds0x/HkHLOarzJfINoj1uOg6fNugD8nVQVcI3ckGBYZ9+NHzYWzeXaxMhNUW5FptR0hdDSoTqpAQ4diH6S8+GtWOVCw5JnJne4FYm+kFDlYcBrbbL770G1zOV6pVot9MfXFwwU2Ae3USWfUJo6vLtRqFlbPIKLhhdJSDzdYA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738982403; c=relaxed/simple;
	bh=nXoEqWHBPCVYJy4H+Qn1jOOPHX5V1O3quc6H6Jx6YXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=boc8D5XVosu9s/XhqRbM1XyCk+YEqjFQKHF+/Lqk7ASyvFM7MQcKyew+XB/V4nYGogYxswgFnqIYDO9MglR9QgiIdWNpvLum/jY0xQW+DOvwyWNU/VAo6OZl9woeCCZ5e9+nzTDgjoW89mlfYXc6vbhBB2+bZ7nQXbbAy86Vfk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2OB7y+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57CAC4CED1;
	Sat,  8 Feb 2025 02:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738982402;
	bh=nXoEqWHBPCVYJy4H+Qn1jOOPHX5V1O3quc6H6Jx6YXM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H2OB7y+kevkx1sAEtp4Rw58i2jkZx+Zy5bImDjORI9XKkDQ+sWn9ZjGx/XJg8lJ1N
	 yxCN0kra2cC68Mxra4uoqrOca7cjoh0RpqaoAceVylXSK1XzoFkI4+B3b0UDORJe/o
	 cnTsFjkQM8L1jF8t8if0DRerXUu1Ye5ftwMY2teFrHbQNeTiERs9UfWoHp/4Ah3dvb
	 14+3iuJ5rjY3xQvW1v+hK8nq1xdA4V6e8E1WwOxzm7Fy+jL4llm/+J2UZZUrovMSM8
	 P4xd8ZItQlbb9wy27T1QsFGqHAMaWRC2LpeMkZBWbqeZ+agxisRbiuQlJNiPfZa0r2
	 2Cz/BU9+VYKHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBABF380AAF5;
	Sat,  8 Feb 2025 02:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove with_addr.sh and
 with_tunnels.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173898243078.2462994.9706001313685951312.git-patchwork-notify@kernel.org>
Date: Sat, 08 Feb 2025 02:40:30 +0000
References: <20250204-with-v1-1-387a42118cd4@bootlin.com>
In-Reply-To: <20250204-with-v1-1-387a42118cd4@bootlin.com>
To: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 04 Feb 2025 11:59:43 +0100 you wrote:
> Those two scripts were used by test_flow_dissector.sh to setup/cleanup
> the network topology before/after the tests. test_flow_dissector.sh
> have been deleted by commit 63b37657c5fd ("selftests/bpf: remove
> test_flow_dissector.sh") so they aren't used anywhere now.
> 
> Remove the two unused scripts and their Makefile entries.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Remove with_addr.sh and with_tunnels.sh
    https://git.kernel.org/bpf/bpf-next/c/9b6cdaf2ac85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



