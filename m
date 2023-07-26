Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FFE7639AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 16:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjGZO5R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjGZO5R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 10:57:17 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E885C10F3;
        Wed, 26 Jul 2023 07:57:15 -0700 (PDT)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4R9xnl0nqPzDqV4;
        Wed, 26 Jul 2023 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1690383435; bh=SRkpeWDGsQ784tK+v68bqnUs+FhdczWP/bjri3n67bo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HLkmwiM7AO+/n1QnhDJJfGifHL72pMrSDKMTnbSJnWI963AlWF6O+XmT2fdt79Mp/
         InqSRNsj3t5eNPi0FGwFD4hsSjmo5KRAbnWQW3VVr1swhTnZYtd/p2UI13wXxngi4Q
         D9VWWfiPZoY0Kbq5kzN+sjwSCmEVt239w6YIBl7c=
X-Riseup-User-ID: A81ECEBE9F46214717655E92076DA51CF4E93B488B8BFF314C990EAF99F8AEB8
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4R9xnS16fNzJq9P;
        Wed, 26 Jul 2023 14:56:59 +0000 (UTC)
Message-ID: <e87a70f7-9b7e-e5dc-bc00-8f8ba76f0476@riseup.net>
Date:   Wed, 26 Jul 2023 11:56:57 -0300
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
