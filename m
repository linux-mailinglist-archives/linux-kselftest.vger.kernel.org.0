Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B877789CD7
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 11:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjH0J6M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 05:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjH0J6F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 05:58:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B1ABF;
        Sun, 27 Aug 2023 02:58:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31aeef88a55so1829320f8f.2;
        Sun, 27 Aug 2023 02:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693130281; x=1693735081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6iUeeYfhNc0jytc1glHXmb17kdu3jEyQYgoQSwf9xI=;
        b=AwDPUyiGFaJrcFCvk08U8sZnL8sr8JWcR3gErURPOXI6NMwb5IbDSf/qY8lLdASnCk
         4JkCv++CuzCSq7iyyYUkoosMcg4SbN9foXu9kOcMfNZZrgP1owfIwAEbbobohJWg5afs
         XbcWS/Yg0XacKnig9xX/+lo771O/2RHZ0Cm/6zgEG/A8jfSybWThzUsJUtP/pVONICF2
         aqItufq8wWVbAgm2i+gMVpZjSgHT6qW82es2ioFJjYs4/8kYunkKNTeUrBNr+WcraXWX
         z6TZ2I/c5WGc+EyAapTbImVj+xxfh6d7C5YT+Ql0ooF2aKNjuWYW1srU3BYicNXLT/Se
         ITtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693130281; x=1693735081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6iUeeYfhNc0jytc1glHXmb17kdu3jEyQYgoQSwf9xI=;
        b=beTK3FgBzG139HQq9bUyYJpgnyriVkzTnyyqOSXUwu6pkm6LUnicRN0ask7Uu/orqA
         w1suPpeDL9vTXukuvOV689efobG61dlcIz6DOq6COOLpwAVpux6e85Lo5UR5O2ldEonh
         OKnaLFWYEUIfyrWc/m/xsJ+/fpVay8zgIXPzNJMvHmkkyD7wA11ajA0dQzgsOgpExDnj
         OOGDlZo+u4r432rdNvl8zEXArOmsqO+ezENqvOfihPEJ2G8sNhOvJHqjAXBI7W7dMgKb
         3WglX8fnSdjhFjca0Db3bBkogVuyDV9VB8b9xtv3uSMBBU53GAQRQyO0xAO6WznmSyXP
         ni9A==
X-Gm-Message-State: AOJu0YzILDsgyipHj8n+FZwhypjQDm2o/excaZNF1G8gdOQVYnM3lNAg
        1mK/sUDK9obTxA9Kv9hvGD0=
X-Google-Smtp-Source: AGHT+IFfR0fmVFVB8vfVRxtlmjFKkb8JcdKMDM6TRXoZ1j9cpBuYRpeYwgBifR07kg+pf+CndaaJiw==
X-Received: by 2002:a5d:4d85:0:b0:31a:d6cb:7f9d with SMTP id b5-20020a5d4d85000000b0031ad6cb7f9dmr16459293wru.24.1693130280835;
        Sun, 27 Aug 2023 02:58:00 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d540a000000b00317e6f06e22sm7136717wrv.77.2023.08.27.02.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 02:57:59 -0700 (PDT)
Date:   Sun, 27 Aug 2023 10:57:59 +0100
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
Subject: Re: [PATCH v5 6/7] selftests: mm: Add a test for remapping within a
 range
Message-ID: <08ce8c61-e7a2-417a-a3cc-d20861753ae8@lucifer.local>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-7-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822015501.791637-7-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 22, 2023 at 01:54:59AM +0000, Joel Fernandes (Google) wrote:
> Move a block of memory within a memory range. Any alignment optimization
> on the source address may cause corruption. Verify using kselftest that
> it works. I have also verified with tracing that such optimization does
> not happen due to this check in can_align_down():
>
> if (!for_stack && vma->vm_start <= addr_masked)
> 	return false;
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/testing/selftests/mm/mremap_test.c | 79 +++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
> index d7366074e2a8..f45d1abedc9c 100644
> --- a/tools/testing/selftests/mm/mremap_test.c
> +++ b/tools/testing/selftests/mm/mremap_test.c
> @@ -23,6 +23,7 @@
>  #define VALIDATION_NO_THRESHOLD 0	/* Verify the entire region */
>
>  #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
> +#define SIZE_MB(m) ((size_t)m * (1024 * 1024))

Nit in this instance since you always just use an integer, but generally
for good practice's sake - shouldn't we place m in parens e.g. (size_t)(m)
to avoid broken macro expansion?

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
> + * a part of a larger 10MB range which is not shown. Each
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

It's nitty I know for a test (sorry!) but it'd be nice to place a bitwise
alignment trick like this into a helper function or macro if it isn't
otherwise avialable.

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
> 2.42.0.rc1.204.g551eb34607-goog
>

I drew a little diagram for myself and was thereby convinced this was a good test, therefore,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
