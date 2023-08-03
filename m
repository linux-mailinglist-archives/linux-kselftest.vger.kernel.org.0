Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D434076DDD2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 04:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjHCCFu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 22:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCCFt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 22:05:49 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C709B135;
        Wed,  2 Aug 2023 19:05:46 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37325X2l023759;
        Thu, 3 Aug 2023 04:05:33 +0200
Date:   Thu, 3 Aug 2023 04:05:33 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org
Subject: Re: [PATCH v4 08/12] selftests/nolibc: add test support for ppc
Message-ID: <20230803020533.GA23704@1wt.eu>
References: <20230802103217.231036-1-falcon@tinylab.org>
 <20230802160358.407890-1-falcon@tinylab.org>
 <98629d86-eca8-4cad-aedc-2e2328a4f6ab@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98629d86-eca8-4cad-aedc-2e2328a4f6ab@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 02, 2023 at 11:36:30PM +0200, Thomas Weißschuh wrote:
> On 2023-08-03 00:03:58+0800, Zhangjin Wu wrote:
> > Hi, Willy, Hi Thomas
> > 
> > I'm so happy to share with you, we have solved all of the left found
> > issues, include the ones about ppc and the missing poweroff options for
> > the tinyconfig series, will renew both series ;-)
> 
> Can we stick to one series at a time?

Yes and please this time, let's stick exclusively to what is sufficiently
tested for 6.6, otherwise it will have to be delayed.

> > > Further compared the preprocessed files, found the root cause is the new
> > > compiler using 'no_stack_protector' instead of
> > > '__optimize__("-fno-stack-protector")'. And the attribute 'no_stack_protector'
> > > breaks our "omit-frame-pointer" like the failure with '-O0' we fixed before.
> > > 
> > > I checked some of the other architectures, they didn't have the same issue, but
> > > test shows the 'no_stack_protector' attribute does have such compability issue
> > > here.
> > > 
> > > I learned the commit message of tools/include/nolibc/compiler.h, seems
> > > __optimize__("-fno-stack-protector") is enough for all of the nolibc supported
> > > architectures? is it ok for us to simply give up 'no_stack_protector'
> > > eventully? otherwise, we should manually disable 'no_stack_protector' for
> > > ppc32:
> > > 
> > >     #define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
> > >
> > 
> > Hello, any suggestion here? ;-)
> 
> Patience :-)
> 
> no_stack_protector is the offically documented mechanism to disable
> stack protector for a function. As it works for all other architectures
> this seems like a compiler bug.

Or a limitation. To be honest we're playing with compiler limits by
adjusting their optimizations per function.  But as long as we don't
break what currently works, we can accept to have some limits in a first
version (e.g. if ppc32 doesn't support -O0 for now it's not dramatic).
Also, some other archs use optimize("Os", "omit-frame-pointer")), maybe
that's needed there as well.

> If we want to work around it I would prefer to have both attributes.

Also if you remember we also used to have a work-around for the
function's entry code consisting in renaming _start and having a _start
pointer in the asm code itself. That can remain an option to experiment
with later. But let's not change everything again at the last minute,
all these series have been sufficiently difficult to follow :-(

thanks,
Willy
