Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C8C521FCC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 17:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346563AbiEJPwf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 11:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346851AbiEJPv3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 11:51:29 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C224EDC0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 08:46:07 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id e15so18963722iob.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kyl/wivTrFtPE41gkY/L5cOUv62hj2SZY3x+GcpTBNg=;
        b=ca3YiJYkxZX7krw3V695xqWag5GOtKgTt5fmu92BI88s8OOCL7Loe/wVCLlcMB39BE
         LHdzbYTq/QhReb+zXLjqTIVHKtnGmNf6Gz1koJ7VcP1CeVF+N3zb/CDXDlSldcHRsTdO
         vZHFU5pSEbwoyG3LN4OQo+N9+KLXs2qcNtJeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kyl/wivTrFtPE41gkY/L5cOUv62hj2SZY3x+GcpTBNg=;
        b=arN6nnURDxrUczNlxRaSf1gxuUaSKyM1eq2E9GU0pRnQt7D277rZZkoePV7Dvyo07A
         PSiAYrqaAMWPezzYB5XBB6VvqYm3op+/N1CSa9GGUrn4B3FOO6yUUA4WT0i1CY0+IgpH
         hDjNQTuza+97YZU27MGmtqR4DMnumu6fzimDHUDb9wvuQjkGLfn6fbdLJn5tpqgDjX/S
         h9FsSWernkerZxHSHs2FtpERwwSQAMl9Lo8RqUlU30lUEcx4iuh9KHlLUPdTymgiFz6Y
         AWi8xTqtb64lBtSsgJxIanOnMP7NM7tkmyJpyyJX2+2Z6+gWdDruNX/t59cBxBvJStax
         I+FA==
X-Gm-Message-State: AOAM532nnfkH5EO41xgu+T9y2k7mGesZLmKuoQpYbPzcJiO47f2NE3bu
        OduU3ofAhcGBhd+BlOh65GXiuA==
X-Google-Smtp-Source: ABdhPJwqQ5V3k73w7aeJhYBKjEM71dQ/SINE7A8esskHt5ZTj6KvE99TN85ULCDZUoO+8WrRJnVmSQ==
X-Received: by 2002:a02:8605:0:b0:32b:1dd7:fc31 with SMTP id e5-20020a028605000000b0032b1dd7fc31mr9692144jai.174.1652197566839;
        Tue, 10 May 2022 08:46:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d6-20020a05663802a600b0032b3a78177csm4436324jaq.64.2022.05.10.08.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 08:46:06 -0700 (PDT)
Subject: Re: [PATCH 2/3] mm: drop oom code from exit_mmap
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
 <20220510030014.3842475-2-surenb@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3e847a15-e8c0-41fd-9518-2ae3d4a39092@linuxfoundation.org>
Date:   Tue, 10 May 2022 09:46:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220510030014.3842475-2-surenb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/9/22 9:00 PM, Suren Baghdasaryan wrote:
> With the oom-killer being able to operate on locked pages, exit_mmap
> does not need to ensure that oom_reap_task_mm is done before it can
> proceed. Instead it can rely on mmap_lock write lock to prevent
> oom-killer from operating on the vma tree while it's freeing page
> tables. exit_mmap can hold mmap_lock read lock when unmapping vmas
> and then take mmap_lock write lock before freeing page tables.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>   include/linux/oom.h |  2 --
>   mm/mmap.c           | 25 ++++++-------------------
>   mm/oom_kill.c       |  2 +-
>   3 files changed, 7 insertions(+), 22 deletions(-)
> 

How does this improve the test? Include the information on why this
change is needed as opposed describing what this does?

thanks,
-- Shuah
