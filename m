Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEF176EA65
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 15:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjHCNbq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 09:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjHCNba (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 09:31:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA404C09;
        Thu,  3 Aug 2023 06:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D069661DA5;
        Thu,  3 Aug 2023 13:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F633C433C9;
        Thu,  3 Aug 2023 13:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691069423;
        bh=KM3SVbE2l+Dymo4uy1mdhvTALidWFZb++YPoJUNyLsk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q6gHVJ09+jSpCCsxY8+TRUxq+H8nQLw7ZgVIiu5RBLOc/4pvgrPB+PlP/ueOfgq+a
         irUEUhwjGGX/xC6CfcN8SadzEyUTiBb71b0hSoZC+q0ajPjUZ+Nz+8CAJKD+MUdCEw
         Gs2ikg6UyGPuq5AdNcDWC53cIK7NyErUzsHbTjmeB1X957F17U5eTwv5ll9p/47BYA
         daQrthLio61DDXujuvhDEKv6zxnL8sQGG7bBMOpw7pgumfZE2escYA6/xxje4gqZBq
         hocEF3SJLaqOrIPSEkZiUsV6s2xM1fBhH05dIFc3aUp8dn4AffBK+mObznWIFypqxL
         rkbaOBurCZf7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 127E0C3274D;
        Thu,  3 Aug 2023 13:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/5] selftests: openvswitch: add flow programming
 cases
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169106942307.23843.4039028020019462397.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Aug 2023 13:30:23 +0000
References: <20230801212226.909249-1-aconole@redhat.com>
In-Reply-To: <20230801212226.909249-1-aconole@redhat.com>
To:     Aaron Conole <aconole@redhat.com>
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, pshelar@ovn.org,
        amorenoz@redhat.com, i.maximets@ovn.org
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

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  1 Aug 2023 17:22:21 -0400 you wrote:
> The openvswitch selftests currently contain a few cases for managing the
> datapath, which includes creating datapath instances, adding interfaces,
> and doing some basic feature / upcall tests.  This is useful to validate
> the control path.
> 
> Add the ability to program some of the more common flows with actions. This
> can be improved overtime to include regression testing, etc.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/5] selftests: openvswitch: add an initial flow programming case
    https://git.kernel.org/netdev/net-next/c/918423fda910
  - [v3,net-next,2/5] selftests: openvswitch: support key masks
    https://git.kernel.org/netdev/net-next/c/9f1179fbbd84
  - [v3,net-next,3/5] selftests: openvswitch: add a test for ipv4 forwarding
    https://git.kernel.org/netdev/net-next/c/05398aa40953
  - [v3,net-next,4/5] selftests: openvswitch: add basic ct test case parsing
    https://git.kernel.org/netdev/net-next/c/2893ba9c1d1a
  - [v3,net-next,5/5] selftests: openvswitch: add ct-nat test case with ipv4
    https://git.kernel.org/netdev/net-next/c/60f10077eec6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


