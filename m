Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B36678375
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 18:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjAWRkr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 12:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjAWRkq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 12:40:46 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8814D29423;
        Mon, 23 Jan 2023 09:40:45 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id CAE1582EE8;
        Mon, 23 Jan 2023 17:40:42 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674495645;
        bh=qxmdlCcR9Co2RfcU/X47fpU7lJJsQYY5qdJwxtMYYOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrAqqdyLrWVXza3qNBOpWHCRJREU/mW+0Mekj412XD7VpxTC+SDiKmjea0A4+/+mg
         YvoVfE5bvwFzahjEO4EGOQn1JXbnd9EPXJeTAdOV1sqUeZkFIdY4WbZTAsPFK0TF+W
         7WAWOHOMdzsrw1G3UX+FVzBgdWFSLhLkeFBtVCbYpBqu371uyQKUBvE10Xoeb9tgOe
         1LbTvMFyV/YD9BbcJ6BU/KkaDNAMPP3Tr5XuCf7HnR56DfVDfMh9NL9VANSZIVjwkJ
         kiUQzNG7Rm6W+ptYm2s7kmNgZmgmmfVsFOXn6nnTAF5eG+sup8vIiPqaS5pwH4VTpd
         OT4mCXiq6VB8w==
Date:   Tue, 24 Jan 2023 00:40:38 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <Y87GlhFxz+ZsKR3X@biznet-home.integral.gnuweeb.org>
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230121213455.GA16121@1wt.eu>
 <Y868lIin0bLM9HfM@biznet-home.integral.gnuweeb.org>
 <20230123172016.GB13172@1wt.eu>
 <Y87EVVt431Wx2zXk@biznet-home.integral.gnuweeb.org>
 <20230123173707.GC13172@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123173707.GC13172@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 23, 2023 at 06:37:07PM +0100, Willy Tarreau wrote:
> Ah cool! I looked for something like this on a remote ubuntu system but
> failed to figure it out by myself. Do you also have the other archs with
> it ?

Yes, they come with many architectures.

$ ls /usr/bin/qemu-* | cat
/usr/bin/qemu-aarch64
/usr/bin/qemu-aarch64_be
/usr/bin/qemu-alpha
/usr/bin/qemu-arm
/usr/bin/qemu-armeb
/usr/bin/qemu-cris
/usr/bin/qemu-hexagon
/usr/bin/qemu-hppa
/usr/bin/qemu-i386
/usr/bin/qemu-img
/usr/bin/qemu-io
/usr/bin/qemu-m68k
/usr/bin/qemu-microblaze
/usr/bin/qemu-microblazeel
/usr/bin/qemu-mips
/usr/bin/qemu-mips64
/usr/bin/qemu-mips64el
/usr/bin/qemu-mipsel
/usr/bin/qemu-mipsn32
/usr/bin/qemu-mipsn32el
/usr/bin/qemu-nbd
/usr/bin/qemu-nios2
/usr/bin/qemu-or1k
/usr/bin/qemu-ppc
/usr/bin/qemu-ppc64
/usr/bin/qemu-ppc64le
/usr/bin/qemu-pr-helper
/usr/bin/qemu-riscv32
/usr/bin/qemu-riscv64
/usr/bin/qemu-s390x
/usr/bin/qemu-sh4
/usr/bin/qemu-sh4eb
/usr/bin/qemu-sparc
/usr/bin/qemu-sparc32plus
/usr/bin/qemu-sparc64
/usr/bin/qemu-storage-daemon
/usr/bin/qemu-system-i386
/usr/bin/qemu-system-x86_64
/usr/bin/qemu-system-x86_64-microvm
/usr/bin/qemu-system-x86_64-spice
/usr/bin/qemu-x86_64
/usr/bin/qemu-xtensa
/usr/bin/qemu-xtensaeb

> Great. And without sudo you should see two of them fail. I intend to
> implement geteuid() and condition their result to it, that will be
> sufficient for most cases. I'd rather avoid seeing users run test
> programs under sudo actually, since they're run on the local system :-/

I see.

-- 
Ammar Faizi

