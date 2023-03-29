Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CC66CD1AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 07:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjC2Ffq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 01:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjC2Ffh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 01:35:37 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4266E3A84;
        Tue, 28 Mar 2023 22:35:36 -0700 (PDT)
Date:   Wed, 29 Mar 2023 05:35:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680068134;
        bh=GLQ3ltzyMx0gEOf9aVkp+vIB25DqgxrGs7yglPKYW7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HR7Vy4jrr/Ewm325u3lgPSy2P/C4EjKjgUD4N8yZwauhSiD4T9KlCW5lqYgzWcPBS
         cDi766OmwN53F369TuXd1C5l7Npqwpr2aE5ekLt9E8UDJXXZ1E7utgP0i5pozVAa7r
         RbMgwkDmpV9K4kqOCKJKBf6zB9D52FL9xs70aqrI=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: validate C99 compatibility
Message-ID: <2be5dd3f-d4ca-499a-9f7e-3113b4f04412@t-8ch.de>
References: <20230328-nolibc-c99-v1-1-a8302fb19f19@weissschuh.net>
 <ZCPJm/Nb2AGlJqXg@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCPJm/Nb2AGlJqXg@1wt.eu>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Willy,

On 2023-03-29 07:16:11+0200, Willy Tarreau wrote:
> On Tue, Mar 28, 2023 at 09:07:35PM +0000, Thomas Weißschuh wrote:
> > Most of the code was migrated to C99-conformant __asm__ statements
> > before. It seems string.h was missed.
> > 
> > Fix string.h and also validate during build that nolibc stays within
> > C99.
> 
> I'm all for improving portability, however I have a concern with building
> the test case with -std=c99 which is that it might hide some c99-only
> stuff that we'd introduce by accident in the nolibc's code, and I'd
> rather not do that because it will mean changing build options for some
> external programs using it if it happens. However I totally agree with
> you that we need to make sure that there's no build issues with c99
> compilers. Modern compilers are c99-compatible but generally come with
> GNU extensions and I understand why you're interested in switching to
> std=c99 in order to drop some of these like "asm". Should we have two
> build targets, the default one and a c99 one ? Maybe. The build is so
> small and quick that nobody will care, so we could definitely imagine
> building the two versions. Maybe you have a better idea ?

I'm not sure I understand.
Do you want to stay compatible with c89/gnu89?

If so we could use that baseline standard instead of -std=c99.

Without specifying a standard we get whatever the compiler uses as
default which is probably much newer than c99.

Having two targets seems to be easy to do but I'm not sure what the
advantage would be over compiling once against the intended baseline
standard.

Regards,
Thomas
