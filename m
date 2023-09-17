Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38977A33E5
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Sep 2023 08:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjIQFui (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Sep 2023 01:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjIQFuI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Sep 2023 01:50:08 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BE310B;
        Sat, 16 Sep 2023 22:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694929799;
        bh=I2ORHDPmzg8IMQkgZSGbyhmTUn7nAixQxkusYZXX9Ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNhvK9COLyxFXqsSZoncbm4ouWx+Xn1gh6p+fU6V31arYi8oIbkEOyMxEv8YtTaM4
         9JuXFJ7xrV8X8uhdb/ZrUvtuG054Xa4X5b66PsE+uDraTemleD4RBH9PezFqXpHXYh
         jgb+n3iwz/+Ck3NN2n1YjPHOM/2fLBWGlxMJLLTw=
Date:   Sun, 17 Sep 2023 07:49:57 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] tools/nolibc: avoid unused parameter warnings for
 ENOSYS fallbacks
Message-ID: <2bd688b7-5f1b-44ca-a41b-6e90dc3e8557@t-8ch.de>
References: <20230914-nolibc-syscall-nr-v1-0-e50df410da11@weissschuh.net>
 <20230914-nolibc-syscall-nr-v1-2-e50df410da11@weissschuh.net>
 <20230917025851.GE9646@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230917025851.GE9646@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-09-17 04:58:51+0200, Willy Tarreau wrote:
> On Thu, Sep 14, 2023 at 06:01:18PM +0200, Thomas Weißschuh wrote:
> > The ENOSYS fallback code does not use its functions parameters.
> > This can lead to compiler warnings about unused parameters.
> > 
> > Explicitly avoid these warnings.
> 
> Just out of curiosity, did you find a valid case for enabling this
> warning or were you trying various combinations ? I'm asking because
> I've never seen it enabled anywhere given that it's probably the most 
> useless and unusable warning: as soon as you're dealing with function
> pointers, you start to have multiple functions with a similar
> prototype, some of which just don't need certain arguments, and the
> only way to shut the warning is to significantly uglify the code.

nolibc-test uses it currently and I also used it in some projects.

> If really needed, I'm wondering if instead we shouldn't have an
> "no_syscall*" set of macros, that would have the same signature
> as my_syscall* to just consume all args in the same order and
> return -ENOSYS. E.g, consider the following:
> 
>   @@ -934,6 +960,11 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
>    #endif
>    	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
>    #else
>   +	(void)nfds;
>   +	(void)rfds;
>   +	(void)wfds;
>   +	(void)efds;
>   +	(void)timeout;
>    	return -ENOSYS;
>    #endif
> 
> It would become:
> 
>   @@ -934,6 +960,11 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
>    #endif
>    	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
>    #else
>   +	return no_syscall5(nfds, rfds, wfds, efds, timeout);
>   -	return -ENOSYS;
>    #endif
> 
> What do you think ?

The idea sounds good. But "no_syscall5" sounds a bit non-obvious to me.

Maybe the macro-equivalent of this?

static inline int __nolibc_enosys(...)
{
	return -ENOSYS;
}

The only-vararg function unfortunately needs C23 so we can't use it.

It's clear to the users that this is about ENOSYS and we don't need a
bunch of new macros similar.

I'll check if it is cleaner to implement a generic macro or a few
numbered ones.


Thomas
