Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A939C3500B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 14:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbhCaMyn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 08:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235675AbhCaMyR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 08:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617195257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BLVqguYYRqWS+fkpiZrnYWlDg4Em6ZwexNgxX0lsnu4=;
        b=H8RavXFVBwHwcMCLYL+w7w5HA8GwqCDwN0UWs8+titAW1NYzoE8V8+P3ndQRHGgPvJxviJ
        eyuw3IgvxPULNWW9++nk8q0Eb4KM2LKwYJuTbw4yVZy4njiulPUkL7JejYzbulGn5II+iQ
        XKBuDL+dnurIQw5/HEX3kusHddJYqh0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-Q2OE_ICXNuCZ05vGWxprcA-1; Wed, 31 Mar 2021 08:54:14 -0400
X-MC-Unique: Q2OE_ICXNuCZ05vGWxprcA-1
Received: by mail-qt1-f197.google.com with SMTP id w2so1078423qts.18
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Mar 2021 05:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BLVqguYYRqWS+fkpiZrnYWlDg4Em6ZwexNgxX0lsnu4=;
        b=JitdPrTiWCfvkeEFi98IXjGISnbNXvwHV8vtr++vYa+IF5r5ROvQBKm0V9uxQQlNaH
         WfL+wAVy6zXOKYLo/kF8JVRkqmuIOcDGhs6NejSLO18lOxj/OEW23sFmpTaCzDUI6YOO
         Vha9aEiBh3xsjmFeLi9sHC1jPZqZl+lqjd2KlmSXHL/OwM5MmWz/Qfk6Z5gYA9EF9i55
         DvSJbp28fK6yaHcRkNU5WERY6UVccGpJiNlm1FWHx69FRtxJZ2WhpWDcImtEpzdceGWA
         tgpGdWehcaJUNgxH4fdFmtibzyMPT/1KP6GsCnztRbh2wM/mXC/texfi5jl5ENksmHqm
         X2Bg==
X-Gm-Message-State: AOAM531bhHVu8PTcZZk7f2VC0YiTxhWZzfSlGhFI357kn0AmgCamNPnk
        dZeq3kR8ukWmM77kYyPG26Q/bcRBhjlFPFR7IlwOGfsV8Pe288KgaYeYYsjtaRJ+IWyWdFI931d
        uPPWG/0ywNhCoJsZDvdwC99OqlgbI
X-Received: by 2002:a05:622a:48d:: with SMTP id p13mr2279120qtx.21.1617195253823;
        Wed, 31 Mar 2021 05:54:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUI7wPo7TLqkGMdpy3kH1M1sXi6ovrIE72FbmoqiknBlD6P60sY1MhBQ3ElvmViqcwOGvUsQ==
X-Received: by 2002:a05:622a:48d:: with SMTP id p13mr2279090qtx.21.1617195253556;
        Wed, 31 Mar 2021 05:54:13 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id a19sm1330189qkl.126.2021.03.31.05.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 05:54:12 -0700 (PDT)
Date:   Wed, 31 Mar 2021 08:54:09 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v3] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTNUE behavior
Message-ID: <20210331125409.GL429942@xz-x1>
References: <20210329234131.304999-1-axelrasmussen@google.com>
 <20210330205519.GK429942@xz-x1>
 <CAJHvVcikF9MJepyvf6riVKZEUxQvV1QMdoQoN5Kirs0TLcn-Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcikF9MJepyvf6riVKZEUxQvV1QMdoQoN5Kirs0TLcn-Dg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Axel,

On Tue, Mar 30, 2021 at 04:30:13PM -0700, Axel Rasmussen wrote:
> Yes, a refactor like that is promising. It's hard to say for certain
> without actually looking at the result - I'll spend some time tomorrow
> on a few options, and send along the cleanest version I come up with.

Before you move onto a new version...  See this commit:

5b51072e97d5 ("userfaultfd: shmem: allocate anonymous memory for MAP_PRIVATE shmem", 2018-11-30)

I found it when I was thinking why not move the whole continue logic directly
into mfill_atomic_pte(), if we can have the pte installation helper, because
that's all we need.

So previously I got the semantics a bit mixed up: for private shmem mappings,
UFFDIO_COPY won't fill in page cache at all, but it's all private.  We keep the
page cache empty even after UFFDIO_COPY for a private mapping.

UFFDIO_CONTINUE is slightly different, since we _know_ the page cache is
there..  So I'm thinking maybe you need to handle the continue request in
mfill_atomic_pte() before the VM_SHARED check so as to cover both cases.

-- 
Peter Xu

