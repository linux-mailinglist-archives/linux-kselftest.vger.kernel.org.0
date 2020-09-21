Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC456272DE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Sep 2020 18:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgIUQni (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Sep 2020 12:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbgIUQne (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Sep 2020 12:43:34 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91756238E6;
        Mon, 21 Sep 2020 16:43:32 +0000 (UTC)
Date:   Mon, 21 Sep 2020 17:43:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Gabor Kertesz <gabor.kertesz@arm.com>,
        linux-kselftest@vger.kernel.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] kselftest/arm64: Add utilities and a test to
 validate mte memory
Message-ID: <20200921164329.GD13882@gaia>
References: <20200901092719.9918-1-amit.kachhap@arm.com>
 <20200901092719.9918-2-amit.kachhap@arm.com>
 <20200921141817.GC13882@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921141817.GC13882@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 21, 2020 at 03:18:19PM +0100, Catalin Marinas wrote:
> On Tue, Sep 01, 2020 at 02:57:14PM +0530, Amit Daniel Kachhap wrote:
> > diff --git a/tools/testing/selftests/arm64/mte/mte_helper.S b/tools/testing/selftests/arm64/mte/mte_helper.S
> > new file mode 100644
> > index 000000000000..91af6d1293f8
> > --- /dev/null
> > +++ b/tools/testing/selftests/arm64/mte/mte_helper.S
> > @@ -0,0 +1,116 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (C) 2020 ARM Limited */
> > +
> > +#include "mte_def.h"
> > +
> > +#define ENTRY(name) \
> > +	.globl name ;\
> > +	.p2align 2;\
> > +	.type name, @function ;\
> > +name:
> > +
> > +#define ENDPROC(name) \
> > +	.size name, .-name ;
> > +
> > +	.text
> > +/*
> > + * mte_insert_random_tag: Insert random tag and different from
> > + *			 the orginal tag if source pointer has it.
> > + * Input:
> > + *		x0 - source pointer with a tag/no-tag
> > + * Return:
> > + *		x0 - pointer with random tag
> > + */
> > +ENTRY(mte_insert_random_tag)
> > +	mov	x1, #0x0
> > +	gmi	x1, x0, x1
> > +	irg	x0, x0, x1
> > +	ret
> > +ENDPROC(mte_insert_random_tag)
> 
> What was the reason for gmi here? The test fails when you have an
> include mask of 0x8000 (exclude mask 0x7fff) and x0 has tag 0xf. In this
> case we exclude the only allowed tag here, so the CPU falls back to the
> default tag 0.
> 
> You can (a) stop the check_multiple_included_tags() earlier to have two
> allowed tags here, (b) clear the pointer old tag so that you don't end
> up in this scenario or (c) simply remove the gmi. My preference is the
> latter, we don't test the hardware here, we only want to check whether
> the kernel sets the GCR_EL1 correctly.
> 
> BTW, you also remove mov x1, #0, just:
> 
> 	irg	x0, x0, xzr

Ah, removing gmi breaks the check_user_mem test as it occasionally gets
the same tag when it expects to be different. I'll leave this to you to
fix, maybe use two different functions, one with gmi and another
without.

In addition, could you please add the PR_MTE_* definitions and PROT_MTE
to a header file in the MTE kselftests (mte-def.h maybe)? They should be
bracketed with #ifndef ... #endif. The reason is that we'd like to queue
these patches on their own branch on top of vanilla 5.9-rc3 rather than
on top of for-next/mte.

Thanks.

-- 
Catalin
