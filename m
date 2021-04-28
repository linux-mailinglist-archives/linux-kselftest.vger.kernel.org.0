Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24A636DB3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 17:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhD1PLI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Apr 2021 11:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235833AbhD1PKy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Apr 2021 11:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619622609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kk0GXyWrV+tplXlipzE2jcmQ3JfsCy9V2iMdjdCt+G0=;
        b=eF+dxnYIs+ZLj9HBWAJwe0vwC2LlBWGcYDuRVttOYjqcHZrouKAjh3lq5kdcN4IdwojG3e
        Xh4ne1eTDdd97Fqgp7P5E89TeM+uo1dRcvRCjHeCeL2l28aCReW53gS8ev7X4ilEe3rAV2
        GotZzFwCuvf+3Y6oly+PsmYZ+qRh+C4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-7w8vXhbMPhG8rg7mvxTGVg-1; Wed, 28 Apr 2021 11:10:07 -0400
X-MC-Unique: 7w8vXhbMPhG8rg7mvxTGVg-1
Received: by mail-qt1-f199.google.com with SMTP id r20-20020ac85c940000b02901bac34fa2eeso3604924qta.11
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Apr 2021 08:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kk0GXyWrV+tplXlipzE2jcmQ3JfsCy9V2iMdjdCt+G0=;
        b=AfySsEhqDcgzIlZsmiRq3P6j5yHlFao3fN9Oz/5B5xPddBIXKsuMkgfLauvc70/vZY
         qScbCY0u8iSBnH9oceu+lbInt6qf16GkCuNDnf3PBoWq07Lkrj8LQKcS6DHtu/hNoj8H
         s3RDcgrBNNUyfbJ9lV/yQtuZpDSevI7XG4miMl/MdmpPjC3y99IoWWQRlq+/+i0mEa/H
         OK0axdY5jN8v0VKPER09InStiTZdvV1RiMnZxoAlCxLp/0byQGY04p3HEkdj6uNAbzJy
         WEbHODGBvm4J6shm4TC64bUoZ6+BLBsuYGKi0ssWZDc1h7nbS3nEgpZnyH2wZgzaX2sv
         dWwA==
X-Gm-Message-State: AOAM533NQ6GF0KkyyWshDfFoYr6TfiA9sdPCuw/gmYFCcMNhHzW1Hx0f
        DBKtx54nLD2mx7c6XBTgB6tNij/bKpZOMyn8aPwWpw2in39+wP/eZUNgWKGumDq/gIBO6zaDAhG
        AwuArlTTMQk/EC0wbqeKZdEtVhdJs
X-Received: by 2002:a05:622a:58d:: with SMTP id c13mr5772739qtb.44.1619622606823;
        Wed, 28 Apr 2021 08:10:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDOIhz717CICdyQ7QFBw3/HvW1s7fJ9E22xX4/FLRWsnY9Iqpo03jJIJ0dPF8+ttjVIu4urg==
X-Received: by 2002:a05:622a:58d:: with SMTP id c13mr5772702qtb.44.1619622606467;
        Wed, 28 Apr 2021 08:10:06 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id f2sm5333165qkh.76.2021.04.28.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 08:10:05 -0700 (PDT)
Date:   Wed, 28 Apr 2021 11:10:03 -0400
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
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 04/10] userfaultfd/shmem: support UFFDIO_CONTINUE for
 shmem
Message-ID: <20210428151003.GB6584@xz-x1>
References: <20210427225244.4326-1-axelrasmussen@google.com>
 <20210427225244.4326-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210427225244.4326-5-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 27, 2021 at 03:52:38PM -0700, Axel Rasmussen wrote:
> With this change, userspace can resolve a minor fault within a
> shmem-backed area with a UFFDIO_CONTINUE ioctl. The semantics for this
> match those for hugetlbfs - we look up the existing page in the page
> cache, and install a PTE for it.
> 
> This commit introduces a new helper: mcopy_atomic_install_pte.
> 
> Why handle UFFDIO_CONTINUE for shmem in mm/userfaultfd.c, instead of in
> shmem.c? The existing userfault implementation only relies on shmem.c
> for VM_SHARED VMAs. However, minor fault handling / CONTINUE work just
> fine for !VM_SHARED VMAs as well. We'd prefer to handle CONTINUE for
> shmem in one place, regardless of shared/private (to reduce code
> duplication).
> 
> Why add a new mcopy_atomic_install_pte helper? A problem we have with
> continue is that shmem_mcopy_atomic_pte() and mcopy_atomic_pte() are
> *close* to what we want, but not exactly. We do want to setup the PTEs
> in a CONTINUE operation, but we don't want to e.g. allocate a new page,
> charge it (e.g. to the shmem inode), manipulate various flags, etc. Also
> we have the problem stated above: shmem_mcopy_atomic_pte() and
> mcopy_atomic_pte() both handle one-half of the problem (shared /
> private) continue cares about. So, introduce mcontinue_atomic_pte(), to
> handle all of the shmem continue cases. Introduce the helper so it
> doesn't duplicate code with mcopy_atomic_pte().
> 
> In a future commit, shmem_mcopy_atomic_pte() will also be modified to
> use this new helper. However, since this is a bigger refactor, it seems
> most clear to do it as a separate change.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

