Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9BD57BC71
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 19:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiGTROo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 13:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbiGTROo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 13:14:44 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 248136F7FA;
        Wed, 20 Jul 2022 10:14:42 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26KHEWOS004283;
        Wed, 20 Jul 2022 19:14:32 +0200
Date:   Wed, 20 Jul 2022 19:14:32 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Pranith Kumar <bobby.prani@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Fernanda Ma'rouf" <fernandafmr12@gnuweeb.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [PATCH 00/17] nolibc: add preliminary self tests
Message-ID: <20220720171432.GD4159@1wt.eu>
References: <20220719214449.2520-1-w@1wt.eu>
 <67a92005-4e13-909a-1693-dfb86d8114c0@gnuweeb.org>
 <20220720162054.GB4159@1wt.eu>
 <ee428948-eaea-49bd-d8a3-c054a57f0094@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee428948-eaea-49bd-d8a3-c054a57f0094@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 21, 2022 at 12:05:14AM +0700, Ammar Faizi wrote:
> > But again, I'm open to better proposals. I reached the limits of my
> > imagination there, but I do value the ability to "yyp" one line, change
> > two arguments and gain one extra test for a different combination, and
> > I really do not want to lose that simplicity. Note that for more complex
> > tests, it's trivial to add a dedicated function and that's what was done
> > for getdents64() which also serves as an example.
> 
> OK, I understand the reason behind this now. I and Fernanda will try
> to visit this again at around 5.20-rc. *If* we can find a better
> design that matches your requirements, we will send you an RFC to
> improve it too.

You would be very welcome, thank you!

Willy
