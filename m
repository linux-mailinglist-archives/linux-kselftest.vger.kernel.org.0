Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2A96D9D6C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 18:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbjDFQW3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDFQW2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 12:22:28 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 193191708;
        Thu,  6 Apr 2023 09:22:26 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 336GMFn2004846;
        Thu, 6 Apr 2023 18:22:15 +0200
Date:   Thu, 6 Apr 2023 18:22:15 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kselftest: Support nolibc
Message-ID: <ZC7xt6rWfc4zdMB1@1wt.eu>
References: <20230405-kselftest-nolibc-v1-0-63fbcd70b202@kernel.org>
 <ZC7VLXGpB8PRdj12@1wt.eu>
 <bdac4e4a-383d-4d60-8ce4-f26c1e265335@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdac4e4a-383d-4d60-8ce4-f26c1e265335@sirena.org.uk>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 06, 2023 at 03:32:20PM +0100, Mark Brown wrote:
> On Thu, Apr 06, 2023 at 04:20:29PM +0200, Willy Tarreau wrote:
> > On Thu, Apr 06, 2023 at 02:56:28PM +0100, Mark Brown wrote:
> 
> > > At present the kselftest header can't be used with nolibc since it makes
> > > use of vprintf() which is not available in nolibc and seems like it would
> > > be inappropriate to implement given the minimal system requirements and
> > > environment intended for nolibc.
> 
> > In fact we already have vfprintf(), and printf() is based on it, so
> > wouldn't it just be a matter of adding vprintf() that calls vfprintf()
> > for your case ? Maybe just something like this :
> 
> >   static int vprintf(const char *fmt, va_list args)
> >   {
> > 	return vfprintf(stdout, fmt, args);
> >   }
> 
> > It's possible I'm missing something, but it's also possible you didn't
> > find vfprintf() which is why I prefer to raise my hand ;-)
> 
> Oh, yes - I just didn't find that.  Can't remember what I searched for
> but it didn't match.

No problem. I just remembered it existed because we just received a
new test for it a few days ago ;-)

> > > This has resulted in some open coded
> > > kselftests which use nolibc to test features that are supposed to be
> > > controlled via libc and therefore better exercised in an environment with
> > > no libc.
> 
> > Yeah that's ugly. In nolibc-test we now have two build targets so that
> > we can more easily verify the compatibility between the default libc and
> > nolibc, so my recommendation would be to stick to a common subset of both
> > libcs, but not to rely on nolibc-specific stuff that could make tests
> > harder to debug.
> 
> For these features we simply never want to run with a proper libc since
> if we use a libc which has support for the features then we can't
> meaningfully interact with them.  We're trying to test interfaces that
> libc is supposed to use.

Indeed, this totally makes sense then! But I think you get the idea of
what I was suggesting which is to try to avoid getting trapped by a
single implementation in general, by using portable stuff as much as
possible.

Cheers,
Willy
