Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740D6D0D86
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 13:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfJILSw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 07:18:52 -0400
Received: from foss.arm.com ([217.140.110.172]:60164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfJILSw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 07:18:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2666E28;
        Wed,  9 Oct 2019 04:18:52 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F7213F703;
        Wed,  9 Oct 2019 04:18:51 -0700 (PDT)
Date:   Wed, 9 Oct 2019 12:18:49 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
Subject: Re: [PATCH v8 02/12] kselftest: arm64:
 mangle_pstate_invalid_compat_toggle and common utils
Message-ID: <20191009111848.GB27757@arm.com>
References: <20191009082611.9441-1-cristian.marussi@arm.com>
 <20191009082611.9441-3-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009082611.9441-3-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 09, 2019 at 09:26:01AM +0100, Cristian Marussi wrote:
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
> v7 --> v8
> - removed unused SSBS_SYSREG

[...]

> diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
> new file mode 100644
> index 000000000000..e5aeae45febb
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/.gitignore
> @@ -0,0 +1,3 @@
> +!*.[ch]
> +mangle_*
> +fake_sigreturn_*

I think the !*.[ch] line needs to come last.

Re-including *.[ch] on the first line has no effect because no files
have been excluded yet.

(This looks like it was my mistake when I originally suggested using
wildcards here -- apologies for that!)

I'm happy for you to keey my Reviewed-by on that change.

[...]

Cheers
---Dave
