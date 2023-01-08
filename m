Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516A7661741
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 18:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjAHRQC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 12:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjAHRQB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 12:16:01 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E59C0A470;
        Sun,  8 Jan 2023 09:15:59 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 308HFkWo020532;
        Sun, 8 Jan 2023 18:15:46 +0100
Date:   Sun, 8 Jan 2023 18:15:46 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [RESEND PATCH v1 0/3] nolibc auxiliary vector retrieval support
Message-ID: <20230108171546.GA18859@1wt.eu>
References: <20230108135809.850210-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108135809.850210-1-ammar.faizi@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ammar,

On Sun, Jan 08, 2023 at 08:58:06PM +0700, Ammar Faizi wrote:
> From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> 
> Hi Willy,
> 
> This series is a follow up of our previous discussion about getauxval()
> and getpagesize() functions.
> 
> It will apply cleanly on top of your "20221227-nolibc-weak-4" branch.
> Base commit: b6887ec8b0b0 ("tools/nolibc: add auxiliary vector
> retrieval for mips").
> 
> I have added a selftest for the getpagesize() function, but I am not
> sure how to assert the correctness of getauxval(). I think it is fine
> not to add a selftest for getauxval(). If you think we should, please
> give some advice on the test mechanism.
(...)

Thank you! I've applied it to my local queue (will push soon), and
could test it on all supported archs and it works fine. Thus consider
it as merged now.

Thanks!
Willy
