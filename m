Return-Path: <linux-kselftest+bounces-40199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECF7B3A70C
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 18:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBEEA02090
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 16:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D65322DD2;
	Thu, 28 Aug 2025 16:56:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69508322DD1;
	Thu, 28 Aug 2025 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400202; cv=none; b=Un7RyI0kXQH7lUBEgYoeHrSPZJPcjBkVqFHXHvX2p0kzxQVanDsxB7xKD1KxPDdWdrMOGlB3/Jlqwta5Yv1u8srf8k367qcF6LouqviaaSunC1V0Jqz1RRgtk+3CRtxzT6HUY+NEp27aN3EOkUhwCnGyxz2j+TJppPOlbd/cClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400202; c=relaxed/simple;
	bh=TXzUNJXtueCL1Gu1Xs8lUA47SZJ0mUPPgR+YxMi31fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpYszfxSxoMjmoauuYQKDChgNbl/F27gX3hDRrccxADHoaVWQzzWLtEjDpHG6DdD0W7dqICcFD4rggRqZ3hCOKi/VKoF7EzFrYTNcjMKI3fWlzTalPl6yCs4NpFa9Se9oUROKOHCaCjY2kS5OKWhSTbxoKxrHhIwjWVl20bR5nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 269EB1688;
	Thu, 28 Aug 2025 09:56:30 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D576C3F738;
	Thu, 28 Aug 2025 09:56:35 -0700 (PDT)
Date: Thu, 28 Aug 2025 17:56:30 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: David Gow <davidgow@google.com>
Cc: Marie Zhussupova <marievic@google.com>, marievictoria875@gmail.com,
	rmoar@google.com, shuah@kernel.org, brendan.higgins@linux.dev,
	elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v4 0/7] kunit: Refactor and extend KUnit's parameterized
 testing framework
Message-ID: <aLCKPieOlM8dD858@J2N7QTR9R3>
References: <20250826091341.1427123-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826091341.1427123-1-davidgow@google.com>

On Tue, Aug 26, 2025 at 05:13:30PM +0800, David Gow wrote:
> Hi all,
> 
> This is a new version of Marie's patch series, with a couple of extra
> fixes squashed in, notably:
> - drm/xe/tests: Fix some additional gen_params signatures
> https://lore.kernel.org/linux-kselftest/20250821135447.1618942-1-davidgow@google.com/
> - kunit: Only output a test plan if we're using kunit_array_gen_params
> https://lore.kernel.org/linux-kselftest/20250821135447.1618942-2-davidgow@google.com/
> 
> These should fix the issues found in linux-next here:
> https://lore.kernel.org/linux-next/20250818120846.347d64b1@canb.auug.org.au/
> 
> These changes only affect patches 3 and 4 of the series, the others are
> unchanged from v3.
> 
> Thanks, everyone, and sorry for the inconvenience!

Thanks for this!

I had a go at converting some of my aarch64 instruction encoding tests
over to this, and having the ability to dynamically generate the params
array before iterating over the case makes that much easier to handle.

FWIW, for the series:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I'll see about getting those converted over and posted once this is in.

Mark.

> 
> Cheers,
> -- David
> 
> ---
> 
> Hello!
> 
> KUnit offers a parameterized testing framework, where tests can be
> run multiple times with different inputs. However, the current
> implementation uses the same `struct kunit` for each parameter run.
> After each run, the test context gets cleaned up, which creates
> the following limitations:
> 
> a. There is no way to store resources that are accessible across
>    the individual parameter runs.
> b. It's not possible to pass additional context, besides the previous
>    parameter (and potentially anything else that is stored in the current
>    test context), to the parameter generator function.
> c. Test users are restricted to using pre-defined static arrays
>    of parameter objects or generate_params() to define their
>    parameters. There is no flexibility to make a custom dynamic
>    array without using generate_params(), which can be complex if
>    generating the next parameter depends on more than just the single
>    previous parameter.
> 
> This patch series resolves these limitations by:
> 
> 1. [P 1] Giving each parameterized run its own `struct kunit`. It will
>    remove the need to manage state, such as resetting the `test->priv`
>    field or the `test->status_comment` after every parameter run.
> 
> 2. [P 1] Introducing parameterized test context available to all
>    parameter runs through the parent pointer of type `struct kunit`.
>    This context won't be used to execute any test logic, but will
>    instead be used for storing shared resources. Each parameter run
>    context will have a reference to that parent instance and thus,
>    have access to those resources.
> 
> 3. [P 2] Introducing param_init() and param_exit() functions that can
>    initialize and exit the parameterized test context. They will run once
>    before and after the parameterized test. param_init() can be used to add
>    resources to share between parameter runs, pass parameter arrays, and
>    any other setup logic. While param_exit() can be used to clean up
>    resources that were not managed by the parameterized test, and
>    any other teardown logic.
> 
> 4. [P 3] Passing the parameterized test context as an additional argument
>    to generate_params(). This provides generate_params() with more context,
>    making parameter generation much more flexible. The generate_params()
>    implementations in the KCSAN and drm/xe tests have been adapted to match
>    the new function pointer signature.
> 
> 5. [P 4] Introducing a `params_array` field in `struct kunit`. This will
>    allow the parameterized test context to have direct storage of the
>    parameter array, enabling features like using dynamic parameter arrays
>    or using context beyond just the previous parameter. This will also
>    enable outputting the KTAP test plan for a parameterized test when the
>    parameter count is available.
> 
> Patches 5 and 6 add examples tests to lib/kunit/kunit-example-test.c to
> showcase the new features and patch 7 updates the KUnit documentation
> to reflect all the framework changes.
> 
> Thank you!
> -Marie
> 
> ---
> 
> Changes in v4:
> 
> Link to v3 of this patch series:
> https://lore.kernel.org/linux-kselftest/20250815103604.3857930-1-marievic@google.com/
> 
> - Fixup the signatures of some more gen_params functions in the drm/xe
>   driver.
> - Only print a KTAP test plan if a parameterised test is using the
>   built-in kunit_array_gen_params generating function, fixing the issues
>   with generator functions which skip array elements.
> 
> Changes in v3:
> 
> Link to v2 of this patch series:
> https://lore.kernel.org/all/20250811221739.2694336-1-marievic@google.com/
> 
> - Added logic for skipping the parameter runs and updating the test statistics
>   when parameterized test initialization fails.
> - Minor changes to the documentation.
> - Commit message formatting.
> 
> Changes in v2:
> 
> Link to v1 of this patch series:
> https://lore.kernel.org/all/20250729193647.3410634-1-marievic@google.com/
> 
> - Establish parameterized testing terminology:
>    - "parameterized test" will refer to the group of all runs of a single test
>      function with different parameters.
>    - "parameter run" will refer to the execution of the test case function with
>      a single parameter.
>    - "parameterized test context" is the `struct kunit` that holds the context
>      for the entire parameterized test.
>    - "parameter run context" is the `struct kunit` that holds the context of the
>      individual parameter run.
>    - A test is defined to be a parameterized tests if it was registered with a
>      generator function.
> - Make comment edits to reflect the established terminology.
> - Require users to manually pass kunit_array_gen_params() to
>   KUNIT_CASE_PARAM_WITH_INIT() as the generator function, unless they want to
>   provide their own generator function, if the parameter array was registered
>   in param_init(). This is to be consistent with the definition of a
>   parameterized test, i.e. generate_params() is never NULL if it's
>   a parameterized test.
> - Change name of kunit_get_next_param_and_desc() to
>   kunit_array_gen_params().
> - Other minor function name changes such as removing the "__" prefix in front
>   of internal functions.
> - Change signature of get_description() in `struct params_array` to accept
>   the parameterized test context, as well.
> - Output the KTAP test plan for a parameterized test when the parameter count
>   is available.
> - Cover letter was made more concise.
> - Edits to the example tests.
> - Fix bug of parameterized test init/exit logic being done outside of the
>   parameterized test check.
> - Fix bugs identified by the kernel test robot.
> 
> ---
> 
> Marie Zhussupova (7):
>   kunit: Add parent kunit for parameterized test context
>   kunit: Introduce param_init/exit for parameterized test context
>     management
>   kunit: Pass parameterized test context to generate_params()
>   kunit: Enable direct registration of parameter arrays to a KUnit test
>   kunit: Add example parameterized test with shared resource management
>     using the Resource API
>   kunit: Add example parameterized test with direct dynamic parameter
>     array setup
>   Documentation: kunit: Document new parameterized test features
> 
>  Documentation/dev-tools/kunit/usage.rst | 342 +++++++++++++++++++++++-
>  drivers/gpu/drm/xe/tests/xe_pci.c       |  14 +-
>  drivers/gpu/drm/xe/tests/xe_pci_test.h  |   9 +-
>  include/kunit/test.h                    |  95 ++++++-
>  kernel/kcsan/kcsan_test.c               |   2 +-
>  lib/kunit/kunit-example-test.c          | 217 +++++++++++++++
>  lib/kunit/test.c                        |  94 +++++--
>  rust/kernel/kunit.rs                    |   4 +
>  8 files changed, 740 insertions(+), 37 deletions(-)
> 
> -- 
> 2.51.0.261.g7ce5a0a67e-goog
> 

