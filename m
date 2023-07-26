Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E60C7639AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 16:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjGZO5c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 10:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjGZO50 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 10:57:26 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9887E2135;
        Wed, 26 Jul 2023 07:57:25 -0700 (PDT)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4R9xnw6mN0z9sp2;
        Wed, 26 Jul 2023 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1690383445; bh=SRkpeWDGsQ784tK+v68bqnUs+FhdczWP/bjri3n67bo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sNVeMPF9guconmmPZdlmFRyoHTgCJpHYzx6J7IyxcBUvQpZedPDCo1UdSH/IUxmxx
         lq6m9KeBsAMMxay2kAniYTHl4nr1YOuFuXhE2re9ye/JKLAY8KnmNQ7e9Ht39k6JPg
         6S/Q+bJMcT9b1eJzD0poW8oPU/X2gvNeGwYG5Kf0=
X-Riseup-User-ID: 5AD1C4D2966B104ABA09EAD525D21483029186B6F508999D2097E4A938347020
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4R9xnr6ZhkzJntF;
        Wed, 26 Jul 2023 14:57:20 +0000 (UTC)
Message-ID: <1dd25d94-a714-5996-dd33-dfa9d1a95307@riseup.net>
Date:   Wed, 26 Jul 2023 11:57:19 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/9] kunit: Add test attributes API
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>, shuah@kernel.org, davidgow@google.com,
        dlatypov@google.com, brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
References: <20230725212522.1622716-1-rmoar@google.com>
From:   Arthur Grillo Queiroz Cabral <arthurgrillo@riseup.net>
In-Reply-To: <20230725212522.1622716-1-rmoar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 25/07/23 18:25, 'Rae Moar' via KUnit Development wrote:
> Hello everyone,
> 
> This patch series adds a test attributes framework to KUnit.
> 
> There has been interest in filtering out "slow" KUnit tests. Most notably,
> a new config, CONFIG_MEMCPY_SLOW_KUNIT_TEST, has been added to exclude a
> particularly slow memcpy test
> (https://lore.kernel.org/all/20230118200653.give.574-kees@kernel.org/).
> 
> This attributes framework can be used to save and access test associated
> data, including whether a test is slow. These attributes are reportable
> (via KTAP and command line output) and are also filterable.
> 
> This framework is designed to allow for the addition of other attributes in
> the future. These attributes could include whether the test can be run
> concurrently, test file path, etc.
> 
> To try out the framework I suggest running:
> "./tools/testing/kunit/kunit.py run --filter speed!=slow"
> 
> This patch series was originally sent out as an RFC. Here is a link to the
> RFC v2:
> https://lore.kernel.org/all/20230707210947.1208717-1-rmoar@google.com/
> 
> Thanks!
> Rae
> 

Great addition to the KUnit framework!

On all the patch set

Reviewed-by: Arthur Grillo <arthurgrillo@riseup.net>

Best Regards,
~Arthur Grillo

> Rae Moar (9):
>   kunit: Add test attributes API structure
>   kunit: Add speed attribute
>   kunit: Add module attribute
>   kunit: Add ability to filter attributes
>   kunit: tool: Add command line interface to filter and report
>     attributes
>   kunit: memcpy: Mark tests as slow using test attributes
>   kunit: time: Mark test as slow using test attributes
>   kunit: add tests for filtering attributes
>   kunit: Add documentation of KUnit test attributes
> 
>  Documentation/dev-tools/kunit/run_wrapper.rst |  12 +
>  .../dev-tools/kunit/running_tips.rst          | 166 +++++++
>  include/kunit/attributes.h                    |  50 +++
>  include/kunit/test.h                          |  70 ++-
>  kernel/time/time_test.c                       |   2 +-
>  lib/Kconfig.debug                             |   3 +
>  lib/kunit/Makefile                            |   3 +-
>  lib/kunit/attributes.c                        | 418 ++++++++++++++++++
>  lib/kunit/executor.c                          | 114 ++++-
>  lib/kunit/executor_test.c                     | 128 +++++-
>  lib/kunit/kunit-example-test.c                |   9 +
>  lib/kunit/test.c                              |  27 +-
>  lib/memcpy_kunit.c                            |   8 +-
>  tools/testing/kunit/kunit.py                  |  70 ++-
>  tools/testing/kunit/kunit_kernel.py           |   8 +-
>  tools/testing/kunit/kunit_parser.py           |  11 +-
>  tools/testing/kunit/kunit_tool_test.py        |  39 +-
>  17 files changed, 1062 insertions(+), 76 deletions(-)
>  create mode 100644 include/kunit/attributes.h
>  create mode 100644 lib/kunit/attributes.c
> 
> 
> base-commit: 64bd4641310c41a1ecf07c13c67bc0ed61045dfd
