Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6991C5259E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 May 2022 05:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376670AbiEMDF4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 23:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376669AbiEMDFt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 23:05:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9E95FE7;
        Thu, 12 May 2022 20:05:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KztnF5GpFz4xR7;
        Fri, 13 May 2022 13:05:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1652411138;
        bh=fC2GGkZ6i1/eN+A/UO95n84TneECFcVdKhwj/auxTZY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qw7Q0Cqcx1/V91zdI8RMOi066QNsHEmIm/HkytZtdFLlJiZS0bty8HG2DknIg2KS2
         bHAixUSeOjosvQtCQcFczSNbz47Xdrkd6A3ky+O1VBL+uqCXriZ1ObHk+1DaUGAuJD
         AIVYtmLDi6fvIwFaU5mfbQYg5gj2dBlKc5KhhVlowKVaR/ogRLkvE62CPYKtCdUhpc
         5xY7/Wfpty5Q/N1GbClkBwlxz9x/eWytE4g6oDudmm0W54UREbC3VzBjLtGrkzDPVN
         Z/51MUN26hOvXoSMLyZtv0ifr38DtuhcBFi0i62RYOtchm3Fw3lYoTVP7fTY9OxUG/
         zafJQ7igNgE+w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com,
        davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Subject: Re: [PATCH] lib/atomic64_test.c: convert to use KUnit
In-Reply-To: <20220502192327.81153-1-dlatypov@google.com>
References: <20220502192327.81153-1-dlatypov@google.com>
Date:   Fri, 13 May 2022 13:05:31 +1000
Message-ID: <87ilqa6sjo.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Daniel Latypov <dlatypov@google.com> writes:
> The test currently is a bunch of checks (implemented using BUG_ON())
> that can be built into the kernel or as a module.
>
> Convert it to a KUnit test, which can also run in both modes.
> From a user's perspective, this change adds a CONFIG_KUNIT=y dep and
> changes the output format of the test [1]. The test itself is the same.
...

I don't know why I got Cc'ed on this :), but I gave it a quick test anyway.

Seems to work fine on a Power9.
I also flipped some of the conditionals to make sure failure is detected
correctly.

Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)


> Meta:
> 1. this patch applies on top of the kunit branch,
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=kunit
>
> 2. checkpatch complains about aligning with parens, but it wants me to
> indent the `#ifdef CONFIG_X86_64` which seems inappropriate in context.
>
> 3. this file doesn't seem to have a clear maintainer, so I assume this
> conversion is fine to go through the kunit branch.

I think you want to at least Cc the atomic folks:

ATOMIC INFRASTRUCTURE
M:	Will Deacon <will@kernel.org>
M:	Peter Zijlstra <peterz@infradead.org>
R:	Boqun Feng <boqun.feng@gmail.com>
R:	Mark Rutland <mark.rutland@arm.com>
L:	linux-kernel@vger.kernel.org
S:	Maintained


cheers
