Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F923E0C10
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2019 20:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732797AbfJVS5M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Oct 2019 14:57:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42854 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731740AbfJVS5L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Oct 2019 14:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571770630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmXtv+xjVUY0EdjSkqIq2Jgpn3pXg6NOTpjVb7VJr9k=;
        b=hwXuxVAdIO58bzYevgyD1T88tmfiOf+7CnTJrEhGCkd6O+SGEM9ra6j5KyL17i5hwBOVjU
        EJ6HQK1JpQmjszWh/n4zpumU8Mvz6oa1RBs3qRa+b67hERWH0fJjmTwzZZIRasG2uiWlqu
        rI0/fgDqARN881PvEuVVLCkW+4kkeYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-KFcFTeHvPCiuzixU_R4e4g-1; Tue, 22 Oct 2019 14:57:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 147D780183D;
        Tue, 22 Oct 2019 18:57:04 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 736165C1D4;
        Tue, 22 Oct 2019 18:57:03 +0000 (UTC)
Date:   Tue, 22 Oct 2019 14:57:01 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/gup_benchmark: fix MAP_HUGETLB case
Message-ID: <20191022185701.GD5169@redhat.com>
References: <20191021212435.398153-1-jhubbard@nvidia.com>
 <20191021212435.398153-2-jhubbard@nvidia.com>
 <20191022171452.GA5169@redhat.com>
 <1095fd94-1c0b-de61-7ceb-c963e29575b6@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1095fd94-1c0b-de61-7ceb-c963e29575b6@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: KFcFTeHvPCiuzixU_R4e4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 22, 2019 at 11:41:57AM -0700, John Hubbard wrote:
> On 10/22/19 10:14 AM, Jerome Glisse wrote:
> > On Mon, Oct 21, 2019 at 02:24:35PM -0700, John Hubbard wrote:
> >> The MAP_HUGETLB ("-H" option) of gup_benchmark fails:
> >>
> >> $ sudo ./gup_benchmark -H
> >> mmap: Invalid argument
> >>
> >> This is because gup_benchmark.c is passing in a file descriptor to
> >> mmap(), but the fd came from opening up the /dev/zero file. This
> >> confuses the mmap syscall implementation, which thinks that, if the
> >> caller did not specify MAP_ANONYMOUS, then the file must be a huge
> >> page file. So it attempts to verify that the file really is a huge
> >> page file, as you can see here:
> >>
> >> ksys_mmap_pgoff()
> >> {
> >>     if (!(flags & MAP_ANONYMOUS)) {
> >>         retval =3D -EINVAL;
> >>         if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(file)))
> >>             goto out_fput; /* THIS IS WHERE WE END UP */
> >>
> >>     else if (flags & MAP_HUGETLB) {
> >>         ...proceed normally, /dev/zero is ok here...
> >>
> >> ...and of course is_file_hugepages() returns "false" for the /dev/zero
> >> file.
> >>
> >> The problem is that the user space program, gup_benchmark.c, really ju=
st
> >> wants anonymous memory here. The simplest way to get that is to pass
> >> MAP_ANONYMOUS whenever MAP_HUGETLB is specified, so that's what this
> >> patch does.
> >=20
> > This looks wrong, MAP_HUGETLB should only be use to create vma
> > for hugetlbfs. If you want anonymous private vma do not set the
> > MAP_HUGETLB. If you want huge page inside your anonymous vma
> > there is nothing to do at the mmap time, this is the job of the
> > transparent huge page code (THP).
> >=20
>=20
> Not the point. Please look more closely at ksys_mmap_pgoff(). You'll=20
> see that, since 2009 (and probably earlier; 2009 is just when Hugh Dicken=
s=20
> moved it over from util.c), this routine has had full support for using
> hugetlbfs automatically, via mmap.
>=20
> It does that via hugetlb_file_setup():
>=20
> unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
> =09=09=09      unsigned long prot, unsigned long flags,
> =09=09=09      unsigned long fd, unsigned long pgoff)
> {
> ...
> =09if (!(flags & MAP_ANONYMOUS)) {
> ...
> =09} else if (flags & MAP_HUGETLB) {
> =09=09struct user_struct *user =3D NULL;
> =09=09struct hstate *hs;
>=20
> =09=09hs =3D hstate_sizelog((flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
> =09=09if (!hs)
> =09=09=09return -EINVAL;
>=20
> =09=09len =3D ALIGN(len, huge_page_size(hs));
> =09=09/*
> =09=09 * VM_NORESERVE is used because the reservations will be
> =09=09 * taken when vm_ops->mmap() is called
> =09=09 * A dummy user value is used because we are not locking
> =09=09 * memory so no accounting is necessary
> =09=09 */
> =09=09file =3D hugetlb_file_setup(HUGETLB_ANON_FILE, len,
> =09=09=09=09VM_NORESERVE,
> =09=09=09=09&user, HUGETLB_ANONHUGE_INODE,
> =09=09=09=09(flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
> =09=09if (IS_ERR(file))
> =09=09=09return PTR_ERR(file);
> =09}
> ...
>=20
>=20
> Also, there are 14 (!) other pre-existing examples of passing
> MAP_HUGETLB | MAP_ANONYMOUS to mmap, so I'm not exactly the first one
> to reach this understanding.
>=20
>=20
> > NAK as misleading
>=20
> Ouch. But I think I'm actually leading correctly, rather than misleading.
> Can you prove me wrong? :)

So i was misslead by the file descriptor, passing a file descriptor and
asking for anonymous always bugs me. But yeah the _linux_ kernel is happy
to ignore the file argument if you set the anonymous flag. I guess the
rules of passing -1 for fd when anonymous is just engrave in my brain.

Also i thought that the file was an argument of the test and thus that
for huge you needed to pass a hugetlbfs' file.

Anyway my mistake, you are right, you can pass a file and ask for anonymous
and hugetlb at the same time.

Reviewed-by: J=E9r=F4me Glisse <jglisse@redhat.com>

