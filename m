Return-Path: <linux-kselftest+bounces-29875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A78A74249
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 03:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5373B6374
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 02:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748FA20E003;
	Fri, 28 Mar 2025 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+M0ejEB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ACC20127E;
	Fri, 28 Mar 2025 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743129007; cv=none; b=bB7tKseFQ+jEv8Ah2V+dxWT2DJJ4a1FQvJvbIbaO0OiiXMbAgj3MryZ6Tu64e+Z3WFintkiJUy5iA9I/GpY/j2KQSsojWCppEsk7iJHEkilOEWSP+UI6/Ut1yTPZ2bdopkbKcaMMarVYdzFzXSZ3xbKKfHh9FUybVCDfvIeFF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743129007; c=relaxed/simple;
	bh=X4/qvP8+82XjoRaOHseFvpQTqiyTjZjdwwCCvY2ijD4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eAKI0U0NrPXq2YT2aS14HcpJLM8mTd8NOU1CrXXSKz7h6Dl9CqYjhJleqnidML/yMeX9IyRpBXw0Zb3Fr0dVaPDKJOLZnpG/ss0M+i5mOaMCsmnPgJsns4Goih8DCgLnqe8hJMAxkVolU/DJuaZQi/64TksULpDLV8kekP3pNCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+M0ejEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185B8C4CEDD;
	Fri, 28 Mar 2025 02:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743129007;
	bh=X4/qvP8+82XjoRaOHseFvpQTqiyTjZjdwwCCvY2ijD4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T+M0ejEBl0GBes24ZvlKjLmiHg0WfqD7CX316/71fhtYKVOpVJYP0ZKj36z8rclTv
	 dXhzEV0yiulW/lak1UiW2gsqnuUcHn9QJ/sEHmDCdYdpfEBg6clXFLhpC1a5YDt/x+
	 RSPQ2i0WwFNyQkWHu2F44wToID4vNCk8fD2lbj4SN+onI4gyKscAB3yXBJpZ6NX/Dp
	 Albb5kjIO2xzszS/DMxf7DnNdE8YCAxWjlzA94mVAOYORdEdg2NvJZOb+Y1eKqy7Mf
	 Dmm1NZ7BheDyp0Uv2Mg8u/unqcgSQewhbMjHK+zBk3z2sJgc5ReGsIfRrHZhzQABvO
	 e3GUWALuS2zZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE663380AAEB;
	Fri, 28 Mar 2025 02:30:44 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest next update for Linux 6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <cf07ff28-f329-42a6-abb7-aff61845cbca@linuxfoundation.org>
References: <cf07ff28-f329-42a6-abb7-aff61845cbca@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <cf07ff28-f329-42a6-abb7-aff61845cbca@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.15-rc1
X-PR-Tracked-Commit-Id: 82ef781f24ac26f4aa71f02d7624c439ab8389a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e324a5c9849e4a8225e38facdcc1a60faa4227a
Message-Id: <174312904316.2320867.6789454613213396532.pr-tracker-bot@kernel.org>
Date: Fri, 28 Mar 2025 02:30:43 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Mar 2025 19:56:31 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e324a5c9849e4a8225e38facdcc1a60faa4227a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

