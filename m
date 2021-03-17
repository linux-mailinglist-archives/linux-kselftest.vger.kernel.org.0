Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EF233F59B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 17:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhCQQfJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 12:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhCQQen (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 12:34:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF54C06174A;
        Wed, 17 Mar 2021 09:34:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id c10so3607191ejx.9;
        Wed, 17 Mar 2021 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MkRZb5ASIvGNEKAuhAJgK+I2tK/jYldJYEW+ewUVePQ=;
        b=n1JH6UgSxcTpzG9HinDVbwSj/YLiTNH4MjlzcTj+oVkBeDB5zZlL52g5Rf/7WSZHul
         t4ti6GL1W5L3bwrn2jZATEmaYIv2mxqXwZSyRqkoS/ed5fFu9yBEjEn5AgWAvAHCWCAD
         w1NS9Dct6h5gDl2mv+sZ35dA+PUxBIrIDm69x2ig86MweDzIoCjQnFHc97R0WG2BhOok
         dxwkp7O3ElDuRMdUL2dd7WiF7O+jNJWMk4D09Tqvx4Fa0+aWjTcV2qambm+Lhx/WcmKr
         leb3HoyB/uoe9Z/Tdj8IREG57Rd3+ZQurpqrroWjfEfFvtK3nab0lOLnlD2nDSdQJmOk
         3w5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MkRZb5ASIvGNEKAuhAJgK+I2tK/jYldJYEW+ewUVePQ=;
        b=Ro1RvbV8dZ/BB0w4Y7eSyEtvZQgkCrVgcwJPUqJ9na5gk72ObVrcKqOTw4DhLa/cES
         JVsWMz7Tn7mgieU0RZISuq/yr3W/8rbEDw2h6+4oWKMKLcckoCp+5KxbPROJKA4HWaOB
         3Gqq9OT8giChICSXq/8ePaex1hUhlrz2d9j8RNG2lok6m9ijPiq2cR7dD2EQkZ7FhsLk
         S1KR1o4pp7lLHvAxI/FZ+G8AnAdEcmhgbbW2h/c8OWnKHnbyRXQXCL46YIKAY54FBV5N
         dPQEuJtXvSKfVmlgPjdffMVHy/m9mm4uFGSBumEt8n2zpeQ24iKHFa+qQm0UwEO5gkfL
         pv/A==
X-Gm-Message-State: AOAM530Rj2PMzCS/qmC5R+y5jvuAQhBKvw/QN5d5gaSSg+V5zUda4uRb
        YeEMDLWsbq8o4bS8WOn19HBMD9hUDLkDXS+IL9w=
X-Google-Smtp-Source: ABdhPJznJfurp+cv2fAQ9tXA8hcsp4Gh5i5ks09ZVLuO2K4TRp9edOqOrXTflDMUjXiJ80mPtC09xQl1xuy5Lp0Nd/E=
X-Received: by 2002:a17:906:bcfc:: with SMTP id op28mr35808524ejb.238.1615998881266;
 Wed, 17 Mar 2021 09:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210315203349.171760-1-zi.yan@sent.com> <20210315203349.171760-2-zi.yan@sent.com>
 <CAHbLzkpmFhBxMRetg8QM4BQ4fDiTS823XBm73+5BV-eXsoCP+Q@mail.gmail.com> <10CA242B-9994-41D0-A84B-E711A5CD2975@nvidia.com>
In-Reply-To: <10CA242B-9994-41D0-A84B-E711A5CD2975@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 17 Mar 2021 09:34:29 -0700
Message-ID: <CAHbLzkr0x3sk+WtseKMDn-rGEaTNNbDfYMhyReR3oH4oJz4BAw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mm: huge_memory: debugfs for file-backed THP split.
To:     Zi Yan <ziy@nvidia.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Mika Penttila <mika.penttila@nextfour.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 17, 2021 at 8:00 AM Zi Yan <ziy@nvidia.com> wrote:
>
> On 16 Mar 2021, at 19:18, Yang Shi wrote:
>
> > On Mon, Mar 15, 2021 at 1:34 PM Zi Yan <zi.yan@sent.com> wrote:
> >>
> >> From: Zi Yan <ziy@nvidia.com>
> >>
> >> Further extend <debugfs>/split_huge_pages to accept
> >> "<path>,<off_start>,<off_end>" for file-backed THP split tests since
> >> tmpfs may have file backed by THP that mapped nowhere.
> >>
> >> Update selftest program to test file-backed THP split too.
> >>
> >> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >> ---
> >>  mm/huge_memory.c                              | 95 ++++++++++++++++++=
-
> >>  .../selftests/vm/split_huge_page_test.c       | 79 ++++++++++++++-
> >>  2 files changed, 166 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 3bfee54e2cd0..da91ee97d944 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -3043,12 +3043,72 @@ static int split_huge_pages_pid(int pid, unsig=
ned long vaddr_start,
> >>         return ret;
> >>  }
> >>
> >> +static int split_huge_pages_in_file(const char *file_path, pgoff_t of=
f_start,
> >> +                               pgoff_t off_end)
> >> +{
> >> +       struct filename *file;
> >> +       struct file *candidate;
> >> +       struct address_space *mapping;
> >> +       int ret =3D -EINVAL;
> >> +       pgoff_t off_cur;
> >> +       unsigned long total =3D 0, split =3D 0;
> >> +
> >> +       file =3D getname_kernel(file_path);
> >> +       if (IS_ERR(file))
> >> +               return ret;
> >> +
> >> +       candidate =3D file_open_name(file, O_RDONLY, 0);
> >> +       if (IS_ERR(candidate))
> >> +               goto out;
> >> +
> >> +       pr_info("split file-backed THPs in file: %s, offset: [0x%lx - =
0x%lx]\n",
> >> +                file_path, off_start, off_end);
> >> +
> >> +       mapping =3D candidate->f_mapping;
> >> +
> >> +       for (off_cur =3D off_start; off_cur < off_end;) {
> >> +               struct page *fpage =3D pagecache_get_page(mapping, off=
_cur,
> >> +                                               FGP_ENTRY | FGP_HEAD, =
0);
> >> +
> >> +               if (xa_is_value(fpage) || !fpage) {
> >
> > Why do you have FGP_ENTRY? It seems it would return page instead of
> > NULL if page is value. So I think you could remove FGP_ENTRY and
> > xa_is_value() check as well.
>
> The comment on FGP_ENTRY says =E2=80=9CIf there is a shadow/swap/DAX entr=
y, return
> it instead of allocating a new page to replace it=E2=80=9D. I do not thin=
k we
> want to allocate new pages here. I mostly follow the use of pagecache_get=
_page()
> in shmem_getpage_gfp without swapin or allocating new pages.

Yes, you are correct. I overlooked that.

>
> >
> >> +                       off_cur +=3D PAGE_SIZE;
> >> +                       continue;
> >> +               }
> >> +
> >> +               if (!is_transparent_hugepage(fpage)) {
> >> +                       off_cur +=3D PAGE_SIZE;
> >> +                       goto next;
> >> +               }
> >> +               total++;
> >> +               off_cur =3D fpage->index + thp_size(fpage);
> >> +
> >> +               if (!trylock_page(fpage))
> >> +                       goto next;
> >> +
> >> +               if (!split_huge_page(fpage))
> >> +                       split++;
> >> +
> >> +               unlock_page(fpage);
> >> +next:
> >> +               put_page(fpage);
> >> +       }
> >> +
> >> +       filp_close(candidate, NULL);
> >> +       ret =3D 0;
> >> +
> >> +       pr_info("%lu of %lu file-backed THP split\n", split, total);
> >> +out:
> >> +       putname(file);
> >> +       return ret;
> >> +}
> >> +
> >>  static ssize_t split_huge_pages_write(struct file *file, const char _=
_user *buf,
> >>                                 size_t count, loff_t *ppops)
> >>  {
> >>         static DEFINE_MUTEX(mutex);
> >>         ssize_t ret;
> >> -       char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
> >> +       /* hold pid, start_vaddr, end_vaddr or file_path, off_start, o=
ff_end */
> >> +       char input_buf[MAX_INPUT];
> >
> > I didn't find where MAX_INPUT is defined in your patch. Just saw
> > include/uapi/linux/limits.h have it defined. Is it the one you really
> > refer to?
>
> Yeah, I want to use 255 as the max input size and find MAX_INPUT. From yo=
ur comment,
> I think it is better to define a MACRO here explicitly.
>
>
> >>         int pid;
> >>         unsigned long vaddr_start, vaddr_end;
> >>
> >> @@ -3058,11 +3118,40 @@ static ssize_t split_huge_pages_write(struct f=
ile *file, const char __user *buf,
> >>
> >>         ret =3D -EFAULT;
> >>
> >> -       memset(input_buf, 0, 80);
> >> +       memset(input_buf, 0, MAX_INPUT);
> >>         if (copy_from_user(input_buf, buf, min_t(size_t, count, 80)))
> >>                 goto out;
> >>
> >> -       input_buf[79] =3D '\0';
> >> +       input_buf[MAX_INPUT - 1] =3D '\0';
> >> +
> >> +       if (input_buf[0] =3D=3D '/') {
> >> +               char *tok;
> >> +               char *buf =3D input_buf;
> >> +               char file_path[MAX_INPUT];
> >> +               pgoff_t off_start =3D 0, off_end =3D 0;
> >> +               size_t input_len =3D strlen(input_buf);
> >> +
> >> +               tok =3D strsep(&buf, ",");
> >> +               if (tok) {
> >> +                       strncpy(file_path, tok, MAX_INPUT);
> >> +               } else {
> >> +                       ret =3D -EINVAL;
> >> +                       goto out;
> >> +               }
> >> +
> >> +               ret =3D sscanf(buf, "0x%lx,0x%lx", &off_start, &off_en=
d);
> >> +               if (ret !=3D 2) {
> >> +                       pr_info("ret: %ld\n", ret);
> >> +                       ret =3D -EINVAL;
> >> +                       goto out;
> >> +               }
> >> +               ret =3D split_huge_pages_in_file(file_path, off_start,=
 off_end);
> >> +               if (!ret)
> >> +                       ret =3D input_len;
> >> +
> >> +               goto out;
> >> +       }
> >> +
> >>         ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start=
, &vaddr_end);
> >>         if (ret =3D=3D 1 && pid =3D=3D 1) {
> >>                 split_huge_pages_all();
> >> diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools=
/testing/selftests/vm/split_huge_page_test.c
> >> index 9f33ddbb3182..0202702f7eda 100644
> >> --- a/tools/testing/selftests/vm/split_huge_page_test.c
> >> +++ b/tools/testing/selftests/vm/split_huge_page_test.c
> >> @@ -7,11 +7,13 @@
> >>  #define _GNU_SOURCE
> >>  #include <stdio.h>
> >>  #include <stdlib.h>
> >> +#include <stdarg.h>
> >>  #include <unistd.h>
> >>  #include <inttypes.h>
> >>  #include <string.h>
> >>  #include <fcntl.h>
> >>  #include <sys/mman.h>
> >> +#include <sys/mount.h>
> >>  #include <malloc.h>
> >>  #include <stdbool.h>
> >>
> >> @@ -24,6 +26,9 @@ uint64_t pmd_pagesize;
> >>  #define SMAP_PATH "/proc/self/smaps"
> >>  #define INPUT_MAX 80
> >>
> >> +#define PID_FMT "%d,0x%lx,0x%lx"
> >> +#define PATH_FMT "%s,0x%lx,0x%lx"
> >> +
> >>  #define PFN_MASK     ((1UL<<55)-1)
> >>  #define KPF_THP      (1UL<<22)
> >>
> >> @@ -87,13 +92,16 @@ static int write_file(const char *path, const char=
 *buf, size_t buflen)
> >>         return (unsigned int) numwritten;
> >>  }
> >>
> >> -static void write_debugfs(int pid, uint64_t vaddr_start, uint64_t vad=
dr_end)
> >> +static void write_debugfs(const char *fmt, ...)
> >>  {
> >>         char input[INPUT_MAX];
> >>         int ret;
> >> +       va_list argp;
> >> +
> >> +       va_start(argp, fmt);
> >> +       ret =3D vsnprintf(input, INPUT_MAX, fmt, argp);
> >> +       va_end(argp);
> >>
> >> -       ret =3D snprintf(input, INPUT_MAX, "%d,0x%lx,0x%lx", pid, vadd=
r_start,
> >> -                       vaddr_end);
> >>         if (ret >=3D INPUT_MAX) {
> >>                 printf("%s: Debugfs input is too long\n", __func__);
> >>                 exit(EXIT_FAILURE);
> >> @@ -178,7 +186,8 @@ void split_pmd_thp(void)
> >>         }
> >>
> >>         /* split all THPs */
> >> -       write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page=
 + len);
> >> +       write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
> >> +               (uint64_t)one_page + len);
> >>
> >>         for (i =3D 0; i < len; i++)
> >>                 if (one_page[i] !=3D (char)i) {
> >> @@ -269,7 +278,7 @@ void split_pte_mapped_thp(void)
> >>         }
> >>
> >>         /* split all remapped THPs */
> >> -       write_debugfs(getpid(), (uint64_t)pte_mapped,
> >> +       write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
> >>                       (uint64_t)pte_mapped + pagesize * 4);
> >>
> >>         /* smap does not show THPs after mremap, use kpageflags instea=
d */
> >> @@ -295,6 +304,65 @@ void split_pte_mapped_thp(void)
> >>         close(kpageflags_fd);
> >>  }
> >>
> >> +void split_file_backed_thp(void)
> >> +{
> >> +       int status;
> >> +       int fd;
> >> +       ssize_t num_written;
> >> +       char tmpfs_template[] =3D "/tmp/thp_split_XXXXXX";
> >> +       const char *tmpfs_loc =3D mkdtemp(tmpfs_template);
> >> +       char testfile[INPUT_MAX];
> >> +
> >> +       status =3D mount("tmpfs", tmpfs_loc, "tmpfs", 0, "huge=3Dalway=
s,size=3D4m");
> >> +
> >> +       if (status) {
> >> +               printf("Unable to create a tmpfs for testing\n");
> >> +               exit(EXIT_FAILURE);
> >> +       }
> >> +
> >> +       status =3D snprintf(testfile, INPUT_MAX, "%s/thp_file", tmpfs_=
loc);
> >> +       if (status >=3D INPUT_MAX) {
> >> +               printf("Fail to create file-backed THP split testing f=
ile\n");
> >> +               goto cleanup;
> >> +       }
> >> +
> >> +       fd =3D open(testfile, O_CREAT|O_WRONLY);
> >> +       if (fd =3D=3D -1) {
> >> +               perror("Cannot open testing file\n");
> >> +               goto cleanup;
> >> +       }
> >> +
> >> +       /* write something to the file, so a file-backed THP can be al=
located */
> >> +       num_written =3D write(fd, tmpfs_loc, sizeof(tmpfs_loc));
> >> +       close(fd);
> >> +
> >> +       if (num_written < 1) {
> >> +               printf("Fail to write data to testing file\n");
> >> +               goto cleanup;
> >> +       }
> >> +
> >> +       /* split the file-backed THP */
> >> +       write_debugfs(PATH_FMT, testfile, 0, 1024);
> >> +
> >> +       status =3D unlink(testfile);
> >> +       if (status)
> >> +               perror("Cannot remove testing file\n");
> >> +
> >> +cleanup:
> >> +       status =3D umount(tmpfs_loc);
> >> +       if (status) {
> >> +               printf("Unable to umount %s\n", tmpfs_loc);
> >> +               exit(EXIT_FAILURE);
> >> +       }
> >> +       status =3D rmdir(tmpfs_loc);
> >> +       if (status) {
> >> +               perror("cannot remove tmp dir");
> >> +               exit(EXIT_FAILURE);
> >> +       }
> >> +
> >> +       printf("file-backed THP split test done, please check dmesg fo=
r more information\n");
> >> +}
> >> +
> >>  int main(int argc, char **argv)
> >>  {
> >>         if (geteuid() !=3D 0) {
> >> @@ -308,6 +376,7 @@ int main(int argc, char **argv)
> >>
> >>         split_pmd_thp();
> >>         split_pte_mapped_thp();
> >> +       split_file_backed_thp();
> >>
> >>         return 0;
> >>  }
> >> --
> >> 2.30.1
> >>
>
> Thanks for the comments. :)
>
> =E2=80=94
> Best Regards,
> Yan Zi
