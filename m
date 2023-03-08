Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834706B0705
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 13:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjCHMZQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 07:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjCHMZH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 07:25:07 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5FB25943
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 04:24:32 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x3so64887972edb.10
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 04:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678278271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/79u3NievU114h75XyEizn8Kbhu2zyr9KGTl1BwcSZI=;
        b=V1hHxBqOPE2qUn8zBqILiGuhZWnPmGbCFd1gy6IE4x3MkHDPpDoqHsirtxgb/bM2ne
         36VfGCEPAso7RN2p2wmmEsfIDnY7ccH+sTsPFY1O1w3C+XJkRv+ARxlmaV0O9XgITgsk
         j4Ul2ZTdFF2HnldDczEwZkPNbkiUfdhJYPqMFE83b0AklieQskPuPNoFQsYdL0cu6eLD
         6K6nWt+/rxaCTFD0ZJlGHa3TRbARUKl71DfdpFzgXLuKyTBCXXaCdxPjCs1A3NrCxiOw
         POKb+4TRrgUv8oDu0ay7NxPQIpBljeNMWEPii+nxm8odpHxh4ezH4bdsRQGBX9ZCmWvj
         ygWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678278271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/79u3NievU114h75XyEizn8Kbhu2zyr9KGTl1BwcSZI=;
        b=I4pDt3NwMc18ueMU4gUxLagBdS9SpoB9AJy7M3UqIhOJ613toNxJoO11Wob0z/yP+Y
         ozhiuVLiPMQVZPN3ijDY+zQDaD5UdNjCtfZv/NM3No8H5kwQ50zB+FXXjoD7or3YSspN
         ZB3ESf7f3pr5xTBaACpH+ZE9vMhroMNU4wrWxHmX/2pZju8A7fxiEakOINIeNO6dnDdo
         PLo499Tdozz3gmmo+cIdilEujXFqESrfgnc7z/iWCh/QWjJY/9KIKtPyubTh1cMesmrK
         nIlRMx//appiG21zSdbZaRqEhlqelbtttA52x26tC9ntNGPQwCXY2Ky9WX6KZ8VLQI1c
         XUdg==
X-Gm-Message-State: AO0yUKXlnPqSmdC+U2OKzEhN2mu8QC+/Vn9BZMc3et6oHgJ1i0TqmRBV
        eAlwrC3TEvtYHFt138Mvl5lPTA==
X-Google-Smtp-Source: AK7set8HnTZCwP54a0MYhGz5sDoile+Y21+dgjFbbDezeItGGAVrJHJI16y6Q3L7KtIiJQpZawFodQ==
X-Received: by 2002:a17:907:9703:b0:8af:514f:1078 with SMTP id jg3-20020a170907970300b008af514f1078mr21599887ejc.31.1678278270907;
        Wed, 08 Mar 2023 04:24:30 -0800 (PST)
Received: from google.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id z30-20020a509e21000000b004bef1187754sm8127244ede.95.2023.03.08.04.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 04:24:30 -0800 (PST)
Date:   Wed, 8 Mar 2023 12:24:26 +0000
From:   Matt Bobrowski <mattbobrowski@google.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH] bpf: Fix IMA test
Message-ID: <ZAh+eqa4bcFfizwe@google.com>
References: <20230308103713.1681200-1-roberto.sassu@huaweicloud.com>
 <ZAhrl0rK9Yume1Ed@google.com>
 <9f19f0ff41114f7c90cca681f438388a64807e92.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f19f0ff41114f7c90cca681f438388a64807e92.camel@huaweicloud.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08, 2023 at 01:05:45PM +0100, Roberto Sassu wrote:
> On Wed, 2023-03-08 at 11:03 +0000, Matt Bobrowski wrote:
> > Ha! I was literally in the midst of sending through a patch for
> > this. Thanks for also taking a look and beating me to it!
> > 
> > This LGTM, feel free to add:
> > 
> > Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
> 
> Thanks.
> 
> I have only one remain question. Should we accept the old behavior, or
> simply reject it?

I assume you mean whether we should continue supporting the old,
arguably incorrect, behavior in this test? I'm of the opinion that it
is OK, given that this is how the API behaved prior to commit
62622dab0a28.

I'll let others also chime in and share their .02 though...

> > On Wed, Mar 08, 2023 at 11:37:13AM +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Commit 62622dab0a28 ("ima: return IMA digest value only when IMA_COLLECTED
> > > flag is set") caused bpf_ima_inode_hash() to refuse to give non-fresh
> > > digests. IMA test #3 assumed the old behavior, that bpf_ima_inode_hash()
> > > still returned also non-fresh digests.
> > > 
> > > Correct the test by accepting both cases. If the samples returned are 1,
> > > assume that the commit above is applied and that the returned digest is
> > > fresh. If the samples returned are 2, assume that the commit above is not
> > > applied, and check both the non-fresh and fresh digest.
> > > 
> > > Fixes: 62622dab0a28 ("ima: return IMA digest value only when IMA_COLLECTED flag is set")
> > > Reported by: David Vernet <void@manifault.com>
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/test_ima.c       | 29 ++++++++++++++-----
> > >  1 file changed, 21 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> > > index b13feceb38f..810b14981c2 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/test_ima.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> > > @@ -70,7 +70,7 @@ void test_test_ima(void)
> > >  	u64 bin_true_sample;
> > >  	char cmd[256];
> > >  
> > > -	int err, duration = 0;
> > > +	int err, duration = 0, fresh_digest_idx = 0;
> > >  	struct ima *skel = NULL;
> > >  
> > >  	skel = ima__open_and_load();
> > > @@ -129,7 +129,15 @@ void test_test_ima(void)
> > >  	/*
> > >  	 * Test #3
> > >  	 * - Goal: confirm that bpf_ima_inode_hash() returns a non-fresh digest
> > > -	 * - Expected result: 2 samples (/bin/true: non-fresh, fresh)
> > > +	 * - Expected result:
> > > +	 *   1 sample (/bin/true: fresh) if commit 62622dab0a28 applied
> > > +	 *   2 samples (/bin/true: non-fresh, fresh) if commit 62622dab0a28 is
> > > +	 *     not applied
> > > +	 *
> > > +	 * If commit 62622dab0a28 ("ima: return IMA digest value only when
> > > +	 * IMA_COLLECTED flag is set") is applied, bpf_ima_inode_hash() refuses
> > > +	 * to give a non-fresh digest, hence the correct result is 1 instead of
> > > +	 * 2.
> > >  	 */
> > >  	test_init(skel->bss);
> > >  
> > > @@ -144,13 +152,18 @@ void test_test_ima(void)
> > >  		goto close_clean;
> > >  
> > >  	err = ring_buffer__consume(ringbuf);
> > > -	ASSERT_EQ(err, 2, "num_samples_or_err");
> > > -	ASSERT_NEQ(ima_hash_from_bpf[0], 0, "ima_hash");
> > > -	ASSERT_NEQ(ima_hash_from_bpf[1], 0, "ima_hash");
> > > -	ASSERT_EQ(ima_hash_from_bpf[0], bin_true_sample, "sample_equal_or_err");
> > > +	ASSERT_GE(err, 1, "num_samples_or_err");
> > > +	if (err == 2) {
> > > +		ASSERT_NEQ(ima_hash_from_bpf[0], 0, "ima_hash");
> > > +		ASSERT_EQ(ima_hash_from_bpf[0], bin_true_sample,
> > > +			  "sample_equal_or_err");
> > > +		fresh_digest_idx = 1;
> > > +	}
> > > +
> > > +	ASSERT_NEQ(ima_hash_from_bpf[fresh_digest_idx], 0, "ima_hash");
> > >  	/* IMA refreshed the digest. */
> > > -	ASSERT_NEQ(ima_hash_from_bpf[1], bin_true_sample,
> > > -		   "sample_different_or_err");
> > > +	ASSERT_NEQ(ima_hash_from_bpf[fresh_digest_idx], bin_true_sample,
> > > +		   "sample_equal_or_err");
> > >  
> > >  	/*
> > >  	 * Test #4
> > > -- 
> > > 2.25.1

/M
