Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115547D13F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 18:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjJTQ1e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 12:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTQ1e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 12:27:34 -0400
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA8BA3;
        Fri, 20 Oct 2023 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=qn+s27bmZY
        JOpVoNzboSU3Snd5iN0hcRbPkkiE9qcC4=; h=date:references:in-reply-to:
        subject:cc:to:from; d=openbsd.org; b=lDsu7por9y4kJ3nZ1Bfn3ZrvcfTuzTq6D
        i4ZGlLsZ/GX/8EK5YHqapM48NVRjDTFhavtYUAM3KZKrxr+BxrvxLIXL9mP1XkESh4ODGS
        XXG/xGlje/ElGR82Fj5DGbfJrnVMN3QRA8Uxc0ybJUS2kJH36+5AcdwzXSYT9CVlSFr+SM
        9q/2Zd6dHPJ1owM4MemmfTR+eTX9HhRhHDsGo6XKGEcRyF2FAafdHkmcuDKJ+3YDFtiqs/
        srZB89voPmzg4biEZBiarNxd0hSd0OhQ3Dsa0sr0IVEICQ63/VyILvYm+4scJzbBekLxqv
        pTYEoX74OtPds/Kud9giJQAwI6ayQ==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
        by cvs.openbsd.org (OpenSMTPD) with ESMTP id eeb066c3;
        Fri, 20 Oct 2023 10:27:31 -0600 (MDT)
From:   "Theo de Raadt" <deraadt@openbsd.org>
To:     =?us-ascii?Q?=3D=3FUTF-8=3FQ=3FStephen=5FR=3DC3=3DB6ttger=3F=3D?= 
        <sroettger@google.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Xu <jeffxu@google.com>, jeffxu@chromium.org,
        akpm@linux-foundation.org, keescook@chromium.org,
        jorgelo@chromium.org, groeck@chromium.org,
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
In-reply-to: <CAEAAPHYgg49WtpE7Jdq6HDecFp5RHPhdxtPTUaNF12RONu5aDA@mail.gmail.com>
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com> <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com> <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com> <55960.1697566804@cvs.openbsd.org> <CAHk-=wjS=xg12RVQdTNxEurjo21eXQBQO0D5My6Aox4LCfsO1A@mail.gmail.com> <CAEAAPHYgg49WtpE7Jdq6HDecFp5RHPhdxtPTUaNF12RONu5aDA@mail.gmail.com>
Comments: In-reply-to =?us-ascii?Q?=3D=3FUTF-8=3FQ=3FStephen=5FR=3DC3=3DB6?=
 =?us-ascii?Q?ttger=3F=3D?= <sroettger@google.com>
   message dated "Thu, 19 Oct 2023 10:00:33 +0200."
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 20 Oct 2023 10:27:31 -0600
Message-ID: <33724.1697819251@cvs.openbsd.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Stephen R=C3=B6ttger <sroettger@google.com> wrote:

> > I do like us starting with just "mimmutable()", since it already
> > exists. Particularly if chrome already knows how to use it.
> >
> > Maybe add a flag field (require it to be zero initially) just to allow
> > any future expansion. Maybe the chrome team has *wanted* to have some
> > finer granularity thing and currently doesn't use mimmutable() in some
> > case?
>=20
> Yes, we do have a use case in Chrome to split the sealing into unmap and
> mprotect which will allow us to seal additional pages that we can't seal =
with
> pure mimmutable().

> For example, we have pkey-tagged RWX memory that we want to seal. Since
> the memory is already RWX and the pkey controls write access, we don't ca=
re
> about permission changes but sometimes we do need to mprotect data only
> pages.

Let me try to decompose this statement.

This is clearly for the JIT. You can pivot between the a JIT generated
code mapping being RW and RX (or X-only), the object will pivot between
W or X to satisfy W^X policy for safety.

I think you are talking about a RWX MAP_ANON object.

Then you use pkey_alloc() to get a PKEY.  pkey_mprotect() sets the PKEY on
the region.  I argue you can then make it entirely immutable / sealed.

Let's say it is fully immutable / sealed.

After which, you can change the in-processor PKU register (using pkey_set)
to toggle the Write-Inhibit and eXecute-Inhibit bits on that key.

The immutable object has a dangerous RWX permission.  But the specific
PKEY making it either RX (or X-only) or RW depending upon your context.
The mapping is never exposed as RWX. The PKU model reduces the
permission access of the object below the immutable permission level.

The security depends on the PKEY WI/XI bits being difficult to control.

SADLY on x86, this is managed with a PKRU userland register which is change=
ble
without any supervisor control -- yes, it seems quite dangerous.
Changing it requires a complicated MSR dance.  It is unfortunate that
the pkey_set() library function is easily reachedable in the PLT via ROP
methods.  On non-x86 cpus that have similar functionality, the register
is privileged, but operating supporting it generally change it and
return immediately.

The problem you seem to have with fully locked mseal() in chrome seems
to be here:

> about permission changes but sometimes we do need to mprotect data only
> pages.

Does that data have to be in the same region?  Can your allocator not
put the non-code pieces of the JIT elsewhere, with a different
permission, fully immutable / msealed -- and perhaps even managed with a
different PKEY if neccessary?

May that requires a huge rearchitecture.  But isn't the root problem here
that data and code are being handled in the same object with a shared
permission model?

> But the munmap sealing will provide protection against implicit changes o=
f the
> pkey in this case which would happen if a page gets unmapped and another
> mapped in its place.

That primitive feels so weird, I have a difficult time believing it will
remain unattackable in the long term.


But what if you could replace mprotect() with pkey_mprotect() upon a
different key.. ?

--

A few more notes comparing what OpenBSD has done compared to Linux:


In OpenBSD, we do not have the pkey library.  We have stolen one of the
PKEY and use it for kernel support of xonly for kernel code and userland
code.  On x86 we recognize that userland can flip the permission by whacking
the RPKU register -- which would make xonly code readable.  (The chrome data
you are trying to guard faces the same problem).

To prevent that, a majority of traps in the kernel (page faults,
interrupts, etc) check if the PKRU register has been modified, and kill
the process.  It is statistically strong.

We are not making pkey available as a userland feature, but if we later
do so we would still have 15 pkeys to play with.  We would probably make
the pkey_set() operation a system call, so the trap handler can also
observe RPKU register modifications by the instruction.

Above, I mentioned pivoting between "RW or RX (or X-only)".  On OpenBSD, ch=
rome would be
able to pivot between RW and X-only.

When it comes to Pkey utilization, we've ended up in a very different
place than Linux.


