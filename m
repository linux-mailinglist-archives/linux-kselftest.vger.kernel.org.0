Return-Path: <linux-kselftest+bounces-22225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD359D1E87
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 04:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AC1283209
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 03:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E7A84A22;
	Tue, 19 Nov 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cORlJbS6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA401A28C;
	Tue, 19 Nov 2024 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985228; cv=none; b=t1YogcqmEBdh5JdNhmlGxDPAnLT8mCmWfUfhuAhdf1AzVEvygUEO+zNyL7cr3/8qkiUiXY4+EKx+YegWdtIjLUKK/azrhVIGYS6kc2vAq7XO3GssOKzbrU4pYmm2NQ1NLxZitdIRwk1sO/CaC9ftaWqNoRR+Vvsi+ZSEEYayl9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985228; c=relaxed/simple;
	bh=/Mvt36S/RdlWwZDHxJ+uh+u0ea1LA9OjZPho7cXNQ2M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OyJqqQVMcne4MbOmGunsW30hURkBLuJ+oQX3Rffiua4z5/SdpOtTySXzWPv4AJ0nyIkhRGZOvfiLzuRUPIA4k/qQ+FKPcSeypt6M5GgeuAavlqv26JajLuRUAkRq8o2UutrNCxGOy7N8y9aa1J95BZBo/ovsoA3meHlvbToQty4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cORlJbS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B33C4CECC;
	Tue, 19 Nov 2024 03:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731985227;
	bh=/Mvt36S/RdlWwZDHxJ+uh+u0ea1LA9OjZPho7cXNQ2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cORlJbS6EfHdS5/8c87oBeUZ+DOlNEwWOw36y8Qyjox+yhwGrX4FpT/Gy3PpaqTL8
	 EenTVTfLFSdPaDpuJbaAqp2pTrK3/IXoN+fK+PC8oV/KsY7o4+wNA21LyiWDWrl/r6
	 E2F/5B195ea1IPwmHJdVE3+l63AQ130eCMXHf4IJ3O+NpmLxQMYiN8fttjrNPvwVsg
	 MMReT+QPp3FlYksurZYmMy1GED1qtS3Y0AGBmc/oxLMdclsa3FLkLKR5lPYiyW0t87
	 rECsNgGsLFThKPbQvtTHY0ZWS3OWX69x1PlpauhlbpfpCJ3OaM1mRSDiaiROrb9aVR
	 x9qTP9yvntIGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF1F3809A80;
	Tue, 19 Nov 2024 03:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: netlink-dumps: validation checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198523877.84991.11510166168893200267.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 03:00:38 +0000
References: <20241115003248.733862-1-kuba@kernel.org>
In-Reply-To: <20241115003248.733862-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 16:32:48 -0800 you wrote:
> The sanity checks are going to get silently cast to unsigned
> and always pass. Cast the sizeof to signed size.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: linux-kselftest@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: netlink-dumps: validation checks
    https://git.kernel.org/netdev/net-next/c/357c52ff860b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



