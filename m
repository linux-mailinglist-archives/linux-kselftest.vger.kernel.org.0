Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9566A0FA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 19:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjBWSr1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 13:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjBWSrY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 13:47:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEA015885;
        Thu, 23 Feb 2023 10:47:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1776B81AB8;
        Thu, 23 Feb 2023 18:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93C93C433EF;
        Thu, 23 Feb 2023 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677178026;
        bh=p+4qMvq3tcMWTHcyZOQJ5FmryJtgMA5mhgP9GISDHp0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TDfNg+K5mjCsXTSxEJd+Mwp61k1l93/CGRbPnyLClKmdDg1POIEPMKcchkXDIx3hJ
         oBMXimUhgLn/yj2nmHvtJdLMZkLyh04XEnR1Y7t19+MKu7+gfSHUahRSDll1WCkRvW
         9rEbs+AgjRS1U2860F7L5FHiU1vsEzSZl2hqR4L6HyHVpgOKhUrqSUp6cEQ1sOZ71j
         t61CVKxpT29WtdZvgsPREeS6ApPs2/A1Ln62vOPyLnr4DOz2kq1X9ISZRAByqITnM/
         +zY+EoSyrsksK4xiTHXtQ7Rz298N9iFrG+AR56xGQvRAqXvQ8Gn7jnFlV0Y12sk7j6
         +ZmCOBlyIDsDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C6DCC43157;
        Thu, 23 Feb 2023 18:47:06 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a896a0b2-258e-f412-038b-ab17b137bb80@linuxfoundation.org>
References: <a896a0b2-258e-f412-038b-ab17b137bb80@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <a896a0b2-258e-f412-038b-ab17b137bb80@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.3-rc1
X-PR-Tracked-Commit-Id: 0eb15a47bf437a268b69ab1a1a45fdf1f609b69f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6296cb65320be16dbf20f2fd584ddc25f3437cd
Message-Id: <167717802650.14005.8003016327699118395.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 18:47:06 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 21 Feb 2023 17:15:50 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6296cb65320be16dbf20f2fd584ddc25f3437cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
