Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C1E467EEA
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 21:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245055AbhLCUsA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 15:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbhLCUsA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 15:48:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3937C061751;
        Fri,  3 Dec 2021 12:44:35 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04710B82949;
        Fri,  3 Dec 2021 20:44:34 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BC0F60E0C;
        Fri,  3 Dec 2021 20:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638564272;
        bh=xlny09940e6Z3BkMmLz5Nzw7SvRddCWfs0zmtslxYGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BbYF/l5Ma6YhWbIH8kIPgBrhESjTUAyDktuYhS5yM+4agmxI2I4NLUGfKdbOwzMf7
         I7G3GMyKJOrnLaA+qv4EA3X1PFehZXZnfozkf46TLWsbMpCXuDgwso65ugqfExtBT1
         vvUhRrVslz35Cxmn8vVshWXxRoG48muoMPa+TbFs=
Date:   Fri, 3 Dec 2021 12:44:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        brendanhiggins@google.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/11] mm/damon/vaddr: Remove an unnecessary warning
 message
Message-Id: <20211203124430.bd1879d382010270f4112324@linux-foundation.org>
In-Reply-To: <CAMZfGtUPSmquyMd70HtqFVvxU68kbTdYN1fJU8g35zeXHMJHVA@mail.gmail.com>
References: <20211201150440.1088-1-sj@kernel.org>
        <20211201150440.1088-5-sj@kernel.org>
        <CAMZfGtUPSmquyMd70HtqFVvxU68kbTdYN1fJU8g35zeXHMJHVA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 3 Dec 2021 11:01:36 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> On Wed, Dec 1, 2021 at 11:05 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > The DAMON virtual address space monitoring primitive prints a warning
> > message for wrong DAMOS action.  However, it is not essential as the
> > code returns appropriate failure in the case.  This commit removes the
> > message to make the log clean.
> >
> > Fixes: 6dea8add4d28 ("mm/damon/vaddr: support DAMON-based Operation Schemes")
> 
> I don't think there should be a Fixes tag since it's not a serious bug.

"Fixes:" doesn't mean "backport to stable".  At least, not for MM
patches.  Other subsystems do get their Fixes:-tagged patches
automatically backported.

