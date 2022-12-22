Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5E7653B52
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Dec 2022 05:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiLVEfN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Dec 2022 23:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLVEfM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Dec 2022 23:35:12 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CF5714D04;
        Wed, 21 Dec 2022 20:35:10 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2BM4Yq2T029352;
        Thu, 22 Dec 2022 05:34:52 +0100
Date:   Thu, 22 Dec 2022 05:34:52 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH v1 0/8] nolibc signal handling support
Message-ID: <20221222043452.GB29086@1wt.eu>
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222035134.3467659-1-ammar.faizi@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ammar,

On Thu, Dec 22, 2022 at 10:51:26AM +0700, Ammar Faizi wrote:
> From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> 
> Hi,
> 
> This series adds signal handling support to the nolibc subsystem.
(...)

Thank you! I'll have a look at this this week-end.
I noticed one thing that we'll need to discuss further:

> 3)  Extra nolibc updates.
> 
>     Apart from the signal handling support. This series also contains
>     nolibc updates, they are:
> 
>       - getpagesize() support.

This one relies on /proc/self/auxv, but we'll quickly run into a
chicken-and-egg situation given that nolibc is used by init programs
that mount /proc. Instead I think that we should modify the _start
code to retrieve the auxv at startup and store it somewhere. This
"somewhere" is not yet defined, but I'm thinking that it could
deserve reserving some room in the stack to store some nolibc-defined
information (possibly even a copy of a pointer to environ and/or errno)
and figure a reliable and simple way to access this. Note that one way
could also be to know that it's after the NULL that follows envp, and
to start from environ. In fact there are plenty of ways and we just
need to decide what's the least ugly. But once we have access to the
auxv from the process, then we could implement a getauxval() function
to retrieve the information you need for getpagesize().

More on this later.

Thanks!
Willy
