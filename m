Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE676AD3B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 02:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCGBEr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 20:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCGBEl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 20:04:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99BF43445
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 17:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678151037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DXzykjsiAcre19V+P05KPlN8nRLl9kRUfsGAPF8Sp98=;
        b=Ufi3i5t3/KubiGoPhezDjLsYwTYGwhfMjlXHQf1Kj6PM3ExIdlw7h10H/nwsaEr9M+vyBt
        G4gzU1Iflkjfngh9gDHmEnOgweLd57wrck4F9GEPag0LbIcM3+fWyRP7q3xyQn7aSmN2tv
        vOqyxS4K1T2N2Ny9uf6qV7jLT+5WPII=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-FA-oNyPXPNqXsILPGcMgmg-1; Mon, 06 Mar 2023 20:03:55 -0500
X-MC-Unique: FA-oNyPXPNqXsILPGcMgmg-1
Received: by mail-qt1-f200.google.com with SMTP id o10-20020a05622a138a00b003bfdabf3b89so6296909qtk.13
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Mar 2023 17:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678151035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXzykjsiAcre19V+P05KPlN8nRLl9kRUfsGAPF8Sp98=;
        b=5uJhDq1cEXHr0opHIh/piRkKTR5zgpGIWlHwV6J3u2BRkn6NJnJmpEssQZEFPqWqM4
         kpYOnkmiopHoRlpV+3VrcC1RzBZZI6udc9WXugQ64C0Jsgb3WY/V5UeVX9G73f+d5Zui
         6UFUIzTHfHnRmQjXYvW0SzOIYp1462UllIFjD0vCqPwE1mcXXJqP41O3uLkc7yyzGdHP
         hE8FTBniaMgF87peS3OBwDgBuG92tSRck4m/jHnavY/8zquuGUzh5cQgEMGdsPrEI4a+
         4cUOuwoGGRABsybiTygFAHRJcBMNAnreo1ISQxYjwY1zyFrq/46LE4KzPe/GrnA7oG53
         sWlQ==
X-Gm-Message-State: AO0yUKVTwRFe73xT7P7jdDXu84wZtS3pnY0/mAH6JVKIJhuK6eCd/yzE
        F/wRLu7Ck5idxZ3cnSSZuiKhqKkbS4D9Z6+6W90PviieFSKTRJWf6A8vmaCCr2+ZDkoYl43ZxDg
        Bds4MdAmAF6p2ALugyJdd8PKaY03B
X-Received: by 2002:ac8:5fc3:0:b0:3bf:f7d0:9ba9 with SMTP id k3-20020ac85fc3000000b003bff7d09ba9mr23995391qta.5.1678151035286;
        Mon, 06 Mar 2023 17:03:55 -0800 (PST)
X-Google-Smtp-Source: AK7set8wu0A4lbdw7SyIrbGqAwWxKod4tbGGXx84xCdHz+aQ0B1ZzeoTvLl7C6vRV8e75opvM1ftkA==
X-Received: by 2002:ac8:5fc3:0:b0:3bf:f7d0:9ba9 with SMTP id k3-20020ac85fc3000000b003bff7d09ba9mr23995363qta.5.1678151035048;
        Mon, 06 Mar 2023 17:03:55 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id 11-20020a37060b000000b00742663a2019sm8542044qkg.76.2023.03.06.17.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 17:03:54 -0800 (PST)
Date:   Mon, 6 Mar 2023 20:03:53 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/5] mm: userfaultfd: rename functions for clarity +
 consistency
Message-ID: <ZAaNeUT3tZwiVPat@x1n>
References: <20230306225024.264858-1-axelrasmussen@google.com>
 <20230306225024.264858-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306225024.264858-2-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 06, 2023 at 02:50:20PM -0800, Axel Rasmussen wrote:
> The basic problem is, over time we've added new userfaultfd ioctls, and
> we've refactored the code so functions which used to handle only one
> case are now re-used to deal with several cases. While this happened, we
> didn't bother to rename the functions.
> 
> Similarly, as we added new functions, we cargo-culted pieces of the
> now-inconsistent naming scheme, so those functions too ended up with
> names that don't make a lot of sense.
> 
> A key point here is, "copy" in most userfaultfd code refers specifically
> to UFFDIO_COPY, where we allocate a new page and copy its contents from
> userspace. There are many functions with "copy" in the name that don't
> actually do this (at least in some cases).
> 
> So, rename things into a consistent scheme. The high level idea is that
> the call stack for userfaultfd ioctls becomes:
> 
> userfaultfd_ioctl
>   -> userfaultfd_(particular ioctl)
>     -> mfill_atomic_(particular kind of fill operation)
>       -> mfill_atomic    /* loops over pages in range */
>         -> mfill_atomic_pte    /* deals with single pages */
>           -> mfill_atomic_pte_(particular kind of fill operation)
>             -> mfill_atomic_install_pte
> 
> There are of course some special cases (shmem, hugetlb), but this is the
> general structure which all function names now adhere to.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

