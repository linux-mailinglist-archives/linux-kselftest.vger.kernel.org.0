Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04A23F22E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 00:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhHSWRz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 18:17:55 -0400
Received: from smtprelay0017.hostedemail.com ([216.40.44.17]:36608 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235852AbhHSWRy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 18:17:54 -0400
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6794025F3A;
        Thu, 19 Aug 2021 22:17:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 21E1D255104;
        Thu, 19 Aug 2021 22:17:16 +0000 (UTC)
Message-ID: <ac2587d3d4b7ce87e8922380e36d7864bfb54262.camel@perches.com>
Subject: Re: [RFC PATCH 1/5] checkpatch: improve handling of revert commits
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jkosina@suse.cz>,
        Willy Tarreau <w@1wt.eu>
Date:   Thu, 19 Aug 2021 15:17:15 -0700
In-Reply-To: <c31b2007-26a9-34e0-8c9a-8e11a00ce69f@linux.com>
References: <20210818154646.925351-1-efremov@linux.com>
         <20210818154646.925351-2-efremov@linux.com>
         <cc5801790fea258e20fa6b7e26de7806ae8e0dda.camel@perches.com>
         <3d347d4b-1576-754f-8633-ba6084cc0661@linux.com>
         <23c8ebaa0921d5597df9fc1d6cbbcc4f354f80c5.camel@perches.com>
         <c31b2007-26a9-34e0-8c9a-8e11a00ce69f@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: skshep1bqut9k49n7cu9y6o5pd3jjqfi
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 21E1D255104
X-Spam-Status: No, score=0.10
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18xeMNU5Xm3A6JVpFd9ED1ZFoW48dmRWWo=
X-HE-Tag: 1629411436-234901
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2021-08-19 at 22:52 +0300, Denis Efremov wrote:
> Hi,


> 
> Why do you want to add "if ($orig_desc =~ /^".*"$/);" here? and not just substr($orig_desc, 2, -2);?

Because commit descriptions sometimes to not have quotes like

commit <deadbeef> (Multiple word description)

btw:

I tested the last proposal with this script:

$ git log --grep="commit [0-9a-f]" -i --format=%h -1000 | \
  while read commit ; do \
    echo $commit; \
    ./scripts/checkpatch.pl --git --no-summary --quiet --types=GIT_COMMIT_ID $commit ; \
  done

and there are still a fair number of ERRORs.

And I'm not sure if this particular ERROR is that useful overall.

