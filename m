Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302B64A7197
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 14:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiBBNch (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 08:32:37 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57642 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiBBNcg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 08:32:36 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 9916E1F4459C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643808755;
        bh=itrri+xresWOD9wIBg0EiwvvsJKxEyhEpv0hS7QNFeI=;
        h=Date:To:Cc:From:Subject:From;
        b=UM3XKm6Gi0hGCd5eFhRcCp3L4CEbSIPf4nPxxWwoH0pVgDDgMGtWsV0pDal0hQrOn
         BWJvOqsToB24U7dOgQdeSNYiBXZPUgKvR6PP0l0qkv0TpHf3cb2y73jXzq7QEm+wJS
         AW/KgGGCWWiq4yryMuUwSZP+FIQ0BQqlS+0mlZqf5mQ4/zS/bACVHTJMtgpQuthiQw
         cRYGFr66Noz8R2nxjHjJSvkUfczT9xOuHle7lZFC+FPOM/QhaPKUxfOfspcDQiYwx6
         XMFhfj+kQQX6OvkdUaZ5yHThKyPqzUJAc4Q61+Jst+2E844wCRh1aP/BPfB+5ea7yJ
         +l8HJy4aKR5PQ==
Message-ID: <5fd1a35c-f84e-1c6a-4a3a-be76dda97ca3@collabora.com>
Date:   Wed, 2 Feb 2022 13:32:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        "kernelci@groups.io" <kernelci@groups.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: kselftest tree on kernelci.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

I've made this PR to start monitoring the "fixes" branch from the
kselftest tree on kernelci.org:

  https://github.com/kernelci/kernelci-core/pull/998

While kselftest changes eventually land in linux-next, monitoring
your tree directly means we can test it earlier and potentially
enable more build variants or experimental tests.  Since
kernelci.org also builds and runs some kselftests we're regularly
finding issues and people are sending fixes for them.  See this
recent story for example:

  https://twitter.com/kernelci/status/1488831497259921409

Keeping an eye on kselftest patches with kernelci.org means we
can verify that fixes do what they're supposed to do with a much
larger test coverage than what individual developers can do.
We've been applying kselftest fixes on a branch managed by
kernelci.org to verify them in the past, but having the actual
kselftest tree part of the workflow would seem much better.

There are several branches in your tree, while "fixes" seemed
like the most useful one to pick I see there is also a "kernelci"
branch too but it hasn't been updated for a while, reviving it
could give you the possibility to test patches through
kernelci.org before applying them on other branches that get
pulled into linux-next and mainline.

Many things could potentially be done with arbitrary builds and
tests etc.  These are some initial suggestions.  How does this
sound?

Best wishes,
Guillaume
