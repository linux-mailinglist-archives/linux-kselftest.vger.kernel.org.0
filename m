Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177EB46F08F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Dec 2021 18:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbhLIRJn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Dec 2021 12:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242213AbhLIRJX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Dec 2021 12:09:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD25DC061353
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 09:05:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81546B825C2
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 17:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A7AC341C3;
        Thu,  9 Dec 2021 17:05:44 +0000 (UTC)
Date:   Thu, 9 Dec 2021 17:05:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 06/37] kselftest/arm64: Add a test program to exercise
 the syscall ABI
Message-ID: <YbI3ZfhOO+M5L/9V@arm.com>
References: <20211115152835.3212149-1-broonie@kernel.org>
 <20211115152835.3212149-7-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115152835.3212149-7-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 15, 2021 at 03:28:04PM +0000, Mark Brown wrote:
> diff --git a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
> new file mode 100644
> index 000000000000..983467cfcee0
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0-only

Nitpick: I think GPL-2.0 is sufficient (i.e. no '-only' suffix), though
about a quarter seem to use the -only variant.

> diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
> new file mode 100644
> index 000000000000..d103acf1ab79
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
[...]
> +static int check_z(struct syscall_cfg *cfg, int sve_vl)
> +{
> +	size_t reg_size = sve_vl;
> +	int errors = 0;
> +	int i;
> +
> +	if (!sve_vl)
> +		return 0;
> +
> +	/*
> +	 * After a syscall the low 128 bits of the Z registers should
> +	 * be preserved and the rest be zeroed.
> +	 */

That's the current behaviour I think but the sve.rst doc states the
values after syscall are 'unspecified' (same for the P regs). Should we
tighten the doc as well?

A downside with forcing zero is that it may prevent us from some
optimisations in the future. Currently we do an sve_user_discard() on
the syscall entry path and disable SVE but we could instead do this only
on context switch or when the kernel used Neon.

Of course, we also run the risk of the current behavior (zeroing)
becoming the de-facto ABI.

-- 
Catalin
