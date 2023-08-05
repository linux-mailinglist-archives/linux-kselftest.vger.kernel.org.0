Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035EC771089
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjHEQZ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 12:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjHEQZ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 12:25:58 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19FE10F8;
        Sat,  5 Aug 2023 09:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1691252753;
        bh=n+KIGDLXUCXqwwdfMNnhnPNoQs5vP1Mvjy/BSICI1ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSf4+NaRQcnlzLmZF93FPWVNlfYzn2+aMXniJ2kae4/LSxYoDqXc09EiciDlRaEGg
         Li0WogOIDT47XM2FfNIPFZNir25kP2nmQYZEyCeqCqpPKd97qrzNF/g96nhD/0mxmN
         2nMIHDy6X61+m65cNi2DjRTJgz7jsP3iVkKlwkVM=
Date:   Sat, 5 Aug 2023 18:25:52 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH v3 05/14] tools/nolibc: stdint: use int for size_t on
 32bit
Message-ID: <44f1bab4-9d0a-4e7d-a73b-2c00c6029070@t-8ch.de>
References: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
 <20230803-nolibc-warnings-v3-5-bcc1a096ae02@weissschuh.net>
 <20230805161929.GA15284@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230805161929.GA15284@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-05 18:19:29+0200, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Thu, Aug 03, 2023 at 09:28:49AM +0200, Thomas Weißschuh wrote:
> > Otherwise both gcc and clang may generate warnings about type
> > mismatches:
> > 
> > sysroot/mips/include/string.h:12:14: warning: mismatch in argument 1 type of built-in function 'malloc'; expected 'unsigned int' [-Wbuiltin-declaration-mismatch]
> >    12 | static void *malloc(size_t len);
> >       |              ^~~~~~
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/include/nolibc/stdint.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
> > index 4b282435a59a..0f390c3028d8 100644
> > --- a/tools/include/nolibc/stdint.h
> > +++ b/tools/include/nolibc/stdint.h
> > @@ -15,7 +15,11 @@ typedef unsigned int       uint32_t;
> >  typedef   signed int        int32_t;
> >  typedef unsigned long long uint64_t;
> >  typedef   signed long long  int64_t;
> > +#if __SIZE_WIDTH__ == 64
> >  typedef unsigned long        size_t;
> > +#else
> > +typedef unsigned int         size_t;
> > +#endif
> 
> This one breaks gcc < 7 for me because __SIZE_WIDTH__ is not defined
> there. However I could trace __SIZE_TYPE__ to be defined since at least
> gcc-3.4 so instead we can do this, which will always match the type set
> by the compiler (either "unsigned int" or "unsigned long int") :
> 
>   #ifdef __SIZE_TYPE__
>   typedef __SIZE_TYPE__ size_t;
>   #else
>   typedef unsigned long size_t;
>   #endif

Sounds good. But do we need the fallback?

Further below we are also unconditionally using preprocessor-defines
like __INT_MAX__ and __LONG_MAX__.

So I guess we can drop the proposed #ifdef.

> Please just let me know if you want me to modify your patch accordingly.
> I'm still continuing the tests.

Feel free to modify the patch.

Thanks!
Thomas
