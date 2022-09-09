Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CCF5B32CC
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 11:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiIIJFv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 05:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiIIJFT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 05:05:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8689D89906;
        Fri,  9 Sep 2022 02:04:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A28D122D0B;
        Fri,  9 Sep 2022 09:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662714291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VS9Tg2cOgBBFD8Gi5AkXQ2SCWybmG/CQfZ0zhS2Ao0I=;
        b=pJPiinpxTnjFmPGuhukeVlIUxpVfFKLnxShkTUO7/MoLu9JaP9pcB1FfSpFRP1X6dt8GMi
        JPbKgZo04T7+9vNMRpRrzYQF2x4xgT2AmdCm5++ryQQPvEcYWLeAkk+WbXOFBGQnDKsH05
        hrWDX4WV6uxrMCva8FXnt0UlEzkTg8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662714291;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VS9Tg2cOgBBFD8Gi5AkXQ2SCWybmG/CQfZ0zhS2Ao0I=;
        b=pLq/GKiLpr4+dnZfpXZR5G8i8hvxMqEpLaYvUk1gSUZZWWLsKwpEuCRVFe42T1Pu+JVmHO
        kiy2eeKKLwHzjXBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8824D139D5;
        Fri,  9 Sep 2022 09:04:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ke8xILMBG2PUVgAAMHmgww
        (envelope-from <chrubis@suse.cz>); Fri, 09 Sep 2022 09:04:51 +0000
Date:   Fri, 9 Sep 2022 11:06:46 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Tarun Sahu <tsahu@linux.ibm.com>
Cc:     ltp@lists.linux.it, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, aneesh.kumar@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [LTP] [RFC PATCH] Hugetlb: Migrating hugetlb tests from
 libhugetlbfs
Message-ID: <YxsCJi8O+HmMpefq@yuki>
References: <20220908173947.17956-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908173947.17956-1-tsahu@linux.ibm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   2 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  | 106 ++++++++++++++++++
>  3 files changed, 109 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index f719217ab..ee02835d3 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -3,6 +3,8 @@ hugemmap02 hugemmap02
>  hugemmap04 hugemmap04
>  hugemmap05 hugemmap05
>  hugemmap06 hugemmap06
> +hugemmap07 hugemmap07
> +
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index ff2910533..df5256ec8 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -4,6 +4,7 @@
>  /hugetlb/hugemmap/hugemmap04
>  /hugetlb/hugemmap/hugemmap05
>  /hugetlb/hugemmap/hugemmap06
> +/hugetlb/hugemmap/hugemmap07
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> new file mode 100644
> index 000000000..798735ed0
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> @@ -0,0 +1,106 @@
> +/*
> + * License/Copyright Details
> + */

There should be a SPDX licence identifier here instead.

Also testcase should include a special ascii-doc formatted comment here
that describes the purpose of the test.

> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +
> +#include "tst_test.h"
> +
> +#define P0 "ffffffff"
> +#define IOSZ 4096
> +char buf[IOSZ] __attribute__((aligned(IOSZ)));
> +static int  fildes = -1, nfildes = -1;
> +static char TEMPFILE[MAXPATHLEN];
> +static char NTEMPFILE[MAXPATHLEN];

Uppercase is reserved for macros in C.

Have you run 'make check' to check for common mistakes before
submitting?

> +void test_directio(void)

should be static

> +{
> +	long hpage_size;
> +	void *p;
> +	int ret;
> +
> +	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:");
> +
> +	fildes = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0600);
> +	nfildes = SAFE_OPEN(NTEMPFILE, O_CREAT|O_EXCL|O_RDWR|O_DIRECT, 0600);

I would say that fd and nfd in the original code was were better names,
shorter and to the point. See also:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

> +	p = mmap(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fildes, 0);
> +	if (p == MAP_FAILED)
> +		tst_brk(TFAIL | TERRNO, "mmap() Failed on %s", TEMPFILE);

We do have SAFE_MMAP() as well.

> +	memcpy(p, P0, 8);
> +
> +	/* Direct write from huge page */
> +	ret = write(nfildes, p, IOSZ);
> +	if (ret == -1)
> +		tst_brk(TFAIL | TERRNO, "Direct-IO write from huge page");
> +	if (ret != IOSZ)
> +		tst_brk(TFAIL, "Short direct-IO write from huge page");
> +	if (lseek(nfildes, 0, SEEK_SET) == -1)
> +		tst_brk(TFAIL | TERRNO, "lseek");
> +
> +	/* Check for accuracy */
> +	ret = read(nfildes, buf, IOSZ);
> +	if (ret == -1)
> +		tst_brk(TFAIL | TERRNO, "Direct-IO read to normal memory");
> +	if (ret != IOSZ)
> +		tst_brk(TFAIL, "Short direct-IO read to normal memory");
> +	if (memcmp(P0, buf, 8))
> +		tst_brk(TFAIL, "Memory mismatch after Direct-IO write");
> +	if (lseek(nfildes, 0, SEEK_SET) == -1)
> +		tst_brk(TFAIL | TERRNO, "lseek");

And we have SAFE_WRITE(), SAFE_READ(), and SAFE_LSEEK() as well.

Also tst_brk(TFAIL, "") usage is deprecated and should not be used in
new tests.

> +	/* Direct read to huge page */
> +	memset(p, 0, IOSZ);
> +	ret = read(nfildes, p, IOSZ);
> +	if (ret == -1)
> +		tst_brk(TFAIL | TERRNO, "Direct-IO read to huge page");
> +	if (ret != IOSZ)
> +		tst_brk(TFAIL, "Short direct-IO read to huge page");
> +
> +	/* Check for accuracy */
> +	if (memcmp(p, P0, 8))
> +		tst_brk(TFAIL, "Memory mismatch after Direct-IO read");
> +	tst_res(TPASS, "Successfully tested Hugepage Direct I/O");

You should close filedescriptors and unmap memory here, otherwise the
test will fail with large enough -i parameter.

> +}
> +
> +void setup(void)

should be static.

> +{
> +	if (tst_hugepages == 0)
> +		tst_brk(TCONF, "Not enough hugepages for testing.");
> +
> +	if (!Hopt)
> +		Hopt = tst_get_tmpdir();
> +	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
> +
> +	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());

Ideally all files created outside of the test temporary directory should
be prefixed with "ltp_"

> +	snprintf(NTEMPFILE, sizeof(NTEMPFILE), "%s/nmmapfile%d", "/home/", getpid());

Please do not create any files outside of the test temporary directory,
also as the temporary directory is unique already, there is no need to
actually create the second tempfile name like this. All we need to do is
to is something as:

#define NTEMPFILE "tempfile"

> +}
> +
> +void cleanup(void)
> +{
> +	close(fildes);
> +	close(nfildes);
> +	remove(TEMPFILE);
> +	remove(NTEMPFILE);
> +	umount2(Hopt, MNT_DETACH);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.options = (struct tst_option[]) {
> +		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
> +		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
> +		{}
> +	},
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = test_directio,
> +	.hugepages = {2, TST_REQUEST},
> +};
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
