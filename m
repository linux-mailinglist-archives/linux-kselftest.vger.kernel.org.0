Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C24872197C
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 21:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjFDTVO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 15:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDTVO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 15:21:14 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6841A7;
        Sun,  4 Jun 2023 12:21:11 -0700 (PDT)
Date:   Sun, 4 Jun 2023 21:21:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685906469; bh=1UClnzbPKFLgB8+m4Ye4NhmglZ0eNYJbm+haocS29Dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHF1QbHZGPslYjUKOjgngaUKFdFNWbjneJMTIO4Dx43CHu6UxHzxKpry/lClXyJ46
         B+i7Qp5tyXzU3frQnpC5kEegItHMHDnt+hA4FcENSbs9tIhkbXpWVcTtcL7QbldFEs
         uo7Im8wBP/JfQph7F8Vf3H024I4lnFrqYV0HHSRA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/4] tools/nolibc: unistd.h: add __syscall() and
 __syscall_ret() helpers
Message-ID: <ea4e7442-7223-4211-ba29-70821e907888@t-8ch.de>
References: <cover.1685856497.git.falcon@tinylab.org>
 <f549b27981484b429b7c7f98e212bf3c5561724f.1685856497.git.falcon@tinylab.org>
 <ZHyKoeSMaOHtSr58@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHyKoeSMaOHtSr58@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-04 14:59:13+0200, Willy Tarreau wrote:
> Hi Zhangjin,
> 
> On Sun, Jun 04, 2023 at 01:34:29PM +0800, Zhangjin Wu wrote:
> > most of the library routines share the same code model, let's add some
> > macros to simplify the coding and shrink the code lines too.
> > 
> > One added for syscall return, one added for syscall call, both of them
> > can get the typeof 'return value' automatically.
> > 
> > To get the return type of syscalls, __auto_type is better than typeof(),
> > but it is not supported by the old compilers (before 2013, see [1]), so,
> > use typeof() here.
> > 
> > [1]: https://gcc.gnu.org/legacy-ml/gcc-patches/2013-11/msg01378.html
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/include/nolibc/sys.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > index 1d6f33f58629..937a8578e3d4 100644
> > --- a/tools/include/nolibc/sys.h
> > +++ b/tools/include/nolibc/sys.h
> > @@ -28,6 +28,21 @@
> >  #include "errno.h"
> >  #include "types.h"
> >  
> > +/* Syscall call and return helpers */
> > +#define __syscall_ret(ret)						\
> > +({									\
> > +	if (ret < 0) {							\
> > +		SET_ERRNO(-ret);					\
> > +		ret = (typeof(ret))-1;					\
> > +	}								\
> > +	ret;								\
> > +})
> > +
> > +#define __syscall(name, ...)						\
> > +({									\
> > +	typeof(sys_##name(__VA_ARGS__)) ret = sys_##name(__VA_ARGS__);	\
> > +	__syscall_ret(ret);						\
> > +})
> 
> Well, I personally don't find that it increases legibility, on the
> opposite. At first when reading the series, I thought you had dropped
> errno setting on return. I think the reason is that when reading that
> last macro, it's not at all obvious that __syscall_ret() is actually
> modifying this ret value *and* returning it as the macro's result.
> 
> If we'd want to go down that route, I suspect that something like this
> would at least hint about what is being returned:
> 
> +#define __syscall(name, ...)						\
> +({									\
> +	typeof(sys_##name(__VA_ARGS__)) ret = sys_##name(__VA_ARGS__);	\
> +	ret = __syscall_ret(ret);					\
> +})
> 
> But I'm interested in others' opinion on this, particularly Thomas and
> Arnd who review a significant number of patches. For now I prefer not
> to take it before we've settled on a choice.

While I see the value in factoring out this pattern I'm also not really
happy with the implementation.
Especially the magic delegation to "sys_##name".

What about something like this:

static inline long __ret_as_errno(long ret) /* or some other name */
{
	if (ret < 0) {
		SET_ERRNO(-ret);
		ret = -1;
	}
	return ret;
}

This avoids another macro by using a normal function.

Syscall return values should always fit into long, at least
extrapolating from syscall(2) and the fact that they are returned in
registers.

It would be a bit more verbose:

int chdir(const char *path)
{
	return __ret_as_errno(sys_chdir(path));
}

But it's clear what's going on and also just one line.

Thomas
