Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426C6312994
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 04:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBHD4S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Feb 2021 22:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBHD4R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Feb 2021 22:56:17 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB11C06174A;
        Sun,  7 Feb 2021 19:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=r5e0pP3lJ6oc8hBEATfesxmMHxx1NyuwyNkkdpPRZS0=; b=rpKYMsoFiCzLmEQ2Dvo4qBjVyl
        t61Uuhp0KMj3ILsCvBeXtxoklLp7JJ2p7h6fkLvu2auv0bqoV9OnAoRK1DM74Z4vWvsLyW9c2SLwP
        yL78Ap7DKAKUg0mtrx7ys2YbEXhuW/+C2sZ4kgbsMatwdGyXlsx2zL5kuTclcx9q4kT2pJhIOueK5
        5lm5IGrupPAzuLcwXCNpWFZK/R5MRVZtJIZWssW5tA1DExmvMJ8VrjLCU43dGoVqD1WksAw9eVToj
        KUxhs/ENkjJDhr6WtV7xdYt7/I2LK39hxC9RwMD1tmOZvUyGSz3jbeWZ8/RokMx6tcHNK4l1BOV6w
        qpuezpeA==;
Received: from [2601:1c0:6280:3f0::b879]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l8xeA-0005yg-37; Mon, 08 Feb 2021 03:55:34 +0000
Subject: Re: [PATCH v3 1/7] seqnum_ops: Introduce Sequence Number Ops
To:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net,
        gregkh@linuxfoundation.org, peterz@infradead.org,
        keescook@chromium.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc:     devel@driverdev.osuosl.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <cover.1612314468.git.skhan@linuxfoundation.org>
 <23f6347a7bb9f902babe7351f71b23644035673d.1612314468.git.skhan@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8f64e963-e0d6-e9a2-41c3-206bed440cde@infradead.org>
Date:   Sun, 7 Feb 2021 19:55:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <23f6347a7bb9f902babe7351f71b23644035673d.1612314468.git.skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi--
Comments are inline.

On 2/3/21 10:11 AM, Shuah Khan wrote:
> Sequence Number api provides interfaces for unsigned atomic up counters.
> 
> There are a number of atomic_t usages in the kernel where atomic_t api
> is used for counting sequence numbers and other statistical counters.
> Several of these usages, convert atomic_read() and atomic_inc_return()
> return values to unsigned. Introducing sequence number ops supports
> these use-cases with a standard core-api.
> 
> Sequence Number ops provide interfaces to initialize, increment and get
> the sequence number. These ops also check for overflow and log message to
> indicate when overflow occurs.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  Documentation/core-api/index.rst      |   1 +
>  Documentation/core-api/seqnum_ops.rst |  53 ++++++++++
>  MAINTAINERS                           |   7 ++
>  include/linux/seqnum_ops.h            | 129 +++++++++++++++++++++++++
>  lib/Kconfig                           |   9 ++
>  lib/Makefile                          |   1 +
>  lib/test_seqnum_ops.c                 | 133 ++++++++++++++++++++++++++
>  7 files changed, 333 insertions(+)
>  create mode 100644 Documentation/core-api/seqnum_ops.rst
>  create mode 100644 include/linux/seqnum_ops.h
>  create mode 100644 lib/test_seqnum_ops.c


> diff --git a/Documentation/core-api/seqnum_ops.rst b/Documentation/core-api/seqnum_ops.rst
> new file mode 100644
> index 000000000000..ed4eba394799
> --- /dev/null
> +++ b/Documentation/core-api/seqnum_ops.rst
> @@ -0,0 +1,53 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: <isonum.txt>
> +
> +.. _seqnum_ops:
> +
> +==========================
> +Sequence Number Operations
> +==========================
> +
> +:Author: Shuah Khan
> +:Copyright: |copy| 2021, The Linux Foundation
> +:Copyright: |copy| 2021, Shuah Khan <skhan@linuxfoundation.org>
> +
> +Sequence Number api provides interfaces for unsigned up counters.

                   API

> +
> +Sequence Number Ops
> +===================
> +
> +seqnum32 and seqnum64 types support implementing unsigned up counters. ::
> +
> +        struct seqnum32 { u32 seqnum; };
> +        struct seqnum64 { u64 seqnum; };
> +
> +Initializers
> +------------
> +
> +Interfaces for initializing sequence numbers. ::
> +
> +        #define SEQNUM_INIT(i)    { .seqnum = i }
> +        seqnum32_init(seqnum, val)
> +        seqnum64_init(seqnum, val)
> +
> +Increment interface
> +-------------------
> +
> +Increments sequence number and returns the new value. Checks for overflow
> +conditions and logs message when overflow occurs. This check is intended
> +to help catch cases where overflow could lead to problems. ::
> +
> +        seqnum32_inc(seqnum): Calls atomic_inc_return(seqnum).
> +        seqnum64_inc(seqnum): Calls atomic64_inc_return(seqnum).
> +
> +Return/get value interface
> +--------------------------
> +
> +Returns sequence number value. ::
> +
> +        seqnum32_get() - return seqnum value.
> +        seqnum64_get() - return seqnum value.
> +
> +.. warning::
> +        seqnum32 wraps around to INT_MIN when it overflows.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc1e6a5ee6e6..f9fe1438a8cd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16235,6 +16235,13 @@ S:	Maintained
>  F:	Documentation/fb/sm712fb.rst
>  F:	drivers/video/fbdev/sm712*
>  
> +SEQNUM OPS
> +M:	Shuah Khan <skhan@linuxfoundation.org>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	include/linux/seqnum_ops.h
> +F:	lib/test_seqnum_ops.c
> +
>  SIMPLE FIRMWARE INTERFACE (SFI)
>  S:	Obsolete
>  W:	http://simplefirmware.org/
> diff --git a/include/linux/seqnum_ops.h b/include/linux/seqnum_ops.h
> new file mode 100644
> index 000000000000..e8d8481445d3
> --- /dev/null
> +++ b/include/linux/seqnum_ops.h
> @@ -0,0 +1,129 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * seqnum_ops.h - Interfaces for unsigned atomic sequential up counters.
> + *
> + * Copyright (c) 2021 Shuah Khan <skhan@linuxfoundation.org>
> + * Copyright (c) 2021 The Linux Foundation
> + *
> + * Sequence Number functions provide support for unsgined atomic up

                                                    unsigned

> + * counters.
> + *
> + * The interface provides:
> + * seqnumu32 & seqnumu64 functions:
> + *	initialization
> + *	increment and return
> + *
> + * seqnumu32 and seqnumu64 functions leverage/use atomic*_t ops to
> + * implement support for unsigned atomic up counters.
> + *
> + * Reference and API guide:
> + *	Documentation/core-api/seqnum_ops.rst for more information.
> + */
> +
> +#ifndef __LINUX_SEQNUM_OPS_H
> +#define __LINUX_SEQNUM_OPS_H
> +
> +#include <linux/atomic.h>
> +
> +/**
> + * struct seqnum32 - Sequence number atomic counter
> + * @seqnum: atomic_t
> + *
> + **/
> +struct seqnum32 {
> +	u32 seqnum;
> +};
> +
> +#define SEQNUM_INIT(i)		{ .seqnum = i }
> +
> +/*
> + * seqnum32_init() - initialize seqnum value
> + * @seq: struct seqnum32 pointer
> + *
> + */
> +static inline void seqnum32_init(struct seqnum32 *seq, u32 val)
> +{
> +	seq->seqnum = val;
> +}
> +
> +/*
> + * seqnum32_inc() - increment seqnum value and return the new value
> + * @seq: struct seqnum32 pointer
> + *
> + * Return u32

It would be good to convert that to kernel-doc notation.

> + */
> +static inline u32 seqnum32_inc(struct seqnum32 *seq)
> +{
> +	atomic_t val = ATOMIC_INIT(seq->seqnum);
> +
> +	seq->seqnum = (u32) atomic_inc_return(&val);
> +	if (seq->seqnum >= UINT_MAX)
> +		pr_info("Sequence Number overflow %u detected\n",
> +			seq->seqnum);
> +	return seq->seqnum;
> +}
> +
> +/*
> + * seqnum32_get() - get seqnum value
> + * @seq: struct seqnum32 pointer
> + *
> + * Return u32
> + */
> +static inline u32 seqnum32_get(struct seqnum32 *seq)
> +{
> +	return seq->seqnum;
> +}
> +
> +/*
> + * struct seqnum64 - Sequential/Statistical atomic counter
> + * @seq: atomic64_t
> + *
> + */
> +struct seqnum64 {
> +	u64 seqnum;
> +};
> +
> +/* Add to a global include/vdso/limits.h and fix all other UINT64_MAX
> + * duplicate defines?
> + */
> +#define SEQ_UINT64_MAX	((u64)(~((u64) 0)))	/* 0xFFFFFFFFFFFFFFFF */
> +
> +/*
> + * seqnum64_init() - initialize seqnum value
> + * @seq: struct seqnum64 pointer
> + *
> + */

and kernel-doc there also.

> +static inline void seqnum64_init(struct seqnum64 *seq, u64 val)
> +{
> +	seq->seqnum = val;
> +}
> +
> +/*
> + * seqnum64_inc() - increment seqnum value and return the new value
> + * @seq: struct seqnum64 pointer
> + *
> + * Return u64
> + */
> +static inline u64 seqnum64_inc(struct seqnum64 *seq)
> +{
> +	atomic64_t val = ATOMIC_INIT(seq->seqnum);
> +
> +	seq->seqnum = (u64) atomic64_inc_return(&val);
> +	if (seq->seqnum >= SEQ_UINT64_MAX)
> +		pr_info("Sequence Number overflow %llu detected\n",
> +			seq->seqnum);
> +	return seq->seqnum;
> +}
> +
> +/*
> + * seqnum64_get() - get seqnum value
> + * @seq: struct seqnum64 pointer
> + *
> + * Return u64
> + */
> +static inline u64 seqnum64_get(struct seqnum64 *seq)
> +{
> +	return (u64) seq->seqnum;
> +}
> +
> +#endif /* __LINUX_SEQNUM_OPS_H */


> diff --git a/lib/test_seqnum_ops.c b/lib/test_seqnum_ops.c
> new file mode 100644
> index 000000000000..173278314f26
> --- /dev/null
> +++ b/lib/test_seqnum_ops.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * test_seqnum_ops.c - Kernel module for testing Seqnum API
> + *
> + * Copyright (c) 2021 Shuah Khan <skhan@linuxfoundation.org>
> + * Copyright (c) 2021 The Linux Foundation
> + *
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/seqnum_ops.h>
> +
>
...

> +static void test_seqnum64(void)
> +{
> +	u64 start_val = 0;
> +	struct seqnum64 seq = SEQNUM_INIT(start_val);
> +	u64 end_val;
> +
> +	end_val = seqnum64_inc(&seq);
> +	test_seqnum64_result("Test increment",
> +			     start_val, end_val, start_val+1);
> +
> +	/* Initialize sequence number to 0 */
> +	seqnum64_init(&seq, start_val);
> +	end_val = seqnum64_inc(&seq);
> +
> +	/* if seqnum642_init() works correctly end_val should be 1 */

	      seqnum64_init()
AFAICT.

> +	test_seqnum64_result("Test init", start_val, end_val, 1);
> +	/* seqnum64_get() test for seqnum value == 1 */
> +	start_val = end_val = seqnum64_get(&seq);
> +	test_seqnum64_result("Test get", start_val, end_val, 1);
> +}
> +


-- 
~Randy

