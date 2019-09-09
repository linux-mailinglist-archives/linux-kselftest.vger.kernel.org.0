Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C466AD17B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2019 03:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbfIIBXS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Sep 2019 21:23:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38498 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731574AbfIIBXS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Sep 2019 21:23:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id p9so1078865plk.5
        for <linux-kselftest@vger.kernel.org>; Sun, 08 Sep 2019 18:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a3/0ZW94SlxfHwi8fkeNecS9+cSMiUaEl6AF9bF+OIU=;
        b=AWNjhVINiDCvok+3LK3JrnoQ4t/dUzFL/hJD1nvWDEelMGHuDlqUoIhc/849cDx8ar
         MHr34OsDSFNzgVEPAUCK6IJd0FzzcvqWeOx3HtuBB4c/UYy2k6nw8A9mrF+lwvcnOnZh
         5YZ6i/0oMsJxpVqV0D6087eJYoYYr+DQG+auo3ZNDGLgMJekh1vHNfTxmcuETB3njMVM
         5XUn8lR0ywSy0qs8723O2PKynOWYgYlx2e1Tcx39uVCTPUgQ2oAKZWCi4i6ESxy2IadK
         iKjyxDMBiPHRa0aFWYEZpw7a0kBIvAL+howWzPKD7Ivpo0UHFV/0phVNGgftpICc+EgI
         eijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a3/0ZW94SlxfHwi8fkeNecS9+cSMiUaEl6AF9bF+OIU=;
        b=Lzd6pwPl4okJCKmXUyLiyfdb6D+IIos48Xdy0IMZd8QsvJoBUxF9sp0x8/VoZcMgFH
         70uhPKhpkezN2J3rh0odq4zkXQYulEOvRcXJoBbXKeD7d1N6hvNrbtx2P1xTOBKGO64r
         N/5CdgTVmi1Nzvh8MSRkK/fPaioVlevnr2Ljm5pfct5nW/dxsj+AX8WVXY2NDm8KFCaX
         JCz/KYg8hoEE6bRBCn26uGe9qucBONK3uBCArZEnFLgpWvsLpbhw4R2u7aZxpjJBbU3H
         9qBryYRbkvjQa92H66x5yeefcE/hdO/S3WMYGxj6DEBvGMs6mQEfN3ikhoO8ubohMaQ0
         RJWw==
X-Gm-Message-State: APjAAAXe/OaBUO/ma0QBiX/QBcPX1KuleSMjn6SS+0M6nrt/CRoLPkch
        9XakkavwX3rS6hcrjeps6HKzug==
X-Google-Smtp-Source: APXvYqxrGq2aUftr5zeTNqIsTUDP0bvzQy1QAEGsrQNNzyZJ/XdKbLNtA/RqKi8ho+ELrCQA1gfaMA==
X-Received: by 2002:a17:902:bd05:: with SMTP id p5mr20346593pls.339.1567992196111;
        Sun, 08 Sep 2019 18:23:16 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id p11sm14508790pff.136.2019.09.08.18.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 18:23:15 -0700 (PDT)
Date:   Sun, 8 Sep 2019 18:23:10 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Knut Omang <knut.omang@oracle.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC 02/19] ktf: Introduce the main part of the kernel side of
 ktf
Message-ID: <20190909012310.GA16570@google.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
 <524b4e062500c6a240d4d7c0e1d0a2996800cc0a.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524b4e062500c6a240d4d7c0e1d0a2996800cc0a.1565676440.git-series.knut.omang@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 13, 2019 at 08:09:17AM +0200, Knut Omang wrote:

Sorry, it's taken me way too long to get down to a proper code review on
this. I was hoping to send you something a couple weeks ago in
preparation for Tuesday, but I have been crazy busy.

> The ktf module itself and basic data structures for management
> of test cases and tests and contexts for tests.
> Also contains the top level include file for kernel clients
> in ktf.h.
> 
> More elaborate documentation follows towards the end of the
> patch set.
> 
> This patch set contains both user level and kernel code,
> we'll provide the full implementation of ktf on the kernel side in
> this and forthcoming patches, then the user space code to execute
> tests within the kernel and report results, then documentation
> before introducing a small self test suite of tests to test ktf
> itself, and some very simple additional example tests.
> 
> ktf.h:           Defines the KTF user API for kernel clients
> ktf_test.c:      Kernel side code for tracking and reporting ktf test results
> 
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  tools/testing/selftests/ktf/kernel/Makefile      |  15 +-
>  tools/testing/selftests/ktf/kernel/ktf.h         | 604 ++++++++++++++++-
>  tools/testing/selftests/ktf/kernel/ktf_context.c | 409 +++++++++++-
>  tools/testing/selftests/ktf/kernel/ktf_test.c    | 397 +++++++++++-
>  tools/testing/selftests/ktf/kernel/ktf_test.h    | 381 ++++++++++-
>  5 files changed, 1806 insertions(+)
>  create mode 100644 tools/testing/selftests/ktf/kernel/Makefile
>  create mode 100644 tools/testing/selftests/ktf/kernel/ktf.h
>  create mode 100644 tools/testing/selftests/ktf/kernel/ktf_context.c
>  create mode 100644 tools/testing/selftests/ktf/kernel/ktf_test.c
>  create mode 100644 tools/testing/selftests/ktf/kernel/ktf_test.h
[...]
> diff --git a/tools/testing/selftests/ktf/kernel/ktf.h b/tools/testing/selftests/ktf/kernel/ktf.h
> new file mode 100644
> index 0000000..ea270e7
> --- /dev/null
> +++ b/tools/testing/selftests/ktf/kernel/ktf.h
> @@ -0,0 +1,604 @@
> +/*
> + * Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.
> + *    Author: Knut Omang <knut.omang@oracle.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + *
> + * ktf.h: Defines the KTF user API for kernel clients
> + */
> +#ifndef _KTF_H
> +#define _KTF_H
> +
> +#include <linux/completion.h>
> +#include <linux/kprobes.h>
> +#include <linux/kthread.h>
> +#include <linux/ptrace.h>
> +#include "ktf_test.h"
> +#include "ktf_override.h"
> +#include "ktf_map.h"

Where do you add this file? I don't see any definitions of
`struct ktf_map` in either this or the preceding patches, so I don't
think that this will compile.

> +#include "ktf_unlproto.h"

Same here. This looks important for understanding what you presented
here.

> +#define	KTF_MAX_LOG			2048
> +
> +/* Type for an optional configuration callback for contexts.
> + * Implementations should copy and store data into their private
> + * extensions of the context structure. The data pointer is
> + * only valid inside the callback:
> + */
> +typedef int (*ktf_config_cb)(struct ktf_context *ctx, const void* data, size_t data_sz);
> +typedef void (*ktf_context_cb)(struct ktf_context *ctx);
> +
> +struct ktf_context_type;
> +
> +struct ktf_context {
> +	struct ktf_map_elem elem;  /* Linkage for ctx_map in handle */
> +	char name[KTF_MAX_KEY];	   /* Context name used in map */
> +	struct ktf_handle *handle; /* Owner of this context */
> +	ktf_config_cb config_cb;   /* Optional configuration callback */
> +	ktf_context_cb cleanup;	   /* Optional callback upon context release */
> +	int config_errno;	   /* If config_cb set: state of configuration */
> +	struct ktf_context_type *type; /* Associated type, must be set */
> +};
> +
> +typedef struct ktf_context* (*ktf_context_alloc)(struct ktf_context_type *ct);
> +
> +struct ktf_context_type {
> +	struct ktf_map_elem elem;  /* Linkage for map in handle */
> +	char name[KTF_MAX_KEY];	   /* Context type name */
> +	struct ktf_handle *handle; /* Owner of this context type */
> +	ktf_context_alloc alloc;   /* Allocate a new context of this type */
> +	ktf_config_cb config_cb;   /* Configuration callback */
> +	ktf_context_cb cleanup;	   /* Optional callback upon context release */
> +};
> +
> +#include "ktf_netctx.h"
> +
> +/* type for a test function */
> +struct ktf_test;

Okay, so a `struct ktf_test` (I know you define it later in the patch);
it seems like it correlates to a `struct kunit_case` in KUnit, correct?
It represents the test to be run, kind of analogous to a
`struct device_driver`, correct?

> +/* state of running test, used to pass to threads spawned by test. */
> +struct ktf_test_state;
> +
> +struct ktf_thread {
> +	int (*func)(void *);
> +	const char *name;
> +	struct task_struct *task;
> +	struct ktf_test_state state;
> +	struct completion started;
> +	struct completion completed;
> +};

So that makes this analogous to `struct kunit` or `struct device` to
keep the above analogy going, right?

> +typedef void (*ktf_test_adder)(void);
> +
> +/* Generic setup function for client modules */
> +void ktf_add_tests(ktf_test_adder f);
> +int ktf_context_add(struct ktf_handle *handle, struct ktf_context* ctx,
> +		    const char* name, ktf_config_cb cfg_cb, const char *type);
> +struct ktf_context *ktf_context_add_from(struct ktf_handle *handle, const char *name,
> +					 struct ktf_context_type *ct);
> +const char *ktf_context_name(struct ktf_context *ctx);
> +struct ktf_context* ktf_find_context(struct ktf_handle *handle, const char* name);
> +struct ktf_context *ktf_find_first_context(struct ktf_handle *handle);
> +struct ktf_context *ktf_find_next_context(struct ktf_context* ctx);
> +void ktf_context_remove(struct ktf_context *ctx);
> +size_t ktf_has_contexts(struct ktf_handle *handle);
> +void ktf_context_remove_all(struct ktf_handle *handle);
> +
> +/* Called by framework when a configuration is supplied,
> + * returns the return value of the configuration callback.
> + */
> +int ktf_context_set_config(struct ktf_context *ctx, const void* data, size_t data_sz);
> +
> +struct ktf_context *ktf_find_create_context(struct ktf_handle *handle, const char *name,
> +					    const char *type_name);
> +int ktf_handle_add_ctx_type(struct ktf_handle *handle, struct ktf_context_type *ct);
> +struct ktf_context_type *ktf_handle_get_ctx_type(struct ktf_handle *handle,
> +						 const char *type_name);
> +
> +/* Declare the implicit __test_handle as extern for .c files that use it
> + * when adding tests with ADD_TEST but where definition is in another .c file:
> + */
> +extern struct ktf_handle __test_handle;
> +
> +/* Add/remove/find a context to/from the default handle */

nit: I think adding some vertile space to some of these sections might
make them a little easier to read.

> +#define KTF_CONTEXT_ADD(__context, name) \
> +	ktf_context_add(&__test_handle, __context, name, NULL, "default")
> +#define KTF_CONTEXT_ADD_CFG(__context, name, __cb, __type_name)  \
> +	ktf_context_add(&__test_handle, __context, name, __cb, __type_name)
> +#define KTF_CONTEXT_FIND(name) ktf_find_context(&__test_handle, name)
> +#define KTF_CONTEXT_GET(name, type) \
> +	container_of(KTF_CONTEXT_FIND(name), type, k)
[...]
> +/* For unsupported platforms. */
> +#ifndef KTF_PROBE_SUPPORT
> +#define	KTF_SET_RETURN_VALUE(value)	do { } while (0)
> +#endif /* KTF_PROBE_SUPPORT */
> +
> +#define KTF_UNREGISTER_RETURN_PROBE(func, probehandler) \
> +	KTF_UNREGISTER_PROBE(handler, func, probehandler)
> +
> +#define	KTF_OVERRIDE(func, probehandler) \
> +	static int probehandler(struct kprobe *, struct pt_regs *);\
> +	static struct kprobe __ktf_override_##probehandler = { \
> +		.symbol_name = #func, \
> +		.pre_handler = probehandler, \
> +		.post_handler = ktf_post_handler, \
> +		.fault_handler = NULL, \
> +		.flags = 0, \
> +        }; \
> +        static int probehandler(struct kprobe *kp, struct pt_regs *regs)

Oh cool! Does this allow you to mock out/spy on arbitrary functions?

Rob Herring suggested I implement my arbitrary function mocking in terms
of kprobe, if I remember correctly. I wonder how easily we could make
this work with KUnit.

I don't want to totally derail this discussion by changing the subject,
but I am thinking about doing parameter matching and/or C-style class
mocking as one of the next major collection of things to upstream. I
don't think you have anything comparable to parameter matching, would it
help you if I tried to start upstreaming  both of those things
before/while you work on this?

I guess this is all part of a bigger meta question in what features you
want to break out into separate patchsets? This patchset it pretty huge
as it is, and I think you are going to want to break it up to make it
easier to review. I think you should probably break this initial patch
into multiple patches.

> +#ifdef KTF_PROBE_SUPPORT
> +#define	KTF_REGISTER_OVERRIDE(func, probehandler) \
> +	ktf_register_override(&__ktf_override_##probehandler)
> +#else
> +#define	KTF_REGISTER_OVERRIDE(func, probehandler) \
> +	ktf_no_probe_support()
> +#endif
> +
> +#define	KTF_UNREGISTER_OVERRIDE(func, probehandler) \
> +	do { \
> +		unregister_kprobe(&__ktf_override_##probehandler); \
> +		memset(&__ktf_override_##probehandler, 0, \
> +		       sizeof(struct kprobe)); \
> +		__ktf_override_##probehandler.symbol_name = #func; \
> +		__ktf_override_##probehandler.pre_handler = probehandler; \
> +		__ktf_override_##probehandler.post_handler = ktf_post_handler; \
> +	} while (0)
> +
> +
> +#define	KTF_OVERRIDE_RETURN \
> +	do { \
> +		ktf_override_function_with_return(regs); \
> +		return 1; \
> +	} while (0)
> +
> +#ifdef KTF_PROBE_SUPPORT
> +#define	KTF_SET_INSTRUCTION_POINTER(regs, value) \
> +	instruction_pointer_set(regs, (value))
> +#else
> +#define	KTF_SET_INSTRUCTION_POINTER(regs, value)	do { } while (0)
> +#endif
> +
> +/* Interfaces for creating kthreads in tests. */
> +#define	KTF_THREAD_INIT(threadname, t) \
> +	do { \
> +		(t)->func = threadname; \
> +		(t)->name = #threadname; \
> +		(t)->state.self = self; \
> +		(t)->state.ctx = ctx; \
> +		(t)->state.iter = _i; \
> +		(t)->state.value = _value; \
> +		init_completion(&((t)->started)); \
> +		init_completion(&((t)->completed)); \
> +	} while (0)
> +
> +#define	KTF_THREAD_RUN(t) \
> +	((t)->task = kthread_run((t)->func, t, (t)->name))
> +
> +#define KTF_THREAD_STOP(t) \
> +	do { \
> +		if ((t)->task) \
> +			kthread_stop((t)->task); \
> +	} while (0)
> +
> +/* Wraps thread execution to supply same variables as test case - this allows
> + * us to define assertions etc in thread context.
> + */
> +#define	KTF_THREAD(name) \
> +	static void __##name(struct ktf_thread *thread, struct ktf_test *self, \
> +			     struct ktf_context *ctx, int _i, u32 _value); \
> +	static int name(void *data) \
> +	{ \
> +		struct ktf_thread *t = data; \
> +		complete(&t->started); \
> +		__##name(t, t->state.self, t->state.ctx, t->state.iter, \
> +			 t->state.value); \
> +		complete(&t->completed); \
> +		return 0; \
> +	} \
> +	static void __##name(struct ktf_thread *_thread, struct ktf_test *self,\
> +			     struct ktf_context *ctx, int _i, u32 _value)
> +
> +#define	KTF_THREAD_WAIT_STARTED(t)	(wait_for_completion(&((t)->started)))
> +#define	KTF_THREAD_WAIT_COMPLETED(t)	(wait_for_completion(&((t)->completed)))
> +
> +u32 ktf_get_assertion_count(void);
> +
> +/**
> + * ASSERT_TRUE() - fail and return if @C evaluates to false
> + * @C: Boolean expression to evaluate
> + *
> + */
> +#define ASSERT_TRUE(C) do { \
> +		if (!ktf_assert((C))) return;	\
> +	} while (0)
> +
> +/**
> + * ASSERT_FALSE() - fail and return if @C evaluates to true
> + * @C: Boolean expression to evaluate
> + */
> +#define ASSERT_FALSE(C) do { \
> +		if (!ktf_assert(!(C))) return;	\
> +	} while (0)
> +
> +/**
> + * ASSERT_TRUE_GOTO() - fail and jump to @_lbl if @C evaluates to false
> + * @C: Boolean expression to evaluate
> + * @_lbl: Label to jump to in case of failure
> + */
> +#define ASSERT_TRUE_GOTO(C,_lbl) {		\
> +	if (!ktf_assert((C))) goto _lbl;\
> +}
> +
> +/**
> + * ASSERT_FALSE_GOTO() - fail and jump to @_lbl if @C evaluates to true
> + * @C: Boolean expression to evaluate
> + * @_lbl: Label to jump to in case of failure
> + */
> +#define ASSERT_FALSE_GOTO(C,_lbl) {		\
> +	if (!ktf_assert(!(C))) goto _lbl;\
> +}
> +
> +/**
> + * ASSERT_TRUE_RETVAL() - fail and return @V if @C evaluates to false
> + * @C: Boolean expression to evaluate
> + * @V: Value to return on failure
> + */
> +#define ASSERT_TRUE_RETVAL(C, V) do { \
> +	if (!ktf_assert((C))) return V;	\
> +} while (0)
> +
> +/**
> + * ASSERT_FALSE() - fail and return @V if @C evaluates to true
> + * @C: Boolean expression to evaluate
> + * @V: Value to return on failure
> + */
> +#define ASSERT_FALSE_RETVAL(C, V) do { \
> +	if (!ktf_assert(!(C))) return V;	\
> +} while (0)
> +
> +/**
> + * ASSERT_TRUE_CONT() - fail and continue if @C evaluates to false
> + * @C: Boolean expression to evaluate
> + */
> +#define ASSERT_TRUE_CONT(C) { \
> +	if (!ktf_assert((C))) continue; \
> +}
> +
> +/**
> + * ASSERT_FALSE_CONT() - fail and continue if @C evaluates to true
> + * @C: Boolean expression to evaluate
> + */
> +#define ASSERT_FALSE_CONT(C) { \
> +	if (!ktf_assert(!(C))) continue; \
> +}
> +
> +/**
> + * ASSERT_TRUE_BREAK() - fail and break if @C evaluates to false
> + * @C: Boolean expression to evaluate
> + */
> +#define ASSERT_TRUE_BREAK(C) { \
> +	if (!ktf_assert((C))) break; \
> +}
> +
> +/**
> + * ASSERT_FALSE_BREAK() - fail and break if @C evaluates to true
> + * @C: Boolean expression to evaluate
> + */
> +#define ASSERT_FALSE_BREAK(C) { \
> +	if (!ktf_assert(!(C))) break; \
> +}
> +
> +/**
> + * ASSERT_LONG_EQ() - compare two longs, fail and return if @X != @Y
> + * @X: Expected value
> + * @Y: Actual value
> + */
> +#define ASSERT_LONG_EQ(X, Y) \
> +	ktf_assert_long_ret(X, ==, Y);
> +
> +#define ASSERT_LONG_NE(X, Y) \
> +	ktf_assert_long_ret(X, !=, Y);
> +
> +#define ASSERT_ADDR_EQ(X, Y) \
> +	ktf_assert_long_ret((u64)(X), ==, (u64)(Y));
> +
> +#define ASSERT_ADDR_NE(X, Y) \
> +	ktf_assert_long_ret((u64)(X), !=, (u64)(Y));
> +
> +#define ASSERT_INT_EQ(X, Y) \
> +	ktf_assert_int_ret(X, ==, Y);
> +
> +#define ASSERT_INT_GT(X, Y) \
> +	ktf_assert_int_ret(X, >, Y);
> +
> +/**
> + * ASSERT_LONG_EQ() - compare two longs, jump to @_lbl if @X != @Y
> + * @X: Expected value
> + * @Y: Actual value
> + * @_lbl: Label to jump to in case of failure
> + */
> +#define ASSERT_LONG_EQ_GOTO(X, Y, _lbl) \
> +	ktf_assert_long_goto(X, ==, Y, _lbl)
> +
> +#define ASSERT_LONG_NE_GOTO(X, Y, _lbl) \
> +	ktf_assert_long_goto(X, !=, Y, _lbl)
> +
> +#define ASSERT_ADDR_EQ_GOTO(X, Y, _lbl) \
> +	ktf_assert_long_goto((u64)(X), ==, (u64)(Y), _lbl)
> +
> +#define ASSERT_ADDR_NE_GOTO(X, Y, _lbl) \
> +	ktf_assert_long_goto((u64)(X), !=, (u64)(Y), _lbl)
> +
> +#define ASSERT_INT_EQ_GOTO(X, Y, _lbl) \
> +	ktf_assert_int_goto(X, ==, Y, _lbl)
> +
> +#define ASSERT_INT_GE_GOTO(X, Y, _lbl) \
> +	ktf_assert_int_goto(X, >=, Y, _lbl)
> +
> +#define ASSERT_INT_GT_GOTO(X, Y, _lbl) \
> +	ktf_assert_int_goto(X, >, Y, _lbl)
> +
> +#define ASSERT_INT_LT_GOTO(X, Y, _lbl) \
> +	ktf_assert_int_goto(X, <, Y, _lbl)
> +
> +#define ASSERT_INT_NE(X,Y) \
> +	ktf_assert_int_ret(X, !=, Y);
> +
> +#define ASSERT_INT_NE_GOTO(X,Y,_lbl) \
> +	ktf_assert_int_goto(X, !=, Y, _lbl);
> +
> +/**
> + * EXPECT_TRUE() - fail if @C evaluates to false but allow test to continue
> + * @C: Boolean expression to evaluate
> + *
> + */
> +#define EXPECT_TRUE(C) ktf_assert(C)
> +#define EXPECT_FALSE(C) ktf_assert(!(C))
> +
> +#define OK_ADDR(X) (X && !IS_ERR(X))
> +
> +/* Valid kernel address check */
> +#define EXPECT_OK_ADDR(X) \
> +	ktf_assert_msg(OK_ADDR(X), "Invalid pointer '"#X"' - was 0x%Lx", (X))
> +
> +#define ASSERT_OK_ADDR(X) do { \
> +		if (!ktf_assert_msg(OK_ADDR(X), "Invalid pointer '"#X"' - value 0x%Lx", (X))) \
> +			return;						\
> +	} while (0)
> +#define ASSERT_OK_ADDR_GOTO(X,_lbl) do { \
> +		if (!ktf_assert_msg(OK_ADDR(X), "Invalid pointer '"#X"' - was 0x%Lx", (X))) \
> +			goto _lbl;					\
> +	} while (0)
> +
> +#define ASSERT_OK_ADDR_BREAK(X) do { \
> +	if (!ktf_assert_msg(OK_ADDR(X), "Invalid pointer '"#X"' - was 0x%Lx", (X))) \
> +		break; \
> +	} while (0)
> +
> +#define EXPECT_INT_EQ(X,Y) ktf_assert_int(X, ==, Y)
> +#define EXPECT_INT_GT(X,Y) ktf_assert_int(X, >, Y)
> +#define EXPECT_INT_GE(X,Y) ktf_assert_int(X, >=, Y)
> +#define EXPECT_INT_LE(X,Y) ktf_assert_int(X, <=, Y)
> +#define EXPECT_INT_LT(X,Y) ktf_assert_int(X, <, Y)
> +#define EXPECT_INT_NE(X,Y) ktf_assert_int(X, !=, Y)
> +
> +#define EXPECT_LONG_EQ(X, Y) ktf_assert_long(X, ==, Y)
> +#define EXPECT_LONG_NE(X, Y) ktf_assert_long(X, !=, Y)
> +#define EXPECT_ADDR_EQ(X, Y) ktf_assert_long((u64)(X), ==, (u64)(Y))
> +#define EXPECT_ADDR_NE(X, Y) ktf_assert_long((u64)(X), !=, (u64)(Y))
> +#define EXPECT_LONG_GT(X, Y) ktf_assert_long(X, >, Y)
> +#define EXPECT_LONG_GE(X, Y) ktf_assert_long(X, >=, Y)
> +#define EXPECT_LONG_LE(X, Y) ktf_assert_long(X, <=, Y)
> +#define EXPECT_LONG_LT(X, Y) ktf_assert_long(X, <, Y)
> +
> +#define EXPECT_STREQ(X, Y) ktf_assert_str_eq(X, Y)
> +#define EXPECT_STRNE(X, Y) ktf_assert_str_ne(X, Y)
> +
> +extern ulong ktf_debug_mask;
> +
> +/* Defined debug bits - higher values should represent more
> + * verbose categories:
> + */
> +#define T_INFO		0x1
> +#define T_LIST		0x2
> +#define T_INTR	      0x200
> +#define T_INFO_V      0x800
> +#define T_DEBUG	     0x1000
> +#define T_MCAST	     0x2000
> +#define T_TRACE	   0x100000
> +#define T_DEBUG_V  0x200000
> +
> +#define tlog(class, format, arg...)	\
> +	do { \
> +		if (unlikely((ktf_debug_mask) & (class)))	\
> +			printk(KERN_INFO \
> +				   "ktf pid [%d] " "%s: " format "\n", \
> +				   current->pid, __func__, \
> +				   ## arg); \
> +	} while (0)
> +#define twarn(format, arg...)	\
> +	do { \
> +		printk(KERN_WARNING				       \
> +		       "ktf pid [%d] " "%s: " format "\n",	       \
> +		       current->pid, __func__,			       \
> +		       ## arg);				       \
> +	} while (0)
> +#define terr(format, arg...)	\
> +	do { \
> +		printk(KERN_ERR				       \
> +		       "ktf pid [%d] " "%s: " format "\n",	       \
> +		       current->pid, __func__,			       \
> +		       ## arg);				       \
> +	} while (0)
> +#define tlogs(class, stmt_list) \
> +	do { \
> +		if (unlikely((ktf_debug_mask) & (class))) { \
> +			stmt_list;\
> +		} \
> +	} while (0)
> +
> +
> +/* Look up the current address of a potentially local symbol - to allow testing
> + * against it. NB! This is a hack for unit testing internal unexposed interfaces and
> + * violates the module boundaries and has no fw/bw comp gauarantees, but are
> + * still very useful for detailed unit testing complex logic:
> + */
> +void* ktf_find_symbol(const char *mod, const char *sym);
> +
> +unsigned long ktf_symbol_size(unsigned long addr);
> +
> +#define ktf_resolve_symbol(mname, sname) \
> +	do { \
> +		sname = ktf_find_symbol(#mname, #sname);	\
> +		if (!sname) \
> +			return -ENOENT; \
> +	} while (0)
> +#endif
[...]
> diff --git a/tools/testing/selftests/ktf/kernel/ktf_test.c b/tools/testing/selftests/ktf/kernel/ktf_test.c
> new file mode 100644
> index 0000000..1e287d0
> --- /dev/null
> +++ b/tools/testing/selftests/ktf/kernel/ktf_test.c
[...]
> +long _ktf_assert(struct ktf_test *self, int result, const char *file,
> +		 int line, const char *fmt, ...)

This looks a lot like the KUnit expectation/assertion API.

> +{
> +	int len;
> +	va_list ap;
> +	char *buf;
> +	char bufprefix[256];
> +	unsigned long flags;
> +
> +	if (result) {
> +		atomic_inc(&assert_cnt);
> +	} else {
> +		flush_assert_cnt(self);
> +		buf = kmalloc(MAX_PRINTF, GFP_KERNEL);
> +		if (!buf) {
> +			terr("file %s line %d: Unable to allocate memory for the error report!",
> +			     file, line);
> +			goto out;
> +		}
> +		va_start(ap, fmt);
> +		len = vsnprintf(buf, MAX_PRINTF - 1, fmt, ap);
> +		buf[len] = 0;
> +		va_end(ap);
> +		if (self->skb) {
> +			nla_put_u32(self->skb, KTF_A_STAT, result);
> +			nla_put_string(self->skb, KTF_A_FILE, file);
> +			nla_put_u32(self->skb, KTF_A_NUM, line);
> +			nla_put_string(self->skb, KTF_A_STR, buf);
> +		}
> +		(void)snprintf(bufprefix, sizeof(bufprefix) - 1,
> +				"file %s line %d: result %d: ", file, line,
> +				result);
> +		terr("%s%s", bufprefix, buf);
> +
> +		/* Multiple threads may try to update log */
> +		spin_lock_irqsave(&assert_lock, flags);
> +		(void)strncat(self->log, bufprefix, KTF_MAX_LOG);
> +		(void)strncat(self->log, buf, KTF_MAX_LOG);
> +		spin_unlock_irqrestore(&assert_lock, flags);
> +		kfree(buf);
> +	}
> +out:
> +	return result;
> +}
> +EXPORT_SYMBOL(_ktf_assert);
[...]
> diff --git a/tools/testing/selftests/ktf/kernel/ktf_test.h b/tools/testing/selftests/ktf/kernel/ktf_test.h
> new file mode 100644
> index 0000000..9769664
> --- /dev/null
> +++ b/tools/testing/selftests/ktf/kernel/ktf_test.h
> @@ -0,0 +1,381 @@
> +/*
> + * Copyright (C) 2001, 2002, Arien Malec
> + * Copyright (C) 2011, 2017, Oracle and/or its affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.1
> + *
> + * This file originates from check.h from the Check C unit test
> + * framework, adapted by Knut Omang to build with the linux kernel.
> + */
> +
> +#ifndef KTF_TEST_H
> +#define KTF_TEST_H
> +
> +#include <net/netlink.h>
> +#include <linux/version.h>
> +#include "ktf_map.h"
> +#include "ktf_unlproto.h"
> +
> +/* A test context is an extendable object that a test client module
> + * can supply, and that all tests will be invoked with as an implicit
> + * 'ctx' argument:
> + */
> +struct ktf_context;
> +
> +struct ktf_test;
> +
> +typedef void (*ktf_test_fun) (struct ktf_test *, struct ktf_context* tdev, int, u32);
> +
> +struct ktf_debugfs {
> +        struct dentry *debugfs_results_testset;
> +        struct dentry *debugfs_results_test;
> +        struct dentry *debugfs_run_testset;
> +        struct dentry *debugfs_run_test;
> +};
> +
> +struct ktf_test {
> +	struct ktf_map_elem kmap; /* linkage for test case list */
> +	const char* tclass; /* test class name */
> +	const char* name; /* Name of the test */
> +	ktf_test_fun fun;
> +	int start; /* Start and end value to argument to fun */
> +	int end;   /* Defines number of iterations */
> +	struct sk_buff *skb; /* sk_buff for recording assertion results */
> +	char *log; /* per-test log */
> +	void *data; /* Test specific out-of-band data */
> +	size_t data_sz; /* Size of the data element, if set */
> +	struct timespec lastrun; /* last time test was run */
> +	struct ktf_debugfs debugfs; /* debugfs info for test */
> +	struct ktf_handle *handle; /* Handler for owning module */
> +};
> +
> +struct ktf_case {
> +	struct ktf_map_elem kmap; /* Linkage for ktf_map */
> +	struct ktf_map tests; /* List of tests to run */
> +	struct ktf_debugfs debugfs; /* debugfs handles for testset */
> +};

So this seems comparable to a `struct kunit_suite`, does that seem
right?

> +/* Used for tests that spawn kthreads to pass state.  We should probably
> + * look at passing data to tests like this to make things more extensible,
> + * but will defer for now as this would disrupt KTF consumers.
> + */
> +struct ktf_test_state {
> +	struct ktf_test *self;
> +	struct ktf_context *ctx;
> +	int iter;
> +	u32 value;
> +};
[...]
> +#endif /* KTF_TEST_H */
> -- 
> git-series 0.9.1

My initial thoughts: at a high level it seems that you have some data
structures and some functions which are pretty similiar to what exists
in KUnit. I also think this patch is *way* too complicated and is going
to need to be broken down into several smaller patches.

I think some book-keeping is done differently, but I think, at the core,
how we represent tests inside the kernel is actually very similar. I see
a bunch of stuff that you added to support the KTF netlink protocol and
the kprobe stuff, but I don't see any reason why you wouldn't be able to
add that to the KUnit data structures.

Could you try to see if you can implement your features on top of what
is already there in KUnit? I think a good place to start would be
getting hybrid tests working. Shuah and I were talking offlist and we
think that there is value to providing a mechanism to trigger tests from
userspace; it seems you have something that does that, and I think it
represents a small portion of what you have here. So maybe that is a
good place for you to start.

As for breaking this patch down, several things immediately jump out to
me that should be in different patchs:
 - kprobe stuff
 - expectations/assertions
 - hybrid tests
 - core in-kernel test stuff
You might even be able to break it down further, but I think that would
be a good start.

In any case, looks like good stuff. I am very keen on the arbitrary
function mocking/spying and the hybrid testing stuff in particular.

Cheers!
