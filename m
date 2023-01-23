Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47396785E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 20:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjAWTNM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 14:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjAWTNL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 14:13:11 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 254E221947;
        Mon, 23 Jan 2023 11:12:58 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30NJCodi015118;
        Mon, 23 Jan 2023 20:12:50 +0100
Date:   Mon, 23 Jan 2023 20:12:50 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <20230123191250.GD13172@1wt.eu>
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230121213455.GA16121@1wt.eu>
 <Y868lIin0bLM9HfM@biznet-home.integral.gnuweeb.org>
 <20230123172016.GB13172@1wt.eu>
 <Y87EVVt431Wx2zXk@biznet-home.integral.gnuweeb.org>
 <20230123174003.GU2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123174003.GU2948950@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 23, 2023 at 09:40:03AM -0800, Paul E. McKenney wrote:
> Except that when I install Ubuntu 20.04's version, I get this:
> 
> ------------------------------------------------------------------------
> 
> $ sudo make run-user
>   MKDIR   sysroot/x86/include
> make[1]: Entering directory '/home/git/linux-rcu/tools/include/nolibc'
> make[2]: Entering directory '/home/git/linux-rcu'
> make[2]: Leaving directory '/home/git/linux-rcu'
> make[2]: Entering directory '/home/git/linux-rcu'
>   INSTALL /home/git/linux-rcu/tools/testing/selftests/nolibc/sysroot/sysroot/include
> make[2]: Leaving directory '/home/git/linux-rcu'
> make[1]: Leaving directory '/home/git/linux-rcu/tools/include/nolibc'
>   CC      nolibc-test
> 32 gettimeofday_null = -1 EFAULT        [FAIL]
> See all results in /home/git/linux-rcu/tools/testing/selftests/nolibc/run.out
> 
> ------------------------------------------------------------------------
> 
> I have attached run.out.
> 
> In contrast, with my hand-built qemu-x86_64, all tests passed.
> 
> This might be just a version-related bug, but figured I should let you
> guys know.

Interesting. Maybe something differs in the way it passes expectedly
invalid pointers to some syscalls. Keep in mind that it's using your
local kernel also, that could make a difference. I'm not that much keen
on trying to investigate that one to be honest, given that this user
mode is really meant to ease the life of test developers like Ammar
and myself who just want to focus on the correctness of the test they're
adding and not that much on the validity of the test itself in this
context. I suggest we keep this one in mind without putting too much
effort on it for now.

Thanks!
Willy
