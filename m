Return-Path: <linux-kselftest+bounces-18342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7669856F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 12:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABFA1F2525F
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9040C15FA7E;
	Wed, 25 Sep 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCwlXPE0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A5715E5CC;
	Wed, 25 Sep 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727259029; cv=none; b=NoXOTRXHf60RntcWoaRl/MDbLIrZn+JQo6TAlS6cTgbZCUCGfHBjVlQFp4MRkdgl0NbXnDb22QuV/fDXCPECayJeaGalTzy68VWRdlhLTCH0ZztbRFOP6eiKvuUaRHk9GXUm8IgqczdWAzSn4P6QxIXRs0Eheytdmc052LWfO40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727259029; c=relaxed/simple;
	bh=zagggcB3+STL8PwRqWhjspVVN0j/v2YUcWp5Mt0mX78=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m3SGEYFHyO/PeFXXLMEhZY+A2ZVw3TxYlZXidq/7SbXEPC+mn1T3z5G9FALD8XdrruD2XWWBtoNjjg6Do4KwRVBZypNmzkQZ5MVP633wE2nSTlUg+blQLMSzxP9RfyWx6L3R2+3wzYLchQTivMZu0X8Ew/7duMtda1LdpWsSvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCwlXPE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED4BC4CEC3;
	Wed, 25 Sep 2024 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727259029;
	bh=zagggcB3+STL8PwRqWhjspVVN0j/v2YUcWp5Mt0mX78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SCwlXPE0bpsrn6qxwQy+GoKuil1/vTEP1ZPibVKUdixp5k0izh/VvFtPnYNpQiRqH
	 NswBhCfXZ9h9Dn5E4N1OnXyyESiSZdw0GWyWo2cjU5owy3ElohtIAKAlU9awmgHYGw
	 ZafdW+SuUYbGpc2+Qc6i1vqBNEQyn5P58IdYvGDKmwUCxKyEJ46f2dbdEZKTN/h+RS
	 LYNqZ3Drr+VwliesKtgjZ6NAqcOUBxi5OYuE9Py1Blciqsrm8WCseWd1qV3+M+JGc5
	 PnVxcXxTTkZHgnYPea/D+frKI4pqdeuvlt9JJ6du0lARrVDMLBkRZnsnpR87TA2GQl
	 Zh7ocE51AbKcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD203809A8F;
	Wed, 25 Sep 2024 10:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Add missing va_end.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172725903151.525990.10977318589786290906.git-patchwork-notify@kernel.org>
Date: Wed, 25 Sep 2024 10:10:31 +0000
References: <20240924045534.8672-1-zhangjiao2@cmss.chinamobile.com>
In-Reply-To: <20240924045534.8672-1-zhangjiao2@cmss.chinamobile.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 24 Sep 2024 12:55:34 +0800 you wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> There is no va_end after va_copy, just add it.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - selftests/bpf: Add missing va_end.
    https://git.kernel.org/bpf/bpf-next/c/8714495755fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



