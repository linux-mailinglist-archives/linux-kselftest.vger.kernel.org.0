Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775312AA18A
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Nov 2020 00:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgKFXvX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 18:51:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgKFXvW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 18:51:22 -0500
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604706682;
        bh=L8n8O9tfeabKHa0EFaSGDW8SBUSR7cfgK3qCRIavVKI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KmD80jQ+5Yno3yar3u0ITTb+JEGuOxkUNSr1bA+XUiO6uzrtc5Zf/178e+hGPWY+B
         9teQdy14usUCKG4Y46uB5Xwp9Is2vtpQtZ2o6FjRtlY5x3evnteoSFehN5TD0+2x0O
         /abrtFOmplPTdhPFQKKp+VmpYL9/LADUlfNqE1GI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cfea14f7-30aa-33ee-308f-36660272735e@linuxfoundation.org>
References: <cfea14f7-30aa-33ee-308f-36660272735e@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <cfea14f7-30aa-33ee-308f-36660272735e@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.10-rc3
X-PR-Tracked-Commit-Id: 7d764b685ee1bc73a9fa2b6cb4d42fa72b943145
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03f0f5ad58479ba1374f10680fc836aa21abe8f9
Message-Id: <160470668202.27031.4544984612764481388.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Nov 2020 23:51:22 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 6 Nov 2020 11:16:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03f0f5ad58479ba1374f10680fc836aa21abe8f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
