Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B53A7B5648
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 17:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbjJBPYD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 11:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbjJBPYC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 11:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7630A9
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Oct 2023 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696260191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4O1ESocyKqwozJC+Tl+xGGPxeQyAnmMS0aCpZFUwmKo=;
        b=EVW6ugt+WqYLDz2b3SDzOH0l9qPqzthtBM5nMs6tb2CBPtQyhEennpRBajU7zrJaPvzzq+
        9rnCVkXVVl2OJlOIHu35ue1+KlBzquVwSJeKJqTG3Nu9N9FuYNT/ZopcCSI+igOwHsQfVG
        wbLx9Rp0wUrJo4CmbFBYtP2uU8yrRZM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-XPoXPtIRNyahRaGfTd0k_w-1; Mon, 02 Oct 2023 11:23:09 -0400
X-MC-Unique: XPoXPtIRNyahRaGfTd0k_w-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4197878ffe9so12668101cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Oct 2023 08:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260189; x=1696864989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O1ESocyKqwozJC+Tl+xGGPxeQyAnmMS0aCpZFUwmKo=;
        b=oZYg8jkD6Vx4l+lnFujXeLTyc3P9m4NiaFfE1qwlJJFoJ1mv4c80uw2MngDP8tOorS
         Z+4AShjfT0s8RT0bUE0yDTr09UHytP9/qJo8ZBS9oP4GH2z/ldSMxAJAL5N9W6y/ST9j
         RUs98GBII4yDgh7OQ/Y1eFlq/iIFk2wZTjhrQimwJujPTrSFKUDdkywKTOWG/gB7iTPS
         CJHZO7ZnNNc+6YerFVm7gtoLfp837RMsnGR9eri4g23PuUsNwxPmPN/kv++difd70EQD
         R1Cx7T54VVdw36eZ0VBczgmCxYnuICZMOoAcOT4udZPKKNlXrd2J27ooaTkR9Hx03dXR
         LB2A==
X-Gm-Message-State: AOJu0YyXHXH1RDKQhbBFed3yu+tFaX5AsdqDUy7uVs4x0AN2OYGfa7Ve
        UE6c1jDIH6fY8Kf7aRug51zaEG6YzLC+ClpP9Y1wNQV0+n0eSbyEsb3iKBd5p9jwh7cqu9q3/1e
        MuyTQ+B21iKzl+ZIs6XqbyaxVmPKG
X-Received: by 2002:a05:622a:1452:b0:3ff:2a6b:5a76 with SMTP id v18-20020a05622a145200b003ff2a6b5a76mr13928232qtx.5.1696260189227;
        Mon, 02 Oct 2023 08:23:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMkfW5qwKvmskAcRJvzl4ek6148BaomL6ar7scMW39LWBMgkGSUsRlNgp0NyH9ZUc23Gd1Fw==
X-Received: by 2002:a05:622a:1452:b0:3ff:2a6b:5a76 with SMTP id v18-20020a05622a145200b003ff2a6b5a76mr13928199qtx.5.1696260188907;
        Mon, 02 Oct 2023 08:23:08 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c21-20020ac853d5000000b004181d77e08fsm5406196qtq.85.2023.10.02.08.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:23:08 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:23:05 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/3] userfaultfd: UFFDIO_REMAP: rmap preparation
Message-ID: <ZRrgWVgjVfQu4RGX@x1n>
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-2-surenb@google.com>
 <27f177c9-1035-3277-cd62-dc81c12acec4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27f177c9-1035-3277-cd62-dc81c12acec4@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 02, 2023 at 04:42:50PM +0200, David Hildenbrand wrote:
> On 23.09.23 03:31, Suren Baghdasaryan wrote:
> > From: Andrea Arcangeli <aarcange@redhat.com>
> > 
> > As far as the rmap code is concerned, UFFDIO_REMAP only alters the
> > page->mapping and page->index. It does it while holding the page
> > lock. However folio_referenced() is doing rmap walks without taking the
> > folio lock first, so folio_lock_anon_vma_read() must be updated to
> > re-check that the folio->mapping didn't change after we obtained the
> > anon_vma read lock.
> 
> I'm curious: why don't we need this for existing users of
> page_move_anon_rmap()? What's special about UFFDIO_REMAP?

Totally no expert on anon vma so I'm prone to errors, but IIUC the
difference here is root anon vma cannot change in page_move_anon_rmap(),
while UFFDIO_REMAP can.

Thanks,

-- 
Peter Xu

