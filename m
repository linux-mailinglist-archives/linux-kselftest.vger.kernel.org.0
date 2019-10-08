Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E076AD0065
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 20:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfJHSBX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 14:01:23 -0400
Received: from foss.arm.com ([217.140.110.172]:42650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfJHSBX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 14:01:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4F3415BE;
        Tue,  8 Oct 2019 11:01:22 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD9013F6C4;
        Tue,  8 Oct 2019 11:01:21 -0700 (PDT)
Date:   Tue, 8 Oct 2019 19:01:19 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
Subject: Re: [PATCH v7 02/11] kselftest: arm64:
 mangle_pstate_invalid_compat_toggle and common utils
Message-ID: <20191008180119.GZ27757@arm.com>
References: <20191007182954.25730-1-cristian.marussi@arm.com>
 <20191007182954.25730-3-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007182954.25730-3-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 07, 2019 at 07:29:45pm +0100, Cristian Marussi wrote:
> Add some arm64/signal specific boilerplate and utility code to help
> further testcases' development.
> 
> Introduce also one simple testcase mangle_pstate_invalid_compat_toggle
> and some related helpers: it is a simple mangle testcase which messes
> with the ucontext_t from within the signal handler, trying to toggle
> PSTATE state bits to switch the system between 32bit/64bit execution
> state. Expects SIGSEGV on test PASS.
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v6 --> v7
> - removed ambiguos fprintf in test_init
> - fixed spacing

[...]

> diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h

[...]

> +/* Local Helpers */
> +#define ID_AA64MMFR1_EL1_PAN_SUPPORTED(val) \
> +	(!!((val) & (0xfUL << ID_AA64MMFR1_PAN_SHIFT)))
> +#define ID_AA64MMFR2_EL1_UAO_SUPPORTED(val) \
> +	(!!((val) & (0xfUL << ID_AA64MMFR2_UAO_SHIFT)))
> +
> +#define SSBS_SYSREG		S3_3_C4_C2_6	/* EL0 supported */

Does anything in the series still use SSBS_SYSREG?

If not, please drop it.  No need to remove my Reviewed-by just for thato
change.

[...]

Cheers
---Dave
