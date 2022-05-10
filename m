Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB3F52166D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 15:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241498AbiEJNMp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 09:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiEJNMo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 09:12:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CADB53B4B;
        Tue, 10 May 2022 06:08:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 135981F8C6;
        Tue, 10 May 2022 13:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652188126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xlPWteioqpYFvjBcQYKo/BjcXYvQ08uXCEUWe/iKqPY=;
        b=TuCts4P+EE3p3zrQm1PgFJRWle2LN4YZoD/6JoUp3GDg63Afgh7ym4cx60kFrRSy/CWLuS
        CKcpXUOOWehKX5RakYb0xHGPRJyO681F/AMagaFzy66vJq5oq34A9a1hUYuCtw42CKatIJ
        JMzaCRhLpyX9bP97aNysVdCxuJhMVqc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C66D62C141;
        Tue, 10 May 2022 13:08:45 +0000 (UTC)
Date:   Tue, 10 May 2022 15:08:45 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        minchan@kernel.org, kirill@shutemov.name, aarcange@redhat.com,
        brauner@kernel.org, hch@infradead.org, oleg@redhat.com,
        david@redhat.com, jannh@google.com, shakeelb@google.com,
        peterx@redhat.com, jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 3/3] mm: delete unused MMF_OOM_VICTIM flag
Message-ID: <Ynpj3TsPcWVL7K7F@dhcp22.suse.cz>
References: <20220510030014.3842475-1-surenb@google.com>
 <20220510030014.3842475-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510030014.3842475-3-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 09-05-22 20:00:14, Suren Baghdasaryan wrote:
> With the last usage of MMF_OOM_VICTIM in exit_mmap gone, this flag is
> now unused and can be removed.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

LGTM
Acked-by: Michal Hocko <mhocko@suse.com>

One question below
[...]
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index 4d9e3a656875..746f6cb07a20 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -70,7 +70,6 @@ static inline int get_dumpable(struct mm_struct *mm)
>  #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
>  #define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
>  #define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
> -#define MMF_OOM_VICTIM		25	/* mm is the oom victim */
>  #define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
>  #define MMF_MULTIPROCESS	27	/* mm is shared between processes */

Have you consider renumbering the follow up flags so that we do not have
holes in there. Nothing really important but it can confuse somebody in
the future.

-- 
Michal Hocko
SUSE Labs
