Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124587E02AF
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 13:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346658AbjKCMRW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 08:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346442AbjKCMRV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 08:17:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B12CE;
        Fri,  3 Nov 2023 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NwSa0s/USIN07+9So8CURfAeXqMYxed0LGoxTxzaWIs=; b=BchoTeSyaSsw5YVFa0b7Ex3dB2
        ju2JfCId7dUuJE49APsnTneSoVKSrhL53EotUSuwvei7yXOReaWDMIhubsDi+lBog4vQAJJndh8DN
        +LAv7TWkcksMmHOMwcz9ucJgK1ioB2mA1Gh5pD7Y//cyET7H8VkMorvC/LBcxVfCX7/7NEQY96nij
        tTkMuEULNfhWoyNLGPiZdoMOO7Q96Io/nxiuqgkFhB/F9mf/MAaKLQujHM3sHaHvAw0UhyraxcjrC
        igy/vrquBieQzo4jS+1sevMuzzV7wSTAzquZAPk5f7/ef+olx4YXjWSzjmJAnhDVi4p6nbfd9nXVV
        z2h7jgCQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qyt6a-005IuG-3S; Fri, 03 Nov 2023 12:16:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 727F2300202; Fri,  3 Nov 2023 13:16:52 +0100 (CET)
Date:   Fri, 3 Nov 2023 13:16:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 11/11] selftests: error out if kernel header files are
 not yet built
Message-ID: <20231103121652.GA6217@noisy.programming.kicks-ass.net>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-12-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606071637.267103-12-jhubbard@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 06, 2023 at 12:16:37AM -0700, John Hubbard wrote:
> As per a discussion with Muhammad Usama Anjum [1], the following is how
> one is supposed to build selftests:
> 
>     make headers && make -C tools/testing/selftests/mm
> 
> Change the selftest build system's lib.mk to fail out with a helpful
> message if that prerequisite "make headers" has not been done yet.
> 

NAK NAK NAK

This now means I can no longer run selftests, I thank you very much! :-/

root@spr:/usr/src/linux-2.6# make O=defconfig-build/ -j64
make[1]: Entering directory '/usr/src/linux-2.6/defconfig-build'
***
*** The source tree is not clean, please run 'make mrproper'
*** in /usr/src/linux-2.6


I've always done:

  cd tools/testing/selftests/x86; make

and that has always worked

Now I can't bloody well build *any* selftest or risk not being able to
do builds.

