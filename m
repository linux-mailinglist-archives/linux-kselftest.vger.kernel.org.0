Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3B75E0A43
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2019 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbfJVRPA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Oct 2019 13:15:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57489 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731795AbfJVRPA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Oct 2019 13:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571764499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnqQpohuKQ9uYTM7VPMOk3S+s+Sz5MTWH/R9yn2bwqA=;
        b=TFkUSbsNVm4sJEeniTyKuwOl1q6F6Tb9jK4Ixg1Jmc9cQqDY7+7GCEhFZGvbrRhLLmxKa/
        VFilB51CO47MYlIxEpSRiHhXU1atIWTD+u+8d2+KGatEbWi9Z+1zWf/guIRvwGa4jmGgxn
        QqrEG0cx+J/M+AYwxlsTGhMUZzdESWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-Jldqq01BOAOUQbEbYa4rKg-1; Tue, 22 Oct 2019 13:14:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E80591005509;
        Tue, 22 Oct 2019 17:14:54 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 557C71001B22;
        Tue, 22 Oct 2019 17:14:54 +0000 (UTC)
Date:   Tue, 22 Oct 2019 13:14:52 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/gup_benchmark: fix MAP_HUGETLB case
Message-ID: <20191022171452.GA5169@redhat.com>
References: <20191021212435.398153-1-jhubbard@nvidia.com>
 <20191021212435.398153-2-jhubbard@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20191021212435.398153-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Jldqq01BOAOUQbEbYa4rKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 21, 2019 at 02:24:35PM -0700, John Hubbard wrote:
> The MAP_HUGETLB ("-H" option) of gup_benchmark fails:
>=20
> $ sudo ./gup_benchmark -H
> mmap: Invalid argument
>=20
> This is because gup_benchmark.c is passing in a file descriptor to
> mmap(), but the fd came from opening up the /dev/zero file. This
> confuses the mmap syscall implementation, which thinks that, if the
> caller did not specify MAP_ANONYMOUS, then the file must be a huge
> page file. So it attempts to verify that the file really is a huge
> page file, as you can see here:
>=20
> ksys_mmap_pgoff()
> {
>     if (!(flags & MAP_ANONYMOUS)) {
>         retval =3D -EINVAL;
>         if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(file)))
>             goto out_fput; /* THIS IS WHERE WE END UP */
>=20
>     else if (flags & MAP_HUGETLB) {
>         ...proceed normally, /dev/zero is ok here...
>=20
> ...and of course is_file_hugepages() returns "false" for the /dev/zero
> file.
>=20
> The problem is that the user space program, gup_benchmark.c, really just
> wants anonymous memory here. The simplest way to get that is to pass
> MAP_ANONYMOUS whenever MAP_HUGETLB is specified, so that's what this
> patch does.

This looks wrong, MAP_HUGETLB should only be use to create vma
for hugetlbfs. If you want anonymous private vma do not set the
MAP_HUGETLB. If you want huge page inside your anonymous vma
there is nothing to do at the mmap time, this is the job of the
transparent huge page code (THP).

NAK as misleading

Cheers,
J=E9r=F4me

