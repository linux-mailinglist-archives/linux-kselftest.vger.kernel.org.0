Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CAE7C7936
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 00:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbjJLWC1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 18:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjJLWC0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 18:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A68D9
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Oct 2023 15:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697148103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jO+V0kCCN2H4fTh8SDF52Bqu9Ca+4ziotGTsqK4FPs0=;
        b=XET1i8kX+DmJrIqQJY+sbhBmd437aBIsvwPEKCMJYsEUTaJflmGEcXiThnxJiZP16g4o3m
        zQWDWHpJQhjTRn2cKwM80sKpOzc5h8h++Y3jQkAP1l9Ds2LbkHVyET/jvRvV/rQCQLucxJ
        Kimzf7BMDFPAHDI1fyA3vTcJHerz9UI=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-zLYzIXfSOAiGzn8bef46pg-1; Thu, 12 Oct 2023 18:01:41 -0400
X-MC-Unique: zLYzIXfSOAiGzn8bef46pg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3ae2377058bso292712b6e.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Oct 2023 15:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697148101; x=1697752901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jO+V0kCCN2H4fTh8SDF52Bqu9Ca+4ziotGTsqK4FPs0=;
        b=K+V79AuSgEjhaJWmKhpXWoa4KI23D8By3Vm81ehS92KdPVCf/XXXK4aDOWCgOfq2kG
         Ffxj6EyUuLYQnSh+81KKNYcBImbkFBkh1/wcUhhWyGItC9wzW8srs8Y77BCv8vOtzta+
         mg6dfvO/coKySQHfLEEMSDbB4sNRoN5hGhSisc28TvXyFulHVvT3Xw1V5MlSYTCJKbm2
         1xaeKuOMnYjvV6gbyXJEeZTDrnjUSdaebYzoGyKs6wizAymk7EAQk5fmEaXgspIevYg6
         CPMgEBJ5Pn3YkgWx4uhNmT5dzvujpVAdy0Di3CfsyLgOcP8U7YFlXRRP8f7rRz+M8ZqI
         7r1w==
X-Gm-Message-State: AOJu0YwDJlSVjgTq9dd5cGUJi+rK0IvuAXM/cFfH5e0UMRt3OJz4/VQ7
        OSC3uGtnCg8RWtg05IODB8bWxk2cEWvnWrazdBf/92kGdxQl9MWsc30J+KPViItuv1G7M1rpUJU
        Lf0nW4W/RzwtYElHOU0uRo9pDgISQ
X-Received: by 2002:a05:6808:2087:b0:3b2:9c2f:50e0 with SMTP id s7-20020a056808208700b003b29c2f50e0mr7037854oiw.5.1697148101019;
        Thu, 12 Oct 2023 15:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxqOd0z9Rrm05kMUw7f1NwIqG2E5WysntGtAunm/GI19UXZNOiR7r13fJ46GNQ81YF0h/Yjg==
X-Received: by 2002:a05:6808:2087:b0:3b2:9c2f:50e0 with SMTP id s7-20020a056808208700b003b29c2f50e0mr7037819oiw.5.1697148100725;
        Thu, 12 Oct 2023 15:01:40 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p4-20020ac84604000000b004181234dd1dsm106401qtn.96.2023.10.12.15.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:01:40 -0700 (PDT)
Date:   Thu, 12 Oct 2023 18:01:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, david@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 1/3] mm/rmap: support move to different root anon_vma
 in folio_move_anon_rmap()
Message-ID: <ZShswW2rkKTwnrV3@x1n>
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009064230.2952396-2-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 08, 2023 at 11:42:26PM -0700, Suren Baghdasaryan wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> For now, folio_move_anon_rmap() was only used to move a folio to a
> different anon_vma after fork(), whereby the root anon_vma stayed
> unchanged. For that, it was sufficient to hold the folio lock when
> calling folio_move_anon_rmap().
> 
> However, we want to make use of folio_move_anon_rmap() to move folios
> between VMAs that have a different root anon_vma. As folio_referenced()
> performs an RMAP walk without holding the folio lock but only holding the
> anon_vma in read mode, holding the folio lock is insufficient.
> 
> When moving to an anon_vma with a different root anon_vma, we'll have to
> hold both, the folio lock and the anon_vma lock in write mode.
> Consequently, whenever we succeeded in folio_lock_anon_vma_read() to
> read-lock the anon_vma, we have to re-check if the mapping was changed
> in the meantime. If that was the case, we have to retry.
> 
> Note that folio_move_anon_rmap() must only be called if the anon page is
> exclusive to a process, and must not be called on KSM folios.
> 
> This is a preparation for UFFDIO_MOVE, which will hold the folio lock,
> the anon_vma lock in write mode, and the mmap_lock in read mode.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/rmap.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index c1f11c9dbe61..f9ddc50269d2 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -542,7 +542,9 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
>  	struct anon_vma *root_anon_vma;
>  	unsigned long anon_mapping;
>  
> +retry:
>  	rcu_read_lock();
> +retry_under_rcu:
>  	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
>  	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
>  		goto out;
> @@ -552,6 +554,16 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
>  	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
>  	root_anon_vma = READ_ONCE(anon_vma->root);
>  	if (down_read_trylock(&root_anon_vma->rwsem)) {
> +		/*
> +		 * folio_move_anon_rmap() might have changed the anon_vma as we
> +		 * might not hold the folio lock here.
> +		 */
> +		if (unlikely((unsigned long)READ_ONCE(folio->mapping) !=
> +			     anon_mapping)) {
> +			up_read(&root_anon_vma->rwsem);
> +			goto retry_under_rcu;

Is adding this specific label worthwhile?  How about rcu unlock and goto
retry (then it'll also be clear that we won't hold rcu read lock for
unpredictable time)?

> +		}
> +
>  		/*
>  		 * If the folio is still mapped, then this anon_vma is still
>  		 * its anon_vma, and holding the mutex ensures that it will

-- 
Peter Xu

