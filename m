Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6D57223BA
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 12:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjFEKoR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 06:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFEKoQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 06:44:16 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D9FDB;
        Mon,  5 Jun 2023 03:44:05 -0700 (PDT)
Date:   Mon, 5 Jun 2023 12:44:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685961843; bh=QVXyqBCquC6KdHJ2hKV41XXOd2PcXVnhiGJ6lkZSGh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFoLM42HarKpIpgmpD0JvmgFXbHhALDzJteiBvE43G4AM8jHPZSHw2XiCkwSZznMO
         P+3A6rextkavC9qqPSIqlJC0tc40q5JXwtRxCce+UWa6B8DWTHzUDC4pw7de2H6KF3
         kSr2ok55U33JsNJrUcfSWUUsiJ1K5/y9pKwzPSlY=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: nolibc patches, still possible for 6.5 ?
Message-ID: <1fc53bcf-f7ec-4d74-a984-da4ee38e938f@t-8ch.de>
References: <ZHyPi29q3MKiNAQZ@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHyPi29q3MKiNAQZ@1wt.eu>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NO_DNS_FOR_FROM,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-04 15:20:11+0200, Willy Tarreau wrote:
> Hello Paul,
> 
> Thomas and Zhangjin have provided significant nolibc cleanups, and
> fixes, as well as preparation work to later support riscv32.
> 
> These consist in the following main series:
>   - generalization of stackprotector to other archs that were not
>     previously supported (riscv, mips, loongarch, arm, arm64)
> 
>   - general cleanups of the makefile, test report output, deduplication
>     of certain tests
> 
>   - slightly better compliance of some tests performed on certain syscalls
>     (e.g. no longer pass (void*)1 to gettimeofday() since glibc hates it).
> 
>   - add support for nanoseconds in stat() and statx()
> 
>   - fixes for some syscalls (e.g. ppoll() has 5 arguments not 4)
> 
>   - fixes around limits.h and  INT_MAX / INT_FAST64_MAX
> 
> I rebased the whole series on top of your latest dev branch (d19a9ca3d5)
> and it works fine for all archs.
> 
> I don't know if you're still planning on merging new stuff in this area
> for 6.5 or not (since I know that it involves new series of tests on your
> side as well), but given that Zhangjin will engage into deeper changes
> later for riscv32 that will likely imply to update more syscalls to use
> the time64 ones, I would prefer to split the cleanups from the hard stuff,
> but I'll let you judge based on the current state of what's pending for
> 6.5.
> 
> In any case I'm putting all this here for now (not for merge yet):
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git 20230604-nolibc-rv32+stkp6
> 
> I'd like Thomas and Zhangjin to perform a last check to confirm they're
> OK with this final integration.

(Talking about 20230605-nolibc-rv32+stkp7,
but the same issue is in stkp6)

I noticed that the commit introducing prctl() comes *after* the one
making use of it.

8389cb4b55ae ("selftests/nolibc: prevent coredumps during test execution")
033c01b5a8f4 ("tools/nolibc: add support for prctl()")

This can lead to compiler errors and break bisectability.

They just need to be swapped.

Thomas
