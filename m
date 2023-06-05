Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93613721DBB
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 07:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjFEF7Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 01:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFEF7W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 01:59:22 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57B4CA;
        Sun,  4 Jun 2023 22:59:18 -0700 (PDT)
X-QQ-mid: bizesmtp69t1685944744ts84doh5
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 05 Jun 2023 13:59:03 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: G46xFj+wOV/L074q2AKnBZa3XbP/lNWUqet1CdpG27NI5H5INZ6/Krhugq1JO
        QLYPBnd57JQbS+98+fGyQroOc35/Jjh5ECnHpvSasBdXYNWyPnVemwaRxIc8Fd5c68Yt2YK
        d7fGFnpiM4OnM9bY09b8+2sCWUlorx7svBydPvj0rJhkGqmacLFY3oRn12czE7CoMAxOkOz
        ziEpKFTZhibRSI96N4blVM35wXg66xojJ5FkSS6Xpa+ZsH8mLF5vWcsBegm7BIyzPqLZxE9
        fKV5JdkCWG+sbDPeUYml4aV/Kyhisn6lAo+uK6GMsfSHTSYcJ3GTc85EXg9HyLUrawiItqJ
        QkCgPowOsmxqbwCtBLnardKRpee0rJGOdvuD1RYfpvwv3N6wbZ5T3VKYAEWgRO/Q7VI2el0
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1147498527477827847
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        w@1wt.eu
Subject: Re: [PATCH 1/4] tools/nolibc: unistd.h: add __syscall() and __syscall_ret() helpers
Date:   Mon,  5 Jun 2023 13:58:57 +0800
Message-Id: <20230605055857.135286-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ea4e7442-7223-4211-ba29-70821e907888@t-8ch.de>
References: <ea4e7442-7223-4211-ba29-70821e907888@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On 2023-06-04 14:59:13+0200, Willy Tarreau wrote:
> > Hi Zhangjin,
> > 
> > On Sun, Jun 04, 2023 at 01:34:29PM +0800, Zhangjin Wu wrote:
> > > most of the library routines share the same code model, let's add some
> > > macros to simplify the coding and shrink the code lines too.
> > > 
> > > One added for syscall return, one added for syscall call, both of them
> > > can get the typeof 'return value' automatically.
> > > 
> > > To get the return type of syscalls, __auto_type is better than typeof(),
> > > but it is not supported by the old compilers (before 2013, see [1]), so,
> > > use typeof() here.
> > > 
> > > [1]: https://gcc.gnu.org/legacy-ml/gcc-patches/2013-11/msg01378.html
> > > 
> > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > ---
> > >  tools/include/nolibc/sys.h | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > > index 1d6f33f58629..937a8578e3d4 100644
> > > --- a/tools/include/nolibc/sys.h
> > > +++ b/tools/include/nolibc/sys.h
> > > @@ -28,6 +28,21 @@
> > >  #include "errno.h"
> > >  #include "types.h"
> > >  
> > > +/* Syscall call and return helpers */
> > > +#define __syscall_ret(ret)						\
> > > +({									\
> > > +	if (ret < 0) {							\
> > > +		SET_ERRNO(-ret);					\
> > > +		ret = (typeof(ret))-1;					\
> > > +	}								\
> > > +	ret;								\
> > > +})
> > > +
> > > +#define __syscall(name, ...)						\
> > > +({									\
> > > +	typeof(sys_##name(__VA_ARGS__)) ret = sys_##name(__VA_ARGS__);	\
> > > +	__syscall_ret(ret);						\
> > > +})
> > 
> > Well, I personally don't find that it increases legibility, on the
> > opposite. At first when reading the series, I thought you had dropped
> > errno setting on return. I think the reason is that when reading that
> > last macro,

Hi, Willy, I did add something like this in my local copy to pass the
errno and retval arguments too:

    #define __syscall_ret3(ret, errno, retval)				\
    ({									\
    	if (ret < 0) {							\
    		SET_ERRNO(errno);					\
    		ret = (typeof(ret)retval;				\
    	}								\
    	ret;								\
    })

    #define __syscall_ret(ret) __syscall_ret3(ret, -ret, -1)

But when really using them, I found we could be able to set the ret as errno at
first (and the reval is always -1 currently), then used the only simpler
__syscall_ret() at last.

> > it's not at all obvious that __syscall_ret() is actually
> > modifying this ret value *and* returning it as the macro's result.
> > 
> > If we'd want to go down that route, I suspect that something like this
> > would at least hint about what is being returned:
> > 
> > +#define __syscall(name, ...)						\
> > +({									\
> > +	typeof(sys_##name(__VA_ARGS__)) ret = sys_##name(__VA_ARGS__);	\
> > +	ret = __syscall_ret(ret);					\
> > +})
> >

It is clearer.

> > But I'm interested in others' opinion on this, particularly Thomas and
> > Arnd who review a significant number of patches. For now I prefer not
> > to take it before we've settled on a choice.
> 
> While I see the value in factoring out this pattern I'm also not really
> happy with the implementation.
> Especially the magic delegation to "sys_##name".
> 
> What about something like this:
> 
> static inline long __ret_as_errno(long ret) /* or some other name */
> {
> 	if (ret < 0) {
> 		SET_ERRNO(-ret);
> 		ret = -1;
> 	}
> 	return ret;
> }
> 
> This avoids another macro by using a normal function.
>

It is reasonable, like it very much.

> Syscall return values should always fit into long, at least
> extra polating from syscall(2) and the fact that they are returned in
> registers.

Yes, I did use 'long' instead of 'int' for unistd.h locally, but since tried to
let it work with 'void *' before (e.g. sys_brk, an older version support pass
the errno value), so, the typeof() is used and the same to unistd.h, but at
last, none of (void *) return type is really used in current patchset, so, we
are able to use this normal function version without the checking of the type.

> 
> It would be a bit more verbose:
> 
> int chdir(const char *path)
> {
> 	return __ret_as_errno(sys_chdir(path));
> }
>
> But it's clear what's going on and also just one line.

Thanks Thomas, It looks good and I do like the 'embedded' calling of
sys_chrdir(path), but __syscall() looks cleaner and shorter too, let's put them
together:

int chdir(const char *path)
{
	return __ret_as_errno(sys_chdir(path));
}

int chdir(const char *path)
{
	return __syscall(chdir, path);
}

And even with:

int chdir(const char *path)
{
	return __sysret(sys_chdir(path));
}

__syscall() works likes syscall(), and the definition is similar to syscall(),
but uses the syscall name instead of syscall number, If reserve __syscall(),
the inline function would be renamed back to __syscall_ret() or something like
the shorter __sysret(), to align with our new __syscall(). 

for sys.h:

    /* Syscall return helper, set errno as ret when ret < 0 */
    static inline long __sysret(long ret)
    {
    	if (ret < 0) {
    		SET_ERRNO(-ret);
    		ret = -1;
    	}
    	return ret;
    }

    /* Syscall call helper, use syscall name instead of syscall number */
    #define __syscall(name, ...) __sysret(sys_##name(__VA_ARGS__))

for unistd.h:

    #define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))

What about this version?

The potential 'issue' may be mixing the use of __syscall(), _syscall() and
syscall(), but the compilers may help to fix up this for us, I don't think it
is a bottleneck.

Best regards,
Zhangjin

> 
> Thomas
