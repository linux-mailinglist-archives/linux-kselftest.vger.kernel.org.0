Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D85715DCA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 13:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjE3Lu0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 07:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjE3LuZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 07:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAF3B0;
        Tue, 30 May 2023 04:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CFB262E7D;
        Tue, 30 May 2023 11:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1688C433EF;
        Tue, 30 May 2023 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685447422;
        bh=byI1jSqOxqzrLfxKAKoP4+VRuLNT5KsfgGVDhPHa2TI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D7ksxtq//RH+wajtrjjSh9iQTCJVWdz2tYayDljwrAxdv4506GgB6n0nRApkI+/QL
         0haQ1OAJUExxMrkMgd2VeXmIA9cv06Tcs0l8aF5PDQU2o/UprUK+qWINuatHB91rHC
         s4PlvfanUn/eTFozn9W/DMzk/2ZNJ4HGXZjAn8R6Va6exVw1BHIo5bGjjzLP4ZVoIa
         AdZWVms1HBg4oZaS/3DCRlrqT8g7julZyzaSXQ9wkdod9ta6s+ucRcKk9Blv7C8akk
         GAnxpMHiktC4oJ4k7cfRf9E9X0ARlkFRoqEXNF6Iv+ive2EYCmHpZB5IcqfbzfWzyb
         6b6CAbfvBHulw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B61FBE52BFB;
        Tue, 30 May 2023 11:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8] selftests: mptcp: skip tests not supported by old
 kernels (part 1)
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168544742274.5689.17805805293315572360.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 11:50:22 +0000
References: <20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-v1-0-a32d85577fc6@tessares.net>
In-Reply-To: <20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-v1-0-a32d85577fc6@tessares.net>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        shuah@kernel.org, cpaasch@apple.com, fw@strlen.de,
        dcaratti@redhat.com, kishen.maloor@intel.com,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 28 May 2023 19:35:25 +0200 you wrote:
> After a few years of increasing test coverage in the MPTCP selftests, we
> realised [1] the last version of the selftests is supposed to run on old
> kernels without issues.
> 
> Supporting older versions is not that easy for this MPTCP case: these
> selftests are often validating the internals by checking packets that
> are exchanged, when some MIB counters are incremented after some
> actions, how connections are getting opened and closed in some cases,
> etc. In other words, it is not limited to the socket interface between
> the userspace and the kernelspace. In addition, the current selftests
> run a lot of different sub-tests but the TAP13 protocol used in the
> selftests don't support sub-tests: in other words, one failure in
> sub-tests implies that the whole selftest is seen as failed at the end
> because sub-tests are not tracked. It is then important to skip
> sub-tests not supported by old kernels.
> 
> [...]

Here is the summary with links:
  - [net,1/8] selftests: mptcp: join: avoid using 'cmp --bytes'
    https://git.kernel.org/netdev/net/c/d328fe870674
  - [net,2/8] selftests: mptcp: connect: skip if MPTCP is not supported
    https://git.kernel.org/netdev/net/c/d83013bdf90a
  - [net,3/8] selftests: mptcp: pm nl: skip if MPTCP is not supported
    https://git.kernel.org/netdev/net/c/0f4955a40daf
  - [net,4/8] selftests: mptcp: join: skip if MPTCP is not supported
    https://git.kernel.org/netdev/net/c/715c78a82e00
  - [net,5/8] selftests: mptcp: diag: skip if MPTCP is not supported
    https://git.kernel.org/netdev/net/c/46565acdd29f
  - [net,6/8] selftests: mptcp: simult flows: skip if MPTCP is not supported
    https://git.kernel.org/netdev/net/c/9161f21c74a1
  - [net,7/8] selftests: mptcp: sockopt: skip if MPTCP is not supported
    https://git.kernel.org/netdev/net/c/cf6f0fda7af7
  - [net,8/8] selftests: mptcp: userspace pm: skip if MPTCP is not supported
    https://git.kernel.org/netdev/net/c/63212608a92a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


