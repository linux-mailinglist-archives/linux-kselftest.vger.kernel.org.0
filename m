Return-Path: <linux-kselftest+bounces-37188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0501B02A50
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 11:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00848167892
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73488273808;
	Sat, 12 Jul 2025 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="k0o92uC5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51622320F;
	Sat, 12 Jul 2025 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752313850; cv=pass; b=J2gatGl6XEWbb79u/eNUugy5dOBzXr5OnSyk5TxXhBH4NcK9noTR64FeFEodD3EQ0sRIynppphO/fcQwl0lcb+AKl9A304N755+sod8Hm9ssWiK/0hpbIJnhdb4qm9AnLUrYxH4gmH8UV+nXJ/v8jKVsHxc/Gd2SlmTExRtlP1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752313850; c=relaxed/simple;
	bh=+Ynhpu2KXz4O7b5acgi7VjUcunB8pQv17pYrwm4Afjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoyYykbbGZ0VnUL7ctqKI3bcgOPLbHj6PEN92HsQ9CrFmSrKdL8lCCambQrFLvMMob6TKD6zrfTHf6Ime6sufD0TFhwq2flfTdnp1ijsIAVBfFm3VdMN6mcosFhv9J4Act5YAx2FSk/vTxVOKRmk3bHtFwtUFePutuq72cQkbsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=k0o92uC5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752313784; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IjAmJz1z0yMDYPwA+CnT1jRLlqgTk/jkDlnHnyeruSF+/L1kNge9i2ROXqRGw7GRPV6CPG1s5U/TfTwHC8pr0SNVZM7/TeOTJeMKqDkeQ83lK2hv9upcfgjguCFqikzu3ruJmRI1GkeDRv/E7wZnf1CDg4+ef94B1oMjRpj508s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752313784; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=go+Gwy9F2gBG7zGq4Wsnv/lQe3FIC9LBHLEwSkLnE/4=; 
	b=QniJ2o/9OhA6zU7q3+vrmzUxo2uRtAEoki4TFqKGnZD2kKg/qd5P3ZdRk/9ZBnTsds+Jj1AnZ0CLKfZ3iyiRRqXzA0M+B3v1B5E/ZXy4vvFTL4BD1spW/Hcmp+xfSQ1v1MbYhmA4MtCwL3q7lohk23+jOLtWdK9GmiAiHjRpCVs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752313784;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=go+Gwy9F2gBG7zGq4Wsnv/lQe3FIC9LBHLEwSkLnE/4=;
	b=k0o92uC5oivuRhDSgbLhC3qJe2CJLNbx82gnZG1YVp7UKEfjeY4yDBCyEuGA3fF6
	1OOiQEKwg43h60IR+jslzvtzqNfgNclpeAkFtm4F23lpvf1YUlAX/jySFJZoi5LkiZ+
	5M538ea/ql9V4qntmV/cQxntjBzWejageV/6OA+I=
Received: by mx.zohomail.com with SMTPS id 1752313782493219.79404897299253;
	Sat, 12 Jul 2025 02:49:42 -0700 (PDT)
Message-ID: <dc205138-3f68-4073-aeb3-3e2e67c15da4@collabora.com>
Date: Sat, 12 Jul 2025 14:49:38 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] kunit: uapi: Introduce preinit executable
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, workflows@vger.kernel.org
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-14-48760534fef5@linutronix.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250626-kunit-kselftests-v4-14-48760534fef5@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 6/26/25 11:10 AM, Thomas WeiÃschuh wrote:
> UAPI selftests may expect a "normal" userspace environment.
> For example the normal kernel API pseudo-filesystems should be mounted.
> This could be done from kernel code but it is non-idiomatic.
> 
> Add a preinit userspace executable which performs these setup steps
> before running the final test executable.
> This preinit executable is only ever run from the kernel.
> Give it access to autoconf.h and kconfig.h to adapt itself to the
> tested kernel.
From perspective of kselftests, I've liked the approach. Once we have an
automated way to run all the tests by some simple stubs, it would solve
the inherent problem of kselftests that it require different config options
enabled before tests can run. Hopefully, they would be auto enabled / disabled as
kernel config changes.

Acked-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
>  MAINTAINERS              |  1 +
>  lib/kunit/Makefile       |  6 +++++
>  lib/kunit/kunit-uapi.c   |  9 +++++--
>  lib/kunit/uapi-preinit.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b1405f0a0e638d1654d9dc9e51d784ddc838cf5b..e81dfa180ab374ef91c7a45e546e6e9a8f454fa7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13546,6 +13546,7 @@ S:	Maintained
>  F:	include/kunit/uapi.h
>  F:	lib/kunit/kunit-example-uapi.c
>  F:	lib/kunit/kunit-uapi.c
> +F:	lib/kunit/uapi-preinit.c
>  
>  KVM PARAVIRT (KVM/paravirt)
>  M:	Paolo Bonzini <pbonzini@redhat.com>
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 1bba7965613e36e26939d6b31e1d65acf5bad0dc..b50f3bc8bc7f3ade03be4900d9163d7a0d96863c 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -14,8 +14,14 @@ kunit-objs +=				test.o \
>  					device.o \
>  					platform.o
>  
> +userprogs +=				uapi-preinit
> +uapi-preinit-userccflags +=		-static $(NOLIBC_USERCFLAGS) \
> +					-include include/generated/autoconf.h \
> +					-include $(srctree)/tools/include/linux/kconfig.h
>  obj-$(CONFIG_KUNIT_UAPI) +=		kunit-uapi.o
>  
> +$(obj)/kunit-uapi.o: $(obj)/uapi-preinit
> +
>  ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
>  kunit-objs +=				debugfs.o
>  endif
> diff --git a/lib/kunit/kunit-uapi.c b/lib/kunit/kunit-uapi.c
> index cfe8440e16fde942a5f0fa7ac9d8ab90a737215b..7c87605b9ded9dbeb3968af8a8f4650ab5938887 100644
> --- a/lib/kunit/kunit-uapi.c
> +++ b/lib/kunit/kunit-uapi.c
> @@ -25,6 +25,8 @@
>  #define KSFT_XPASS	3
>  #define KSFT_SKIP	4
>  
> +KUNIT_UAPI_EMBED_BLOB(kunit_uapi_preinit, "uapi-preinit");
> +
>  static struct vfsmount *kunit_uapi_mount_ramfs(void)
>  {
>  	struct file_system_type *type;
> @@ -146,7 +148,7 @@ static int kunit_uapi_user_mode_thread_init(void *data)
>  	kernel_sigaction(SIGABRT, SIG_DFL);
>  
>  	complete(&ctx->setup_done);
> -	ctx->exec_err = kernel_execve(ctx->executable, argv, NULL);
> +	ctx->exec_err = kernel_execve(kbasename(kunit_uapi_preinit.path), argv, NULL);
>  	if (!ctx->exec_err)
>  		return 0;
>  	do_exit(0);
> @@ -255,7 +257,10 @@ static int kunit_uapi_run_executable(struct kunit *test,
>  	if (IS_ERR(mnt))
>  		return PTR_ERR(mnt);
>  
> -	err = kunit_uapi_write_executable(mnt, executable);
> +	err = kunit_uapi_write_executable(mnt, &kunit_uapi_preinit);
> +
> +	if (!err)
> +		err = kunit_uapi_write_executable(mnt, executable);
>  
>  	if (!err)
>  		err = kunit_uapi_run_executable_in_mount(test, exe_name, mnt);
> diff --git a/lib/kunit/uapi-preinit.c b/lib/kunit/uapi-preinit.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..81182039965a8c93aebb2d5d76f4113bfef277a6
> --- /dev/null
> +++ b/lib/kunit/uapi-preinit.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit Userspace environment setup.
> + *
> + * Copyright (C) 2025, Linutronix GmbH.
> + * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> + *
> + * This is *userspace* code.
> + */
> +
> +#include <sys/mount.h>
> +#include <sys/stat.h>
> +
> +#include "../../tools/testing/selftests/kselftest.h"
> +
> +static int setup_api_mount(const char *target, const char *fstype)
> +{
> +	int ret;
> +
> +	ret = mkdir(target, 0755);
> +	if (ret && errno != EEXIST)
> +		return -errno;
> +
> +	ret = mount("none", target, fstype, 0, NULL);
> +	if (ret && errno != EBUSY)
> +		return -errno;
> +
> +	return 0;
> +}
> +
> +static void exit_failure(const char *stage, int err)
> +{
> +	/* If preinit fails synthesize a failed test report. */
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +	ksft_test_result_fail("Failed during test setup: %s: %s\n", stage, strerror(-err));
Positive error values are passed to strerror() without the - sign in userspace.
Probably - needs to be removed from strerror() here.

> +	ksft_finished();
> +}
> +
> +int main(int argc, char **argv, char **envp)
> +{
> +	int ret;
> +
> +	ret = setup_api_mount("/proc", "proc");
> +	if (ret)
> +		exit_failure("mount /proc", ret);
> +
> +	ret = setup_api_mount("/sys", "sysfs");
> +	if (ret)
> +		exit_failure("mount /sys", ret);
> +
> +	if (IS_ENABLED(CONFIG_DEVTMPFS)) {
> +		ret = setup_api_mount("/dev", "devtmpfs");
> +		if (ret)
> +			exit_failure("mount /dev", ret);
> +	}
> +
> +	ret = execve(argv[0], argv, envp);
> +	if (ret)
> +		exit_failure("execve", ret);
> +
> +	return 0;
> +}
> 


