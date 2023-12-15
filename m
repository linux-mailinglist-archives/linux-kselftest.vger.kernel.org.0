Return-Path: <linux-kselftest+bounces-2013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B66814857
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6971F1C23ADF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 12:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DBC2C6B9;
	Fri, 15 Dec 2023 12:43:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9502C6A2;
	Fri, 15 Dec 2023 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68394C15;
	Fri, 15 Dec 2023 04:44:38 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7635C3F738;
	Fri, 15 Dec 2023 04:43:49 -0800 (PST)
Message-ID: <732aa152-53cc-1101-4292-0906266a4c01@arm.com>
Date: Fri, 15 Dec 2023 12:43:44 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 05/11] arm64: perf: Include threshold control fields in
 PMEVTYPER mask
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 suzuki.poulose@arm.com, mark.rutland@arm.com, anshuman.khandual@arm.com,
 namhyung@gmail.com, Catalin Marinas <catalin.marinas@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Russell King <linux@armlinux.org.uk>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Zaid Al-Bassam <zalbassam@google.com>,
 Raghavendra Rao Ananta <rananta@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20231211161331.1277825-1-james.clark@arm.com>
 <20231211161331.1277825-6-james.clark@arm.com>
 <20231215120817.h2f3akgv72zhrtqo@pengutronix.de>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20231215120817.h2f3akgv72zhrtqo@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/12/2023 12:08, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Dec 11, 2023 at 04:13:17PM +0000, James Clark wrote:
>> FEAT_PMUv3_TH (Armv8.8) adds two new fields to PMEVTYPER, so include
>> them in the mask. These aren't writable on 32 bit kernels as they are in
>> the high part of the register, so only include them for arm64.
>>
>> It would be difficult to do this statically in the asm header files for
>> each platform without resulting in circular includes or #ifdefs inline
>> in the code. For that reason the ARMV8_PMU_EVTYPE_MASK definition has
>> been removed and the mask is constructed programmatically.
>>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> Signed-off-by: James Clark <james.clark@arm.com>
> 
> This change is in today's next as commit
> 3115ee021bfb04efde2e96507bfcc1330261a6a1. this breaks allmodconfig
> building on ARCH=arm:
> 
> 	In file included from include/linux/ratelimit_types.h:5,
> 			 from include/linux/printk.h:9,
> 			 from include/asm-generic/bug.h:22,
> 			 from arch/arm/include/asm/bug.h:60,
> 			 from include/linux/bug.h:5,
> 			 from include/linux/mmdebug.h:5,
> 			 from include/linux/percpu.h:5,
> 			 from include/asm-generic/irq_regs.h:11,
> 			 from ./arch/arm/include/generated/asm/irq_regs.h:1,
> 			 from drivers/perf/arm_pmuv3.c:11:
> 	drivers/perf/arm_pmuv3.c: In function ‘armv8pmu_write_evtype’:
> 	include/linux/bits.h:34:29: error: left shift count >= width of type [-Werror=shift-count-overflow]
> 	   34 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
> 	      |                             ^~
> 	include/linux/bits.h:37:38: note: in expansion of macro ‘__GENMASK’
> 	   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> 	      |                                      ^~~~~~~~~
> 	include/linux/perf/arm_pmuv3.h:238:33: note: in expansion of macro ‘GENMASK’
> 	  238 | #define ARMV8_PMU_EVTYPE_TC     GENMASK(63, 61)
> 	      |                                 ^~~~~~~
> 	drivers/perf/arm_pmuv3.c:567:25: note: in expansion of macro ‘ARMV8_PMU_EVTYPE_TC’
> 	  567 |                 mask |= ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_TH;
> 	      |                         ^~~~~~~~~~~~~~~~~~~
> 	include/linux/bits.h:35:18: error: right shift count is negative [-Werror=shift-count-negative]
> 	   35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> 	      |                  ^~
> 	include/linux/bits.h:37:38: note: in expansion of macro ‘__GENMASK’
> 	   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> 	      |                                      ^~~~~~~~~
> 	include/linux/perf/arm_pmuv3.h:238:33: note: in expansion of macro ‘GENMASK’
> 	  238 | #define ARMV8_PMU_EVTYPE_TC     GENMASK(63, 61)
> 	      |                                 ^~~~~~~
> 	drivers/perf/arm_pmuv3.c:567:25: note: in expansion of macro ‘ARMV8_PMU_EVTYPE_TC’
> 	  567 |                 mask |= ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_TH;
> 	      |                         ^~~~~~~~~~~~~~~~~~~
> 	include/linux/bits.h:34:29: error: left shift count >= width of type [-Werror=shift-count-overflow]
> 	   34 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
> 	      |                             ^~
> 	include/linux/bits.h:37:38: note: in expansion of macro ‘__GENMASK’
> 	   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> 	      |                                      ^~~~~~~~~
> 	include/linux/perf/arm_pmuv3.h:237:33: note: in expansion of macro ‘GENMASK’
> 	  237 | #define ARMV8_PMU_EVTYPE_TH     GENMASK(43, 32)
> 	      |                                 ^~~~~~~
> 	drivers/perf/arm_pmuv3.c:567:47: note: in expansion of macro ‘ARMV8_PMU_EVTYPE_TH’
> 	  567 |                 mask |= ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_TH;
> 	      |                                               ^~~~~~~~~~~~~~~~~~~
> 	include/linux/bits.h:35:18: error: right shift count is negative [-Werror=shift-count-negative]
> 	   35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> 	      |                  ^~
> 	include/linux/bits.h:37:38: note: in expansion of macro ‘__GENMASK’
> 	   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> 	      |                                      ^~~~~~~~~
> 	include/linux/perf/arm_pmuv3.h:237:33: note: in expansion of macro ‘GENMASK’
> 	  237 | #define ARMV8_PMU_EVTYPE_TH     GENMASK(43, 32)
> 	      |                                 ^~~~~~~
> 	drivers/perf/arm_pmuv3.c:567:47: note: in expansion of macro ‘ARMV8_PMU_EVTYPE_TH’
> 	  567 |                 mask |= ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_TH;
> 	      |                                               ^~~~~~~~~~~~~~~~~~~
> 
> I guess that's easy to fix but I didn't look into that.
> 
> Best regards
> Uwe
> 

Thanks for the report. I see that the build is only broken with GCC and
is working with LLVM. I will look into a fix.

Worst case the if can be changed to an #ifdef

James

