Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3036B6DEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 04:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCMDYi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Mar 2023 23:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCMDYf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Mar 2023 23:24:35 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD20C2CC59;
        Sun, 12 Mar 2023 20:24:29 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32D3OO4U006884;
        Mon, 13 Mar 2023 04:24:24 +0100
Date:   Mon, 13 Mar 2023 04:24:24 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 4/5] tools/nolibc: add support for stack protector
Message-ID: <ZA6XaPxSg7mKbDLU@1wt.eu>
References: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
 <20230223-nolibc-stackprotector-v1-4-3e74d81b3f21@weissschuh.net>
 <ZA3MC89PEq058cdo@1wt.eu>
 <68b4b33d-711b-4b5d-b932-6beceffbcf28@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68b4b33d-711b-4b5d-b932-6beceffbcf28@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 12, 2023 at 11:06:58PM +0000, Thomas Weißschuh wrote:
> On Sun, Mar 12, 2023 at 01:56:43PM +0100, Willy Tarreau wrote:
> > Hi Thomas,
> > 
> > thanks for this patchset. I must confess it's not very clear to me which
> > class of programs using nolibc could benefit from stack protection, but
> > if you think it can improve the overall value (even if just by allowing
> > to test more combinations), I'm fine with this given that it doesn't
> > remove anything.
> 
> I forgot the rationale, will add it properly to the next revision:
> 
> This is useful when using nolibc for security-critical tools.
> Using nolibc has the advantage that the code is easily auditable and
> sandboxable with seccomp as no unexpected syscalls are used.
> Using compiler-assistent stack protection provides another security
> mechanism.

I hadn't thought about such a use case at all. Till now the code has
been developped in a more or less lenient way because it was aimed at
tiny tools (a small preinit code, and regtests) with no particular
focus on security. I'm fine with such use cases but I think we need
to place the cursor at the right place in terms of responsibilities
between the lib and the application. For example IMHO we should make
sure it's never the lib's responsibility to erase some buffers that
might have contained a password, to provide constant-time memcmp(),
nor to pad/memset the structures in functions stacks, otherwise it
will significantly complicate contributions and reviews in the future.
This means the lib should continue to focus on providing convenient
access to syscalls and very basic functions and if certain security-
sensitive functions are ever needed, we should probably refrain from
implementing them so that users know it's their job to provide them
for their application. I don't have any such function in mind but I
prefer that we can draw this line early.

But I definitely understand how such a model based on inlined code
can provide some benefits in terms of code auditing! You can even
copy the code in the application's repository and have everything
available without even depending on any version so that once the
code has been audited, you know it will not change by a iota. Makes
sense!

Thanks for the background,
Willy
