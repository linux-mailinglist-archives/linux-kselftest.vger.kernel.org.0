Return-Path: <linux-kselftest+bounces-47528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBCDCB9C2A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 21:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2F61304D0F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 20:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164F731062D;
	Fri, 12 Dec 2025 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vlENiZg0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401E630FC04
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765571271; cv=none; b=U1tGgR2n0rhF67Do1lVaoKmjWKTQI2Sj2jgX/o0TkBLGtrYdRVzm3Q2nNvKuWw7LxoyMWOMNn7A71DtifQP8KXQgPXvDxzMBEZuS18OEAI1zlIVBdacWLzUzblg9/qmbqhfFOcsJsYtV3oGnR4hy7wlmZo11kY/O/lnlZKJeHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765571271; c=relaxed/simple;
	bh=xi7nKKP19jWf1tsN8ro67KKFXkP+49bDKSOt9hT+rz0=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=WHgpgvyBiVB7RjL3/ZKiq9QFT2dFAQN2AbHnaWoKIL/6g5OxKoWd28Qa5W2yFb9PEVFmPwQRJeyAZhVnA6Q/oPH9OmViKvsHc37fUcviaqxqa15VS2PPYNmdPPAdRESaRK+FTzvnaVcNIhf3kuPq2jgpan8bANSqN0NFOJjv4BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vlENiZg0; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-4501735f488so2345239b6e.2
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 12:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765571268; x=1766176068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fzm/tsqAvW56TDo978ZmdNBfUInnyBjt6fplMac4YIM=;
        b=vlENiZg0zDQdsEARe6eUZN7+/2n2qlBaaqKLosM9rU5da8OugtAYhEnIaCUskcvDyL
         fx67tiArY/BZVHN7S7XxdB40gRRHMKINmuQfd8m8CBHuMCmjdquF4KgkYPRsYgMJqp+P
         AerNUT9L7cUGN+XcWuJczw+nwSVOqe1NPxF5mmuDkpFcx/gMUDPpEQyD4RTaUk0rHpnj
         xxZnENVMiHhVJOSr4lyEZc2GqNfUvaeyc3arNSyy+jkcEtRTqg7IGHUz4TmcYT4sChD+
         NR4HmSBDN4/p9j5M4PUG/GiL9VLR7564LrelWsuE3fRVPtoeRKscHILoxsnrCXWrYJH0
         jGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765571268; x=1766176068;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzm/tsqAvW56TDo978ZmdNBfUInnyBjt6fplMac4YIM=;
        b=MWIbAYfqWjdbvkelZBzJjnBbApJTAQC28lm2dQaGlwaAo+jccHXgO9qDxRB08tForu
         oDZ92Rbw5/Bw2Hmy2H1zkw3uFVBk3V6+sEnX1W9lPmwJfq87HOxAjOZlfz9jjBELWgnH
         E/ZPSRGRTDm99Yj0VYvC+ctUn+tQs+dbZGbV/Do3+Qm6cn2x0atS+lIc1x/DQi6Rwtsk
         ZUMdIB+TS8LI6ylf97XQEDNVEvVw4gKgZkfhS6099tWTNM9bBCc0b53GBYiVZH1ZEQHT
         9x9m7QqiBwD8kugy0EAO/enbgZ0tpPV2WVnVOCRYrZWRWbyuMMZXz61OZUxSWACpI0ju
         rEPg==
X-Forwarded-Encrypted: i=1; AJvYcCWFSF+f2glvnkfx3y/71mnarS39d9XBBezgAtpL6zqIajerVVJsbk3JLkePuGloWSPO0qXqk2ZTcOQM3+mVi3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNrbm4/25P23R94R2NrZFVbuTH8qBAfazItzxdLWTWWcz+A29
	avdvVEnryemAdrUVVFMWt/zxt0uFMRLKRVJo9Zw/rKxqZs15SYPCz/9T4qn8j2hrFexHqk2IyYz
	CjCHojMN13z6u58Rdqk8PuyDHyA==
X-Google-Smtp-Source: AGHT+IHtS4CSArf4CIQyXaQ3gTcwhHkWk1+dzcc15H4XApucHfZc+0GcjKfr0Sr/upH3+2NzDR6Jy4cUsIgV3mtOEg==
X-Received: from oiks6-n2.prod.google.com ([2002:a05:6808:a606:20b0:450:c024:a4f7])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4fd0:b0:44d:a0ec:d9a5 with SMTP id 5614622812f47-455ac822609mr1365623b6e.1.1765571268278;
 Fri, 12 Dec 2025 12:27:48 -0800 (PST)
Date: Fri, 12 Dec 2025 20:27:47 +0000
In-Reply-To: <202512110209.GjVZa9ti-lkp@intel.com> (message from kernel test
 robot on Thu, 11 Dec 2025 02:31:00 +0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt4ipv4f98.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 11/24] KVM: arm64: Writethrough trapped PMEVTYPER register
From: Colton Lewis <coltonlewis@google.com>
To: kernel test robot <lkp@intel.com>
Cc: kvm@vger.kernel.org, oe-kbuild-all@lists.linux.dev, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, skhan@linuxfoundation.org, 
	gankulkarni@os.amperecomputing.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

kernel test robot <lkp@intel.com> writes:

> Hi Colton,

> kernel test robot noticed the following build errors:

> [auto build test ERROR on ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d]

> url:     
> https://github.com/intel-lab-lkp/linux/commits/Colton-Lewis/arm64-cpufeature-Add-cpucap-for-HPMN0/20251210-055309
> base:   ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
> patch link:     
> https://lore.kernel.org/r/20251209205121.1871534-12-coltonlewis%40google.com
> patch subject: [PATCH v5 11/24] KVM: arm64: Writethrough trapped  
> PMEVTYPER register
> config: arm64-randconfig-001-20251210  
> (https://download.01.org/0day-ci/archive/20251211/202512110209.GjVZa9ti-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 14.3.0
> reproduce (this is a W=1 build):  
> (https://download.01.org/0day-ci/archive/20251211/202512110209.GjVZa9ti-lkp@intel.com/reproduce)

> If you fix the issue in a separate patch/commit (i.e. not just a new  
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:  
> https://lore.kernel.org/oe-kbuild-all/202512110209.GjVZa9ti-lkp@intel.com/

> All errors (new ones prefixed by >>):

>     arch/arm64/kvm/sys_regs.c: In function 'writethrough_pmevtyper':
>>> arch/arm64/kvm/sys_regs.c:1183:34: error: implicit declaration of  
>>> function 'kvm_pmu_event_mask'; did you mean 'kvm_pmu_evtyper_mask'?  
>>> [-Wimplicit-function-declaration]
>      1183 |                 eventsel = val & kvm_pmu_event_mask(vcpu->kvm);
>           |                                  ^~~~~~~~~~~~~~~~~~
>           |                                  kvm_pmu_evtyper_mask


Caused by missing a stub definition for kvm_pmu_event_mask when
reorganizing headers in patch 6: Reorganize PMU functions

Fixed

> vim +1183 arch/arm64/kvm/sys_regs.c

>    1168
>    1169	static bool writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct  
> sys_reg_params *p,
>    1170					   u64 reg, u64 idx)
>    1171	{
>    1172		u64 eventsel;
>    1173		u64 val = p->regval;
>    1174		u64 evtyper_set = ARMV8_PMU_EXCLUDE_EL0 |
>    1175			ARMV8_PMU_EXCLUDE_EL1;
>    1176		u64 evtyper_clr = ARMV8_PMU_INCLUDE_EL2;
>    1177
>    1178		__vcpu_assign_sys_reg(vcpu, reg, val);
>    1179
>    1180		if (idx == ARMV8_PMU_CYCLE_IDX)
>    1181			eventsel = ARMV8_PMUV3_PERFCTR_CPU_CYCLES;
>    1182		else
>> 1183			eventsel = val & kvm_pmu_event_mask(vcpu->kvm);
>    1184
>    1185		if (vcpu->kvm->arch.pmu_filter &&
>    1186		    !test_bit(eventsel, vcpu->kvm->arch.pmu_filter))
>    1187			val |= evtyper_set;
>    1188
>    1189		val &= ~evtyper_clr;
>    1190
>    1191		if (idx == ARMV8_PMU_CYCLE_IDX)
>    1192			write_pmccfiltr(val);
>    1193		else
>    1194			write_pmevtypern(idx, val);
>    1195
>    1196		return true;
>    1197	}
>    1198

> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

