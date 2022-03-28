Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E8A4EA118
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 22:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbiC1UEe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 16:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiC1UEd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 16:04:33 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27D83BA5E;
        Mon, 28 Mar 2022 13:02:52 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 47C3E37A;
        Mon, 28 Mar 2022 20:02:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 47C3E37A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1648497772; bh=PwIBFic52cB+8cV6Ms4Smf/K/c9Y0vVMor8KDA0YN2c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=k0xDbu41Pd0W0r93jSo7/AJ7ki4ya8GQbyZgUmEkPeyKGxfaG9oZGu3jCV2gnVR5k
         WEPyPkuKiwawV2DwNKfy4R79Ba/VXT/lpm5iWEJj0fJsmM7huBYJlDkByq7pZLFXO8
         l5qLkfHUQlIuFeFSg+9JD9rNTzIZMMlRd2qhsjkawHcLnwev4QnmRzIWSWekooKQgJ
         YitPxnxFVB8hjUUp6Fbq3U3pdQw+YuPyohNG3gavAnOnTn6WfQ1dpQFbUgKFMjIJbY
         9oOKg7aIK+SzBfORYABsnkVU0ahODzR8+UP+/73O8gr8FcR8WXYrOQ/v7FgSDpqXNx
         /0DSV5XcbxGZQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>, Marco Elver <elver@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kunit: Fix cross-referencing warnings
In-Reply-To: <20220326054414.637293-1-davidgow@google.com>
References: <20220326054414.637293-1-davidgow@google.com>
Date:   Mon, 28 Mar 2022 14:02:51 -0600
Message-ID: <87r16l7slw.fsf@meer.lwn.net>
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

David Gow <davidgow@google.com> writes:

> The Architecture chapter of the KUnit documentation tried to include
> copies of the kernel-doc for a couple of things, despite these already
> existing in the API documentation. This lead to some warnings:
>
> architecture:31: ./include/kunit/test.h:3: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:66.
> Declaration is '.. c:struct:: kunit_case'.
> architecture:163: ./include/kunit/test.h:1217: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:1217.
> Declaration is '.. c:macro:: KUNIT_ARRAY_PARAM'.
> architecture.rst:3: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:66.
> Declaration is '.. c:struct:: kunit_case'.
> architecture.rst:1217: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:1217.
> Declaration is '.. c:macro:: KUNIT_ARRAY_PARAM'.
>
> Get rid of these, and cleanup the mentions of the struct and macro in
> question so that sphinx generates a link to the existing copy of the
> documentation in the api/test document.
>
> Fixes: bc145b370c ("Documentation: KUnit: Added KUnit Architecture")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  Documentation/dev-tools/kunit/architecture.rst | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)

Applied, thanks.

jon
