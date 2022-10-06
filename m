Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D392F5F6E8D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Oct 2022 22:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiJFUDv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Oct 2022 16:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiJFUDt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Oct 2022 16:03:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2A3B14DD;
        Thu,  6 Oct 2022 13:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73204B8217F;
        Thu,  6 Oct 2022 20:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E2D2C433B5;
        Thu,  6 Oct 2022 20:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665086626;
        bh=yJ9f4McGBe+AkliIJ6Ds7GBMH5sUp3LB3mYHmX1WiHg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nbA/A7O1/nNmBV3xxa1xb9UbIPf9nIu9jrgEVul7xnUguIwsRBs56GPsDjEDixegX
         dwzNz2HdFdWxG42wQQj0sTDO75QH0jnZ40VnoGMikYZlHnsWDGLW1ixAni1+Q69MVZ
         G2dnUxODV38W330Fgq6kqk3vc9o5HoQI38zWzPc4V3FcSdoR+O6mGLKKiGPNwGXgdy
         i4hde7cSBuTp6w1DSP4nvqGXb3Oq8hjBlVioMexCW/8IFovPj5h8+Y13ZAvs+iVzXi
         UW56nY0u+WAoS3bwbzvhVjEdSVpCjd4XhO1dFeQI1ybKuh2QTFdRlO3LG1WWqXTb90
         cS3HsVxbv9dHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24601E43EFC;
        Thu,  6 Oct 2022 20:03:46 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <92b6068e-f018-5697-5296-7318779db881@linuxfoundation.org>
References: <92b6068e-f018-5697-5296-7318779db881@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <92b6068e-f018-5697-5296-7318779db881@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-6.1-rc1
X-PR-Tracked-Commit-Id: 4e37057387cca749b7fbc8c77e3d86605117fffd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffb39098bf87db327b2be4b5c6f1087bcba94ce9
Message-Id: <166508662614.28289.144499526342967162.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Oct 2022 20:03:46 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Wed, 5 Oct 2022 15:02:46 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffb39098bf87db327b2be4b5c6f1087bcba94ce9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
