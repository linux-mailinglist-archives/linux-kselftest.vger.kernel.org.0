Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7F973227D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 00:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbjFOWKY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 18:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjFOWKX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 18:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70611199D;
        Thu, 15 Jun 2023 15:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEEB1614B7;
        Thu, 15 Jun 2023 22:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C6B9C433CB;
        Thu, 15 Jun 2023 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686867021;
        bh=OO4GIh2UDuRjnfoglLA7j6vUZuazCf3QLb7484E5bXE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IDAi/BKbufdSM+RgZXbfmTpMBdoN2Mg8HncIcXAyxaCHv+UVk/q7VMqBESxbEwrmk
         0pk2ssL7tNp+IHJeGmPPDWh4vOg5kQW2XtC9uU/7E0yu6vMCNrNp+gTLGWXhk9HX93
         FN0cwU61YkRWw1MIr7u4XUf5E6YNkW17SmoCJtOv/YH8f89nmrfgJpNPd9qOUyJ+nf
         c8yfnFtZdQO2WZ1iZuXzF1TBcTOY0xBzIsmBqyFqCtzOTssZhEyolJkMpqhhgpF9o/
         cro/iWfuIMlXBWKnNXReJmtNncF4uHS4uqQ9PQcVT4D5RGRTjGUm7gpC+TqcP2arp+
         0CAB+2LVtjPNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29DDEE29F32;
        Thu, 15 Jun 2023 22:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/ptp: Fix timestamp printf format for PTP_SYS_OFFSET
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168686702116.9701.8936089484702817897.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jun 2023 22:10:21 +0000
References: <20230615083404.57112-1-alex.maftei@amd.com>
In-Reply-To: <20230615083404.57112-1-alex.maftei@amd.com>
To:     Alex Maftei <alex.maftei@amd.com>
Cc:     richardcochran@gmail.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Jun 2023 09:34:04 +0100 you wrote:
> Previously, timestamps were printed using "%lld.%u" which is incorrect
> for nanosecond values lower than 100,000,000 as they're fractional
> digits, therefore leading zeros are meaningful.
> 
> This patch changes the format strings to "%lld.%09u" in order to add
> leading zeros to the nanosecond value.
> 
> [...]

Here is the summary with links:
  - selftests/ptp: Fix timestamp printf format for PTP_SYS_OFFSET
    https://git.kernel.org/netdev/net/c/76a4c8b82938

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


