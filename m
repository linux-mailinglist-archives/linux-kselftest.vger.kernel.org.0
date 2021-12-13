Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6F047369F
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 22:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbhLMVkN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 16:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238212AbhLMVkM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 16:40:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FB6C061574;
        Mon, 13 Dec 2021 13:40:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12E96B815C6;
        Mon, 13 Dec 2021 21:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B4EAC34604;
        Mon, 13 Dec 2021 21:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639431609;
        bh=6GG03xYfqeKBcEiDmd57oo4h550St5h3jFpkVt0yeZk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=R2CiaiS53ybI42ewHM/NvbIlhP0Q654PFhRRvca/8r/FmVWlC35nio9fUDMl+13xq
         XMpgLrJ5tCEtFprNe6GWu66DLqaJ1SO+kziUcRUTxQGE5PdB1cj2LhecZ3wlirAChw
         5VuJvfPfPEKZNX+0PbQualMAWPdoNtVOJZ35p28xXRjIYax/zA+qBad0v/gEURHxaS
         Axmkq9xG+ukK3OHyk2LexoqpJjN02vU5Xeg0F5CeWtuEjPdjEmPYIQP+ldCnY17jmd
         3ln0YDB+G4KUUCzWEHeGTsznkbZXPSR7z6PROPRQHdI/id/CII1tQ5fVOWLI7DnAK+
         cPMw2yulTtjWg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6B650609CD;
        Mon, 13 Dec 2021 21:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix segfault in bpf_tcp_ca
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163943160943.5662.15434893142890658156.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Dec 2021 21:40:09 +0000
References: <20211213183058.346066-1-jean-philippe@linaro.org>
In-Reply-To: <20211213183058.346066-1-jean-philippe@linaro.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     shuah@kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 13 Dec 2021 18:30:59 +0000 you wrote:
> Since commit ad9a7f96445b ("libbpf: Improve logging around BPF program
> loading"), libbpf_debug_print() gets an additional prog_name parameter
> but doesn't pass it to printf(). Since the format string now expects two
> arguments, printf() may read uninitialized data and segfault. Pass
> prog_name through.
> 
> Fixes: ad9a7f96445b ("libbpf: Improve logging around BPF program loading")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix segfault in bpf_tcp_ca
    https://git.kernel.org/bpf/bpf-next/c/acd143eefb82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


