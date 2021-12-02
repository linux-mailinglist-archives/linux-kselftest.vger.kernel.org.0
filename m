Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D52A466AA5
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 21:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbhLBUDe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 15:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhLBUDd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 15:03:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EEFC06174A;
        Thu,  2 Dec 2021 12:00:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22EF162782;
        Thu,  2 Dec 2021 20:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85AC2C00446;
        Thu,  2 Dec 2021 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638475209;
        bh=baph57BdP9atGNL5C3iGG2WrcvXu7ovgikPT9F9F6fg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=N+PNKZQuRjqNuuVsc1Y2HvBOoxnRDi0bFS/uRIjoRXObBP08F9TERpHUrKq5sRiUM
         A8OzCGpl+pcu7lkiXX4O9hPLwl6DjXCThAoaTAgOcP7nri1gz2jFzgePnnvxB1PM4E
         2GqQKl1eypxzJucfo9JSTStZr4gFxuskswYSECj22ZKNpF/p/E+23O9EULEkvGcprS
         oBw+dqh7OQIFTejTvq6rYA1zYrk3gWmwPDJ88rTr53H7wcKQAUt7Q4F7GscV7FZWEL
         qivYZRRiIHxzzuxLUezOMBB3XK21rdgX6TVRp5q2XYaE3lh7/gsFqFiOp3LMLFjLFb
         Nk3YItMiBFzVg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 51EB1609E7;
        Thu,  2 Dec 2021 20:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Build testing_helpers.o out of
 tree
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163847520932.12330.16820896026323277205.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Dec 2021 20:00:09 +0000
References: <20211201145101.823159-1-jean-philippe@linaro.org>
In-Reply-To: <20211201145101.823159-1-jean-philippe@linaro.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  1 Dec 2021 14:51:02 +0000 you wrote:
> Add $(OUTPUT) prefix to testing_helpers.o, so it can be built out of
> tree when necessary. At the moment, in addition to being built in-tree
> even when out-of-tree is required, testing_helpers.o is not built with
> the right recipe when cross-building.
> 
> For consistency the other helpers, cgroup_helpers and trace_helpers, can
> also be passed as objects instead of source. Use *_HELPERS variable to
> keep the Makefile readable.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: Build testing_helpers.o out of tree
    https://git.kernel.org/bpf/bpf-next/c/eee9a6df0eed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


