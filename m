Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBA16BB3EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 14:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjCONH5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 09:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjCONH4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 09:07:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFDA85353;
        Wed, 15 Mar 2023 06:07:54 -0700 (PDT)
Received: from [IPV6:2001:861:4a40:8620:2c75:7350:cd65:d027] (unknown [IPv6:2001:861:4a40:8620:2c75:7350:cd65:d027])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B7ED2660304F;
        Wed, 15 Mar 2023 13:07:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678885673;
        bh=5re/JPBZEH9+G9AWINTZ7qiFtAiq3TE2YC3ggLy0kHs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mey0BY8Bf4z0ZDu8KtlVA2aXK2UEiKmKvoFBkKFz4EWWiacdu98oZm4R1+7wVcr0W
         CdaFfacq3bz+flK8D8BWQgmb4t9lFMa4jQIe67Nkcfc6GBcA3KMLTwfG+C7NXXY8xi
         i4VBSQ6ZuZUpmZ+ohBUGQ8DAGQrMKWy74gmAAa2X8SkDnBdwQePKay9Oqei3bkB3QS
         ghvwp0DHX/rCPsFBE3jNfq/Tu7HTmaP1iPJOJj77j19g9LAMKYBQXt+ATFH0ifduMY
         y+66bZPVYZQXUSYQMfEyJoQdmYr70vm6yeqL9edONGmhQeIoNc5YovjEdJNjEHBZ0r
         9gK7+D8qVhcwg==
Message-ID: <aeaae945-ddc1-09e1-4120-74868962e90c@collabora.com>
Date:   Wed, 15 Mar 2023 14:08:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [KTAP V2 PATCH] ktap_v2: add skip test result
To:     Rae Moar <rmoar@google.com>, frowand.list@gmail.com,
        davidgow@google.com, skhan@linuxfoundation.org,
        keescook@chromium.org, Tim.Bird@sony.com, brendanhiggins@google.com
Cc:     corbet@lwn.net, dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
        "kernelci-tsc@groups.io" <kernelci-tsc@groups.io>
References: <20230310222002.3633162-1-rmoar@google.com>
Content-Language: en-US
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <20230310222002.3633162-1-rmoar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FUZZY_CPILL,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+ kernelci@lists.linux.dev

Please note: kernelci@groups.io is not used any more, see details
here about the move:

  https://groups.io/g/kernelci

The new KernelCI email archives can be found here:

  https://lore.kernel.org/kernelci/

Thanks,
Guillaume


On 10/03/2023 23:20, Rae Moar wrote:
> Add the test result "skip" to KTAP version 2 as an alternative way to
> indicate a test was skipped.
> 
> The current spec uses the "#SKIP" directive to indicate that a test was
> skipped. However, the "#SKIP" directive is not always evident when quickly
> skimming through KTAP results.
> 
> The "skip" result would provide an alternative that could make it clearer
> that a test has not successfully passed because it was skipped.
> 
> Before:
> 
>  KTAP version 1
>  1..1
>    KTAP version 1
>    1..2
>    ok 1 case_1
>    ok 2 case_2 #SKIP
>  ok 1 suite
> 
> After:
> 
>  KTAP version 2
>  1..1
>    KTAP version 2
>    1..2
>    ok 1 case_1
>    skip 2 case_2
>  ok 1 suite
> 
> Here is a link to a version of the KUnit parser that is able to parse
> the skip test result for KTAP version 2. Note this parser is still able
> to parse the "#SKIP" directive.
> 
> Link: https://kunit-review.googlesource.com/c/linux/+/5689
> 
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---
> 
> Note: this patch is based on Frank's ktap_spec_version_2 branch.
> 
>  Documentation/dev-tools/ktap.rst | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
> index ff77f4aaa6ef..f48aa00db8f0 100644
> --- a/Documentation/dev-tools/ktap.rst
> +++ b/Documentation/dev-tools/ktap.rst
> @@ -74,7 +74,8 @@ They are required and must have the format:
>  	<result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
>  
>  The result can be either "ok", which indicates the test case passed,
> -or "not ok", which indicates that the test case failed.
> +"not ok", which indicates that the test case failed, or "skip", which indicates
> +the test case did not run.
>  
>  <number> represents the number of the test being performed. The first test must
>  have the number 1 and the number then must increase by 1 for each additional
> @@ -91,12 +92,13 @@ A directive is a keyword that indicates a different outcome for a test other
>  than passed and failed. The directive is optional, and consists of a single
>  keyword preceding the diagnostic data. In the event that a parser encounters
>  a directive it doesn't support, it should fall back to the "ok" / "not ok"
> -result.
> +/ "skip" result.
>  
>  Currently accepted directives are:
>  
> -- "SKIP", which indicates a test was skipped (note the result of the test case
> -  result line can be either "ok" or "not ok" if the SKIP directive is used)
> +- "SKIP", which indicates a test was skipped (note this is an alternative to
> +  the "skip" result type and if the SKIP directive is used, the
> +  result can be any type - "ok", "not ok", or "skip")
>  - "TODO", which indicates that a test is not expected to pass at the moment,
>    e.g. because the feature it is testing is known to be broken. While this
>    directive is inherited from TAP, its use in the kernel is discouraged.
> @@ -110,7 +112,7 @@ Currently accepted directives are:
>  
>  The diagnostic data is a plain-text field which contains any additional details
>  about why this result was produced. This is typically an error message for ERROR
> -or failed tests, or a description of missing dependencies for a SKIP result.
> +or failed tests, or a description of missing dependencies for a skipped test.
>  
>  The diagnostic data field is optional, and results which have neither a
>  directive nor any diagnostic data do not need to include the "#" field
> @@ -130,11 +132,18 @@ The test "test_case_name" failed.
>  
>  ::
>  
> -	ok 1 test # SKIP necessary dependency unavailable
> +	skip 1 test # necessary dependency unavailable
>  
> -The test "test" was SKIPPED with the diagnostic message "necessary dependency
> +The test "test" was skipped with the diagnostic message "necessary dependency
>  unavailable".
>  
> +::
> +
> +	ok 1 test_2 # SKIP this test should not run
> +
> +The test "test_2" was skipped with the diagnostic message "this test
> +should not run".
> +
>  ::
>  
>  	not ok 1 test # TIMEOUT 30 seconds
> @@ -225,7 +234,7 @@ An example format with multiple levels of nested testing:
>  	    not ok 1 test_1
>  	    ok 2 test_2
>  	  not ok 1 test_3
> -	  ok 2 test_4 # SKIP
> +	  skip 2 test_4
>  	not ok 1 example_test_1
>  	ok 2 example_test_2
>  
> @@ -262,7 +271,7 @@ Example KTAP output
>  	  ok 1 example_test_1
>  	    KTAP version 2
>  	    1..2
> -	    ok 1 test_1 # SKIP test_1 skipped
> +	    skip 1 test_1 # test_1 skipped
>  	    ok 2 test_2
>  	  ok 2 example_test_2
>  	    KTAP version 2
> 
> base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5

