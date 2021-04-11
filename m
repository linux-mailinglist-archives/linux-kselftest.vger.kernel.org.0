Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B0C35B644
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Apr 2021 19:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhDKRFt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 11 Apr 2021 13:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbhDKRFt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Apr 2021 13:05:49 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F13C061574;
        Sun, 11 Apr 2021 10:05:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 534EA60C;
        Sun, 11 Apr 2021 17:05:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 534EA60C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1618160731; bh=xxK8/dr2vH+/dn7vWfea+JFsLZcrSFJ+5yc+6TLS/rc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=p/aqQdgMoq9ic8sql18EogPObNY/GxwcTjG7rG1BxWMTTSiJrxUztZrPK4oP++OGn
         VYtyiibEX417YgAlkZ6x5vinIknGdtzGryg9NI/5wFXO+v2oaSNKTWLd+Q30OaGKnq
         Cg/iSxQLHHsZfUd6oU0doM5bB189DbDParIIaVO6v2Pyk8XtN0mTzFxuQR9UqjcPBb
         5n9RVwnhYM8RaMAOrrXU2JWkN+eiSpyLKSndLHdXdVomdL3bCPOPrIvi8lDXMVXjCu
         PVK7k19yXEXMI7EpNllKxyX+NA8hdI3N9h/w5aau4WkRmdbkQm7TCq03nqYdv7PR3P
         ruSR5ouTYTlFg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, linux-doc@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: dev-tools: Add Testing Overview
In-Reply-To: <20210410070529.4113432-1-davidgow@google.com>
References: <20210410070529.4113432-1-davidgow@google.com>
Date:   Sun, 11 Apr 2021 11:05:29 -0600
Message-ID: <87zgy4vjja.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A nit but

> +The bulk of kernel tests are written using either the :doc:`kselftest
> +<kselftest>` or :doc:`KUnit <kunit/index>` frameworks. These both provide
> +infrastructure to help make running tests and groups of tests easier, as well
> +as providing helpers to aid in writing new tests.

If you just mention the relevant file, the docs build will make links
for you...so just "Documentation/dev-tools/kselftest.rst" rather than
the :doc: directive.  That helps to improve the readability of the
plain-text documentation as well.

> +`KUnit` tests therefore are best written against small, self-contained parts
> +of the kernel, which can be tested in isolation. This aligns well with the
> +concept of Unit testing.

If you want literal text, you need a double backtick: ``KUnit``.
Otherwise I'd just use normal quotes.

Thanks,

jon
