Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBAC5A4772
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 12:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiH2Kp2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 06:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiH2Kp1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 06:45:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B81AD99;
        Mon, 29 Aug 2022 03:45:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 00D2D21AEF;
        Mon, 29 Aug 2022 10:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661769925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LDkt1HM7O2vv+7snReLnfVNzSWfCCrT2+rmvr+iyOUs=;
        b=rEwBVkQJETkWFa7ePfs3KRQRNk7ilQ8FeL1Yv0AjYCq1PoPlqrlp8Q6GqzYu7VcFsvxY8X
        3EVoSiEkbNwebWgVm0qpGUTicZAcMqwRPdtVROJ5498fxkQtmoXERv94OEvoJBB8JCD7h9
        EHjFAEBAXxeEx1qEweb7sJmw/Xdk7jI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCA99133A6;
        Mon, 29 Aug 2022 10:45:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Xa2ML8SYDGPsSwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 29 Aug 2022 10:45:24 +0000
Date:   Mon, 29 Aug 2022 12:45:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>, brauner@kernel.org,
        Christoph Hellwig <hch@infradead.org>, oleg@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, shuah@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH RESEND v2 2/2] mm: delete unused MMF_OOM_VICTIM flag
Message-ID: <YwyYwxVOv0p736gf@dhcp22.suse.cz>
References: <20220531223100.510392-2-surenb@google.com>
 <20220822152119.96d40c884078229ee3e6b25e@linux-foundation.org>
 <CAOUHufbysRjhX_AiFirjvWCR129t4_bELd1wFQG+fBsZpzhgYw@mail.gmail.com>
 <20220822154822.366a9e4527b748cf99d98637@linux-foundation.org>
 <CAOUHufa1zc3fMWsyyz1uB6_gsgVPk1Hw_T31WzWK58QVgsQSAQ@mail.gmail.com>
 <20220822161603.9e19edfe2daaea3bf591910a@linux-foundation.org>
 <CAOUHufbyWwkOAJTD4G82sLcwE_33Yy=s4Q+gGBujwXvEBZ8iqA@mail.gmail.com>
 <YwSRf3LZ7gXwWaNN@dhcp22.suse.cz>
 <CAOUHufbauOoXshmfbBYAnPVYkrZ=jFA2wpPotXNnOjoWVRa5qQ@mail.gmail.com>
 <YwyXhH6k1JVgKBVl@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwyXhH6k1JVgKBVl@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 29-08-22 12:40:05, Michal Hocko wrote:
> On Sun 28-08-22 13:50:09, Yu Zhao wrote:
> > On Tue, Aug 23, 2022 at 2:36 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > You cannot really make any
> > > assumptions about oom_reaper and how quickly it is going to free the
> > > memory.
> > 
> > Agreed. But here we are talking about heuristics, not dependencies on
> > certain behaviors. Assume we are playing a guessing game: there are
> > multiple mm_structs available for reclaim, would the oom-killed ones
> > be more profitable on average? I'd say no, because I assume it's more
> > likely than unlikely that the oom reaper is doing/to do its work. Note
> > that the assumption is about likelihood, hence arguably valid.
> 
> Well, my main counter argument would be that we do not really want to
> carve last resort mechanism (which the oom reaper is) into any heuristic
> because any future changes into that mechanism will be much harder to
> justify and change. There is a cost of the maintenance that should be
> considered. While you might be right that this change would be
> beneficial, there is no actual proof of that. Historically we've had
> several examples of such a behavior which was really hard to change
> later on because the effect would be really hard to evaluate.

Forgot to mention the recent change as a clear example of the change
which would be have a higher burden to evaluate. e4a38402c36e
("oom_kill.c: futex: delay the OOM reaper to allow time for proper futex
cleanup") has changed the wake up logic to be triggered after a timeout.
This means that the task will be sitting there on the queue without any
actual reclaim done on it. The timeout itself can be changed in the
future and I would really hate to argue that changeing it from $FOO to
$FOO + epsilon breaks a very subtle dependency somewhere deep in the
reclaim path. From the oom reaper POV any timeout is reasonable becaude
this is the _last_ resort to resolve OOM stall/deadlock when the victim
cannot exit on its own for whatever reason. This is a considerably
different objective from "we want to optimize which taks to scan to
reclaim efficiently".

See my point?
-- 
Michal Hocko
SUSE Labs
