Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAB546FEDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 11:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbhLJKpC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 05:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbhLJKpB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 05:45:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F41C061746
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 02:41:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5B50B8275F
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 10:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F408C00446;
        Fri, 10 Dec 2021 10:41:22 +0000 (UTC)
Date:   Fri, 10 Dec 2021 10:41:18 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 13/37] arm64/sme: Basic enumeration support
Message-ID: <YbMuzjU/MSTwBDLY@arm.com>
References: <20211115152835.3212149-1-broonie@kernel.org>
 <20211115152835.3212149-14-broonie@kernel.org>
 <YbJN1ujpDP1RG1Ll@arm.com>
 <YbJY0P1KZjSFfwtY@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbJY0P1KZjSFfwtY@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 09, 2021 at 07:28:16PM +0000, Mark Brown wrote:
> On Thu, Dec 09, 2021 at 06:41:26PM +0000, Catalin Marinas wrote:
> > On Mon, Nov 15, 2021 at 03:28:11PM +0000, Mark Brown wrote:
> > > +#define HWCAP2_SME		(1 << 20)
> > > +#define HWCAP2_SME_I16I64	(1 << 21)
> > > +#define HWCAP2_SME_F64F64	(1 << 22)
> > > +#define HWCAP2_SME_I8I32	(1 << 23)
> > > +#define HWCAP2_SME_F16F32	(1 << 24)
> > > +#define HWCAP2_SME_B16F32	(1 << 25)
> > > +#define HWCAP2_SME_F32F32	(1 << 26)
> > > +#define HWCAP2_SME_FA64		(1 << 27)
> 
> > At this pace we'll need HWCAP3 pretty soon (since we only allocated
> > 32-bit in each). I wonder whether we could instead not bother at all and
> > just provide user-space emulation for ID_AA64SMFR0_EL1.
> 
> I think so if people are willing to go along with just having userspace
> check the ID register (IIRC access to it already does the right thing
> but I need to confirm).  We'll also need to think about how we handle
> any new SVE features, that's got a similar thing going on and is most of
> the existing usage of HWCAP2.

It would be good to get feedback from the libc people. IIRC the ifunc
resolver relies currently on the HWCAP bits. Could this be adapted to
use the MRS instruction? We'd still keep the main HWCAP2_SME but without
the finer-grained bits.

The other option is to start going into the upper 32-bit of the
elf_hwcap. We tried to avoid this some time back when we were still
having doubts about merging ILP32.

> > > +	{
> > > +		.desc = "FA64",
> > > +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > > +		.capability = ARM64_SME_FA64,
> > > +		.sys_reg = SYS_ID_AA64SMFR0_EL1,
> > > +		.sign = FTR_UNSIGNED,
> > > +		.field_pos = ID_AA64SMFR0_FA64_SHIFT,
> > > +		.min_field_value = ID_AA64SMFR0_FA64,
> > > +		.matches = has_feature_flag,
> > > +		.cpu_enable = fa64_kernel_enable,
> > > +	},
> 
> > I'll comment here rather than the patch introducing has_feature_flag():
> > an alternative would be to add a .field_width option and in
> > feature_matches() use cpuid_feature_extract_field_width() directly. All
> > the arm64_ftr_bits entries already have a width, so just generalise it
> > for arm64_cpu_capabilities.
> 
> Sure, if people are happy with that - it's a more invasive change since
> we don't currently set the widths, I wasn't clear if that was a case of
> not needing it right now or a design decision.

We didn't have a field_width since they were all 4 bits until SVE. If
you don't want to touch all the entries in the array, we can say that a
0 value (i.e. not explicitly initialised) means default 4 and update it
during init_cpu_features().

-- 
Catalin
