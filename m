Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC2B5276CB
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 May 2022 12:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbiEOKFb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 May 2022 06:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiEOKFa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 May 2022 06:05:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961553D1E4;
        Sun, 15 May 2022 03:05:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E99160EF6;
        Sun, 15 May 2022 10:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39026C385B8;
        Sun, 15 May 2022 10:05:27 +0000 (UTC)
Date:   Sun, 15 May 2022 11:05:23 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: bti: force static linking
Message-ID: <YoDQY/0i9BrEIEO8@arm.com>
References: <20220511172129.2078337-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511172129.2078337-1-andre.przywara@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 11, 2022 at 06:21:29PM +0100, Andre Przywara wrote:
> The "bti" selftests are built with -nostdlib, which apparently
> automatically creates a statically linked binary, which is what we want
> and need for BTI (to avoid interactions with the dynamic linker).
> 
> However this is not true when building a PIE binary, which some
> toolchains (Ubuntu) configure as the default.
> When compiling btitest with such a toolchain, it will create a
> dynamically linked binary, which will probably fail some tests, as the
> dynamic linker might not support BTI:
> ===================
> TAP version 13
> 1..18
> not ok 1 nohint_func/call_using_br_x0
> not ok 2 nohint_func/call_using_br_x16
> not ok 3 nohint_func/call_using_blr
> ....
> ===================
> 
> To make sure we create static binaries, add an explicit -static on the
> linker command line. This forces static linking even if the toolchain
> defaults to PIE builds, and fixes btitest runs on BTI enabled machines.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Does this need to go in as a fix (cc stable, fixes tag)?

-- 
Catalin
