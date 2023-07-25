Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3067624CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 23:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGYVuW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 17:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjGYVuW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 17:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3627C10D1;
        Tue, 25 Jul 2023 14:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA792618EA;
        Tue, 25 Jul 2023 21:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21672C433C9;
        Tue, 25 Jul 2023 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690321820;
        bh=C3N78LdzzkhdNILLsvGYjZB2EMY9TDfg329d9jBl8Ho=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=czy0i+JPIIi3JSvDWzDUjezXc599XnsFAQdGdlXx+D4+98e+tmYq6opJQNxXQr8c9
         dnNhjM9bNbTUm3ZBR9d0csYALAIVJyaXpevris3sOg3mmZeuuIc8fm3HdRsHSpCR5B
         h0fJnVQPY9wFzDSTInEWvBgNXL9lRcRYNqzzB6OobOmPESXRJQr6wwrD+c7hk0E2pm
         j0bR4ANHQX+AeaYTuLaVZERIKR8x1Sgx1kwLOks9ywwDbatyqt8MktdZArB8+8DdUM
         2gpbpMOaeBYf5IGu3xygU9SegVQpjYc162AQzMfti9q/acfIwRkcbmnk4qym6G+/FX
         gOPJVDOHSAJIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0522BC59A4C;
        Tue, 25 Jul 2023 21:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] selftests/xsk: Fix spelling mistake "querrying" ->
 "querying"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169032182001.22369.1559368522725545561.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Jul 2023 21:50:20 +0000
References: <20230720104815.123146-1-colin.i.king@gmail.com>
In-Reply-To: <20230720104815.123146-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        shuah@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 20 Jul 2023 11:48:15 +0100 you wrote:
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] selftests/xsk: Fix spelling mistake "querrying" -> "querying"
    https://git.kernel.org/bpf/bpf-next/c/13fd5e14afa5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


