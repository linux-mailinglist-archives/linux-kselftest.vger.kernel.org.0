Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4AD348618
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Mar 2021 01:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbhCYAxR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Mar 2021 20:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235263AbhCYAwl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Mar 2021 20:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616633561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/I8HMRSY8uGPzIO7tttoD3dS3yWYP/iDM4q6Ir57s4=;
        b=XvIGNOE9DtYsnK7xu61TRzM7pn+tZ8HcCvhWLdoNKXEAu71XPUNVaJ1yQ9n6+nXdomVstQ
        va8DiXM9MGsJmGVpFzMygyV/Zk4W16Y8rKev8rGR7fr9KSW3V+FxbTW/YexvpXmtaRRN02
        dfMtndeEhwtsBRd1q4LasUX1h9GCyho=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-mZ-jUxR0O6-h1hSID8YVIw-1; Wed, 24 Mar 2021 20:52:37 -0400
X-MC-Unique: mZ-jUxR0O6-h1hSID8YVIw-1
Received: by mail-qk1-f199.google.com with SMTP id g18so2844042qki.15
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Mar 2021 17:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a/I8HMRSY8uGPzIO7tttoD3dS3yWYP/iDM4q6Ir57s4=;
        b=KrRfmmNAlhRAz3hSZjCyicOaZ8ynmjzBas+aYrOr+t9n4fXo8GPRp6OwVFQ4eUxVjw
         CyI5akBXwVz2Q6WChjt+AOyicj6+oRqqsu8a206Bts4ydg/iWDT0oYaxjuwExdefsCuA
         qam1OVG0f6T1qXZRbL7hiiIOScrEMNkl5Eg95xgjnF/6qr9tN6yi75eGAISodxfVPpAz
         SdeOHRJvu8UkFiawm7+bNllVqwwshO7ODj0dN1Pv51mohCq9qIF/MsVdFz3m579F0s3B
         VC/adLueS865bHajIvB+RuK8GHg5BoH/PvpPv5sdRudbP+lA8ke2BsSUBv1VhpBKbBbx
         IJPA==
X-Gm-Message-State: AOAM532/VXvVmE4m27/lxTdlQLts5PGXsdIGY1jrmw/oxS5Lwo5PB/6o
        9/PJl/tSVKFD+SFhU5NYa39mClgHv3lpcjMP+GxJiNP7gAS6U2/xeIzpM5rOQzqurxq1RV+w1FW
        OuOWfZsfrQw+tqbdHpJN0bof+HJUZ
X-Received: by 2002:ac8:6a04:: with SMTP id t4mr5714161qtr.258.1616633557072;
        Wed, 24 Mar 2021 17:52:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwf9lYUsnxZG/nhvJyxohZp2hC5gok7X1yMvcKfPeM5sVJS83vfqZvs4qyqdec2U35Zf3Et5A==
X-Received: by 2002:ac8:6a04:: with SMTP id t4mr5714138qtr.258.1616633556783;
        Wed, 24 Mar 2021 17:52:36 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id k4sm3078112qke.13.2021.03.24.17.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 17:52:36 -0700 (PDT)
Date:   Wed, 24 Mar 2021 20:52:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Wang Qing <wangqing@vivo.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH] userfaultfd/shmem: fix minor fault page leak
Message-ID: <20210325005234.GG219069@xz-x1>
References: <20210322204836.1650221-1-axelrasmussen@google.com>
 <20210324162027.cc723b545ff62b1ad6f5223e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210324162027.cc723b545ff62b1ad6f5223e@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Andrew,

On Wed, Mar 24, 2021 at 04:20:27PM -0700, Andrew Morton wrote:
> On Mon, 22 Mar 2021 13:48:35 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:
> 
> > This fix is analogous to Peter Xu's fix for hugetlb [0]. If we don't
> > put_page() after getting the page out of the page cache, we leak the
> > reference.
> > 
> > The fix can be verified by checking /proc/meminfo and running the
> > userfaultfd selftest in shmem mode. Without the fix, we see MemFree /
> > MemAvailable steadily decreasing with each run of the test. With the
> > fix, memory is correctly freed after the test program exits.
> > 
> > Fixes: 00da60b9d0a0 ("userfaultfd: support minor fault handling for shmem")
> 
> Confused.  The affected code:
> 
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1831,6 +1831,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> >  
> >  	if (page && vma && userfaultfd_minor(vma)) {
> >  		unlock_page(page);
> > +		put_page(page);
> >  		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
> >  		return 0;
> >  	}
> 
> Is added by Peter's "page && vma && userfaultfd_minor".  I assume that
> "Fixes:" is incorrect?
> 

It seems to me the commit is correct as pointed to in "Fixes", but I do have a
different commit ID here:

    commit 63c826b1372c4930f89b8a55092699fa7f0d6f4e
    Author: Axel Rasmussen <axelrasmussen@google.com>
    Date:   Thu Mar 18 10:20:43 2021 -0400

    userfaultfd: support minor fault handling for shmem

Axel, did you fetched the commit ID from your local tree, perhaps?  Since I
should have fetched from hnaz/linux-mm and I can see Andrew's sign-off too.

Thanks,

-- 
Peter Xu

