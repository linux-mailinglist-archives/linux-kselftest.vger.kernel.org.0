Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FD8533204
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 21:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbiEXTxj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 15:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241377AbiEXTxf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 15:53:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3EB793B0;
        Tue, 24 May 2022 12:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65432616EF;
        Tue, 24 May 2022 19:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2EB7C34118;
        Tue, 24 May 2022 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653422006;
        bh=jEyVaQgiUPGB6cBGtuxITB7KLVb8FEmB14/6i1uec1U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vp26nruWosYNITR0e/aH7Esnq6mW+qKnfIuGna/qYgQo6WGEq+BsQWqcbuOe1I2MR
         RdrvZdSZn0Xb8GSQXa43BvA6Bt/9XtXu6LinIIB4Tv+Y300P/TzvblUwQMOE2AN5ab
         /CQndsE9e0xlkFjnd26r+urXLdgJfzta808hi1T9ucjmGAm0SjvlGFNrqRty0HNF2Y
         zM3762h3iaSWKT5tEfJ+qt+QRgfEN7ChQNpuEQeOVirXkrA7IHtrQbsz+K1vwB9e9O
         WIsVumLiNPZhbyxn0OPxQuabhYHj10/aE21UPzSR38I4EwiX56Wp5+LACdkCZJ5BuO
         yljwd1rpGY7IA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C445E8DD61;
        Tue, 24 May 2022 19:53:26 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202205231214.ED9D18F@keescook>
References: <202205231214.ED9D18F@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202205231214.ED9D18F@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.19-rc1
X-PR-Tracked-Commit-Id: 5e91d2a4146946ea0abc984ca957f12b70632901
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc8af1ffd657c90733088e0093c7990305b2b4e9
Message-Id: <165342200662.18932.10797505337064474015.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 19:53:26 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        David Yang <davidcomponentone@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Yang Guang <yang.guang5@zte.com.cn>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 12:15:01 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc8af1ffd657c90733088e0093c7990305b2b4e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
