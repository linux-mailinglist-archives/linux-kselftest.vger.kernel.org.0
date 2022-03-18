Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBAD4DE1B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 20:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbiCRTZM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 15:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbiCRTZK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 15:25:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E899304AC5;
        Fri, 18 Mar 2022 12:23:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EF71D1F45C19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647631428;
        bh=WlSxsl1AsukIIoT+HgzKCmviZWgGsHJPvRrOsuv2jMo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jM4edW6w09UWqtmSOGEzQOsPEfY7cXe6gIGCHOxMZ8c6Hv82Sf4WL9YJL10v99060
         4w8ErN+CrDUNSGP6uJBC3TycxdVc28S5a/5RB3ENmDEH/FBNF9sYd+Hk0kZfLuYtdI
         htUPBgQvPM215lCR+lJ6iLDxdi+E2MeIGtiFqAcM6t6lhqazkBrThN0cAOSVvQk1p3
         dJIRPlMw2Z/9nWO4cnp78zSe8R0Llz4N9v6cI9Yrj4hCgiOGFYvxzUWojB3LaMFob3
         1rTZdwbc5zeeWClc/PQELSFfvpaH1bnfX7D+jYg/e87DrpoprnTCE1NjOk4YPVE1iW
         EZ4Ynd4Mw6Xjw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        david@redhat.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V5 2/2] selftests: vm: Add test for Soft-Dirty PTE bit
Organization: Collabora
References: <20220317103323.94799-1-usama.anjum@collabora.com>
        <20220317103323.94799-2-usama.anjum@collabora.com>
Date:   Fri, 18 Mar 2022 15:23:43 -0400
In-Reply-To: <20220317103323.94799-2-usama.anjum@collabora.com> (Muhammad
        Usama Anjum's message of "Thu, 17 Mar 2022 15:33:22 +0500")
Message-ID: <87ilsbyshs.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
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

> new file mode 100644
> index 0000000000000..3153ebac6909b
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
> +#define PAGEMAP_FILE_PATH "/proc/self/pagemap"
> +#define TEST_ITERATIONS 10000
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
> +		// Write something to the page to get the dirty bit enabled on the page
> +		map[0] = i % 255;

you don't need this mod at all but at least it should be 256 :).  I think
Either 'map[0] = !map[0]' or keeping the original 'map[0]++' is fine.

> +
> +		if (pagemap_is_softdirty(pagemap_fd, map) == 0) {
> +			ksft_print_msg("dirty bit was 0, but should be 1 (i=%d)\n", i);
> +			break;
> +		}
> +
> +		clear_softdirty();
> +	}
> +	free(map);
> +
> +	ksft_test_result(i == TEST_ITERATIONS, "Test %s\n", __func__);
> +}
> +
> +static void test_vma_reuse(int pagemap_fd, int pagesize)
> +{
> +	char *map, *map2;
> +
> +	map = mmap(NULL, pagesize, (PROT_READ | PROT_WRITE), (MAP_PRIVATE | MAP_ANON), -1, 0);
> +	if (map == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap failed");
> +
> +	clear_softdirty();
> +
> +	/* Write to the page before unmapping and map the same size region again to check
> +	 * if same memory region is gotten next time and if dirty bit is preserved across
> +	 * this type of allocations.
> +	 */

This reads weird.  It should *not* be preserved across different
mappings.  Also, we are not testing if the same region is reused, we are
depending on it to test the sd bit.

/* Ensures the soft-dirty bit is reset accross different mappings on the
same address.  */

> +	map[0]++;

This is inconsistent with the other two tests.

> +
> +	munmap(map, pagesize);
> +
> +	map2 = mmap(NULL, pagesize, (PROT_READ | PROT_WRITE), (MAP_PRIVATE | MAP_ANON), -1, 0);
> +	if (map2 == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap failed");
> +
> +	ksft_test_result(map == map2, "Test %s reused memory location\n", __func__);

if map != map2, the test itself is broken, meaning we should skip it, not
fail, i guess.

-- 
Gabriel Krisman Bertazi
