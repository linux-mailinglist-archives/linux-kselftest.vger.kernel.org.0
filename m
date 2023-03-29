Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587A06CD1F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 08:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjC2GMV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 02:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC2GMU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 02:12:20 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ACC435A1;
        Tue, 28 Mar 2023 23:12:05 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32T6BwOJ009459;
        Wed, 29 Mar 2023 08:11:58 +0200
Date:   Wed, 29 Mar 2023 08:11:58 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: validate C99 compatibility
Message-ID: <ZCPWrrrlVRsaVIsl@1wt.eu>
References: <20230328-nolibc-c99-v1-1-a8302fb19f19@weissschuh.net>
 <ZCPJm/Nb2AGlJqXg@1wt.eu>
 <2be5dd3f-d4ca-499a-9f7e-3113b4f04412@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2be5dd3f-d4ca-499a-9f7e-3113b4f04412@t-8ch.de>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 29, 2023 at 05:35:33AM +0000, Thomas Weißschuh wrote:
> Hi Willy,
> 
> On 2023-03-29 07:16:11+0200, Willy Tarreau wrote:
> > On Tue, Mar 28, 2023 at 09:07:35PM +0000, Thomas Weißschuh wrote:
> > > Most of the code was migrated to C99-conformant __asm__ statements
> > > before. It seems string.h was missed.
> > > 
> > > Fix string.h and also validate during build that nolibc stays within
> > > C99.
> > 
> > I'm all for improving portability, however I have a concern with building
> > the test case with -std=c99 which is that it might hide some c99-only
> > stuff that we'd introduce by accident in the nolibc's code, and I'd
> > rather not do that because it will mean changing build options for some
> > external programs using it if it happens. However I totally agree with
> > you that we need to make sure that there's no build issues with c99
> > compilers. Modern compilers are c99-compatible but generally come with
> > GNU extensions and I understand why you're interested in switching to
> > std=c99 in order to drop some of these like "asm". Should we have two
> > build targets, the default one and a c99 one ? Maybe. The build is so
> > small and quick that nobody will care, so we could definitely imagine
> > building the two versions. Maybe you have a better idea ?
> 
> I'm not sure I understand.
> Do you want to stay compatible with c89/gnu89?

At least with gnu89, yes, since it's been used by default by a wide
range of compilers.

> If so we could use that baseline standard instead of -std=c99.

The only thing is that c99 is both more permissive and more restrictive
than gnu89 since (as you noticed) gnu89 allows for example "asm" instead
of "__asm__".

> Without specifying a standard we get whatever the compiler uses as
> default which is probably much newer than c99.

Yes but do we really care ? I think we want at least some gnuXX
(which gcc does by default) and some c99 for those who don't want to
depend on gnuXX. Diversity in tests provides faster reports than
forcing everyone to the same set. By keeping the default build option,
a backwards-compatibility test is just a matter of setting CC= with the
relevant compiler to confirm it's still OK, without being fooled by the
fact that a standard other than the default was used.

> Having two targets seems to be easy to do but I'm not sure what the
> advantage would be over compiling once against the intended baseline
> standard.

We're providing a set of includes to be used by userland so there isn't
a single intended baseline standard. I'm not advocating for supporting
everything on earth at all, but at least it should work with native
compilers currently found in distros or on the kernel.org crosstools,
and with some older toolchains that are used once in a while to rebuild
a few compact tools. For example I've used this codebase to build a
recovery kernel+tools in the past, which fits everything in a 1MB
binary, and that's the type of thing where you know that it's not always
easy nor relevant to port the code to newer compilers, so if it used to
work on gcc 4.7 you'll just reuse that one if you still have it. My
position regarding older tools is: we don't make particular efforts to
test them, but we at least do not try hard to evince them either as
long as it's not necessary.

Thanks,
Willy
