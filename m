Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D15EADAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Sep 2022 19:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiIZRKm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Sep 2022 13:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiIZRKX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Sep 2022 13:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BC0E090;
        Mon, 26 Sep 2022 09:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0032960B68;
        Mon, 26 Sep 2022 16:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F85C433C1;
        Mon, 26 Sep 2022 16:18:38 +0000 (UTC)
Date:   Mon, 26 Sep 2022 12:19:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Joe Fradley <joefradley@google.com>,
        Steve Muckle <smuckle@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/2] kunit: expose ftrace-based API for stubbing
 out functions during tests
Message-ID: <20220926121946.5b409ca1@gandalf.local.home>
In-Reply-To: <20220910212804.670622-3-davidgow@google.com>
References: <20220910212804.670622-1-davidgow@google.com>
        <20220910212804.670622-3-davidgow@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 11 Sep 2022 05:28:04 +0800
David Gow <davidgow@google.com> wrote:

> +++ b/lib/kunit/ftrace_stub.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <kunit/test.h>
> +
> +#include <linux/typecheck.h>
> +
> +#include <linux/ftrace.h>
> +#include <linux/sched.h>
> +
> +struct kunit_ftrace_stub_ctx {
> +	struct kunit *test;
> +	unsigned long real_fn_addr; /* used as a key to lookup the stub */
> +	unsigned long replacement_addr;
> +	struct ftrace_ops ops; /* a copy of kunit_stub_base_ops with .private set */
> +};
> +
> +static void kunit_stub_trampoline(unsigned long ip, unsigned long parent_ip,
> +				  struct ftrace_ops *ops,
> +				  struct ftrace_regs *fregs)
> +{
> +	struct kunit_ftrace_stub_ctx *ctx = ops->private;
> +	int lock_bit;
> +
> +	if (current->kunit_test != ctx->test)
> +		return;
> +
> +	lock_bit = ftrace_test_recursion_trylock(ip, parent_ip);
> +	KUNIT_ASSERT_GE(ctx->test, lock_bit, 0);
> +
> +	ftrace_instruction_pointer_set(fregs, ctx->replacement_addr);
> +
> +	ftrace_test_recursion_unlock(lock_bit);
> +}
> +
> +static struct ftrace_ops kunit_stub_base_ops = {
> +	.func = &kunit_stub_trampoline,
> +	.flags = FTRACE_OPS_FL_IPMODIFY |
> +#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +		FTRACE_OPS_FL_SAVE_REGS |
> +#endif
> +		FTRACE_OPS_FL_DYNAMIC
> +};
> +
> +static void __kunit_ftrace_stub_resource_free(struct kunit_resource *res)
> +{
> +	struct kunit_ftrace_stub_ctx *ctx = res->data;
> +
> +	unregister_ftrace_function(&ctx->ops);
> +	kfree(ctx);
> +}
> +
> +/* Matching function for kunit_find_resource(). match_data is real_fn_addr. */
> +static bool __kunit_ftrace_stub_resource_match(struct kunit *test,
> +						struct kunit_resource *res,
> +						void *match_real_fn_addr)
> +{
> +	/* This pointer is only valid if res is a static stub resource. */
> +	struct kunit_ftrace_stub_ctx *ctx = res->data;
> +
> +	/* Make sure the resource is a static stub resource. */
> +	if (res->free != &__kunit_ftrace_stub_resource_free)
> +		return false;
> +
> +	return ctx->real_fn_addr == (unsigned long)match_real_fn_addr;
> +}
> +
> +void kunit_deactivate_ftrace_stub(struct kunit *test, void *real_fn_addr)
> +{
> +	struct kunit_resource *res;
> +
> +	KUNIT_ASSERT_PTR_NE_MSG(test, real_fn_addr, NULL,
> +				"Tried to deactivate a NULL stub.");
> +
> +	/* Look up the existing stub for this function. */
> +	res = kunit_find_resource(test,
> +				  __kunit_ftrace_stub_resource_match,
> +				  real_fn_addr);
> +
> +	/* Error out if the stub doesn't exist. */
> +	KUNIT_ASSERT_PTR_NE_MSG(test, res, NULL,
> +				"Tried to deactivate a nonexistent stub.");
> +
> +	/* Free the stub. We 'put' twice, as we got a reference
> +	 * from kunit_find_resource(). The free function will deactivate the
> +	 * ftrace stub.
> +	 */
> +	kunit_remove_resource(test, res);
> +	kunit_put_resource(res);
> +}
> +EXPORT_SYMBOL_GPL(kunit_deactivate_ftrace_stub);
> +
> +void __kunit_activate_ftrace_stub(struct kunit *test,
> +				  const char *name,
> +				  void *real_fn_addr,
> +				  void *replacement_addr)
> +{
> +	unsigned long ftrace_ip;
> +	struct kunit_ftrace_stub_ctx *ctx;
> +	int ret;
> +
> +	ftrace_ip = ftrace_location((unsigned long)real_fn_addr);
> +	if (!ftrace_ip)
> +		KUNIT_ASSERT_FAILURE(test, "%s ip is invalid: not a function, or is marked notrace or inline", name);
> +
> +	/* Allocate the stub context, which contains pointers to the replacement
> +	 * function and the test object. It's also registered as a KUnit
> +	 * resource which can be looked up by address (to deactivate manually)
> +	 * and is destroyed automatically on test exit.
> +	 */
> +	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ctx, "failed to allocate kunit stub for %s", name);
> +
> +	ctx->test = test;
> +	ctx->ops = kunit_stub_base_ops;
> +	ctx->ops.private = ctx;
> +	ctx->real_fn_addr = (unsigned long)real_fn_addr;
> +	ctx->replacement_addr = (unsigned long)replacement_addr;
> +
> +	ret = ftrace_set_filter_ip(&ctx->ops, ftrace_ip, 0, 0);
> +	if (ret) {
> +		kfree(ctx);
> +		KUNIT_ASSERT_FAILURE(test, "failed to set filter ip for %s: %d", name, ret);

I don't know the KUNIT_ASSERT content, but I'm guessing that any failure is
just to crash the kernel or something where you do not need to bail out of
the function?

> +	}
> +
> +	ret = register_ftrace_function(&ctx->ops);
> +	if (ret) {
> +		kfree(ctx);
> +		if (ret == -EBUSY)
> +			KUNIT_ASSERT_FAILURE(test, "failed to register stub (-EBUSY) for %s, likely due to already stubbing it?", name);
> +		KUNIT_ASSERT_FAILURE(test, "failed to register stub for %s: %d", name, ret);
> +	}
> +
> +	/* Register the stub as a resource with a cleanup function */
> +	kunit_alloc_resource(test, NULL,
> +			     __kunit_ftrace_stub_resource_free,
> +			     GFP_KERNEL, ctx);

And I'm also guessing that there's no race concern with registering the
free resource after enabling the function code?

Other than that, looks good to me.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> +}
