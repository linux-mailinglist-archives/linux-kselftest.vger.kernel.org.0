Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E2A5A475C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 12:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiH2KkN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 06:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiH2KkK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 06:40:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BF76389;
        Mon, 29 Aug 2022 03:40:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5652233681;
        Mon, 29 Aug 2022 10:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661769605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YyrUyc//S6lyu1GkaA3SvkFVh044FLWZiRnNfMaJfiQ=;
        b=sealo4JgszYzk3Q2SF7jDXyb+wUABg85KYwx49/EUGKvkBaXX/kTf9TlfzGXDN+Mu5ulPn
        ZURHB3vlh8kKMdn4Y1jckgKOOqFh2+/xM4JaQVl79/OQrNHxgVezqk+h2rceWlN/QWiB8Q
        sucYahKq9QPP3O6pIx7HJFlTcccMynI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32DCF133A6;
        Mon, 29 Aug 2022 10:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uxstCoWXDGO7SQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 29 Aug 2022 10:40:05 +0000
Date:   Mon, 29 Aug 2022 12:40:04 +0200
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
Message-ID: <YwyXhH6k1JVgKBVl@dhcp22.suse.cz>
References: <20220531223100.510392-1-surenb@google.com>
 <20220531223100.510392-2-surenb@google.com>
 <20220822152119.96d40c884078229ee3e6b25e@linux-foundation.org>
 <CAOUHufbysRjhX_AiFirjvWCR129t4_bELd1wFQG+fBsZpzhgYw@mail.gmail.com>
 <20220822154822.366a9e4527b748cf99d98637@linux-foundation.org>
 <CAOUHufa1zc3fMWsyyz1uB6_gsgVPk1Hw_T31WzWK58QVgsQSAQ@mail.gmail.com>
 <20220822161603.9e19edfe2daaea3bf591910a@linux-foundation.org>
 <CAOUHufbyWwkOAJTD4G82sLcwE_33Yy=s4Q+gGBujwXvEBZ8iqA@mail.gmail.com>
 <YwSRf3LZ7gXwWaNN@dhcp22.suse.cz>
 <CAOUHufbauOoXshmfbBYAnPVYkrZ=jFA2wpPotXNnOjoWVRa5qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufbauOoXshmfbBYAnPVYkrZ=jFA2wpPotXNnOjoWVRa5qQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun 28-08-22 13:50:09, Yu Zhao wrote:
> On Tue, Aug 23, 2022 at 2:36 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > You cannot really make any
> > assumptions about oom_reaper and how quickly it is going to free the
> > memory.
> 
> Agreed. But here we are talking about heuristics, not dependencies on
> certain behaviors. Assume we are playing a guessing game: there are
> multiple mm_structs available for reclaim, would the oom-killed ones
> be more profitable on average? I'd say no, because I assume it's more
> likely than unlikely that the oom reaper is doing/to do its work. Note
> that the assumption is about likelihood, hence arguably valid.

Well, my main counter argument would be that we do not really want to
carve last resort mechanism (which the oom reaper is) into any heuristic
because any future changes into that mechanism will be much harder to
justify and change. There is a cost of the maintenance that should be
considered. While you might be right that this change would be
beneficial, there is no actual proof of that. Historically we've had
several examples of such a behavior which was really hard to change
later on because the effect would be really hard to evaluate.

-- 
Michal Hocko
SUSE Labs
