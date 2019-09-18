Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95335B6142
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2019 12:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfIRKRL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Sep 2019 06:17:11 -0400
Received: from foss.arm.com ([217.140.110.172]:38664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728599AbfIRKRL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Sep 2019 06:17:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01977337;
        Wed, 18 Sep 2019 03:17:11 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BB503F59C;
        Wed, 18 Sep 2019 03:17:09 -0700 (PDT)
Date:   Wed, 18 Sep 2019 11:17:07 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     shuah <shuah@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>, amit.kachhap@arm.com,
        andreyknvl@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 01/11] kselftest: arm64: extend toplevel skeleton
 Makefile
Message-ID: <20190918101705.GP27757@arm.com>
References: <20190910123111.33478-1-cristian.marussi@arm.com>
 <20190910123111.33478-2-cristian.marussi@arm.com>
 <20190917160534.GK27757@arm.com>
 <119aaea7-10b5-0fdf-269d-e86df07b4831@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <119aaea7-10b5-0fdf-269d-e86df07b4831@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 17, 2019 at 10:18:55AM -0600, shuah wrote:
> On 9/17/19 10:05 AM, Dave Martin wrote:
> >On Tue, Sep 10, 2019 at 01:31:01pm +0100, Cristian Marussi wrote:
> >>Modify KSFT arm64 toplevel Makefile to maintain arm64 kselftests organized
> >>by subsystem, keeping them into distinct subdirectories under arm64 custom
> >>KSFT directory: tools/testing/selftests/arm64/
> >>
> >>Add to such toplevel Makefile a mechanism to guess the effective location
> >>of Kernel headers as installed by KSFT framework.
> >>
> >>Fit existing arm64 tags kselftest into this new schema moving them into
> >>their own subdirectory (arm64/tags).
> >>
> >>Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> >>---
> >>Based on:
> >>commit 9ce1263033cd ("selftests, arm64: add a selftest for passing
> >>		     tagged pointers to kernel")
> >>---
> >>v5 --> v6
> >>- using realpath to avoid passing down relative paths
> >>- fix commit msg & Copyright
> >>- removed unneded Makefile export
> >>- added SUBTARGETS specification, to allow building specific only some
> >>   arm64 test subsystems
> >>v4 --> v5
> >>- rebased on arm64/for-next/core
> >>- merged this patch with KSFT arm64 tags patch, while moving the latter
> >>   into its own subdir
> >>- moved kernel header includes search mechanism from KSFT arm64
> >>   SIGNAL Makefile
> >>- export proper top_srcdir ENV for lib.mk
> >>v3 --> v4
> >>- comment reword
> >>- simplified documentation in README
> >>- dropped README about standalone
> >>---
> >>  tools/testing/selftests/Makefile              |  1 +
> >>  tools/testing/selftests/arm64/Makefile        | 63 +++++++++++++++++--
> >>  tools/testing/selftests/arm64/README          | 25 ++++++++
> >>  tools/testing/selftests/arm64/tags/Makefile   |  6 ++
> >>  .../arm64/{ => tags}/run_tags_test.sh         |  0
> >>  .../selftests/arm64/{ => tags}/tags_test.c    |  0
> >>  6 files changed, 91 insertions(+), 4 deletions(-)
> >>  create mode 100644 tools/testing/selftests/arm64/README
> >>  create mode 100644 tools/testing/selftests/arm64/tags/Makefile
> >>  rename tools/testing/selftests/arm64/{ => tags}/run_tags_test.sh (100%)
> >>  rename tools/testing/selftests/arm64/{ => tags}/tags_test.c (100%)
> >>
> >>diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> >>index 25b43a8c2b15..1722dae9381a 100644
> >>--- a/tools/testing/selftests/Makefile
> >>+++ b/tools/testing/selftests/Makefile
> >>@@ -1,5 +1,6 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >>  TARGETS = android
> >>+TARGETS += arm64
> >>  TARGETS += bpf
> >>  TARGETS += breakpoints
> >>  TARGETS += capabilities
> >>diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
> >>index a61b2e743e99..cbb2a5a9e3fc 100644
> >>--- a/tools/testing/selftests/arm64/Makefile
> >>+++ b/tools/testing/selftests/arm64/Makefile
> >>@@ -1,11 +1,66 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >>-# ARCH can be overridden by the user for cross compiling
> >>+# When ARCH not overridden for crosscompiling, lookup machine
> >>  ARCH ?= $(shell uname -m 2>/dev/null || echo not)
> >>  ifneq (,$(filter $(ARCH),aarch64 arm64))
> >>-TEST_GEN_PROGS := tags_test
> >>-TEST_PROGS := run_tags_test.sh
> >>+SUBTARGETS ?= tags
> >>+else
> >>+SUBTARGETS :=
> >>  endif
> >>-include ../lib.mk
> >>+CFLAGS := -Wall -O2 -g
> >>+
> >>+# A proper top_srcdir is needed by KSFT(lib.mk)
> >>+top_srcdir = $(realpath ../../../../)
> >>+
> >>+# Additional include paths needed by kselftest.h and local headers
> >>+CFLAGS += -I$(top_srcdir)/tools/testing/selftests/
> >>+
> >>+# Guessing where the Kernel headers could have been installed
> >>+# depending on ENV config
> >>+ifeq ($(KBUILD_OUTPUT),)
> >>+khdr_dir = $(top_srcdir)/usr/include
> >>+else
> >>+# the KSFT preferred location when KBUILD_OUTPUT is set
> >>+khdr_dir = $(KBUILD_OUTPUT)/kselftest/usr/include
> >>+endif
> >
> >I still tend to think that for now we should just do what all the other
> >tests do.
> >
> >Most tests use
> >
> >	CFLAGS += -I../../../../usr/include/
> >
> >in their Makefiles.
> >
> >For us, the test Makefiles are nested one level deeper, so I guess
> >we would put
> >
> >	CFLAGS += -I../../../../../usr/include/
> >
> >in each.
> >
> >
> >This will break in some cases, but only in the same cases where
> >kselftest is already broken.
> >
> >Ideally we would fix this globally, but can that instead be done
> >independently of this series?
> >
> >Fixing only arm64, by pasting some arbitrary logic from
> >selftests/Makefile doesn't seem like a future-proof approach.
> >
> >
> >Or did I miss something?
> >
> >>+
> >>+CFLAGS += -I$(khdr_dir)
> >>+
> >>+export CFLAGS
> >>+export top_srcdir
> >>+
> >>+all:
> >>+	@for DIR in $(SUBTARGETS); do				\
> >>+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
> >>+		mkdir -p $$BUILD_TARGET;			\
> >>+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
> >>+	done
> >>+
> >>+install: all
> >>+	@for DIR in $(SUBTARGETS); do				\
> >>+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
> >>+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
> >>+	done
> >>+
> >>+run_tests: all
> >>+	@for DIR in $(SUBTARGETS); do				\
> >>+		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
> >>+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
> >>+	done
> >>+
> >>+# Avoid any output on non arm64 on emit_tests
> >
> >This comment can be dropped: the whole file does nothing for
> >non-arm64, and it achieves it in the same way as other arch-specific
> >Makefiles, so it's odd to have the comment here specifically (?)
> >
> >
> >With or without the above changes, I'm happy to give
> >
> >Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> >
> >(but Shuah or someone will need to give a view on how this integrates
> >with kselftest overall).
> >
> 
> I am reviewing the series this week. I will provide comments in a
> day or two.
> 
> thanks,
> -- Shuah

Thanks!

From the arm64 side, I'd say we're just down to minor issues at this
point.

Cheers
---Dave
