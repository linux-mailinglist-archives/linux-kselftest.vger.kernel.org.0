Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A1A6C99A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 04:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjC0Clz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Mar 2023 22:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0Cly (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Mar 2023 22:41:54 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FCD44AF;
        Sun, 26 Mar 2023 19:41:53 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id x8-20020a9d3788000000b0069f922cd5ceso3808752otb.12;
        Sun, 26 Mar 2023 19:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679884912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRauHu1FOjU1xQL/oXl2UNdyYQgBLhmS7p7OrBntk+k=;
        b=JHmkY7tdYZSVVlBNau7p68ncdc1TURD1w8HYA/zw9iLP/+s6VluqD0EtQilHMCpgye
         xjTRtJACHjnjcTq1Ukie0WmG5xgwqEtYBEh/qG3aWgzPmDVv86GpeXu0QWijd3zrrIwl
         o2Psye6PONkyD1QZx3lMTz1njjravMGJqE0b2voJaIsErCDIVbexYINIrSBSIylVMr/t
         bj9CZJJUeFbgXcbcu+XYtc4jWbLrghNXzbrnxsX1JsiXGE7W6p2aT/ovvvj2uWFGNpi5
         M47mUo2tvWVknswz7dRd8xBr9+CR6pkRsyGLZxE4d+gSw+7UcUXjtNC8AUn2XM0ly2gM
         xZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679884912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRauHu1FOjU1xQL/oXl2UNdyYQgBLhmS7p7OrBntk+k=;
        b=XgJPc6fWCrdJyXYlzsZUS2PwGthag9My3AJXRO8r860kHc5QdXWJF6cuP3+Bb/vByq
         GvxvfkqQjn5yNu5JHRilLATSdMTC5YFcF6BRZlcWAzbfsbQ1yBpt504fsrk54qj5s3Bv
         jZBzdLLG4E9eI0LP5J2ovPXIWl78CdQ4dwQVP9kz02DWVe8WGpqOkWE1Y/HtnS8ZDojd
         RHfoyFEmbfxU6hVu2DoYOINbUa4jldf+eQUVS4kDNkmjEqWmfXv4AzC4lEJ8q8BEY7y7
         mvnvCMCmVXkaAU6n+nEfAj+IqSAK5eVsaM5xo8BNXgXjB205sBgS0MMBRL8xprtuwcUf
         n5tw==
X-Gm-Message-State: AAQBX9edJjFC97QV6T3Oic9efZX1YoG+wWA8xaVxJwL28s0mfCZdDUt3
        3FcF/LquykIe7LA/Qi4vLhc=
X-Google-Smtp-Source: AKy350YaOvV4wgho3Y8Gqb2SQntKfrIJyqMdE2stCjweiVzT1ZH0s/MJG/fZbfLR/J/4VXW7Nj8goQ==
X-Received: by 2002:a05:6830:1457:b0:6a1:37f1:9863 with SMTP id w23-20020a056830145700b006a137f19863mr1291505otp.11.1679884912460;
        Sun, 26 Mar 2023 19:41:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:988b:7dda:764e:c744? ([2600:1700:2442:6db0:988b:7dda:764e:c744])
        by smtp.gmail.com with ESMTPSA id r25-20020a9d7519000000b006a11af03732sm2773600otk.67.2023.03.26.19.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 19:41:51 -0700 (PDT)
Message-ID: <197889b6-5773-094c-8699-26843c6519fd@gmail.com>
Date:   Sun, 26 Mar 2023 21:41:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [KTAP V2 PATCH] ktap_v2: add recognized test name line
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>, davidgow@google.com,
        skhan@linuxfoundation.org, keescook@chromium.org,
        Tim.Bird@sony.com, brendanhiggins@google.com
Cc:     corbet@lwn.net, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@lists.linux.dev,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230316225915.494688-1-rmoar@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230316225915.494688-1-rmoar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TRACKER_ID
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/16/23 17:59, Rae Moar wrote:
> Add recognition of the test name line ("# Subtest: <name>") to the KTAP v2
> spec.
> 
> The purpose of this line is to declare the name of a test before its
> results. This functionality is especially useful when trying to parse test
> results incrementally and when interpretting results after a crash.
> 
> This line is already compliant with KTAP v1 as it is interpretted as a
> diagnostic line by parsers. Additionally, the line is currently used by
> KUnit tests and was derived from the TAP 14 spec:
> https://testanything.org/tap-version-14-specification.html.

It is convenient that "# Subtest: <name>" is compatible with v1, but I think
that there is a negative that overrides the convenience.

The "# Subtest: <name>" syntax means that we need to restrict the format of
diagnostic lines, such that "#Subtest:" is an illegal diagnostic, at least
for the line immediately following the Version line.

I think it would be cleaner to modify the Version line syntax to be:

  KTAP version 2 [# <subtest_name>]

I notice that the KTAP Specification version 1 fails to specify the
Version line syntax.  So the Specification would be updated from:

  All KTAP-formatted results begin with a "version line" which specifies which
  version of the (K)TAP standard the result is compliant with.

  For example:
  - "KTAP version 1"
  - "TAP version 13"
  - "TAP version 14"

to:

  The Version line is required and must have the format:

  .. code-block:: none

        KTAP version 2 [# <subtest_name>]

  All KTAP-formatted results begin with a "version line" which specifies which
  version of the (K)TAP standard the result is compliant with.

  For example:
  - "KTAP version 2"
  - "TAP version 13"
  - "TAP version 14"

> 
> Recognition of this line would create an accepted way for different test
> frameworks to declare the name of a test before its results.
> 
> The proposed location for this line is between the version line and the
> test plan line. This location ensures that the line would not be
> accidentally parsed as a subtest's diagnostic lines. Note this proposed
> location would be a slight differentiation from KTAP v1.
> 
> Example of test name line:
> 
>  KTAP version 2
>  # Subtest: main_test
>  1..1
>    KTAP version 2
>    # Subtest: sub_test
>    1..2
>    ok 1 test_1
>    ok 2 test_2
>  ok 1 sub_test
> 
> Here is a link to a version of the KUnit parser that is able to parse the
> test name line for KTAP version 2. Note this includes a test name line for
> the main level of KTAP.
> 
> Link: https://kunit-review.googlesource.com/c/linux/+/5709
> 
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---
> 
> This is a RFC. I would like to know what people think and use this as a
> platform for discussion on KTAP v2.
> 
> Note: this patch is based on Frank's ktap_spec_version_2 branch.
> 
>  Documentation/dev-tools/ktap.rst | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
> index ff77f4aaa6ef..9c7ed66d9f77 100644
> --- a/Documentation/dev-tools/ktap.rst
> +++ b/Documentation/dev-tools/ktap.rst
> @@ -28,8 +28,7 @@ KTAP output is built from four different types of lines:
>  In general, valid KTAP output should also form valid TAP output, but some
>  information, in particular nested test results, may be lost. Also note that
>  there is a stagnant draft specification for TAP14, KTAP diverges from this in
> -a couple of places (notably the "Subtest" header), which are described where
> -relevant later in this document.
> +a couple of places, which are described where relevant later in this document.
>  
>  Version lines
>  -------------
> @@ -44,8 +43,8 @@ For example:
>  - "TAP version 14"
>  
>  Note that, in KTAP, subtests also begin with a version line, which denotes the

> -start of the nested test results. This differs from TAP14, which uses a
> -separate "Subtest" line.

^^^^ This is an error in the KTAP Specification version 1.  TAP14 allows the case
of "Bare Subtests", which would be the equivalent of the KTAP v1 method.

> +start of the nested test results. This differs from TAP14, which uses only a
> +"Subtest" line.
>  
>  While, going forward, "KTAP version 2" should be used by compliant tests, it
>  is expected that most parsers and other tooling will accept the other versions
> @@ -166,6 +165,12 @@ even if they do not start with a "#": this is to capture any other useful
>  kernel output which may help debug the test. It is nevertheless recommended
>  that tests always prefix any diagnostic output they have with a "#" character.
>  
> +One recognized diagnostic line is the "# Subtest: <name>" line. This line
> +is used to declare the name of a test before subtest results are printed. This
> +is helpful for parsing and for providing context during crashes. As a rule,
> +this line is placed after the version line and before the plan line. Note
> +this line can be used for the main test, as well as subtests.
> +
>  Unknown lines
>  -------------
>  
> @@ -206,6 +211,7 @@ An example of a test with two nested subtests:
>  	KTAP version 2
>  	1..1
>  	  KTAP version 2
> +	  # Subtest: example
>  	  1..2
>  	  ok 1 test_1
>  	  not ok 2 test_2
> @@ -219,6 +225,7 @@ An example format with multiple levels of nested testing:
>  	KTAP version 2
>  	1..2
>  	  KTAP version 2
> +	  # Subtest: example_test_1
>  	  1..2
>  	    KTAP version 2
>  	    1..2
> @@ -245,7 +252,7 @@ allows an arbitrary number of tests to be nested     no         yes
>  
>  The TAP14 specification does permit nested tests, but instead of using another
>  nested version line, uses a line of the form
> -"Subtest: <name>" where <name> is the name of the parent test.
> +"Subtest: <name>" where <name> is the name of the parent test as discussed above.
>  
>  Example KTAP output
>  --------------------
> @@ -254,6 +261,7 @@ Example KTAP output
>  	KTAP version 2
>  	1..1
>  	  KTAP version 2
> +	  # Subtest: main_test
>  	  1..3
>  	    KTAP version 2
>  	    1..1
> @@ -266,6 +274,7 @@ Example KTAP output
>  	    ok 2 test_2
>  	  ok 2 example_test_2
>  	    KTAP version 2
> +		# Subtest: example_test_3
>  	    1..3
>  	    ok 1 test_1
>  	    # test_2: FAIL
> 
> base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5

