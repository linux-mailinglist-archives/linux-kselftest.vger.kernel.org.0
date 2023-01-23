Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CD46782E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 18:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjAWRU0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 12:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjAWRU0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 12:20:26 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FCB6A5E6;
        Mon, 23 Jan 2023 09:20:24 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30NHKGZe014373;
        Mon, 23 Jan 2023 18:20:16 +0100
Date:   Mon, 23 Jan 2023 18:20:16 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <20230123172016.GB13172@1wt.eu>
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230121213455.GA16121@1wt.eu>
 <Y868lIin0bLM9HfM@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y868lIin0bLM9HfM@biznet-home.integral.gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ammar,

On Mon, Jan 23, 2023 at 11:57:56PM +0700, Ammar Faizi wrote:
> Is there a way to make it work for the default qemu installation?
> Or maybe it's a mandatory requirement to build qemu from the source?
> 
> I use the qemu that comes from Ubuntu apt. I have "qemu-system-x86_64",
> but no "qemu-x86_64". So, something like this...
> 
>   $ which qemu-x86_64
>   $ echo $?
>   1
> 
>   $ which qemu-system-x86_64
>   /usr/bin/qemu-system-x86_64

Ah now I think I understand Paul's question. I didn't know that the
userland version was not always provided. I've always had both side
by side.

> It would be great if we can avoid building qemu from the source. But if
> not, let's go with that.

As Paul indicated, it's really trouble-free and I think I've only done
that since the very first day I started to use QEMU, reason why I probably
never noticed that not everything was packaged.

Then at least to respond to Paul, it could make sense to add a note that
on some distros the userland version might not always be provided and
might require a pretty simple rebuild of QEMU.

Thanks!
Willy
