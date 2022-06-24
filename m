Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C825755A1E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 21:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiFXT1H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 15:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiFXT1G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 15:27:06 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974EA48328;
        Fri, 24 Jun 2022 12:27:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9278E31A;
        Fri, 24 Jun 2022 19:27:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9278E31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656098824; bh=1Tl+2VcojDecCEW67KaGgou+vGthJ0QFAm7poWodRvk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CXbnElIJmvmgDUlbluzNCNfxDH6z6VQTD1MsHkndvrTyVlCCfxgCo8NnA6W0NQ9Pn
         hbWdzKXHBUBqTmT3zFis5EtScJ6Ul7oZ86bajW+Vp3AwUvkqzwdIhEEVlw9w92pJnt
         1hrVohDc7dr5oQ7GkAG7vwuODjxYHZbeh4x51XrtH3hNQSXdMz+8+uTa4J/y5PkznW
         SEvA9BEl6GcIUtVppCdfbwl6wh2ILydQGxiXPiUJdoaXLMal8pUsAhBj7A5RazmsS3
         jhmvQ2OiAuq2VZ/zJPD65emLvXqX1LCpiNFO657ijZ2OsN0OoKOYPC3k5gjnTylkiN
         EGsyplVXF2hKw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Harinder Singh <sharinder@google.com>,
        Tim Bird <tim.bird@sony.com>
Subject: Re: [PATCH] Documentation: kunit: eliminate code-block warnings
In-Reply-To: <20220401024707.10550-1-rdunlap@infradead.org>
References: <20220401024707.10550-1-rdunlap@infradead.org>
Date:   Fri, 24 Jun 2022 13:27:03 -0600
Message-ID: <87fsjt50c8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Fix Sphinx complaints about code-block directive missing an argument.
> For start.rst, add "none" since that is already heavily used in that
> file. For run_wrapper.rst, use the simpler "::" literal block instead.

[Sorry that this fell through the cracks; I'm never quite sure who is
going to handle kunit patches]

> dev-tools/kunit/start.rst:83: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
>
> dev-tools/kunit/run_wrapper.rst:17: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.

So which version of Sphinx are you using?  The language argument became
optional in 2.0, so you'd need to be running something pretty ancient to
see this.

Ah, I see 1.8.5 in your later message...how wedded are you to that
version?

Ostensibly we support back to 1.7, so I guess we should stick by its
rules.  But the better solution, I think, is to raise our minimum
version; I think I'll look into that shortly.

> dev-tools/kunit/run_wrapper.rst:23: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:31: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:51: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:57: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:78: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:85: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:109: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:116: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:124: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:139: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:162: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
>
> Fixes: c48b9ef1f794 ("Documentation: KUnit: Rewrite getting started")
> Fixes: 46201d47d6c4 ("Documentation: kunit: Reorganize documentation related to running tests")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Harinder Singh <sharinder@google.com>
> Cc: Tim Bird <tim.bird@sony.com>
> ---
>  Documentation/dev-tools/kunit/run_wrapper.rst |   24 ++++++++--------
>  Documentation/dev-tools/kunit/start.rst       |    2 -
>  2 files changed, 13 insertions(+), 13 deletions(-)
>
> --- linux-next-20220331.orig/Documentation/dev-tools/kunit/run_wrapper.rst
> +++ linux-next-20220331/Documentation/dev-tools/kunit/run_wrapper.rst
> @@ -14,13 +14,13 @@ tests, and formats the test results.
>  
>  Run command:
>  
> -.. code-block::
> +::

A much nicer fix for these would have been just:

  Run command::

Oh well, I've applied it.

Thanks,

jon
