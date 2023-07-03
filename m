Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261ED7459C8
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 12:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGCKLx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 06:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjGCKLw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 06:11:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E5718D;
        Mon,  3 Jul 2023 03:11:51 -0700 (PDT)
Date:   Mon, 3 Jul 2023 12:11:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1688379110; bh=JaQoe8ZfDwifbQM153siZCvI+TDzLOP02eBD2RQK1NA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sBDpJhgjTVhhWVzcennscDyTI4F6KXTA+3SID8ccsEI7fBqVLT0j+EFiRgGlpMteR
         dc1qrQ1p4Yw5N3lhTor9LB5hr3ZuMjHDPGHt4lROhnoRz6fPoHSaPfJZIsbTRT4aky
         DBGFNlobetNOHs0+g7q8GY1YyuOi8T2URyZvJTiI=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        w@1wt.eu
Subject: Re: [PATCH v1 03/11] tools/nolibc: include crt.h before arch.h
Message-ID: <8efbbfe5-1c3f-46df-9bc3-2ba62015f17e@t-8ch.de>
References: <e1cf8fd3-f8cd-4c3c-9f8c-24bbc0a7cde3@t-8ch.de>
 <20230703095832.493137-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703095832.493137-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-03 17:58:32+0800, Zhangjin Wu wrote:
> Hi, Thomas
> 
> > 
> > On 2023-06-29 02:54:35+0800, Zhangjin Wu wrote:
> > > The crt.h provides a new _start_c() function, which is required by the
> > > new assembly _start entry of arch-<ARCH>.h (included by arch.h), let's
> > > include crt.h before arch.h.
> > > 
> > > This '#include "crt.h"' doesn't let the new _start_c() work immediately,
> > > but it is a base of the coming patches to move most of the assembly
> > > _start operations to the _start_c() function for every supported
> > > architecture.
> > 
> > Why don't the arch-*.h files include this new header?
> > They are the users of the new symbol.
> >
> 
> I have tried so, but since crt.h itself is not architecture specific, add it
> before arch.h will avoid every new arch porting add the same thing again and
> again, currently, we only need to add once. I have even planned to move
> compiler.h out of arch-*.h, but not yet ;-)

While this saves a few lines of code in my opinion it hurts clarity to
rely on implicitly pre-included things.

> every new arch porting

That doesn't seem like a very frequent occurrence :-)

> And also, crt.h may require more features in the future, like init/fini
> support, it may be not only used by arch-*.h files.

Do you have a mechanism in mind that supports init/fini without needing
an ELF parser at runtime? I guess an ELF parser would make it a complete
no-go.

Also the value added by init/fini seems fairly limited for a statically
linked (tiny) application.

> [..]
