Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F3A3DFA0E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Aug 2021 05:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhHDDl5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Aug 2021 23:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhHDDl5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Aug 2021 23:41:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54561C0613D5
        for <linux-kselftest@vger.kernel.org>; Tue,  3 Aug 2021 20:41:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y12so1732325edo.6
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Aug 2021 20:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jqn3cUSXhL86/aR8CXIntvMigSyWyrxcTEh0ioBgKjc=;
        b=Mfkfku6RzIh9PU9VB5qCOgW8WPVleuDk9MDb+AtkTfLnzUJypUSiqNvVbRdiH9x9qL
         MZP9SjW8oyhlmRzbHUP/2gJ+6kXh3+rI/VAaLH20TTvlTX1UTzihrxkV81EzOX2YZVV3
         SHByZMnPSJzR26K8RUWZO6dQcs1gcGr3sQEv/OSVDYrGzE2E5Dbm2DdrKrxIMnQcaaGo
         9hxzJZ8wRDhSwzboDQLOaCO75FvoxSAOZGfhIYUtTjYa0YFV/XJnbB8ghi0RUfgtyNsM
         Nbd/YJcdPOKwsyhsHy7vzZrskbK4f/21IDo4QFCBMdqKUVY2C8bfdZgpOvTTrt7VmUGc
         H3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jqn3cUSXhL86/aR8CXIntvMigSyWyrxcTEh0ioBgKjc=;
        b=A3vGXNLXICvQiWs8JVZcLJZYKIcUN3jSasm6mv0Vl/XG3B95oooMLU3LDjFATDg4PY
         EO1/kHoCi2LtuXBc/VFEAGMD0XSRRbkVRnIrhiBy6Tzl1ozF+M/Q17YJXLzp0GpKMdEl
         gi8dvvA3XXM/kvzKGUq5KCVA5/SD7o9MAqWuUBC/IHZt5Ejs8ELFr9435m+umrNCQsyh
         dpq5yAhDx1tV5hqbKifzGp6ZGydY7iBaeXTbAG3RZw/Gqr8F9RVWJ89SRTNljkhavzZE
         F4hViRaE1hi/lPvL/iZNvfmMwF5OcbNXSTU9N5+wNGLPcec6frBwHPeOApFGH5Kbq9jZ
         Ufyg==
X-Gm-Message-State: AOAM531HTlR3UNWTJUue6iUwCKEjLLpmDCpAkIXusA3B7lZQOkyZSDjc
        ouaR8Q7sfefYsbrFjGHyXTfyS7JOEMsCf4NE9x0tNw==
X-Google-Smtp-Source: ABdhPJyJKo0Trisq81aGbNLYiUV00k9Ixck93Dwg1xDSDp9cPcYPvKUVlMntKjkWjIBFpnJkSaGPG6+/MfNYMUkJsEI=
X-Received: by 2002:a05:6402:2043:: with SMTP id bc3mr29579404edb.62.1628048502976;
 Tue, 03 Aug 2021 20:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627828548.git.zhansayabagdaulet@gmail.com> <26a3cc3d02dc4fa65cc9b135be76e7d795c44877.1627828548.git.zhansayabagdaulet@gmail.com>
In-Reply-To: <26a3cc3d02dc4fa65cc9b135be76e7d795c44877.1627828548.git.zhansayabagdaulet@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 3 Aug 2021 23:41:07 -0400
Message-ID: <CA+CK2bDYZBBaU3pC369o01tCgydaJ6y91GZ0_MWONMMCajZOUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: vm: add COW time test for KSM pages
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 1, 2021 at 11:43 AM Zhansaya Bagdauletkyzy
<zhansayabagdaulet@gmail.com> wrote:
>
> Since merged pages are copied every time they need to be modified,
> the write access time is different between shared and non-shared pages.
> Add ksm_cow_time() function which evaluates latency of these COW
> breaks. First, duplicated pages are merged and then the time required
> to write to each of the pages is detected.

Hi Zhansaya,

This test would make more sense if we also had a baseline on how long
it takes to modify unmerged pages. This way it would show the true
cost of having a write on a previously merged page vs. if it was never
merged.

Also, instead of having all pages merged together, I'd rather see a
collection of merged pairs of pages, which are decoupled as one of the
pages gets modified: i.e.
Page1 - Page2: merged
Page3 - Page4: merged
...

then, go through pages: Page2, Page4, ... and modify the first byte in
each of them and measure the time it takes. Do the same when these
pages are not merged, and print both numbers so the cost of KSM and
COW can be calculated.

Thanks,
Pasha

>
> The test is run as follows: ./ksm_tests -C -p 5000
> The output:
>         Total COW time:      0.012612 s
>         The number of pages: 5000
>         Average speed:       1623 MB/s
>
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
> ---
>  tools/testing/selftests/vm/ksm_tests.c | 66 ++++++++++++++++++++++++--
>  1 file changed, 63 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
> index 91c6ff496655..3ffd899b2bd9 100644
> --- a/tools/testing/selftests/vm/ksm_tests.c
> +++ b/tools/testing/selftests/vm/ksm_tests.c
> @@ -33,7 +33,8 @@ enum ksm_test_name {
>         CHECK_KSM_UNMERGE,
>         CHECK_KSM_ZERO_PAGE_MERGE,
>         CHECK_KSM_NUMA_MERGE,
> -       KSM_MERGE_TIME
> +       KSM_MERGE_TIME,
> +       KSM_COW_TIME
>  };
>
>  static int ksm_write_sysfs(const char *file_path, unsigned long val)
> @@ -98,7 +99,9 @@ static void print_help(void)
>                " -U (page unmerging)\n"
>                " -P evaluate merging time and speed.\n"
>                "    For this test, the size of duplicated memory area (in MB)\n"
> -              "    must be provided using -s option\n\n");
> +              "    must be provided using -s option\n"
> +              " -C evaluate the time required to break COW of merged pages.\n"
> +              "    The number of pages can be defined using -p option.\n\n");
>
>         printf(" -a: specify the access protections of pages.\n"
>                "     <prot> must be of the form [rwx].\n"
> @@ -457,6 +460,56 @@ static int ksm_merge_time(int mapping, int prot, int timeout, size_t map_size)
>         return KSFT_FAIL;
>  }
>
> +static int ksm_cow_time(int mapping, int prot, int timeout, size_t page_size, long page_count)
> +{
> +       void *map_ptr;
> +       struct timespec start_time, end_time;
> +       long cow_time_s, cow_time_ns;
> +       int avg_speed;
> +
> +       if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
> +               perror("clock_gettime");
> +               return KSFT_FAIL;
> +       }
> +
> +       map_ptr = allocate_memory(NULL, prot, mapping, '*', page_size * page_count);
> +       if (!map_ptr)
> +               return KSFT_FAIL;
> +
> +       if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeout))
> +               goto err_out;
> +
> +       if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
> +               perror("clock_gettime");
> +               goto err_out;
> +       }
> +       for (size_t i = 0; i < page_count; i++)
> +               memset(map_ptr + page_size * i, '-', 1);
> +       if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
> +               perror("clock_gettime");
> +               goto err_out;
> +       }
> +
> +       cow_time_ns = (end_time.tv_sec - start_time.tv_sec) * NSEC_PER_SEC +
> +                      (end_time.tv_nsec - start_time.tv_nsec);
> +       cow_time_s = cow_time_ns / NSEC_PER_SEC;
> +       cow_time_ns %= NSEC_PER_SEC;
> +       avg_speed = (page_size * page_count) / (cow_time_s * USEC_PER_SEC +
> +                                               cow_time_ns / NSEC_PER_USEC);
> +
> +       printf("Total COW time:      %ld.%06ld s\n", cow_time_s, cow_time_ns / NSEC_PER_USEC);
> +       printf("The number of pages: %ld\n", page_count);
> +       printf("Average speed:       %d MB/s\n", avg_speed);
> +
> +       munmap(map_ptr, page_size * page_count);
> +       return KSFT_PASS;
> +
> +err_out:
> +       printf("Not OK\n");
> +       munmap(map_ptr, page_size * page_count);
> +       return KSFT_FAIL;
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         int ret, opt;
> @@ -470,7 +523,7 @@ int main(int argc, char *argv[])
>         bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
>         long size_MB = 0;
>
> -       while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNP")) != -1) {
> +       while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNPC")) != -1) {
>                 switch (opt) {
>                 case 'a':
>                         prot = str_to_prot(optarg);
> @@ -524,6 +577,9 @@ int main(int argc, char *argv[])
>                 case 'P':
>                         test_name = KSM_MERGE_TIME;
>                         break;
> +               case 'C':
> +                       test_name = KSM_COW_TIME;
> +                       break;
>                 default:
>                         return KSFT_FAIL;
>                 }
> @@ -573,6 +629,10 @@ int main(int argc, char *argv[])
>                 ret = ksm_merge_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
>                                      size_MB);
>                 break;
> +       case KSM_COW_TIME:
> +               ret = ksm_cow_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
> +                                  page_size, page_count);
> +               break;
>         }
>
>         if (ksm_restore(&ksm_sysfs_old)) {
> --
> 2.25.1
>
