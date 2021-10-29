Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F78943FFD1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 17:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhJ2Pwg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 11:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhJ2Pwf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 11:52:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DEA4D61165;
        Fri, 29 Oct 2021 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635522606;
        bh=C24ZEADQSvzXhTDyTXoMSH01592ojU9/SMUi01rYgTU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BW54T610amKwIMu8MEs6rlNqyln+uFDUyU/sp0dgli6dIWl7RO2gyUXsSvBy8mnq4
         oRk/Wrrp4Duqk1y5sOd02V1rcNF6pw5HuNGdI/EhZplrbI5hbsXlRdrfET7Dz+jwnW
         DqZFYBLkE7XKf9PPNwhYr8mbuMvyXEc6BSOJvHoraioibnmNMdXyMX8oiQ5qF/kPYm
         dDCATtwJh5JszuzA1AM+8Gp8jEt8/BXH3kfbMnvzWTd57hMfPrL3gDdyJzFRG7wPRa
         JFG77pnxzYxrga6zX7Qg83aHc2qjoIk7EnlgbRatTSViXg5ZORT3CW7nlhoTPO8IYU
         bkmHNhg69AKjg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D1D8760987;
        Fri, 29 Oct 2021 15:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: fix fclose/pclose mismatch
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163552260685.20698.10433659303294861994.git-patchwork-notify@kernel.org>
Date:   Fri, 29 Oct 2021 15:50:06 +0000
References: <20211026143409.42666-1-andrea.righi@canonical.com>
In-Reply-To: <20211026143409.42666-1-andrea.righi@canonical.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 26 Oct 2021 16:34:09 +0200 you wrote:
> Make sure to use pclose() to properly close the pipe opened by popen().
> 
> Fixes: 81f77fd0deeb ("bpf: add selftest for stackmap with BPF_F_STACK_BUILD_ID")
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - selftests/bpf: fix fclose/pclose mismatch
    https://git.kernel.org/bpf/bpf-next/c/f48ad69097fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


