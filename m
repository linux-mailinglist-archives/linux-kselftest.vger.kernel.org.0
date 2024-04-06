Return-Path: <linux-kselftest+bounces-7345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1163B89ACFD
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 23:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99ED528202E
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 21:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCCE4E1C8;
	Sat,  6 Apr 2024 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1oyfLxj/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F7482EA;
	Sat,  6 Apr 2024 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712438090; cv=none; b=aJ9XL6hMc6BaPYwknhrJkAMXdNfdYxsgIaiUcp2PWeLHNJ0a235omjLwOZtdVWaTk5AIy2nLgEr2FraxhnqdnlYphedNrzAuq/3CHJKHubY8tweyLD195Pl6wPKnSFOJlHPUmc1VVCQlNp4UV9+OwYneUxWR+7Uda3zySqDgJD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712438090; c=relaxed/simple;
	bh=hhz6IpanWydt8WUTjJ/lmeFHNnKRshU3Zaa8XFkk05s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T+5S+Z0gx5Ik5yJxdBKlXNDH7l2GaSCWNd32QYOCl62qYDoI368D8TnSvk8/HMV9wjgHGinwGK5AQMvnTws67iKIBqPZ4BbVRS17ceGIQNBMidferBZx2Da5iWC0zpF+fLnebIYHpwTyG+fO+DjHWyc+6PbsRn6zsyXXQ1MoevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1oyfLxj/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712438087;
	bh=hhz6IpanWydt8WUTjJ/lmeFHNnKRshU3Zaa8XFkk05s=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=1oyfLxj/FML4m8aCygitnXqdREbMvB+E0/6/IWpycUDD+1I66xqzMJS8HzpBmdaQ2
	 Apdo8+cnpRCATIUTHu/jlAaAMEj43pOUue6rPhzR53VKmApQ/WmQIxR+1L1tYKYpuS
	 ZTN2FQ/wNuhYi9rOk++jBymeQbRJqwYCsdkkNYCRyBkODNOcIuIFAPOibsvGihjczV
	 KROakduPEMduugmssUU1uKdjqEuxYiPT525vNXA8ve2sGLMxjlvkcoMhg68Bjw3lAL
	 Zqa4+13Vlm6O0ECqP4sxfUzA0SbkI+NyjW5h6WVJRh1kGrL3PWztdJQ59aFeD5y8Kp
	 kSty/OMXFwhZg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0E8F0378020A;
	Sat,  6 Apr 2024 21:14:41 +0000 (UTC)
Message-ID: <ab271c32-dca8-413f-b97e-c8ceb6d7924c@collabora.com>
Date: Sun, 7 Apr 2024 02:15:15 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anshuman.Khandual@arm.com, suzuki.poulose@arm.com, ryan.roberts@arm.com,
 rob.herring@arm.com, Catalin.Marinas@arm.com, broonie@kernel.org,
 will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 4/4] selftests: Add build infrastructure along with README
To: Dev Jain <dev.jain@arm.com>, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240405084410.256788-1-dev.jain@arm.com>
 <20240405084410.256788-5-dev.jain@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240405084410.256788-5-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/24 1:44 PM, Dev Jain wrote:
> Add arm target, individual Makefile targets, and instructions to build the
> tests.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  tools/testing/selftests/Makefile            |  1 +
>  tools/testing/selftests/arm/Makefile        | 57 +++++++++++++++++++++
>  tools/testing/selftests/arm/README          | 31 +++++++++++
>  tools/testing/selftests/arm/elf/Makefile    |  6 +++
>  tools/testing/selftests/arm/mm/Makefile     |  6 +++
>  tools/testing/selftests/arm/signal/Makefile | 30 +++++++++++
>  6 files changed, 131 insertions(+)
>  create mode 100644 tools/testing/selftests/arm/Makefile
>  create mode 100644 tools/testing/selftests/arm/README
>  create mode 100644 tools/testing/selftests/arm/elf/Makefile
>  create mode 100644 tools/testing/selftests/arm/mm/Makefile
>  create mode 100644 tools/testing/selftests/arm/signal/Makefile
Add one recursive .gitignore file or multiple .gitignore files and put
generated object files in it to avoid clutter of generated objects in git
history.

> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 15b6a111c3be..8478d94cda4c 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  TARGETS += alsa
>  TARGETS += amd-pstate
> +TARGETS += arm
>  TARGETS += arm64
>  TARGETS += bpf
>  TARGETS += breakpoints
> diff --git a/tools/testing/selftests/arm/Makefile b/tools/testing/selftests/arm/Makefile
> new file mode 100644
> index 000000000000..039224bc006e
> --- /dev/null
> +++ b/tools/testing/selftests/arm/Makefile
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# When ARCH not overridden for crosscompiling, lookup machine
> +ARCH ?= $(shell uname -m 2>/dev/null || echo not)
> +
> +ifneq (,$(filter $(ARCH),aarch64 arm64 arm armv7l armv8l))
> +ARM_SUBTARGETS ?= mm signal elf
> +else
> +ARM_SUBTARGETS :=
> +endif
> +
> +CFLAGS := -Wall -O2 -g -static
> +
> +# A proper top_srcdir is needed by KSFT(lib.mk)
> +top_srcdir = $(realpath ../../../../)
> +
> +# Additional include paths needed by kselftest.h and local headers
> +CFLAGS += -I$(top_srcdir)/tools/testing/selftests/
> +
> +CFLAGS += -I$(top_srcdir)/tools/include
Please use KHDR_INCLUDE instead of using absolute path

> +
> +export CFLAGS
> +export top_srcdir
> +
> +all:
> +	@for DIR in $(ARM_SUBTARGETS); do				\
> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
> +		mkdir -p $$BUILD_TARGET;			\
> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
> +	done
> +
> +install: all
> +	@for DIR in $(ARM_SUBTARGETS); do				\
> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
> +	done
> +
> +run_tests: all
> +	@for DIR in $(ARM_SUBTARGETS); do				\
> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
> +	done
> +
> +# Avoid any output on non arm on emit_tests
> +emit_tests:
> +	@for DIR in $(ARM_SUBTARGETS); do				\
> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
> +	done
> +
> +clean:
> +	@for DIR in $(ARM_SUBTARGETS); do				\
> +		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
> +	done
> +
> +.PHONY: all clean install run_tests emit_tests
> diff --git a/tools/testing/selftests/arm/README b/tools/testing/selftests/arm/README
> new file mode 100644
> index 000000000000..1a05c043d7ee
> --- /dev/null
> +++ b/tools/testing/selftests/arm/README
> @@ -0,0 +1,31 @@
> +KSelfTest ARM
> +===============
> +
> +- This is a series of compatibility tests, wherein the source files are
> +  built statically into a 32 bit ELF; they should pass on both 32 and 64
> +  bit kernels. They are not built or run but just skipped completely when
> +  env-variable ARCH is found to be different than 'arm64' or 'arm' and
> +  `uname -m` reports other than 'aarch64', 'armv7l' or 'armv8l'.
> +
> +- Please ensure that the test kernel is built with CONFIG_COMPAT enabled.
Please create a config file and put all the per-requisite configurations in
that. For example, look at tools/testing/selftests/mm/config

> +
> +- Holding true the above, ARM KSFT tests can be run within the KSelfTest
> +  framework using standard Linux top-level-makefile targets. Please set
> +  $(CROSS_COMPILE) to 'arm-linux-gnueabi-' or 'arm-linux-gnueabihf-'.
> +
> +      $ make TARGETS=arm kselftest-clean
> +      $ make $(CROSS_COMPILE) TARGETS=arm kselftest
> +
> +      or
> +
> +      $ make $(CROSS_COMPILE) -C tools/testing/selftests TARGETS=arm \
> +		INSTALL_PATH=<your-installation-path> install
> +
> +      or, alternatively, only specific arm/ subtargets can be picked:
> +
> +      $ make $(CROSS_COMPILE) -C tools/testing/selftests TARGETS=arm \
> +		ARM_SUBTARGETS="signal" INSTALL_PATH=<your-installation-path> \
> +			install
> +
> +   Further details on building and running KFST can be found in:
> +     Documentation/dev-tools/kselftest.rst
Thanks for this well written documentation.

> diff --git a/tools/testing/selftests/arm/elf/Makefile b/tools/testing/selftests/arm/elf/Makefile
> new file mode 100644
> index 000000000000..86636fe02994
> --- /dev/null
> +++ b/tools/testing/selftests/arm/elf/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 ARM Limited
> +
> +TEST_GEN_PROGS := parse_elf
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/arm/mm/Makefile b/tools/testing/selftests/arm/mm/Makefile
> new file mode 100644
> index 000000000000..d8bfa45df98c
> --- /dev/null
> +++ b/tools/testing/selftests/arm/mm/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 ARM Limited
> +
> +TEST_GEN_PROGS := compat_va
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/arm/signal/Makefile b/tools/testing/selftests/arm/signal/Makefile
> new file mode 100644
> index 000000000000..3540a25de75a
> --- /dev/null
> +++ b/tools/testing/selftests/arm/signal/Makefile
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 ARM Limited
> +
> +# Additional include paths needed by kselftest.h and local headers
> +CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
> +
> +SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
> +PROGS := $(patsubst %.c,%,$(SRCS))
> +
> +# Generated binaries to be installed by top KSFT script
> +TEST_GEN_PROGS := $(notdir $(PROGS))
> +
> +# Get Kernel headers installed and use them.
> +
> +# Including KSFT lib.mk here will also mangle the TEST_GEN_PROGS list
> +# to account for any OUTPUT target-dirs optionally provided by
> +# the toplevel makefile
> +include ../../lib.mk
> +
> +$(TEST_GEN_PROGS): $(PROGS)
> +	cp $(PROGS) $(OUTPUT)/
> +
> +# Common test-unit targets to build common-layout test-cases executables
> +# Needs secondary expansion to properly include the testcase c-file in pre-reqs
> +COMMON_SOURCES := test_signals.c test_signals_utils.c
> +COMMON_HEADERS := test_signals.h test_signals_utils.h
> +
> +.SECONDEXPANSION:
> +$(PROGS): $$@.c ${COMMON_SOURCES} ${COMMON_HEADERS}
> +	$(CC) $(CFLAGS) ${@}.c ${COMMON_SOURCES} -o $@

-- 
BR,
Muhammad Usama Anjum

