Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1078F2DD431
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 16:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgLQP3f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 10:29:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46956 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLQP3d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 10:29:33 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608218931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EIcpuCdPdjtUIDDq5V1Kd6Nd1DvDsLvtJ/iV0ZcMRgA=;
        b=3/uIVXk04WU6Kuue5KdK/PZzRT3PQRQci3lkMWxtnm0m12Qkt5QmdLW1qQQiqnAFp2hZp5
        QzFq2fC1v1lLeWxspvs7ZktqDZYepiYqq++tBMgUhzKOe2wtg66cawjCw02bRBA1+2Djdc
        4KqVMkPy5/ypITooF8IgTBcIQjsKSpTImchFsyfvoJm7nqCiKy3U5DR28Hag30uG9YGgov
        RUvtLmBoVLaNPRF+SFiF/2wkaVq1oYPqBJmTNbWB4E7TQFmDGdSdnkPdaiSRXTI2qchLhb
        YTBG4YlbqP+sIR9BHSNaYY0o6m7NSpXCZrdp1Gbc1GfXIGh0T78z8Dt66x3VyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608218931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EIcpuCdPdjtUIDDq5V1Kd6Nd1DvDsLvtJ/iV0ZcMRgA=;
        b=9yQmqCVKnv9+iECxfpPNtEbdep6NKjLzINPHlJVMXIR0uStpoRGsed4or02lEAiC+4QayK
        TZlxdiWrObB1IHAQ==
To:     ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 06/10] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <20201106232908.364581-7-ira.weiny@intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-7-ira.weiny@intel.com>
Date:   Thu, 17 Dec 2020 16:28:51 +0100
Message-ID: <87y2hwqwng.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 06 2020 at 15:29, ira weiny wrote:
> +#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> +/*
> + * PKRS is a per-logical-processor MSR which overlays additional protection for
> + * pages which have been mapped with a protection key.
> + *
> + * The register is not maintained with XSAVE so we have to maintain the MSR
> + * value in software during context switch and exception handling.
> + *
> + * Context switches save the MSR in the task struct thus taking that value to
> + * other processors if necessary.
> + *
> + * To protect against exceptions having access to this memory we save the
> + * current running value and set the PKRS value for the duration of the
> + * exception.  Thus preventing exception handlers from having the elevated
> + * access of the interrupted task.
> + */
> +noinstr void irq_save_set_pkrs(irqentry_state_t *irq_state, u32 val)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
> +		return;
> +
> +	irq_state->thread_pkrs = current->thread.saved_pkrs;
> +	write_pkrs(INIT_PKRS_VALUE);

Why is this noinstr? Just because it's called from a noinstr function?

Of course the function itself violates the noinstr constraints:

  vmlinux.o: warning: objtool: write_pkrs()+0x36: call to do_trace_write_msr() leaves .noinstr.text section

There is absolutely no reason to have this marked noinstr.

Thanks,

        tglx
