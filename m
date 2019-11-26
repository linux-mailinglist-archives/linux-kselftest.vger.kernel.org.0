Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 168531097BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 03:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfKZCPi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 21:15:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfKZCPH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 21:15:07 -0500
Subject: Re: [GIT PULL] kselftest kunit update for Linux 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574734506;
        bh=wtE77hz7XaQGdo6/XrWXFInsy28E6omol7wveMwM4pk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=E5oLpJIT7vyEiXH5RXBkg7QuM8rbDuM/mdySaU8LV4WwRyJZG4Kig19DSBepgJ15V
         c3k9aG/6OCt3hhLHVLwzSa/E/KnEOzxGW/Xdny1T7ij09fk1DvgzH9U9//ZrXL+164
         5p7tm4EFVPM8ifDvCjMz8NCNnOq7XLtJB5cRM8FQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0d518aea-63f4-507d-af4b-30536c156479@linuxfoundation.org>
References: <0d518aea-63f4-507d-af4b-30536c156479@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0d518aea-63f4-507d-af4b-30536c156479@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.5-rc1-kunit
X-PR-Tracked-Commit-Id: ea2dd7c0875ed31955cda7b1b20612c8337192e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e25645b181ae67753f9a48e11bb5b34dcf41187d
Message-Id: <157473450646.11733.17128731630611051270.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 02:15:06 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 22 Nov 2019 21:46:50 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.5-rc1-kunit

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e25645b181ae67753f9a48e11bb5b34dcf41187d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
