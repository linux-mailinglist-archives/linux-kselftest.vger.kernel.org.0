Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D427D1337
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 17:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377820AbjJTPzf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 11:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377736AbjJTPze (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 11:55:34 -0400
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F99ED65;
        Fri, 20 Oct 2023 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=4Wxr8YyJBV
        Ji9dsEnvrWsVWlX7GW5YDL5ggU4ht88YY=; h=date:references:in-reply-to:
        subject:cc:to:from; d=openbsd.org; b=5uh8cM/3362zsHWWsOJQQ46mNmFkN73zH
        KtMFfu5/V5BQjgUqramyy6DLokJoEDDFiTXDZ9iUmZ33ICuFYcRAWnD1u1Dy6mL5GBBpzV
        cK0utCgesrjOUEgYntUsl8hY0EbCeuyTBqgYTMKlXmvilryrzM8byogl9HLQCThr3rMysD
        L82kOgtwM7VU3G72B8IDyDKGiKO5YgnzU3kOkbpogCOzuEGaVauGn0Zg2M1eCSwbcPzmIM
        GVGqBq3zKy+Lc0W0r82Inq0AQq5NBneSdFBScYh0F+MKxTGmaENtL7eSiIGg+yuhmKUFy/
        CQE/qsUjQmJsRTTtKDVa+NXOPLbbg==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
        by cvs.openbsd.org (OpenSMTPD) with ESMTP id 8d5b7bfa;
        Fri, 20 Oct 2023 09:55:28 -0600 (MDT)
From:   "Theo de Raadt" <deraadt@openbsd.org>
To:     =?us-ascii?Q?=3D=3FUTF-8=3FQ=3FStephen=5FR=3DC3=3DB6ttger=3F=3D?= 
        <sroettger@google.com>
cc:     Jeff Xu <jeffxu@google.com>, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, surenb@google.com,
        alex.sierra@amd.com, apopple@nvidia.com,
        aneesh.kumar@linux.ibm.com, axelrasmussen@google.com,
        ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com,
        dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com,
        joey.gouly@arm.com, corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
In-reply-to: <CAEAAPHbB0yZfpXGMib4bbH8z5diKfur5M6mAfZuB6qi9UVpcPw@mail.gmail.com>
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com> <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com> <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com> <55960.1697566804@cvs.openbsd.org> <CALmYWFs81T=XnT=AXQTo0+9FXo=OBAV_4rrYPSn9-16O-gBTZg@mail.gmail.com> <95482.1697587015@cvs.openbsd.org> <CALmYWFtQX57Z7ttKxrdXQH4QupFn4vi5KfizUBH9NkmP-S1JDw@mail.gmail.com> <ZS/3GCKvNn5qzhC4@casper.infradead.org> <CALmYWFu_uY=cWzAQaLtS0CdNrm+cO7tKz4sY2Ff02WQ8mGUUXw@mail.gmail.com> <7071.1697661373@cvs.openbsd.org> <CAEAAPHbB0yZfpXGMib4bbH8z5diKfur5M6mAfZuB6qi9UVpcPw@mail.gmail.com>
Comments: In-reply-to =?us-ascii?Q?=3D=3FUTF-8=3FQ=3FStephen=5FR=3DC3=3DB6?=
 =?us-ascii?Q?ttger=3F=3D?= <sroettger@google.com>
   message dated "Thu, 19 Oct 2023 10:28:32 +0200."
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 20 Oct 2023 09:55:28 -0600
Message-ID: <20251.1697817328@cvs.openbsd.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Stephen R=C3=B6ttger <sroettger@google.com> wrote:

> > > IMO: The approaches mimmutable() and mseal() took are different, but
> > > we all want to seal the memory from attackers and make the linux
> > > application safer.
> >
> > I think you are building mseal for chrome, and chrome alone.
> >
> > I do not think this will work out for the rest of the application space
> > because
> >
> > 1) it is too complicated
> > 2) experience with mimmutable() says that applications don't do any of =
it
> >    themselves, it is all in execve(), libc initialization, and ld.so.
> >    You don't strike me as an execve, libc, or ld.so developer.
>=20
> We do want to build this in a way that it can be applied automatically by=
 ld.so
> and we appreciate all your feedback on this.

Hi Stephen,

I am pretty sure your mechanism will be useable by ld.so.

What bothers me is the complex many-bits approach may encourage people
to set only a subset of the bits, and then believe they have a security
primitive.

Partial sealing is not safe.  I define partial sealing as "blocking munmap,
but not mprotect".  Or "blocking mprotect, but not madvise or mmap".

In Message-id <ZS/3GCKvNn5qzhC4@casper.infradead.org> Matthew stated there
that there are two aspects being locked: which object is mapped, and the
permission of that mapping.  When additional system calls msync() and madvi=
se()
are included in the picture, there are 3 actions being prevented:

 - Can someone replace the object
 - Can someone change the permission
 - Can someone throw away the cached pages, reverting to original
   content of the object (that is the madvise / msync)

In Message-id: <CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gm=
ail.com>
Jan reminded us of this piece.  I'm taking this as a long-standing security
hole in some sub-operations of msync/madvise which can write to data regions
that aren't actually writeable.  Sub-operations with this problem are MADV_=
FREE,
MADV_DONTNEED, POSIX_MADV_DONTNEED, MS_INVALIDATE.. on Linux MADV_WIPEONFOR=
K,
and probably a whole bunch of others.  I am testing OpenBSD changes which
demand PROT_WRITE permission for these sub-operations.  Perhaps some systems
are already careful.

If you leave any of these operators available, the object is not actually s=
ealed
against abuse.  I believe an attacker will simply switch to a different ope=
rator
(mmap, munmap, mprotect, madvise, msync) to achieve a similar objective of
damaging the permission or contents.

Since mseal() is designed to create partial sealings, the name of the propo=
sed
system call really smells.

> The intention of
> splitting the sealing
> by syscall was to provide flexibility while still allowing ld.so to
> seal all operations.

Yes, you will have ld.so set all the bits, and the same in C runtime
initialization.  If you convince glibc to stop make the stack executable
in dlopen(), the kernel could automatically do it.. With Linux backwards
compat management, getting there would be an extremely long long long
roadmap.  But anyways the idea would be "set all the bits".  Because otherw=
ise
the object or data isn't safe.

> Does Linus' proposal to just split munmap / mprotect sealing address your
> complexity concerns? ld.so would always use both flags which should then =
behave
> similar to mimmutable().

No, I think it is weak, because it isn't sealed.

A seperate mail in the thread from you says this is about chrome wanting
to use PKU on RWX objects.  I think that's the reason for wanting to
seperate the sealing (I haven't heard of other applications wanting that).
How about we explore that in the other subthread..

