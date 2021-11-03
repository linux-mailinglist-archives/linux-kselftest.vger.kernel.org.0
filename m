Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BA1443CC9
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 06:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhKCFl1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 01:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230431AbhKCFlX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 01:41:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 83D4D611AF;
        Wed,  3 Nov 2021 05:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635917927;
        bh=kNWeR2uO1Qpq9FMWc9gmClN8pdS+hNVMR0RUoe1MnyM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p/0GGpuO6cR6+TBMTtxsNbhodTmAhaMCdlUs4/pxwP/1Lf7BwBtKrT8dhjMzeAWfh
         9/qbVy4gSGWwvorNYHyPikB7TvXozT5SrJCgUvQAs546puXVgyRIjdWEb+bOm2AUJz
         T1VeG3gunmQjvoUKAVvk2FsrQrOCKJR4bxZUEgShMyRluNC/xqPF8k767MXHZWJIYW
         eb+d3G9VtTr7ZdAF9cQ8C7F99AMcJD8jWvxe3FqNnFnhW/CMlRJVNaYJUnlzXt7soi
         TgLp5GW9Gr94uIB2E128v7x4mOWerE/Hhu9vMw1+hzn5FCgRLtcY7SRt+oZsGVXckk
         Cm2vA30MzEPNg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7DA6160176;
        Wed,  3 Nov 2021 05:38:47 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2838f567-ad44-ec1e-dc26-6205d78b0feb@linuxfoundation.org>
References: <2838f567-ad44-ec1e-dc26-6205d78b0feb@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2838f567-ad44-ec1e-dc26-6205d78b0feb@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.16-rc1
X-PR-Tracked-Commit-Id: 52a5d80a2225e2d0b2a8f4656b76aead2a443b2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 313b6ffc8e90173f1709b2f4bf9d30c4730a1dde
Message-Id: <163591792750.8140.13770670183997594561.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Nov 2021 05:38:47 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Tue, 2 Nov 2021 12:52:13 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/313b6ffc8e90173f1709b2f4bf9d30c4730a1dde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
