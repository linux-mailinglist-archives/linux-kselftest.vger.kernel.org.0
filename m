Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832C46A0FAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 19:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjBWSrj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 13:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjBWSr0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 13:47:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9631158BF;
        Thu, 23 Feb 2023 10:47:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FA9961777;
        Thu, 23 Feb 2023 18:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB8EDC4339B;
        Thu, 23 Feb 2023 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677178026;
        bh=6C2jHPl6pnwtB8eHfvsI8oYo3JuuUpmD65Pi5NUNCI0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fEWTAIuymFwYkl+n26dcjFAPVmNIoG3xWR18erT/4H2NWr7tOt7CWZeuPzQHql0kG
         bb+ccBIuFfaDAIHt5guqtLhzlj2LEq9ODl6nXBxonRYuQXlkfE6w45rrtVwbasVRaN
         emgI30MOcETF9R2A+9WWrlcaPoZPs1ucRIjYhi2bDiq/PXvhxd7ne+ML5vclTgS3Gt
         bUp3UP7uYktq/zQqFq1MN+MyBThy/IENrg7v/DvbBTlkbiflAf+g5TnOsJBorvldPt
         7x4SeTDc0veqiuQNzGeLL2w6WTDZCsRnJREoTgar0UFqP3DPTwPKg/2XqnKTIiaPw9
         sQ7/VS2eOQblQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6507C395E0;
        Thu, 23 Feb 2023 18:47:06 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit next update for Linux 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <02cf36b9-6526-576b-1fd3-a59b67c8c123@linuxfoundation.org>
References: <02cf36b9-6526-576b-1fd3-a59b67c8c123@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <02cf36b9-6526-576b-1fd3-a59b67c8c123@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-6.3-rc1
X-PR-Tracked-Commit-Id: 82649c7c0da431d147a75c6ae768ee42c1053f53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89f1a2440a200918676f9e1eeb765b337f735d86
Message-Id: <167717802667.14005.13294305555994735974.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 18:47:06 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 21 Feb 2023 18:50:56 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89f1a2440a200918676f9e1eeb765b337f735d86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
