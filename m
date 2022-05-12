Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01ED5250FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355770AbiELPMp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 11:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355755AbiELPMg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 11:12:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7466D262660
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 08:12:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq17so10888843ejb.4
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 08:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=URAyLVGzg8Nt4aDbg3Gbees9letYmMiBHHAQBtnqWOg=;
        b=Sz0wAf/nuR9sykNUsrdx7wu/2uB9VWEK4Lk+0EPPHIb/+SAcG2B0hOLzt3zkTxVlm2
         qUeKFfx/kYDQSEfmeSdLV1eAo7/NOUosm/NjXv4hxnf/SMauHIBN0aOaZhYtou/cS+wc
         yBVTKyOdM7CxbFhx5HcdWWTryb3qhzftC9eygXuJ0vEJ8eemFtvH3cxzxYaj7f6PGOp/
         fZTfBE9PZeQdZ4SEvQcrDxPi5EUdmJkmmC+TpOzospFaxKT9QYRu1VSEb24jWIdNlwSI
         8tne8p7REzWgW2s6YRW/c6fWS4jqhxI+SfvxcFOXZsB3nXIr8x4BoVrDVfLOYcwjezDu
         zwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URAyLVGzg8Nt4aDbg3Gbees9letYmMiBHHAQBtnqWOg=;
        b=HaL6IcQGLCWjgBiBa3CgHw0LdXU1rT8sfwCNBcTJlLfokoZcXMx/t+PhaKItmFudix
         vWHXUXioR9lkXbWioDlSqA+nB1TJBR+QCayXjhd73dMarcTLVRAQibwQRmjK0CZi45qY
         Gjofl31DfkrGNs9tOP0xJLNI/DCfRAS/kpzfFlP/T6gcul0tQ9vzD6Wvu4CWaBantssN
         jGf4Qe77bi8O3cwyKrXow56CbAOK4MWymIlbfuc9Q7dG8ayN3LfQQuIntq6ebwS4Kz2B
         dRcqluw7pAptmbNX87AQ+Szx0KLJsWUHxTLfAy0lfySCeZ+nCvsNvMwBhQMuLyect5KD
         8LXA==
X-Gm-Message-State: AOAM531pOmkcBkRK6mDK5bakawLhuO6q3Zj0WSBYcEiDPKjv1xwQFQ6P
        C4UvvBZW3wtudB7CKTifT1r7mUS2pRuO2O6+8AhH+A==
X-Google-Smtp-Source: ABdhPJw39fUr46PtBbB7NV8LWUrpQykG2OQD9q5q4f8PfkT7wPGNBmgyzRQFBWCXyPCYwrmHFTqVFH1kj4wXm8EeaI0=
X-Received: by 2002:a17:907:1c06:b0:6df:b257:cbb3 with SMTP id
 nc6-20020a1709071c0600b006dfb257cbb3mr315311ejc.631.1652368353809; Thu, 12
 May 2022 08:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <bc6e9ed7-d98b-c4da-2a59-ee0915c18f10@gmail.com>
In-Reply-To: <bc6e9ed7-d98b-c4da-2a59-ee0915c18f10@gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 12 May 2022 08:12:22 -0700
Message-ID: <CAGS_qxreTLFp1VvMd07AZhE9wbgxR5bXgeJSyW-iWWoA5qs79g@mail.gmail.com>
Subject: Re: [RFC] KTAP spec v2: prefix to KTAP data
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 11, 2022 at 10:59 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> In the middle of the "RFC - kernel test result specification (KTAP)" thread,
> started in August 2021, Tim Bird made a suggestion to allow a prefix to the
> KTAP data format:
>
> > Just as a side note, in some Fuego tests, it was very useful to include an identifier
> > in thethe prefix nested tests.  The output looked like this:
> >
> > TAP version 13
> > 1..2
> > [batch_id 4] TAP version 13
> > [batch_id 4] 1..2
> > [batch_id 4] ok 1 - cyclictest with 1000 cycles
> > [batch_id 4] # problem setting CLOCK_REALTIME
> > [batch_id 4] not ok 2 - cyclictest with CLOCK_REALTIME
> > not ok 1 - check realtime
> > [batch_id 4] TAP version 13
> > [batch_id 4] 1..1
> > [batch_id 4] ok 1 - IOZone read/write 4k blocks
> > ok 2 - check I/O performance
> >
> > Can I propose that the prefix not be fixed by the spec, but that the spec indicates that
> > whatever the prefix is on the TAP version line, that prefix must be used with the output for
> > all lines from the test (with the exception of unknown lines)?

Just chiming in since I didn't see it mentioned after a quick skim of
the original thread:

This is already basically the behavior of kunit.py's TAP parser since
commit afc63da64f1e5e41875c98707020e85050f8a0c5
Author: Heidi Fahim <heidifahim@google.com>
Date:   Mon Mar 16 13:21:24 2020 -0700

    kunit: kunit_parser: make parser more robust

    Previously, kunit_parser did not properly handle kunit TAP output that
    - had any prefixes (generated from different configs e.g.
    CONFIG_PRINTK_TIME)
...

The notable difference is that only the prefix _length_ is fixed, not
the contents of the string itself.

So ignoring a dynamic prefix is a practical necessity if we want to
parse TAP from kernelspace/printk across a range of configs.
But I don't know if this dynamic version is worth including in the spec.
The static prefix makes more sense to me to formalize, and if we go
down that route, at least kunit.py will already be compliant :)

Daniel
