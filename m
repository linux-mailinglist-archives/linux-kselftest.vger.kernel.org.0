Return-Path: <linux-kselftest+bounces-28086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE77A4C93E
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 18:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049FD16C61A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A6C23AE60;
	Mon,  3 Mar 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uA+kUUFz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88433215F58;
	Mon,  3 Mar 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021278; cv=none; b=Kr7dtWueeJ+i/E148r17a+QhShWpi+MzBRBP/hKOyt983hoirKvJMEgFs+FCXGsRGJ1dBX6bbnZ8hWmLUBxbV4/hV5ecvVqNNm+KVrGpnLB2yYLOGO70u/98+mYF6suhCX6gbfjx72RwB74t1PIO7AjUno8oKPr5F6XugjdSu5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021278; c=relaxed/simple;
	bh=cbk68TMZcZXPbVfxtAAvvisgzKDF0RnGN/M9es88iRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3uEi5c2v9PrGvsK2+K+k+rOJYkMaJhGdOz1WFCS08a/BVRp4DWebQ/TONJadJY9haw8ESBvnLi2nKpxgrIWfov8kXqAuMRGbibt+KcU+IaJ3pALc/7GTFvZ2Hdthlm4sxQl8GBz9tVL6ymEK3zY8Z3rV1EVw2QyYW7q3+QFSSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uA+kUUFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E63C4CED6;
	Mon,  3 Mar 2025 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741021276;
	bh=cbk68TMZcZXPbVfxtAAvvisgzKDF0RnGN/M9es88iRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uA+kUUFzAyFJzxGo2c79X7S5ceLqIq3ldGivgBqF4tPZliJ2p7I+AGU6DP0SbHReI
	 VE9J+isQT3+tgUvPMvsm3B8htvD5NvRP0rTjxVSecr5LF8WlAlTVUvbxWuHTeH9ArK
	 G298QUULsxlQC31qili97454NkIz9wbLuvUYSOUVv61VffBeF/BNfAh/WAn1S4nzBK
	 EkUVyUPxs/aT1BxvGIUlWMxl3ITOJnV4Gc4o/fa5r2U0iUYoZlwhzBwwNLCM8vtskt
	 xPzBFPXlqEX0wl7173FoYiV7B7naKFhgd3J1PMIMwz8TeWWFO6tQAEW7YO7a0kcCf1
	 trt2J6HjqAMug==
Date: Mon, 3 Mar 2025 09:01:11 -0800
From: Kees Cook <kees@kernel.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, jannh@google.com,
	torvalds@linux-foundation.org, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, jorgelo@chromium.org,
	sroettger@google.com, hch@lst.de, ojeda@kernel.org,
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
	johannes@sipsolutions.net, pedro.falcato@gmail.com,
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de,
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net,
	peterx@redhat.com, f.fainelli@gmail.com, gerg@kernel.org,
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org,
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org,
	ardb@google.com, enh@google.com, rientjes@google.com,
	groeck@chromium.org, mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Subject: Re: [PATCH v8 7/7] selftest: test system mappings are sealed.
Message-ID: <202503030848.30D0E54E7@keescook>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-8-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-8-jeffxu@google.com>

On Mon, Mar 03, 2025 at 05:09:21AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Add sysmap_is_sealed.c to test system mappings are sealed.
> 
> Note: CONFIG_MSEAL_SYSTEM_MAPPINGS must be set, as indicated in
> config file.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  .../mseal_system_mappings/.gitignore          |   2 +
>  .../selftests/mseal_system_mappings/Makefile  |   6 +
>  .../selftests/mseal_system_mappings/config    |   1 +
>  .../mseal_system_mappings/sysmap_is_sealed.c  | 113 ++++++++++++++++++
>  4 files changed, 122 insertions(+)
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/config
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> 
> diff --git a/tools/testing/selftests/mseal_system_mappings/.gitignore b/tools/testing/selftests/mseal_system_mappings/.gitignore
> new file mode 100644
> index 000000000000..319c497a595e
> --- /dev/null
> +++ b/tools/testing/selftests/mseal_system_mappings/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +sysmap_is_sealed
> diff --git a/tools/testing/selftests/mseal_system_mappings/Makefile b/tools/testing/selftests/mseal_system_mappings/Makefile
> new file mode 100644
> index 000000000000..2b4504e2f52f
> --- /dev/null
> +++ b/tools/testing/selftests/mseal_system_mappings/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +CFLAGS += -std=c99 -pthread -Wall $(KHDR_INCLUDES)
> +
> +TEST_GEN_PROGS := sysmap_is_sealed
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/mseal_system_mappings/config b/tools/testing/selftests/mseal_system_mappings/config
> new file mode 100644
> index 000000000000..675cb9f37b86
> --- /dev/null
> +++ b/tools/testing/selftests/mseal_system_mappings/config
> @@ -0,0 +1 @@
> +CONFIG_MSEAL_SYSTEM_MAPPINGS=y
> diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> new file mode 100644
> index 000000000000..c1e93794a58b
> --- /dev/null
> +++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * test system mappings are sealed when
> + * KCONFIG_MSEAL_SYSTEM_MAPPINGS=y
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <stdbool.h>
> +
> +#include "../kselftest.h"
> +#include "../kselftest_harness.h"
> +
> +#define VDSO_NAME "[vdso]"
> +#define VVAR_NAME "[vvar]"
> +#define VVAR_VCLOCK_NAME "[vvar_vclock]"
> +#define UPROBES_NAME "[uprobes]"
> +#define SIGPAGE_NAME "[sigpage]"
> +#define VECTORS_NAME "[vectors]"

These are only ever used once, and it feels like having them spelled out
right in the variant definitions would be more readable, but I'm not
sure I feel strongly enough about it to say it should be changed.
They're available via "variant->name" as well, which makes it unlikely
the macros will be used anywhere in the future? Maybe you have plans for
them. :)

> +#define VMFLAGS "VmFlags:"

This one gets a strlen() on it, so it feels better to have a macro.

> +#define MSEAL_FLAGS "sl"
> +#define MAX_LINE_LEN 512
> +
> +bool has_mapping(char *name, FILE *maps)
> +{
> +	char line[MAX_LINE_LEN];
> +
> +	while (fgets(line, sizeof(line), maps)) {
> +		if (strstr(line, name))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +bool mapping_is_sealed(char *name, FILE *maps)
> +{
> +	char line[MAX_LINE_LEN];
> +
> +	while (fgets(line, sizeof(line), maps)) {
> +		if (!strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
> +			if (strstr(line, MSEAL_FLAGS))
> +				return true;
> +
> +			return false;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +FIXTURE(basic) {
> +	FILE *maps;
> +};
> +
> +FIXTURE_SETUP(basic)
> +{
> +	self->maps = fopen("/proc/self/smaps", "r");
> +	if (!self->maps)
> +		SKIP(return, "Could not open /proc/self/smap, errno=%d",
> +			errno);

Good SKIP usage, though I wonder if not having /proc should be a full
blown failure?

> +};
> +
> +FIXTURE_TEARDOWN(basic)
> +{
> +	if (self->maps)
> +		fclose(self->maps);
> +};
> +
> +FIXTURE_VARIANT(basic)
> +{
> +	char *name;
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, vdso) {
> +	.name = VDSO_NAME,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, vvar) {
> +	.name = VVAR_NAME,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, vvar_vclock) {
> +	.name = VVAR_VCLOCK_NAME,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, sigpage) {
> +	.name = SIGPAGE_NAME,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, vectors) {
> +	.name = VECTORS_NAME,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, uprobes) {
> +	.name = UPROBES_NAME,
> +};

I love seeing variants used in the test harness. :)

> +
> +TEST_F(basic, is_sealed)
> +{
> +	if (!has_mapping(variant->name, self->maps)) {
> +		SKIP(return, "could not found the mapping, %s",

typo nit: "find" instead of "found"

> +			variant->name);
> +	}
> +
> +	EXPECT_TRUE(mapping_is_sealed(variant->name, self->maps));
> +};

This is a good "positive" test, but I'd like to see a negative test
added as well. (This adds robustness against something going "all wrong"
or "all right", like imagine that someone adds a VmFlags string named
"slow", suddenly this test will always pass due to matching "sl". With
a negative test added, it will fail when it finds "sl" when it's not
expected.) For example, also check "[stack]" and "[heap]" and expect
them NOT to be sealed.

You could update the variant as:

FIXTURE_VARIANT(basic)
{
	char *name;
	bool sealed;
};

FIXTURE_VARIANT_ADD(basic, vdso) {
	.name = "[vdso]",
	.sealed = true,
};

FIXTURE_VARIANT_ADD(basic, stack) {
	.name = "[stack]",
	.sealed = false,
};

And then update the is_sealed test to:

	EXPECT_EQ(variant->sealed, mapping_is_sealed(variant->name, self->maps));

-- 
Kees Cook

