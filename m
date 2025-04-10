Return-Path: <linux-kselftest+bounces-30486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF0CA847A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 17:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87FF4A532A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 15:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07331E1A16;
	Thu, 10 Apr 2025 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ePkbFQDE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1851E9B0F
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744298386; cv=none; b=KoA6SihiE9TiJQv/9I2ZhxkI9fkDZt/YB6lka3hiL7+iF+wHN3EPrpXmPm3/mTZyjoZDykpPAbNtrYeS3sbEQYv9b8Ad2cD6jiIvYURTACc5ZQjX34fwzdD4RYJi5lmKr2w7gvIq3oMA3/ezVtny9rD70ItUUhZxI1vsIhxLfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744298386; c=relaxed/simple;
	bh=VssWxC84mEs7L9/avRuqypjxEQmdSjrRRIUEqYV4Wpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H17IhBmG7ZhdfsyllOEmXoFKnNfNpSciuF/+h5DwKnS6oktKBpAdm5HuzaCelIol3JC3deFacz1XIORmFN4b9PREMpZiAZ7uXx+HtzJjyqw63rk5J8ZzHK7yAE7IBfhGQCmteUYb5vdO0pDvTnx5n8mqYxmF1uzk2bAnYV7hGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ePkbFQDE; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d6d6d82633so3559055ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744298383; x=1744903183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTbAkNf1q5qo8+NwqAeTj3dhW58KgCjW3CTJ6jZXbHw=;
        b=ePkbFQDEHxNupxbPmOaU+e1OS7QzjayaCGjCCCUAn55nfKDFUFJex4hkpkFxrbJTMf
         AaGBB+xKFtOSMRtlSBx1n5rPOuGwtDBI1ROKszFGY0ZvvqyhtEp+oSWGp3/tGWG5TuMl
         Z0GGjQ5mwayMDekARmrSqzA9gos0+LAM1nmj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744298383; x=1744903183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTbAkNf1q5qo8+NwqAeTj3dhW58KgCjW3CTJ6jZXbHw=;
        b=sdLpx2dtg3DqyxLvi5dK9HHgf6H3LMEmbI1Vlefr7m4HLJqslR3b+kfG4LzKrhXNqG
         YxaNUuEDmJNEJcEkbQDKWgS72/prazxn2Kp/jmAsQr/HPDogX4RtJi2mTEv44QcHg5y6
         /k8nH9qmouEtqmlvPMSA/UkhlwB4JEJ6K220nCTthibALVvCVgbwIYSNjae6UUqvauVW
         sIoyfzaXhPRedVp1ef8AxWebrv0SZT5iPjfEDXtaZauX1dN4vwALr4MAs1DEs1rD07xO
         ZW7yxicsdTNNSu/+fT08vsDD7i3uZZYLiyHnsxLcnEc4262EaJVoCRTPCh8T5QsAW2xq
         J64g==
X-Forwarded-Encrypted: i=1; AJvYcCXmlbdmURYtwTxYkCBzqdTof2XIWIpMqMYC/t/jiUxEE2x/2ErwdzQt92r1LRQO55uUhm19JADZDFy3BblXQVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWiysyRK8cO3PG1Fj9aEPpdQJCB7pmWCidNGZaX7rROOxdwgoT
	qsqnWt5DXFeQL3AWFzd4wCVZdlye25aVC7+JqOcd+uEHTJShwvTT/wnpaXmqlBE=
X-Gm-Gg: ASbGncvO6Y1xgAwh1FIDLSjljfr8AJOOfgHlA0y1NlAFbmMBcwNIes2UjCPPavPAQaf
	Zmd8iWuF60zH8jCeUZnXGW+BHCGns/Qb7ikpIBzNuxqVXwpjSF4hPI6q3Uz+XFYnnwmm+2l7q+k
	VZmbz++EgaFYdaSSgTSAZpCeyc8uTf2k2TXDjElKpqQ5wATf5DXxXotc5XUs/vvYiY0fy3Al3of
	opNUih/eBYUaaPJKvQ38LCLTesqdde9LdCR/blHhPDYU4bf+5xOIWiVebLW5aKFVhul/6klA+n+
	D4VI6yRrclzfzEaX5sxWk6rM70FmojIJwZtp7nVxXp6CPiPrhx8=
X-Google-Smtp-Source: AGHT+IG00hHo/TwmdfOnZOSnb8NCdsyorRqLEyAr44S8McihuyDzghob6c74mBPiuDyaGp8HrfN1yw==
X-Received: by 2002:a05:6e02:258b:b0:3d0:235b:4810 with SMTP id e9e14a558f8ab-3d7e46e0837mr32083585ab.2.1744298383441;
        Thu, 10 Apr 2025 08:19:43 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2e610sm772963173.108.2025.04.10.08.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 08:19:42 -0700 (PDT)
Message-ID: <4af4d2a5-1503-47c6-8da0-cb7586294f0e@linuxfoundation.org>
Date: Thu, 10 Apr 2025 09:19:42 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/32] selftests: harness: Add harness selftest
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Shuah Khan <shuah@kernel.org>, Willy Tarreau <w@1wt.eu>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
 <20250407-nolibc-kselftest-harness-v2-1-f8812f76e930@linutronix.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-1-f8812f76e930@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/7/25 00:52, Thomas Weißschuh wrote:
> Add a selftest for the harness itself so any changes can be validated.
> 

kselftest harness?

> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   tools/testing/selftests/Makefile                   |   1 +
>   tools/testing/selftests/kselftest/.gitignore       |   1 +
>   tools/testing/selftests/kselftest/Makefile         |   6 +
>   .../testing/selftests/kselftest/harness-selftest.c | 129 +++++++++++++++++++++
>   .../selftests/kselftest/harness-selftest.expected  |  62 ++++++++++
>   .../selftests/kselftest/harness-selftest.sh        |  14 +++
>   6 files changed, 213 insertions(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index c77c8c8e3d9bdd8047c9cb7722c3830447e504e5..3ce071eefa86af59aadd1df7972fdf3bf6e01d52 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -48,6 +48,7 @@ TARGETS += ipc
>   TARGETS += ir
>   TARGETS += kcmp
>   TARGETS += kexec
> +TARGETS += kselftest

kselftest name can be confusing to users  since the the test suite is called
kselftest in the main Makefile. Find different name - kselftest_harness?

Also don't add files to selftests/kselftest - create a new directory.

make kselftest (runs the entire suite).

>   TARGETS += kvm
>   TARGETS += landlock
>   TARGETS += lib
> diff --git a/tools/testing/selftests/kselftest/.gitignore b/tools/testing/selftests/kselftest/.gitignore

Add a new directory - kselftest_harness?

> new file mode 100644
> index 0000000000000000000000000000000000000000..9aab194e8ea25a2c5ccc116f9f728b8afd0c51c4
> --- /dev/null
> +++ b/tools/testing/selftests/kselftest/.gitignore
> @@ -0,0 +1 @@
> +/harness-selftest
> diff --git a/tools/testing/selftests/kselftest/Makefile b/tools/testing/selftests/kselftest/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..2f2933553dbc47014d9dfe0b4bd8ad3bc36e38c2
> --- /dev/null
> +++ b/tools/testing/selftests/kselftest/Makefile

Same here - don't put these under selftests/kselftest

> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_GEN_PROGS_EXTENDED := harness-selftest
> +TEST_PROGS := harness-selftest.sh
> +
> +include ../lib.mk

Need a clean override since you are creatinbg a TMPFILE so it
gets cleaned up.

> diff --git a/tools/testing/selftests/kselftest/harness-selftest.c b/tools/testing/selftests/kselftest/harness-selftest.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..8d39e7a0b99c41a5d33edfe2dbf875cac04c098d
> --- /dev/null
> +++ b/tools/testing/selftests/kselftest/harness-selftest.c
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
> diff --git a/tools/testing/selftests/kselftest/harness-selftest.expected b/tools/testing/selftests/kselftest/harness-selftest.expected
> new file mode 100644
> index 0000000000000000000000000000000000000000..1aa6461db90d4e7cc0679f19b69aadf4032875ec
> --- /dev/null
> +++ b/tools/testing/selftests/kselftest/harness-selftest.expected
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
> diff --git a/tools/testing/selftests/kselftest/harness-selftest.sh b/tools/testing/selftests/kselftest/harness-selftest.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..bf691adf0b41aaedb2fbc5f06add9fd1d5689044
> --- /dev/null
> +++ b/tools/testing/selftests/kselftest/harness-selftest.sh
> @@ -0,0 +1,14 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Selftest for kselftest_harness.h
> +#
> +
> +DIR="$(dirname $(readlink -f "$0"))"
> +
> +TMPFILE="$(mktemp)"
> +trap 'rm "$TMPFILE"' EXIT
> +
> +$DIR/harness-selftest > "$TMPFILE"
> +
> +diff -u "$DIR"/harness-selftest.expected "$TMPFILE"

This TMPFILE needs to be removed from make clean

> 

thanks,
-- Shuah

