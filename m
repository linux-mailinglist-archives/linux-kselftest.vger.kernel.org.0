Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02385721AEE
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 00:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjFDW55 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 18:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjFDW54 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 18:57:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB7FCD;
        Sun,  4 Jun 2023 15:57:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 326E160A4D;
        Sun,  4 Jun 2023 22:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9771DC433D2;
        Sun,  4 Jun 2023 22:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685919474;
        bh=8XjDS4iDM+8yMwrflnTpmcp6OBQrO3wSWyu/IjlMnOc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=K86udc3+sYRhmGHEjKvJPbToeCeRxFc0MjWBTRcq539T9stICCyuW92bLfxV1iTVg
         2WM3n+1my2y1PFF0NB5x9MNslxvHye86tnDkCE859zck65NB15+Td/UB0bmjHnFRvj
         3XiYImin54MjZtR+AHKGPaWpesFj3Z2SNRE1HOcusFCgSi74QVtQErspj2TqTYmGXI
         1dVoXk1qOu9MOroz1Tdk7WujTGRBd2Teb8DQT3Y/syt8IlJ5U9w+0BNN9VaDUSvRgR
         e4fRVaCuDSgnYiW9sF+k8q2p7gOtBff3Kz7gTBUeGTXysdWq9iamy3FnLdjejQ8KbH
         VREF+Ov4ueWmA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2957CCE04DD; Sun,  4 Jun 2023 15:57:54 -0700 (PDT)
Date:   Sun, 4 Jun 2023 15:57:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, thomas@t-8ch.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: nolibc patches, still possible for 6.5 ?
Message-ID: <5494ac68-b4b9-434f-92c1-7e197c92a4ab@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZHyPi29q3MKiNAQZ@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHyPi29q3MKiNAQZ@1wt.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 04, 2023 at 03:20:11PM +0200, Willy Tarreau wrote:
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

Given that the testing converges by the end of this week, I can't see
any reason why these cannot make v6.5.  (There were some kernel test
robot complaints as well, valid or not I am not sure.)

							Thanx, Paul
