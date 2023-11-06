Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A12A7E2D34
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 20:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjKFTu2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 14:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjKFTu2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 14:50:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CE31986
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Nov 2023 11:50:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12AB9C433C9;
        Mon,  6 Nov 2023 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699300225;
        bh=wBZMPGW05QAt4q3PLR20838jqJXX9Xe3kTxLnmnGOkQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JjHUzDdAIju2YfmkvIvUsaDuqv5NHttWA99vv4sLP6CRw1TJcryoFArdRFDE63TKD
         4COLsTdMAsnKAVSHuucFG1g6nsbi0+FynscNEC9gj3rVn3CZ78OLd9kdD3A+5/WOYA
         57lQhHeY5lYnPal/tPxA5Uzb9nZgqLaAFtWZFVxayy/3sonz/ic1WVuSG8kWu0UMmU
         ZBwgq2IodPfKFJERbqwVnG1gmDZZgj6Y5PeUdUMpmTV7L9KSfqJKh4omlhVQu9eeTu
         Ow8PSFQH/SDmZ1g8kOgnWRBFzkfcVZT9sC7Wie0LzExeXF22jekxqRVZxbcVwGhtvh
         SF3CFPadvZlRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC31AC04DD9;
        Mon,  6 Nov 2023 19:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: bpf: config.aarch64: disable
 CONFIG_DEBUG_INFO_REDUCED
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169930022496.29727.8671827068339091535.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Nov 2023 19:50:24 +0000
References: <20231103220912.333930-1-anders.roxell@linaro.org>
In-Reply-To: <20231103220912.333930-1-anders.roxell@linaro.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        mykolal@fb.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  3 Nov 2023 23:09:12 +0100 you wrote:
> Building an arm64 kernel and seftests/bpf with defconfig +
> selftests/bpf/config and selftests/bpf/config.aarch64 the fragment
> CONFIG_DEBUG_INFO_REDUCED is enabled in arm64's defconfig, it should be
> disabled in file sefltests/bpf/config.aarch64 since if its not disabled
> CONFIG_DEBUG_INFO_BTF wont be enabled.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> 
> [...]

Here is the summary with links:
  - selftests: bpf: config.aarch64: disable CONFIG_DEBUG_INFO_REDUCED
    https://git.kernel.org/bpf/bpf-next/c/dfee93e25773

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


