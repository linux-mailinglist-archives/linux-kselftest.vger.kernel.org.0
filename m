Return-Path: <linux-kselftest+bounces-31154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABCEA93B7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D96817B3279
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986D7217734;
	Fri, 18 Apr 2025 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="IS8/DfFB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50147217701;
	Fri, 18 Apr 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995468; cv=pass; b=J0xLgt+EYlG9ZuoRQ0BEF+AKxkV4gDIf+qOSzPvgveA2mxlIf2GDIaIcJ0xQwzpvLbly1wVB5ZoPfqMSd7VbJymZwwfYD4ufSFw6oYL+/jbQqiVBY+5x9leyo2JjQ04K8OgIggCewoglxdO+BemqktFG36rrKcKQ2HrCzbBFEDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995468; c=relaxed/simple;
	bh=j394sdPoy1TFOK1NiTfP3tI9XfMt6T/lkVA9MdGbBUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gvum4r7R3M08biiILy9SiMCsOpfBc1HSThdhLnXEyeY3+eyGjsQwBhbgpwWlQRa7Vv/d8WQo9K47gtMmUqVC2zf0rS2TCJEsPNvq9Qr9JEH58XfXZAUCG1OqwkqOgofrJYvfseWp0Up2DOebdW8gi2skQrvtgzLuHT+mIK1BqNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=IS8/DfFB; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744995421; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=m1l6bh+A2YrsA39PhYyRcGzWvfFc1vfiHGbqvfePWe2fXvlmZMsR3f+xtv5xHus4El9eObu2BwNQC29/S8JaBWhKUz55wEqsQsniqh6xHdOw3P+5Q40eKPzhsyzugIz5zCfHxM3jlaD7UzAg5BPPZOqlVrR8kUH1IrzDoKxTwmE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744995421; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oRPC2ItHMkxFaau4AxBrLR7CttxC8Jjy7+M9RiyFnhw=; 
	b=ZdzrIlvZS1D5UM9N1jOIql5Zy3jmNgQ8XF2aIPRUls0wUWCf9kjOX6ADfdNbbM57uuTXoPafzwkKIeQFpMUUBa/1f+RS/1whnJpS5Xw2M2+xlvGRKXAecI5Il7Jfo3v/xLloY1fg8UEsRsVA+TtPiWuYdbC/lqK4in6jkuAa9QY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744995421;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=oRPC2ItHMkxFaau4AxBrLR7CttxC8Jjy7+M9RiyFnhw=;
	b=IS8/DfFBioAvmltZyKjibFhrc5tM0FULPhNrd7ugoZ7GYyBqEMfbdGY86hHXUycG
	PMXjzBSEIci84IM1ni01CVdBk/NsYgVIEtPg+o9fB1D66H9/W7TgsK0KzUqDqPAp3IV
	W3J8RfbzAu5rI9a+PjRToKhZEwbalvzPDLwgx8WY=
Received: by mx.zohomail.com with SMTPS id 1744995418289730.5392988040163;
	Fri, 18 Apr 2025 09:56:58 -0700 (PDT)
Message-ID: <6477df86-86ca-40df-989b-babe181f6fdb@collabora.com>
Date: Fri, 18 Apr 2025 21:56:50 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/32] selftests: harness: Add kselftest harness
 selftest
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
 <20250411-nolibc-kselftest-harness-v3-1-4d9c0295893f@linutronix.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-1-4d9c0295893f@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 4/11/25 2:00 PM, Thomas Weißschuh wrote:
> Add a selftest for the kselftest harness itself so any changes can be
> validated.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  MAINTAINERS                                        |   1 +
>  tools/testing/selftests/Makefile                   |   1 +
>  .../testing/selftests/kselftest_harness/.gitignore |   2 +
>  tools/testing/selftests/kselftest_harness/Makefile |   7 ++
>  .../selftests/kselftest_harness/harness-selftest.c | 129 +++++++++++++++++++++
>  .../kselftest_harness/harness-selftest.expected    |  62 ++++++++++
>  .../kselftest_harness/harness-selftest.sh          |  13 +++
>  7 files changed, 215 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96b82704950184bd71623ff41fc4df31e4c7fe87..9d5278df33c8b63b3b08155991b789b3a998f80e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21742,6 +21742,7 @@ F:	include/linux/seccomp.h
>  F:	include/uapi/linux/seccomp.h
>  F:	kernel/seccomp.c
>  F:	tools/testing/selftests/kselftest_harness.h
> +F:	tools/testing/selftests/kselftest_harness/
>  F:	tools/testing/selftests/seccomp/*
>  K:	\bsecure_computing
>  K:	\bTIF_SECCOMP\b
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index c77c8c8e3d9bdd8047c9cb7722c3830447e504e5..27592909a5969da009d71be6c8330fe6779e7354 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -48,6 +48,7 @@ TARGETS += ipc
>  TARGETS += ir
>  TARGETS += kcmp
>  TARGETS += kexec
> +TARGETS += kselftest_harness
>  TARGETS += kvm
>  TARGETS += landlock
>  TARGETS += lib
> diff --git a/tools/testing/selftests/kselftest_harness/.gitignore b/tools/testing/selftests/kselftest_harness/.gitignore
> new file mode 100644
> index 0000000000000000000000000000000000000000..e4e476a333c912602161448bc61787732a6fa2e2
> --- /dev/null
> +++ b/tools/testing/selftests/kselftest_harness/.gitignore
> @@ -0,0 +1,2 @@
> +/harness-selftest
> +/harness-selftest.seen
> diff --git a/tools/testing/selftests/kselftest_harness/Makefile b/tools/testing/selftests/kselftest_harness/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..0617535a6ce424ff977e033b0a3a01c3117aefcf
> --- /dev/null
> +++ b/tools/testing/selftests/kselftest_harness/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_GEN_PROGS_EXTENDED := harness-selftest
> +TEST_PROGS := harness-selftest.sh
> +EXTRA_CLEAN := harness-selftest.seen
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.c b/tools/testing/selftests/kselftest_harness/harness-selftest.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..8d39e7a0b99c41a5d33edfe2dbf875cac04c098d
> --- /dev/null
> +++ b/tools/testing/selftests/kselftest_harness/harness-selftest.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <stdio.h>
> +
> +#ifndef NOLIBC
> +#include <sys/resource.h>
> +#include <sys/prctl.h>
> +#endif
> +
> +/* Avoid any inconsistencies */
> +#define TH_LOG_STREAM stdout
> +
> +#include "../kselftest_harness.h"
> +
> +TEST(standalone_pass) {
> +	TH_LOG("before");
> +	ASSERT_EQ(0, 0);
> +	EXPECT_EQ(0, 0);
> +	TH_LOG("after");
> +}
> +
> +TEST(standalone_fail) {
> +	TH_LOG("before");
> +	EXPECT_EQ(0, 0);
> +	EXPECT_EQ(0, 1);
> +	ASSERT_EQ(0, 1);
> +	TH_LOG("after");
> +}
> +
> +TEST_SIGNAL(signal_pass, SIGUSR1) {
> +	TH_LOG("before");
> +	ASSERT_EQ(0, 0);
> +	TH_LOG("after");
> +	kill(getpid(), SIGUSR1);
> +}
> +
> +TEST_SIGNAL(signal_fail, SIGUSR1) {
> +	TH_LOG("before");
> +	ASSERT_EQ(0, 1);
> +	TH_LOG("after");
> +	kill(getpid(), SIGUSR1);
> +}
> +
> +FIXTURE(fixture) {
> +	pid_t testpid;
> +};
> +
> +FIXTURE_SETUP(fixture) {
> +	TH_LOG("setup");
> +	self->testpid = getpid();
> +}
> +
> +FIXTURE_TEARDOWN(fixture) {
> +	TH_LOG("teardown same-process=%d", self->testpid == getpid());
> +}
> +
> +TEST_F(fixture, pass) {
> +	TH_LOG("before");
> +	ASSERT_EQ(0, 0);
> +	TH_LOG("after");
> +}
> +
> +TEST_F(fixture, fail) {
> +	TH_LOG("before");
> +	ASSERT_EQ(0, 1);
> +	TH_LOG("after");
> +}
> +
> +TEST_F_TIMEOUT(fixture, timeout, 1) {
> +	TH_LOG("before");
> +	sleep(2);
> +	TH_LOG("after");
> +}
> +
> +FIXTURE(fixture_parent) {
> +	pid_t testpid;
> +};
> +
> +FIXTURE_SETUP(fixture_parent) {
> +	TH_LOG("setup");
> +	self->testpid = getpid();
> +}
> +
> +FIXTURE_TEARDOWN_PARENT(fixture_parent) {
> +	TH_LOG("teardown same-process=%d", self->testpid == getpid());
> +}
> +
> +TEST_F(fixture_parent, pass) {
> +	TH_LOG("before");
> +	ASSERT_EQ(0, 0);
> +	TH_LOG("after");
> +}
> +
> +FIXTURE(fixture_setup_failure) {
> +	pid_t testpid;
> +};
> +
> +FIXTURE_SETUP(fixture_setup_failure) {
> +	TH_LOG("setup");
> +	self->testpid = getpid();
> +	ASSERT_EQ(0, 1);
> +}
> +
> +FIXTURE_TEARDOWN(fixture_setup_failure) {
> +	TH_LOG("teardown same-process=%d", self->testpid == getpid());
> +}
> +
> +TEST_F(fixture_setup_failure, pass) {
> +	TH_LOG("before");
> +	ASSERT_EQ(0, 0);
> +	TH_LOG("after");
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	/*
> +	 * The harness uses abort() to signal assertion failures, which triggers coredumps.
> +	 * This may be useful to debug real failures but not for this selftest, disable them.
> +	 */
> +	struct rlimit rlimit = {
> +		.rlim_cur = 0,
> +		.rlim_max = 0,
> +	};
> +
> +	prctl(PR_SET_DUMPABLE, 0, 0, 0, 0);
> +	setrlimit(RLIMIT_CORE, &rlimit);
> +
> +	return test_harness_run(argc, argv);
> +}
> diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.expected b/tools/testing/selftests/kselftest_harness/harness-selftest.expected
> new file mode 100644
> index 0000000000000000000000000000000000000000..1aa6461db90d4e7cc0679f19b69aadf4032875ec
> --- /dev/null
> +++ b/tools/testing/selftests/kselftest_harness/harness-selftest.expected
> @@ -0,0 +1,62 @@
> +TAP version 13
> +1..9
> +# Starting 9 tests from 4 test cases.
> +#  RUN           global.standalone_pass ...
> +# harness-selftest.c:16:standalone_pass:before
> +# harness-selftest.c:19:standalone_pass:after
> +#            OK  global.standalone_pass
> +ok 1 global.standalone_pass
> +#  RUN           global.standalone_fail ...
> +# harness-selftest.c:23:standalone_fail:before
> +# harness-selftest.c:25:standalone_fail:Expected 0 (0) == 1 (1)
> +# harness-selftest.c:26:standalone_fail:Expected 0 (0) == 1 (1)
> +# standalone_fail: Test terminated by assertion
> +#          FAIL  global.standalone_fail
> +not ok 2 global.standalone_fail
> +#  RUN           global.signal_pass ...
> +# harness-selftest.c:31:signal_pass:before
> +# harness-selftest.c:33:signal_pass:after
> +#            OK  global.signal_pass
> +ok 3 global.signal_pass
> +#  RUN           global.signal_fail ...
> +# harness-selftest.c:38:signal_fail:before
> +# harness-selftest.c:39:signal_fail:Expected 0 (0) == 1 (1)
> +# signal_fail: Test terminated by assertion
> +#          FAIL  global.signal_fail
> +not ok 4 global.signal_fail
> +#  RUN           fixture.pass ...
> +# harness-selftest.c:49:pass:setup
> +# harness-selftest.c:58:pass:before
> +# harness-selftest.c:60:pass:after
> +# harness-selftest.c:54:pass:teardown same-process=1
> +#            OK  fixture.pass
> +ok 5 fixture.pass
> +#  RUN           fixture.fail ...
> +# harness-selftest.c:49:fail:setup
> +# harness-selftest.c:64:fail:before
> +# harness-selftest.c:65:fail:Expected 0 (0) == 1 (1)
> +# harness-selftest.c:54:fail:teardown same-process=1
> +# fail: Test terminated by assertion
> +#          FAIL  fixture.fail
> +not ok 6 fixture.fail
> +#  RUN           fixture.timeout ...
> +# harness-selftest.c:49:timeout:setup
> +# harness-selftest.c:70:timeout:before
> +# timeout: Test terminated by timeout
> +#          FAIL  fixture.timeout
> +not ok 7 fixture.timeout
> +#  RUN           fixture_parent.pass ...
> +# harness-selftest.c:80:pass:setup
> +# harness-selftest.c:89:pass:before
> +# harness-selftest.c:91:pass:after
> +# harness-selftest.c:85:pass:teardown same-process=0
> +#            OK  fixture_parent.pass
> +ok 8 fixture_parent.pass
> +#  RUN           fixture_setup_failure.pass ...
> +# harness-selftest.c:99:pass:setup
> +# harness-selftest.c:101:pass:Expected 0 (0) == 1 (1)
> +# pass: Test terminated by assertion
> +#          FAIL  fixture_setup_failure.pass
> +not ok 9 fixture_setup_failure.pass
> +# FAILED: 4 / 9 tests passed.
> +# Totals: pass:4 fail:5 xfail:0 xpass:0 skip:0 error:0
> diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.sh b/tools/testing/selftests/kselftest_harness/harness-selftest.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..fe72d16370fe5bc16706289ff4e1ff44db180017
> --- /dev/null
> +++ b/tools/testing/selftests/kselftest_harness/harness-selftest.sh
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Selftest for kselftest_harness.h
> +#
> +
> +set -e
> +
> +DIR="$(dirname $(readlink -f "$0"))"
> +
> +"$DIR"/harness-selftest > harness-selftest.seen || true
> +
> +diff -u "$DIR"/harness-selftest.expected harness-selftest.seen
> 


-- 
Regards,
Usama

