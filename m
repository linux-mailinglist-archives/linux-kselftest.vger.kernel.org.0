Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2496782D2
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 18:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjAWRSL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 12:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjAWRSD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 12:18:03 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DDE0468A;
        Mon, 23 Jan 2023 09:17:44 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30NHHChN014353;
        Mon, 23 Jan 2023 18:17:12 +0100
Date:   Mon, 23 Jan 2023 18:17:12 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <20230123171712.GA13172@1wt.eu>
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230121213455.GA16121@1wt.eu>
 <20230123164721.GO2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123164721.GO2948950@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Paul,

On Mon, Jan 23, 2023 at 08:47:21AM -0800, Paul E. McKenney wrote:
> And building from sources proved to be reasonably easy, so the test
> now passes for me.  My initial thought of putting qemu-x86_64 into
> my ~/bin directory fails the sudo test, but putting it into /usr/bin
> works fine.

Great!

> Thank you for the hints!
> 
> Should I add a sentence to the commit log noting the potential need to
> build qemu from the git repo and to install qemu-x86_64, give or take
> what architecture one is running?

Well, I've always had all the variants for all supported archs and
didn't know that sometimes only part of them could be installed.
I've used and tested qemu-{i386,x86_64,arm,aarch64,mips,s390x,riscv64}
with this with success, and all of them are built by default for me.
Thus I'm not seeing a good reason for making a special case of x86_64.
Or maybe I'm missing the point ?

Thanks,
Willy
