Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521546E9DEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 23:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjDTVbi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 17:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDTVbh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 17:31:37 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06115123;
        Thu, 20 Apr 2023 14:31:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 707A632003D3;
        Thu, 20 Apr 2023 17:31:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 20 Apr 2023 17:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1682026294; x=1682112694; bh=ZX
        YrfI6mL8GAp9EePATK2aQWfA9YdeSnO3RSGAF64I4=; b=p8kEYQdx9RWw5rbetM
        QyZ1FZuFi9mZ/hL9rpsNZhtwVtWiQlqd2jNOUHyIRq24ktiOuzUhQ/QJ4YYedAdW
        cGDPAjNoc9efPMk8bdUt/8v1jcb8E3yNnjdpIfWgX0zUXpUQTMMYftmmpnZh+Cpb
        GVye3SaWnQnY3HL1SvsPrMbKZSB4R9wHW70wPuAmnLWIdEQDSfzbUWDDVengPffQ
        BiOx8ImhbByAQMh26rb9QvC67Dyb4iRYeh6NS/KgE/d0cPK0sEjn/Emhyo73svIe
        nTGibaGugyIm8q6wLeGoKQ45B9ezLiBYZlbNN9k4l7MN6thnGUhzzefdivaCM3cO
        Wf6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682026294; x=1682112694; bh=ZXYrfI6mL8GAp
        9EePATK2aQWfA9YdeSnO3RSGAF64I4=; b=YSOcMtrQLX9Uap02KYGPHEXxUuMKz
        Y5uL3pEhH8KdyD6yP47dcwEk2g1xf/4GSynj16hZEkQgrFiGQSYUfrm9UQtknvRh
        UUQiEOUJ9aojuTPRrI7Nr23u+2ZvTsNcnglQOnOmGsR1RZ2u0rlYaAiAzWG4vo1P
        lu3Y7f6e32DAJk9azAbkL7Pcgylc/Q+ZxVrozAXAJQ80aDrI8dVjAjcn5sT0b+0C
        ptBfugWmwWV9WmP4Zg4UIb1W/fSObY0kYX2dIFLN8Z5qvQDDpb783c9X1kXLXi5W
        FBBFHNd0UtvQEc73TTSHlY7a/dvbGIvIviPpyeISL6ozanF0aWvML17iA==
X-ME-Sender: <xms:Na9BZBMrerlL3zVQPovB7hkWQOaOjAoMmc3QDKwEZqUwwKbsx67MFw>
    <xme:Na9BZD-FMTMz80yiL85fc7KAU_weWtBw4KXH4G_LY4j7lfhFhB82424JwC9MoHtIK
    exi3oXr1HXxPagX7cU>
X-ME-Received: <xmr:Na9BZASuQLn9DtTJJYq5RVypM8jMroUXrviI6jGzsGLQ6PfOeJV1znnFFULHVvCxFVPiXMklsQPnWwpu3i4tO7L-M_H4ShnQFJSlS-SW5f6D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtvddgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:Na9BZNsbdSXyrV0NR-fz_nry8RGYAP3fPf3qOjxnXECX39bAK_D3kw>
    <xmx:Na9BZJdiC_5jGvC7np9Zp9Du2-uHwaEKHvO0fpO_hd_--EJPVkY8WA>
    <xmx:Na9BZJ1Ah7vK7MyacPNBhESHx0xkms6XmKSBQzNKi1jnBDrwv-C5TQ>
    <xmx:Nq9BZE0xPLVk7qkq-z0ZxhiwSi5gxZ17xGN3hpWTez--JRLE3h5Sew>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Apr 2023 17:31:31 -0400 (EDT)
References: <20230418051342.1919757-1-shr@devkernel.io>
 <20230418152849.505124-1-david@redhat.com>
 <20230418152849.505124-3-david@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 2/3] selftests/ksm: ksm_functional_tests: add prctl
 unmerge test
Date:   Thu, 20 Apr 2023 14:30:57 -0700
In-reply-to: <20230418152849.505124-3-david@redhat.com>
Message-ID: <qvqwmt32i6kt.fsf@devbig1114.prn1.facebook.com>
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

> Let's test whether setting PR_SET_MEMORY_MERGE to 0 after setting it to
> 1 will unmerge pages, similar to how setting MADV_UNMERGEABLE after setting
> MADV_MERGEABLE would.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  .../selftests/mm/ksm_functional_tests.c       | 46 ++++++++++++++++---
>  1 file changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> index 7bc9fc17c9f0..26853badae70 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -91,9 +91,10 @@ static int ksm_merge(void)
>  	return 0;
>  }
>
> -static char *mmap_and_merge_range(char val, unsigned long size)
> +static char *mmap_and_merge_range(char val, unsigned long size, bool use_prctl)
>  {
>  	char *map;
> +	int ret;
>
>  	map = mmap(NULL, size, PROT_READ|PROT_WRITE,
>  		   MAP_PRIVATE|MAP_ANON, -1, 0);
> @@ -110,7 +111,17 @@ static char *mmap_and_merge_range(char val, unsigned long size)
>
>  	/* Make sure each page contains the same values to merge them. */
>  	memset(map, val, size);
> -	if (madvise(map, size, MADV_MERGEABLE)) {
> +
> +	if (use_prctl) {
> +		ret = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
> +		if (ret < 0 && errno == EINVAL) {
> +			ksft_test_result_skip("PR_SET_MEMORY_MERGE not supported\n");
> +			goto unmap;
> +		} else if (ret) {
> +			ksft_test_result_fail("PR_SET_MEMORY_MERGE=1 failed\n");
> +			goto unmap;
> +		}
> +	} else if (madvise(map, size, MADV_MERGEABLE)) {
>  		ksft_test_result_fail("MADV_MERGEABLE failed\n");
>  		goto unmap;
>  	}
> @@ -133,7 +144,7 @@ static void test_unmerge(void)
>
>  	ksft_print_msg("[RUN] %s\n", __func__);
>
> -	map = mmap_and_merge_range(0xcf, size);
> +	map = mmap_and_merge_range(0xcf, size, false);
>  	if (map == MAP_FAILED)
>  		return;
>
> @@ -155,7 +166,7 @@ static void test_unmerge_discarded(void)
>
>  	ksft_print_msg("[RUN] %s\n", __func__);
>
> -	map = mmap_and_merge_range(0xcf, size);
> +	map = mmap_and_merge_range(0xcf, size, false);
>  	if (map == MAP_FAILED)
>  		return;
>
> @@ -187,7 +198,7 @@ static void test_unmerge_uffd_wp(void)
>
>  	ksft_print_msg("[RUN] %s\n", __func__);
>
> -	map = mmap_and_merge_range(0xcf, size);
> +	map = mmap_and_merge_range(0xcf, size, false);
>  	if (map == MAP_FAILED)
>  		return;
>
> @@ -323,9 +334,31 @@ static void test_prctl_fork(void)
>  	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");
>  }
>
> +static void test_prctl_unmerge(void)
> +{
> +	const unsigned int size = 2 * MiB;
> +	char *map;
> +
> +	ksft_print_msg("[RUN] %s\n", __func__);
> +
> +	map = mmap_and_merge_range(0xcf, size, true);
> +	if (map == MAP_FAILED)
> +		return;
> +
> +	if (prctl(PR_SET_MEMORY_MERGE, 0, 0, 0, 0)) {
> +		ksft_test_result_fail("PR_SET_MEMORY_MERGE=0 failed\n");
> +		goto unmap;
> +	}
> +
> +	ksft_test_result(!range_maps_duplicates(map, size),
> +			 "Pages were unmerged\n");
> +unmap:
> +	munmap(map, size);
> +}
> +
>  int main(int argc, char **argv)
>  {
> -	unsigned int tests = 4;
> +	unsigned int tests = 5;
>  	int err;
>
>  #ifdef __NR_userfaultfd
> @@ -355,6 +388,7 @@ int main(int argc, char **argv)
>
>  	test_prctl();
>  	test_prctl_fork();
> +	test_prctl_unmerge();
>
>  	err = ksft_get_fail_cnt();
>  	if (err)

Acked-by: Stefan Roesch <shr@devkernel.io>
