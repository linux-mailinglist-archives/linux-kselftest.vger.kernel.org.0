Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011BD7B1765
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 11:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjI1Jcv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 05:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Jcu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 05:32:50 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4502126;
        Thu, 28 Sep 2023 02:32:48 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38S5eNJc014947;
        Thu, 28 Sep 2023 04:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=GMIOHLA+1cwj2SUxHf/5rdlhotu8odxf5qrGWEkUgS0=; b=
        XAhqokCGpY59R7SgHNGNlLx9ZmsWtNVUUgHPxHaIekl2d2Cs5sLOVVAwbPvAeTIj
        m3/Ylhg/GrXpC8tkUCTljqDwJHZFN6gtQ78Q/9ndvmcoYZtdBmQbYAinNoyb0+x0
        RVvyORUYqRqBPpCqD3bSg9rLGGlqcHt0J1kzpWp/mmSwoAZuXv1+TUIfKmOt6rmG
        5N73Ez3+nBU2/GotEoka9JSdekA7aabSgHs5UFHlOC//Zg5G4qc/VpGVIzDHJCs7
        7i2ZT30Fftfvp6e4wJaUuKn26Gu5jnrTZVSc7eGjH0sXR4y+BuNN1PtheHs8IBRp
        +4GAGifeLoyQtbSE7sqwtg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t9vejdvgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 04:32:37 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 28 Sep
 2023 10:32:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 28 Sep 2023 10:32:36 +0100
Received: from [198.90.251.13] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.13])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 435D911AB;
        Thu, 28 Sep 2023 09:32:36 +0000 (UTC)
Message-ID: <8fec7a59-5fc0-a543-8b87-f4b2a9232aa9@opensource.cirrus.com>
Date:   Thu, 28 Sep 2023 10:32:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] kunit: debugfs: Handle errors from alloc_string_stream()
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20230927165058.29484-1-rf@opensource.cirrus.com>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20230927165058.29484-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uT0Cs6wX9Q8nbE_5sRkJmBgUpgh9Tp0F
X-Proofpoint-ORIG-GUID: uT0Cs6wX9Q8nbE_5sRkJmBgUpgh9Tp0F
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 27/09/2023 17:50, Richard Fitzgerald wrote:
> In kunit_debugfs_create_suite() give up and skip creating the debugfs
> file if any of the alloc_string_stream() calls return an error or NULL.
> Only put a value in the log pointer of kunit_suite and kunit_test if it
> is a valid pointer to a log.
> 
> This prevents the potential invalid dereference reported by smatch:
> 
>   lib/kunit/debugfs.c:115 kunit_debugfs_create_suite() error: 'suite->log'
> 	dereferencing possible ERR_PTR()
>   lib/kunit/debugfs.c:119 kunit_debugfs_create_suite() error: 'test_case->log'
> 	dereferencing possible ERR_PTR()
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 05e2006ce493 ("kunit: Use string_stream for test log")
> ---
>   lib/kunit/debugfs.c | 29 ++++++++++++++++++++++++-----
>   1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 270d185737e6..73075ca6e88c 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -109,14 +109,27 @@ static const struct file_operations debugfs_results_fops = {
>   void kunit_debugfs_create_suite(struct kunit_suite *suite)
>   {
>   	struct kunit_case *test_case;
> +	struct string_stream *stream;
>   
> -	/* Allocate logs before creating debugfs representation. */
> -	suite->log = alloc_string_stream(GFP_KERNEL);
> -	string_stream_set_append_newlines(suite->log, true);
> +	/*
> +	 * Allocate logs before creating debugfs representation.
> +	 * The log pointer must be NULL if there isn't a log so only
> +	 * set it if the log stream was created successfully.
> +	 */
> +	stream = alloc_string_stream(GFP_KERNEL);
> +	if (IS_ERR_OR_NULL(stream))
> +		goto err;

This can be a return. Nothing has been created at this point so
there is nothing to clean up.
I'll send a V2.

> +
> +	string_stream_set_append_newlines(stream, true);
> +	suite->log = stream;
>   
>   	kunit_suite_for_each_test_case(suite, test_case) {
> -		test_case->log = alloc_string_stream(GFP_KERNEL);
> -		string_stream_set_append_newlines(test_case->log, true);
> +		stream = alloc_string_stream(GFP_KERNEL);
> +		if (IS_ERR_OR_NULL(stream))
> +			goto err;
> +
> +		string_stream_set_append_newlines(stream, true);
> +		test_case->log = stream;
>   	}
>   
>   	suite->debugfs = debugfs_create_dir(suite->name, debugfs_rootdir);
> @@ -124,6 +137,12 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
>   	debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
>   			    suite->debugfs,
>   			    suite, &debugfs_results_fops);
> +	return;
> +
> +err:
> +	string_stream_destroy(suite->log);
> +	kunit_suite_for_each_test_case(suite, test_case)
> +		string_stream_destroy(test_case->log);
>   }
>   
>   void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
