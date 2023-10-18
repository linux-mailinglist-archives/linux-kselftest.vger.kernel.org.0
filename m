Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B747CE0F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 17:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjJRPSF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 11:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjJRPSE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 11:18:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0BB94;
        Wed, 18 Oct 2023 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EYJWM82k/mYbNh1hfZQ8KkV147YIzBIZxX71F7kjj3o=; b=SP8eWuThWrXi0c+GKIfuQmjZth
        m8/aZFY0nYGaQzDsejHx0z/V6t3NsJjeORp/uGXzhj39+OR2w2/oRsloh++YDaE2cTL3KmaFAfJOn
        1abJTfFo5CEZEKuPxBZ0FPFkDnDehbk+hCyRjsxjHUY6NXG0/A+MD2FRrLo2JYgFo8BaKNUaq0SEz
        /+odCu/MMdB5q5sBf9XxYOBN376/6smqd3AYT/9m7BwfQC9Adp6kQQhqG383BL57eLzLWs8latknJ
        yTnbdZ1C+yUGO2QdDKTttULIj+JqxIRcKc4PdhojxFG7PgO/UW0fs6OY8VbZXahhYtUOFINnnIjMs
        tVn/tT0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qt8Iq-001bDQ-Mh; Wed, 18 Oct 2023 15:17:44 +0000
Date:   Wed, 18 Oct 2023 16:17:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Xu <jeffxu@google.com>
Cc:     Theo de Raadt <deraadt@openbsd.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, sroettger@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
Message-ID: <ZS/3GCKvNn5qzhC4@casper.infradead.org>
References: <20231016143828.647848-1-jeffxu@chromium.org>
 <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com>
 <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com>
 <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com>
 <55960.1697566804@cvs.openbsd.org>
 <CALmYWFs81T=XnT=AXQTo0+9FXo=OBAV_4rrYPSn9-16O-gBTZg@mail.gmail.com>
 <95482.1697587015@cvs.openbsd.org>
 <CALmYWFtQX57Z7ttKxrdXQH4QupFn4vi5KfizUBH9NkmP-S1JDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALmYWFtQX57Z7ttKxrdXQH4QupFn4vi5KfizUBH9NkmP-S1JDw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 17, 2023 at 08:18:47PM -0700, Jeff Xu wrote:
> In practice: libc could do below:
> #define MM_IMMUTABLE
> (MM_SEAL_MPROTECT|MM_SEAL_MUNMAP|MM_SEAL_MREMAP|MM_SEAL_MMAP)
> mseal(add,len, MM_IMMUTABLE)
> it will be equivalent to BSD's immutable().

No, it wouldn't, because you've carefully listed the syscalls you're
blocking instead of understanding the _concept_ of what you need to
block.

> In linux cases, I think, eventually, mseal() will have a bigger scope than
> BSD's mimmutable().  VMA's metadata(vm_area_struct) contains a lot
> of control info, depending on application's needs, mseal() can be
> expanded to seal individual control info.
> 
> For example, in madvice(2) case:
> As Jann point out in [1] and I quote:
> "you'd probably also want to block destructive madvise() operations
> that can effectively alter region contents by discarding pages and
> such, ..."
> 
> Another example: if an application wants to keep a memory always
> present in RAM, for whatever the reason, it can call seal the mlock().
> 
> To handle those two new cases. mseal() could add two more bits:
> MM_SEAL_MADVICE, MM_SEAL_MLOCK.

Yes, thank you for demonstrating that you have no idea what you need to
block.

> It is practical to keep syscall extentable, when the business logic is the same.

I concur with Theo & Linus.  You don't know what you're doing.  I think
the underlying idea of mimmutable() is good, but how you've split it up
and how you've implemented it is terrible.

Let's start with the purpose.  The point of mimmutable/mseal/whatever is
to fix the mapping of an address range to its underlying object, be it
a particular file mapping or anonymous memory.  After the call succeeds,
it must not be possible to make any address in that virtual range point
into any other object.

The secondary purpose is to lock down permissions on that range.
Possibly to fix them where they are, possibly to allow RW->RO transitions.

With those purposes in mind, you should be able to deduce for any syscall
or any madvise(), ... whether it should be allowed.

Look, I appreciate this is only your second set of patches to Linux and
you've taken on a big job.  But that's all the more reason you should
listen to people who are trying to help you.
