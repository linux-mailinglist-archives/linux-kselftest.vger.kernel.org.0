Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCD7502ECD
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Apr 2022 20:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347657AbiDOSth (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Apr 2022 14:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347170AbiDOSte (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Apr 2022 14:49:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5473366F92;
        Fri, 15 Apr 2022 11:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 110B1B82ED4;
        Fri, 15 Apr 2022 18:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA081C385A5;
        Fri, 15 Apr 2022 18:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650048422;
        bh=V6Or4vmknzNgFOcP+C8ivvRl20k+FMtELnb/9XTJge0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iceQkmTlvcOD/GZoQHYQqnnPvN/c5vOI3MqO84zomnLUEOaDFIkLlO7d5k+QikQZU
         H/XQMBCAUabElx2MAy1bIBw1/sj+UcipE+zfBnhiht097XuYJuNzgsJKU6y9/WwLiO
         h9K/d5HODEvheCtq+dM7c3o4MllYD65ggWTbk50OKUgC9EXUkB843t+Pbr+H0OcZtA
         ZrI7Jc/wc/LmILnVECIs48N+72bQTtGF5m0glToSkoXPei0eGuTIygOJY+AlQSrTMa
         IZcYgLvXjnHBgwDnml/OgqnC1vY59uZFb3VwUV3HEDTmiiItAKXL/f8wNgng/yYcUW
         /vbzz0UTprG/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FFA3E8DBD4;
        Fri, 15 Apr 2022 18:47:02 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c7ff0298-f0d7-2159-2af0-4c94abc5c52d@linuxfoundation.org>
References: <c7ff0298-f0d7-2159-2af0-4c94abc5c52d@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <c7ff0298-f0d7-2159-2af0-4c94abc5c52d@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.18-rc3
X-PR-Tracked-Commit-Id: ce64763c63854b4079f2e036638aa881a1fb3fbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb34e0dba38eaed1160c8c863659318ed2929a93
Message-Id: <165004842258.6717.13245995236128908942.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Apr 2022 18:47:02 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
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

The pull request you sent on Fri, 15 Apr 2022 10:31:52 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb34e0dba38eaed1160c8c863659318ed2929a93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
