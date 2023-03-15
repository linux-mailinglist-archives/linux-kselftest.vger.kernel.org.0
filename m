Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2B16BC0E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 00:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjCOX2s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 19:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCOX2p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 19:28:45 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0674EC68
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 16:28:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso3443506pjb.3
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 16:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678922922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U/XHH5xA0LiSHgmYOixKxhW3un3ttTrDIMNjVuOodwM=;
        b=EQqDYUKifkpVFhhYe009xvgIpS5kW2MoYKA2EKF20WKP3IoqH+lrgcRp6AdFuU86Ri
         +t3f3y/xrpzM7cecPy7bfjJsvQyP348pv1ApkKUxMI2PwHibCy4FlrjLrBBkcAe/azB8
         0EBKpd1QEtvdcG8+1GxnIdL8PExQSo8RdbB9qENgcJmn4xgYS7VmxAFjI43Q35r1DxhJ
         RPilI96028csTiByHWTSCP2J3mvWdz89rs/tBRXho3oPBs8eE/4w+PFq9USEOx4jacG7
         tek8cagIewM6Kv11i6m2XnHJYaYfL5cfUstcKkhd+lwAGqkkR5kES4PpjpBf2yJYk/Rp
         N9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678922922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/XHH5xA0LiSHgmYOixKxhW3un3ttTrDIMNjVuOodwM=;
        b=3K/PmBfr17QFaSgxBiTFtw2360/b2gY6aWsOENh/9uAoXkTAn59RqL4/1iOH5xWWED
         XA5BShRb12DT5RUUURnVBcC2J9aqzUpgKdaDAnt+ZqvctISM/LREluVz5LW2Je7I7CSd
         z1GG8Dp8aii/X67VBKsdN4Zxim68geGYkkZnM72QdqDIkP+qwvuLqM8CrmBTV1lfQEHP
         j3drjP4t0WiByWqoq23lC/C7cbE3orFoNiiI4e9OM4klGgdYVg4TddKxKfhfJr7LMkVV
         hEJ5MmHNJ3DdfYbf7ahtQKX358a+Ae/h0gYmrzjUK5LS/ZJ3BarXxpHLY8iYRYafVE3f
         o6Eg==
X-Gm-Message-State: AO0yUKXjU2l1p2hpx+csRiCNOeqSytUJmZejkYQLmlE0BQVaFnurBAp+
        jgDLtzJqm/psozKSLmR8l1xE/w==
X-Google-Smtp-Source: AK7set8zTtOuZpy2rQKLjeXy3FUDJGSFpJIg34NtjkmNXizL7dZJ+RPewhrHDA0rNY4no80w4XYPfQ==
X-Received: by 2002:a17:902:c94b:b0:1a0:563e:b0d1 with SMTP id i11-20020a170902c94b00b001a0563eb0d1mr50590pla.18.1678922922035;
        Wed, 15 Mar 2023 16:28:42 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id v16-20020a62a510000000b005d72e54a7e1sm4002840pfm.215.2023.03.15.16.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 16:28:41 -0700 (PDT)
Date:   Wed, 15 Mar 2023 16:28:37 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Peter Xu <peterx@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH mm-unstable v1] selftests/vm: cow: Add COW tests for
 collapsing of PTE-mapped anon THP
Message-ID: <CAAa6QmSZTQ6=oxsTvCLoaFMcpamkNa7wY6VkDoipRTDAo5JhoQ@mail.gmail.com>
References: <20230104144905.460075-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104144905.460075-1-david@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>
> Currently, anonymous PTE-mapped THPs cannot be collapsed in-place:
> collapsing (e.g., via MADV_COLLAPSE) implies allocating a fresh THP and
> mapping that new THP via a PMD: as it's a fresh anon THP, it will get the
> exclusive flag set on the head page and everybody is happy.
>
> However, if the kernel would ever support in-place collapse of anonymous
> THPs (replacing a page table mapping each sub-page of a THP via PTEs with a
> single PMD mapping the complete THP), exclusivity information stored for
> each sub-page would have to be collapsed accordingly:
>
> (1) All PTEs map !exclusive anon sub-pages: the in-place collapsed THP
>     must not not have the exclusive flag set on the head page mapped by
>     the PMD. This is the easiest case to handle ("simply don't set any
>     exclusive flags").
>
> (2) All PTEs map exclusive anon sub-pages: when collapsing, we have to
>     clear the exclusive flag from all tail pages and only leave the
>     exclusive flag set for the head page. Otherwise, fork() after
>     collapse would not clear the exclusive flags from the tail pages
>     and we'd be in trouble once PTE-mapping the shared THP when writing
>     to shared tail pages that still have the exclusive flag set. This
>     would effectively revert what the PTE-mapping code does when
>     propagating the exclusive flag to all sub-pages.
>
> (3) PTEs map a mixture of exclusive and !exclusive anon sub-pages (can
>     happen e.g., due to MADV_DONTFORK before fork()). We must not
>     collapse the THP in-place, otherwise bad things may happen:
>     the exclusive flags of sub-pages would get ignored and the
>     exclusive flag of the head page would get used instead.
>
> Now that we have MADV_COLLAPSE in place to trigger collapsing a THP,
> let's add some test cases that would bail out early, if we'd
> voluntarily/accidantially unlock in-place collapse for anon THPs and
> forget about taking proper care of exclusive flags.

Hey David,

Sorry for the (very) delayed review. As our helpful syncs offline, I'm in a
better place to understand the intent of these tests.

On Wed, Jan 4, 2023 at 6:49 AM David Hildenbrand <david@redhat.com> wrote:

> Running the test on a kernel with MADV_COLLAPSE support:
>   # [INFO] Anonymous THP tests
>   # [RUN] Basic COW after fork() when collapsing before fork()
>   ok 169 No leak from parent into child
>   # [RUN] Basic COW after fork() when collapsing after fork() (fully shared)
>   ok 170 # SKIP MADV_COLLAPSE failed: Invalid argument
>   # [RUN] Basic COW after fork() when collapsing after fork() (lower shared)
>   ok 171 No leak from parent into child
>   # [RUN] Basic COW after fork() when collapsing after fork() (upper shared)
>   ok 172 No leak from parent into child
>
> For now, MADV_COLLAPSE always seems to fail if all PTEs map shared
> sub-pages.

Thanks for pointing this out. I have had a TODO / pending patch to verify this
for awhile. It seems this is due to some old requirement of requiring a single
writeable pte. I don't know this history well here, but I don't think it's
required anymore, and, as this test shows, prevents collapse of
pte-mapped-hugepage shared across fork().

>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: Zach O'Keefe <zokeefe@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>
> A patch from Hugh made me explore the wonderful world of in-place collapse
> of THP, and I was briefly concerned that it would apply to anon THP as
> well. After thinking about it a bit, I decided to add test cases, to better
> be safe than sorry in any case, and to document how PG_anon_exclusive is to
> be handled in that case.
>
> ---
>  tools/testing/selftests/vm/cow.c | 228 +++++++++++++++++++++++++++++++
>  1 file changed, 228 insertions(+)
>
> diff --git a/tools/testing/selftests/vm/cow.c b/tools/testing/selftests/vm/cow.c
> index 26f6ea3079e2..16216d893d96 100644
> --- a/tools/testing/selftests/vm/cow.c
> +++ b/tools/testing/selftests/vm/cow.c
> @@ -30,6 +30,10 @@
>  #include "../kselftest.h"
>  #include "vm_util.h"
>
> +#ifndef MADV_COLLAPSE
> +#define MADV_COLLAPSE 25
> +#endif
> +
>  static size_t pagesize;
>  static int pagemap_fd;
>  static size_t thpsize;
> @@ -1178,6 +1182,228 @@ static int tests_per_anon_test_case(void)
>         return tests;
>  }
>
> +enum anon_thp_collapse_test {
> +       ANON_THP_COLLAPSE_UNSHARED,

OK, so this test checks case 2: we see all PG_anon_exclusive, and need to make
sure we clear the bit on tails. Had we not, after fork(), the bit would still be
set on tails (since copy_huge_pmd() -> page_try_dup_anon_rmap() only clears it
on head), and so write to said tails would go through after wp fault, and since
collapse was in-place, this leaks data from parent to child.

> +       ANON_THP_COLLAPSE_FULLY_SHARED,

This checks case 1: we see all !PG_anon_exclusive, we aught to set the flag on
head page in parent, after fork(). Had we not, subsequent write will be allowed
to go through after wp fault and hit backing page -- which, since collapse was
in-place, is same as child, leaking data.

> +       ANON_THP_COLLAPSE_LOWER_SHARED,
> +       ANON_THP_COLLAPSE_UPPER_SHARED,

IIUC, this check only partially tests case 3. Had we introduced a bug where we
set PG_anon_exclusive on the head in this mixed-case, it's very similar to
ANON_THP_COLLAPSE_FULLY_SHARED.

However, if we decided to still attempt in-place collapse, and cleared the bit
in the parent, then the write here will be CoW'd and we won't see data leak
into the child. In order for problems to occur, we'd need something to trip
the improper CoW. The example you've shared with me was a io_uring fixed buffer
mapping the non-shared pages, which, after CoW, would disagree.

That said, I'm not sure the extra work required to catch this case is worth the
effort.

> +};
> +
> +static void do_test_anon_thp_collapse(char *mem, size_t size,
> +                                     enum anon_thp_collapse_test test)
> +{
> +       struct comm_pipes comm_pipes;
> +       char buf;
> +       int ret;
> +
> +       ret = setup_comm_pipes(&comm_pipes);
> +       if (ret) {
> +               ksft_test_result_fail("pipe() failed\n");
> +               return;
> +       }
> +
> +       /*
> +        * Trigger PTE-mapping the THP by temporarily mapping a single subpage
> +        * R/O, such that we can try collapsing it later.
> +        */
> +       ret = mprotect(mem + pagesize, pagesize, PROT_READ);
> +       if (ret) {
> +               ksft_test_result_fail("mprotect() failed\n");
> +               goto close_comm_pipes;
> +       }
> +       ret = mprotect(mem + pagesize, pagesize, PROT_READ | PROT_WRITE);
> +       if (ret) {
> +               ksft_test_result_fail("mprotect() failed\n");
> +               goto close_comm_pipes;
> +       }

Might be a good place for a check_huge_anon(mem, 0, ..) to validate pte-mapped.

> +       switch (test) {
> +       case ANON_THP_COLLAPSE_UNSHARED:
> +               /* Collapse before actually COW-sharing the page. */
> +               ret = madvise(mem, size, MADV_COLLAPSE);
> +               if (ret) {
> +                       ksft_test_result_skip("MADV_COLLAPSE failed: %s\n",
> +                                             strerror(errno));
> +                       goto close_comm_pipes;
> +               }
> +               break;
> +       case ANON_THP_COLLAPSE_FULLY_SHARED:
> +               /* COW-share the full PTE-mapped THP. */
> +               break;
> +       case ANON_THP_COLLAPSE_LOWER_SHARED:
> +               /* Don't COW-share the upper part of the THP. */
> +               ret = madvise(mem + size / 2, size / 2, MADV_DONTFORK);
> +               if (ret) {
> +                       ksft_test_result_fail("MADV_DONTFORK failed\n");
> +                       goto close_comm_pipes;
> +               }
> +               break;
> +       case ANON_THP_COLLAPSE_UPPER_SHARED:
> +               /* Don't COW-share the lower part of the THP. */
> +               ret = madvise(mem, size / 2, MADV_DONTFORK);
> +               if (ret) {
> +                       ksft_test_result_fail("MADV_DONTFORK failed\n");
> +                       goto close_comm_pipes;
> +               }
> +               break;
> +       default:
> +               assert(false);
> +       }
> +
> +       ret = fork();
> +       if (ret < 0) {
> +               ksft_test_result_fail("fork() failed\n");
> +               goto close_comm_pipes;
> +       } else if (!ret) {
> +               switch (test) {
> +               case ANON_THP_COLLAPSE_UNSHARED:
> +               case ANON_THP_COLLAPSE_FULLY_SHARED:
> +                       exit(child_memcmp_fn(mem, size, &comm_pipes));
> +                       break;
> +               case ANON_THP_COLLAPSE_LOWER_SHARED:
> +                       exit(child_memcmp_fn(mem, size / 2, &comm_pipes));
> +                       break;
> +               case ANON_THP_COLLAPSE_UPPER_SHARED:
> +                       exit(child_memcmp_fn(mem + size / 2, size / 2,
> +                                            &comm_pipes));
> +                       break;
> +               default:
> +                       assert(false);
> +               }
> +       }
> +
> +       while (read(comm_pipes.child_ready[0], &buf, 1) != 1)
> +               ;
> +
> +       switch (test) {
> +       case ANON_THP_COLLAPSE_UNSHARED:
> +               break;
> +       case ANON_THP_COLLAPSE_UPPER_SHARED:
> +       case ANON_THP_COLLAPSE_LOWER_SHARED:
> +               /*
> +                * Revert MADV_DONTFORK such that we merge the VMAs and are
> +                * able to actually collapse.
> +                */
> +               ret = madvise(mem, size, MADV_DOFORK);
> +               if (ret) {
> +                       ksft_test_result_fail("MADV_DOFORK failed\n");
> +                       write(comm_pipes.parent_ready[1], "0", 1);
> +                       wait(&ret);
> +                       goto close_comm_pipes;
> +               }
> +               /* FALLTHROUGH */
> +       case ANON_THP_COLLAPSE_FULLY_SHARED:
> +               /* Collapse before anyone modified the COW-shared page. */
> +               ret = madvise(mem, size, MADV_COLLAPSE);
> +               if (ret) {
> +                       ksft_test_result_skip("MADV_COLLAPSE failed: %s\n",
> +                                             strerror(errno));
> +                       write(comm_pipes.parent_ready[1], "0", 1);
> +                       wait(&ret);
> +                       goto close_comm_pipes;
> +               }
> +               break;
> +       default:
> +               assert(false);
> +       }
> +
> +       /* Modify the page. */
> +       memset(mem, 0xff, size);
> +       write(comm_pipes.parent_ready[1], "0", 1);
> +
> +       wait(&ret);
> +       if (WIFEXITED(ret))
> +               ret = WEXITSTATUS(ret);
> +       else
> +               ret = -EINVAL;
> +
> +       ksft_test_result(!ret, "No leak from parent into child\n");
> +close_comm_pipes:
> +       close_comm_pipes(&comm_pipes);
> +}
> +
> +static void test_anon_thp_collapse_unshared(char *mem, size_t size)
> +{
> +       do_test_anon_thp_collapse(mem, size, ANON_THP_COLLAPSE_UNSHARED);
> +}
> +
> +static void test_anon_thp_collapse_fully_shared(char *mem, size_t size)
> +{
> +       do_test_anon_thp_collapse(mem, size, ANON_THP_COLLAPSE_FULLY_SHARED);
> +}
> +
> +static void test_anon_thp_collapse_lower_shared(char *mem, size_t size)
> +{
> +       do_test_anon_thp_collapse(mem, size, ANON_THP_COLLAPSE_LOWER_SHARED);
> +}
> +
> +static void test_anon_thp_collapse_upper_shared(char *mem, size_t size)
> +{
> +       do_test_anon_thp_collapse(mem, size, ANON_THP_COLLAPSE_UPPER_SHARED);
> +}
> +
> +/*
> + * Test cases that are specific to anonymous THP: pages in private mappings
> + * that may get shared via COW during fork().
> + */
> +static const struct test_case anon_thp_test_cases[] = {
> +       /*
> +        * Basic COW test for fork() without any GUP when collapsing a THP
> +        * before fork().
> +        *
> +        * Re-mapping a PTE-mapped anon THP using a single PMD ("in-place
> +        * collapse") might easily get COW handling wrong when not collapsing
> +        * exclusivity information properly.
> +        */
> +       {
> +               "Basic COW after fork() when collapsing before fork()",
> +               test_anon_thp_collapse_unshared,
> +       },
> +       /* Basic COW test, but collapse after COW-sharing a full THP. */
> +       {
> +               "Basic COW after fork() when collapsing after fork() (fully shared)",
> +               test_anon_thp_collapse_fully_shared,
> +       },
> +       /*
> +        * Basic COW test, but collapse after COW-sharing the lower half of a
> +        * THP.
> +        */
> +       {
> +               "Basic COW after fork() when collapsing after fork() (lower shared)",
> +               test_anon_thp_collapse_lower_shared,
> +       },
> +       /*
> +        * Basic COW test, but collapse after COW-sharing the upper half of a
> +        * THP.
> +        */
> +       {
> +               "Basic COW after fork() when collapsing after fork() (upper shared)",
> +               test_anon_thp_collapse_upper_shared,
> +       },
> +};
> +
> +static void run_anon_thp_test_cases(void)
> +{
> +       int i;
> +
> +       if (!thpsize)
> +               return;
> +
> +       ksft_print_msg("[INFO] Anonymous THP tests\n");
> +
> +       for (i = 0; i < ARRAY_SIZE(anon_thp_test_cases); i++) {
> +               struct test_case const *test_case = &anon_thp_test_cases[i];
> +
> +               ksft_print_msg("[RUN] %s\n", test_case->desc);
> +               do_run_with_thp(test_case->fn, THP_RUN_PMD);
> +       }
> +}
> +
> +static int tests_per_anon_thp_test_case(void)
> +{
> +       return thpsize ? 1 : 0;
> +}
> +
>  typedef void (*non_anon_test_fn)(char *mem, const char *smem, size_t size);
>
>  static void test_cow(char *mem, const char *smem, size_t size)
> @@ -1518,6 +1744,7 @@ int main(int argc, char **argv)
>
>         ksft_print_header();
>         ksft_set_plan(ARRAY_SIZE(anon_test_cases) * tests_per_anon_test_case() +
> +                     ARRAY_SIZE(anon_thp_test_cases) * tests_per_anon_thp_test_case() +
>                       ARRAY_SIZE(non_anon_test_cases) * tests_per_non_anon_test_case());
>
>         gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
> @@ -1526,6 +1753,7 @@ int main(int argc, char **argv)
>                 ksft_exit_fail_msg("opening pagemap failed\n");
>
>         run_anon_test_cases();
> +       run_anon_thp_test_cases();
>         run_non_anon_test_cases();
>
>         err = ksft_get_fail_cnt();
> --
> 2.39.0
>

Overall the tests look good, though too late to record that in the log. At least
mail archives will have it.
