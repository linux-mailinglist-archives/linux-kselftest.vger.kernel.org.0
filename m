Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B337D3A2F
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 16:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjJWO7P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 10:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjJWO7C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 10:59:02 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D35172D;
        Mon, 23 Oct 2023 07:58:57 -0700 (PDT)
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4SDdcc1yfdzDqNf;
        Mon, 23 Oct 2023 14:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1698073136; bh=0EwVX4x8/C/wp6TVJp3GOQOulro1hRYNPscctE5kWGo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=duF/zOC4tRpvihCIOFQ1Azq7UG/6zbCxA2sQjcuPPm3C55okjUmgXHl6GFHFvbpp8
         wUxRSoX9PGbZh+27k+LwPOow/yAtWKoKE6azytvFl2N7LTzsDR80G6JUcQJEyrg7Rd
         tVZoe9T1vY6/UzTMYLQoy5u8e7WbBBgKe0kYn+5s=
X-Riseup-User-ID: 78D5FF85C1AECE59B001A8F588ABCF4E6B83636AF5BBC44C7A4D11F0DD8AA434
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4SDdcW0H5gzFpWN;
        Mon, 23 Oct 2023 14:58:50 +0000 (UTC)
Message-ID: <80904787-def1-424d-abd7-e49e671b502f@riseup.net>
Date:   Mon, 23 Oct 2023 11:58:47 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] um: kunit: Add Clang support for CONFIG_GCOV
Content-Language: en-US
To:     =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
        llvm@lists.linux.dev, linux-um@lists.infradead.org,
        linux-doc@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>
References: <20231020092159.2486063-1-michal.winiarski@intel.com>
From:   Arthur Grillo <arthurgrillo@riseup.net>
In-Reply-To: <20231020092159.2486063-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 20/10/23 06:21, Michał Winiarski wrote:
> Clang uses a different set of CLI args for coverage, and the output
> needs to be processed by a different set of tools.
> Update the Makefile and add an example of usage in kunit docs.

Great change! It's great not to rely on older versions of GCC for
that.

I was able to generate coverage reports, but I have a few of things to
note:

When I ran the kunit.py it generated this warning several times:

WARNING: modpost: vmlinux (__llvm_covfun): unexpected non-allocatable section.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.

Maybe it would be great to know why this is happening.

Also, the linker consumed a lot of RAM to build the kernel with those
additional flags, but maybe this is expected :P.

Best Regards,
~Arthur Grillo

> 
> Michał Winiarski (2):
>   arch: um: Add Clang coverage support
>   Documentation: kunit: Add clang UML coverage example
> 
>  Documentation/dev-tools/kunit/running_tips.rst | 11 +++++++++++
>  arch/um/Makefile-skas                          |  5 +++++
>  2 files changed, 16 insertions(+)
> 
