Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52DA94E61F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2019 12:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfFUKex (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jun 2019 06:34:53 -0400
Received: from foss.arm.com ([217.140.110.172]:57936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfFUKex (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jun 2019 06:34:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE43E142F;
        Fri, 21 Jun 2019 03:34:52 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E19CC3F718;
        Fri, 21 Jun 2019 03:34:51 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:34:49 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
Subject: Re: [PATCH 01/13] kselftest: arm64: introduce new boilerplate code
Message-ID: <20190621103449.GI2790@e103592.cambridge.arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
 <20190613111335.7645-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613111335.7645-2-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 13, 2019 at 12:13:23PM +0100, Cristian Marussi wrote:
> Added a new arm64-specific empty subsystem amongst TARGETS of KSFT build
> framework; once populated with testcases, it will be possible to build
> and invoke the new KSFT TARGETS=arm64 related tests from the toplevel
> Makefile in the usual ways.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  tools/testing/selftests/Makefile       |  1 +
>  tools/testing/selftests/arm64/Makefile | 51 ++++++++++++++++++++++++++
>  tools/testing/selftests/arm64/README   | 44 ++++++++++++++++++++++
>  3 files changed, 96 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/Makefile
>  create mode 100644 tools/testing/selftests/arm64/README
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 9781ca79794a..4ff0b41ead8a 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  TARGETS = android
> +TARGETS += arm64
>  TARGETS += bpf
>  TARGETS += breakpoints
>  TARGETS += capabilities
> diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
> new file mode 100644
> index 000000000000..03a0d4f71218
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/Makefile
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 ARM Limited
> +
> +# When ARCH not overridden for crosscompiling, lookup machine
> +ARCH ?= $(shell uname -m)
> +ARCH := $(shell echo $(ARCH) | sed -e s/aarch64/arm64/)
> +
> +ifeq ("x$(ARCH)", "xarm64")
> +SUBDIRS :=
> +else
> +SUBDIRS :=
> +endif
> +
> +CFLAGS := -Wall -O2 -g
> +
> +export CC
> +export CFLAGS
> +
> +all:
> +	@for DIR in $(SUBDIRS); do				\
> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
> +		mkdir -p $$BUILD_TARGET;			\
> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
> +	done
> +
> +install: all
> +	@for DIR in $(SUBDIRS); do				\
> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
> +	done
> +
> +run_tests: all
> +	@for DIR in $(SUBDIRS); do				\
> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
> +	done
> +
> +# Avoid any output on non arm64 on emit_tests
> +emit_tests: all
> +	@for DIR in $(SUBDIRS); do				\
> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
> +	done
> +
> +clean:
> +	@for DIR in $(SUBDIRS); do				\
> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
> +	done
> +
> +.PHONY: all clean install run_tests emit_tests
> diff --git a/tools/testing/selftests/arm64/README b/tools/testing/selftests/arm64/README
> new file mode 100644
> index 000000000000..d5aa7a2eda78
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/README
> @@ -0,0 +1,44 @@
> +KSelfTest ARM64
> +===============
> +
> +- These tests are arm64 specific and so not built or run but just skipped
> +  completely when env-variable ARCH is found to be different than 'arm64'
> +  and `uname -m` reports other than 'aarch64'.
> +
> +- Holding true the above, ARM64 KSFT tests can be run:
> +
> +   + as standalone (example for signal tests)
> +
> +      $ make -C tools/testing/selftest/arm64/signal clean
> +      $ make -C tools/testing/selftest/arm64/signal \
> +		INSTALL_PATH=<your-installation-path> install
> +
> +      and then launching on the target device inside the installed path:
> +
> +      device# cd <your-installed-path> && ./test_arm64_signals.sh [-k | -v]

(Similar nits to those on the arm64-specific documentation in the next
patch.)

Otherwise, this looks sensible.

[...]

Cheers
---Dave
