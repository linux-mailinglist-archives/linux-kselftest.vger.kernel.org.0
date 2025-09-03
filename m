Return-Path: <linux-kselftest+bounces-40669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FECB41134
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 02:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A46546C23
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 00:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4706C15855E;
	Wed,  3 Sep 2025 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsWuoUD9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D44F1514DC;
	Wed,  3 Sep 2025 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756858217; cv=none; b=t7F22F9ygp9jmYd5uKRCvJU59XALij9b+cniewkLx4xde+1f4MskrTqwvqbzjDX+McyhiwVy2ANFmlVILsQI7+I5VYxNGfE8r4A93/iLxq3covwPDhDsUDoCpu0SGidwK9OJpH0pZouobHFIHlk4UcOn9ynIUa8Tc9iOZW10N24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756858217; c=relaxed/simple;
	bh=RThlysA/RuyeXBGMnRBfwxjS2m1nTVkIydghg2E2wrE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CR8tVtYrJPptvRi3H6JDRYP2mzUvRr2w0x1S8S7+jB/kd7bX5lxGLHGa65da/v+34R5aNSZCaWRVzJEvQiJ/NNIrlYjzGLgNWMIPopBz+wQUy+OzAbGrxLgD1JT8qnX8pV3E8cSpJ0ZDGlcsT6BVpzaT6VNzz6NoYr/tib5SCdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsWuoUD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D17AC4CEF4;
	Wed,  3 Sep 2025 00:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756858215;
	bh=RThlysA/RuyeXBGMnRBfwxjS2m1nTVkIydghg2E2wrE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RsWuoUD9QLp8V20gvgOcrU8UxEXG23gVmiGafO9e7V8FYqd+f9HVWg23xsI/VhCq2
	 ttvh90NWiI86YAc68xQm9G6B/DOBxj1eGvl/5vr8LcVJAr6wB+sZuhCfaH39/dSPQW
	 toxYnK5vdBYcas44q/b3H2JyCWP0Fi96WAFj/GnPLZf6EEsplequ2RzaWYP0XSlHmh
	 tgAXTshCd6nD9r40awU2JmD23pbLBimO5sewBMKAGYGQX7yLzFRQKdByXwCu/4iwni
	 MZPHANHc3YilDKoFO22PqXlyHlWDeeAN6Z+VggJw/mD2WIP5XHMYL/vbIyLYgJIoRu
	 yXElhngIkvuvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E2E383BF64;
	Wed,  3 Sep 2025 00:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] selftests: net: avoid memory leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685822099.475224.9853965554573801178.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 00:10:20 +0000
References: <20250901054557.32811-1-min_halo@163.com>
In-Reply-To: <20250901054557.32811-1-min_halo@163.com>
To: Zongmin Zhou <min_halo@163.com>
Cc: kuba@kernel.org, horms@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, zhouzongmin@kylinos.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Sep 2025 13:45:57 +0800 you wrote:
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> The buffer be used without free,fix it to avoid memory leak.
> 
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> ---
> Changes in v3:
> - move freeaddrinfo() to a separate label.
> Changes in v2:
> - add the label to use instead of directly to use on each case.
> 
> [...]

Here is the summary with links:
  - [v3] selftests: net: avoid memory leak
    https://git.kernel.org/netdev/net-next/c/b0bc64512295

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



