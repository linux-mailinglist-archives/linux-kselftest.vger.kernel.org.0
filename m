Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672EA6E86F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 02:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjDTAvB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Apr 2023 20:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjDTAud (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Apr 2023 20:50:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD757A9F
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Apr 2023 17:50:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54ee12aa4b5so11847577b3.4
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Apr 2023 17:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681951797; x=1684543797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WElRL1S1A/l6yYWkPjKb60TbLP43vB7Va3vAhnMHy4o=;
        b=0KQvDXHLR89BVxU2oI9O1ZusFid2YKHOcipULiVP6+PSDHwriZYqd2A06zVvzb+5zg
         +1pAM1zXlSNPZvINL7u8jaguPJCIxfMpOP+rF/bo3e7YipW5A5h9Z1uQ5Ne2aQDNcW6c
         EcQXFII0XVCoUfr19ADWbM/w1kzMojqRNFL4dpL0bA9tYUhTVMdjBXnH0ldjTdoS4rfS
         B4qULmS58/9Ub/zlvy0EPJx+IEG/RXiTWy5ry2WStJSaH5TR16lXIzvnkE2V+5Qqr+ic
         KCotEARF8eci5Ax95+I+ZNzK3NrfAcOPUHTnTLXEbEOQev6PRHk+rxhdkpcXFMAn0sKn
         YqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681951797; x=1684543797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WElRL1S1A/l6yYWkPjKb60TbLP43vB7Va3vAhnMHy4o=;
        b=V7shAZHHV8lmQalaWOZLz67lz1MQUdsafWwNLG1ndRUcKgbICd0pvP26anhXXW1Xgr
         uC7ca+4QWe0G/CuSWngVo9DYn3DEL1GgVYCU2Siph1JwQTYq6+l/yrYhsvdVNlmFnbxq
         +VaDokU5uKqraPw7KLvD6jphlJKKgKii1QioiERIxKBNewViFZl9CwWuot9zaTlPn+0k
         OqyoRffToAJkT4poErxgb5+a35TkUXWv2MVz6/AhaV9VOpqYpsy4uwf8llbaIiszvrMr
         o5QPXv2J0gyrCn1DmvgZ3eWZSex/74CsM/dcCu/ja0TmH5nvhBtjQ3ixlk2cK9wS1m3m
         4INg==
X-Gm-Message-State: AAQBX9fkoc5HQaHH7Sea5xH6y4dLKSswqCwSQe9+SFZExCJ88UwtQOyK
        Gyb3r48rhLKr0x5X3Ey4V4Yvdzr89WE=
X-Google-Smtp-Source: AKy350ZW3QSDcu1b4uay718+0UKdCoR5698g0B4gA8e9kbzHBPJ0H7w91zco9M9KgDo6hSqXOcwRuk93omk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d24c:0:b0:b95:460c:1776 with SMTP id
 j73-20020a25d24c000000b00b95460c1776mr766347ybg.13.1681951797267; Wed, 19 Apr
 2023 17:49:57 -0700 (PDT)
Date:   Wed, 19 Apr 2023 17:49:55 -0700
In-Reply-To: <20230418-anfallen-irdisch-6993a61be10b@brauner>
Mime-Version: 1.0
References: <20220818132421.6xmjqduempmxnnu2@box> <diqzlej60z57.fsf@ackerleytng-cloudtop.c.googlers.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com> <20230413-anlegen-ergibt-cbefffe0b3de@brauner>
 <ZDiCG/7OgDI0SwMR@google.com> <20230418-anfallen-irdisch-6993a61be10b@brauner>
Message-ID: <ZECMM9bjgGRdyXRy@google.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
From:   Sean Christopherson <seanjc@google.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>,
        linux-arch@vger.kernel.org, arnd@arndb.de, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, tabba@google.com, wei.w.wang@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 19, 2023, Christian Brauner wrote:
> On Thu, Apr 13, 2023 at 03:28:43PM -0700, Sean Christopherson wrote:
> > > But if you want to preserve the inode number and device number of the
> > > relevant tmpfs instance but still report memfd restricted as your
> > > filesystem type
> > 
> > Unless I missed something along the way, reporting memfd_restricted as a distinct
> > filesystem is very much a non-goal.  AFAIK it's purely a side effect of the
> > proposed implementation.
> 
> In the current implementation you would have to put in effort to fake
> this. For example, you would need to also implement ->statfs
> super_operation where you'd need to fill in the details of the tmpfs
> instance. At that point all that memfd_restricted fs code that you've
> written is nothing but deadweight, I would reckon.

After digging a bit, I suspect the main reason Kirill implemented an overlay to
inode_operations was to prevent modifying the file size via ->setattr().  Relying
on shmem_setattr() to unmap entries in KVM's MMU wouldn't work because, by design,
the memory can't be mmap()'d into host userspace. 

	if (attr->ia_valid & ATTR_SIZE) {
		if (memfd->f_inode->i_size)
			return -EPERM;

		if (!PAGE_ALIGNED(attr->ia_size))
			return -EINVAL;	
	}

But I think we can solve this particular problem by using F_SEAL_{GROW,SHRINK} or
SHMEM_LONGPIN.  For a variety of reasons, I'm leaning more and more toward making
this a KVM ioctl() instead of a dedicated syscall, at which point we can be both
more flexible and more draconian, e.g. let userspace provide the file size at the
time of creation, but make the size immutable, at least by default.

> > After giving myself a bit of a crash course in file systems, would something like
> > the below have any chance of (a) working, (b) getting merged, and (c) being
> > maintainable?
> > 
> > The idea is similar to a stacking filesystem, but instead of stacking, restrictedmem
> > hijacks a f_ops and a_ops to create a lightweight shim around tmpfs.  There are
> > undoubtedly issues and edge cases, I'm just looking for a quick "yes, this might
> > be doable" or a "no, that's absolutely bonkers, don't try it".
> 
> Maybe, but I think it's weird.

Yeah, agreed.

> _Replacing_ f_ops isn't something that's unprecedented. It happens everytime
> a character device is opened (see fs/char_dev.c:chrdev_open()). And debugfs
> does a similar (much more involved) thing where it replaces it's proxy f_ops
> with the relevant subsystem's f_ops. The difference is that in both cases the
> replace happens at ->open() time; and the replace is done once. Afterwards
> only the newly added f_ops are relevant.
> 
> In your case you'd be keeping two sets of {f,a}_ops; one usable by
> userspace and another only usable by in-kernel consumers. And there are
> some concerns (non-exhaustive list), I think:
> 
> * {f,a}_ops weren't designed for this. IOW, one set of {f,a}_ops is
>   authoritative per @file and it is left to the individual subsystems to
>   maintain driver specific ops (see the sunrpc stuff or sockets).
> * lifetime management for the two sets of {f,a}_ops: If the ops belong
>   to a module then you need to make sure that the module can't get
>   unloaded while you're using the fops. Might not be a concern in this
>   case.

Ah, whereas I assume the owner of inode_operations is pinned by ??? (dentry?)
holding a reference to the inode?

> * brittleness: Not all f_ops for example deal with userspace
>   functionality some deal with cleanup when the file is closed like
>   ->release(). So it's delicate to override that functionality with
>   custom f_ops. Restricted memfds could easily forget to cleanup
>   resources.
> * Potential for confusion why there's two sets of {f,a}_ops.
> * f_ops specifically are generic across a vast amount of consumers and
>   are subject to change. If memfd_restricted() has specific requirements
>   because of this weird double-use they won't be taken into account.
> 
> I find this hard to navigate tbh and it feels like taking a shortcut to
> avoid building a proper api.

Agreed.  At the very least, it would be better to take an explicit dependency on
whatever APIs are being used instead of somewhat blindly bouncing through ->fallocate().
I think that gives us a clearer path to getting something merged too, as we'll
need Acks on making specific functions visible, i.e. will give MM maintainers
something concrete to react too.

> If you only care about a specific set of operations specific to memfd
> restricte that needs to be available to in-kernel consumers, I wonder if you
> shouldn't just go one step further then your proposal below and build a
> dedicated minimal ops api.

This is actually very doable for shmem.  Unless I'm missing something, because
our use case doesn't allow mmap(), swap, or migration, a good chunk of
shmem_fallocate() is simply irrelevant.  The result is only ~100 lines of code,
and quite straightforward.

My biggest concern, outside of missing a detail in shmem, is adding support for
HugeTLBFS, which is likely going to be requested/needed sooner than later.  At a
glance, hugetlbfs_fallocate() is quite a bit more complex, i.e. not something I'm
keen to duplicate.  But that's also a future problem to some extent, as it's
purely kernel internals; the uAPI side of things doesn't seem like it'll be messy
at all.

Thanks again!
