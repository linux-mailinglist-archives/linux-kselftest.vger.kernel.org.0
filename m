Return-Path: <linux-kselftest+bounces-33792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97270AC412E
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 16:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E913E1899FEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EC720E002;
	Mon, 26 May 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U4T43Ytx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65565202998
	for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269152; cv=none; b=irmEABxf11wQBTIR6CihMSIgQSiREzbS2ShK5PMNd8QAs0ROaP03dB/UJI+9EknR3ST2clknCoUfZDhvC2osJjdaIBFyIbX3NDKDSkigo5qTfNBi4no5r0pYs6ZUMgMsO17MMA7HIU9p72ZQyxp/3E70zx/NmKL1rnde2Hu8CRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269152; c=relaxed/simple;
	bh=zZY12G2RUE6dyOkl3opChCWHjj1XJx+3D/Lm++dU8bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJSoWj9mBTRcWLvSHAIVDmsSyvBUIrN/45kzm+mS336mrmYPUW3cvLM9vog29d7MsHsOc/CrVH5J6oG+6H+jR3Cg7lQeK0jjNRRsJVh9cgfa/70/YaGVuPO7BH7siVCOo/CricW6hexa/V/QEOV4ISCk7LPnNHtRpfeIMbNfAqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U4T43Ytx; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 May 2025 16:19:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748269147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QP47mBiBQT/WSbbK5SaleZH/+hgZqZTeZEh/OAuW384=;
	b=U4T43Ytxt22kYjLevAzW8hC3OqOrtz6ZyCo6XjtEFtQOFqdwKb/z5GADfUlQUJaLmnxPNI
	GT7jkQhvfOJoKjyOq2fC3ODIg8T45kHtE/3roqnuIesTaamXRb6xrk+9/IAh8SaNswuUVa
	dhjX8nnp5bca2pOtF/0OQwtOVRZW/Ow=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 00/11] kunit: Introduce UAPI testing framework
Message-ID: <20250523-winged-donkey-of-advance-fffac7@l-nschier-aarch64>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
Organization: AVM GmbH
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 07, 2025 at 09:42:37AM +0200, Thomas Weißschuh wrote:
> Currently testing of userspace and in-kernel API use two different
> frameworks. kselftests for the userspace ones and Kunit for the
> in-kernel ones. Besides their different scopes, both have different
> strengths and limitations:
> 
> Kunit:
> * Tests are normal kernel code.
> * They use the regular kernel toolchain.
> * They can be packaged and distributed as modules conveniently.
> 
> Kselftests:
> * Tests are normal userspace code
> * They need a userspace toolchain.
>   A kernel cross toolchain is likely not enough.
> * A fair amout of userland is required to run the tests,
>   which means a full distro or handcrafted rootfs.
> * There is no way to conveniently package and run kselftests with a
>   given kernel image.
> * The kselftests makefiles are not as powerful as regular kbuild.
>   For example they are missing proper header dependency tracking or more
>   complex compiler option modifications.
> 
> Therefore kunit is much easier to run against different kernel
> configurations and architectures.
> This series aims to combine kselftests and kunit, avoiding both their
> limitations. It works by compiling the userspace kselftests as part of
> the regular kernel build, embedding them into the kunit kernel or module
> and executing them from there. If the kernel toolchain is not fit to
> produce userspace because of a missing libc, the kernel's own nolibc can
> be used instead.
> The structured TAP output from the kselftest is integrated into the
> kunit KTAP output transparently, the kunit parser can parse the combined
> logs together.
> 
> Further room for improvements:
> * Call each test in its completely dedicated namespace
> * Handle additional test files besides the test executable through
>   archives. CPIO, cramfs, etc.
> * Compatibility with kselftest_harness.h (in progress)
> * Expose the blobs in debugfs
> * Provide some convience wrappers around compat userprogs
> * Figure out a migration path/coexistence solution for
>   kunit UAPI and tools/testing/selftests/
> 
> Output from the kunit example testcase, note the output of
> "example_uapi_tests".
> 
> $ ./tools/testing/kunit/kunit.py run --kunitconfig lib/kunit example
> ...
> Running tests with:
> $ .kunit/linux kunit.filter_glob=example kunit.enable=1 mem=1G console=tty kunit_shutdown=halt
> [11:53:53] ================== example (10 subtests) ===================
> [11:53:53] [PASSED] example_simple_test
> [11:53:53] [SKIPPED] example_skip_test
> [11:53:53] [SKIPPED] example_mark_skipped_test
> [11:53:53] [PASSED] example_all_expect_macros_test
> [11:53:53] [PASSED] example_static_stub_test
> [11:53:53] [PASSED] example_static_stub_using_fn_ptr_test
> [11:53:53] [PASSED] example_priv_test
> [11:53:53] =================== example_params_test  ===================
> [11:53:53] [SKIPPED] example value 3
> [11:53:53] [PASSED] example value 2
> [11:53:53] [PASSED] example value 1
> [11:53:53] [SKIPPED] example value 0
> [11:53:53] =============== [PASSED] example_params_test ===============
> [11:53:53] [PASSED] example_slow_test
> [11:53:53] ======================= (4 subtests) =======================
> [11:53:53] [PASSED] procfs
> [11:53:53] [PASSED] userspace test 2
> [11:53:53] [SKIPPED] userspace test 3: some reason
> [11:53:53] [PASSED] userspace test 4
> [11:53:53] ================ [PASSED] example_uapi_test ================
> [11:53:53] ===================== [PASSED] example =====================
> [11:53:53] ============================================================
> [11:53:53] Testing complete. Ran 16 tests: passed: 11, skipped: 5
> [11:53:53] Elapsed time: 67.543s total, 1.823s configuring, 65.655s building, 0.058s running
> 
> Based on v6.15-rc1.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v2:
> - Rebase onto v6.15-rc1
> - Add documentation and kernel docs
> - Resolve invalid kconfig breakages
> - Drop already applied patch "kbuild: implement CONFIG_HEADERS_INSTALL for Usermode Linux"
> - Drop userprogs CONFIG_WERROR integration, it doesn't need to be part of this series
> - Replace patch prefix "kconfig" with "kbuild"
> - Rename kunit_uapi_run_executable() to kunit_uapi_run_kselftest()
> - Generate private, conflict-free symbols in the blob framework
> - Handle kselftest exit codes
> - Handle SIGABRT
> - Forward output also to kunit debugfs log
> - Install a fd=0 stdin filedescriptor
> - Link to v1: https://lore.kernel.org/r/20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de
> 
> ---
> Thomas Weißschuh (11):
>       kbuild: userprogs: add nolibc support
>       kbuild: introduce CONFIG_ARCH_HAS_NOLIBC
>       kbuild: doc: add label for userprogs section
>       kbuild: introduce blob framework
>       kunit: tool: Add test for nested test result reporting
>       kunit: tool: Don't overwrite test status based on subtest counts
>       kunit: tool: Parse skipped tests from kselftest.h
>       kunit: Introduce UAPI testing framework
>       kunit: uapi: Add example for UAPI tests
>       kunit: uapi: Introduce preinit executable
>       kunit: uapi: Validate usability of /proc
> 
>  Documentation/dev-tools/kunit/api/index.rst        |   5 +
>  Documentation/dev-tools/kunit/api/uapi.rst         |  12 +
>  Documentation/kbuild/makefiles.rst                 |  37 ++-
>  MAINTAINERS                                        |   2 +
>  include/kunit/uapi.h                               |  24 ++
>  include/linux/blob.h                               |  32 +++
>  init/Kconfig                                       |   2 +
>  lib/kunit/.kunitconfig                             |   2 +
>  lib/kunit/Kconfig                                  |  11 +
>  lib/kunit/Makefile                                 |  18 +-
>  lib/kunit/kunit-example-test.c                     |  15 ++
>  lib/kunit/kunit-example-uapi.c                     |  56 ++++
>  lib/kunit/uapi-preinit.c                           |  65 +++++
>  lib/kunit/uapi.c                                   | 294 +++++++++++++++++++++
>  scripts/Makefile.blobs                             |  19 ++
>  scripts/Makefile.build                             |   6 +
>  scripts/Makefile.clean                             |   2 +-
>  scripts/Makefile.userprogs                         |  16 +-
>  scripts/blob-wrap.c                                |  27 ++
>  tools/include/nolibc/Kconfig.nolibc                |  13 +
>  tools/testing/kunit/kunit_parser.py                |  13 +-
>  tools/testing/kunit/kunit_tool_test.py             |   9 +
>  .../test_is_test_passed-failure-nested.log         |  10 +
>  .../test_data/test_is_test_passed-kselftest.log    |   3 +-
>  24 files changed, 682 insertions(+), 11 deletions(-)
> ---
> base-commit: bf9962cc9ec3ac1dae2bf81b126657c1c49c348a
> change-id: 20241015-kunit-kselftests-56273bc40442
> 
> Best regards,
> -- 
> Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 

Hi Thomas,

sorry for the long delay.  I started reviewing but am not completely 
through the whole set (especially, I did not really look at the kunit 
patches, yet) but would like to send you at least some feedback already.

In general, I really like the idea and your approach and am looking 
forward for an integration.

Kind regards,
Nicolas

