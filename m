Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6484C1667
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 16:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiBWPUb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 10:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiBWPUb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 10:20:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D7839698
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 07:20:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C92D61787
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 15:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11248C340E7;
        Wed, 23 Feb 2022 15:19:59 +0000 (UTC)
Date:   Wed, 23 Feb 2022 15:19:56 +0000
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
Subject: Re: [PATCH v11 21/40] arm64/sme: Implement ZA signal handling
Message-ID: <YhZQnKhZsa4U/Ut8@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-22-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-22-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 07, 2022 at 03:20:50PM +0000, Mark Brown wrote:
> Implement support for ZA in signal handling in a very similar way to how
> we implement support for SVE registers, using a signal context structure
> with optional register state after it. Where present this register state
> stores the ZA matrix as a series of horizontal vectors numbered from 0 to
> VL/8 in the endinanness independent format used for vectors.
> 
> As with SVE we do not allow changes in the vector length during signal
> return but we do allow ZA to be enabled or disabled.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

This follows the SVE implementation closely. It looks fine to me:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
