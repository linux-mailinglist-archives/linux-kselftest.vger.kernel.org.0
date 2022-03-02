Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B684CA43E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 12:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiCBLxk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 06:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbiCBLxj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 06:53:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833C448E6D
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 03:52:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F49D618A2
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 11:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE279C004E1;
        Wed,  2 Mar 2022 11:52:52 +0000 (UTC)
Date:   Wed, 2 Mar 2022 11:52:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Alan Hayward <alan.hayward@arm.com>,
        kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>
Subject: Re: [PATCH v11 03/40] arm64: cpufeature: Always specify and use a
 field width for capabilities
Message-ID: <Yh9akZaM+qeWPgEz@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-4-broonie@kernel.org>
 <Yh6kqaR9FQXg8Q4w@qian>
 <878rts3bpi.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rts3bpi.wl-maz@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 02, 2022 at 10:12:09AM +0000, Marc Zyngier wrote:
> On Tue, 01 Mar 2022 22:56:41 +0000,
> Qian Cai <quic_qiancai@quicinc.com> wrote:
> > 
> > On Mon, Feb 07, 2022 at 03:20:32PM +0000, Mark Brown wrote:
> > > Since all the fields in the main ID registers are 4 bits wide we have up
> > > until now not bothered specifying the width in the code. Since we now
> > > wish to use this mechanism to enumerate features from the floating point
> > > feature registers which do not follow this pattern add a width to the
> > > table.  This means updating all the existing table entries but makes it
> > > less likely that we run into issues in future due to implicitly assuming
> > > a 4 bit width.
> > > 
> > > Signed-off-by: Mark Brown <broonie@kernel.org>
> > 
> > Do we leave this one alone on purpose?
> > 
> >                 .desc = "GIC system register CPU interface",
> >                 .capability = ARM64_HAS_SYSREG_GIC_CPUIF,
> >                 .type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
> >                 .matches = has_useable_gicv3_cpuif,
> >                 .sys_reg = SYS_ID_AA64PFR0_EL1,
> >                 .field_pos = ID_AA64PFR0_GIC_SHIFT,
> >                 .sign = FTR_UNSIGNED,
> >                 .min_field_value = 1,
> >
> > Since width == 0, it will generate an undefined behavior.
> 
> I don't think that's on purpose, and we should definitely address
> this. Maybe we should have a warning if we spot an occurrence of
> .width being 0.

We should indeed have a check. Alternatively, assume the default to be 4
and convert all 0s to 4 during boot (less patch churn).

-- 
Catalin
