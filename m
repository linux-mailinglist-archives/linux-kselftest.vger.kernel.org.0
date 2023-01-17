Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147B6670E5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 01:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjARAEq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 19:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjARAEU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 19:04:20 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B39ABF5DB;
        Tue, 17 Jan 2023 15:17:14 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id B47B47F937;
        Tue, 17 Jan 2023 23:17:10 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673997433;
        bh=PPaTURbD1g7mkfJxDqc8AFxivfwcGWlKFRRMlZyAylQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tx34+WaqDfs77RMaoY3vxBj7pfSJWKlxMrlLHFUxQ+WdNHM8tX83lJcqVXHXyahYb
         iqWBx6nxgrZJz7qwR+SdyC5m2oi1Id4Ura5GJ2YFkkpQ3Q20y5pu6NvTpsmTkwwzys
         n8U+bONK096mJko+uWVtPQQ7jAavbpf2GaoyPaMaiNwO593rALUMBJF4KF9KZ1TLas
         tDhPd7pn3FRr+H70+SfA2dT7m11zHHNGIV9OYWZRq2K5aFsYXu56KCCiLxdMjYdPQu
         JqcCTT2DptvQLhrK34egeHcW4XE9x8pm22yuzYFtu6whXYH3uqeNv+btz0nZ3WUUa6
         /1pvM0fDuFPoQ==
Date:   Wed, 18 Jan 2023 06:17:06 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] nolibc signal handling support
Message-ID: <Y8cscp3BOdAqgkAq@biznet-home.integral.gnuweeb.org>
References: <20230108135904.851762-1-ammar.faizi@intel.com>
 <20230108175842.GB18859@1wt.eu>
 <Y7sL9U1dYkuWJ8rS@biznet-home.integral.gnuweeb.org>
 <20230108184930.GC18859@1wt.eu>
 <Y8QjQnkPxVyEOxPz@biznet-home.integral.gnuweeb.org>
 <CAOG64qMcvd==jfHc22q2=n79siixqbKOxb7N8i6SXjqCJtnZpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOG64qMcvd==jfHc22q2=n79siixqbKOxb7N8i6SXjqCJtnZpw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 16, 2023 at 12:06:44AM +0700, Alviro Iskandar Setiawan wrote:
> Read the glibc sigaction implementation, it has different struct
> sigaction definitions for user and kernel too.
> 
> https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/libc_sigaction.c;h=3cbf241a5fa28296c910fa40a41b09d2b6113b05;hb=7e31d166510ac4adbf53d5e8144c709a37dd8c7a
> 
> Since nolibc compiles everything in a single translation unit, you
> can't have a different sigset_t definition. You need to copy the
> definition to nolibc header and change the type name to something else
> for internal use only.

I'll give it a try.

-- 
Ammar Faizi

