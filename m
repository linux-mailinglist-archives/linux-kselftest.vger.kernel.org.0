Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95E435FB1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Apr 2021 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhDNSwP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Apr 2021 14:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21199 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230398AbhDNSwI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Apr 2021 14:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618426305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=olnINB9MiAVWvAGJIPu39IEipm/CRaDs3WWVqPj5ijQ=;
        b=LhEVkhyN98Ne+wDQKzktr4ZCyfinHbP3Xa+rGqA6PiKl77gure8wi9HuMyLgBHc+nuGSEt
        cvrtMpMbOJyDp/9uOMXCJaC0yP+PFY27r47RR22n4wBe5Pk+O2G3oPstrPxbwjJjC0ckjl
        cxG2LFs1j1JFf6IGNTxIai6FTmIbSRM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-vFBoKPfYN0i66gTEE6Nk5Q-1; Wed, 14 Apr 2021 14:51:40 -0400
X-MC-Unique: vFBoKPfYN0i66gTEE6Nk5Q-1
Received: by mail-qt1-f200.google.com with SMTP id a11-20020ac85b8b0000b02901a69faebe0cso2529288qta.6
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Apr 2021 11:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=olnINB9MiAVWvAGJIPu39IEipm/CRaDs3WWVqPj5ijQ=;
        b=W4RbnBvvVuCue1tuTYArQ06ix4goa2VbDdj2w3YevUEVhiu3G+nY8iKNDeteksxHIv
         BYgM5fx9nKL5Te/nY7wHHE2yca+yZfhiNsA9cX3/fSk5kAV52I7mCcLTpjiecInchEUt
         t4G2Qr2o7StGVRSJHR4YVmtVF6XPa6Tyc9F8IE8bNAt7F8N+cKhFp2DMvehk5b7LeXJX
         E7Brpz6FCIvnbxQy2rsHQ5Uy8UPtNUVesu5EIRZdtT3hGn42MJZWG4GtG1YgSiVSVmp8
         5ZLsSZgUp0WlB5eeOklcoPoBF+QS8evdPrNf7sCxk0G/dzwyLNBiZWA/YrnuP3LfVMJu
         83cw==
X-Gm-Message-State: AOAM5307B/fIezT3rSoIovAaO2x4Ce8I0qrs2fMFoHSbZPlBOdjasusA
        t+kDlIH4SSPXpGS/2tABCCLZQo3ejJ8cQ1roSu8pbxNoiMiEUdwC/CWEw9WjfHTCEWN/WvIR4f0
        2VHwhK/R1198q3QKkJeSDn9MppDlY
X-Received: by 2002:a05:6214:849:: with SMTP id dg9mr1265813qvb.30.1618426300103;
        Wed, 14 Apr 2021 11:51:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyg9sbLBXWyxGdJsTjNQr4DDmurtkXEAu8TTVg/ZkwZ2b+eql0sW4xwjZe0FJzN98fdLZhmxg==
X-Received: by 2002:a05:6214:849:: with SMTP id dg9mr1265778qvb.30.1618426299817;
        Wed, 14 Apr 2021 11:51:39 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id m11sm159011qtg.67.2021.04.14.11.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:51:38 -0700 (PDT)
Date:   Wed, 14 Apr 2021 14:51:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v2 3/9] userfaultfd/shmem: support minor fault
 registration for shmem
Message-ID: <20210414185137.GK4440@xz-x1>
References: <20210413051721.2896915-1-axelrasmussen@google.com>
 <20210413051721.2896915-4-axelrasmussen@google.com>
 <alpine.LSU.2.11.2104132351350.9086@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2104132351350.9086@eggly.anvils>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 14, 2021 at 12:36:13AM -0700, Hugh Dickins wrote:
> On Mon, 12 Apr 2021, Axel Rasmussen wrote:
> 
> > This patch allows shmem-backed VMAs to be registered for minor faults.
> > Minor faults are appropriately relayed to userspace in the fault path,
> > for VMAs with the relevant flag.
> > 
> > This commit doesn't hook up the UFFDIO_CONTINUE ioctl for shmem-backed
> > minor faults, though, so userspace doesn't yet have a way to resolve
> > such faults.
> 
> This is a very odd way to divide up the series: an "Intermission"
> half way through the implementation of MINOR/CONTINUE: this 3/9
> makes little sense without the 4/9 to mm/userfaultfd.c which follows.
> 
> But, having said that, I won't object and Peter did not object, and
> I don't know of anyone else looking here: it will only give each of
> us more trouble to insist on repartitioning the series, and it's the
> end state that's far more important to me and to all of us.

Agreed, ideally it should be after patch 4 since this patch enables the
feature already.

> 
> And I'll even seize on it, to give myself an intermission after
> this one, until tomorrow (when I'll look at 4/9 and 9/9 - but
> shall not look at the selftests ones at all).
> 
> Most of this is okay, except the mm/shmem.c part; and I've just now
> realized that somewhere (whether in this patch or separately) there
> needs to be an update to Documentation/admin-guide/mm/userfaultfd.rst
> (admin-guide? how weird, but not this series' business to correct).

(maybe some dir "devel" would suite better?  But I do also see soft-dirty.rst,
 idle_page_tracking.rst,..)

[...]

> >  static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> > @@ -1820,6 +1820,14 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> >  
> >  	page = pagecache_get_page(mapping, index,
> >  					FGP_ENTRY | FGP_HEAD | FGP_LOCK, 0);
> > +
> > +	if (page && vma && userfaultfd_minor(vma)) {
> > +		unlock_page(page);
> > +		put_page(page);
> > +		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
> > +		return 0;
> > +	}
> > +
> 
> Okay, Peter persuaded you to move that up here: where indeed it
> does look better than the earlier "swapped" version.
> 
> But will crash on swap as it's currently written: it needs to say
> 		if (!xa_is_value(page)) {
> 			unlock_page(page);
> 			put_page(page);
> 		}

And this is definitely true...  Thanks,

> 
> I did say before that it's more robust to return from the swap
> case after doing the shmem_swapin_page(). But I might be slowly
> realizing that the ioctl to add the pte (in 4/9) will do its
> shmem_getpage_gfp(), and that will bring in the swap if user
> did not already do so: so I was wrong to claim more robustness
> the other way, this placement should be fine. I think.
> 
> >  	if (xa_is_value(page)) {
> >  		error = shmem_swapin_page(inode, index, &page,
> >  					  sgp, gfp, vma, fault_type);
> > -- 
> > 2.31.1.295.g9ea45b61b8-goog
> 

-- 
Peter Xu

