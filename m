Return-Path: <linux-kselftest+bounces-4184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5120984B14B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 10:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D381C21AED
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 09:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06AD12DD8C;
	Tue,  6 Feb 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsUZZYpv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94CC12DD87;
	Tue,  6 Feb 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211826; cv=none; b=UldQgmNYVUSTiuVPdlgnnEL1klbeRgT0xW63PS8YKCT8tkBxGLLr/7Mv7fktYsclvBnYtd7afkSg1bNRMMgN3YIHNBcBLAYjjTuEfAlciKKeUNSCXHQCVHDf05Z1JdAY9glBTTelpiWnLH19yKzKIB0HfqzZsqa+1c8T/yVyMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211826; c=relaxed/simple;
	bh=qsvov4oq4ERupC1CRh3t9QcxaPjnTBWsvxcxhElCRyg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nserkPRvGEnOwtU0iTPDcjsMqzfJgb6qux+78aeP4efZ/MO64zpxX6OjGRzVPF/AFgdayPhjFra/TZT8cGU36LEVn3r4uRQ9pvO2Ys2UfF6npWt+X/WEw0zJJtHbHMMCOPEbHY6l7PL7a3IAJhL1sPjSaEjegr3jCNnU2aVy+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsUZZYpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46E83C433F1;
	Tue,  6 Feb 2024 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707211826;
	bh=qsvov4oq4ERupC1CRh3t9QcxaPjnTBWsvxcxhElCRyg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MsUZZYpvu/TXGdb+gJuDm13IMo1lofYjDxdrad1sw6QbmyKc/AqkVXdWjPPvs8Ahu
	 wJvZj46gw8aeyN5ONkuyUUzGHrZWPn3VdjBj9vGkVXZrc7i3gxBgs2+tPNhDirnToC
	 2OJGKNAtYE/fVhGDoBjpQ3ME6e8ngLEXq1Z0ZCxQ46mBD0OAE2SUadd7h6gNIVLYRy
	 nkxwLOKrgGSxaDUXE6jQ6lul3Sqd2bJ5Tt5X4tuyr7xJPbmqCNBVYn1Iiye8A4IIdE
	 y58fACncG+CKzPSQoP3WwfO3123tWUxfl2PBSAKWUrjqsrc7TVVxFc4MJcOzGPMDUS
	 IYPxcVBcUm6MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 323FCE2F31F;
	Tue,  6 Feb 2024 09:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: ignore timing errors in so_txtime if
 KSFT_MACHINE_SLOW
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170721182620.9128.9587375437123290639.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 09:30:26 +0000
References: <20240201162130.2278240-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240201162130.2278240-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kselftest@vger.kernel.org,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  1 Feb 2024 11:21:19 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> This test is time sensitive. It may fail on virtual machines and for
> debug builds.
> 
> Continue to run in these environments to get code coverage. But
> optionally suppress failure for timing errors (only). This is
> controlled with environment variable KSFT_MACHINE_SLOW.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: ignore timing errors in so_txtime if KSFT_MACHINE_SLOW
    https://git.kernel.org/netdev/net-next/c/c41dfb0dfbec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



