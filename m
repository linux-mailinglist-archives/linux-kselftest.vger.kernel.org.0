Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB718C40F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Mar 2020 01:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgCTADt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Mar 2020 20:03:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35844 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgCTADt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Mar 2020 20:03:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id d11so5220855qko.3
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Mar 2020 17:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1pJxpq8bFhAdtFvjymRkDlT+zzgC3t93bLWt4+LdA0o=;
        b=niE0QFwAScsJNksiL1RD0EoZyWLTkmIFeNZTwtNcFLkMjDayi0bxMD56+ydBpxjFer
         ccfFIEFWOAqX7S6DF8dy2B90sjOJd11kjQNv+zzxmWUfQ+NuUvGWeapza5y7m3aL1wJG
         j3hvcJFjjm2RHXKkVcIUMT/Unai34kkTifnPtPSjJsdNLmUD0nhajqJhX+Agn9Kz3t8d
         MseyS+KCBRWIY/Clnpsqfu2H+lIZb7sticYp/HJnFGSWY7gUq7c/Zqf45npz2Z8DGQ78
         mXMSeVQdS57T+ekPAXfTCqZyqZmCir8LMmtQu7NDGFXY1YDgmRsH7Uq3cAhojnHv5w1y
         bUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1pJxpq8bFhAdtFvjymRkDlT+zzgC3t93bLWt4+LdA0o=;
        b=jpE4D7B8WO4FoyBVyU5GuUWW8sieDAj+VQxn5IYP0xFVsQIo2uUkrbNcxB0lG/s9/O
         0raksInYGFGyUtTj92xY3LvocD+DOvZnV9YHmmeWcusVsBz17FjEA4fncl5Rbw7E+tmn
         G/CyJ7OGNEJyjltCZpGwBkNtU4JrNKGpzcgQjRZWkNRPCNK/kkGNU9/TvIUNWtX4xnBi
         C8qSMmH73kTwbf5i4cNPCEw2llDJfL2ocaNqkPQVQKAIBY1gTXfjNAXzLxWuf4hF039d
         7gt3PnD3hw8nrYZhlM04BXV1laptJIo9n9NiU2stk+CgXokTf81/NeCp6na33uptrgkj
         J5hA==
X-Gm-Message-State: ANhLgQ1kf3/jstW5Jz+kNn70H22MYhB6GK+Gnq+IymiOKGc0B3Q99kiY
        cjJlJAw6Swf3DXGV8NbmPbvxVw==
X-Google-Smtp-Source: ADFU+vvmojx05al3/dBJDAgC1QulIXZbUAIDZwSQ+speDrKVTJZR9ajSBjpmE5SDOXsMKVejlONOTg==
X-Received: by 2002:a37:b44:: with SMTP id 65mr5064085qkl.201.1584662627565;
        Thu, 19 Mar 2020 17:03:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h11sm139725qtr.38.2020.03.19.17.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Mar 2020 17:03:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jF58b-00029b-D5; Thu, 19 Mar 2020 21:03:45 -0300
Date:   Thu, 19 Mar 2020 21:03:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>, kvm-ppc@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: simplify device private page handling in
 hmm_range_fault
Message-ID: <20200320000345.GO20941@ziepe.ca>
References: <20200316193216.920734-4-hch@lst.de>
 <7256f88d-809e-4aba-3c46-a223bd8cc521@nvidia.com>
 <20200317121536.GQ20941@ziepe.ca>
 <20200317122445.GA11662@lst.de>
 <20200317122813.GA11866@lst.de>
 <20200317124755.GR20941@ziepe.ca>
 <20200317125955.GA12847@lst.de>
 <24fca825-3b0f-188f-bcf2-fadcf3a9f05a@nvidia.com>
 <20200319181716.GK20941@ziepe.ca>
 <89e33770-a0ab-e1ec-d5e5-535edefd3fd3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89e33770-a0ab-e1ec-d5e5-535edefd3fd3@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 19, 2020 at 03:56:50PM -0700, Ralph Campbell wrote:
> Adding linux-kselftest@vger.kernel.org for the test config question.
> 
> On 3/19/20 11:17 AM, Jason Gunthorpe wrote:
> > On Tue, Mar 17, 2020 at 04:14:31PM -0700, Ralph Campbell wrote:
> > > 
> > > On 3/17/20 5:59 AM, Christoph Hellwig wrote:
> > > > On Tue, Mar 17, 2020 at 09:47:55AM -0300, Jason Gunthorpe wrote:
> > > > > I've been using v7 of Ralph's tester and it is working well - it has
> > > > > DEVICE_PRIVATE support so I think it can test this flow too. Ralph are
> > > > > you able?
> > > > > 
> > > > > This hunk seems trivial enough to me, can we include it now?
> > > > 
> > > > I can send a separate patch for it once the tester covers it.  I don't
> > > > want to add it to the original patch as it is a significant behavior
> > > > change compared to the existing code.
> > > > 
> > > 
> > > Attached is an updated version of my HMM tests based on linux-5.6.0-rc6.
> > > I ran this OK with Jason's 8+1 HMM patches, Christoph's 1-5 misc HMM clean ups,
> > > and Christoph's 1-4 device private page changes applied.
> > 
> > I'd like to get this to mergable, it looks pretty good now, but I have
> > no idea about selftests - and I'm struggling to even compile the tools
> > dir
> > 
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index 69def4a9df00..4d22ce7879a7 100644
> > > +++ b/lib/Kconfig.debug
> > > @@ -2162,6 +2162,18 @@ config TEST_MEMINIT
> > >   	  If unsure, say N.
> > > +config TEST_HMM
> > > +	tristate "Test HMM (Heterogeneous Memory Management)"
> > > +	depends on DEVICE_PRIVATE
> > > +	select HMM_MIRROR
> > > +        select MMU_NOTIFIER
> > 
> > extra spaces
> 
> Will fix in v8.
> 
> > In general I wonder if it even makes sense that DEVICE_PRIVATE is user
> > selectable?
> 
> Should tests enable the feature or the feature enable the test?
> IMHO, if the feature is being compiled into the kernel, that should
> enable the menu item for the test. If the feature isn't selected,
> no need to test it :-)

I ment if DEVICE_PRIVATE should be a user selectable option at all, or
should it be turned on when a driver like nouveau is selected.

Is there some downside to enabling DEVICE_PRIVATE?

> > The notifier holds a mmgrab, no need for another one
> 
> OK. I'll replace dmirror->mm with dmirror->notifier.mm.

Right that is good too

> > > +	filp->private_data = dmirror;
> > 
> > Not sure what this comment means
> 
> I'll change the comment to:
> 	  /*
>          * The first open of the device character file registers the address
>          * space of the process doing the open() system call with the device.
>          * Subsequent file opens by other processes will have access to the
>          * first process' address space.
>          */

How does this happen? The function looks like it always does the same thing

> > > +static bool dmirror_interval_invalidate(struct mmu_interval_notifier *mni,
> > > +				const struct mmu_notifier_range *range,
> > > +				unsigned long cur_seq)
> > > +{
> > > +	struct dmirror *dmirror = container_of(mni, struct dmirror, notifier);
> > > +	struct mm_struct *mm = dmirror->mm;
> > > +
> > > +	/*
> > > +	 * If the process doesn't exist, we don't need to invalidate the
> > > +	 * device page table since the address space will be torn down.
> > > +	 */
> > > +	if (!mmget_not_zero(mm))
> > > +		return true;
> > 
> > Why? Don't the notifiers provide for this already.
> > 
> > mmget_not_zero() is required before calling hmm_range_fault() though

Oh... This is the invalidate_all path during invalidation

IMHO you should test the invalidation reason in the range to exclude
this.

But xa_erase looks totally safe so there should be no reason to do
that.

> This is a workaround for a problem I don't quite understand.
> If you change tools/testing/selftests/vm/hmm-tests.c line 868 to
> 	ASSERT_EQ(ret, -1);
> Then the test will abort, core dump, and cause two problems,
> 1) the migrated page will be faulted back to system memory in order to write
>    it to the core dump. This triggers lockdep_assert_held(&walk.mm->mmap_sem)
>    in walk_page_range().

Has the migration stuff become entangled with the xarray?

> [  137.980718] Code: 80 2f 1a 83 c6 05 e9 8d 7b 01 01 e8 3e b1 b1 fe e9 05 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 41 56 41 55 41 54 55 <48> 89 fd 53 4c 8d 6d 10 e8 3c fc ff ff 49 89 c4 4c 89 e0 83 e0 03
> [  137.999461] RSP: 0018:ffffc900015e77c8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> [  138.007028] RAX: ffff8886e508c408 RBX: 0000000000000000 RCX: ffffffff82626c89
> [  138.014159] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffc900015e78a0
> [  138.021293] RBP: ffffc900015e78a0 R08: ffffffff811461c4 R09: fffff520002bcf17
> [  138.028426] R10: fffff520002bcf16 R11: 0000000000000003 R12: 0000000002606d10
> [  138.035557] R13: ffff8886e508c448 R14: 0000000000000031 R15: ffffffffa06546a0
> [  138.042701]  ? do_raw_spin_lock+0x104/0x1d0
> [  138.046888]  ? xas_store+0x19/0xa60
> [  138.050390]  xas_store+0x5b3/0xa60
> [  138.053806]  ? register_lock_class+0x860/0x860
> [  138.058267]  __xa_erase+0x96/0x110
> [  138.061673]  ? xas_store+0xa60/0xa60
> [  138.065267]  xa_erase+0x19/0x30

oh, it is doing this:

static void mn_itree_release(struct mmu_notifier_subscriptions *subscriptions,
                             struct mm_struct *mm)
{
        struct mmu_notifier_range range = {
                .flags = MMU_NOTIFIER_RANGE_BLOCKABLE,
                .event = MMU_NOTIFY_RELEASE,
                .mm = mm,
                .start = 0,
                .end = ULONG_MAX,
        };

ie it is sitting doing a huge number of xa_erases, I suppose. Probably
in normal exit the notifier is removed before the mm is destroyed.

The xa_erase needs to be a bit smarter to jump over gaps in the tree
perhaps some

xa_for_each()
   xa_erase()

pattern?

> > Also I get this:
> > 
> > lib/test_hmm.c: In function ‘dmirror_devmem_fault_alloc_and_copy’:
> > lib/test_hmm.c:1041:25: warning: unused variable ‘vma’ [-Wunused-variable]
> >   1041 |  struct vm_area_struct *vma = args->vma;
> > 
> > But this is a kernel bug, due to alloc_page_vma being a #define not a
> > static inline and me having CONFIG_NUMA off in this .config
> 
> Fixed.

in gfp.h?

Jason
