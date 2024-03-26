Return-Path: <linux-kselftest+bounces-6629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B90888C529
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 15:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75723B21AAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 14:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1F917565;
	Tue, 26 Mar 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVUSPbqC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2818E2A;
	Tue, 26 Mar 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463427; cv=none; b=J9Mx/bWuomqSpjZ7kY7RjqWpAOiEW3UBVlrya/Q1ZzLxRDMrS2Eq47oXtEGlu9NT8KWQc+QKx11evl00nQfXZImYbT3PyYgChkmy5B8Qa3UkvTIb2M5mQLzZCCE28gg98Nc9jKZImJhV5T/KxaVAeLBVlC6O8b9FdFSNwfklxL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463427; c=relaxed/simple;
	bh=oUGjKN8a97S2rx0dIM9QduSF3iQR9g9Tb9D05c/bMdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To; b=FGrvaDR9E1Iic0YTjCTQCdzrs9Eyg9lOI++jTP6LpLwtt7p0WBf7HLSSVUiWcXPQ51ak45dLn/RWV28aVAnAugOWaxieyKUbZn4W12GYvdT1toyoYlAHFYqEEqoijttRD0IeCib3XGOWVsRHagu3YLqlONCUnxHiyPp0siQW0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVUSPbqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73545C433C7;
	Tue, 26 Mar 2024 14:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711463427;
	bh=oUGjKN8a97S2rx0dIM9QduSF3iQR9g9Tb9D05c/bMdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=aVUSPbqC1cZ+JVCfGmikyGM6yG0fATOJM/icUPBVZm6COTX7INZrE7R5u/bLBA8aZ
	 IMH/3KmOg108dvLnjjsgDlLJCoAXzMbW9Nu8dhJ07x5+Fe/pAZJhxLytJisMhK4f/m
	 DOri2VUQlce0FCybTpoOH1LYyvbGIxTtOL+G5NK7hm7MZtgliJ1XBw8i2PMGgXOoji
	 /DjhUNkMAtpjPi7vljP+1D/EBvZD4w/crxOR9y43ZCVCrR/bc2FXbkjDao2DdMSfln
	 OL+7vqUC2T2SMvPPWyaX5DdomGcuCT+duhtnMzJfJh3DEF9qhs6dQHr42Hs7NcFDgg
	 NLBMyLP9xWn+A==
From: SeongJae Park <sj@kernel.org>
To: David Gow <davidgow@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	Rae Moar <rmoar@google.com>,
	Mark Brown <broonie@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] kunit: configs: Enable CONFIG_DAMON_DBGFS_DEPRECATED for --alltests
Date: Tue, 26 Mar 2024 07:30:06 -0700
Message-Id: <20240326143006.15839-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240326100740.178594-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

On Tue, 26 Mar 2024 18:07:38 +0800 David Gow <davidgow@google.com> wrote:

> This is required, as CONFIG_DAMON_DEBUGFS is enabled, and --alltests UML
> builds will fail due to the missing config option otherwise.
> 
> Fixes: f4cba4bf6777 ("mm/damon: rename CONFIG_DAMON_DBGFS to DAMON_DBGFS_DEPRECATED")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> This is breaking all UML alltests builds, so we'd like to fix it sooner
> rather than later. SeongJae, would you rather take this yourself, or can
> we push it alongside any other KUnit fixes?

Both are ok for me, but I think you pushing it with other kunit fixes may make
things simpler.  Please let me know if you'd prefer me to take this, though.

Sorry for the breakage, and thank you for making this nice fix!


Thanks,
SJ

> 
> Johannes: Does this conflict with the CONFIG_NETDEVICES / CONFIG_WLAN
> fixes to all_tests.config? I'd assume not, but I'm happy to take them
> via KUnit if you'd prefer anyway.
> 
> Thanks,
> -- David
> 
> ---
>  tools/testing/kunit/configs/all_tests.config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
> index aa5ec149f96c..f388742cf266 100644
> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -38,6 +38,7 @@ CONFIG_DAMON_VADDR=y
>  CONFIG_DAMON_PADDR=y
>  CONFIG_DEBUG_FS=y
>  CONFIG_DAMON_DBGFS=y
> +CONFIG_DAMON_DBGFS_DEPRECATED=y
>  
>  CONFIG_REGMAP_BUILD=y
>  
> -- 
> 2.44.0.396.g6e790dbe36-goog

