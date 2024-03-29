Return-Path: <linux-kselftest+bounces-6899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB628924DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 21:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DA328594F
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F3D13AA48;
	Fri, 29 Mar 2024 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="el4MOXz8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEA12D603;
	Fri, 29 Mar 2024 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742807; cv=none; b=XDZJspkiURZoHDF+KQkbtsgTde/hEio5937E5L31u9Qb4NeFKASHbwl+QjT6q3YRWLMxzX7tpzJ13BOBtSDFxifDKjA7HhbSU2yKMNALfMbEIEbfv6qM+FSY+huKW8oFk8uE8OuvzQtJyQMBoivtT9X9OYh1sxUUaPCoi/vRfsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742807; c=relaxed/simple;
	bh=IpR8t9TlCO6dA+NNoYBZAT4Y1SQ8QTNF0MuQmcy6ew8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ANQyL0fmTVAnXTpfmHaayweuX9OYFa9Um/6UFGaCrJL6ZXEkchlIrdX7tNdXs72i7ex3dM+NbawsBMz976ZfxQtVN9ziCmnlw+zulaZY259d4TUu/QVUw/eQnbWc6oX0Hb/I/exwc7xGvLNEb/s9aPbT0xd/9dZR52y9ClFg10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=el4MOXz8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711742803;
	bh=IpR8t9TlCO6dA+NNoYBZAT4Y1SQ8QTNF0MuQmcy6ew8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=el4MOXz80U1jbiT/qhNxjT5/5A3rUR5erGlcL7dZWo1O4eLq6SQeeHZTFkZiTz9t4
	 YdBruf9i/J5nwtqQ6p57zn1iK59M4LrLbeCzJ94N+cdvdpL7+vRhR9bpUs7hRAOIRe
	 XoZn6SqkqWeSwaOeXYV+36WfhF1bY9Ylk0vSVp91GUV7Hi7l74eDJ2fknMlZfDbdjW
	 ZTSYsmSvpR0XD9+qpJJIycTM2otVzRCJmWWHfJ/BdJ649o9ioAlRt6bMaI0WW8LWbp
	 x35wmoNL2AQ13jxstCMIuAGcIZtBJHD+pQqJ5Ld5sD2gLklmWCRBHk2DHejnBsZfg+
	 lPG1xH2Y/IPXg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 633C33780C22;
	Fri, 29 Mar 2024 20:06:38 +0000 (UTC)
Message-ID: <a3176f4c-1b03-4537-9217-c90678509611@collabora.com>
Date: Sat, 30 Mar 2024 01:07:08 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Wolfram Sang <wsa@kernel.org>,
 Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 17/30] selftests: ntsync: Add some tests for semaphore
 state.
To: Elizabeth Figura <zfigura@codeweavers.com>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
References: <20240329000621.148791-1-zfigura@codeweavers.com>
 <20240329000621.148791-18-zfigura@codeweavers.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240329000621.148791-18-zfigura@codeweavers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/24 5:06 AM, Elizabeth Figura wrote:
> Wine has tests for its synchronization primitives, but these are more accessible
> to kernel developers, and also allow us to test some edge cases that Wine does
> not care about.
> 
> This patch adds tests for semaphore-specific ioctls NTSYNC_IOC_SEM_POST and
> NTSYNC_IOC_SEM_READ, and waiting on semaphores.
> 
> Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  .../testing/selftests/drivers/ntsync/Makefile |   8 +
>  tools/testing/selftests/drivers/ntsync/config |   1 +
>  .../testing/selftests/drivers/ntsync/ntsync.c | 149 ++++++++++++++++++
Please add generated binary objects in .gitignore file.

>  4 files changed, 159 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/ntsync/Makefile
>  create mode 100644 tools/testing/selftests/drivers/ntsync/config
>  create mode 100644 tools/testing/selftests/drivers/ntsync/ntsync.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index e1504833654d..6f95206325e1 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -16,6 +16,7 @@ TARGETS += damon
>  TARGETS += devices
>  TARGETS += dmabuf-heaps
>  TARGETS += drivers/dma-buf
> +TARGETS += drivers/ntsync
>  TARGETS += drivers/s390x/uvdevice
>  TARGETS += drivers/net/bonding
>  TARGETS += drivers/net/team
> diff --git a/tools/testing/selftests/drivers/ntsync/Makefile b/tools/testing/selftests/drivers/ntsync/Makefile
> new file mode 100644
> index 000000000000..a34da5ccacf0
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/ntsync/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-LICENSE-IDENTIFIER: GPL-2.0-only
> +TEST_GEN_PROGS := ntsync
> +
> +top_srcdir =../../../../..
> +CFLAGS += -I$(top_srcdir)/usr/include
Please use KHDR_INCLUDES instead of specifying include path.

> +LDLIBS += -lpthread
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/drivers/ntsync/config b/tools/testing/selftests/drivers/ntsync/config
> new file mode 100644
> index 000000000000..60539c826d06
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/ntsync/config
> @@ -0,0 +1 @@
> +CONFIG_WINESYNC=y
> diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
> new file mode 100644
> index 000000000000..1e145c6dfded
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Various unit tests for the "ntsync" synchronization primitive driver.
> + *
> + * Copyright (C) 2021-2022 Elizabeth Figura <zfigura@codeweavers.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/ioctl.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <time.h>
> +#include <pthread.h>
> +#include <linux/ntsync.h>
> +#include "../../kselftest_harness.h"
> +
> +static int read_sem_state(int sem, __u32 *count, __u32 *max)
> +{
> +	struct ntsync_sem_args args;
> +	int ret;
> +
> +	memset(&args, 0xcc, sizeof(args));
> +	ret = ioctl(sem, NTSYNC_IOC_SEM_READ, &args);
> +	*count = args.count;
> +	*max = args.max;
> +	return ret;
> +}
> +
> +#define check_sem_state(sem, count, max) \
> +	({ \
> +		__u32 __count, __max; \
> +		int ret = read_sem_state((sem), &__count, &__max); \
> +		EXPECT_EQ(0, ret); \
> +		EXPECT_EQ((count), __count); \
> +		EXPECT_EQ((max), __max); \
> +	})
> +
> +static int post_sem(int sem, __u32 *count)
> +{
> +	return ioctl(sem, NTSYNC_IOC_SEM_POST, count);
> +}
> +
> +static int wait_any(int fd, __u32 count, const int *objs, __u32 owner, __u32 *index)
> +{
> +	struct ntsync_wait_args args = {0};
> +	struct timespec timeout;
> +	int ret;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &timeout);
> +
> +	args.timeout = timeout.tv_sec * 1000000000 + timeout.tv_nsec;
> +	args.count = count;
> +	args.objs = (uintptr_t)objs;
> +	args.owner = owner;
> +	args.index = 0xdeadbeef;
> +	ret = ioctl(fd, NTSYNC_IOC_WAIT_ANY, &args);
> +	*index = args.index;
> +	return ret;
> +}
> +
> +TEST(semaphore_state)
> +{
> +	struct ntsync_sem_args sem_args;
> +	struct timespec timeout;
> +	__u32 count, index;
> +	int fd, ret, sem;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &timeout);
> +
> +	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
> +	ASSERT_LE(0, fd);
> +
> +	sem_args.count = 3;
> +	sem_args.max = 2;
> +	sem_args.sem = 0xdeadbeef;
> +	ret = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
> +	EXPECT_EQ(-1, ret);
> +	EXPECT_EQ(EINVAL, errno);
> +
> +	sem_args.count = 2;
> +	sem_args.max = 2;
> +	sem_args.sem = 0xdeadbeef;
> +	ret = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
> +	EXPECT_EQ(0, ret);
> +	EXPECT_NE(0xdeadbeef, sem_args.sem);
> +	sem = sem_args.sem;
> +	check_sem_state(sem, 2, 2);
> +
> +	count = 0;
> +	ret = post_sem(sem, &count);
> +	EXPECT_EQ(0, ret);
> +	EXPECT_EQ(2, count);
> +	check_sem_state(sem, 2, 2);
> +
> +	count = 1;
> +	ret = post_sem(sem, &count);
> +	EXPECT_EQ(-1, ret);
> +	EXPECT_EQ(EOVERFLOW, errno);
> +	check_sem_state(sem, 2, 2);
> +
> +	ret = wait_any(fd, 1, &sem, 123, &index);
> +	EXPECT_EQ(0, ret);
> +	EXPECT_EQ(0, index);
> +	check_sem_state(sem, 1, 2);
> +
> +	ret = wait_any(fd, 1, &sem, 123, &index);
> +	EXPECT_EQ(0, ret);
> +	EXPECT_EQ(0, index);
> +	check_sem_state(sem, 0, 2);
> +
> +	ret = wait_any(fd, 1, &sem, 123, &index);
> +	EXPECT_EQ(-1, ret);
> +	EXPECT_EQ(ETIMEDOUT, errno);
> +
> +	count = 3;
> +	ret = post_sem(sem, &count);
> +	EXPECT_EQ(-1, ret);
> +	EXPECT_EQ(EOVERFLOW, errno);
> +	check_sem_state(sem, 0, 2);
> +
> +	count = 2;
> +	ret = post_sem(sem, &count);
> +	EXPECT_EQ(0, ret);
> +	EXPECT_EQ(0, count);
> +	check_sem_state(sem, 2, 2);
> +
> +	ret = wait_any(fd, 1, &sem, 123, &index);
> +	EXPECT_EQ(0, ret);
> +	ret = wait_any(fd, 1, &sem, 123, &index);
> +	EXPECT_EQ(0, ret);
> +
> +	count = 1;
> +	ret = post_sem(sem, &count);
> +	EXPECT_EQ(0, ret);
> +	EXPECT_EQ(0, count);
> +	check_sem_state(sem, 1, 2);
> +
> +	count = ~0u;
> +	ret = post_sem(sem, &count);
> +	EXPECT_EQ(-1, ret);
> +	EXPECT_EQ(EOVERFLOW, errno);
> +	check_sem_state(sem, 1, 2);
> +
> +	close(sem);
> +
> +	close(fd);
> +}
> +
> +TEST_HARNESS_MAIN

-- 
BR,
Muhammad Usama Anjum

