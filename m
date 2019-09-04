Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0D6A815B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2019 13:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfIDLri (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Sep 2019 07:47:38 -0400
Received: from foss.arm.com ([217.140.110.172]:52576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfIDLri (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Sep 2019 07:47:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAFC1337;
        Wed,  4 Sep 2019 04:47:37 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E38603F246;
        Wed,  4 Sep 2019 04:47:36 -0700 (PDT)
Date:   Wed, 4 Sep 2019 12:47:34 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
Subject: Re: [PATCH v5 01/11] kselftest: arm64: add skeleton Makefile
Message-ID: <20190904114734.GR27757@arm.com>
References: <20190902112932.36129-1-cristian.marussi@arm.com>
 <20190902112932.36129-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902112932.36129-2-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 02, 2019 at 12:29:22pm +0100, Cristian Marussi wrote:
> Add a new arm64-specific empty subsystem amongst TARGETS of KSFT build
> framework; keep these new arm64 KSFT testcases separated into distinct

Nit: this isn't true any more, since the tags tests already added the
arm64 subsystem here.

> subdirs inside tools/testing/selftests/arm64/ depending on the specific
> subsystem targeted.
> 
> Add into toplevel arm64 KSFT Makefile a mechanism to guess the effective
> location of Kernel headers as installed by KSFT framework.

This:

> Merge with
> 
> commit 9ce1263033cd ("selftests, arm64: add a selftest for passing
> 		     tagged pointers to kernel")
> 
> while moving such KSFT tags tests inside their own subdirectory
> (arm64/tags).

...could be put under the tearoff, but it doesn't really belong in the
commit message IMHO.

I suggest rewriting the commit message to reflect the current
situation (but it can be kept brief).

Basically, what this patch now seems to do is to prepare for adding
more arm64 tests, by moving the tags tests into their own subdirectory
and extending the existing skeleton Makefile as appropriate.

> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v4 --> v5
> - rebased on arm64/for-next/core
> - merged this patch with KSFT arm64 tags patch, while moving the latter
>   into its own subdir
> - moved kernel header includes search mechanism from KSFT arm64
>   SIGNAL Makefile
> - export proper top_srcdir ENV for lib.mk
> v3 --> v4
> - comment reword
> - simplified documentation in README
> - dropped README about standalone
> ---

[...]

> diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
> index a61b2e743e99..5dbb0ffdfc9a 100644
> --- a/tools/testing/selftests/arm64/Makefile
> +++ b/tools/testing/selftests/arm64/Makefile
> @@ -1,11 +1,69 @@
>  # SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 ARM Limited

Change of copyright?  This isn't pure Arm IP upstream IIUC.

Maybe just drop it: Makefiles don't usually contain significant IP, so
many have no copyright message anyway.

> -# ARCH can be overridden by the user for cross compiling
> -ARCH ?= $(shell uname -m 2>/dev/null || echo not)
> +# When ARCH not overridden for crosscompiling, lookup machine
> +ARCH ?= $(shell uname -m)
> +ARCH := $(shell echo $(ARCH) | sed -e s/aarch64/arm64/)
>  
> -ifneq (,$(filter $(ARCH),aarch64 arm64))
> -TEST_GEN_PROGS := tags_test
> -TEST_PROGS := run_tags_test.sh
> +ifeq ("x$(ARCH)", "xarm64")
> +SUBDIRS := tags
> +else
> +SUBDIRS :=
>  endif
>  
> -include ../lib.mk
> +CFLAGS := -Wall -O2 -g
> +
> +# A proper top_srcdir is needed by KSFT(lib.mk)
> +top_srcdir = ../../../../..
> +
> +# Additional include paths needed by kselftest.h and local headers
> +CFLAGS += -I$(top_srcdir)/tools/testing/selftests/
> +
> +# Guessing where the Kernel headers could have been installed
> +# depending on ENV config
> +ifeq ($(KBUILD_OUTPUT),)
> +khdr_dir = $(top_srcdir)/usr/include
> +else
> +# the KSFT preferred location when KBUILD_OUTPUT is set
> +khdr_dir = $(KBUILD_OUTPUT)/kselftest/usr/include
> +endif

Looking at this, can we just pass the directory in from the toplevel
"all" rule instead of guessing?

Maybe don't churn this for now though.  It's something that could be
looked at later.

[...]

Apart from the comments above, the patch looks reasonable to me.

Cheers
---Dave
