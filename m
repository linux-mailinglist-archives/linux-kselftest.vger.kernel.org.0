Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27666D37C9
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 14:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjDBMLN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 08:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDBMLM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 08:11:12 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862AE1A974;
        Sun,  2 Apr 2023 05:11:11 -0700 (PDT)
Date:   Sun, 2 Apr 2023 12:11:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680437469;
        bh=4DlzhjnIZYDz1Xleyafaex30JUPJPNbxjCJU6hBBoPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNWbIMuhq/Eo8hZHrrwR5L7pF5yaLl1hMh/7HQ5tz07Zy/n8PHq7layehpbkaw7Hb
         uvtZMEgS/lhmkS3YTYuHclVAeNRJup2ICsQuGE2TQfJIwWpMnj5lwiOpjfAyzDhqgX
         DlekF8rL1Q8s0+NvBdV1UYVhgNJXubB5wXt74eNw=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] tools/nolibc: let FILE streams contain an fd
Message-ID: <1cea5233-dae4-49a4-bdd0-d43563ae724d@t-8ch.de>
References: <20230328-nolibc-printf-test-v1-0-d7290ec893dd@weissschuh.net>
 <20230328-nolibc-printf-test-v1-2-d7290ec893dd@weissschuh.net>
 <ZCkytcGBUbWUoiv+@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCkytcGBUbWUoiv+@1wt.eu>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-04-02 09:45:57+0200, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Tue, Mar 28, 2023 at 09:01:30PM +0000, Thomas Weißschuh wrote:
> > This enables the usage of the stream APIs with arbitrary filedescriptors.
> > 
> > It will be used by a future testcase.
> > Users can also use nolibc-specific code to do the same.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/include/nolibc/stdio.h | 36 +++++++-----------------------------
> >  1 file changed, 7 insertions(+), 29 deletions(-)
> > 
> > diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> > index 96ac8afc5aee..cb58912b98e5 100644
> > --- a/tools/include/nolibc/stdio.h
> > +++ b/tools/include/nolibc/stdio.h
> > @@ -21,17 +21,13 @@
> >  #define EOF (-1)
> >  #endif
> >  
> > -/* just define FILE as a non-empty type */
> >  typedef struct FILE {
> > -	char dummy[1];
> > +	int fd;
> >  } FILE;
> 
> In my opinion this makes the usage of FILE* more complicated than before.
> Look for example at your vfprintf() test case, you had to do this with
> the fd provided by memfd_create():
> 
>         w = vfprintf(&(FILE) { fd }, fmt, args);
> 
> This is particularly ugly especially for code that needs to be exposed
> to end-user. Also it breaks compatibility with glibc that is seldom used
> to check if trouble comes from nolibc or from the test itself. It would
> be much better to have fdopen() here but the new struct makes this
> impossible.

My original reasoning was to avoiding to implement a version of fdopen()
that does not properly check the "mode" argument.

But rereading the manpage of fdopen() we don't actually need to check
them.

Also the goal was for this "API" to be completely opaque to the enduser
and only used internally in nolibc(-test).
But building the tests with glibc is indeed a great usecase.

fdopen() it is.

Also I think I'll extend the -std=c99/-std=gnu89 series to also build
the test against glibc to prevent me from breaking this in the future.

> I would propose instead to go back to the previous definition and simply
> change its semantics a little bit:
> 
>    /* just define FILE as a non-empty type. The value of the pointer gives
>     * the FD: FILE=~fd for fd>=0 or NULL for fd<0. This way positive FILE
>     * are immediately identified as abnormal entries (i.e. possible copies
>     * of valid pointers to something else).
>    typedef struct FILE {
>    	char dummy[1];
>    } FILE;
> 
> Then we can have:
> 
>   static __attribute__((unused)) FILE* const stdin  = (FILE*)(uintptr_t)~STDIN_FILENO;
>   static __attribute__((unused)) FILE* const stdout = (FILE*)(uintptr_t)~STDOUT_FILENO;
>   static __attribute__((unused)) FILE* const stderr = (FILE*)(uintptr_t)~STDERR_FILENO;
> 
>   /* provides a FILE* equivalent of fd. The mode is ignored. */
>   static __attribute__((unused))
>   FILE *fdopen(int fd, const char *mode)
>   {
>   	if (fd < 0)
>   		return NULL;
>   	return (FILE*)(uintptr_t)~fd;
>   }
> 
> And your FD can simply be passed this way:
> 
>   fd = memfd_create("vfprintf", 0);
>   if (fd == -1) {
>           pad_spc(llen, 64, "[FAIL]\n");
>           return 1;
>   }
> 
>   va_start(args, fmt);
>   w = vfprintf(fdopen(fd, "w+"), fmt, args);
>   va_end(args);
> 
> This way it works more like common usage and restores glibc compatibility.

Ack, will do.
