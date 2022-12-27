Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B86656E12
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 19:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiL0StR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 13:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiL0StQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 13:49:16 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF8A5CE15;
        Tue, 27 Dec 2022 10:49:14 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2BRIn2ro006300;
        Tue, 27 Dec 2022 19:49:02 +0100
Date:   Tue, 27 Dec 2022 19:49:02 +0100
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
Message-ID: <20221227184902.GA6287@1wt.eu>
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
 <20221222043452.GB29086@1wt.eu>
 <20221222134615.3535422-1-ammar.faizi@intel.com>
 <20221227062640.GA5337@1wt.eu>
 <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 27, 2022 at 08:32:57PM +0700, Ammar Faizi wrote:
> > Thus now my focus will be on storing these variables where relevant
> > for all archs, so that your getauxval() implementation works on top
> > of it. It will be much cleaner and will also improve programs' ease
> > of implementation and reliability.
> 
> Are you going to wire up a patchset for it?
>
> If so, I'll wait for it. When it's already committed, I'll base this
> series on top it.
> 
> Or I take your series locally then submit your patches and mine in a
> single series.
> 
> What do you prefer?

I'll try to do it but do not want to make you wait too long in case it
gets delayed. In the worst case we should only postpone the getauxval()
patch and not the other ones.

BTW, do you think your arch-specific changes for sigaction() will be
easily portable to other architectures ? I feel a bit wary of starting
to have different features per architecture given the purpose of the
lib, so the more uniform the coverage the better.

I'll get back to you soon.

Thanks,
Willy
