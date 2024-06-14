Return-Path: <linux-kselftest+bounces-11979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A87909300
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 21:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AEC21C221AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3334719DF5D;
	Fri, 14 Jun 2024 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s174N3aL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22D1F946
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718393796; cv=none; b=r4PCZ/mrhMxvvgnet7/tNIGIHX+fB9HAQjrh3TtLlLHgOjWbR5RDiyZ9ROyJHOcC9SrXAYyYqBp1gyPY6gE6tve3EhVZHqDnGuPjETo5ND3ifONob4oT9tmkA0Mgw7DvKPf/DdMr9WkNkmkul7LVyBuetfnIjRNahfg/jKgD2Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718393796; c=relaxed/simple;
	bh=uzavtBYjGVA7UxI1rmNYelxeceegnAfEW5RP7HvGBQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7sWtxpHwGydLgGh3l4o5RX16RMkNTN0AcfEqUfxyWP/2ETQDJgU0Y4B90S6FSVyq7RwQkVsAB20sC/YMn4G458IjXdbQsbtpY7VVSORmgo1ncAxBc0uAQkzWb7VdR9w7txW6xrwtHwPirKKcVrMu15W2mht7CBRGg244dfrflQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s174N3aL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so21130535e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718393791; x=1718998591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbopwMHWkV45wIqmjDY+g847NFMSr7NrSEAY9QIEam4=;
        b=s174N3aLsuntR+zpf1SJx23OB5N/a/27zGpbokmlOOwwrxAV3qCqtWywisOBxHClUM
         JDwEg2dN1jPTHUVOe0b8Jnqs5nh1lskb6shG+VuXFVwf93NJm5rQDzZ7mnf0qYDGUVxg
         HgmB3KIYOakg1Tlg0RB7scaUYmbcqzaD8woblFFkGbyjGTQy9//rEhPsT8fUH4AOOqXO
         JpnBMuFpo71t6BaiuWlbpl2msUzXv5KptHCIrPyhDa8syxzCMRBVNRwnJ4Eht+yvsw4a
         4RY90QG5F5t5SLGceViXJPbNzUcTQCHlko5/YEf2IcJIR4L9S3iFvkQEkmW21q5H1r7t
         U9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718393791; x=1718998591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbopwMHWkV45wIqmjDY+g847NFMSr7NrSEAY9QIEam4=;
        b=BdMJrTi+gfQ23Bx/Ku4EDndasOO/NPYwa8OB2jWhE0uyEDBn1ZxXip9x/n1decX7Fv
         Q50onnxM92emyHRLis3ERiBIyocU21ghvd+8KkvY/+TCKAG1eA1S/rpqEJfMc+SWXVIc
         dAVz0IiIXi838kQvNr0sr4tgE24sCevv+5/O7UXT9K6ccyTT/2vzO8lzmJ21A3iKRywM
         rhzM/F3015tDTo8n0fsqYu17IEfRBXWxye64DyTBcVvmYZ3OjeP+jLQAGDXOKKWbv0Xm
         AeGbOUDwp3M7H7YIYhGuWD9zw1A+d187s/uBFjepjE8mo8w4JhsUtNYbSU3Q2BIqbw7a
         Wmjg==
X-Forwarded-Encrypted: i=1; AJvYcCWw+RVFRd8Sz7VQuLrgHFijrk5Cy+MMAPIa5XbPFNe7fiYmeq9Jbh1D6c8gcLCtnlygcakPp3TBtgoPaPAPIkR6QVmhW4hUzOtFeLsW1jWq
X-Gm-Message-State: AOJu0YwU+DRCWkXiWR7uPt/ReKBAz9dtfniRVBtgsmgZZ5c1zgjBt8ph
	sbEvae2+fHxsINyqrDOR+NgZLkUGVjqZmqPFEJYUztEth/t8ac7irb5udy/9fHj5mj5/a7CBCPt
	dV5buuJ4rbFjvvCRpAHp5CGWyMyT8/9//kKz0
X-Google-Smtp-Source: AGHT+IE36tamiKDJKDMN4OR0mpDMyrXnQye01agHTETm+6906OLYhNWDC7szFItiXoC91Ax4dhigBIW0dI9cEBYYkvk=
X-Received: by 2002:a05:600c:b43:b0:421:8e64:5f36 with SMTP id
 5b1f17b1804b1-42304820d7cmr28923395e9.14.1718393790771; Fri, 14 Jun 2024
 12:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611215544.2105970-1-jiaqiyan@google.com> <20240611215544.2105970-3-jiaqiyan@google.com>
 <5c97ee26-754f-c94c-6888-952b45b43558@huawei.com>
In-Reply-To: <5c97ee26-754f-c94c-6888-952b45b43558@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 14 Jun 2024 12:36:18 -0700
Message-ID: <CACw3F51sMwYgE2n5eGMCm+wFWYeqiLq6Jvd1chC6VxWbgWdRvg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] selftest/mm: test enable_soft_offline behaviors
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, nao.horiguchi@gmail.com, jane.chu@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 8:50=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> On 2024/6/12 5:55, Jiaqi Yan wrote:
> > Add regression and new tests when hugepage has correctable memory
> > errors, and how userspace wants to deal with it:
> > * if enable_soft_offline=3D0, mapped hugepage is soft offlined
> > * if enable_soft_offline=3D1, mapped hugepage is intact
>
> This shoule be something like below ?
>  if enable_soft_offline=3D0, mapped hugepage is intact
>  if enable_soft_offline=3D1, mapped hugepage is soft offlined
>
> >
> > Free hugepages case is not explicitly covered by the tests.
> >
> > Hugepage having corrected memory errors is emulated with
> > MADV_SOFT_OFFLINE.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  tools/testing/selftests/mm/.gitignore         |   1 +
> >  tools/testing/selftests/mm/Makefile           |   1 +
> >  .../selftests/mm/hugetlb-soft-offline.c       | 258 ++++++++++++++++++
> >  tools/testing/selftests/mm/run_vmtests.sh     |   4 +
> >  4 files changed, 264 insertions(+)
> >  create mode 100644 tools/testing/selftests/mm/hugetlb-soft-offline.c
> >
> > diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/self=
tests/mm/.gitignore
> > index 0b9ab987601c..064e7b125643 100644
> > --- a/tools/testing/selftests/mm/.gitignore
> > +++ b/tools/testing/selftests/mm/.gitignore
> > @@ -6,6 +6,7 @@ hugepage-shm
> >  hugepage-vmemmap
> >  hugetlb-madvise
> >  hugetlb-read-hwpoison
> > +hugetlb-soft-offline
> >  khugepaged
> >  map_hugetlb
> >  map_populate
> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selfte=
sts/mm/Makefile
> > index 3b49bc3d0a3b..d166067d75ef 100644
> > --- a/tools/testing/selftests/mm/Makefile
> > +++ b/tools/testing/selftests/mm/Makefile
> > @@ -42,6 +42,7 @@ TEST_GEN_FILES +=3D gup_test
> >  TEST_GEN_FILES +=3D hmm-tests
> >  TEST_GEN_FILES +=3D hugetlb-madvise
> >  TEST_GEN_FILES +=3D hugetlb-read-hwpoison
> > +TEST_GEN_FILES +=3D hugetlb-soft-offline
> >  TEST_GEN_FILES +=3D hugepage-mmap
> >  TEST_GEN_FILES +=3D hugepage-mremap
> >  TEST_GEN_FILES +=3D hugepage-shm
> > diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tools/=
testing/selftests/mm/hugetlb-soft-offline.c
> > new file mode 100644
> > index 000000000000..d37d68a433e7
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> > @@ -0,0 +1,258 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Test soft offline behavior for HugeTLB pages:
> > + * - if enable_soft_offline =3D 0, hugepages should stay intact and so=
ft
> > + *   offlining failed with EINVAL.
> > + * - if enable_soft_offline =3D 1, a hugepage should be dissolved and
> > + *   nr_hugepages/free_hugepages should be reduced by 1.
> > + *
> > + * Before running, make sure more than 2 hugepages of default_hugepage=
sz
> > + * are allocated. For example, if /proc/meminfo/Hugepagesize is 2048kB=
:
> > + *   echo 8 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <errno.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +
> > +#include <linux/magic.h>
> > +#include <linux/memfd.h>
> > +#include <sys/mman.h>
> > +#include <sys/statfs.h>
> > +#include <sys/types.h>
> > +
> > +#ifndef MADV_SOFT_OFFLINE
> > +#define MADV_SOFT_OFFLINE 101
> > +#endif
> > +
> > +#define PREFIX " ... "
> > +#define EPREFIX " !!! "
> > +
> > +enum test_status {
> > +     TEST_PASS =3D 0,
> > +     TEST_FAILED =3D 1,
> > +     // From ${ksft_skip} in run_vmtests.sh.
> > +     TEST_SKIPPED =3D 4,
> > +};
> > +
> > +static enum test_status do_soft_offline(int fd, size_t len, int expect=
_ret)
> > +{
> > +     char *filemap =3D NULL;
> > +     char *hwp_addr =3D NULL;
> > +     const unsigned long pagesize =3D getpagesize();
> > +     int ret =3D 0;
> > +     enum test_status status =3D TEST_SKIPPED;
> > +
> > +     if (ftruncate(fd, len) < 0) {
> > +             perror(EPREFIX "ftruncate to len failed");
> > +             return status;
> > +     }
> > +
> > +     filemap =3D mmap(NULL, len, PROT_READ | PROT_WRITE,
> > +                    MAP_SHARED | MAP_POPULATE, fd, 0);
> > +     if (filemap =3D=3D MAP_FAILED) {
> > +             perror(EPREFIX "mmap failed");
> > +             goto untruncate;
> > +     }
> > +
> > +     memset(filemap, 0xab, len);
> > +     printf(PREFIX "Allocated %#lx bytes of hugetlb pages\n", len);
> > +
> > +     hwp_addr =3D filemap + len / 2;
> > +     ret =3D madvise(hwp_addr, pagesize, MADV_SOFT_OFFLINE);
> > +     printf(PREFIX "MADV_SOFT_OFFLINE %p ret=3D%d, errno=3D%d\n",
> > +            hwp_addr, ret, errno);
> > +     if (ret !=3D 0)
> > +             perror(EPREFIX "madvise failed");
> > +
> > +     if (errno =3D=3D expect_ret)
> > +             status =3D TEST_PASS;
> > +     else {
> > +             printf(EPREFIX "MADV_SOFT_OFFLINE should ret %d\n", expec=
t_ret);
> > +             status =3D TEST_FAILED;
> > +     }
> > +
> > +     munmap(filemap, len);
> > +untruncate:
> > +     if (ftruncate(fd, 0) < 0)
> > +             perror(EPREFIX "ftruncate back to 0 failed");
> > +
> > +     return status;
> > +}
> > +
> > +static int set_enable_soft_offline(int value)
> > +{
> > +     char cmd[256] =3D {0};
> > +     FILE *cmdfile =3D NULL;
> > +
> > +     if (value !=3D 0 && value !=3D 1)
> > +             return -EINVAL;
> > +
> > +     sprintf(cmd, "echo %d > /proc/sys/vm/enable_soft_offline", value)=
;
> > +     cmdfile =3D popen(cmd, "r");
> > +
> > +     if (cmdfile =3D=3D NULL)
> > +             perror(EPREFIX "failed to set enable_soft_offline");
>
> If fails to set enable_soft_offline, should we return errno here?

Yes, in v3 this will errno, and make the test TEST_FAILED.

>
> > +     else
> > +             printf(PREFIX "enable_soft_offline =3D> %d\n", value);
> > +
> > +     pclose(cmdfile);
> > +     return 0;
> > +}
> > +
> > +static int read_nr_hugepages(unsigned long hugepage_size,
> > +                          unsigned long *nr_hugepages)
> > +{
> > +     char buffer[256] =3D {0};
> > +     char cmd[256] =3D {0};
> > +
> > +     sprintf(cmd, "cat /sys/kernel/mm/hugepages/hugepages-%ldkB/nr_hug=
epages",
> > +             hugepage_size);
> > +     FILE *cmdfile =3D popen(cmd, "r");
>
> Check cmdfile against NULL?

Will do in v3.

>
> > +
> > +     if (!fgets(buffer, sizeof(buffer), cmdfile)) {
> > +             perror(EPREFIX "failed to read nr_hugepages");
> > +             pclose(cmdfile);
> > +             return -1;
> > +     }
> > +
> > +     *nr_hugepages =3D atoll(buffer);
> > +     pclose(cmdfile);
> > +     return 0;
> > +}
> > +
> > +static int create_hugetlbfs_file(struct statfs *file_stat)
> > +{
> > +     int fd;
> > +
> > +     fd =3D memfd_create("hugetlb_tmp", MFD_HUGETLB);
> > +     if (fd < 0) {
> > +             perror(EPREFIX "could not open hugetlbfs file");
> > +             return -1;
> > +     }
> > +
> > +     memset(file_stat, 0, sizeof(*file_stat));
> > +     if (fstatfs(fd, file_stat)) {
> > +             perror(EPREFIX "fstatfs failed");
> > +             goto close;
> > +     }
> > +     if (file_stat->f_type !=3D HUGETLBFS_MAGIC) {
> > +             printf(EPREFIX "not hugetlbfs file\n");
> > +             goto close;
> > +     }
> > +
> > +     return fd;
> > +close:
> > +     close(fd);
> > +     return -1;
> > +}
> > +
> > +static enum test_status test_soft_offline(void)
> > +{
> > +     int fd;
> > +     struct statfs file_stat;
> > +     unsigned long hugepagesize_kb =3D 0;
> > +     unsigned long nr_hugepages_before =3D 0;
> > +     unsigned long nr_hugepages_after =3D 0;
> > +     enum test_status status =3D TEST_SKIPPED;
> > +
> > +     printf("Test Soft Offline When softoffline_corrected_errors=3D1\n=
");
> > +
> > +     fd =3D create_hugetlbfs_file(&file_stat);
> > +     if (fd < 0) {
> > +             printf(EPREFIX "Failed to create hugetlbfs file\n");
> > +             return status;
> > +     }
> > +
> > +     hugepagesize_kb =3D file_stat.f_bsize / 1024;
> > +     printf(PREFIX "Hugepagesize is %ldkB\n", hugepagesize_kb);
> > +
> > +     if (set_enable_soft_offline(1))
> > +             return TEST_FAILED;
> > +
> > +     if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_before) !=3D=
 0)
> > +             return TEST_FAILED;
> > +
> > +     printf(PREFIX "Before MADV_SOFT_OFFLINE nr_hugepages=3D%ld\n",
> > +             nr_hugepages_before);
> > +
> > +     status =3D do_soft_offline(fd, 2 * file_stat.f_bsize, /*expect_re=
t=3D*/0);
> > +
> > +     if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) !=3D =
0)
> > +             return TEST_FAILED;
> > +
> > +     printf(PREFIX "After MADV_SOFT_OFFLINE nr_hugepages=3D%ld\n",
> > +             nr_hugepages_after);
> > +
> > +     if (nr_hugepages_before !=3D nr_hugepages_after + 1) {
> > +             printf(EPREFIX "MADV_SOFT_OFFLINE should reduced 1 hugepa=
ge\n");
> > +             return TEST_FAILED;
> > +     }
> > +
> > +     return status;
> > +}
> > +
> > +static enum test_status test_disable_soft_offline(void)
> > +{
> > +     int fd;
> > +     struct statfs file_stat;
> > +     unsigned long hugepagesize_kb =3D 0;
> > +     unsigned long nr_hugepages_before =3D 0;
> > +     unsigned long nr_hugepages_after =3D 0;
> > +     enum test_status status =3D TEST_SKIPPED;
> > +
> > +     printf("Test Soft Offline When softoffline_corrected_errors=3D0\n=
");
> > +
> > +     fd =3D create_hugetlbfs_file(&file_stat);
> > +     if (fd < 0) {
> > +             printf(EPREFIX "Failed to create hugetlbfs file\n");
> > +             return status;
> > +     }
> > +
> > +     hugepagesize_kb =3D file_stat.f_bsize / 1024;
> > +     printf(PREFIX "Hugepagesize is %ldkB\n", hugepagesize_kb);
> > +
> > +     if (set_enable_soft_offline(0))
> > +             return TEST_FAILED;
> > +
> > +     if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_before) !=3D=
 0)
> > +             return TEST_FAILED;
> > +
> > +     printf(PREFIX "Before MADV_SOFT_OFFLINE nr_hugepages=3D%ld\n",
> > +             nr_hugepages_before);
> > +
> > +     status =3D do_soft_offline(fd, 2 * file_stat.f_bsize, /*expect_re=
t=3D*/EINVAL);
> > +
> > +     if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) !=3D =
0)
> > +             return TEST_FAILED;
> > +
> > +     printf(PREFIX "After MADV_SOFT_OFFLINE nr_hugepages=3D%ld\n",
> > +             nr_hugepages_after);
> > +
> > +     if (nr_hugepages_before !=3D nr_hugepages_after) {
> > +             printf(EPREFIX "MADV_SOFT_OFFLINE reduced %lu hugepages\n=
",
> > +                     nr_hugepages_before - nr_hugepages_after);
> > +             return TEST_FAILED;
> > +     }
> > +
> > +     return status;
> > +}
>
> test_disable_soft_offline is almost same with test_soft_offline. Shall we=
 extract the common pattern?

Will do in v3.

>
> Thanks.
> .
>
>

