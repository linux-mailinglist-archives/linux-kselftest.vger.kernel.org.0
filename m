Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FC46C9987
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 04:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjC0CMr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Mar 2023 22:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0CMq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Mar 2023 22:12:46 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0742D4EFD;
        Sun, 26 Mar 2023 19:12:45 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bm2so5271343oib.4;
        Sun, 26 Mar 2023 19:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679883164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vEMCMLPR+Xjpl1WIVDjjcljkaYbB096H73XtZut4AIE=;
        b=h8ttn/WZlHCnNrNjpePRY0xXuYnGRBM9uD3zdQ3BDLBFJUOcCKD+7XLAXzqkYpddkg
         jCMTh+4qH0vxZglSyK/XHJKfePoNIxTCchfDLLoODWUOfEMPzO0uA3Ou2y08Jg1+CquQ
         rSBHgXtQObUdZ/dhuUJjcFARridNUoGHemYivHXVDqUWijfxCGCVr8Lwm9MBlMe+5IUb
         1T+8She3tCf2l9HAjXShKIJwkNUJCNkQGZtdcgaQNBkz8jKkZBFEzo/tGQ6lm4PVx4z1
         KjO0Y4r6/Xf3TJMPS6CtoUmAyvIzNVk5E2jV17UGRKJe9o6vNre2YnqlfHTFb7JwvxKr
         G8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679883164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEMCMLPR+Xjpl1WIVDjjcljkaYbB096H73XtZut4AIE=;
        b=LEkYr0oVa+MMLemqPopNQ57dQNgm5xjTFoAhgmJUD2wdobnuaaaZZne784IuaqreAm
         XRb1WYvGgoSpGwiwPjGJi4X6Nsp96fLANO3+TPRh80luf9LsNP8oObEkUo4qg1F+WFE2
         ljVL8WOsKGQ62uOtbCxGWhP+b7v9xGBhaa07U+sTovmF5DC0Az8re9SzA8hsH46zaIW9
         YuoVDGINqXFqOuaOu6twGQDmFDBizkRW0GX76P5l/zo1UFxVYWgPcvaXXIHd9R3thPWr
         bfk0h0usgxD3jF+O3jrX6/2tv3SOEAVN7c5c40jAZ3h3kntuikbgp68U7jl8TYh5ggQU
         OLkA==
X-Gm-Message-State: AO0yUKUO1O+QVdxzF3b10/dpHsssibTl4RklpI4vIS/Va2FuZ3WSDHnX
        BxociPlMY7lz4zR2XDi7Iec=
X-Google-Smtp-Source: AK7set+ZcGTcslKPlXsUuWQ2kqytCSF3wbKvkLhVBhilVcUsLVY9961WTiDRsPSA+mPzUZxoRQNBOQ==
X-Received: by 2002:a05:6808:2804:b0:383:f5f8:651f with SMTP id et4-20020a056808280400b00383f5f8651fmr4015166oib.55.1679883164234;
        Sun, 26 Mar 2023 19:12:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:988b:7dda:764e:c744? ([2600:1700:2442:6db0:988b:7dda:764e:c744])
        by smtp.gmail.com with ESMTPSA id m206-20020acabcd7000000b0037d7f4eb7e8sm10737093oif.31.2023.03.26.19.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 19:12:43 -0700 (PDT)
Message-ID: <5626cd99-f44a-97db-334e-99f1d62112a1@gmail.com>
Date:   Sun, 26 Mar 2023 21:12:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [KTAP V2 PATCH] ktap_v2: allow prefix to KTAP lines
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>, davidgow@google.com,
        skhan@linuxfoundation.org, keescook@chromium.org,
        Tim.Bird@sony.com, brendanhiggins@google.com
Cc:     corbet@lwn.net, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@lists.linux.dev,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230316225926.494921-1-rmoar@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230316225926.494921-1-rmoar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/16/23 17:59, Rae Moar wrote:
> Change the KTAP v2 spec to allow variable prefixes to KTAP lines,
> instead of fixed indentation of two spaces. However, the prefix must be
> constant on the same level of testing (besides unknown lines).
> 
> This was proposed by Tim Bird in 2021 and then supported by Frank Rowand
> in 2022 (see link below).
> 
> Link: https://lore.kernel.org/all/bc6e9ed7-d98b-c4da-2a59-ee0915c18f10@gmail.com/

Another link to the same thread, but expanded to show all replies in one page is:

  https://lore.kernel.org/all/bc6e9ed7-d98b-c4da-2a59-ee0915c18f10@gmail.com/T/#u

Near the top of that thread I proposed alternative 1 (essentially what Tim
originally suggested, and what Rae proposes here) and alternative 2 (with
slight variant 2b).  The overall preference seemed to be alternative 1, but
if we wanted to provide a method to provide test or system metadata then
alternative 2 might provide both a test prefix and metadata.

Alternate 1 provides the vast majority of what I need the prefix for, but
I think there has been a recent comment that it would be useful to be able
to report system metadata (sorry, I haven't found a reference for that yet).
In my case, it would be informative to use metadata to report which config
options that impact the DT unittests are enabled.

> 
> As cited in the original proposal, it is useful in some Fuego tests to
> include an identifier in the prefix. This is an example:
> 
>  KTAP version 1
>  1..2
>  [batch_id 4] KTAP version 1
>  [batch_id 4] 1..2
>  [batch_id 4] ok 1 cyclictest with 1000 cycles
>  [batch_id 4] # problem setting CLOCK_REALTIME
>  [batch_id 4] not ok 2 cyclictest with CLOCK_REALTIME
>  not ok 1 check realtime
>  [batch_id 4] KTAP version 1
>  [batch_id 4] 1..1
>  [batch_id 4] ok 1 IOZone read/write 4k blocks
>  ok 2 check I/O performance
> 
> Here is a link to a version of the KUnit parser that is able to parse
> variable length prefixes for KTAP version 2. Note that the prefix must
> be constant at the same level of testing.
> 
> Link: https://kunit-review.googlesource.com/c/linux/+/5710
> 
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---
> 
> This idea has already been proposed but I wanted to potentially
> restart the discussion by demonstrating this change can by
> implemented in the KUnit parser. Let me know what you think.
> 
> Note: this patch is based on Frank's ktap_spec_version_2 branch.
> 
>  Documentation/dev-tools/ktap.rst | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
> index ff77f4aaa6ef..ac61fdd97096 100644
> --- a/Documentation/dev-tools/ktap.rst
> +++ b/Documentation/dev-tools/ktap.rst

Some additional lines of the Spec to be updated (from my alternate 1 email,
I haven't checked the current Spec to see if these are the exact changes
needed, but at least capture the intent:

The "Version lines" format is changed from:

   KTAP version 1

to:

   [<prefix string>] KTAP version 1

The "Plan lines" format is changed from:

   "1..N"

to:

   [<prefix string>] "1..N"

The "Test case result lines" format is changed from:

   <result> <number> [<description>][ # [<directive>] [<diagnostic data>]]

to:

   [<prefix string>] <result> <number> [<description>][ # [<directive>] [<diagnostic data>]]


   <prefix content is a constant string>


I wrote (with a bit of imprecision):

  Indentation for "Nested tests" follows <prefix string>.  The indentation
  does NOT precede <prefix string>.

which was meant to imply that the two space indentation would follow the
<prefix string>.

The patch I am replying to instead replaces the two space indentation
entirely with the <prefix string>.  I think this patches' version of
indentation is superior to what I suggested.

> @@ -192,9 +192,11 @@ starting with another KTAP version line and test plan, and end with the overall
>  result. If one of the subtests fail, for example, the parent test should also
>  fail.
>  
> -Additionally, all lines in a subtest should be indented. One level of
> -indentation is two spaces: "  ". The indentation should begin at the version
> -line and should end before the parent test's result line.
> +Additionally, all lines in a subtest should be indented. The standard for one
> +level of indentation is two spaces: "  ". However, any prefix for indentation
> +is allowed as long as the prefix is consistent throughout that level of
> +testing. The indentation should begin at the version line and should end
> +before the parent test's result line.
>  
>  "Unknown lines" are not considered to be lines in a subtest and thus are
>  allowed to be either indented or not indented.

I was a little more verbose about "Unknown lines":

   "Unknown lines" may optionally be prefixed with the <prefix string>, but
   are not required to be prefixed with the <prefix string>.  It is allowed
   for some "Unknown lines" to not be prefixed with the <prefix string>, even
   if one or more other "Unknown lines" are prefixed with the <prefix string>.

I think combining the intent ("not considered to be lines in a subtest") with
the extra verbosity would be useful.

> @@ -229,6 +231,19 @@ An example format with multiple levels of nested testing:
>  	not ok 1 example_test_1
>  	ok 2 example_test_2
>  
> +An example of a test with two nested subtests using prefixes:
> +
> +::
> +
> +	KTAP version 2
> +	1..1
> +	[prefix_1] KTAP version 2
> +	[prefix_1] 1..2
> +	[prefix_1] ok 1 test_1
> +	[prefix_1] ok 2 test_2
> +	# example passed
> +	ok 1 example
> +

The "[" and "]" are meant to indicate an optional field, so the
example would be:

+	KTAP version 2
+	1..1
+	prefix_1 KTAP version 2
+	prefix_1 1..2
+	prefix_1 ok 1 test_1
+	prefix_1 ok 2 test_2
+	# example passed
+	ok 1 example
+

Of course, "[" and "]" are valid characters within the prefix string, so
that an example of "[prefix_1]" could be mentioned as a valid example.

I would suggest some additional more complex examples:

+	prefix_0 KTAP version 2
+	prefix_0 1..1
+	prefix_0 prefix_1 KTAP version 2
+	prefix_0 prefix_1 1..2
+	prefix_0 prefix_1 ok 1 test_1
+	prefix_0 prefix_1 ok 2 test_2
+	# example passed
+	prefix_0 ok 1 example
+

+	KTAP version 2
+	1..2
+	prefix_1 KTAP version 2
+	prefix_1 1..2
+	prefix_1 ok 1 test_a_1
+	prefix_1 ok 2 test_a_2
+	# example passed
+	ok 1 example
+	prefix_2 KTAP version 2
+	prefix_2 1..2
+	prefix_2 ok 1 test_b_1
+	prefix_2 ok 2 test_b_2
+	# example passed
+	ok 2 example
+

+	KTAP version 2
+	1..3
+	prefix_1 KTAP version 2
+	prefix_1 1..2
+	prefix_1 ok 1 test_a_1
+	prefix_1 ok 2 test_a_2
+	# example passed
+	ok 1 example
+	  KTAP version 2
+	  1..2
+	  ok 1 test_b_1
+	  ok 2 test_b_2
+	# example passed
+	ok 2 example
+	prefix_2 KTAP version 2
+	prefix_2 1..2
+	prefix_2 ok 1 test_c_1
+	prefix_2 ok 2 test_c_2
+	# example passed
+	ok 3 example
+



>  
>  Major differences between TAP and KTAP
>  --------------------------------------
> 
> base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5

