Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38A14BAD6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 00:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiBQXvD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 18:51:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiBQXvC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 18:51:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0017427F2;
        Thu, 17 Feb 2022 15:50:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FAE4618CA;
        Thu, 17 Feb 2022 23:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C72ADC340E8;
        Thu, 17 Feb 2022 23:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645141846;
        bh=NpSQ0OTxSO0IrfQSnUyXG5N76XbEGxyx9JaG+Bcbz8g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DblQE/Lk5nnxWSAfXcIyV4FAD6GY6pkrLhMVeXd6GlwOqDB78Ry0rVGe0xUAr6PYn
         P4QffThLC3iZivz+4jD/2DlOnuMp9+8ywgCzZUGtBM+W48pnqSanfIU+/ITzleWBnf
         LHUj24BxQbUrQAENP5c5LKX7ATKmYqJ3QnJdQ8q9ogq/3HwZGwuOBOSlKSeO7GLqut
         zhl9hf2hI7oQmW7iB+BzbxgcHxCoiejbCpbDDh/2ezW4hK6tywblyGoweFXZdVTDkk
         RInODZd4r2ek5xN2EBeQ4w2v5lnIde9B1phxpuVp0HNqKgK5P2cxkYnT1OPYyti2Md
         AQpW/OJ7DBtpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6266E6D447;
        Thu, 17 Feb 2022 23:50:46 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1b759083-880e-8acc-239b-bba42ec09551@linuxfoundation.org>
References: <1b759083-880e-8acc-239b-bba42ec09551@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1b759083-880e-8acc-239b-bba42ec09551@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.17-rc5
X-PR-Tracked-Commit-Id: 6fec1ab67f8d60704cc7de64abcfd389ab131542
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9195e5e0adbb8a9a5ee9ef0f9dedf6340d827405
Message-Id: <164514184673.26956.9171883239443079951.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Feb 2022 23:50:46 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Thu, 17 Feb 2022 15:24:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9195e5e0adbb8a9a5ee9ef0f9dedf6340d827405

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
