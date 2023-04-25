Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1FD6EE945
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 22:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjDYUza (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 16:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjDYUzF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 16:55:05 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E60D146D3;
        Tue, 25 Apr 2023 13:55:03 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-b953887e70eso8897660276.1;
        Tue, 25 Apr 2023 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682456103; x=1685048103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OU/Nt9B7XN1sCdbr/6eEb0oLClGSXdVDLD5Mdz4L6mI=;
        b=DxsvyX9FhAGMU+w31NsiCPMJpBjiSmiusOxrrqMuWc7O2JrI3lOOhib9NUZ8evbkVb
         hnpe+Dv76iu91frLgDA9nGUkKbjFzq0OvBXo0Xoy5xb+tpmzXuaDlwJQYj5J/J53DSjE
         3v3ta/aG3bSsUUMmV78xGQmvmXq8YucDwfmouyPZOA9/J4waeSO8XWxhagfzpRzcXzAI
         svko/KEuM58pa4AkiN3pHR7OQ1eIAZ26Cqn/5dxBes0BDJmsgrCcnAOUZ7nOQJVkEKW/
         7k7i8gws9nQro3wQwqHnMi1d292dOmYhyF5+UUwSdrLE7o2eARF2luNFPTWuEy0N0H2v
         xkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682456103; x=1685048103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OU/Nt9B7XN1sCdbr/6eEb0oLClGSXdVDLD5Mdz4L6mI=;
        b=M4XEUwR49qLlR/xGAC5lHZyV5JzRld8G6WbTimFJSGbGSsNHDiPVza9yWVZeBjBgHG
         IwgoIU5CT9N10MYMOrNQ0C2UTefrCx6pqJVQYXNNVoRZoxPypfqClkGWoFklGLjsxwq3
         vhWtjadVsRw5TQpndxAnidpk7is3ApMxWLmLFDKO5kmuGItulo+iHNSQOvyjn5KuRWBb
         iMZ4GZDK5lUrdfx/MLOiMPqx1TuddOBEYjZProxf4Z+6v7/VdBqdII4bjs2gtEcLTxAF
         S3OZmd1BFOM8McB1CUYa/nBIu4DyHTjcCyWX+lYs77rKzct6uruF1MQ6uC80IRk3OTZS
         lJCw==
X-Gm-Message-State: AAQBX9dD3spzdEJE7bTzrlPosc5R/TIGv/9FcQ7b4vXILcmb1WQdM3jo
        SfTqkw6ekNjbqEWgtIv2rIA=
X-Google-Smtp-Source: AKy350ZBOeq+FuyZ+QGosrfgyVeMEZ16y1tOuiCk4iWVjMIHrX23nwDvyYSFgFY7ng6MxhuoZh/xcw==
X-Received: by 2002:a25:4105:0:b0:b99:75f:8f24 with SMTP id o5-20020a254105000000b00b99075f8f24mr12009761yba.30.1682456102630;
        Tue, 25 Apr 2023 13:55:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:7dac:d9da:d59f:fcdb? ([2600:1700:2442:6db0:7dac:d9da:d59f:fcdb])
        by smtp.gmail.com with ESMTPSA id o68-20020a254147000000b00b8f5b078eacsm3687976yba.39.2023.04.25.13.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 13:55:02 -0700 (PDT)
Message-ID: <ce5b723d-2395-8974-ba62-1ee519732218@gmail.com>
Date:   Tue, 25 Apr 2023 15:55:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [KTAP V2 PATCH] ktap_v2: add test metadata
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>, davidgow@google.com,
        skhan@linuxfoundation.org, keescook@chromium.org,
        Tim.Bird@sony.com, brendanhiggins@google.com
Cc:     corbet@lwn.net, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@lists.linux.dev,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230420205734.1288498-1-rmoar@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230420205734.1288498-1-rmoar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TRACKER_ID,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/20/23 15:57, Rae Moar wrote:
> Add specification for declaring test metadata to the KTAP v2 spec.
> 
> The purpose of test metadata is to allow for the declaration of essential
> testing information in KTAP output. This information includes test
> names, test configuration info, test attributes, and test files.
> 
> There have been similar ideas around the idea of test metadata such as test
> prefixes and test name lines. However, I propose this specification as an
> overall fix for these issues.

This seems like a cleaner approach.

> 
> These test metadata lines are a form of diagnostic lines with the
> format: "# <metadata_type>: <data>". As a type of diagnostic line, test
> metadata lines are compliant with KTAP v1, which will help to not
> interfere too much with current parsers.
> 
> Specifically the "# Subtest:" line is derived from the TAP 14 spec:
> https://testanything.org/tap-version-14-specification.html.
> 
> The proposed location for test metadata is in the test header, between the
> version line and the test plan line. Note including diagnostic lines in
> the test header is a depature from KTAP v1.
> 
> This location provides two main benefits:
> 
> First, metadata will be printed prior to when subtests are run. Then if a
> test fails, test metadata can help discern which test is causing the issue
> and potentially why.
> 
> Second, this location ensures that the lines will not be accidentally
> parsed as a subtest's diagnostic lines because the lines are bordered by
> the version line and plan line.

I like that.

> 
> Here is an example of test metadata:
> 
>  KTAP version 2
>  # Config: CONFIG_TEST=y
>  1..1
>      KTAP version 2
>      # Subtest: test_suite
>      # File: /sys/kernel/...
>      # Attributes: slow
>      # Other: example_test
>      1..2
>      ok 1 test_1
>      ok 2 test_2
>  ok 1 test_suite
> 
> Here is a link to a version of the KUnit parser that is able to parse test
> metadata lines for KTAP version 2. Note this includes test metadata
> lines for the main level of KTAP.
> 
> Link: https://kunit-review.googlesource.com/c/linux/+/5809
> 
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---
> 
> Hi everyone,
> 
> I would like to use this proposal similar to an RFC to gather ideas on the
> topic of test metadata. Let me know what you think.
> 
> I am also interested in brainstorming a list of recognized metadata types.
> Providing recognized metadata types would be helpful in parsing and
> displaying test metadata in a useful way.
> 
> Current ideas:
> - "# Subtest: <test_name>" to indicate test name (name must match
>   corresponding result line)

I would prefer "Test" to "Subtest" because the type should be allowed for the
top level test, as well as for subtest levels.

> - "# Attributes: <attributes list>" to indicate test attributes (list
>   separated by commas)
> - "# File: <file_path>" to indicate file used in testing
> 
> Any other ideas?

(Already used in an example above...)

- "# Config: <config_option list> to indicate kernel configuration options
  (list separated by commas)

    config_option format:
      Option XXX is enabled: CONFIG_XXX=y
      Option XXX is not enabled: CONFIG_XXX=n
      Option XXX is text: CONFIG_XXX="a text string"

Linux .config format is "#CONFIG_XXX is not set",
but this would be harder to parse in a list.

A text config option also complicates parsing of a list.  Maybe there
should not be a list, instead have a separate "# Config:" line for
each config option.

I would like to bifurcate the name space of metadata types, to names
specified in the standard vs names not in the standard that can be
used on an experimental or for future use in existing tests.

I can think of at least two ways to implement this:

(1) types that are in the specification all begin with a specific prefix,
such as "ktap_" (bike shedding on naming welcomed), so the examples woudld be

  # ktap_test:
  # ktap_attributes:
  # ktap_file:
  # ktap_config:

(2) types that are _not_ in the specification all begin with a specific prefix,
such as "custom_" (bike shedding on naming welcomed).

> 
> Note this proposal replaces two of my previous proposals: "ktap_v2: add
> recognized test name line" and "ktap_v2: allow prefix to KTAP lines."
> 
> Thanks!
> -Rae
> 
> Note: this patch is based on Frank's ktap_spec_version_2 branch.
> 
>  Documentation/dev-tools/ktap.rst | 51 ++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
> index ff77f4aaa6ef..a2d0a196c115 100644
> --- a/Documentation/dev-tools/ktap.rst
> +++ b/Documentation/dev-tools/ktap.rst
> @@ -17,7 +17,9 @@ KTAP test results describe a series of tests (which may be nested: i.e., test
>  can have subtests), each of which can contain both diagnostic data -- e.g., log
>  lines -- and a final result. The test structure and results are
>  machine-readable, whereas the diagnostic data is unstructured and is there to
> -aid human debugging.
> +aid human debugging. One exception to this is test metadata lines - a type
> +of diagnostic lines. Test metadata is located between the version line and
> +plan line of a test and can be machine-readable.
>  
>  KTAP output is built from four different types of lines:
>  - Version lines
> @@ -28,8 +30,7 @@ KTAP output is built from four different types of lines:
>  In general, valid KTAP output should also form valid TAP output, but some
>  information, in particular nested test results, may be lost. Also note that
>  there is a stagnant draft specification for TAP14, KTAP diverges from this in
> -a couple of places (notably the "Subtest" header), which are described where
> -relevant later in this document.
> +a couple of places, which are described where relevant later in this document.
>  
>  Version lines
>  -------------
> @@ -166,6 +167,45 @@ even if they do not start with a "#": this is to capture any other useful
>  kernel output which may help debug the test. It is nevertheless recommended
>  that tests always prefix any diagnostic output they have with a "#" character.
>  
> +Test metadata lines
> +-------------------
> +
> +Test metadata lines are a type of diagnostic lines used to the declare the
> +name of a test and other helpful testing information in the test header.
> +These lines are often helpful for parsing and for providing context during
> +crashes.
> +
> +Test metadata lines must follow the format: "# <metadata_type>: <data>".
> +These lines must be located between the version line and the plan line
> +within a test header.
> +
> +There are a few currently recognized metadata types:
> +- "# Subtest: <test_name>" to indicate test name (name must match
> +  corresponding result line)
> +- "# Attributes: <attributes list>" to indicate test attributes (list
> +  separated by commas)
> +- "# File: <file_path>" to indicate file used in testing
> +
> +As a rule, the "# Subtest:" line is generally first to declare the test
> +name. Note that metadata lines do not necessarily need to use a
> +recognized metadata type.
> +
> +An example of using metadata lines:
> +
> +::
> +
> +        KTAP version 2
> +        1..1
> +        # File: /sys/kernel/...
> +          KTAP version 2
> +          # Subtest: example
> +          # Attributes: slow, example_test
> +          1..1
> +          ok 1 test_1
> +        # example passed
> +        ok 1 example
> +
> +
>  Unknown lines
>  -------------
>  
> @@ -206,6 +246,7 @@ An example of a test with two nested subtests:
>  	KTAP version 2
>  	1..1
>  	  KTAP version 2
> +	  # Subtest: example
>  	  1..2
>  	  ok 1 test_1
>  	  not ok 2 test_2
> @@ -219,6 +260,7 @@ An example format with multiple levels of nested testing:
>  	KTAP version 2
>  	1..2
>  	  KTAP version 2
> +	  # Subtest: example_test_1
>  	  1..2
>  	    KTAP version 2
>  	    1..2
> @@ -254,6 +296,7 @@ Example KTAP output
>  	KTAP version 2
>  	1..1
>  	  KTAP version 2
> +	  # Subtest: main_test
>  	  1..3
>  	    KTAP version 2
>  	    1..1
> @@ -261,11 +304,13 @@ Example KTAP output
>  	    ok 1 test_1
>  	  ok 1 example_test_1
>  	    KTAP version 2
> +            # Attributes: slow
>  	    1..2
>  	    ok 1 test_1 # SKIP test_1 skipped
>  	    ok 2 test_2
>  	  ok 2 example_test_2
>  	    KTAP version 2
> +	    # Subtest: example_test_3
>  	    1..3
>  	    ok 1 test_1
>  	    # test_2: FAIL
> 
> base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5

