Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F5FBFA78
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 22:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfIZUK0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 16:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728793AbfIZUK0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 16:10:26 -0400
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569528626;
        bh=iSojXQKpnvd/5Lcou9mG4PGqSh4IsNSxoQH2spGYr1s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qdfg7sDmH9wzKhWvklGVBWGjF2SdgRWfHT5crmXm3V9uL4d7UNVO1EjSWeRxzn91N
         9eau7kDfzUA1e+YGbCRQF+jjDx4diFHFfUa54wVGP135ms5fNqkGL9fm+51gGcUMja
         Z+oHc6NiLr6i7hDh/qSVwkMXq4H1vOALx5YRJVsw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <47009c0c-9b64-5824-0c1c-8cdc1a2265de@linuxfoundation.org>
References: <47009c0c-9b64-5824-0c1c-8cdc1a2265de@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <47009c0c-9b64-5824-0c1c-8cdc1a2265de@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.4-rc1.1
X-PR-Tracked-Commit-Id: 721cb3c8bc8890e824b7be53bf951960ff7811f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 797a3242755da1b7c1ada6fb153cb2700ef30a80
Message-Id: <156952862613.24871.2602067850286581209.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Sep 2019 20:10:26 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 23 Sep 2019 16:40:15 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.4-rc1.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/797a3242755da1b7c1ada6fb153cb2700ef30a80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
