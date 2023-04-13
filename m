Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2246A6E13EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 20:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDMSMP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 14:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMSMP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 14:12:15 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DBD30DA;
        Thu, 13 Apr 2023 11:12:13 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E1925C0097;
        Thu, 13 Apr 2023 14:12:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 13 Apr 2023 14:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1681409531; x=1681495931; bh=mH
        jMi001rdT9zkcgx9WuZ3TwwqhhBwYAfjHqVbYONwQ=; b=QN5jiFmvfK7Id5NhKO
        jcNG9TUYOXOqXoi5X8FrWnn4dWwNj5HRky84YgoVTpaa6weqPWIvCql6vFTfaNnv
        h1zPgvcJ2Shl+YCXIaTSOW3eAeRaH9wOXenEJeTLxph6PEKqD4xdh9CsnutXyaTR
        LOtbr8OHrV2oblucIpB/066THbuz0ynzNdaiT2OIvMkxJJ0TlH2MJqShfHXkOcfE
        Yj5JnB7gZ35Is/dzuQ7MRHJChgF/lcZw1dVC51KuxnscyLpOo7RKd7cjWS++CHXo
        twoFk7jFDspUQSIvLLfwp68ausIiVbjKLNkG1ywERuX8mbeuBhBKRFUVC8A/XpHR
        pwmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681409531; x=1681495931; bh=mHjMi001rdT9z
        kcgx9WuZ3TwwqhhBwYAfjHqVbYONwQ=; b=S1Mbnl08csEVGdnUDRUd15g0xhaaG
        au5MKaG0bB8lvLB5PSbstocS6Je4Z3oOP6NpIlpSPjcTwIpw2CJacg+WFEU43Unz
        h84vxHo1A+BsOaUucEaYd5Ap95zJR6/6gCI7LIyNKKRp2ndUixFNSlHVwqAtr3RK
        FsaZXBqB3+ca0tT4fzAYqwVDjlcwcYh6ornnMiL20oP4oRESkdUs8jQCiuT8O2tL
        gPMJNUvSyk6A24CxJ2gdF3oBzQxlX2l9LBOcArk9p8aNiF/foNNy/Bwa4bjjU8xQ
        FOL5/EASye0Vv69w9WxHg8OQWzCaukiZb3nLIVqjUFspIeCIriU2U4Qkw==
X-ME-Sender: <xms:-kU4ZLsHDEeFi3tUrYpDE_Bc46-AihXKNK5WdqRyqr_Sw-m6iCE2cg>
    <xme:-kU4ZMdoa6H6pGcrjpF9a0LtVXP1gwqdKRCRBMoLjNrupWkYc3hZ04sacpGjWL5pa
    4DlYW8BdAn4DOWHoYk>
X-ME-Received: <xmr:-kU4ZOy-slvxI-9uoOVUW1z-Mpy1BEQB94-uaLyPlx3IlE-U1PIxUnuRCldCn6GJEq0bEw2iEexKjExlxabpEqyHFtwp04G4pUaoVblKFgyn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:-kU4ZKO-FpEGPF7kpgO5hTHYpbpkJH1bP1aq32sK94Jg4TKa1N5_dA>
    <xmx:-kU4ZL9hfYprSz9aOZ3ADWCQ3_CP8zlFBHvZAAu65yvEQlZXojDqKQ>
    <xmx:-kU4ZKXULtx-OAECMILQov5UQFU1-OzPUJnOTw9Q78--ciVLcUwIGg>
    <xmx:-0U4ZCbONKO7WB7EaB9F_1w3YW7WJwKsEQX7ye6qUqfWpkSVSa924A>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 14:12:08 -0400 (EDT)
References: <20230412031648.2206875-1-shr@devkernel.io>
 <20230412031648.2206875-4-shr@devkernel.io>
 <7c5606cc-ca58-c505-b0d3-2eec29fe606a@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v6 3/3] selftests/mm: add new selftests for KSM
Date:   Thu, 13 Apr 2023 11:09:46 -0700
In-reply-to: <7c5606cc-ca58-c505-b0d3-2eec29fe606a@redhat.com>
Message-ID: <qvqw1qknhcsr.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 12.04.23 05:16, Stefan Roesch wrote:
>> This adds three new tests to the selftests for KSM.  These tests use the
>> new prctl API's to enable and disable KSM.
>> 1) add new prctl flags to prctl header file in tools dir
>>     This adds the new prctl flags to the include file prct.h in the
>>     tools directory.  This makes sure they are available for testing.
>> 2) add KSM prctl merge test
>>     This adds the -t option to the ksm_tests program.  The -t flag
>>     allows to specify if it should use madvise or prctl ksm merging.
>> 3) add KSM get merge type test
>>     This adds the -G flag to the ksm_tests program to query the KSM
>>     status with prctl after KSM has been enabled with prctl.
>> 4) add KSM fork test
>>     Add fork test to verify that the MMF_VM_MERGE_ANY flag is inherited
>>     by the child process.
>> 5) add two functions for debugging merge outcome
>>     This adds two functions to report the metrics in /proc/self/ksm_stat
>>     and /sys/kernel/debug/mm/ksm.
>> The debugging can be enabled with the following command line:
>> make -C tools/testing/selftests TARGETS="mm" --keep-going \
>>          EXTRA_CFLAGS=-DDEBUG=1
>
> Would it make sense to instead have a "-D" (if still unused) runtime options to
> print this data? Dead code that's not compiled is a bit unfortunate as it can
> easily bit-rot.
>
>

In the next version I'll add -d option. I'll add a global debug variable
for this. Otherwise we would need to pass down the debug option several
levels.

>
> This patch essentially does two things
>
> 1) Add the option to run all tests/benchmarks with the PRCTL instead of MADVISE
>
> 2) Add some functional KSM tests for the new PRCTL (fork, enabling works,
> disabling works).
>
> The latter should rather go into ksm_functional_tests().
>
> [...]
>
>>   -static int check_ksm_unmerge(int mapping, int prot, int timeout, size_t
>> page_size)
>> +/* Verify that prctl ksm flag is inherited. */
>> +static int check_ksm_fork(void)
>> +{
>> +	int rc = KSFT_FAIL;
>> +	pid_t child_pid;
>> +
>> +	if (prctl(PR_SET_MEMORY_MERGE, 1)) {
>> +		perror("prctl");
>> +		return KSFT_FAIL;
>> +	}
>> +
>> +	child_pid = fork();
>> +	if (child_pid == 0) {
>> +		int is_on = prctl(PR_GET_MEMORY_MERGE, 0);
>> +
>> +		if (!is_on)
>> +			exit(KSFT_FAIL);
>> +
>> +		exit(KSFT_PASS);
>> +	}
>> +
>> +	if (child_pid < 0)
>> +		goto out;
>> +
>> +	if (waitpid(child_pid, &rc, 0) < 0)
>> +		rc = KSFT_FAIL;
>> +
>> +	if (prctl(PR_SET_MEMORY_MERGE, 0)) {
>> +		perror("prctl");
>> +		rc = KSFT_FAIL;
>> +	}
>> +
>> +out:
>> +	if (rc == KSFT_PASS)
>> +		printf("OK\n");
>> +	else
>> +		printf("Not OK\n");
>> +
>> +	return rc;
>> +}
>> +
>> +static int check_ksm_get_merge_type(void)
>> +{
>> +	if (prctl(PR_SET_MEMORY_MERGE, 1)) {
>> +		perror("prctl set");
>> +		return 1;
>> +	}
>> +
>> +	int is_on = prctl(PR_GET_MEMORY_MERGE, 0);
>> +
>> +	if (prctl(PR_SET_MEMORY_MERGE, 0)) {
>> +		perror("prctl set");
>> +		return 1;
>> +	}
>> +
>> +	int is_off = prctl(PR_GET_MEMORY_MERGE, 0);
>> +
>> +	if (is_on && is_off) {
>> +		printf("OK\n");
>> +		return KSFT_PASS;
>> +	}
>> +
>> +	printf("Not OK\n");
>> +	return KSFT_FAIL;
>> +}
>
> Yes, these two are better located in ksm_functional_tests() to just run them
> both automatically when the test is executed.

I moved the check_ksm_get_merge_type() and check_ksm_fork() to the
ksm_functional_test executable. The change will be in the next version.
