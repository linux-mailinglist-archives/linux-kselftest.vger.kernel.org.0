Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A89511FA0
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbiD0RMR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 13:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243738AbiD0RMQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 13:12:16 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E900E31374
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 10:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651079343; x=1682615343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RHO/1hBTnfAY0BC4RIzdnoMBlU4LYr9A30YIcQvuxyg=;
  b=mkodAch1JX89LGSiL28jwY50EP/iDAMfm4xS5cyulXZ8JwnA9EphHaGV
   J3czbxpr6TesiH5HFYQ1MjLScRiiohG8vk3AWzyZZEyx7oY1nqHg8u4tY
   hp8JVIUGxBuNb76oR4klS4WkRqC7ZxdjM5+pAggo5pej/pbp6X+h8zq7K
   I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Apr 2022 10:09:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 10:09:02 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 10:09:02 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 10:09:00 -0700
Date:   Wed, 27 Apr 2022 13:08:58 -0400
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
        "Salil Akerkar" <Salil.Akerkar@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>
Subject: Re: [PATCH v14 00/39] arm64/sme: Initial support for the Scalable
 Matrix Extension
Message-ID: <20220427170858.GA2009@qian>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 19, 2022 at 12:22:08PM +0100, Mark Brown wrote:
> This series provides initial support for the ARMv9 Scalable Matrix
> Extension (SME).  SME takes the approach used for vectors in SVE and
> extends this to provide architectural support for matrix operations.  A
> more detailed overview can be found in [1].
> 
> For the kernel SME can be thought of as a series of features which are
> intended to be used together by applications but operate mostly
> orthogonally:
> 
>  - The ZA matrix register.
>  - Streaming mode, in which ZA can be accessed and a subset of SVE
>    features are available.
>  - A second vector length, used for streaming mode SVE and ZA and
>    controlled using a similar interface to that for SVE.
>  - TPIDR2, a new userspace controllable system register intended for use
>    by the C library for storing context related to the ZA ABI.
> 
> A substantial part of the series is dedicated to refactoring the
> existing SVE support so that we don't need to duplicate code for
> handling vector lengths and the SVE registers, this involves creating an
> array of vector types and making the users take the vector type as a
> parameter.  I'm not 100% happy with this but wasn't able to come up with
> anything better, duplicating code definitely felt like a bad idea so
> this felt like the least bad thing.  If this approach makes sense to
> people it might make sense to split this off into a separate series
> and/or merge it while the rest is pending review to try to make things a
> little more digestable, the series is very large so it'd probably make
> things easier to digest if some of the preparatory refactoring could be
> merged before the rest is ready.
> 
> One feature of the architecture of particular note is that switching
> to and from streaming mode may change the size of and invalidate the
> contents of the SVE registers, and when in streaming mode the FFR is not
> accessible.  This complicates aspects of the ABI like signal handling
> and ptrace.
> 
> This initial implementation is mainly intended to get the ABI in place,
> there are several areas which will be worked on going forwards - some of
> these will be blockers, others could be handled in followup serieses:
> 
>  - SME is currently not supported for KVM guests, this will be done as a
>    followup series.  A host system can use SME and run KVM guests but
>    SME is not available in the guests.
>  - The KVM host support is done in a very simplistic way, were anyone to
>    attempt to use it in production there would be performance impacts on
>    hosts with SME support. As part of this we also add enumeration of
>    fine grained traps.
>  - There is not currently ptrace or signal support TPIDR2, this will be
>    done as a followup series.
>  - No support is currently provided for scheduler control of SME or SME
>    applications, given the size of the SME register state the context
>    switch overhead may be noticable so this may be needed especially for
>    real time applications.  Similar concerns already exist for larger
>    SVE vector lengths but are amplified for SME, particularly as the
>    vector length increases.
>  - There has been no work on optimising the performance of anything the
>    kernel does.
> 
> It is not expected that any systems will be encountered that support SME
> but not SVE, SME is an ARMv9 feature and SVE is mandatory for ARMv9.
> The code attempts to handle any such systems that are encountered but
> this hasn't been tested extensively.

Running CPU offline/online on a Neoverse-N1 server will trigger a crash.
A data point is setting CONFIG_ARM64_SVE=n could avoid it.

 kernel BUG at arch/arm64/kernel/cpufeature.c:1353!
 Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
 CPU: 88 PID: 0 Comm: swapper/88 Not tainted 5.18.0-rc4-next-20220426-00006-gfea0cdfbc1de #60
 pstate: 204001c9 (nzCv dAIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __read_sysreg_by_encoding
 lr : has_cpuid_feature
 sp : ffff80000a827d10
 x29: ffff80000a827d10 x28: 0000000000000000 x27: ffffbb3c708efb8a
 x26: 1ffff7678e11df71 x25: 0000000000000002 x24: 0000000000000003
 x23: ffffbb3c75870e80 x22: dfff800000000000 x21: 0000000000000029
 x20: ffffbb3c708efba0 x19: ffffbb3c708efb80 x18: ffffbb3c73eb7d1c
 x17: 000000040044ffff x16: 1fffe7fff0e51474 x15: 1fffe806c1d7b54a
 x14: 1fffe7fff0e5146c x13: 0000000000000004 x12: ffff77678e839850
 x11: 1ffff7678e83984f x10: ffff77678e83984f x9 : ffffbb3c6d7deef0
 x8 : ffffbb3c741cc27f x7 : 0000000000000001 x6 : ffff77678e83984f
 x5 : ffffbb3c741cc278 x4 : 0000000000000000 x3 : 1fffe7fff0e51359
 x2 : 1ffff7678e11df74 x1 : 0000000000180480 x0 : 00000000001804a0
 Call trace:
  __read_sysreg_by_encoding
  has_cpuid_feature
  verify_local_cpu_caps
  verify_local_cpu_capabilities
  check_local_cpu_capabilities
  secondary_start_kernel
  __secondary_switched
 Code: 17ffff34 d5380234 17ffff32 f90013f5 (d4210000)
 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Oops - BUG: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: 0x3b3c657a0000 from 0xffff800008000000
 PHYS_OFFSET: 0x80000000
 CPU features: 0x000,0021700d,19801c82
 Memory Limit: none
 ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---
