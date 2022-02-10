Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB734B142B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 18:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbiBJRZj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 12:25:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbiBJRZj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 12:25:39 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB5DF16
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 09:25:39 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 9so8260553iou.2
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 09:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UPMqvN4jQljY67pyJcK3Q/6I1X+yzjPk4U0IfC3Vs0c=;
        b=H+ARLaHwierRXfOETCvqJs50LUzTTeiFI57HRolyisN1dNCC/7gz05sL1LcchQZrW3
         BYkMAI9HCiRXbWMQig1dhJIhKhCh2GswKdUH8yacBqqYFIBTA+Tf6r4XpHFoKidCig4E
         FV6hb85CaDRJt/OhQVnV0nzSHWBlHjw0HYuTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UPMqvN4jQljY67pyJcK3Q/6I1X+yzjPk4U0IfC3Vs0c=;
        b=jTYn5S6/U1raGZ3LWNszJ5o2xtkQxGXoy2P1geeQB/h0cDDAcgXsFBOWMrg5VLVNj1
         gcv8VwiRaCWhnSmsJ4t8HJbLZUrbhfOmvQicwf/6LigikOAb2MxoXsr72ei6uGen3+IB
         Rjaseq/v41xiEovbA7q22xgA6DaN18HUoVPNW1blBQuY8dRbxIX23/5iZ6mKKYAyM++H
         1xLrrAB6p2aoZCUZ5x8sUccpRPa/GdZwg3kBK4HmyhhDR8RZRHLXNb4RbUXFw3ADbEV7
         L7lVyNmPLXdgl+eJYwTIEcpRLzgjrWGsc4DpxWjP+wSrSYjx6Bm/vdEVx9zTAh1HU79T
         JYsQ==
X-Gm-Message-State: AOAM531E0ClqmgiLaiVrmUS3CVU/0T7HStPuhsOZm0RtAVqxn2x28Q3p
        OjEEiq7EIZRV1oWWx+bTDyitSQ==
X-Google-Smtp-Source: ABdhPJxPlU8rUQRk15NzmGAuikhDY3zdRTWVh9lnLYdokC/d5/P/J94kSjat5l/npQWX9CtrNGv4Xg==
X-Received: by 2002:a02:cd0a:: with SMTP id g10mr4556252jaq.223.1644513937925;
        Thu, 10 Feb 2022 09:25:37 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id n23sm11557642ioo.55.2022.02.10.09.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 09:25:37 -0800 (PST)
Subject: Re: [PATCH v4 2/2] Documentation: dev-tools: fix KTAP specification
 build warnings
To:     frowand.list@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Tim.Bird@sony.com, Brendan Higgins <brendanhiggins@google.com>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220210023519.3221051-1-frowand.list@gmail.com>
 <20220210023519.3221051-3-frowand.list@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d09b0054-b96f-3d3f-5b33-853994723c3a@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 10:25:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220210023519.3221051-3-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/9/22 7:35 PM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Convert "Major differences between TAP and KTAP" from a bullet list
> to a table.  The bullet list was being formatted as a single
> paragraph.
> 
> Add missing required argument in code-block directives.
> 
> ---
> 
> Table conversion suggested by Shuah.
> 
> Patch 2/2 not previously reviewed, so Reviewed-by tags not provided.
> 
> Changes since version 3
>    - Add this commit (patch 2/2) to the series
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>   Documentation/dev-tools/ktap.rst | 33 +++++++++++++++++---------------
>   1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
> index dfb3f10a8b2d..5ee735c6687f 100644
> --- a/Documentation/dev-tools/ktap.rst
> +++ b/Documentation/dev-tools/ktap.rst
> @@ -68,7 +68,7 @@ Test case result lines
>   Test case result lines indicate the final status of a test.
>   They are required and must have the format:
>   
> -.. code-block::
> +.. code-block:: none
>   
>   	<result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
>   
> @@ -117,32 +117,32 @@ separator.
>   
>   Example result lines include:
>   
> -.. code-block::
> +.. code-block:: none
>   
>   	ok 1 test_case_name
>   
>   The test "test_case_name" passed.
>   
> -.. code-block::
> +.. code-block:: none
>   
>   	not ok 1 test_case_name
>   
>   The test "test_case_name" failed.
>   
> -.. code-block::
> +.. code-block:: none
>   
>   	ok 1 test # SKIP necessary dependency unavailable
>   
>   The test "test" was SKIPPED with the diagnostic message "necessary dependency
>   unavailable".
>   
> -.. code-block::
> +.. code-block:: none
>   
>   	not ok 1 test # TIMEOUT 30 seconds
>   
>   The test "test" timed out, with diagnostic data "30 seconds".
>   
> -.. code-block::
> +.. code-block:: none
>   
>   	ok 5 check return code # rcode=0
>   
> @@ -202,7 +202,7 @@ allowed to be either indented or not indented.
>   
>   An example of a test with two nested subtests:
>   
> -.. code-block::
> +.. code-block:: none
>   
>   	KTAP version 1
>   	1..1
> @@ -215,7 +215,7 @@ An example of a test with two nested subtests:
>   
>   An example format with multiple levels of nested testing:
>   
> -.. code-block::
> +.. code-block:: none
>   
>   	KTAP version 1
>   	1..2
> @@ -234,12 +234,15 @@ An example format with multiple levels of nested testing:
>   Major differences between TAP and KTAP
>   --------------------------------------
>   
> -Note the major differences between the TAP and KTAP specification:
> -- yaml and json are not recommended in KTAP diagnostic messages
> -- TODO directive not recognized in KTAP
> -- KTAP allows for an arbitrary number of tests to be nested
> -- TAP includes "Unknown lines" in the category of "Anything else"
> -- TAP says "Unknown lines" are "incorrect"; KTAP allows "Unknown lines"
> +==================================================   =========  ===============
> +Feature                                              TAP        KTAP
> +==================================================   =========  ===============
> +yaml and json in diagnosic message                   ok         not recommended
> +TODO directive                                       ok         not recognized
> +allows an arbitrary number of tests to be nested     no         yes
> +"Unknown lines" are in category of "Anything else"   yes        no
> +"Unknown lines" are                                  incorrect  allowed
> +==================================================   =========  ===============
>   
>   The TAP14 specification does permit nested tests, but instead of using another
>   nested version line, uses a line of the form
> @@ -247,7 +250,7 @@ nested version line, uses a line of the form
>   
>   Example KTAP output
>   --------------------
> -.. code-block::
> +.. code-block:: none
>   
>   	KTAP version 1
>   	1..1
> 

Table looks good. Thanks for adding it. The two patches could be
collapsed into one perhaps? Either way:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
