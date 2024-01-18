Return-Path: <linux-kselftest+bounces-3192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690EB8317CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 12:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF281F218F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 11:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F72F241EA;
	Thu, 18 Jan 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+A1p7xa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E920F23757;
	Thu, 18 Jan 2024 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575626; cv=none; b=ppa8dyV9buN1bMAHCUkUsTieq21Qmfpb/FyvzhXWF+DFQ+RsSm8PS8oZLfk6/6VZvpTK4ox6wd8jvS3992zSlfAN/NsKruqbt0rmtp2AD70fxpdVVZ6/lBNzOeaz8DW70Pnh1wDUypU+lO7A0GgbBuTvPZB96GTdy05XFZHNyFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575626; c=relaxed/simple;
	bh=cRYFExc6WC+tiYLcPkfNYEjhiR8+sS9NYHHJeCzHzMY=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q9Kz6MizanLO6wL/LgrtFi+Tt5PLsS1WArp9tWf4BjfBNteaP9pPlQdr18deDPyoSYyYxP07Bq+TVooEbZq8sM4sbvuGERbRyFK2SR1q6EXKDvgVoMyicycOWpfIyeijpaigZEEZdSttRDkr+DbNBiW7g14EjuYDOWz0/ZkeSH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+A1p7xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FCF4C433C7;
	Thu, 18 Jan 2024 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705575625;
	bh=cRYFExc6WC+tiYLcPkfNYEjhiR8+sS9NYHHJeCzHzMY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F+A1p7xa1VUcZCcxOPKBMNsEqK+dpbD240JCkFErbzzkVAVArdBjcecYImja2ETUt
	 wWUhD3L8v6V4EBGaRzlK9PpHYn1vBl3opMj+LTlQ2OfeMZOXll1Xr9+SUTCVBxHn5C
	 jAzISiemLLHPetrKE1O8uK8jx5WA2ogwnuk30JX5ZPRVaHa0/zlMDHvvV9iodq1Fpv
	 X2jNPik5YVUfIZmO4cRXHoJbMT/ml6Mp/d1UKa7X1fzpDqlKARZDaB8D0lku/rhzTE
	 2ykTjn5ZhFORqz/xQWp3xsNcRCtTpsE/EirXjVQx+5NOkLlxQGhTV4AC8I+At21gro
	 ReL6WazBsPUBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88C12DFC697;
	Thu, 18 Jan 2024 11:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: netdevsim: add a config file
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170557562555.29568.10174791710118557642.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jan 2024 11:00:25 +0000
References: <20240116154311.1945801-1-kuba@kernel.org>
In-Reply-To: <20240116154311.1945801-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, jiri@resnulli.us,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 16 Jan 2024 07:43:11 -0800 you wrote:
> netdevsim tests aren't very well integrated with kselftest,
> which has its advantages and disadvantages. But regardless
> of the intended integration - a config file to know what kernel
> to build is very useful, add one.
> 
> Fixes: fc4c93f145d7 ("selftests: add basic netdevsim devlink flash testing")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] selftests: netdevsim: add a config file
    https://git.kernel.org/netdev/net/c/39369c9a6e09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



