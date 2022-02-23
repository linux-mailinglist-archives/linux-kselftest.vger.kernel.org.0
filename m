Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B1D4C1752
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 16:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiBWPng (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 10:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiBWPng (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 10:43:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484EA13F3D
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 07:43:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7B79B82086
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 15:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6418C340E7;
        Wed, 23 Feb 2022 15:43:02 +0000 (UTC)
Date:   Wed, 23 Feb 2022 15:42:58 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v11 32/40] kselftest/arm64: Add tests for TPIDR2
Message-ID: <YhZWAnLcBIqhHowG@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-33-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-33-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 07, 2022 at 03:21:01PM +0000, Mark Brown wrote:
> The Scalable Matrix Extension adds a new system register TPIDR2 intended to
> be used by libc for its own thread specific use, add some kselftests which
> exercise the ABI for it.
> 
> Since this test should with some adjustment work for TPIDR and any other
> similar registers added in future add tests for it in a separate
> directory rather than placing it with the other floating point tests,
> nothing existing looked suitable so I created a new test directory
> called "abi".
> 
> Since this feature is intended to be used by libc the test is built as
> freestanding code using nolibc so we don't end up with the test program
> and libc both trying to manage the register simultaneously and
> distrupting each other. As a result of being written using nolibc rather
> than using hwcaps to identify if SME is available in the system we check
> for the default SME vector length configuration in proc, adding hwcap
> support to nolibc seems like disproportionate effort and didn't feel
> entirely idiomatic for what nolibc is trying to do.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
