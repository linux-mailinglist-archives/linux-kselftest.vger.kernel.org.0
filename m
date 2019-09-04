Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1245BA815E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2019 13:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfIDLsU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Sep 2019 07:48:20 -0400
Received: from foss.arm.com ([217.140.110.172]:52652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfIDLsT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Sep 2019 07:48:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A17CD337;
        Wed,  4 Sep 2019 04:48:18 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9E323F246;
        Wed,  4 Sep 2019 04:48:17 -0700 (PDT)
Date:   Wed, 4 Sep 2019 12:48:15 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
Subject: Re: [PATCH v5 04/11] kselftest: arm64:
 mangle_pstate_invalid_mode_el[123][ht]
Message-ID: <20190904114815.GU27757@arm.com>
References: <20190902112932.36129-1-cristian.marussi@arm.com>
 <20190902112932.36129-5-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902112932.36129-5-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 02, 2019 at 12:29:25pm +0100, Cristian Marussi wrote:
> Add 6 simple mangle testcases that mess with the ucontext_t from within
> the signal handler, trying to toggle PSTATE mode bits to trick the system
> into switching to EL1/EL2/EL3 using both SP_EL0(t) and SP_ELx(h).
> Expects SIGSEGV on test PASS.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

We might be able to squash this down further using a single .c file and
passing some magic -D option on the compiler command line, but it's
probably not worth it.

This removes most of the actual code duplication already.

So,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
> v3 --> v4
> - fixed commit message
> - macroization
> - splitted into 6 macro-ised testcases to address t/h SP selection modes
> - added test description
> ---
>  .../mangle_pstate_invalid_mode_el1h.c         | 15 ++++++++++
>  .../mangle_pstate_invalid_mode_el1t.c         | 15 ++++++++++
>  .../mangle_pstate_invalid_mode_el2h.c         | 15 ++++++++++
>  .../mangle_pstate_invalid_mode_el2t.c         | 15 ++++++++++
>  .../mangle_pstate_invalid_mode_el3h.c         | 15 ++++++++++
>  .../mangle_pstate_invalid_mode_el3t.c         | 15 ++++++++++
>  .../mangle_pstate_invalid_mode_template.h     | 28 +++++++++++++++++++
>  7 files changed, 118 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1h.c
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1t.c
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2h.c
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2t.c
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3h.c
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3t.c
>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_template.h
> 
> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1h.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1h.c
> new file mode 100644
> index 000000000000..95f821abdf46
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1h.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 ARM Limited
> + *
> + * Try to mangle the ucontext from inside a signal handler, toggling
> + * the mode bit to escalate exception level: this attempt must be spotted
> + * by Kernel and the test case is expected to be termninated via SEGV.
> + */
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +#include "mangle_pstate_invalid_mode_template.h"
> +
> +DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(1h);
> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1t.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1t.c
> new file mode 100644
> index 000000000000..cc222d8a618a
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1t.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 ARM Limited
> + *
> + * Try to mangle the ucontext from inside a signal handler, toggling
> + * the mode bit to escalate exception level: this attempt must be spotted
> + * by Kernel and the test case is expected to be termninated via SEGV.
> + */
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +#include "mangle_pstate_invalid_mode_template.h"
> +
> +DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(1t);
> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2h.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2h.c
> new file mode 100644
> index 000000000000..2188add7d28c
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2h.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 ARM Limited
> + *
> + * Try to mangle the ucontext from inside a signal handler, toggling
> + * the mode bit to escalate exception level: this attempt must be spotted
> + * by Kernel and the test case is expected to be termninated via SEGV.
> + */
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +#include "mangle_pstate_invalid_mode_template.h"
> +
> +DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(2h);
> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2t.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2t.c
> new file mode 100644
> index 000000000000..df32dd5a479c
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2t.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 ARM Limited
> + *
> + * Try to mangle the ucontext from inside a signal handler, toggling
> + * the mode bit to escalate exception level: this attempt must be spotted
> + * by Kernel and the test case is expected to be termninated via SEGV.
> + */
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +#include "mangle_pstate_invalid_mode_template.h"
> +
> +DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(2t);
> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3h.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3h.c
> new file mode 100644
> index 000000000000..9e6829b7e5db
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3h.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 ARM Limited
> + *
> + * Try to mangle the ucontext from inside a signal handler, toggling
> + * the mode bit to escalate exception level: this attempt must be spotted
> + * by Kernel and the test case is expected to be termninated via SEGV.
> + */
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +#include "mangle_pstate_invalid_mode_template.h"
> +
> +DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(3h);
> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3t.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3t.c
> new file mode 100644
> index 000000000000..5685a4f10d06
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3t.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 ARM Limited
> + *
> + * Try to mangle the ucontext from inside a signal handler, toggling
> + * the mode bit to escalate exception level: this attempt must be spotted
> + * by Kernel and the test case is expected to be termninated via SEGV.
> + */
> +
> +#include "test_signals_utils.h"
> +#include "testcases.h"
> +
> +#include "mangle_pstate_invalid_mode_template.h"
> +
> +DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(3t);
> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_template.h b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_template.h
> new file mode 100644
> index 000000000000..f5bf1804d858
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_template.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 ARM Limited
> + *
> + * Utility macro to ease definition of testcases toggling mode EL
> + */
> +
> +#define DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(_mode)		\
> +									\
> +static int mangle_invalid_pstate_run(struct tdescr *td, siginfo_t *si,	\
> +				     ucontext_t *uc)			\
> +{									\
> +	ASSERT_GOOD_CONTEXT(uc);					\
> +									\
> +	uc->uc_mcontext.pstate &= ~PSR_MODE_MASK;			\
> +	uc->uc_mcontext.pstate |= PSR_MODE_EL ## _mode;			\
> +									\
> +	return 1;							\
> +}									\
> +									\
> +struct tdescr tde = {							\
> +		.sanity_disabled = true,				\
> +		.name = "MANGLE_PSTATE_INVALID_MODE_EL"#_mode,		\
> +		.descr = "Mangling uc_mcontext INVALID MODE EL"#_mode,	\
> +		.sig_trig = SIGUSR1,					\
> +		.sig_ok = SIGSEGV,					\
> +		.run = mangle_invalid_pstate_run,			\
> +}
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
