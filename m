Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6574C1746
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 16:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241541AbiBWPmg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 10:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242302AbiBWPme (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 10:42:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9FEBF530
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 07:42:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6906861834
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 15:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013E2C340E7;
        Wed, 23 Feb 2022 15:41:59 +0000 (UTC)
Date:   Wed, 23 Feb 2022 15:41:56 +0000
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
Subject: Re: [PATCH v11 29/40] arm64/sme: Provide Kconfig for SME
Message-ID: <YhZVxGypfxWBJwEw@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-30-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-30-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 07, 2022 at 03:20:58PM +0000, Mark Brown wrote:
> Now that basline support for the Scalable Matrix Extension (SME) is present
> introduce the Kconfig option allowing it to be built. While the feature
> registers don't impose a strong requirement for a system with SME to
> support SVE at runtime the support for streaming mode SVE is mostly
> shared with normal SVE so depend on SVE.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
