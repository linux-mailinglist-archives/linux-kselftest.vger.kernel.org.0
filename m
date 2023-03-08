Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ED76B0548
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 12:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjCHLDJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 06:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCHLCs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 06:02:48 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F3DBBB39;
        Wed,  8 Mar 2023 03:02:31 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PWpY95Ntwz9xs6D;
        Wed,  8 Mar 2023 18:32:45 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAn8lg9Zghkeml9AQ--.21953S2;
        Wed, 08 Mar 2023 11:41:13 +0100 (CET)
Message-ID: <efd569cdf6bba1ee80686f73a64bc636975dd899.camel@huaweicloud.com>
Subject: Re: [PATCH] bpf: Fix IMA test
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        mattbobrowski@google.com, zohar@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 08 Mar 2023 11:40:58 +0100
In-Reply-To: <20230308103713.1681200-1-roberto.sassu@huaweicloud.com>
References: <20230308103713.1681200-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAn8lg9Zghkeml9AQ--.21953S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyUAr45Kw1kKryfWr18Grg_yoW5ZFy8p3
        93Wr1Yyw1ktFyftrsrAayUWFZ3ZFnrXa1UWrn5J345Aw1UWryIgryIvFy0qa1DJrZ2qa1f
        Za1fWrZrWw48Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
        0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
        vE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1rMa5UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4pS5wAAsB
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2023-03-08 at 11:37 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>

The title should have been selftests/bpf: ...

Will send a new version once I get the test result.

Roberto

> Commit 62622dab0a28 ("ima: return IMA digest value only when IMA_COLLECTED
> flag is set") caused bpf_ima_inode_hash() to refuse to give non-fresh
> digests. IMA test #3 assumed the old behavior, that bpf_ima_inode_hash()
> still returned also non-fresh digests.
> 
> Correct the test by accepting both cases. If the samples returned are 1,
> assume that the commit above is applied and that the returned digest is
> fresh. If the samples returned are 2, assume that the commit above is not
> applied, and check both the non-fresh and fresh digest.
> 
> Fixes: 62622dab0a28 ("ima: return IMA digest value only when IMA_COLLECTED flag is set")
> Reported by: David Vernet <void@manifault.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  .../selftests/bpf/prog_tests/test_ima.c       | 29 ++++++++++++++-----
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> index b13feceb38f..810b14981c2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_ima.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> @@ -70,7 +70,7 @@ void test_test_ima(void)
>  	u64 bin_true_sample;
>  	char cmd[256];
>  
> -	int err, duration = 0;
> +	int err, duration = 0, fresh_digest_idx = 0;
>  	struct ima *skel = NULL;
>  
>  	skel = ima__open_and_load();
> @@ -129,7 +129,15 @@ void test_test_ima(void)
>  	/*
>  	 * Test #3
>  	 * - Goal: confirm that bpf_ima_inode_hash() returns a non-fresh digest
> -	 * - Expected result: 2 samples (/bin/true: non-fresh, fresh)
> +	 * - Expected result:
> +	 *   1 sample (/bin/true: fresh) if commit 62622dab0a28 applied
> +	 *   2 samples (/bin/true: non-fresh, fresh) if commit 62622dab0a28 is
> +	 *     not applied
> +	 *
> +	 * If commit 62622dab0a28 ("ima: return IMA digest value only when
> +	 * IMA_COLLECTED flag is set") is applied, bpf_ima_inode_hash() refuses
> +	 * to give a non-fresh digest, hence the correct result is 1 instead of
> +	 * 2.
>  	 */
>  	test_init(skel->bss);
>  
> @@ -144,13 +152,18 @@ void test_test_ima(void)
>  		goto close_clean;
>  
>  	err = ring_buffer__consume(ringbuf);
> -	ASSERT_EQ(err, 2, "num_samples_or_err");
> -	ASSERT_NEQ(ima_hash_from_bpf[0], 0, "ima_hash");
> -	ASSERT_NEQ(ima_hash_from_bpf[1], 0, "ima_hash");
> -	ASSERT_EQ(ima_hash_from_bpf[0], bin_true_sample, "sample_equal_or_err");
> +	ASSERT_GE(err, 1, "num_samples_or_err");
> +	if (err == 2) {
> +		ASSERT_NEQ(ima_hash_from_bpf[0], 0, "ima_hash");
> +		ASSERT_EQ(ima_hash_from_bpf[0], bin_true_sample,
> +			  "sample_equal_or_err");
> +		fresh_digest_idx = 1;
> +	}
> +
> +	ASSERT_NEQ(ima_hash_from_bpf[fresh_digest_idx], 0, "ima_hash");
>  	/* IMA refreshed the digest. */
> -	ASSERT_NEQ(ima_hash_from_bpf[1], bin_true_sample,
> -		   "sample_different_or_err");
> +	ASSERT_NEQ(ima_hash_from_bpf[fresh_digest_idx], bin_true_sample,
> +		   "sample_equal_or_err");
>  
>  	/*
>  	 * Test #4

