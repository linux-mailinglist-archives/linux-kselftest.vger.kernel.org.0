Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5EE6C98AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 01:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjCZXZj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Mar 2023 19:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCZXZi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Mar 2023 19:25:38 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511BC46B5;
        Sun, 26 Mar 2023 16:25:37 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-177ca271cb8so7559128fac.2;
        Sun, 26 Mar 2023 16:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679873136;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pD08TxzwkE2haKDmxOA3Gpocm1WKkTb8S6Or18m5HDI=;
        b=BHIGlZ8LfLq6WhYRt8wpjCAkR3hiOlJCdQ/1EO646kWQXcHyx1T4M5Klhfs0ZMHSYQ
         jF7sbzasBVM6WgyDlHhWkz0CQj9IR48vNdtKfGzrWngIuz7KvrxwMio0Otp68B4GcEXi
         3pVgJ9s4sidJyiU5KFgEVUIz0ZvvN7jZdUAKJbW9eq3mGEt1mX6vPT47FvM4/w+6Z8XF
         zoiiuywoPzy5oOcrlaNEJDwf5BwuyskUT/PvDArmq/bgepNainWGGMMBKweGmKRpmg9R
         i21B6kuEUsxuD5acvNvNLWwCStjRGjs6e/i6r4Votor0UJuG1VEnACN0h3aELcd1r15r
         tZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679873136;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pD08TxzwkE2haKDmxOA3Gpocm1WKkTb8S6Or18m5HDI=;
        b=4qjZRwY+kYcx787xiXAijokpcWTw3pxhpEWgOMIOR2USsSqfUzmzL3Ou78KVzZ0+Ve
         XXC5kUxRKldqLsnZCwM/X7gVPStulrFxOx0b4zc8UGzAT27XT11cgqZhI2r7C6W7hzyA
         GbvNFPsl3L//Gyeigf4AVkkohO1XyBN/V+wWXJ263Avh6BTROnawH50RthpmX+6tI+FW
         KBQwtMRlYCDS4Q7vNdt+tpvEF8Rp36HouJSOYCaKCCMZZcZMDDOfaT/CQNUv6aK6lovp
         Q2rL+3YOfbdIk89b1MzOlvMzVsJQzQrDTdCUtqHZPetKzP4MVmdPDXhn5OHx329Lb40Z
         /N3Q==
X-Gm-Message-State: AO0yUKWaKuO663C3HRRkjav1dJi2B5Q9RuDo/Cy3dRHgZvk08O7zwTtj
        P9enqCg7B/bXPOtejB3znFQ=
X-Google-Smtp-Source: AK7set94XwEeE93yt4ccUYZEuNyC6y3OLlLPU1LbXSURjcgfx0nxnmHzvTkY4v04hQY+OCEFCQscew==
X-Received: by 2002:a05:6870:5386:b0:176:22c5:de70 with SMTP id h6-20020a056870538600b0017622c5de70mr7019258oan.5.1679873136556;
        Sun, 26 Mar 2023 16:25:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:988b:7dda:764e:c744? ([2600:1700:2442:6db0:988b:7dda:764e:c744])
        by smtp.gmail.com with ESMTPSA id az15-20020a05687c230f00b0016a37572d17sm9383077oac.2.2023.03.26.16.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 16:25:35 -0700 (PDT)
Message-ID: <6d4afb49-3cb9-f176-61a2-5bbaab698644@gmail.com>
Date:   Sun, 26 Mar 2023 18:25:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Frank Rowand <frowand.list@gmail.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Frank Rowand <frowand.list@gmail.com>
Subject: [RFC] ktap_v2: KTAP specification transition method
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In the middle of the thread about a patch to add the skip test result,
I suggested documenting the process of deprecating the KTAP v1 Specification
method of marking a skipped test:

  https://lore.kernel.org/all/490271eb-1429-2217-6e38-837c6e5e328b@gmail.com/T/#u

In a reply to that email I suggested that we ought to have a process to transition
the KTAP Specification from v1 to v2, and possibly v3 and future.

This email is meant to be the root of that discussion.

My initial thinking is that there are at least three different types of project
and/or community that may have different needs in this area.

Type 1 - project controls both the test output generation and the test output
parsing tool.  Both generation and parsing code are in the same repository
and/or synchronized versions are distributed together.

Devicetree unittests are an example of Type 1.  I plan to maintain changes
of test output to KTAP v2 format in coordination with updating the parser
to process KTAP v2 data.

Type 2 - project controls both the test output generation and the test output
parsing tool.  The test output generation and a parser modifications may be
controlled by the project BUT there are one or more external testing projects
that (1) may have their own parsers, and (2) may have a single framework that
tests multiple versions of the tests.

I think that kselftest and kunit tests are probably examples of Type 2.  I also
think that DT unittests will become a Type 2 project as a result of converting
to KTAP v2 data.

Type 3 - project may create and maintain some tests, but is primarily a consumer
of tests created by other projects.  Type 3 projects typically have a single
framework that is able to execute and process multiple versions of the tests.

The Fuego test project is an example of Type 3.

Maybe adding all of this complexity of different Types in my initial thinking
was silly -- maybe everything in this topic is governed by the more complex
Type 3.

My thinking was that the three different Types of project would be impacted
in different ways by transition plans.  Type 3 would be the most impacted,
so I wanted to be sure that any transition plan especially considered their
needs.

There is an important aspect of the KTAP format that might ease the transition
from one version to another: All KTAP formatted results begin with a "version
line", so as soon as a parser has processed the first line of a test, it can
apply the appropriate KTAP Specification version to all subsequent lines of
test output.  A parser implementation could choose to process all versions,
could choose to invoke a version specific parser, or some other approach
all together.

In the "add skip test results" thread, I suggested deprecating the v1
method of marking a skipped test in v2, with a scheduled removal of
the v1 method in v3.  But since the KTAP format version is available
in the very first line of test output, is it necessary to do a slow
deprecation and removal over two versions?

One argument to doing a two version deprecation/removal process is that
a parser that is one version older the the test output _might_ be able
to process the test output without error, but would not be able to take
advantage of features added in the newer version of the Specification.

My opinion is that a two version deprecation/removal process will slow
the Specification update process and lead to more versions of the
Specification over a given time interval.

A one version deprecation/removal process puts more of a burden on Type 3
projects and external parsers for Type 2 projects to implement parsers
that can process the newer Specification more quickly and puts a burden
on test maintainers to delay a move to the newer Specification, or possibly
pressure to support selection of more than one Specification version format
for output data.

One additional item...  On the KTAP Specification version 2 process wiki page,
I suggested that it is "desirable for test result parsers that understand the
KTAP Specification version 2 data also be able to parse version 1 data."
With the implication "Converting version 1 compliant data to version 2 compliant
data should not require a "flag day" switch of test result parsers."  If this
thread discussion results in a different decision, I will update the wiki.

Thoughts?

-Frank
