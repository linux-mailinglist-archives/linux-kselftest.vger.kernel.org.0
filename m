Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB467331655
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 19:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhCHSkO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 13:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231224AbhCHSkH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 13:40:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7594965224;
        Mon,  8 Mar 2021 18:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615228807;
        bh=wpz7hEpNPk43NbRCuI7ouiJoQTcvMYGFXJ7ylbWIdBM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q/joHz0+0jjbmCciAXuRxJwRTBHrbawoEtZs4ocQ19X1KIDHTNZWZpKHYaviD1YCY
         lKzgvU09fK1iJqMjmEGuNVQ+aysYRtUbapfPzdUao4dcHGxZMFsP34zTap970ZqscX
         hFIUa7JpY4tbtslouQETB/GtDHw/WHoOS+2wX5T58m0PvohZZDwjwY7TUkjKf8Z1pA
         kCrFaX+zXKXfgYR8pTKjqyEW2C2NSMAe3KuhTvxLD//hkfwFEKpmMMatXbD4wBtzkX
         jYl/lUHxotY/fNe6z5hbLOIFk+jHFp87GAm83usylYBP438+WOt5U+rVuOaY3n+Hkb
         FYnkaMgbxRPAw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6CEE6609DB;
        Mon,  8 Mar 2021 18:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix typo in Makefile
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161522880744.17587.7644031579879031410.git-patchwork-notify@kernel.org>
Date:   Mon, 08 Mar 2021 18:40:07 +0000
References: <20210308182830.155784-1-jean-philippe@linaro.org>
In-Reply-To: <20210308182830.155784-1-jean-philippe@linaro.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, joe@cilium.io, toke@redhat.com,
        quentin@isovalent.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon,  8 Mar 2021 19:28:31 +0100 you wrote:
> The selftest build fails when trying to install the scripts:
> 
> rsync: [sender] link_stat "tools/testing/selftests/bpf/test_docs_build.sh" failed: No such file or directory (2)
> 
> Fix the filename.
> 
> Fixes: a01d935b2e09 ("tools/bpf: Remove bpf-helpers from bpftool docs")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix typo in Makefile
    https://git.kernel.org/bpf/bpf-next/c/a0d73acc1e4b

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


