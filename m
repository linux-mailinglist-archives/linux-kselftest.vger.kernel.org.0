Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB4333E1FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 00:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhCPXTK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 19:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhCPXTD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 19:19:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0715C06174A;
        Tue, 16 Mar 2021 16:19:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y6so68913eds.1;
        Tue, 16 Mar 2021 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzO6qlspMoccvL4j6YTNH7ow8gj9tE1MOD0NCZAbpEk=;
        b=XlP5x52JBJttoi2LWeBiQyBJUnjpc0wEzhRwizGqokeTP7GyqJf+SinAdF9MCz3HOt
         ZWOm/07dvQyE592Q7W6IwL/qNqfcQ+4TyzfKaWVhNUqWoa9nW6689HMFWRqSosmSTsRL
         a8SGxXOjkS3/d7FGq4g0oYy7IUN1Goi4Z+pjNpQ9I59P51+9Z2/mt2PYkUp2LL/3Gnzu
         MOWqkm1G1CUsGBp5Qt+GtXDPpigl5KtCF99qRwSYpZ3A74QGj/TLRUlBqebnRwMLfvID
         jr30HR885TvAm60LikrIsR5Z7Vgs3izg3T09eJmyQl9iTB1iGcKLxfCxytp42+15mW+e
         qL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzO6qlspMoccvL4j6YTNH7ow8gj9tE1MOD0NCZAbpEk=;
        b=YVaAbMNZ9kQWi5HWUCRZOVw5P3pzGV45BSp+5Bt6OzcbkDmr0oN6LVbbWD4anOUdsi
         +W5/alMFKTwHRR9WjOpTp6h503quVrt1mC0ymCp47CHLQ6b3mU9413Fuwx+mLU6ceKVp
         6JYnHQvK0be89omYgIvUDgNxcucyG/2QkpAXkuSUpRU0e0++YYnrWr2ipYJf2Mebejp6
         8h0hY1goJxZawvZMSUmqGvjUK3qVhfqRJhdudm7stJD9Q6HdI9e16mmdkiolNCEMa7UW
         BDwW5IJy1hSw6PGNZyEUEa2LuYHtJ9JhFLX5GmvqUmHAYbhUvCjNDuqSzlLqczTRLUf3
         G+pg==
X-Gm-Message-State: AOAM5304gFposYdwqhaTXx/g/c+OlW0DYNCF69KzdCSDP6/0wEVbZKjW
        d7IEZ+udoSzJ3QZShDVUd4sn/V7Y4z3MCiZM/lk=
X-Google-Smtp-Source: ABdhPJwWAFE7FtMknt4N6qEMuwLHU2Y2IE4lQNqNT8qjXehfKxnz++6zOQPh96ruJ0et2TbJaFN8GfF7EojU1ktxJCw=
X-Received: by 2002:aa7:c403:: with SMTP id j3mr38873366edq.137.1615936741604;
 Tue, 16 Mar 2021 16:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210315203349.171760-1-zi.yan@sent.com> <20210315203349.171760-2-zi.yan@sent.com>
In-Reply-To: <20210315203349.171760-2-zi.yan@sent.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 16 Mar 2021 16:18:50 -0700
Message-ID: <CAHbLzkpmFhBxMRetg8QM4BQ4fDiTS823XBm73+5BV-eXsoCP+Q@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 15, 2021 at 1:34 PM Zi Yan <zi.yan@sent.com> wrote:
>
> From: Zi Yan <ziy@nvidia.com>
>
> Further extend <debugfs>/split_huge_pages to accept
> "<path>,<off_start>,<off_end>" for file-backed THP split tests since
> tmpfs may have file backed by THP that mapped nowhere.
>
> Update selftest program to test file-backed THP split too.
>
> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c                              | 95 ++++++++++++++++++-
>  .../selftests/vm/split_huge_page_test.c       | 79 ++++++++++++++-
>  2 files changed, 166 insertions(+), 8 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 3bfee54e2cd0..da91ee97d944 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3043,12 +3043,72 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>         return ret;
>  }
>
> +static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
> +                               pgoff_t off_end)
> +{
> +       struct filename *file;
> +       struct file *candidate;
> +       struct address_space *mapping;
> +       int ret = -EINVAL;
> +       pgoff_t off_cur;
> +       unsigned long total = 0, split = 0;
> +
> +       file = getname_kernel(file_path);
> +       if (IS_ERR(file))
> +               return ret;
> +
> +       candidate = file_open_name(file, O_RDONLY, 0);
> +       if (IS_ERR(candidate))
> +               goto out;
> +
> +       pr_info("split file-backed THPs in file: %s, offset: [0x%lx - 0x%lx]\n",
> +                file_path, off_start, off_end);
> +
> +       mapping = candidate->f_mapping;
> +
> +       for (off_cur = off_start; off_cur < off_end;) {
> +               struct page *fpage = pagecache_get_page(mapping, off_cur,
> +                                               FGP_ENTRY | FGP_HEAD, 0);
> +
> +               if (xa_is_value(fpage) || !fpage) {

Why do you have FGP_ENTRY? It seems it would return page instead of
NULL if page is value. So I think you could remove FGP_ENTRY and
xa_is_value() check as well.


> +                       off_cur += PAGE_SIZE;
> +                       continue;
> +               }
> +
> +               if (!is_transparent_hugepage(fpage)) {
> +                       off_cur += PAGE_SIZE;
> +                       goto next;
> +               }
> +               total++;
> +               off_cur = fpage->index + thp_size(fpage);
> +
> +               if (!trylock_page(fpage))
> +                       goto next;
> +
> +               if (!split_huge_page(fpage))
> +                       split++;
> +
> +               unlock_page(fpage);
> +next:
> +               put_page(fpage);
> +       }
> +
> +       filp_close(candidate, NULL);
> +       ret = 0;
> +
> +       pr_info("%lu of %lu file-backed THP split\n", split, total);
> +out:
> +       putname(file);
> +       return ret;
> +}
> +
>  static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
>                                 size_t count, loff_t *ppops)
>  {
>         static DEFINE_MUTEX(mutex);
>         ssize_t ret;
> -       char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
> +       /* hold pid, start_vaddr, end_vaddr or file_path, off_start, off_end */
> +       char input_buf[MAX_INPUT];

I didn't find where MAX_INPUT is defined in your patch. Just saw
include/uapi/linux/limits.h have it defined. Is it the one you really
refer to?

>         int pid;
>         unsigned long vaddr_start, vaddr_end;
>
> @@ -3058,11 +3118,40 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
>
>         ret = -EFAULT;
>
> -       memset(input_buf, 0, 80);
> +       memset(input_buf, 0, MAX_INPUT);
>         if (copy_from_user(input_buf, buf, min_t(size_t, count, 80)))
>                 goto out;
>
> -       input_buf[79] = '\0';
> +       input_buf[MAX_INPUT - 1] = '\0';
> +
> +       if (input_buf[0] == '/') {
> +               char *tok;
> +               char *buf = input_buf;
> +               char file_path[MAX_INPUT];
> +               pgoff_t off_start = 0, off_end = 0;
> +               size_t input_len = strlen(input_buf);
> +
> +               tok = strsep(&buf, ",");
> +               if (tok) {
> +                       strncpy(file_path, tok, MAX_INPUT);
> +               } else {
> +                       ret = -EINVAL;
> +                       goto out;
> +               }
> +
> +               ret = sscanf(buf, "0x%lx,0x%lx", &off_start, &off_end);
> +               if (ret != 2) {
> +                       pr_info("ret: %ld\n", ret);
> +                       ret = -EINVAL;
> +                       goto out;
> +               }
> +               ret = split_huge_pages_in_file(file_path, off_start, off_end);
> +               if (!ret)
> +                       ret = input_len;
> +
> +               goto out;
> +       }
> +
>         ret = sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start, &vaddr_end);
>         if (ret == 1 && pid == 1) {
>                 split_huge_pages_all();
> diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/vm/split_huge_page_test.c
> index 9f33ddbb3182..0202702f7eda 100644
> --- a/tools/testing/selftests/vm/split_huge_page_test.c
> +++ b/tools/testing/selftests/vm/split_huge_page_test.c
> @@ -7,11 +7,13 @@
>  #define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <stdarg.h>
>  #include <unistd.h>
>  #include <inttypes.h>
>  #include <string.h>
>  #include <fcntl.h>
>  #include <sys/mman.h>
> +#include <sys/mount.h>
>  #include <malloc.h>
>  #include <stdbool.h>
>
> @@ -24,6 +26,9 @@ uint64_t pmd_pagesize;
>  #define SMAP_PATH "/proc/self/smaps"
>  #define INPUT_MAX 80
>
> +#define PID_FMT "%d,0x%lx,0x%lx"
> +#define PATH_FMT "%s,0x%lx,0x%lx"
> +
>  #define PFN_MASK     ((1UL<<55)-1)
>  #define KPF_THP      (1UL<<22)
>
> @@ -87,13 +92,16 @@ static int write_file(const char *path, const char *buf, size_t buflen)
>         return (unsigned int) numwritten;
>  }
>
> -static void write_debugfs(int pid, uint64_t vaddr_start, uint64_t vaddr_end)
> +static void write_debugfs(const char *fmt, ...)
>  {
>         char input[INPUT_MAX];
>         int ret;
> +       va_list argp;
> +
> +       va_start(argp, fmt);
> +       ret = vsnprintf(input, INPUT_MAX, fmt, argp);
> +       va_end(argp);
>
> -       ret = snprintf(input, INPUT_MAX, "%d,0x%lx,0x%lx", pid, vaddr_start,
> -                       vaddr_end);
>         if (ret >= INPUT_MAX) {
>                 printf("%s: Debugfs input is too long\n", __func__);
>                 exit(EXIT_FAILURE);
> @@ -178,7 +186,8 @@ void split_pmd_thp(void)
>         }
>
>         /* split all THPs */
> -       write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page + len);
> +       write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
> +               (uint64_t)one_page + len);
>
>         for (i = 0; i < len; i++)
>                 if (one_page[i] != (char)i) {
> @@ -269,7 +278,7 @@ void split_pte_mapped_thp(void)
>         }
>
>         /* split all remapped THPs */
> -       write_debugfs(getpid(), (uint64_t)pte_mapped,
> +       write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
>                       (uint64_t)pte_mapped + pagesize * 4);
>
>         /* smap does not show THPs after mremap, use kpageflags instead */
> @@ -295,6 +304,65 @@ void split_pte_mapped_thp(void)
>         close(kpageflags_fd);
>  }
>
> +void split_file_backed_thp(void)
> +{
> +       int status;
> +       int fd;
> +       ssize_t num_written;
> +       char tmpfs_template[] = "/tmp/thp_split_XXXXXX";
> +       const char *tmpfs_loc = mkdtemp(tmpfs_template);
> +       char testfile[INPUT_MAX];
> +
> +       status = mount("tmpfs", tmpfs_loc, "tmpfs", 0, "huge=always,size=4m");
> +
> +       if (status) {
> +               printf("Unable to create a tmpfs for testing\n");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       status = snprintf(testfile, INPUT_MAX, "%s/thp_file", tmpfs_loc);
> +       if (status >= INPUT_MAX) {
> +               printf("Fail to create file-backed THP split testing file\n");
> +               goto cleanup;
> +       }
> +
> +       fd = open(testfile, O_CREAT|O_WRONLY);
> +       if (fd == -1) {
> +               perror("Cannot open testing file\n");
> +               goto cleanup;
> +       }
> +
> +       /* write something to the file, so a file-backed THP can be allocated */
> +       num_written = write(fd, tmpfs_loc, sizeof(tmpfs_loc));
> +       close(fd);
> +
> +       if (num_written < 1) {
> +               printf("Fail to write data to testing file\n");
> +               goto cleanup;
> +       }
> +
> +       /* split the file-backed THP */
> +       write_debugfs(PATH_FMT, testfile, 0, 1024);
> +
> +       status = unlink(testfile);
> +       if (status)
> +               perror("Cannot remove testing file\n");
> +
> +cleanup:
> +       status = umount(tmpfs_loc);
> +       if (status) {
> +               printf("Unable to umount %s\n", tmpfs_loc);
> +               exit(EXIT_FAILURE);
> +       }
> +       status = rmdir(tmpfs_loc);
> +       if (status) {
> +               perror("cannot remove tmp dir");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       printf("file-backed THP split test done, please check dmesg for more information\n");
> +}
> +
>  int main(int argc, char **argv)
>  {
>         if (geteuid() != 0) {
> @@ -308,6 +376,7 @@ int main(int argc, char **argv)
>
>         split_pmd_thp();
>         split_pte_mapped_thp();
> +       split_file_backed_thp();
>
>         return 0;
>  }
> --
> 2.30.1
>
