Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A4263351E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 07:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiKVGNb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 01:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKVGN3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 01:13:29 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A682D743;
        Mon, 21 Nov 2022 22:13:27 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.159.196])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 274B73FA58;
        Tue, 22 Nov 2022 06:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669097604;
        bh=u5Cs/fmCOueONRwkwxKrp0/bYjN0HioEdFbc4/tJork=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=iQ6C4rJB1WvUGruFd6cAlY01lGkQCHfqpDEZXAPfaxpcL5zeHfN42fBEvspDFHlyt
         OJ5CN1ma+IN+FfffjGAvaYXb+BjkVs8jGUudZVeK5HxjH8nwu1e2iJS0PH3tE1DOfO
         6DA0ubKKbHZSsrRW7MwuBCbJ8Ws5OLwrpI0iEO1+qR3o+cfA8twqF/svZCYPHUtWT5
         fD7UEnTUw3WREZUzz6aMuw4bV32yYCf0SRCWzwRgeI7KkAg/zWdNL7cVtlq2ZccqcY
         TNwhezurXy7DAR17yaEgs3ST8NSS/f7+rCOqQqAy1p4VFGOopvz1cdhvqn/kjAQ76n
         G2K1szwF6ZTvw==
Message-ID: <d045d02c-6c8b-88d6-1dad-28e192751d38@canonical.com>
Date:   Mon, 21 Nov 2022 22:13:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 0/2] kunit: add macro to allow conditionally exposing
 static symbols to tests
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>, brendanhiggins@google.com,
        davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, tales.aparecida@gmail.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, apparmor@lists.ubuntu.com
References: <20221102175959.2921063-1-rmoar@google.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221102175959.2921063-1-rmoar@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

sorry for the delay on this

On 11/2/22 10:59, Rae Moar wrote:
> Currently in order to test a static function, tests must be included in the
> same translation unit as the function. However, this can cause issues with
> including implementation and test code in the same file. As an alternative,

And the issue is? An ugly include of C file that only happens if kunit is
built. Also that you can't make the kunit code a module but is that really
an issue?
  
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
> the issue of testing static functions.
> 
> Rae Moar (2):
>    kunit: add macro to allow conditionally exposing static symbols to
>      tests
>    apparmor: test: make static symbols visible during kunit testing
> 
>   include/kunit/visibility.h                | 32 ++++++++++
>   security/apparmor/Kconfig                 |  4 +-
>   security/apparmor/Makefile                |  2 +
>   security/apparmor/include/policy_unpack.h | 50 ++++++++++++++++
>   security/apparmor/policy_unpack.c         | 72 +++++++----------------
>   security/apparmor/policy_unpack_test.c    |  5 ++
>   6 files changed, 112 insertions(+), 53 deletions(-)
>   create mode 100644 include/kunit/visibility.h
> 
> 
> base-commit: 11e76194937b506caf1b49512c42d5c2588681d7

