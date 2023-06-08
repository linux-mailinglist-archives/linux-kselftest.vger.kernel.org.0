Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F30728493
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 18:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjFHQGW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 12:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjFHQGW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 12:06:22 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A94134;
        Thu,  8 Jun 2023 09:06:18 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:06:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1686240377; bh=PLbGY4orS7r/OO9ChDGkyjxNSJlc51OFBzDXVDH4Ii4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LgZCtK5CqJi7+kGUwNDw+NV2XHBX6YW+VlVYYRIh7g472vEfThJkLzBg7zz6OQz9q
         1REcTFqGgqztBtkaxjzSA+u+UUQNllwVj0yL2elkwYkZ0Gndk6DuLrBtvjfdIHkOsO
         FRLX/2O510m2f9t3t7X2D97I+/nQi4JqlRJ0y4SM=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Zhangjin Wu' <falcon@tinylab.org>, "w@1wt.eu" <w@1wt.eu>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 1/4] tools/nolibc: sys.h: add __syscall() and
 __sysret() helpers
Message-ID: <9edb16b4-0d3f-4355-a7b1-684a28f9b4cb@t-8ch.de>
References: <cover.1686036862.git.falcon@tinylab.org>
 <a42fb9e1bbe0daf7d8a48ea8f44135ef851030d7.1686036862.git.falcon@tinylab.org>
 <94dd5170929f454fbc0a10a2eb3b108d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94dd5170929f454fbc0a10a2eb3b108d@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On 2023-06-08 14:35:49+0000, David Laight wrote:
> From: Zhangjin Wu
> > Sent: 06 June 2023 09:10
> > 
> > most of the library routines share the same code model, let's add two
> > helpers to simplify the coding and shrink the code lines too.
> > 
> ...
> > +/* Syscall return helper, set errno as -ret when ret < 0 */
> > +static inline __attribute__((always_inline)) long __sysret(long ret)
> > +{
> > +	if (ret < 0) {
> > +		SET_ERRNO(-ret);
> > +		ret = -1;
> > +	}
> > +	return ret;
> > +}
> 
> If that right?
> I thought that that only the first few (1024?) negative values
> got used as errno values.
> 
> Do all Linux architectures even use negatives for error?
> I thought at least some used the carry flag.
> (It is the historic method of indicating a system call failure.)

I guess you are thinking about the architectures native systemcall ABI.

In nolibc these are abstracted away in the architecture-specific
assembly wrappers: my_syscall0 to my_syscall6.
(A good example would be arch-mips.h)

These normalize the architecture systemcall ABI to negative errornumbers
which then are returned from the sys_* wrapper functions.

The sys_* wrapper functions in turn are used by the libc function which
translate the negative error number to the libc-style
"return -1 and set errno" mechanism.
At this point the new __sysret function is used.

Returning negative error numbers in between has the advantage that it
can be used without having to set up a global/threadlocal errno
variable.

In hope this helped,
Thomas
