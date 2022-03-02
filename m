Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44F54CAB38
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 18:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbiCBRMW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 12:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243694AbiCBRMV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 12:12:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B92D005D
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 09:11:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A062B8210C
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 17:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8DEC340ED;
        Wed,  2 Mar 2022 17:11:28 +0000 (UTC)
Date:   Wed, 2 Mar 2022 17:11:25 +0000
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
Subject: Re: [PATCH v12 22/40] arm64/sme: Implement ptrace support for
 streaming mode SVE registers
Message-ID: <Yh+lPT/TJ4FQfIJ+@arm.com>
References: <20220225165923.1474372-1-broonie@kernel.org>
 <20220225165923.1474372-23-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225165923.1474372-23-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 25, 2022 at 04:59:05PM +0000, Mark Brown wrote:
> The streaming mode SVE registers are represented using the same data
> structures as for SVE but since the vector lengths supported and in use
> may not be the same as SVE we represent them with a new type NT_ARM_SSVE.
> Unfortunately we only have a single 16 bit reserved field available in
> the header so there is no space to fit the current and maximum vector
> length for both standard and streaming SVE mode without redefining the
> structure in a way the creates a complicatd and fragile ABI. Since FFR
> is not present in streaming mode it is read and written as zero.
> 
> Setting NT_ARM_SSVE registers will put the task into streaming mode,
> similarly setting NT_ARM_SVE registers will exit it. Reads that do not
> correspond to the current mode of the task will return the header with
> no register data. For compatibility reasons on write setting no flag for
> the register type will be interpreted as setting SVE registers, though
> users can provide no register data as an alternative mechanism for doing
> so.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
