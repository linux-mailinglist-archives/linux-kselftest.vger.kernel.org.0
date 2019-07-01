Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 550DB4E2BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2019 11:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfFUJMD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jun 2019 05:12:03 -0400
Received: from foss.arm.com ([217.140.110.172]:52154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfFUJMD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jun 2019 05:12:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98C30360;
        Fri, 21 Jun 2019 02:12:02 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3041B3F246;
        Fri, 21 Jun 2019 02:12:00 -0700 (PDT)
Subject: Re: [PATCH v6 00/19] Unify vDSOs across more architectures
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huw Davies <huw@codeweavers.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Burton <paul.burton@mips.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190620172746.7f92cb14@donnerap.cambridge.arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <40c3e4e9-96d3-f940-f5cb-ed97762ef9b0@arm.com>
Date:   Fri, 21 Jun 2019 10:11:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620172746.7f92cb14@donnerap.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 20/06/2019 17:27, Andre Przywara wrote:
> On Thu, 30 May 2019 15:15:12 +0100
> Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
> 
> Hi,
> 
>> vDSO (virtual dynamic shared object) is a mechanism that the Linux
>> kernel provides as an alternative to system calls to reduce where
>> possible the costs in terms of cycles.
>> [ ... ]
>> The porting has been benchmarked and the performance results are
>> provided as part of this cover letter.
> 
> I can't reveal the absolute numbers here, but vdsotest-bench gives me
> quite some performance gain on my board here ("time needed on v6" divided
> by "time needed on 5.2-rc1", so smaller percentages are better):
> clock-gettime-monotonic:	23 %
> clock-gettime-monotonic-raw:	30 %
> clock-gettime-tai:		 5 %
> clock-getres-tai:		 5 %
> clock-gettime-boottime:		 5 %
> clock-getres-boottime:		 5 %
> clock-gettime-realtime:		25 %
> gettimeofday:			26 % 
> The other numbers stayed the same or differed by just 1 ns, which seems to
> be within the margin of error, as repeated runs on the same kernel suggest.
> The 5% numbers are of course those were we went from a syscall-only to the
> newly added arm64 VDSO implementation, but even the other calls improved
> by a factor of 3 or more.
> 
> Sounds like a strong indicator that this is a good thing to have.
> 
> Not sure if "running some benchmark a couple of times on a single machine"
> qualifies for this, but I guess it means:
> 
> Tested-by: Andre Przywara <andre.przywara@arm.com>
>

Thanks Andre, it sounds great! I will add your tag as well to my patches.

> Cheers,
> Andre.
> 

-- 
Regards,
Vincenzo
