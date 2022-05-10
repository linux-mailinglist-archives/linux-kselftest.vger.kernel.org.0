Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7DE522031
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346481AbiEJP6h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 11:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347774AbiEJP6D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 11:58:03 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE3050046
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 08:51:03 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z26so18946754iot.8
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WOUz2WsmdgX6LeN+LrF3txVAnT8hFkZ8ulMV7CFBOqM=;
        b=XTCkuhyrI12mXoibtavSh6cqwdk4FerubUN/RyfF6NFULIGnuGEkqPOOM8I2zwQ+o0
         Q6t7+QE88n3MP1KIW2iOswY+eCBI2ZUBLChS/bwADArGE4WFf2CAE10R0h7xDZu1KZTV
         gm2knkXa/E9lbuTqeJjwbg1h+Du01PqftXDYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WOUz2WsmdgX6LeN+LrF3txVAnT8hFkZ8ulMV7CFBOqM=;
        b=CsFqf+vFEh+tGDmCQd5YtxBsweAVVYFH3BXhu3+9JO52s/x8E8M29KOanBUV7kIWKZ
         vqKUBNHFFfCjSD4d1toxVV7wbCYTXPy2FTv0YGzOs2PIdwe41/RmwWGxYlOpCLfrxgSE
         kRchvBpCEsZWsYEeXx6/Azs86GlREdfRebPOTejzbBsZL3QUGB2MKSdn1LioFd1Of+4U
         mXWNDc/lmNtRtPnVTEtzGDzolFTe8jfBQQK/BsHLvJpa1DHbs83YlayW4Rthf1oqJ9rf
         hmmpk+vWRoafcfBkS/1ebePP8e+v3mmE3xutF8witoIMwEbT/Hq+q3ztHZgL3/51VT4T
         bfrw==
X-Gm-Message-State: AOAM531mMyBh9snD0SXkROqYHStd7qKkZqYDq1cPhmJ3Vq6HNOWvSeKo
        qalh7Ep+IB/9flcqWBXTwTKUGA==
X-Google-Smtp-Source: ABdhPJyKMFN44LVscpOAtyLyGGeKIRdp+9zY59CqwUYms2hhDMiEHT2+QMZC1z4qTekEb3cR4IgqdQ==
X-Received: by 2002:a02:aa94:0:b0:32a:e769:af1 with SMTP id u20-20020a02aa94000000b0032ae7690af1mr9721447jai.0.1652197862793;
        Tue, 10 May 2022 08:51:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cp20-20020a056638481400b0032b75b98013sm4455954jab.148.2022.05.10.08.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 08:51:02 -0700 (PDT)
Subject: Re: [PATCH 3/3] mm: delete unused MMF_OOM_VICTIM flag
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, peterx@redhat.com,
        jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220510030014.3842475-1-surenb@google.com>
 <20220510030014.3842475-3-surenb@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <008de890-7fe1-aeae-345e-0cd3fcd32352@linuxfoundation.org>
Date:   Tue, 10 May 2022 09:51:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220510030014.3842475-3-surenb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/9/22 9:00 PM, Suren Baghdasaryan wrote:
> With the last usage of MMF_OOM_VICTIM in exit_mmap gone, this flag is
> now unused and can be removed.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>   include/linux/oom.h            | 9 ---------
>   include/linux/sched/coredump.h | 1 -
>   mm/oom_kill.c                  | 4 +---
>   3 files changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 6cdf0772dbae..25990e9d9e15 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -77,15 +77,6 @@ static inline bool tsk_is_oom_victim(struct task_struct * tsk)
>   	return tsk->signal->oom_mm;
>   }
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
>   /*
>    * Checks whether a page fault on the given mm is still reliable.
>    * This is no longer true if the oom reaper started to reap the
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index 4d9e3a656875..746f6cb07a20 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -70,7 +70,6 @@ static inline int get_dumpable(struct mm_struct *mm)
>   #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
>   #define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
>   #define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
> -#define MMF_OOM_VICTIM		25	/* mm is the oom victim */
>   #define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
>   #define MMF_MULTIPROCESS	27	/* mm is shared between processes */
>   /*
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 36355b162727..11291b99599f 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -732,10 +732,8 @@ static void mark_oom_victim(struct task_struct *tsk)
>   		return;
>   
>   	/* oom_mm is bound to the signal struct life time. */
> -	if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm)) {
> +	if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm))
>   		mmgrab(tsk->signal->oom_mm);
> -		set_bit(MMF_OOM_VICTIM, &mm->flags);
> -	}
>   
>   	/*
>   	 * Make sure that the task is woken up from uninterruptible sleep
> 

Thank you for working on the new tests and cleanups.

This series needs a cover-letter that explains why this series is needed
that includes the information from this last patch.

Please send v2 with a proper cover letter starting with why this series
is necessary. If you did that, it would have reviewers job is lot easier.

Also it appears you are combining new tests with cleanup patches. I think
patches 2/3 and 3/3 can be a separate series and the new test can be a
separate patch.

thanks,
-- Shuah
