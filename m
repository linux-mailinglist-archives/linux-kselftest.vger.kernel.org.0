Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A562722A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Sep 2020 13:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgIULgi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Sep 2020 07:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgIULgi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Sep 2020 07:36:38 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA9F52071A;
        Mon, 21 Sep 2020 11:36:36 +0000 (UTC)
Date:   Mon, 21 Sep 2020 12:36:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Gabor Kertesz <gabor.kertesz@arm.com>
Subject: Re: [PATCH 1/6] kselftest/arm64: Add utilities and a test to
 validate mte memory
Message-ID: <20200921113633.GB13882@gaia>
References: <20200901092719.9918-1-amit.kachhap@arm.com>
 <20200901092719.9918-2-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901092719.9918-2-amit.kachhap@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 01, 2020 at 02:57:14PM +0530, Amit Daniel Kachhap wrote:
> diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
> new file mode 100644
> index 000000000000..ac311919567d
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
> @@ -0,0 +1,374 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2020 ARM Limited
> +
> +#include <fcntl.h>
> +#include <sched.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#include <linux/auxvec.h>
> +#include <sys/auxv.h>
> +#include <sys/mman.h>
> +#include <sys/prctl.h>
> +
> +#include <asm/hwcap.h>
> +
> +#include "kselftest.h"
> +#include "mte_common_util.h"
> +#include "mte_def.h"
> +
> +/* The temp file must be created in a tmpfs filesystem */
> +#ifdef ANDROID
> +# define TEMPFILENAME    "/storage/tmp_XXXXXX"
> +#else
> +# define TEMPFILENAME    "/tmp/tmp_XXXXXX"
> +#endif

That's not guaranteed to be tmpfs (it's not on my Debian install). I
think you'd have a better chance with /dev/shm/tmp_XXXXXX.

-- 
Catalin
