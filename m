Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5AE3B2D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2019 12:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbfFJKRw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jun 2019 06:17:52 -0400
Received: from foss.arm.com ([217.140.110.172]:39722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388396AbfFJKRw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jun 2019 06:17:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94DFE337;
        Mon, 10 Jun 2019 03:17:51 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 090B03F557;
        Mon, 10 Jun 2019 03:19:30 -0700 (PDT)
Subject: Re: [PATCH v6 01/19] kernel: Standardize vdso_datapage
To:     Huw Davies <huw@codeweavers.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-2-vincenzo.frascino@arm.com>
 <20190610092751.GA11076@merlot.physics.ox.ac.uk>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <58cedde2-0d54-7d2d-f519-77cb71f543fd@arm.com>
Date:   Mon, 10 Jun 2019 11:17:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190610092751.GA11076@merlot.physics.ox.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Huw,

thank you for your review.

On 10/06/2019 10:27, Huw Davies wrote:
> On Thu, May 30, 2019 at 03:15:13PM +0100, Vincenzo Frascino wrote:
>> --- /dev/null
>> +++ b/include/vdso/datapage.h
>> @@ -0,0 +1,91 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __VDSO_DATAPAGE_H
>> +#define __VDSO_DATAPAGE_H
>> +
>> +#ifdef __KERNEL__
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#include <linux/bits.h>
>> +#include <linux/time.h>
>> +#include <linux/types.h>
>> +
>> +#define VDSO_BASES	(CLOCK_TAI + 1)
>> +#define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
>> +			 BIT(CLOCK_MONOTONIC)		| \
>> +			 BIT(CLOCK_BOOTTIME)		| \
>> +			 BIT(CLOCK_TAI))
>> +#define VDSO_COARSE	(BIT(CLOCK_REALTIME_COARSE)	| \
>> +			 BIT(CLOCK_MONOTONIC_COARSE))
>> +#define VDSO_RAW	(BIT(CLOCK_MONOTONIC_RAW))
>> +
>> +#define CS_HRES_COARSE	0
>> +#define CS_RAW		1
> 
> CS_HRES_COARSE seems like a confusing name choice to me.  What you
> really mean is not RAW.
> 
> How about CS_ADJ to indicate that its updated by adjtime?
> CS_XTIME might be another option.
> 

I divided the timers in 3 sets (HRES, COARSE, RAW), CS_HRES_COARSE refers to the
first two and CS_RAW to the third. I will ad a comment to explain the logic in
the next iteration.

> Huw.
> 

-- 
Regards,
Vincenzo
