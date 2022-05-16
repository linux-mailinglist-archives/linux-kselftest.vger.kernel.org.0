Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5C55280DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 11:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiEPJ3m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 05:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiEPJ3m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 05:29:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC4BB2AE07;
        Mon, 16 May 2022 02:29:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EBA11063;
        Mon, 16 May 2022 02:29:40 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E7863F66F;
        Mon, 16 May 2022 02:29:39 -0700 (PDT)
Date:   Mon, 16 May 2022 10:29:35 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: bti: force static linking
Message-ID: <20220516102935.67505a91@donnerap.cambridge.arm.com>
In-Reply-To: <YoDQY/0i9BrEIEO8@arm.com>
References: <20220511172129.2078337-1-andre.przywara@arm.com>
        <YoDQY/0i9BrEIEO8@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 15 May 2022 11:05:23 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

Hi,

> On Wed, May 11, 2022 at 06:21:29PM +0100, Andre Przywara wrote:
> > The "bti" selftests are built with -nostdlib, which apparently
> > automatically creates a statically linked binary, which is what we want
> > and need for BTI (to avoid interactions with the dynamic linker).
> > 
> > However this is not true when building a PIE binary, which some
> > toolchains (Ubuntu) configure as the default.
> > When compiling btitest with such a toolchain, it will create a
> > dynamically linked binary, which will probably fail some tests, as the
> > dynamic linker might not support BTI:
> > ===================
> > TAP version 13
> > 1..18
> > not ok 1 nohint_func/call_using_br_x0
> > not ok 2 nohint_func/call_using_br_x16
> > not ok 3 nohint_func/call_using_blr
> > ....
> > ===================
> > 
> > To make sure we create static binaries, add an explicit -static on the
> > linker command line. This forces static linking even if the toolchain
> > defaults to PIE builds, and fixes btitest runs on BTI enabled machines.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>  
> 
> Does this need to go in as a fix (cc stable, fixes tag)?

I dimly remember some discussion about stable fixes not being a real thing
for the selftests? In any case:

Fixes: 314bcbf09f14 ("kselftest: arm64: Add BTI tests")

Cheers,
Andre
