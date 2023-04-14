Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD646E2B59
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 22:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDNU50 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 16:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDNU50 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 16:57:26 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE5544AE;
        Fri, 14 Apr 2023 13:57:24 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 226AF32009CF;
        Fri, 14 Apr 2023 16:57:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 14 Apr 2023 16:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1681505842; x=1681592242; bh=/n
        96KwSr3t1imDzL+p/xaVA+BzYTEsyybUrKRZIeP0s=; b=Af5lsC/X4Ij1xaKjjb
        KR/S4PvgGWXlRMkotghfAo7JSUWOatMJv1y2PzrAMxhdTDGrvTEaFOc5mbHW/84T
        x5N83WcNvhs0iVy0lJ5NzI7f1wzIPfuDuBsiE2E5UVG9RCu1HZ7769vxnrI66V8i
        500KaneQWo4qmPzHrB8RI2osLg8YGSHwwpLSloBBaqH3krjtdAjkTpYhKBlDG/h5
        Y8rd4MC69zHkSpsro9yMkAlssatpWkn/1TpBhkl36QuBJCc5SeROpsI82AHwRK7O
        t+nC0wXxVblc0mOCAygpwez1LTMtkr84CSmxhrS6A8qp6d0FxkcCQNSz0RoH16BN
        7EPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681505842; x=1681592242; bh=/n96KwSr3t1im
        DzL+p/xaVA+BzYTEsyybUrKRZIeP0s=; b=gX3rnCaXueqt79lX2NPSSrBneMCi3
        BW+9NnM9sy7ttvpoFHtDpLC1Yjg8eI7aNY2Rsav9LxsCOdHsHAk4foQd3olUf6wH
        r9mmatQWsmwjh+1ZaDl+1JF1ZBwSYnCmgk8/ujr+9KiDDo5r1YWT7In+X8E4km70
        YPx4sJkLGlxsLLEKkaJC0Fwt5+AL4Nem8n8E91NCxgklTSlrZ6Y/TFF+YQoa3AwA
        UkNjWYQeuLJxh9zIIH2G4flAqc1bYvRMSszg+VdiYUfKwYhUAJEHjPThRXhQ6zZz
        Hs1s16WNlevnRf1VKPFpZsVbAnY0tNYjqmmBwKi3hEADCf0LkfE7dBF1A==
X-ME-Sender: <xms:Mr45ZFqHgEQbK5Am_4qWoXvQFKj-Oo8ZQxo0vYi56vT8qEom4GdllA>
    <xme:Mr45ZHqZQr_RmRNRPwuQ8_mxYK22iQBS-dbF1wA5aoBM5owkUazHa01KF0KeWypT3
    CBGz975BEuHECBfZeE>
X-ME-Received: <xmr:Mr45ZCNNF4VOSome18Fc9NYv3ZlCftkyVFzn5gQv0VbZKe1nEddo2eBU139OyEKQE3zdL7JXHLrAhbnlNoF0dYpkoY57jStoytCCibtC1Dam>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltddgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:Mr45ZA62YFXA_0BGVjwN_c3Wlggrpd6qEjLqailHuQFhtUHZQELxAQ>
    <xmx:Mr45ZE7c6XIQrk66oUCQnzw7ynUuRnHTCnUpB7k1fhocXqA2L8q4GA>
    <xmx:Mr45ZIh9T0ZMdYLuticFRx6_dqc571w5CC5N5-ARfV198a23WVCnhQ>
    <xmx:Mr45ZFF2Z0qVdqY7X_3qk6SqNaacO5V1VfD6j7wxIip7aexuddGY_Q>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 16:57:21 -0400 (EDT)
References: <20230413233115.1878303-1-shr@devkernel.io>
 <20230413233115.1878303-4-shr@devkernel.io>
 <da0ded70-bb4d-2dab-233f-326ae7bfa626@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v7 3/3] selftests/mm: add new selftests for KSM
Date:   Fri, 14 Apr 2023 13:54:47 -0700
In-reply-to: <da0ded70-bb4d-2dab-233f-326ae7bfa626@redhat.com>
Message-ID: <qvqw8reugp1s.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> Thanks for moving the functional tests. Some more feedback forksm_functional_tests change. Writing tests in the
> ksft testing framework can be a bit "special".
>
>
> I'm seeing some weird test failures due to
>
> prctl(PR_GET_MEMORY_MERGE, 0)
>
> Apparently, these go away when using
>
> prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0)
>

I changed the test programs to always specify all the 5 parameters.

> to explicitly force the other values to 0. Most probably, we should do that
> for PR_SET_MEMORY_MERGE as well (especially if we check for the arguments as
> well).
>
> [...]
>
>> @@ -15,8 +15,10 @@
>>   #include <errno.h>
>>   #include <fcntl.h>
>>   #include <sys/mman.h>
>> +#include <sys/prctl.h>
>>   #include <sys/syscall.h>
>>   #include <sys/ioctl.h>
>> +#include <sys/wait.h>
>>   #include <linux/userfaultfd.h>
>>     #include "../kselftest.h"
>> @@ -326,9 +328,80 @@ static void test_unmerge_uffd_wp(void)
>>   }
>>   #endif
>>   +/* Verify that KSM can be enabled / queried with prctl. */
>> +static void test_ksm_prctl(void)
>
> Maybe call this "test_prctl", because after all, these are all KSM tests.
>

I renamed it to test_prctl in the next version.

>> +{
>> +	bool ret = false;
>> +	int is_on;
>> +	int is_off;
>> +
>> +	ksft_print_msg("[RUN] %s\n", __func__);
>> +
>> +	if (prctl(PR_SET_MEMORY_MERGE, 1)) {
>> +		perror("prctl set");
>> +		goto out;
>> +	}
>> +
>> +	is_on = prctl(PR_GET_MEMORY_MERGE, 0);
>> +	if (prctl(PR_SET_MEMORY_MERGE, 0)) {
>> +		perror("prctl set");
>> +		goto out;
>> +	}
>> +
>> +	is_off = prctl(PR_GET_MEMORY_MERGE, 0);
>> +	if (is_on && is_off)
>> +		ret = true;
>> +
>> +out:
>> +	ksft_test_result(ret, "prctl get / set\n");
>
> The test fails if the kernel does not support PR_SET_MEMORY_MERGE.
>
>
> I'd modify this test to:
>
> (1) skip if the first PR_SET_MEMORY_MERGE=1 failed with EINVAL.
> (2) distinguish for PR_GET_MEMORY_MERGE whether it returned an error or
>     whether it returned a wrong value. Feel free to keep that as is, whatever
>     you prefer.
> (3) exit early for all failures, you get exactly one expected skip/pass/fail for the
>     test and use specific test failure messages.
> (4) Pass "0" for all other arguments of prctl.
>
>
> Something like:
>
> static void test_prctl(void)
> {
> 	int ret;
>
> 	ksft_print_msg("[RUN] %s\n", __func__);
>
> 	ret = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
> 	if (ret < 0 && errno == EINVAL){
> 		ksft_test_result_skip("PR_SET_MEMORY_MERGE not supported\n");
> 		return;
> 	} else if (ret) {
> 		ksft_test_result_fail("PR_SET_MEMORY_MERGE=1 failed\n");
> 		return;
> 	}
>
> 	ret = prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0);
> 	if (ret < 0) {
> 		ksft_test_result_fail("PR_GET_MEMORY_MERGE failed\n");
> 		return;
> 	} else if (ret != 1) {
> 		ksft_test_result_fail("PR_SET_MEMORY_MERGE=1 not effective\n");
> 		return;
> 	}
>
> 	ret = prctl(PR_SET_MEMORY_MERGE, 0, 0, 0, 0);
> 	if (ret){
> 		ksft_test_result_fail("PR_SET_MEMORY_MERGE=0 failed\n");
> 		return;
> 	}
>
> 	ret = prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0);
> 	if (ret < 0) {
> 		ksft_test_result_fail("PR_GET_MEMORY_MERGE failed\n");
> 		return;
> 	} else if (ret != 0) {
> 		ksft_test_result_fail("PR_SET_MEMORY_MERGE=0 not effective\n");
> 		return;
> 	}
>
> 	ksft_test_result_pass("Setting/clearing PR_SET_MEMORY_MERGE works\n");
> }
>
>

I made changes to the test program according to the code above.
>> +}
>> +
>> +/* Verify that prctl ksm flag is inherited. */
>> +static void test_ksm_fork(void)
>
> Maybe call it "test_prctl_fork"
>
I changed it to test_prctl_fork.

>> +{
>> +	int status;
>> +	bool ret = false;
>> +	pid_t child_pid;
>> +
>> +	ksft_print_msg("[RUN] %s\n", __func__);
>> +
>> +	if (prctl(PR_SET_MEMORY_MERGE, 1)) {
>> +		ksft_test_result_fail("prctl failed\n");
>> +		goto out;
>> +	}
>> +
>> +	child_pid = fork();
>> +	if (child_pid == 0) {
>> +		int is_on = +
>> +		if (!is_on)
>> +			exit(-1);
>> +
>> +		exit(0);
>> +	}
>> +
>> +	if (child_pid < 0) {
>> +		ksft_test_result_fail("child pid < 0\n");
>> +		goto out;> +
>> +	if (waitpid(child_pid, &status, 0) < 0 || WEXITSTATUS(status) != 0) {
>> +		ksft_test_result_fail("wait pid < 0\n");
>> +		goto out;
>> +	}
>> +
>> +	if (prctl(PR_SET_MEMORY_MERGE, 0))
>> +		ksft_test_result_fail("prctl 2 failed\n");
>> +	else
>> +		ret = true;
>> +
>> +out:
>> +	ksft_test_result(ret, "ksm_flag is inherited\n");
>> +}
>
> Again, test fails if kernel support is not around.
>
> I'd modify this test to:
>
> (1) skip if the first PR_SET_MEMORY_MERGE=1 failed with EINVAL just as in the other test.
> (2) Use a simple exit(prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0)); in the child.
> (3) exit early for all failures, you get exactly one expected skip/pass/fail for the
>     test and use specific test failure messages.
> (4) Split up the waitpid() check to test what failed.
> (5) Pass "0" for all other arguments of prctl.
>
>
> Something like:
>
> static void test_prctl_fork(void)
> {
> 	int ret, status;
> 	pid_t child_pid;
>
> 	ksft_print_msg("[RUN] %s\n", __func__);
>
> 	ret = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
> 	if (ret < 0 && errno == EINVAL){
> 		ksft_test_result_skip("PR_SET_MEMORY_MERGE not supported\n");
> 		return;
> 	} else if (ret) {
> 		ksft_test_result_fail("PR_SET_MEMORY_MERGE=1 failed\n");
> 		return;
> 	}
>
> 	child_pid = fork();
> 	if (!child_pid) {
> 		exit(prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0));
> 	} else if (child_pid < 0) {
> 		ksft_test_result_fail("fork() failed\n");
> 		return;
> 	}
>
> 	if (waitpid(child_pid, &status, 0) < 0) {
> 		ksft_test_result_fail("waitpid() failed\n");
> 		return;
> 	} else if (WEXITSTATUS(status) != 1) {
> 		ksft_test_result_fail("unexpected PR_GET_MEMORY_MERGE result in child\n");
> 		return;
> 	}
>
> 	if (prctl(PR_SET_MEMORY_MERGE, 0, 0, 0, 0)) {
> 		ksft_test_result_fail("PR_SET_MEMORY_MERGE=0 failed\n");
> 		return;
> 	}
>
> 	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");
> }
>
>
>

I made changes to the test program according to the code above.
>> +
>>   int main(int argc, char **argv)
>>   {
>> -	unsigned int tests = 2;
>> +	unsigned int tests = 6;
>
> Assuming you execute exactly one ksft_test_result_skip/fail/pass on every path of your two
> test, this would become "4".
>
Changed it to 4.
>>   	int err;
>>     #ifdef __NR_userfaultfd
>> @@ -358,6 +431,8 @@ int main(int argc, char **argv)
>>   #ifdef __NR_userfaultfd
>>   	test_unmerge_uffd_wp();
>>   #endif
>> +	test_ksm_prctl();
>> +	test_ksm_fork();
>>
>
>
> With above outlined changes (feel free to integrate what you consider valuable),
> on an older kernel I get:
>
> $ sudo ./ksm_functional_tests
> TAP version 13
> 1..5
> # [RUN] test_unmerge
> ok 1 Pages were unmerged
> # [RUN] test_unmerge_discarded
> ok 2 Pages were unmerged
> # [RUN] test_unmerge_uffd_wp
> ok 3 Pages were unmerged
> # [RUN] test_prctl
> ok 4 # SKIP PR_SET_MEMORY_MERGE not supported
> # [RUN] test_prctl_fork
> ok 5 # SKIP PR_SET_MEMORY_MERGE not supported
> # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:2 error:0
>
>
> On a kernel with your patch #1:
>
> # ./ksm_functional_tests
> TAP version 13
> 1..5
> # [RUN] test_unmerge
> ok 1 Pages were unmerged
> # [RUN] test_unmerge_discarded
> ok 2 Pages were unmerged
> # [RUN] test_unmerge_uffd_wp
> ok 3 Pages were unmerged
> # [RUN] test_prctl
> ok 4 Setting/clearing PR_SET_MEMORY_MERGE works
> # [RUN] test_prctl_fork
> ok 5 PR_SET_MEMORY_MERGE value is inherited
> # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
>
>
>
>
>>   	err = ksft_get_fail_cnt();
>>   	if (err)
>> diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
>> index f9eb4d67e0dd..35b3828d44b4 100644
>> --- a/tools/testing/selftests/mm/ksm_tests.c
>> +++ b/tools/testing/selftests/mm/ksm_tests.c
>> @@ -1,6 +1,8 @@
>>   // SPDX-License-Identifier: GPL-2.0
>
> [...]
>
>
> Changes to ksm_tests mostly look good. Two comments:
>
>
>> -	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeout))
>> +	if (ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_time, timeout))
>>   		goto err_out;
>>     	/* verify that the right number of pages are merged */
>>   	if (assert_ksm_pages_count(page_count)) {
>>   		printf("OK\n");
>> -		munmap(map_ptr, page_size * page_count);
>> +		if (merge_type == KSM_MERGE_MADVISE)
>> +			munmap(map_ptr, page_size * page_count);
>> +		else if (merge_type == KSM_MERGE_PRCTL)
>> +			prctl(PR_SET_MEMORY_MERGE, 0);
>
> Are you sure that we don't want to unmap here? I'd assume we want to unmap in either way.
>
> [...]
>
I changed it to always unmap.

>> +		case 'd':
>> +			debug = 1;
>> +			break;
>>   		case 's':
>>   			size_MB = atoi(optarg);
>>   			if (size_MB <= 0) {
>>   				printf("Size must be greater than 0\n");
>>   				return KSFT_FAIL;
>>   			}
>> +		case 't':
>> +			{
>> +				int tmp = atoi(optarg);
>> +
>> +				if (tmp < 0 || tmp > KSM_MERGE_LAST) {
>> +					printf("Invalid merge type\n");
>> +					return KSFT_FAIL;
>> +				}
>> +				merge_type = atoi(optarg);
>
> You can simply reuse tmp
>
> merge_type = tmp;

Changed it.
