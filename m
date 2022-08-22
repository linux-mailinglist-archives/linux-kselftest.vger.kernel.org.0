Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E3359CB62
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 00:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiHVWVY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 18:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiHVWVX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 18:21:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824B84D26A;
        Mon, 22 Aug 2022 15:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A25F6134E;
        Mon, 22 Aug 2022 22:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ED8C433D6;
        Mon, 22 Aug 2022 22:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661206881;
        bh=5+dnYijmph9j6r03H83ENF5D6tCqRSMA7zXrvGscJRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y0ue13+62oMUgAjV9ILcmIWjJ5FwskKcbdYBwur2vKZDZoKkHxLRAJKvyfOsz+dV0
         74pW5JwXQXaPIb712dr/YhnST0oSv/xswDTRK3h/2XcaDedtlKB/veiDOwKmlL20EZ
         5FtdESRE0T6NFirhe6oY/KR/1TrxXyasW+gEPXVI=
Date:   Mon, 22 Aug 2022 15:21:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, peterx@redhat.com,
        jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH RESEND v2 2/2] mm: delete unused MMF_OOM_VICTIM flag
Message-Id: <20220822152119.96d40c884078229ee3e6b25e@linux-foundation.org>
In-Reply-To: <20220531223100.510392-2-surenb@google.com>
References: <20220531223100.510392-1-surenb@google.com>
        <20220531223100.510392-2-surenb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 31 May 2022 15:31:00 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> With the last usage of MMF_OOM_VICTIM in exit_mmap gone, this flag is
> now unused and can be removed.
> 
> ...
>
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -77,15 +77,6 @@ static inline bool tsk_is_oom_victim(struct task_struct * tsk)
>  	return tsk->signal->oom_mm;
>  }
>  
> -/*
> - * Use this helper if tsk->mm != mm and the victim mm needs a special
> - * handling. This is guaranteed to stay true after once set.
> - */
> -static inline bool mm_is_oom_victim(struct mm_struct *mm)
> -{
> -	return test_bit(MMF_OOM_VICTIM, &mm->flags);
> -}
> -

The patch "mm: multi-gen LRU: support page table walks" from the MGLRU
series
(https://lkml.kernel.org/r/20220815071332.627393-9-yuzhao@google.com)
adds two calls to mm_is_oom_victim(), so my build broke.

I assume the fix is simply

--- a/mm/vmscan.c~mm-delete-unused-mmf_oom_victim-flag-fix
+++ a/mm/vmscan.c
@@ -3429,9 +3429,6 @@ static bool should_skip_mm(struct mm_str
 	if (size < MIN_LRU_BATCH)
 		return true;
 
-	if (mm_is_oom_victim(mm))
-		return true;
-
 	return !mmget_not_zero(mm);
 }
 
@@ -4127,9 +4124,6 @@ restart:
 
 		walk_pmd_range(&val, addr, next, args);
 
-		if (mm_is_oom_victim(args->mm))
-			return 1;
-
 		/* a racy check to curtail the waiting time */
 		if (wq_has_sleeper(&walk->lruvec->mm_state.wait))
 			return 1;
_

Please confirm?
