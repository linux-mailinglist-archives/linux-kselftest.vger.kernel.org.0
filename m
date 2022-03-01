Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9728D4C9894
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Mar 2022 23:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiCAW5a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Mar 2022 17:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbiCAW53 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Mar 2022 17:57:29 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A434D79397
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Mar 2022 14:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646175408; x=1677711408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WCgp4Qb2HPWuL7vI5XcOO6Be8JMHMl98QxYb9LSR3a0=;
  b=xHxRidPwb0Q5EMLye8UD2fxUSadpiluqjou9wFMJPtcHcJ1fRGfXbLXa
   lX8riz+dPlSMDCnwnFJtY6o+rH3Bkm90Vk7dLvTJkgat+nBP2RkjYiCzS
   RxG/QvwpohoyBZ9hf85SEekO33/ZJ5i5A7cfAfEaJMFb8RmV6YV88+pC1
   o=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 01 Mar 2022 14:56:47 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 14:56:46 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 1 Mar 2022 14:56:45 -0800
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 1 Mar 2022
 14:56:44 -0800
Date:   Tue, 1 Mar 2022 17:56:41 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        <kvmarm@lists.cs.columbia.edu>,
        "Salil Akerkar" <Salil.Akerkar@arm.com>
Subject: Re: [PATCH v11 03/40] arm64: cpufeature: Always specify and use a
 field width for capabilities
Message-ID: <Yh6kqaR9FQXg8Q4w@qian>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-4-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-4-broonie@kernel.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 07, 2022 at 03:20:32PM +0000, Mark Brown wrote:
> Since all the fields in the main ID registers are 4 bits wide we have up
> until now not bothered specifying the width in the code. Since we now
> wish to use this mechanism to enumerate features from the floating point
> feature registers which do not follow this pattern add a width to the
> table.  This means updating all the existing table entries but makes it
> less likely that we run into issues in future due to implicitly assuming
> a 4 bit width.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Do we leave this one alone on purpose?

                .desc = "GIC system register CPU interface",
                .capability = ARM64_HAS_SYSREG_GIC_CPUIF,
                .type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
                .matches = has_useable_gicv3_cpuif,
                .sys_reg = SYS_ID_AA64PFR0_EL1,
                .field_pos = ID_AA64PFR0_GIC_SHIFT,
                .sign = FTR_UNSIGNED,
                .min_field_value = 1,

Since width == 0, it will generate an undefined behavior.

UBSAN: shift-out-of-bounds in ./arch/arm64/include/asm/cpufeature.h:535:49
 shift exponent 64 is too large for 64-bit type 'long long unsigned int'
 CPU: 0 PID: 0 Comm: swapper Not tainted 5.17.0-rc6-next-20220301 #1
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  dump_stack
  ubsan_epilogue
  __ubsan_handle_shift_out_of_bounds
  has_cpuid_feature
  cpuid_feature_extract_unsigned_field_width at arch/arm64/include/asm/cpufeature.h:535
  (inlined by) cpuid_feature_extract_field_width at arch/arm64/include/asm/cpufeature.h:582
  (inlined by) cpuid_feature_extract_field_width at arch/arm64/include/asm/cpufeature.h:578
  (inlined by) feature_matches at arch/arm64/kernel/cpufeature.c:1317
  (inlined by) has_cpuid_feature at arch/arm64/kernel/cpufeature.c:1335
  has_useable_gicv3_cpuif
  has_useable_gicv3_cpuif at arch/arm64/kernel/cpufeature.c:1389
  update_cpu_capabilities
  init_cpu_features
  cpuinfo_store_boot_cpu
  smp_prepare_boot_cpu
  start_kernel
  __primary_switched
