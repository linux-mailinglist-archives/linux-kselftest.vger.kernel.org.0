Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7542F368879
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Apr 2021 23:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbhDVVTc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Apr 2021 17:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24304 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239079AbhDVVTa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Apr 2021 17:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619126335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WL2DjbQuTq/EcUdymB75wSg7jJRF6qAH0Wk/CKq5EIY=;
        b=OouV6LUy1hdHGfG30icZrU6EBM8+adpAmwkAcEpzGLyPA399y6YjzbumycjK8zizp9zNLP
        39+u2W4TnZa2uaTHPUZuEnCEcC2GTKo486SEg3xBILuAm33Sv1mhOfUSSGUg0oXPnoc/Ne
        Yl+E8CovX6mOzcU0ajMQL8qm5IiX/hY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-S-1hccwcMy2yHcVD3batcA-1; Thu, 22 Apr 2021 17:18:51 -0400
X-MC-Unique: S-1hccwcMy2yHcVD3batcA-1
Received: by mail-qv1-f71.google.com with SMTP id 99-20020a0c80ec0000b029017de514d56fso16740012qvb.17
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Apr 2021 14:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WL2DjbQuTq/EcUdymB75wSg7jJRF6qAH0Wk/CKq5EIY=;
        b=N6Rf7ukA5kQyJEfTT4PhZA2v2ThWTld99Ud+kFo1QHyuvAVOS+fr65JlMR/rGfo/DJ
         n6byuYEjEXc1JswkKaYTHwixQ+BLmDZVPrCxUJeeYxgyw30RPaAn0WVWuL2Dq+UCl+tt
         ZAeZWXk2yfp+1E8OW9nVcugUw4GJEsThRLMdTbhmbvEXKw8sGLSBrGXTKazGih5zUW96
         3Aes0Xw2aZkpXJQh+r1C6WINjyQiVXj30oI7jPsFktv/rJfvH+2pUsB1QKh0OsgPArnM
         aN6M4uZ1Vo4mIZEgnSre+ahLj0TuZlu79w/b3ppaxvW4UvDgDqJrICni7/ej8+a9q2vI
         QITQ==
X-Gm-Message-State: AOAM531MZ6eIreJsJOz7GeG6y5pXr3hoFPOhXkPDOCOiNOy2X3YpBX7t
        z64F2EiyLSgF3Aoe5V7IfwhJvtOEUZHdZ6nSn0b3y/ibkUgW1aBDBkT1UtOlKXaIwSYoWIw/jzd
        sDv1/wevRFY1f0yOXdcjCjevkd8G0
X-Received: by 2002:ac8:4793:: with SMTP id k19mr453038qtq.373.1619126330843;
        Thu, 22 Apr 2021 14:18:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPK39d5FeudQjLH1XVuvAUd8EB5opbfb/Nov9VNsvcjW/X3rbs5nsCsgqxO6li0RTX/w4dHA==
X-Received: by 2002:ac8:4793:: with SMTP id k19mr453015qtq.373.1619126330602;
        Thu, 22 Apr 2021 14:18:50 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id g135sm3084697qke.8.2021.04.22.14.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 14:18:49 -0700 (PDT)
Date:   Thu, 22 Apr 2021 17:18:47 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 03/10] userfaultfd/shmem: support UFFDIO_CONTINUE for
 shmem
Message-ID: <20210422211847.GF6404@xz-x1>
References: <20210420220804.486803-1-axelrasmussen@google.com>
 <20210420220804.486803-4-axelrasmussen@google.com>
 <CAJHvVchQk1zrgah08n_P3sHUVzQLZUXHSMbkpd9rG-w5jUGNdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVchQk1zrgah08n_P3sHUVzQLZUXHSMbkpd9rG-w5jUGNdw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Axel,

On Thu, Apr 22, 2021 at 01:22:02PM -0700, Axel Rasmussen wrote:
> > +       if (page_in_cache)
> > +               page_add_file_rmap(page, false);
> > +       else
> > +               page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
> > +
> > +       /*
> > +        * Must happen after rmap, as mm_counter() checks mapping (via
> > +        * PageAnon()), which is set by __page_set_anon_rmap().
> > +        */
> > +       inc_mm_counter(dst_mm, mm_counter(page));
> 
> Actually, I've noticed that this is still slightly incorrect.
> 
> As Hugh pointed out, this works for the anon case, because
> page_add_new_anon_rmap() sets page->mapping.
> 
> But for the page_in_cache case, it doesn't work: unlike its anon
> counterpart, page_add_file_rmap() *does not* set page->mapping.

If it's already in the page cache, shouldn't it be set already in e.g. one
previous call to shmem_add_to_page_cache()?  Thanks,

-- 
Peter Xu

