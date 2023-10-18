Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADEE7CE919
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 22:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjJRUgU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 16:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjJRUgT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 16:36:19 -0400
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C760E9F;
        Wed, 18 Oct 2023 13:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=QWshJ3q0CW
        z66rkm4YqP7BTMbsMVrEYYbR/yILapp8Q=; h=date:references:in-reply-to:
        subject:cc:to:from; d=openbsd.org; b=ZQX3DGaSR+jOPuhULTujDPgl6aQpN9KuN
        gkvVNbu/uJzrcaVSBOPHJ6dvubIemeu4UDb7Lz4jF9Xxgu0aYinyXtirWEjOpnIn6eYy7W
        LdYoAlcHB28FhisY6YPTtKjbgfs16deat7bmpxb8RQYqu18SAa/XEuW4yqilS7oyycVzh4
        4ZnQPden+AqQCDDCbKPo5vkMNkrQN/bfHbJzjkc+kwZbUzhlabKs6r622pTPH1p3QoQHx+
        oLEzpQ+VIfeFw1AXzvqe4JsvLglRoDkc6FGrcvBBsEQivtO8T0yA9JL72qY4VIj/v6gCMx
        +hK54KiqMvQIZIeJKJk6cfh7eXZAA==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
        by cvs.openbsd.org (OpenSMTPD) with ESMTP id 681028d6;
        Wed, 18 Oct 2023 14:36:13 -0600 (MDT)
From:   "Theo de Raadt" <deraadt@openbsd.org>
To:     Jeff Xu <jeffxu@google.com>
cc:     Matthew Wilcox <willy@infradead.org>,
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
In-reply-to: <CALmYWFu_uY=cWzAQaLtS0CdNrm+cO7tKz4sY2Ff02WQ8mGUUXw@mail.gmail.com>
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com> <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com> <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com> <55960.1697566804@cvs.openbsd.org> <CALmYWFs81T=XnT=AXQTo0+9FXo=OBAV_4rrYPSn9-16O-gBTZg@mail.gmail.com> <95482.1697587015@cvs.openbsd.org> <CALmYWFtQX57Z7ttKxrdXQH4QupFn4vi5KfizUBH9NkmP-S1JDw@mail.gmail.com> <ZS/3GCKvNn5qzhC4@casper.infradead.org> <CALmYWFu_uY=cWzAQaLtS0CdNrm+cO7tKz4sY2Ff02WQ8mGUUXw@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@google.com>
   message dated "Wed, 18 Oct 2023 11:54:22 -0700."
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 18 Oct 2023 14:36:13 -0600
Message-ID: <7071.1697661373@cvs.openbsd.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Jeff Xu <jeffxu@google.com> wrote:

> On Wed, Oct 18, 2023 at 8:17=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > Let's start with the purpose.  The point of mimmutable/mseal/whatever is
> > to fix the mapping of an address range to its underlying object, be it
> > a particular file mapping or anonymous memory.  After the call succeeds,
> > it must not be possible to make any address in that virtual range point
> > into any other object.
> >
> > The secondary purpose is to lock down permissions on that range.
> > Possibly to fix them where they are, possibly to allow RW->RO transitio=
ns.
> >
> > With those purposes in mind, you should be able to deduce for any sysca=
ll
> > or any madvise(), ... whether it should be allowed.
> >
> I got it.
>=20
> IMO: The approaches mimmutable() and mseal() took are different, but
> we all want to seal the memory from attackers and make the linux
> application safer.

I think you are building mseal for chrome, and chrome alone.

I do not think this will work out for the rest of the application space
because

1) it is too complicated
2) experience with mimmutable() says that applications don't do any of it
   themselves, it is all in execve(), libc initialization, and ld.so.
   You don't strike me as an execve, libc, or ld.so developer.


