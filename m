Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9643DFA09
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Aug 2021 05:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhHDDej (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Aug 2021 23:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhHDDei (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Aug 2021 23:34:38 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B25FC0613D5
        for <linux-kselftest@vger.kernel.org>; Tue,  3 Aug 2021 20:34:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y7so1715178eda.5
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Aug 2021 20:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+e6DPYxoCf6AU7W6hFgz8oUIxu2RVyG8qZ3vU3T53vQ=;
        b=VTUqP21iOcicWyeyykdjreY5cLu2zNhZ5ll+GVwVpBFWPeL6XXyoVR25M9dV/zqWTW
         8akmIk6Qm5yo9tkeiZgQ/5LqoIhkS7Y+W/X+rf675EOU70c+61O9piSaRxAudad1SmgP
         R7nNCwj7sREPaH++fifDzhWE0gHk3GnsZM2UjxcQs5Fp0eThsJURQYNwBFNVmZIzDRZs
         /1I9VlGOuIQFu8jaBsONbQ0FfIbjbeZEYWJdlLLap1Bt/U3oWqf2qn3I76eT0gAyVWH7
         CqurzLuxjlXllEOT8TW+4Tc/b4igWeVOATZsnpbp62eThBbSZzWAOfSL1+12oWhiL/zI
         zmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+e6DPYxoCf6AU7W6hFgz8oUIxu2RVyG8qZ3vU3T53vQ=;
        b=AN461czqwljxVdDHCZTh183RMrClQ84cUfWNNLzkwxcFoHDzViarh/OGV1/78buDHf
         0DnAKEOremHCw0YY7BsOZlLbum4+01fNyS7XAm/uOk6GZap+5gLT87PtBD/32oVmkzRr
         led94LDDNKgE6owFMpHBPGHsaADJwBpFFZ8JlwYKEnQUp1pQ6dpWMR/1lLUrbR/eMceb
         LucbU9lq/glVZYgSIsRuWbSDBWatcNTV8r20BUl7wy7Ljdi5LF3vsQ8oKoq6Yf7INH3m
         MzuW5xQykNlgtKBmxcpDgYTLd2DqTYPjvNiwJwBZFfcLEyFxJ6GFFl+sx7//TnnoYPSB
         FZmA==
X-Gm-Message-State: AOAM5332fkDIni3bwMuOdeQtjQiLdtnmiuHQkfe2+zUA09q5X2UYqDWE
        Dlr65wAQUAosVa73iNrycUvRhwOBrGDfgbdqpXNvXA==
X-Google-Smtp-Source: ABdhPJzJw4KgkJbenDZ3eRyuNArJv7PEx7sB7gl7qawjuImMGLaiTrCbHJ72Qq8vfr5+K6TKfCVpe7qITXjle8uYEuw=
X-Received: by 2002:aa7:c50d:: with SMTP id o13mr29112216edq.153.1628048065144;
 Tue, 03 Aug 2021 20:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627828548.git.zhansayabagdaulet@gmail.com> <5de9beffc409b660229695e0ad921825903156d6.1627828548.git.zhansayabagdaulet@gmail.com>
In-Reply-To: <5de9beffc409b660229695e0ad921825903156d6.1627828548.git.zhansayabagdaulet@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 3 Aug 2021 23:33:49 -0400
Message-ID: <CA+CK2bBpzdWMYoJdR2EQNNCrRn+Pg1Gs2oBqLR65JW3UUnWt0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: vm: add KSM merging time test
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
> Add ksm_merge_time() function to determine speed and time needed for
> merging. The total spent time is shown in seconds while speed is
> in MB/s. User must specify the size of duplicated memory area (in MB)
> before running the test.
>
> The test is run as follows: ./ksm_tests -P -s 100
> The output:
>         Total size:    100 MB
>         Total time:    0.309561 s
>         Average speed: 323 MB/s
>
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
> ---
>  tools/testing/selftests/vm/ksm_tests.c | 76 ++++++++++++++++++++++++--
>  1 file changed, 72 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
> index cdeb4a028538..91c6ff496655 100644
> --- a/tools/testing/selftests/vm/ksm_tests.c
> +++ b/tools/testing/selftests/vm/ksm_tests.c
> @@ -7,6 +7,7 @@
>  #include <numa.h>
>
>  #include "../kselftest.h"
> +#include "../../../../include/vdso/time64.h"
>
>  #define KSM_SYSFS_PATH "/sys/kernel/mm/ksm/"
>  #define KSM_FP(s) (KSM_SYSFS_PATH s)
> @@ -15,6 +16,7 @@
>  #define KSM_PROT_STR_DEFAULT "rw"
>  #define KSM_USE_ZERO_PAGES_DEFAULT false
>  #define KSM_MERGE_ACROSS_NODES_DEFAULT true
> +#define MB_TO_B 1000000ul

We should calculate everything in true megabytes.

#define MB (1ul << 20)

Also, print in MiB/s.

>
>  struct ksm_sysfs {
>         unsigned long max_page_sharing;
> @@ -30,7 +32,8 @@ enum ksm_test_name {
>         CHECK_KSM_MERGE,
>         CHECK_KSM_UNMERGE,
>         CHECK_KSM_ZERO_PAGE_MERGE,
> -       CHECK_KSM_NUMA_MERGE
> +       CHECK_KSM_NUMA_MERGE,
> +       KSM_MERGE_TIME
>  };
>
>  static int ksm_write_sysfs(const char *file_path, unsigned long val)
> @@ -86,13 +89,16 @@ static int str_to_prot(char *prot_str)
>  static void print_help(void)
>  {
>         printf("usage: ksm_tests [-h] <test type> [-a prot] [-p page_count] [-l timeout]\n"
> -              "[-z use_zero_pages] [-m merge_across_nodes]\n");
> +              "[-z use_zero_pages] [-m merge_across_nodes] [-s size]\n");
>
>         printf("Supported <test type>:\n"
>                " -M (page merging)\n"
>                " -Z (zero pages merging)\n"
>                " -N (merging of pages in different NUMA nodes)\n"
> -              " -U (page unmerging)\n\n");
> +              " -U (page unmerging)\n"
> +              " -P evaluate merging time and speed.\n"
> +              "    For this test, the size of duplicated memory area (in MB)\n"
> +              "    must be provided using -s option\n\n");
>
>         printf(" -a: specify the access protections of pages.\n"
>                "     <prot> must be of the form [rwx].\n"
> @@ -105,6 +111,7 @@ static void print_help(void)
>                "     Default: %d\n", KSM_USE_ZERO_PAGES_DEFAULT);
>         printf(" -m: change merge_across_nodes tunable\n"
>                "     Default: %d\n", KSM_MERGE_ACROSS_NODES_DEFAULT);
> +       printf(" -s: the size of duplicated memory area (in MB)\n");
>
>         exit(0);
>  }
> @@ -407,6 +414,49 @@ static int check_ksm_numa_merge(int mapping, int prot, int timeout, bool merge_a
>         return KSFT_FAIL;
>  }
>
> +static int ksm_merge_time(int mapping, int prot, int timeout, size_t map_size)
> +{
> +       void *map_ptr;
> +       struct timespec start_time, end_time;
> +       long scan_time_s, scan_time_ns;

Should be "unsigned long".

> +       int avg_speed;
No needed, see below.

> +
> +       map_size *= MB_TO_B;
> +
> +       map_ptr = allocate_memory(NULL, prot, mapping, '*', map_size);
> +       if (!map_ptr)
> +               return KSFT_FAIL;
> +
> +       if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
> +               perror("clock_gettime");
> +               goto err_out;
> +       }
> +       if (ksm_merge_pages(map_ptr, map_size, start_time, timeout))
> +               goto err_out;
> +       if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
> +               perror("clock_gettime");
> +               goto err_out;
> +       }
> +
> +       scan_time_ns = (end_time.tv_sec - start_time.tv_sec) * NSEC_PER_SEC +
> +                      (end_time.tv_nsec - start_time.tv_nsec);

> +       scan_time_s = scan_time_ns / NSEC_PER_SEC;
> +       scan_time_ns %= NSEC_PER_SEC;
> +       avg_speed = map_size / (scan_time_s * USEC_PER_SEC + scan_time_ns / NSEC_PER_USEC);

Please remove the above three lines, and replace with bellow suggestions:

> +
> +       printf("Total size:    %lu MB\n", map_size / MB_TO_B);

printf("Total size:    %lu MiB\n", map_size / MB);

> +       printf("Total time:    %ld.%06ld s\n", scan_time_s, scan_time_ns / NSEC_PER_USEC);

printf("Total time:    %ld.%09ld s\n", scan_time_ns / NSEC_PER_SEC,
scan_time_ns % NSEC_PER_SEC));

> +       printf("Average speed: %d MB/s\n", avg_speed);

The following would give a much better precision:
printf("Average speed:  %.3f MiB/s\n", (map_size / MB) /
((double)scan_time_ns / NSEC_PER_SEC));

> +
> +       munmap(map_ptr, map_size);
> +       return KSFT_PASS;
> +
> +err_out:
> +       printf("Not OK\n");
> +       munmap(map_ptr, map_size);
> +       return KSFT_FAIL;
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         int ret, opt;
> @@ -418,8 +468,9 @@ int main(int argc, char *argv[])
>         int test_name = CHECK_KSM_MERGE;
>         bool use_zero_pages = KSM_USE_ZERO_PAGES_DEFAULT;
>         bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
> +       long size_MB = 0;
>
> -       while ((opt = getopt(argc, argv, "ha:p:l:z:m:MUZN")) != -1) {
> +       while ((opt = getopt(argc, argv, "ha:p:l:z:m:s:MUZNP")) != -1) {
>                 switch (opt) {
>                 case 'a':
>                         prot = str_to_prot(optarg);
> @@ -453,6 +504,12 @@ int main(int argc, char *argv[])
>                         else
>                                 merge_across_nodes = 1;
>                         break;
> +               case 's':
> +                       size_MB = atoi(optarg);
> +                       if (size_MB <= 0) {
> +                               printf("Size must be greater than 0\n");
> +                               return KSFT_FAIL;
> +                       }
>                 case 'M':
>                         break;
>                 case 'U':
> @@ -464,6 +521,9 @@ int main(int argc, char *argv[])
>                 case 'N':
>                         test_name = CHECK_KSM_NUMA_MERGE;
>                         break;
> +               case 'P':
> +                       test_name = KSM_MERGE_TIME;
> +                       break;
>                 default:
>                         return KSFT_FAIL;
>                 }
> @@ -505,6 +565,14 @@ int main(int argc, char *argv[])
>                 ret = check_ksm_numa_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
>                                            merge_across_nodes, page_size);
>                 break;
> +       case KSM_MERGE_TIME:
> +               if (size_MB == 0) {
> +                       printf("Option '-s' is required.\n");
> +                       return KSFT_FAIL;
> +               }
> +               ret = ksm_merge_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit_sec,
> +                                    size_MB);
> +               break;
>         }
>
>         if (ksm_restore(&ksm_sysfs_old)) {
> --
> 2.25.1
>
