Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93A86AD3C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 02:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCGBVC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 20:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCGBU4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 20:20:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C3836694
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 17:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678152001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qrw2gr+qx7DWb3UAvdR/mcFIQhqsDgcX3EEuLph/d4=;
        b=ZLR2Y2ak5hNlagTc7qGOvm/x2j/tVyFlfo1AXDRA7XW3ki6UapNgduRb3zqLh8VPYe3ijM
        QgFeSUMthufGxkFDs7gXehYNZq7q1dBLrf+jdvNQ1HPsDGmpKR9NWcxlrPxQeVKWQXuabE
        eIi+i8GU6K/QOCt5NWEkSM9zRnbZr6w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-NunLwPuvNrClpIvMzo4fiQ-1; Mon, 06 Mar 2023 20:19:59 -0500
X-MC-Unique: NunLwPuvNrClpIvMzo4fiQ-1
Received: by mail-qv1-f72.google.com with SMTP id pm17-20020ad446d1000000b0057256b237b9so6609328qvb.16
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Mar 2023 17:19:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678151999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qrw2gr+qx7DWb3UAvdR/mcFIQhqsDgcX3EEuLph/d4=;
        b=ZXPYMhkIT9pzYIeGvDkpbX13kMaPzky68oSwNRe+3ghssbU+9rY9QHNDyWgadyMN49
         /dLNX1bENf71JV64WIntRxCCfpQM79oLyyjw3ZjYExFnouvQ+t92aB1VHK3kPxRr60FP
         3brHcypcuRqLrjiJjKto42T6+EkmcreCmFtHMS62biokknV5FYKs0MCDbQLgEbc2EcHY
         eUYmPin3dA21q4Pm9GYvmNQF4nTibYMpj7CRNMh5GXNOZzgHoJX1N42EJIXBnJ8z+2rV
         sZ9IKnDpzwUWG3xnpw6dpjAhZBVWPCbz3GKba2/vRiFNspsORuo6y1rxnWqxUM5f7M5M
         oUGQ==
X-Gm-Message-State: AO0yUKXDAd6hOha5/QGH32ShjRa27IGNCx5f8v62qY9Dz/fL2vROCmOs
        NXaKobU+P2xNq2zllLm3ZnH40scFFpXEjr0bM1eFYTAuKZTehjHPc51q9HTPhS7ozTgFNMPOU6O
        7xMTkRlt/5W4JzZcrugmuUXYCMzZy
X-Received: by 2002:ac8:7d12:0:b0:3bf:d71e:5b08 with SMTP id g18-20020ac87d12000000b003bfd71e5b08mr25643233qtb.3.1678151999080;
        Mon, 06 Mar 2023 17:19:59 -0800 (PST)
X-Google-Smtp-Source: AK7set+YPHN/ncr0Du5Ek2aNycnO04K6K6elfomWX85YMAJoHPLqYfwEiEIk3YRAWh/HHoBKpUm+sw==
X-Received: by 2002:ac8:7d12:0:b0:3bf:d71e:5b08 with SMTP id g18-20020ac87d12000000b003bfd71e5b08mr25643186qtb.3.1678151998762;
        Mon, 06 Mar 2023 17:19:58 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id j11-20020a05622a038b00b003bd0f0b26b0sm8855311qtx.77.2023.03.06.17.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 17:19:58 -0800 (PST)
Date:   Mon, 6 Mar 2023 20:19:56 -0500
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
Subject: Re: [PATCH v3 4/5] mm: userfaultfd: don't separate addr + len
 arguments
Message-ID: <ZAaRPCntR94hGBL2@x1n>
References: <20230306225024.264858-1-axelrasmussen@google.com>
 <20230306225024.264858-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306225024.264858-5-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 06, 2023 at 02:50:23PM -0800, Axel Rasmussen wrote:
> We have a lot of functions which take an address + length pair,
> currently passed as separate arguments. However, in our userspace API we
> already have struct uffdio_range, which is exactly this pair, and this
> is what we get from userspace when ioctls are called.
> 
> Instead of splitting the struct up into two separate arguments, just
> plumb the struct through to the functions which use it (once we get to
> the mfill_atomic_pte level, we're dealing with single (huge)pages, so we
> don't need both parts).
> 
> Relatedly, for waking, just re-use this existing structure instead of
> defining a new "struct uffdio_wake_range".
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  fs/userfaultfd.c              | 107 +++++++++++++---------------------
>  include/linux/userfaultfd_k.h |  17 +++---
>  mm/userfaultfd.c              |  92 ++++++++++++++---------------
>  3 files changed, 96 insertions(+), 120 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index b8e328123b71..984b63b0fc75 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -95,11 +95,6 @@ struct userfaultfd_wait_queue {
>  	bool waken;
>  };
>  
> -struct userfaultfd_wake_range {
> -	unsigned long start;
> -	unsigned long len;
> -};

Would there still be a difference on e.g. 32 bits systems?

[...]

>  static __always_inline int validate_range(struct mm_struct *mm,
> -					  __u64 start, __u64 len)
> +					  const struct uffdio_range *range)
>  {
>  	__u64 task_size = mm->task_size;
>  
> -	if (start & ~PAGE_MASK)
> +	if (range->start & ~PAGE_MASK)
>  		return -EINVAL;
> -	if (len & ~PAGE_MASK)
> +	if (range->len & ~PAGE_MASK)
>  		return -EINVAL;
> -	if (!len)
> +	if (!range->len)
>  		return -EINVAL;
> -	if (start < mmap_min_addr)
> +	if (range->start < mmap_min_addr)
>  		return -EINVAL;
> -	if (start >= task_size)
> +	if (range->start >= task_size)
>  		return -EINVAL;
> -	if (len > task_size - start)
> +	if (range->len > task_size - range->start)
>  		return -EINVAL;
>  	return 0;
>  }

Personally I don't like a lot on such a change. :( It avoids one parameter
being passed over but it can add a lot indirections.

Do you strongly suggest this?  Shall we move on without this so to not
block the last patch (which I assume is the one you're looking for)?

Thanks,

-- 
Peter Xu

