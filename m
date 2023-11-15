Return-Path: <linux-kselftest+bounces-135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 764797EC714
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 16:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043091F26B33
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E91381D0;
	Wed, 15 Nov 2023 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpZZteBh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A908381CB;
	Wed, 15 Nov 2023 15:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E40C433C9;
	Wed, 15 Nov 2023 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700061795;
	bh=8xQ64PrJ2r1RKXD2ge4xYHHnqovHMM4KOyXknKJ04QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpZZteBhAL9H1KTmPyNx7ikQLfKMsMVaRL4GQcWRZZGPhrnujZQKScATqof0lddny
	 MdWmFHCsJEQYXXL5wV3CMxKJXr2rrd903frBLnbRpkljLIhjCAvRZ5mEvw7Rc1ysi1
	 Lb6KEvOncIF9cWGWdsuPZ/FwFevgpa4FpJeViewmLLm/YhC+BSg1JSoL04M8rPvPW5
	 M4U6y3TeHoraU3PV/F939T5gNFeCIJpm//mTCDSid8GQ4NkXBlTLukwAccLS28sQN3
	 3L41ZYUnq3ttFHXk0+O9y0X/Tex65d+iABwxzcGj7iXZvfFeyRTcgzUVL2WBomMrzN
	 QqMGgCHQ69+ag==
Date: Wed, 15 Nov 2023 08:23:12 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, dlatypov@google.com,
	Maxime Ripard <mripard@kernel.org>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Sami Tolvanen <samitolvanen@google.com>, kunit-dev@googlegroups.com,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Emma Anholt <emma@anholt.net>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/3] kunit: Add a macro to wrap a deferred action function
Message-ID: <20231115152312.GA51310@dev-arch.thelio-3990X>
References: <20231110200830.1832556-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110200830.1832556-1-davidgow@google.com>

Hi David,

On Sat, Nov 11, 2023 at 04:08:26AM +0800, David Gow wrote:
> KUnit's deferred action API accepts a void(*)(void *) function pointer
> which is called when the test is exited. However, we very frequently
> want to use existing functions which accept a single pointer, but which
> may not be of type void*. While this is probably dodgy enough to be on
> the wrong side of the C standard, it's been often used for similar
> callbacks, and gcc's -Wcast-function-type seems to ignore cases where
> the only difference is the type of the argument, assuming it's
> compatible (i.e., they're both pointers to data).
> 
> However, clang 16 has introduced -Wcast-function-type-strict, which no
> longer permits any deviation in function pointer type. This seems to be
> because it'd break CFI, which validates the type of function calls.
> 
> This rather ruins our attempts to cast functions to defer them, and
> leaves us with a few options. The one we've chosen is to implement a
> macro which will generate a wrapper function which accepts a void*, and
> casts the argument to the appropriate type.
> 
> For example, if you were trying to wrap:
> void foo_close(struct foo *handle);
> you could use:
> KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_foo_close,
> 			    foo_close,
> 			    struct foo *);
> 
> This would create a new kunit_action_foo_close() function, of type
> kunit_action_t, which could be passed into kunit_add_action() and
> similar functions.
> 
> In addition to defining this macro, update KUnit and its tests to use
> it.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> This is a follow-up to the RFC here:
> https://lore.kernel.org/linux-kselftest/20230915050125.3609689-1-davidgow@google.com/
> 
> There's no difference in the macro implementation, just an update to the
> KUnit tests to use it. This version is intended to complement:
> https://lore.kernel.org/all/20231106172557.2963-1-rf@opensource.cirrus.com/
> 
> There are also two follow-up patches in the series to use this macro in
> various DRM tests.
> 
> Hopefully this will solve any CFI issues that show up with KUnit.
> 
> Thanks,
> -- David
> 
> ---

Prior to this series, there is indeed a crash when running the KUnit
tests with CONFIG_CFI_CLANG=y:

$ tools/testing/kunit/kunit.py run \
    --alltests \
    --arch x86_64 \
    --kconfig_add CONFIG_CFI_CLANG=y \
    --make_options LLVM=1 \
    --timeout 30
...
[08:06:03] [ERROR] Test: sysctl_test: missing subtest result line!
[08:06:03]     # module: sysctl_test
[08:06:03]     1..10
[08:06:03] CFI failure at __kunit_action_free+0x18/0x20 (target: kfree+0x0/0x80; expected type: 0xe82c6923)
[08:06:03] invalid opcode: 0000 [#1] PREEMPT NOPTI
[08:06:03] CPU: 0 PID: 53 Comm: kunit_try_catch Tainted: G                 N 6.7.0-rc1-00019-gc42d9eeef8e5 #3
[08:06:03] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-14-g1e1da7a96300-prebuilt.qemu.org 04/01/2014
[08:06:03] RIP: 0010:__kunit_action_free+0x18/0x20
[08:06:03] Code: 00 00 b8 ae 55 f1 4d 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 4c 8b 5f 38 48 8b 7f 40 41 ba dd 96 d3 17 45 03 53 f1 74 02 <0f> 0b 2e e9 f0 b5 46 00 b8 fa f1 06 5e 90 90 90 90 90 90 90 90 90
[08:06:03] RSP: 0018:ffffb0d2c00ebea0 EFLAGS: 00000292
[08:06:03] RAX: 0000000000000001 RBX: ffff993d41949a80 RCX: ffff993d41949aa0
[08:06:03] RDX: 0000000000000282 RSI: ffff993d41949a80 RDI: ffff993d4186b6b0
[08:06:03] RBP: ffffb0d2c0013ad8 R08: ffffffffc9c84000 R09: 0000000000000400
[08:06:03] R10: 00000000f707d502 R11: ffffffff8f33aa40 R12: ffff993d418d2e00
[08:06:03] R13: ffff993d41a05600 R14: ffffb0d2c0013cc0 R15: ffff993d41949ae0
[08:06:03] FS:  0000000000000000(0000) GS:ffffffff90049000(0000) knlGS:0000000000000000
[08:06:03] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[08:06:03] CR2: ffff993d55c01000 CR3: 000000001563e000 CR4: 00000000000006f0
[08:06:03] Call Trace:
[08:06:03]  <TASK>
[08:06:03]  ? __die+0xd6/0x120
[08:06:03]  ? die+0x5f/0xa0
[08:06:03]  ? do_trap+0x9b/0x180
[08:06:03]  ? __kunit_action_free+0x18/0x20
[08:06:03]  ? __kunit_action_free+0x18/0x20
[08:06:03]  ? handle_invalid_op+0x64/0x80
[08:06:03]  ? __kunit_action_free+0x18/0x20
[08:06:03]  ? exc_invalid_op+0x38/0x60
[08:06:03]  ? asm_exc_invalid_op+0x1a/0x20
[08:06:03]  ? __cfi_kfree+0x10/0x10
[08:06:03]  ? __kunit_action_free+0x18/0x20
[08:06:03]  kunit_remove_resource+0x8f/0xf0
[08:06:03]  kunit_cleanup+0x60/0xe0
[08:06:03]  kunit_generic_run_threadfn_adapter+0x24/0x30
[08:06:03]  ? __cfi_kunit_generic_run_threadfn_adapter+0x10/0x10
[08:06:03]  kthread+0xd9/0xf0
[08:06:03]  ? __cfi_kthread+0x10/0x10
[08:06:03]  ret_from_fork+0x43/0x50
[08:06:03]  ? __cfi_kthread+0x10/0x10
[08:06:03]  ret_from_fork_asm+0x1a/0x30
[08:06:03]  </TASK>
[08:06:03] ---[ end trace 0000000000000000 ]---
[08:06:03] RIP: 0010:__kunit_action_free+0x18/0x20
...

With this series applied with
https://lore.kernel.org/20231106172557.2963-1-rf@opensource.cirrus.com/,
all the tests pass for arm64 and x86_64 on my machine. I see no
remaining casts in the tree in this state. It seems like the
documentation in Documentation/dev-tools/kunit/usage.rst may want to be
updated to remove mention of casting to kunit_action_t as well?
Regardless:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

>  include/kunit/resource.h | 9 +++++++++
>  lib/kunit/kunit-test.c   | 5 +----
>  lib/kunit/test.c         | 6 ++++--
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/kunit/resource.h b/include/kunit/resource.h
> index c7383e90f5c9..4110e13970dc 100644
> --- a/include/kunit/resource.h
> +++ b/include/kunit/resource.h
> @@ -390,6 +390,15 @@ void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
>  /* A 'deferred action' function to be used with kunit_add_action. */
>  typedef void (kunit_action_t)(void *);
>  
> +/* We can't cast function pointers to kunit_action_t if CFI is enabled. */
> +#define KUNIT_DEFINE_ACTION_WRAPPER(wrapper, orig, arg_type) \
> +	static void wrapper(void *in) \
> +	{ \
> +		arg_type arg = (arg_type)in; \
> +		orig(arg); \
> +	}
> +
> +
>  /**
>   * kunit_add_action() - Call a function when the test ends.
>   * @test: Test case to associate the action with.
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index de2113a58fa0..ee6927c60979 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -538,10 +538,7 @@ static struct kunit_suite kunit_resource_test_suite = {
>  #if IS_BUILTIN(CONFIG_KUNIT_TEST)
>  
>  /* This avoids a cast warning if kfree() is passed direct to kunit_add_action(). */
> -static void kfree_wrapper(void *p)
> -{
> -	kfree(p);
> -}
> +KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
>  
>  static void kunit_log_test(struct kunit *test)
>  {
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index f2eb71f1a66c..0308865194bb 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -772,6 +772,8 @@ static struct notifier_block kunit_mod_nb = {
>  };
>  #endif
>  
> +KUNIT_DEFINE_ACTION_WRAPPER(kfree_action_wrapper, kfree, const void *)
> +
>  void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
>  {
>  	void *data;
> @@ -781,7 +783,7 @@ void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
>  	if (!data)
>  		return NULL;
>  
> -	if (kunit_add_action_or_reset(test, (kunit_action_t *)kfree, data) != 0)
> +	if (kunit_add_action_or_reset(test, kfree_action_wrapper, data) != 0)
>  		return NULL;
>  
>  	return data;
> @@ -793,7 +795,7 @@ void kunit_kfree(struct kunit *test, const void *ptr)
>  	if (!ptr)
>  		return;
>  
> -	kunit_release_action(test, (kunit_action_t *)kfree, (void *)ptr);
> +	kunit_release_action(test, kfree_action_wrapper, (void *)ptr);
>  }
>  EXPORT_SYMBOL_GPL(kunit_kfree);
>  
> -- 
> 2.42.0.869.gea05f2083d-goog
> 

