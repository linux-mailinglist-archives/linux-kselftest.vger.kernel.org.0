Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9135548A0EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jan 2022 21:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343655AbiAJUWj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jan 2022 15:22:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33216 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbiAJUWh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jan 2022 15:22:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F2C9B817E1;
        Mon, 10 Jan 2022 20:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12AACC36AE3;
        Mon, 10 Jan 2022 20:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641846155;
        bh=UmkvgzE4mF0UUF5wpZTzoCL7pFrdbiNrRdWfX2RwyZk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rJ/Ir5kdqLfxElpO6l0JzWGHVf8nOhprCY4ySTbE+ZPseCpmi02netKYVkFDEQAnt
         6Ok7SPekZ6w+j3C5ZaF074c7s4yZslxbXuNaX0jeON1JiIfyYD5cxb2scXlF77VhMc
         D3j2LTBCvFygw1PxkapYi5nfUmxqZfl/G5eNw6D/Qy3qwUCQsYaLNQtftY0viXKMzr
         54YiUOt2RHzo5x0vlxhUoeiIsJFgOlo21Gzlfjwb5TezH2EX/hwL6eWh6bqxawlTg8
         IkX9qpb2YbuFip+vfd1LVplMYMnyNECj5YINbZqmxEuAU0srFNh0bVa3O+f3lEDG0/
         vfo30bi+wdHuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 034CCF6078F;
        Mon, 10 Jan 2022 20:22:35 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2886e025-edea-5e09-1e6c-ff2a53ef4c13@linuxfoundation.org>
References: <2886e025-edea-5e09-1e6c-ff2a53ef4c13@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <2886e025-edea-5e09-1e6c-ff2a53ef4c13@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.17-rc1
X-PR-Tracked-Commit-Id: ad659ccb5412874c6a89d3588cb18857c00e9d0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf4eebf8cfa2cd50e20b7321dfb3effdcdc6e909
Message-Id: <164184615500.11936.5069589573010056993.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 20:22:35 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 7 Jan 2022 17:49:26 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf4eebf8cfa2cd50e20b7321dfb3effdcdc6e909

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
