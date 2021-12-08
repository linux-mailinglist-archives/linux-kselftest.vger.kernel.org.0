Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB89246D3A1
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 13:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhLHMxS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 07:53:18 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45616 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhLHMxR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 07:53:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1A485CE2166;
        Wed,  8 Dec 2021 12:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7392C00446;
        Wed,  8 Dec 2021 12:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638967782;
        bh=cdtsQhmjW17y2geFF7A/kvKYIuPdnZxMxM9EFG7yPek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=GKefE0FJlSp09ATc7OSSkIA/FF/j8dXFkQD7p77lR93lXODMt/xcedN/CN5rwBSo7
         KrFxFxmPv41A2oLhmQwIbCyyQWo2kz+pk7wMzQKcEyXPt6M035oKWw/Tc5TOxx3tqu
         gD7icFTsIa8NhzkcryC8/CPzl3SzMXs9QdrzZbjibuQkJwnPD3rNMLsUr7VSAN3feX
         cCCpXdrw0Iuu2+fXw296pcgRQywppatJX0N7a3U40yt2wlSjEMZiZ2y0SqbO0X7/DO
         YTanpn1vlhMi7LrePtB5J7TPHbd/K4TnvZij+bCdLJoEwU2gtwUqNBlf02K7wI92d4
         veagj6Hnd25Hw==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        shuah@kernel.org, brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] mm/damon/dbgfs: Remove an unnecessary error message
Date:   Wed,  8 Dec 2021 12:49:38 +0000
Message-Id: <20211208124938.4035-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <71535f68-4086-45df-2d4b-36a1802c9475@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 8 Dec 2021 14:29:40 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

Hi Xin,

> 
> Hi park:
> 
> On 12/1/21 11:04 PM, SeongJae Park wrote:
> > When wrong scheme action is requested via the debugfs interface, DAMON
> > prints an error message.  Because the function returns error code, this
> > is not really needed.  Because the code path is triggered by the user
> > specified input, this can result in kernel log mistakenly being messy.
> 
> Completely correct, but there will also be a problem that users can’t 
> quickly locate where the problem is,
> 
> Especially too many parameters need to be written into the interface.
> 
> I think it is necessary to add some debugging methods to help users find 
> the error without polluting the kernel log.
> 
> And i have an idea, like this:
> 
> in dbgfs, add a last_cmd_stat interface.
> 
>      # echo "1 2 1 2 1 2  1 2 1 2 100 ..."  > schemes
> 
>      #  cat last_cmd_stat
> 
>      #  wrong action 100
> 
> In this way, on the one hand, it will not pollute the kernel log, on the 
> other hand, it will help users find  the cause of the operation 
> interface error.
> 
> Park, how do you think of about this idea, if ok, i will send a patch.

Thank you always for your great suggestions and efforts!  BTW, I prefer to be
called with my first name ;)

I want DAMON kernel code to be as simple and small as possible, while putting
fancy but complicated features for user conveniences in user space tools like
DAMO[1].  In other words, I hope the DAMON debugfs interface to be used as an
interface for such user space tools, not an interface for human hands.

IMHO, implementing the feature you proposed in the kernel could make the code
slightly bigger, while it can easily implemented in user space.  I therefore
think the feature would be better to be implemented in user space.  If you
could send a pull request of the feature for DAMO, it would be so great.

[1] https://github.com/awslabs/damo


Thanks,
SJ

> 
> > To avoid the case, this commit removes the message
> >
> > Fixes: af122dd8f3c0 ("mm/damon/dbgfs: support DAMON-based Operation Schemes")
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >   mm/damon/dbgfs.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> > index 4bf4204444ab..5b628990ae6e 100644
> > --- a/mm/damon/dbgfs.c
> > +++ b/mm/damon/dbgfs.c
> > @@ -210,10 +210,8 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
> >   				&wmarks.low, &parsed);
> >   		if (ret != 18)
> >   			break;
> > -		if (!damos_action_valid(action)) {
> > -			pr_err("wrong action %d\n", action);
> > +		if (!damos_action_valid(action))
> >   			goto fail;
> > -		}
> >   
> >   		if (min_sz > max_sz || min_nr_a > max_nr_a || min_age > max_age)
> >   			goto fail;
> 
> -- 
> Best Regards!
> Xin Hao
> 
