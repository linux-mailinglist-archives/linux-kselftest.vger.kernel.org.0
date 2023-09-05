Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C12792619
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbjIEQHf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353587AbjIEGtF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 02:49:05 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B661B4;
        Mon,  4 Sep 2023 23:49:00 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bbbda48904so34884731fa.2;
        Mon, 04 Sep 2023 23:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693896539; x=1694501339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L0V9fvZ6KeiIyqTMjNId9LoUH5rIq4jr71Tfkw0JRCI=;
        b=iVKXgakrz6im3srctMe6rGyhQFH27nbo2n5jsPL1GV5ejv8U0+pJ9GEVcgnBtBS4Xt
         aLTDblFGWxw+490aXDPMYN/PksRp+jtAmMRD2KEIT2tZA2s4X2xnVmsMsUaI+Z7lHSlz
         1nGoVqKAUPjnb3jNR/AggK2xaVkApRr+TcpXqvWka2M/QOgPjBX5l9uOCr35B20SE9CL
         y+g38Aqb0Smvem8+2QDPY2EcOC3Gli6P9NqcYQqE3g0cRNBvxy2cnbWZxGGMDUxRJX5D
         IAwE2ERVxGex40xMSgTiND9tkE6STHrLL+V1DqOHu0fAxyxFn8N+X7Hr1SiYNT8wjbL5
         bMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693896539; x=1694501339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0V9fvZ6KeiIyqTMjNId9LoUH5rIq4jr71Tfkw0JRCI=;
        b=CjOKLsGFsgSPSmS76MKqeHCVyBKxChQDzsCcEQrAX9CG41KeFTpOSRD/kfoo7lioNV
         OSuOTovW+PEDw0PtdXzDshdGnRfq6GTkRMqFaeE0aUwxVOaQXUsAOhZ/N5bAwNHYmEYT
         +I1LlFPbwNQRQeEhb6nSJqEuYIbhj+PEngyu/GNb1CPeXYPTcigkROiuHO5l1wdVrhH5
         RREW63rFceRJA5NvOVM3HRVP2NuL2f4yxhWrb2wIeNaduJl0llbSpnBxw06gxR4lLPc9
         yL9bI8DEWV6oKFTmtQeiPpnmG13ZhD62Fm22SoRSeBTo+T41nQvmD1D3fAnTk6c1QRj1
         JkXg==
X-Gm-Message-State: AOJu0Yw2SL4XAij5j1EqAx4pvl9Zg9s2MhjtvuGRHyYam1rQCWU/zCZ6
        SuKu+zUPCs8UFEGKA+EKpFZDipuYJk4=
X-Google-Smtp-Source: AGHT+IF8sEXakLG1Yc8xpCvA0ZI2StCmnPPaa0d4wXFMXAAo9DHrNczicfwS81JFM8/vCSoY3isvcQ==
X-Received: by 2002:a2e:965a:0:b0:2bc:fe17:693c with SMTP id z26-20020a2e965a000000b002bcfe17693cmr8406328ljh.30.1693896538583;
        Mon, 04 Sep 2023 23:48:58 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id r12-20020adfce8c000000b00317afc7949csm16373092wrn.50.2023.09.04.23.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 23:48:57 -0700 (PDT)
Date:   Tue, 5 Sep 2023 07:48:56 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: Re: [PATCH v6 6/7] selftests: mm: Add a test for remapping within a
 range
Message-ID: <2bc8a939-5d98-4129-9cc7-ff6c8aa8493e@lucifer.local>
References: <20230903151328.2981432-1-joel@joelfernandes.org>
 <20230903151328.2981432-7-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903151328.2981432-7-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Sep 03, 2023 at 03:13:27PM +0000, Joel Fernandes (Google) wrote:
> Move a block of memory within a memory range. Any alignment optimization
> on the source address may cause corruption. Verify using kselftest that
> it works. I have also verified with tracing that such optimization does
> not happen due to this check in can_align_down():
>
> if (!for_stack && vma->vm_start != addr_to_align)
> 	return false;
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/testing/selftests/mm/mremap_test.c | 79 +++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
> index d7366074e2a8..12a095457f4c 100644
> --- a/tools/testing/selftests/mm/mremap_test.c
> +++ b/tools/testing/selftests/mm/mremap_test.c
> @@ -23,6 +23,7 @@
>  #define VALIDATION_NO_THRESHOLD 0	/* Verify the entire region */
>
>  #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
> +#define SIZE_MB(m) ((size_t)m * (1024 * 1024))
>
>  struct config {
>  	unsigned long long src_alignment;
> @@ -226,6 +227,79 @@ static void mremap_expand_merge_offset(FILE *maps_fp, unsigned long page_size)
>  		ksft_test_result_fail("%s\n", test_name);
>  }
>
> +/*
> + * Verify that an mremap within a range does not cause corruption
> + * of unrelated part of range.
> + *
> + * Consider the following range which is 2MB aligned and is
> + * a part of a larger 20MB range which is not shown. Each
> + * character is 256KB below making the source and destination
> + * 2MB each. The lower case letters are moved (s to d) and the
> + * upper case letters are not moved. The below test verifies
> + * that the upper case S letters are not corrupted by the
> + * adjacent mremap.
> + *
> + * |DDDDddddSSSSssss|
> + */
> +static void mremap_move_within_range(char pattern_seed)
> +{
> +	char *test_name = "mremap mremap move within range";
> +	void *src, *dest;
> +	int i, success = 1;
> +
> +	size_t size = SIZE_MB(20);
> +	void *ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
> +			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (ptr == MAP_FAILED) {
> +		perror("mmap");
> +		success = 0;
> +		goto out;
> +	}
> +	memset(ptr, 0, size);
> +
> +	src = ptr + SIZE_MB(6);
> +	src = (void *)((unsigned long)src & ~(SIZE_MB(2) - 1));
> +
> +	/* Set byte pattern for source block. */
> +	srand(pattern_seed);
> +	for (i = 0; i < SIZE_MB(2); i++) {
> +		((char *)src)[i] = (char) rand();
> +	}
> +
> +	dest = src - SIZE_MB(2);
> +
> +	void *new_ptr = mremap(src + SIZE_MB(1), SIZE_MB(1), SIZE_MB(1),
> +						   MREMAP_MAYMOVE | MREMAP_FIXED, dest + SIZE_MB(1));
> +	if (new_ptr == MAP_FAILED) {
> +		perror("mremap");
> +		success = 0;
> +		goto out;
> +	}
> +
> +	/* Verify byte pattern after remapping */
> +	srand(pattern_seed);
> +	for (i = 0; i < SIZE_MB(1); i++) {
> +		char c = (char) rand();
> +
> +		if (((char *)src)[i] != c) {
> +			ksft_print_msg("Data at src at %d got corrupted due to unrelated mremap\n",
> +				       i);
> +			ksft_print_msg("Expected: %#x\t Got: %#x\n", c & 0xff,
> +					((char *) src)[i] & 0xff);
> +			success = 0;
> +		}
> +	}
> +
> +out:
> +	if (munmap(ptr, size) == -1)
> +		perror("munmap");
> +
> +	if (success)
> +		ksft_test_result_pass("%s\n", test_name);
> +	else
> +		ksft_test_result_fail("%s\n", test_name);
> +}
> +
>  /*
>   * Returns the start address of the mapping on success, else returns
>   * NULL on failure.
> @@ -491,6 +565,7 @@ int main(int argc, char **argv)
>  	unsigned int threshold_mb = VALIDATION_DEFAULT_THRESHOLD;
>  	unsigned int pattern_seed;
>  	int num_expand_tests = 2;
> +	int num_misc_tests = 1;
>  	struct test test_cases[MAX_TEST] = {};
>  	struct test perf_test_cases[MAX_PERF_TEST];
>  	int page_size;
> @@ -572,7 +647,7 @@ int main(int argc, char **argv)
>  				(threshold_mb * _1MB >= _1GB);
>
>  	ksft_set_plan(ARRAY_SIZE(test_cases) + (run_perf_tests ?
> -		      ARRAY_SIZE(perf_test_cases) : 0) + num_expand_tests);
> +		      ARRAY_SIZE(perf_test_cases) : 0) + num_expand_tests + num_misc_tests);
>
>  	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
>  		run_mremap_test_case(test_cases[i], &failures, threshold_mb,
> @@ -590,6 +665,8 @@ int main(int argc, char **argv)
>
>  	fclose(maps_fp);
>
> +	mremap_move_within_range(pattern_seed);
> +
>  	if (run_perf_tests) {
>  		ksft_print_msg("\n%s\n",
>  		 "mremap HAVE_MOVE_PMD/PUD optimization time comparison for 1GB region:");
> --
> 2.42.0.283.g2d96d420d3-goog
>

Looks good to me, nice series in general!

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
