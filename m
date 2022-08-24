Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67E05A0045
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 19:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiHXRUX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 13:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbiHXRUS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 13:20:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF567437C;
        Wed, 24 Aug 2022 10:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 772DFB82389;
        Wed, 24 Aug 2022 17:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24FD9C433D7;
        Wed, 24 Aug 2022 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661361615;
        bh=M2wrcwhCh7nQLsposY8BZ4Zp9TXq1ZB22EA2lw63ZKk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lKVSx07g6gZmjYA4eTa1RQI9q6/wVL/IE8M5KMnbsW0sWaWiMW4ixb+JmjApbuKnV
         UIgCRnkKZyxyhNlaAvVBiIrZQQp0020LtbYEzkq5Pr10H2HmNNehY8K09uQvGyxgXE
         NrxpG5FGY3vZ1fYsJldrZByIYiUapj3cntDJjNNOcxCmYFs6o6U668Ipn4T34fVlUy
         5i6s2JuJlNMa1VZdHSICCJgPy6bn1t6OEGWb02qPbk4bDqC60HdFlQdf/hm25plM1r
         8XnSCxqI8Ax0JdU8y1ijT83dzwMbVt1YAb0Obv2cUfU0haiHnaRmhKDYqvwtCxMasN
         hOVj6w0IAJQKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04CD7E1CF31;
        Wed, 24 Aug 2022 17:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next,v3] selftests/bpf: add lwt ip encap tests to
 test_progs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166136161501.22569.15129561246366098327.git-patchwork-notify@kernel.org>
Date:   Wed, 24 Aug 2022 17:20:15 +0000
References: <20220824110632.1592592-1-eyal.birger@gmail.com>
In-Reply-To: <20220824110632.1592592-1-eyal.birger@gmail.com>
To:     Eyal Birger <eyal.birger@gmail.com>
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 24 Aug 2022 14:06:32 +0300 you wrote:
> Port test_lwt_ip_encap.sh tests onto test_progs.
> 
> In addition, this commit adds "egress_md" tests which test a similar
> flow as egress tests only they use gre devices in collect_md mode
> for encapsulation and set the tunnel key using bpf_set_tunnel_key().
> 
> This introduces minor changes to the test setup and test_lwt_ip_encap.c:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: add lwt ip encap tests to test_progs
    https://git.kernel.org/bpf/bpf-next/c/a8df1b0636af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


