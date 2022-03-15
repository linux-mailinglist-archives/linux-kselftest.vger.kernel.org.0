Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADFB4DA444
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Mar 2022 21:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiCOUy1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Mar 2022 16:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiCOUy0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Mar 2022 16:54:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5E421E05;
        Tue, 15 Mar 2022 13:53:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 88E221F427AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647377588;
        bh=fMsS3LbTcwht92/HR/LuwAiQjOoU49g8L/K9h5T6wuw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NPGaNKmiWX2v2hpAWpVIPDIQNRjkR8AuG4C8ohhDI5soFk9+3OoT6M7lP8Wp7HJqH
         4Zgw7sLqujjMOobSdz9filIP8YCIV6805LSl3yfHdv+woG+f/+oVOozjkaHghYoi0Z
         XmLZGhlmTa27/3SYPV4M3ZppvRf3o+41dWiwc01jz0JPJL7N6ktyeepxZV41RFsDYf
         3OqeiDR9qlo7uqk1+mIEzDTIKs1rdtPj5nKSrcM15Ui2Fp43HvuJDkjaBugDSP3mH1
         +DES5GfJ52tuT6VSp8JAQ3DlgcybCIQgacSDXcDtwMZye2nSmCAQnzSLSK7kT7cxy3
         h8/Xr8akde8Nw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V4 2/2] selftests: vm: Add test for Soft-Dirty PTE bit
Organization: Collabora
References: <20220315085014.1047291-1-usama.anjum@collabora.com>
        <20220315085014.1047291-2-usama.anjum@collabora.com>
Date:   Tue, 15 Mar 2022 16:53:05 -0400
In-Reply-To: <20220315085014.1047291-2-usama.anjum@collabora.com> (Muhammad
        Usama Anjum's message of "Tue, 15 Mar 2022 13:50:12 +0500")
Message-ID: <871qz3ndji.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Muhammad Usama Anjum <usama.anjum@collabora.com> writes:

> From: Gabriel Krisman Bertazi <krisman@collabora.com>

Hi Usama,

Please, cc me on the whole thread.  I didn't get the patch 1/2 or the
cover letter.

> This introduces three tests:
> 1) Sanity check soft dirty basic semantics: allocate area, clean, dirty,
> check if the SD bit is flipped.
> 2) Check VMA reuse: validate the VM_SOFTDIRTY usage
> 3) Check soft-dirty on huge pages
>
> This was motivated by Will Deacon's fix commit 912efa17e512 ("mm: proc:
> Invalidate TLB after clearing soft-dirty page state"). I was tracking the
> same issue that he fixed, and this test would have caught it.
>
> CC: Will Deacon <will@kernel.org>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> V3 of this patch is in Andrew's tree. Please drop that.

v3 is still in linux-next and this note is quite hidden in the middle of
the commit message.

>
> Changes in V4:
> Cosmetic changes
> Removed global variables
> Replaced ksft_print_msg with ksft_exit_fail_msg to exit the program at
> once
> Some other minor changes
> Correct the authorship of the patch
>
> Tests of soft dirty bit in this patch and in madv_populate.c are
> non-overlapping. madv_populate.c has only one soft-dirty bit test in the
> context of different advise (MADV_POPULATE_READ and
> MADV_POPULATE_WRITE). This new test adds more tests.
>
> Tab width of 8 has been used to align the macros. This alignment may look
> odd in shell or email. But it looks alright in editors.

I'm curious if you tested reverting 912efa17e512. Did the new versions
of this patch still catch the original issue?

> Test output:
> TAP version 13
> 1..5
> ok 1 Test test_simple
> ok 2 Test test_vma_reuse reused memory location
> ok 3 Test test_vma_reuse dirty bit of previous page
> ok 4 Test test_hugepage huge page allocation
> ok 5 Test test_hugepage huge page dirty bit
>  # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Or
>
> TAP version 13
> 1..5
> ok 1 Test test_simple
> ok 2 Test test_vma_reuse reused memory location
> ok 3 Test test_vma_reuse dirty bit of previous page
> ok 4 # SKIP Test test_hugepage huge page allocation
> ok 5 # SKIP Test test_hugepage huge page dirty bit
>  # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:2 error:0
>
> Changes in V3:
> Move test to selftests/vm
> Use kselftest macros
> Minor updates to make code more maintainable
> Add configurations in config file
>
> V2 of this patch:
> https://lore.kernel.org/lkml/20210603151518.2437813-1-krisman@collabora.com/
> ---
>  tools/testing/selftests/vm/.gitignore   |   1 +
>  tools/testing/selftests/vm/Makefile     |   2 +
>  tools/testing/selftests/vm/config       |   2 +
>  tools/testing/selftests/vm/soft-dirty.c | 146 ++++++++++++++++++++++++
>  4 files changed, 151 insertions(+)
>  create mode 100644 tools/testing/selftests/vm/soft-dirty.c
>
> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
> index d7507f3c7c76a..3cb4fa771ec2a 100644
> --- a/tools/testing/selftests/vm/.gitignore
> +++ b/tools/testing/selftests/vm/.gitignore
> @@ -29,5 +29,6 @@ write_to_hugetlbfs
>  hmm-tests
>  memfd_secret
>  local_config.*
> +soft-dirty
>  split_huge_page_test
>  ksm_tests
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 4e68edb26d6b6..f25eb30b5f0cb 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -47,6 +47,7 @@ TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += userfaultfd
> +TEST_GEN_PROGS += soft-dirty
>  TEST_GEN_PROGS += split_huge_page_test
>  TEST_GEN_FILES += ksm_tests
>  
> @@ -92,6 +93,7 @@ KSFT_KHDR_INSTALL := 1
>  include ../lib.mk
>  
>  $(OUTPUT)/madv_populate: vm_util.c
> +$(OUTPUT)/soft-dirty: vm_util.c
>  $(OUTPUT)/split_huge_page_test: vm_util.c
>  
>  ifeq ($(MACHINE),x86_64)
> diff --git a/tools/testing/selftests/vm/config b/tools/testing/selftests/vm/config
> index 60e82da0de850..be087c4bc3961 100644
> --- a/tools/testing/selftests/vm/config
> +++ b/tools/testing/selftests/vm/config
> @@ -4,3 +4,5 @@ CONFIG_TEST_VMALLOC=m
>  CONFIG_DEVICE_PRIVATE=y
>  CONFIG_TEST_HMM=m
>  CONFIG_GUP_TEST=y
> +CONFIG_TRANSPARENT_HUGEPAGE=y
> +CONFIG_MEM_SOFT_DIRTY=y
> diff --git a/tools/testing/selftests/vm/soft-dirty.c b/tools/testing/selftests/vm/soft-dirty.c
> new file mode 100644
> index 0000000000000..2d50ed3472206
> --- /dev/null
> +++ b/tools/testing/selftests/vm/soft-dirty.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <malloc.h>
> +#include <sys/mman.h>
> +#include "../kselftest.h"
> +#include "vm_util.h"
> +
> +#define PAGEMAP			"/proc/self/pagemap"
> +#define CLEAR_REFS		"/proc/self/clear_refs"
> +#define MAX_LINE_LENGTH		512

MAX_LINE_LENGTH is no longer used after check_for_pattern was dropped.

Can't the previous defines and file handling functions also go the
vm_util.h?

> +#define TEST_ITERATIONS		10000
> +
> +static void test_simple(int pagemap_fd, int pagesize)
> +{
> +	int i;
> +	char *map;
> +
> +	map = aligned_alloc(pagesize, pagesize);
> +	if (!map)
> +		ksft_exit_fail_msg("mmap failed\n");
> +
> +	clear_softdirty();
> +
> +	for (i = 0 ; i < TEST_ITERATIONS; i++) {
> +		if (pagemap_is_softdirty(pagemap_fd, map) == 1) {
> +			ksft_print_msg("dirty bit was 1, but should be 0 (i=%d)\n", i);
> +			break;
> +		}
> +
> +		clear_softdirty();
> +		map[0]++;


This will overflow several times during TEST_ITERATIONS.  While it is
not broken, since we care about causing the page fault, it is not
obvious.  Can you add a comment or do something like this instead?

  map[0] = !map[0];

-- 
Gabriel Krisman Bertazi
