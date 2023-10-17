Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A27CCB52
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 20:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343689AbjJQSzG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 14:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjJQSzF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 14:55:05 -0400
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A69FC;
        Tue, 17 Oct 2023 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=nltAwsLnVc
        o8Ol3OOUaPBGv1UdYJKAJvkuezLI48KVs=; h=date:references:in-reply-to:
        subject:cc:to:from; d=openbsd.org; b=8xwIonPTgs5mDltwxve/VanHgI0S5pOMV
        r3DRia+EKAbNalzQ8JRX2Amk9L1RYwHUWowf+ECZ+JuhNYSGBSpYlbBgfgX86UGBTCXjoH
        wwbJhZOx/gCpNq6wZSObg695vA1FRW9rLvSWVfTKdOjot3/uWB7YUedZPcn2BlPA6o/nAK
        43Re55EP1rS//OSdUm8FY5T34SaTav9Ufb4evq1lyA38xQr3BWH1I6iKvb0Iqz0CFXqgfJ
        wM2LaB0vIkEnB8kWbahyz2vV8TsQD5Y7z9bHZB2nyy6YyOdMTPj4kEWNF75aZxLv5O40kx
        YyBV47e7tbtJPiwZhUTzq8rNQ1raw==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
        by cvs.openbsd.org (OpenSMTPD) with ESMTP id 0883e4b1;
        Tue, 17 Oct 2023 12:55:01 -0600 (MDT)
From:   "Theo de Raadt" <deraadt@openbsd.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Jeff Xu <jeffxu@google.com>, jeffxu@chromium.org,
        akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, surenb@google.com,
        alex.sierra@amd.com, apopple@nvidia.com,
        aneesh.kumar@linux.ibm.com, axelrasmussen@google.com,
        ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com,
        dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com,
        joey.gouly@arm.com, corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, willy@infradead.org,
        mawupeng1@huawei.com, linmiaohe@huawei.com, namit@vmware.com,
        peterx@redhat.com, peterz@infradead.org, ryan.roberts@arm.com,
        shr@devkernel.io, vbabka@suse.cz, xiujianfeng@huawei.com,
        yu.ma@intel.com, zhangpeng362@huawei.com, dave.hansen@intel.com,
        luto@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
In-reply-to: <CAHk-=wjS=xg12RVQdTNxEurjo21eXQBQO0D5My6Aox4LCfsO1A@mail.gmail.com>
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com> <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com> <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com> <55960.1697566804@cvs.openbsd.org> <CAHk-=wjS=xg12RVQdTNxEurjo21eXQBQO0D5My6Aox4LCfsO1A@mail.gmail.com>
Comments: In-reply-to Linus Torvalds <torvalds@linux-foundation.org>
   message dated "Tue, 17 Oct 2023 11:38:19 -0700."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68270.1697568901.1@cvs.openbsd.org>
Date:   Tue, 17 Oct 2023 12:55:01 -0600
Message-ID: <19404.1697568901@cvs.openbsd.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 17 Oct 2023 at 11:20, Theo de Raadt <deraadt@openbsd.org> wrote:
> >
> > The only case where the immutable marker is ignored is during address space
> > teardown as a result of process termination.
> 
> .. and presumably also execve()?

Ah yes of course that also.

> I do like us starting with just "mimmutable()", since it already
> exists. Particularly if chrome already knows how to use it.

Well, our chrome fork knows how to use it.  Robert Nagy in our group maintains
1280 patches to make chrome work on OpenBSD.  Google ignores them and will not
upstream them.  Some of these changes are security related, and they ignore
them.  Other changes are to cope with security work we've done on our own,
for example: JIT changes from Stephen@google for mandatory IBT which google
hasn't upstreamed yet, impacts due to PROT_EXEC-only mappings, etc.

But the only chrome diff required for mimmutable is for that v8_flags thing
I described.   And the same issue would need handling for mseal().  Introducing
the new "mutable" ELF section is probably going to be a bigger fuss than the
system call after mprotect(PROT_READ)....

> Maybe add a flag field (require it to be zero initially) just to allow
> any future expansion. Maybe the chrome team has *wanted* to have some
> finer granularity thing and currently doesn't use mimmutable() in some
> case?

There's only one feature I can think of, and we already do it right now,
documented in our manual page:

CAVEATS
     At present, mprotect(2) may reduce permissions on immutable pages marked
     PROT_READ | PROT_WRITE to the less permissive PROT_READ.  This one-way
     operation is permitted for an introductory period to observe how software
     uses this mechanism.  It may change to require explicit mutable region
     annotation with __attribute__((section(".openbsd.mutable"))) and explicit
     calls to mimmutable().

We had something which needed this behaviour during the development
transition.  It is exlusively mprotect RW -> R, no other transitions
allowed.

But once the transition was done, we don't need it anymore.  I want to
delete it, because it is a bit of a trap.  It still fails closed from an
attack perspective, but...

What worries me is a piece of code reached by mistake can do a
mprotect(lowering), not receive -1 EPERM, and carry on running..  I'd
prefer the first time you touch a mapping in the wrong way, you receive
indication of error.  This only applies applies to mprotect() acting up
on a region so the argument is a bit weak, due to mprotect() return
value checking being about as rare as unicorns.

Also, it would be a pain for OpenBSD to transition to adding a 0 flag.
I would need to see real cause not theory.
