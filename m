Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1E96B0698
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 13:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCHMGW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 07:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCHMGV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 07:06:21 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A431A962;
        Wed,  8 Mar 2023 04:06:17 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PWrQK4jYZz9xFrP;
        Wed,  8 Mar 2023 19:56:57 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB39QAbeghkbvN_AQ--.22828S2;
        Wed, 08 Mar 2023 13:05:58 +0100 (CET)
Message-ID: <9f19f0ff41114f7c90cca681f438388a64807e92.camel@huaweicloud.com>
Subject: Re: [PATCH] bpf: Fix IMA test
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Matt Bobrowski <mattbobrowski@google.com>
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 08 Mar 2023 13:05:45 +0100
In-Reply-To: <ZAhrl0rK9Yume1Ed@google.com>
References: <20230308103713.1681200-1-roberto.sassu@huaweicloud.com>
         <ZAhrl0rK9Yume1Ed@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwB39QAbeghkbvN_AQ--.22828S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4fXw4fZFW5uFy3CFy3Arb_yoW5Kw17p3
        97Wr1jya1xtFy3trn2vFWUWFWSvFn7X3WUGrs5t34rA34UWr92qa4IvF18X3Z8CrWIya1x
        Za1rGrZrGw10yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UdxhLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4ZWEAABs8
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2023-03-08 at 11:03 +0000, Matt Bobrowski wrote:
> Ha! I was literally in the midst of sending through a patch for
> this. Thanks for also taking a look and beating me to it!
> 
> This LGTM, feel free to add:
> 
> Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>

Thanks.

I have only one remain question. Should we accept the old behavior, or
simply reject it?

Roberto

> On Wed, Mar 08, 2023 at 11:37:13AM +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Commit 62622dab0a28 ("ima: return IMA digest value only when IMA_COLLECTED
> > flag is set") caused bpf_ima_inode_hash() to refuse to give non-fresh
> > digests. IMA test #3 assumed the old behavior, that bpf_ima_inode_hash()
> > still returned also non-fresh digests.
> > 
> > Correct the test by accepting both cases. If the samples returned are 1,
> > assume that the commit above is applied and that the returned digest is
> > fresh. If the samples returned are 2, assume that the commit above is not
> > applied, and check both the non-fresh and fresh digest.
> > 
> > Fixes: 62622dab0a28 ("ima: return IMA digest value only when IMA_COLLECTED flag is set")
> > Reported by: David Vernet <void@manifault.com>
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  .../selftests/bpf/prog_tests/test_ima.c       | 29 ++++++++++++++-----
> >  1 file changed, 21 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> > index b13feceb38f..810b14981c2 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/test_ima.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> > @@ -70,7 +70,7 @@ void test_test_ima(void)
> >  	u64 bin_true_sample;
> >  	char cmd[256];
> >  
> > -	int err, duration = 0;
> > +	int err, duration = 0, fresh_digest_idx = 0;
> >  	struct ima *skel = NULL;
> >  
> >  	skel = ima__open_and_load();
> > @@ -129,7 +129,15 @@ void test_test_ima(void)
> >  	/*
> >  	 * Test #3
> >  	 * - Goal: confirm that bpf_ima_inode_hash() returns a non-fresh digest
> > -	 * - Expected result: 2 samples (/bin/true: non-fresh, fresh)
> > +	 * - Expected result:
> > +	 *   1 sample (/bin/true: fresh) if commit 62622dab0a28 applied
> > +	 *   2 samples (/bin/true: non-fresh, fresh) if commit 62622dab0a28 is
> > +	 *     not applied
> > +	 *
> > +	 * If commit 62622dab0a28 ("ima: return IMA digest value only when
> > +	 * IMA_COLLECTED flag is set") is applied, bpf_ima_inode_hash() refuses
> > +	 * to give a non-fresh digest, hence the correct result is 1 instead of
> > +	 * 2.
> >  	 */
> >  	test_init(skel->bss);
> >  
> > @@ -144,13 +152,18 @@ void test_test_ima(void)
> >  		goto close_clean;
> >  
> >  	err = ring_buffer__consume(ringbuf);
> > -	ASSERT_EQ(err, 2, "num_samples_or_err");
> > -	ASSERT_NEQ(ima_hash_from_bpf[0], 0, "ima_hash");
> > -	ASSERT_NEQ(ima_hash_from_bpf[1], 0, "ima_hash");
> > -	ASSERT_EQ(ima_hash_from_bpf[0], bin_true_sample, "sample_equal_or_err");
> > +	ASSERT_GE(err, 1, "num_samples_or_err");
> > +	if (err == 2) {
> > +		ASSERT_NEQ(ima_hash_from_bpf[0], 0, "ima_hash");
> > +		ASSERT_EQ(ima_hash_from_bpf[0], bin_true_sample,
> > +			  "sample_equal_or_err");
> > +		fresh_digest_idx = 1;
> > +	}
> > +
> > +	ASSERT_NEQ(ima_hash_from_bpf[fresh_digest_idx], 0, "ima_hash");
> >  	/* IMA refreshed the digest. */
> > -	ASSERT_NEQ(ima_hash_from_bpf[1], bin_true_sample,
> > -		   "sample_different_or_err");
> > +	ASSERT_NEQ(ima_hash_from_bpf[fresh_digest_idx], bin_true_sample,
> > +		   "sample_equal_or_err");
> >  
> >  	/*
> >  	 * Test #4
> > -- 
> > 2.25.1
> > 
> /M

