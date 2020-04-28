Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399001BCC54
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Apr 2020 21:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgD1TWz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Apr 2020 15:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728721AbgD1TWy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Apr 2020 15:22:54 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C91C03C1AD
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Apr 2020 12:22:53 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z90so18260859qtd.10
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Apr 2020 12:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PYh9xmPfS312gCXfdzhUhHbtCQqRUOprLrWe8CN4KOQ=;
        b=IaqMz7fb472+OlDu/UtAPP5H+bEwqwBkv7FKc1L94GjxtlTO3HofyKc3+k1PZRn2CE
         u5u0gaOk6CTvlgtWoV7WkcLyMMWDDByJBX4+NBa/Ai+qIDx7ptplcsoNv6n0RXW5cKHJ
         BpT/G6Ytr6MOwdAqTxCSknBOIuGx2K1nQzIu/26RuQIn2q2CixGKNAQWHO9HC+kIJ6en
         DjH++ipC58RYznVw+z6+Qeo6pojXT67RWJXt/q/mlHe+2BYA+Hgz5SAqDwMVQW6yvgmw
         1EZWfWjkNAHYJpyVl8SMlzBYUVyidDpy+cz9e/t0fQiAVMVH+LsFkfRWZ/6+W/TPuCGL
         mdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PYh9xmPfS312gCXfdzhUhHbtCQqRUOprLrWe8CN4KOQ=;
        b=WJ3LrfyXWS+PtF2WYZmKv37vW2unk/WT0+cj4Xb42wV6GXLd94JfVD9w9j0rBfWBIb
         pPb9AMiyO1uHi0r2Lf476GkWG7Xwge2dQbxYaqKyfsBJAvvh+/ovID06n0YeR6v9m8cE
         lWUCYCJmkpi/xzCVuGUWVtsoEKEUFd8oFw5o6sKYsmTDVovGiStlrQT/OPRqVx7pR52q
         7LSSY+5PHQuC2VlVdby7IBLT5YoKC3nU8+aXUoIXeAWniYG5Z9iaCjyaQOpm1oYlRUC2
         crO2ke87MeCnCRYZIDpTKZ5z+jxinvu98X9eq1RPwbzg29bKQXdoPA32Ih4SNT8KEIUn
         0vMg==
X-Gm-Message-State: AGi0PuayXbBMdyKKTBc1M1EvFCvrs3qGj9DmeX8KId+KWjrZL7kq+Db+
        hUjcgURzIIzPcsE1ToyqZ/c7Ew==
X-Google-Smtp-Source: APiQypIm2iy0fehpUXGvgzCJ3YVuZRDehWEKh6i0g/stChUO8xvKnvqB7LdZZZ9J+nCT5SrC5sQ09A==
X-Received: by 2002:ac8:2fda:: with SMTP id m26mr29942561qta.80.1588101773137;
        Tue, 28 Apr 2020 12:22:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j92sm14236451qtd.58.2020.04.28.12.22.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 12:22:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jTVoh-00070x-RA; Tue, 28 Apr 2020 16:22:51 -0300
Date:   Tue, 28 Apr 2020 16:22:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [regression?] Re: [PATCH v6 06/12] mm/gup: track FOLL_PIN pages
Message-ID: <20200428192251.GW26002@ziepe.ca>
References: <20200211001536.1027652-1-jhubbard@nvidia.com>
 <20200211001536.1027652-7-jhubbard@nvidia.com>
 <20200424121846.5ee2685f@w520.home>
 <5b901542-d949-8d7e-89c7-f8d5ee20f6e9@nvidia.com>
 <20200424141548.5afdd2bb@w520.home>
 <665ffb48-d498-90f4-f945-997a922fc370@nvidia.com>
 <20200428105455.30343fb4@w520.home>
 <20200428174957.GV26002@ziepe.ca>
 <20200428130752.75c153bd@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428130752.75c153bd@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 28, 2020 at 01:07:52PM -0600, Alex Williamson wrote:
> On Tue, 28 Apr 2020 14:49:57 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Tue, Apr 28, 2020 at 10:54:55AM -0600, Alex Williamson wrote:
> > >  static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
> > >  {
> > >  	struct vfio_pci_device *vdev = device_data;
> > > @@ -1253,8 +1323,14 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
> > >  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > >  	vma->vm_pgoff = (pci_resource_start(pdev, index) >> PAGE_SHIFT) + pgoff;
> > >  
> > > +	vma->vm_ops = &vfio_pci_mmap_ops;
> > > +
> > > +#if 1
> > > +	return 0;
> > > +#else
> > >  	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> > > -			       req_len, vma->vm_page_prot);
> > > +			       vma->vm_end - vma->vm_start, vma->vm_page_prot);  
> > 
> > The remap_pfn_range here is what tells get_user_pages this is a
> > non-struct page mapping:
> > 
> > 	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
> > 
> > Which has to be set when the VMA is created, they shouldn't be
> > modified during fault.
> 
> Aha, thanks Jason!  So fundamentally, pin_user_pages_remote() should
> never have been faulting in this vma since the pages are non-struct
> page backed. 

gup should not try to pin them.. I think the VM will still call fault
though, not sure from memory?

> Maybe I was just getting lucky before this commit.  For a
> VM_PFNMAP, vaddr_get_pfn() only needs pin_user_pages_remote() to return
> error and the vma information that we setup in vfio_pci_mmap().

I've written on this before, vfio should not be passing pages to the
iommu that it cannot pin eg it should not touch VM_PFNMAP vma's in the
first place.

It is a use-after-free security issue the way it is..

> only need the fault handler to trigger for user access, which is what I
> see with this change.  That should work for me.
> 
> > Also the vma code above looked a little strange to me, if you do send
> > something like this cc me and I can look at it. I did some work like
> > this for rdma a while ago..
> 
> Cool, I'll do that.  I'd like to be able to zap the vmas from user
> access at a later point and I have doubts that I'm holding the
> refs/locks that I need to for that.  Thanks,

Check rdma_umap_ops, it does what you described (actually it replaces
them with 0 page, but along the way it zaps too).

Jason
