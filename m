Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E21D6E25BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 16:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDNOaW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 10:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjDNOaV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 10:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40074CC0C
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681482487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3+7E0N5YimEKCEkRUQMjEBrkYWjsqKlWAyhl1179nqM=;
        b=Yhli3Qz22ujTYFsFuwZ4N83w4Jr7ubu3hS5ptFisdpUp9t6cYRhLj1npP2C2NKXEFVusTT
        secttSpGvlFUTT20B7Mptg1Y/dis04kEQSxOi5EvZGFhOlAYu1W4tBUekgz/ociXZX3Wzd
        zlqpJgeW8Z0S8CKhRdNQPHq129DnPgQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-Fk4naKwVOL2_PLprqzCaVw-1; Fri, 14 Apr 2023 10:28:04 -0400
X-MC-Unique: Fk4naKwVOL2_PLprqzCaVw-1
Received: by mail-wm1-f71.google.com with SMTP id ay4-20020a05600c1e0400b003f0ad935168so2265017wmb.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 07:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482483; x=1684074483;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+7E0N5YimEKCEkRUQMjEBrkYWjsqKlWAyhl1179nqM=;
        b=kAr4Wm6CU9zRkL0gB9kea5LrMFFyXvLI96+sbQfbwNywnUFWyVqE/Kz4hMs/RSTKNx
         /YOAqefDfiRpQxzMWbxqv/3SjeyCQCtmeUejFn2adEXhu6HTIRBSAzBf1aWSQ0o97M3T
         d205eZ3t8gR84IUwTy/2an+GEEx3fqBp9cH3XgbkuWd2N2wKZOYFTSKl9yy6AivEFp1w
         8XBIqYFT03aYI2ynlX+AGTP0osMWOSVfa+SYHLNG4oWmngmrSQoJ3tyPwm/QgrMPeDhL
         mEnoWyu1nSqPMB16kY478/Ka5yMciH7JNw6PExHMFgYeOhZO3QK9bfo2/OnLjXTXfWok
         sVww==
X-Gm-Message-State: AAQBX9eNS5t7dMpCRAVR0G03uxxQmMyMqtwKL2VneQixqHD3JMewM89X
        +ewFDilmErMVy04WuuGMGWoloWWnh0ci+wciiOdFfzqS2OCyJ7Q7/KpUbYIzWfgOLJ6NN2t3W/2
        aLokgEWdxF10LEsD9HBek/kqHnwof
X-Received: by 2002:a7b:cb85:0:b0:3f0:9fef:1028 with SMTP id m5-20020a7bcb85000000b003f09fef1028mr4298084wmi.17.1681482483648;
        Fri, 14 Apr 2023 07:28:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350bXdpprtWQPV5vLzlkhmiMtNbIMroahWYPyjUn400ftnGsQ6ha2RCpyFzKpq1NLfQNPIfHK1g==
X-Received: by 2002:a7b:cb85:0:b0:3f0:9fef:1028 with SMTP id m5-20020a7bcb85000000b003f09fef1028mr4298069wmi.17.1681482483270;
        Fri, 14 Apr 2023 07:28:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5700:cb5b:f73a:c650:1d9? (p200300cbc7025700cb5bf73ac65001d9.dip0.t-ipconnect.de. [2003:cb:c702:5700:cb5b:f73a:c650:1d9])
        by smtp.gmail.com with ESMTPSA id y24-20020a7bcd98000000b003ee44b2effasm4412739wmj.12.2023.04.14.07.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 07:28:02 -0700 (PDT)
Message-ID: <da0ded70-bb4d-2dab-233f-326ae7bfa626@redhat.com>
Date:   Fri, 14 Apr 2023 16:28:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230413233115.1878303-1-shr@devkernel.io>
 <20230413233115.1878303-4-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 3/3] selftests/mm: add new selftests for KSM
In-Reply-To: <20230413233115.1878303-4-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks for moving the functional tests. Some more feedback forksm_functional_tests change. Writing tests in the
ksft testing framework can be a bit "special".


I'm seeing some weird test failures due to

prctl(PR_GET_MEMORY_MERGE, 0)

Apparently, these go away when using

prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0)

to explicitly force the other values to 0. Most probably, we should do that
for PR_SET_MEMORY_MERGE as well (especially if we check for the arguments as
well).

[...]

> @@ -15,8 +15,10 @@
>   #include <errno.h>
>   #include <fcntl.h>
>   #include <sys/mman.h>
> +#include <sys/prctl.h>
>   #include <sys/syscall.h>
>   #include <sys/ioctl.h>
> +#include <sys/wait.h>
>   #include <linux/userfaultfd.h>
>   
>   #include "../kselftest.h"
> @@ -326,9 +328,80 @@ static void test_unmerge_uffd_wp(void)
>   }
>   #endif
>   
> +/* Verify that KSM can be enabled / queried with prctl. */
> +static void test_ksm_prctl(void)

Maybe call this "test_prctl", because after all, these are all KSM tests.

> +{
> +	bool ret = false;
> +	int is_on;
> +	int is_off;
> +
> +	ksft_print_msg("[RUN] %s\n", __func__);
> +
> +	if (prctl(PR_SET_MEMORY_MERGE, 1)) {
> +		perror("prctl set");
> +		goto out;
> +	}
> +
> +	is_on = prctl(PR_GET_MEMORY_MERGE, 0);
> +	if (prctl(PR_SET_MEMORY_MERGE, 0)) {
> +		perror("prctl set");
> +		goto out;
> +	}
> +
> +	is_off = prctl(PR_GET_MEMORY_MERGE, 0);
> +	if (is_on && is_off)
> +		ret = true;
> +
> +out:
> +	ksft_test_result(ret, "prctl get / set\n");

The test fails if the kernel does not support PR_SET_MEMORY_MERGE.


I'd modify this test to:

(1) skip if the first PR_SET_MEMORY_MERGE=1 failed with EINVAL.
(2) distinguish for PR_GET_MEMORY_MERGE whether it returned an error or
     whether it returned a wrong value. Feel free to keep that as is, whatever
     you prefer.
(3) exit early for all failures, you get exactly one expected skip/pass/fail for the
     test and use specific test failure messages.
(4) Pass "0" for all other arguments of prctl.


Something like:

static void test_prctl(void)
{
	int ret;

	ksft_print_msg("[RUN] %s\n", __func__);

	ret = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
	if (ret < 0 && errno == EINVAL){
		ksft_test_result_skip("PR_SET_MEMORY_MERGE not supported\n");
		return;
	} else if (ret) {
		ksft_test_result_fail("PR_SET_MEMORY_MERGE=1 failed\n");
		return;
	}

	ret = prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0);
	if (ret < 0) {
		ksft_test_result_fail("PR_GET_MEMORY_MERGE failed\n");
		return;
	} else if (ret != 1) {
		ksft_test_result_fail("PR_SET_MEMORY_MERGE=1 not effective\n");
		return;
	}

	ret = prctl(PR_SET_MEMORY_MERGE, 0, 0, 0, 0);
	if (ret){
		ksft_test_result_fail("PR_SET_MEMORY_MERGE=0 failed\n");
		return;
	}

	ret = prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0);
	if (ret < 0) {
		ksft_test_result_fail("PR_GET_MEMORY_MERGE failed\n");
		return;
	} else if (ret != 0) {
		ksft_test_result_fail("PR_SET_MEMORY_MERGE=0 not effective\n");
		return;
	}

	ksft_test_result_pass("Setting/clearing PR_SET_MEMORY_MERGE works\n");
}


> +}
> +
> +/* Verify that prctl ksm flag is inherited. */
> +static void test_ksm_fork(void)

Maybe call it "test_prctl_fork"

> +{
> +	int status;
> +	bool ret = false;
> +	pid_t child_pid;
> +
> +	ksft_print_msg("[RUN] %s\n", __func__);
> +
> +	if (prctl(PR_SET_MEMORY_MERGE, 1)) {
> +		ksft_test_result_fail("prctl failed\n");
> +		goto out;
> +	}
> +
> +	child_pid = fork();
> +	if (child_pid == 0) {
> +		int is_on = 
> +
> +		if (!is_on)
> +			exit(-1);
> +
> +		exit(0);
> +	}
> +
> +	if (child_pid < 0) {
> +		ksft_test_result_fail("child pid < 0\n");
> +		goto out;> +
> +	if (waitpid(child_pid, &status, 0) < 0 || WEXITSTATUS(status) != 0) {
> +		ksft_test_result_fail("wait pid < 0\n");
> +		goto out;
> +	}
> +
> +	if (prctl(PR_SET_MEMORY_MERGE, 0))
> +		ksft_test_result_fail("prctl 2 failed\n");
> +	else
> +		ret = true;
> +
> +out:
> +	ksft_test_result(ret, "ksm_flag is inherited\n");
> +}

Again, test fails if kernel support is not around.

I'd modify this test to:

(1) skip if the first PR_SET_MEMORY_MERGE=1 failed with EINVAL just as in the other test.
(2) Use a simple exit(prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0)); in the child.
(3) exit early for all failures, you get exactly one expected skip/pass/fail for the
     test and use specific test failure messages.
(4) Split up the waitpid() check to test what failed.
(5) Pass "0" for all other arguments of prctl.


Something like:

static void test_prctl_fork(void)
{
	int ret, status;
	pid_t child_pid;

	ksft_print_msg("[RUN] %s\n", __func__);

	ret = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
	if (ret < 0 && errno == EINVAL){
		ksft_test_result_skip("PR_SET_MEMORY_MERGE not supported\n");
		return;
	} else if (ret) {
		ksft_test_result_fail("PR_SET_MEMORY_MERGE=1 failed\n");
		return;
	}

	child_pid = fork();
	if (!child_pid) {
		exit(prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0));
	} else if (child_pid < 0) {
		ksft_test_result_fail("fork() failed\n");
		return;
	}

	if (waitpid(child_pid, &status, 0) < 0) {
		ksft_test_result_fail("waitpid() failed\n");
		return;
	} else if (WEXITSTATUS(status) != 1) {
		ksft_test_result_fail("unexpected PR_GET_MEMORY_MERGE result in child\n");
		return;
	}

	if (prctl(PR_SET_MEMORY_MERGE, 0, 0, 0, 0)) {
		ksft_test_result_fail("PR_SET_MEMORY_MERGE=0 failed\n");
		return;
	}

	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");
}



> +
>   int main(int argc, char **argv)
>   {
> -	unsigned int tests = 2;
> +	unsigned int tests = 6;

Assuming you execute exactly one ksft_test_result_skip/fail/pass on every path of your two
test, this would become "4".

>   	int err;
>   
>   #ifdef __NR_userfaultfd
> @@ -358,6 +431,8 @@ int main(int argc, char **argv)
>   #ifdef __NR_userfaultfd
>   	test_unmerge_uffd_wp();
>   #endif
> +	test_ksm_prctl();
> +	test_ksm_fork();
>   


With above outlined changes (feel free to integrate what you consider valuable),
on an older kernel I get:

$ sudo ./ksm_functional_tests
TAP version 13
1..5
# [RUN] test_unmerge
ok 1 Pages were unmerged
# [RUN] test_unmerge_discarded
ok 2 Pages were unmerged
# [RUN] test_unmerge_uffd_wp
ok 3 Pages were unmerged
# [RUN] test_prctl
ok 4 # SKIP PR_SET_MEMORY_MERGE not supported
# [RUN] test_prctl_fork
ok 5 # SKIP PR_SET_MEMORY_MERGE not supported
# Totals: pass:3 fail:0 xfail:0 xpass:0 skip:2 error:0


On a kernel with your patch #1:

# ./ksm_functional_tests
TAP version 13
1..5
# [RUN] test_unmerge
ok 1 Pages were unmerged
# [RUN] test_unmerge_discarded
ok 2 Pages were unmerged
# [RUN] test_unmerge_uffd_wp
ok 3 Pages were unmerged
# [RUN] test_prctl
ok 4 Setting/clearing PR_SET_MEMORY_MERGE works
# [RUN] test_prctl_fork
ok 5 PR_SET_MEMORY_MERGE value is inherited
# Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0




>   	err = ksft_get_fail_cnt();
>   	if (err)
> diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
> index f9eb4d67e0dd..35b3828d44b4 100644
> --- a/tools/testing/selftests/mm/ksm_tests.c
> +++ b/tools/testing/selftests/mm/ksm_tests.c
> @@ -1,6 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0

[...]


Changes to ksm_tests mostly look good. Two comments:


> -	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeout))
> +	if (ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_time, timeout))
>   		goto err_out;
>   
>   	/* verify that the right number of pages are merged */
>   	if (assert_ksm_pages_count(page_count)) {
>   		printf("OK\n");
> -		munmap(map_ptr, page_size * page_count);
> +		if (merge_type == KSM_MERGE_MADVISE)
> +			munmap(map_ptr, page_size * page_count);
> +		else if (merge_type == KSM_MERGE_PRCTL)
> +			prctl(PR_SET_MEMORY_MERGE, 0);

Are you sure that we don't want to unmap here? I'd assume we want to unmap in either way.

[...]

> +		case 'd':
> +			debug = 1;
> +			break;
>   		case 's':
>   			size_MB = atoi(optarg);
>   			if (size_MB <= 0) {
>   				printf("Size must be greater than 0\n");
>   				return KSFT_FAIL;
>   			}
> +		case 't':
> +			{
> +				int tmp = atoi(optarg);
> +
> +				if (tmp < 0 || tmp > KSM_MERGE_LAST) {
> +					printf("Invalid merge type\n");
> +					return KSFT_FAIL;
> +				}
> +				merge_type = atoi(optarg);

You can simply reuse tmp

merge_type = tmp;




-- 
Thanks,

David / dhildenb

