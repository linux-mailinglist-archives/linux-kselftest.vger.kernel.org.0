Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E126764522E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 03:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLGCnR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 21:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiLGCnQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 21:43:16 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E31F52174;
        Tue,  6 Dec 2022 18:43:12 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5B6EA423FD;
        Wed,  7 Dec 2022 02:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670380990;
        bh=AyqmyTETt8sSaAzP7S+Vz9Kwo2mKJ2hXybWEyJnLAYQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ab4JVNizrbEoXQnI45C6o9f0hiwOHhclv4Tm1dOFq2Xum0UFFTmtjWXN8ekJ2HFWC
         ZcjNeKD8CV5y+0aKJ82hWYK+Y8lCKfMHClY8T7jPYThDZMCYiqEd2XozGcJy5cDp6m
         eZ2JfwCPuNV0kFT2WK5Owq7om1V+r1p+G4+/rNJejsHG/LleDNkwS6jSaIsZXT9FTv
         vka5qd5KGGew9ihTRpC/IPmPJiI4E81wHTiKBeuuvDu+xrtKKXTulJ6ij1LeiS24ZO
         Ml10dwnklj2ydeZSVocRqaqbiboWXidveB0qrNOjM4FQiHztljbFknG/u3GFkjpEsa
         CnwE6lTYFxZzQ==
Message-ID: <3bc67108-9f4a-4cd7-619d-d61816625e1a@canonical.com>
Date:   Tue, 6 Dec 2022 18:43:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/2] kunit: add macro to allow conditionally exposing
 static symbols to tests
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>, brendanhiggins@google.com,
        davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, tales.aparecida@gmail.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, apparmor@lists.ubuntu.com
References: <20221207014024.340230-1-rmoar@google.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221207014024.340230-1-rmoar@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/6/22 17:40, Rae Moar wrote:
> Currently in order to test a static function, tests must be included in the
> same translation unit as the function. However, this can cause issues with
> including implementation and test code in the same file. As an alternative,
> the first patch in this series creates a macro that will set a function to
> be static or not depending on whether CONFIG_KUNIT is enabled. This allows
> the function to be visible during testing and static otherwise.
> 
> As an example, the current status quo to test static functions is:
> 
> === test.c ===
> 
> static void test_case(struct kunit *test)
> {
>    KUNIT_EXPECT_EQ(test, my_func_to_test(), 2);
> }
> 
> Then the tests are included in the implementation file as a workaround to
> the issue of testing static functions:
> 
> === implementation.c ===
> 
> static int my_func_to_test() {...}
> ...
> #include "test.c"
> 
> Instead, the function could be defined with this new macro:
> 
> === implementation.c ===
> 
> VISIBLE_IF_KUNIT int my_func_to_test() {...}
> 
> The first patch also creates a macro that will export a symbol into a kunit
> testing namespace only if CONFIG_KUNIT is enabled. This follows the logic
> above and allows symbols to be conditionally exported based on the testing
> status.
> 
> The second patch in the series updates the policy_unpack test in AppArmor
> to show an example of how to use both of these macros in order to address
> the issue of testing static functions. Additionally, the patch allows the
> policy_unpack test to be built as a module.
> 
> Changes since v2:
>   - Add mention of namespacing symbols to the commit message of the
>     second patch.
>   - Change module name in the second patch from policy_unpack_test to
>     apparmor_policy_unpack_test.
> 
> Changes since v1:
>   - Changed the namespace of exported symbols for the apparmor
>     policy_unpack_test by adding the aa_ prefix.
>   - Separated the documentation comments for macros in
>     include/kunit/visibility.h.
>   - Changed copyright date and author for include/kunit/visibility.h.
> 
> Rae Moar (2):
>    kunit: add macro to allow conditionally exposing static symbols to
>      tests
>    apparmor: test: make static symbols visible during kunit testing
> 
>   include/kunit/visibility.h                |  33 +++
>   security/apparmor/Kconfig                 |   4 +-
>   security/apparmor/Makefile                |   3 +
>   security/apparmor/include/policy_unpack.h |  50 +++++
>   security/apparmor/policy_unpack.c         | 238 ++++++++++------------
>   security/apparmor/policy_unpack_test.c    |  69 ++++---
>   6 files changed, 229 insertions(+), 168 deletions(-)
>   create mode 100644 include/kunit/visibility.h
> 
> 
> base-commit: 0f08f3e2a0186dfb8e33cb46105228eb18448a0e

thanks Rae,

looks good to me, David unless you tell me otherwise I assume this is
still going in via the kselftest/kunit tree.

