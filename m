Return-Path: <linux-kselftest+bounces-10368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BAE8C8D55
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 22:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12EAE1C228CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 20:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA7B140386;
	Fri, 17 May 2024 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkJuUjV8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B74038F86;
	Fri, 17 May 2024 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715978310; cv=none; b=GxB5KxvSKvNC7QdTN4EmOfTOZx54D8aI4O3LFhpX4a3RYCuv2EyUvKKbVXbPamRD8VuLZ8MKjjzTMCn6PSKJcAEUFFxU7GbN0l2BXQlwfw0r8c1xBA2d1CSKxoME+RVPETBaNghBhJSEjo7EC9GJJRkhfXUMKcrHnUJ2WTTBMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715978310; c=relaxed/simple;
	bh=VESQQVszmj9hnUXrDL5EqUE8OZdDZkTLli8H1c6yMw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LnEOPhI31dkKQTJHmb3lCsUUDmgNiAD5F2MQi5C1/uZSJ11fCA2rf7Zc78G64au+O56ObDIzC0QmDk7rsJ23D29IzFZ4t8tlbbuX7BFzYYiMvUryaNn7r67PAqhiR4MfY7cPszgHnJ70+XfFho7kTk2Ui3NqJ6/jtzw7SdJB3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkJuUjV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2E01C4AF0B;
	Fri, 17 May 2024 20:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715978309;
	bh=VESQQVszmj9hnUXrDL5EqUE8OZdDZkTLli8H1c6yMw8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AkJuUjV8UfKWHHkbXBUokhD9PswDCOhG5Nc+h/XDapPtMf/9M9kVkN5fblisd6juw
	 QI1UBkZQC0sPw41THyOV4To5t8rP0R9ZCzk/enGdaw3l1m/vkIBdMiA3MokXw/jnVy
	 xStJxzUu/EH+kN5RQPEJtUZqi8SqHzAXcSSLklGIdJN0KhtvjgM8S/umCq08Tz449L
	 gRpJbScIB6HXeoV3QvVVbpgh0gSD77YpNp8W0RIVR2CP8qaFd0q5VQ1X4Lwiii678W
	 7872Jdpoahz9XgrZr9gB8RuWmE9dknuA+wHSFDSlpTZCKOcTrX5pVpA5BOUG+chruZ
	 GCIyTNAgoQPLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8BE7C54BDA;
	Fri, 17 May 2024 20:38:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] selftests: net: local_termination: annotate the
 expected failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171597830975.5541.4499174102390124527.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 20:38:29 +0000
References: <20240516152513.1115270-1-kuba@kernel.org>
In-Reply-To: <20240516152513.1115270-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, petrm@nvidia.com, vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 May 2024 08:25:13 -0700 you wrote:
> Vladimir said when adding this test:
> 
>   The bridge driver fares particularly badly [...] mainly because
>   it does not implement IFF_UNICAST_FLT.
> 
> See commit 90b9566aa5cd ("selftests: forwarding: add a test for
> local_termination.sh").
> 
> [...]

Here is the summary with links:
  - [net,v3] selftests: net: local_termination: annotate the expected failures
    https://git.kernel.org/netdev/net/c/fe56d6e4a99a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



