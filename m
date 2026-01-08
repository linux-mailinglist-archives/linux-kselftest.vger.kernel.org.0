Return-Path: <linux-kselftest+bounces-48496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66108D0280F
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 12:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E786B30A54CD
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 11:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC63423A7C;
	Thu,  8 Jan 2026 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqA86hdZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7692B421F06
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868738; cv=none; b=OdjcyeMOBtVs7IpyiM/zskhHdfJjAaKdqZZPrTFrDu8v6tgA/xCar6oMpZkU21PeJltJKVyMxdmpSoFR/QzNa3F4EwYfGriPUOKlBLFerTWSMD7DNcHW7A0KJ/Lpgw5JS+DVDSoy/Sur2AK46+vz+lJh9G8VLfl19NoVKpl4Stc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868738; c=relaxed/simple;
	bh=/NZz8vYe4Dx4e39kN0eturw0woAyZfUPdWZDBqIivw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0wCSpz9RL5rRFWyDro62aI64VYMpZNRJv6z4ZVY86H1VMwawM2cFgse/+GCC03YIGepPSBXB5FPZteZsHFV9LifVlMopf/Lcs/kq20X+eNsIrs2laiYjqxgYrrseDuG3ZNoTB1sRQixOkUFbOV4z33KP9WKNVUqNc231ARPIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqA86hdZ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c0f13e4424so293222885a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 02:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767868729; x=1768473529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvXLF/+sDtlU60C1OsJPdIvbCy4JgG2IqLtR8nMU3dM=;
        b=CqA86hdZmiIlZRUc2MDaCdVYHa20QtQ2AOKQSS9EfvGfIt3euCNs8aB7Sw1ht1Tjbi
         KbngVWwihVk41wE3FZKmzrbc+Ts48jWamOzTmKkROwWmRwspHXQckaRbuvs9nbTLr5JM
         CPlikdi5yK4k5yKlP9N4UlsrsJYl/0aKCCJx6jRCmyCdESwuPcZ1KzCAeBqvWhR04ibK
         V+YeSwoaPERv9lVILI5O7AE0rLpc/c+j2af4b7Fq9WLYeqoN0shujzvwjY9J0XQKJa0z
         hUKDkE55nxq87YkmgMCK2g+FNE4N2PCoeDpkDD3wha/qYrtzrccZZwuRqrrrw2aoxrVs
         k9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868729; x=1768473529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvXLF/+sDtlU60C1OsJPdIvbCy4JgG2IqLtR8nMU3dM=;
        b=ImV22VABqOXfH/whQzlKoafIECR7YtnvOEXCNmJRV0PMEwGWmWTn2DPLjZ23x9du13
         HpQ1ge07q1DJAzctV7BnmVprG7HR2oouEmVUgPQm5L2GXA5+HOhF/0fiJU8oobHx2uAi
         d/7kbYryKASQM1yR500cH95xo9AqrNI1HWuWjJE9XIdS5gMugGeYeKSTTpWclZOxTopT
         ip7FtqvPyDb9iDgkerCDMDo+DaRV4xnbaw7cDLB6Hm9jA/e8mqk14NRfmchGDxeMUAWT
         4ss+junS0BZLBSoTTvUqCwiHmHujj0Ox8VmXLU95+/b5jmHx0+Q/oYkrqqIdUI4roVhj
         3qaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiE/QQHvoMfYdV9ggVnof5nfLvUdK4BJ0sU1JpPtY4cD+Hx6CJCYoAeAN30OV+CeyeMy2OM1AzU22VyuUHgrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh7EG5h4hMsaf5MAbERlRD08g12cpL0w7JckoFG38ZLHPerneb
	9A4CeSZ55GkowUOu0sJHpKtpEbyRy747B0BeT8QtX8R+6r/DwOkByjvlZAtfIw==
X-Gm-Gg: AY/fxX5S+93um3HkWZX9OQ+aTQrAVaZxcSaX0D4ZGcIk6Fj/jN57b36q28XZm+EnH47
	T5Sz7th3O5BN6WEkrcCKw+36hvnHcpdVLurGsXFy6beUrZKQJieXR3+r8GbxgHTUKHjvNILv3Qz
	FldLZZU/8n9I+cfZjGI/nBtkwFJj7rMakHUtfx7AOKzmevHxMfanJic8Of4dugBrd2swjnNGn4c
	dfa9A5u0YzRrhQ9rh//9Rq+sNUYFfdoogA1VYsteeNOs4Oix54tc44fhTKKpkdIpPPo9l6Gexv+
	jcPHRJiW9J9dUCs5SWNKTkXqRXYWniOi07sCY9eGZPpUPhUsoXQY1nbkSmPycg8FyNI9HqGHwr/
	ApyreBt6qBDeubCJV7WjozpErDOeUfeS2gDLyLZR2PQ1jqoPERmXbOrEa6YdMUvX/Byr7KgEJ2C
	fplcldPzo1BYX5WHeaplk=
X-Google-Smtp-Source: AGHT+IHZ/e/9MRP0LhYoIMzqNf8baO/CNi6HGD9URb21j0msGo+xTT0NXqavKnYmSn7lb/sewf/nzQ==
X-Received: by 2002:a17:902:e952:b0:29f:2f40:76c4 with SMTP id d9443c01a7336-2a3ee48ace2mr49153895ad.34.1767862419899;
        Thu, 08 Jan 2026 00:53:39 -0800 (PST)
Received: from google.com ([2401:fa00:95:201:bac6:7809:4716:2fd6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2eabsm70662015ad.49.2026.01.08.00.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:53:39 -0800 (PST)
Date: Thu, 8 Jan 2026 16:53:35 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Kir Chou <note351@hotmail.com>
Cc: akpm@linux-foundation.org, geert@linux-m68k.org,
	linux-kernel@vger.kernel.org, davidgow@google.com,
	brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, kirchou@google.com
Subject: Re: [PATCH v3] lib/glob: convert selftest to KUnit
Message-ID: <aV9wjyL-q1fxXjxq@google.com>
References: <20260107051903.35039-1-note351@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107051903.35039-1-note351@hotmail.com>

Hi Kir,

On Wed, Jan 07, 2026 at 02:19:03PM +0900, Kir Chou wrote:
> This patch converts the existing glob selftest (lib/globtest.c) to use
> the KUnit framework (lib/tests/glob_kunit.c).
> 
> The new test:
> 
> - Migrates all 64 test cases from the original test to the KUnit suite.
> - Removes the custom 'verbose' module parameter as KUnit handles logging.
> - Updates Kconfig.debug and Makefile to support the new KUnit test.
> - Updates Kconfig and Makefile to remove the original selftest.
> - Updates GLOB_SELFTEST to GLOB_KUNIT_TEST for arch/m68k/configs.
> 
> This commit is verified by `./tools/testing/kunit/kunit.py run`
> with the .kunit/.kunitconfig:
> 
> ```
> CONFIG_KUNIT=y
> CONFIG_GLOB_KUNIT_TEST=y
> ```
> 
> Signed-off-by: Kir Chou <note351@hotmail.com>

Thanks for the patch.

However, it seems you missed carrying forward David's Reviewed-by and
Geert's Acked-by tags. Please include them in the next version. If you
dropped them intentionally (e.g., due to changes in v3), please explain
why under --- line.

> ---
> v2:
>  - Remove CONFIG_GLOB_KUNIT_TEST from defconfigs as it's implicitly enabled
>    by CONFIG_KUNIT_ALL_TESTS. (Suggested by Geert)
> v3:
>  - Move lib/glob_kunit.c to lib/tests/glob_kunit.c.
>  - Update Makefile accordingly.
> ---
>  arch/m68k/configs/amiga_defconfig    |   1 -
>  arch/m68k/configs/apollo_defconfig   |   1 -
>  arch/m68k/configs/atari_defconfig    |   1 -
>  arch/m68k/configs/bvme6000_defconfig |   1 -
>  arch/m68k/configs/hp300_defconfig    |   1 -
>  arch/m68k/configs/mac_defconfig      |   1 -
>  arch/m68k/configs/multi_defconfig    |   1 -
>  arch/m68k/configs/mvme147_defconfig  |   1 -
>  arch/m68k/configs/mvme16x_defconfig  |   1 -
>  arch/m68k/configs/q40_defconfig      |   1 -
>  arch/m68k/configs/sun3_defconfig     |   1 -
>  arch/m68k/configs/sun3x_defconfig    |   1 -
>  lib/Kconfig                          |  13 ---
>  lib/Kconfig.debug                    |  13 +++
>  lib/Makefile                         |   1 -
>  lib/globtest.c                       | 167 ---------------------------
>  lib/tests/Makefile                   |   1 +
>  lib/tests/glob_kunit.c               | 122 +++++++++++++++++++
>  18 files changed, 136 insertions(+), 193 deletions(-)
>  delete mode 100644 lib/globtest.c
>  create mode 100644 lib/tests/glob_kunit.c
> 

...

> @@ -430,19 +430,6 @@ config GLOB
>  	  are compiling an out-of tree driver which tells you that it
>  	  depends on this.
>  
> -config GLOB_SELFTEST
> -	tristate "glob self-test on init"
> -	depends on GLOB
> -	help
> -	  This option enables a simple self-test of the glob_match
> -	  function on startup.	It is primarily useful for people
> -	  working on the code to ensure they haven't introduced any
> -	  regressions.
> -
> -	  It only adds a little bit of code and slows kernel boot (or
> -	  module load) by a small amount, so you're welcome to play with
> -	  it, but you probably don't need it.
> -
>  #
>  # Netlink attribute parsing support is select'ed if needed
>  #
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ba36939fd..e4347e145 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -3354,6 +3354,19 @@ config PRIME_NUMBERS_KUNIT_TEST
>  
>  	  If unsure, say N
>  
> +config GLOB_KUNIT_TEST
> +	tristate "Glob matching test" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	select GLOB

The original test used depends on GLOB.
Any specific reason for switching to select GLOB?
Ideally, tests should not select functionality, to prevent increasing
the attack vector.

> +	help
> +	  Enable this option to test the glob functions at runtime.
> +
> +	  This test suite verifies the correctness of glob_match() across various
> +	  scenarios, including edge cases.
> +
> +	  If unsure, say N
> +
>  endif # RUNTIME_TESTING_MENU
>  
>  config ARCH_USE_MEMTEST

...

> diff --git a/lib/tests/glob_kunit.c b/lib/tests/glob_kunit.c
> new file mode 100644
> index 000000000..797e32a8c
> --- /dev/null
> +++ b/lib/tests/glob_kunit.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0

The original file lib/globtest.c (and lib/glob.c) is dual-licensed
(MIT/GPL), and your MODULE_LICENSE at the end of this file also states
"Dual MIT/GPL".

However, this SPDX identifier marks the file as GPL-2.0 only.

> +/*
> + * Test cases for glob functions.
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/glob.h>
> +#include <linux/module.h>
> +
> +struct glob_test_case {
> +	// Pattern to match.
> +	const char *pat;
> +	// String to match against.
> +	const char *str;
> +	// Expected glob_match result, true is matched.

If you want to document the struct members, the standard kernel-doc
format [1] would be preferred over C++-style comments.

[1]: https://origin.kernel.org/doc/html/v6.18/doc-guide/kernel-doc.html#structure-union-and-enumeration-documentation

> +	bool expected;
> +};
> +
> +static const struct glob_test_case glob_test_cases[] = {
> +	/* Some basic tests */
> +	{ .pat = "a", .str = "a", .expected = true },
> +	{ .pat = "a", .str = "b", .expected = false },
> +	{ .pat = "a", .str = "aa", .expected = false },
> +	{ .pat = "a", .str = "", .expected = false },
> +	{ .pat = "", .str = "", .expected = true },
> +	{ .pat = "", .str = "a", .expected = false },
> +	/* Simple character class tests */
> +	{ .pat = "[a]", .str = "a", .expected = true },
> +	{ .pat = "[a]", .str = "b", .expected = false },
> +	{ .pat = "[!a]", .str = "a", .expected = false },
> +	{ .pat = "[!a]", .str = "b", .expected = true },
> +	{ .pat = "[ab]", .str = "a", .expected = true },
> +	{ .pat = "[ab]", .str = "b", .expected = true },
> +	{ .pat = "[ab]", .str = "c", .expected = false },
> +	{ .pat = "[!ab]", .str = "c", .expected = true },
> +	{ .pat = "[a-c]", .str = "b", .expected = true },
> +	{ .pat = "[a-c]", .str = "d", .expected = false },
> +	/* Corner cases in character class parsing */
> +	{ .pat = "[a-c-e-g]", .str = "-", .expected = true },
> +	{ .pat = "[a-c-e-g]", .str = "d", .expected = false },
> +	{ .pat = "[a-c-e-g]", .str = "f", .expected = true },
> +	{ .pat = "[]a-ceg-ik[]", .str = "a", .expected = true },
> +	{ .pat = "[]a-ceg-ik[]", .str = "]", .expected = true },
> +	{ .pat = "[]a-ceg-ik[]", .str = "[", .expected = true },
> +	{ .pat = "[]a-ceg-ik[]", .str = "h", .expected = true },
> +	{ .pat = "[]a-ceg-ik[]", .str = "f", .expected = false },
> +	{ .pat = "[!]a-ceg-ik[]", .str = "h", .expected = false },
> +	{ .pat = "[!]a-ceg-ik[]", .str = "]", .expected = false },
> +	{ .pat = "[!]a-ceg-ik[]", .str = "f", .expected = true },
> +	/* Simple wild cards */
> +	{ .pat = "?", .str = "a", .expected = true },
> +	{ .pat = "?", .str = "aa", .expected = false },
> +	{ .pat = "??", .str = "a", .expected = false },
> +	{ .pat = "?x?", .str = "axb", .expected = true },
> +	{ .pat = "?x?", .str = "abx", .expected = false },
> +	{ .pat = "?x?", .str = "xab", .expected = false },
> +	/* Asterisk wild cards (backtracking) */
> +	{ .pat = "*??", .str = "a", .expected = false },
> +	{ .pat = "*??", .str = "ab", .expected = true },
> +	{ .pat = "*??", .str = "abc", .expected = true },
> +	{ .pat = "*??", .str = "abcd", .expected = true },
> +	{ .pat = "??*", .str = "a", .expected = false },
> +	{ .pat = "??*", .str = "ab", .expected = true },
> +	{ .pat = "??*", .str = "abc", .expected = true },
> +	{ .pat = "??*", .str = "abcd", .expected = true },
> +	{ .pat = "?*?", .str = "a", .expected = false },
> +	{ .pat = "?*?", .str = "ab", .expected = true },
> +	{ .pat = "?*?", .str = "abc", .expected = true },
> +	{ .pat = "?*?", .str = "abcd", .expected = true },
> +	{ .pat = "*b", .str = "b", .expected = true },
> +	{ .pat = "*b", .str = "ab", .expected = true },
> +	{ .pat = "*b", .str = "ba", .expected = false },
> +	{ .pat = "*b", .str = "bb", .expected = true },
> +	{ .pat = "*b", .str = "abb", .expected = true },
> +	{ .pat = "*b", .str = "bab", .expected = true },
> +	{ .pat = "*bc", .str = "abbc", .expected = true },
> +	{ .pat = "*bc", .str = "bc", .expected = true },
> +	{ .pat = "*bc", .str = "bbc", .expected = true },
> +	{ .pat = "*bc", .str = "bcbc", .expected = true },
> +	/* Multiple asterisks (complex backtracking) */
> +	{ .pat = "*ac*", .str = "abacadaeafag", .expected = true },
> +	{ .pat = "*ac*ae*ag*", .str = "abacadaeafag", .expected = true },
> +	{ .pat = "*a*b*[bc]*[ef]*g*", .str = "abacadaeafag", .expected = true },
> +	{ .pat = "*a*b*[ef]*[cd]*g*", .str = "abacadaeafag", .expected = false },
> +	{ .pat = "*abcd*", .str = "abcabcabcabcdefg", .expected = true },
> +	{ .pat = "*ab*cd*", .str = "abcabcabcabcdefg", .expected = true },
> +	{ .pat = "*abcd*abcdef*", .str = "abcabcdabcdeabcdefg", .expected = true },
> +	{ .pat = "*abcd*", .str = "abcabcabcabcefg", .expected = false },
> +	{ .pat = "*ab*cd*", .str = "abcabcabcabcefg", .expected = false },
> +};
> +
> +static void glob_case_to_desc(const struct glob_test_case *t, char *desc)
> +{
> +	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "pat:\"%s\" str:\"%s\"", t->pat, t->str);
> +}
> +
> +KUNIT_ARRAY_PARAM(glob, glob_test_cases, glob_case_to_desc);
> +
> +static void glob_test_match(struct kunit *test)
> +{
> +	const struct glob_test_case *params = test->param_value;
> +
> +	KUNIT_EXPECT_EQ_MSG(test,

checkpatch.pl reports an alignment issue here:

CHECK: Alignment should match open parenthesis
#632: FILE: lib/tests/glob_kunit.c:104:
+       KUNIT_EXPECT_EQ_MSG(test,
+               glob_match(params->pat, params->str),

Regards,
Kuan-Wei

> +		glob_match(params->pat, params->str),
> +		params->expected,
> +		"Pattern: \"%s\", String: \"%s\", Expected: %d",
> +		params->pat, params->str, params->expected);
> +}
> +
> +static struct kunit_case glob_kunit_test_cases[] = {
> +	KUNIT_CASE_PARAM(glob_test_match, glob_gen_params),
> +	{}
> +};
> +
> +static struct kunit_suite glob_test_suite = {
> +	.name = "glob",
> +	.test_cases = glob_kunit_test_cases,
> +};
> +
> +kunit_test_suite(glob_test_suite);
> +MODULE_DESCRIPTION("Test cases for glob functions");
> +MODULE_LICENSE("Dual MIT/GPL");
> -- 
> 2.52.0.351.gbe84eed79e-goog
> 
> 

