Return-Path: <linux-kselftest+bounces-7340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE6E89ACEB
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 22:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E28B281AB8
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D854AEFB;
	Sat,  6 Apr 2024 20:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EgC/KUca"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4718C1F;
	Sat,  6 Apr 2024 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712436346; cv=none; b=UQGxq0smKWZ4Ol667e3ZrwMzPWDH2xaKziv0h8eW65L/TqZDhrVzfgpComQ+SZBbHJeFMlSFZr1xia6vnz5Xx00rTA0XkVjAT49wjCBilQkxuDvWfB+1PKxjsQODaf/Vv8vXj2KGdN6Pg3HF0LtURQbI5OuwmtLgi4JfsVVkCY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712436346; c=relaxed/simple;
	bh=FRWRnhNsSxuJgVIpxFQ6rPjxxUUYOlJsTkGK+pV2FpQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sYnJD9S4mgOVUvC2f6MZJxWXanizz1GhqN0nQcQ99v0uUrb6wP4ltgJgxkjFXeGKOM7QXr/Z+neZ/oyBnp8gzlnFRLFhpetPKBxLS2FLP/OfS7uisCzKuhvRF6TG+wtKara4Opk3QTEDm/mD9frh6bWrPZSXY/Rht01/7ex9jDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EgC/KUca; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712436342;
	bh=FRWRnhNsSxuJgVIpxFQ6rPjxxUUYOlJsTkGK+pV2FpQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=EgC/KUcaj4v4QrFr3ZcIZ/idZBDJjx+twTOdCH17SnVZNbffmjSrMijIJfB7/npM8
	 Z/MAa0r+2FODfQxV+dBRiAFf9RCEaqhPexpnfn5s3FnDQJQVC+eDTo8QomYwXMdMTY
	 kiYzS0q7SOdG6Z3ABWz9hThFtMUh84/FBgAB7ol0WDrIxmmyuO+K30+Tq1yrTJEfGD
	 25KvR8vwkUMuOc2ZIp7cKsDEwNEpLCrJLyyW1FHe3FwLm38tE89gsN9uoR15yQTlo5
	 o/AgO9CxRH13zGPDX1biR7wojyUpR0fZyeP/FdARD9Ee5d3tcl0pLOdG+ogFQlw/CG
	 jZkS5yl2pXsTQ==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 90BB337809D1;
	Sat,  6 Apr 2024 20:45:38 +0000 (UTC)
Message-ID: <5da2d9af-7882-49a3-bc39-553e86adf271@collabora.com>
Date: Sun, 7 Apr 2024 01:46:11 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 rdunlap@infradead.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v20 5/5] ring-buffer/selftest: Add ring-buffer mapping
 test
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20240406173649.3210836-1-vdonnefort@google.com>
 <20240406173649.3210836-6-vdonnefort@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240406173649.3210836-6-vdonnefort@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/24 10:36 PM, Vincent Donnefort wrote:
> This test maps a ring-buffer and validate the meta-page after reset and
> after emitting few events.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Acked-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> 
> diff --git a/tools/testing/selftests/ring-buffer/Makefile b/tools/testing/selftests/ring-buffer/Makefile
> new file mode 100644
> index 000000000000..627c5fa6d1ab
> --- /dev/null
> +++ b/tools/testing/selftests/ring-buffer/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS += -Wl,-no-as-needed -Wall
> +CFLAGS += $(KHDR_INCLUDES)
> +CFLAGS += -D_GNU_SOURCE
> +
> +TEST_GEN_PROGS = map_test
> +
> +include ../lib.mk
Please add a .gitignore file with map_test in it.

> diff --git a/tools/testing/selftests/ring-buffer/config b/tools/testing/selftests/ring-buffer/config
> new file mode 100644
> index 000000000000..d936f8f00e78
> --- /dev/null
> +++ b/tools/testing/selftests/ring-buffer/config
> @@ -0,0 +1,2 @@
> +CONFIG_FTRACE=y
> +CONFIG_TRACER_SNAPSHOT=y
> diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
> new file mode 100644
> index 000000000000..50a09e1371d4
> --- /dev/null
> +++ b/tools/testing/selftests/ring-buffer/map_test.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Ring-buffer memory mapping tests
> + *
> + * Copyright (c) 2024 Vincent Donnefort <vdonnefort@google.com>
> + */
> +#include <fcntl.h>
> +#include <sched.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#include <linux/trace_mmap.h>
> +
> +#include <sys/mman.h>
> +#include <sys/ioctl.h>
> +
> +#include "../user_events/user_events_selftests.h" /* share tracefs setup */
> +#include "../kselftest_harness.h"
> +
> +#define TRACEFS_ROOT "/sys/kernel/tracing"
> +
> +static int __tracefs_write(const char *path, const char *value)
> +{
> +	int fd, ret;
> +
> +	fd = open(path, O_WRONLY | O_TRUNC);
> +	if (fd < 0)
> +		return fd;
> +
> +	ret = write(fd, value, strlen(value));
> +
> +	close(fd);
> +
> +	return ret == -1 ? -errno : 0;
> +}
> +
> +static int __tracefs_write_int(const char *path, int value)
> +{
> +	char *str;
> +	int ret;
> +
> +	if (asprintf(&str, "%d", value) < 0)
> +		return -1;
> +
> +	ret = __tracefs_write(path, str);
> +
> +	free(str);
> +
> +	return ret;
> +}
> +
> +#define tracefs_write_int(path, value) \
> +	ASSERT_EQ(__tracefs_write_int((path), (value)), 0)
> +
> +#define tracefs_write(path, value) \
> +	ASSERT_EQ(__tracefs_write((path), (value)), 0)
> +
> +static int tracefs_reset(void)
> +{
> +	if (__tracefs_write_int(TRACEFS_ROOT"/tracing_on", 0))
> +		return -1;
> +	if (__tracefs_write(TRACEFS_ROOT"/trace", ""))
> +		return -1;
> +	if (__tracefs_write(TRACEFS_ROOT"/set_event", ""))
> +		return -1;
> +	if (__tracefs_write(TRACEFS_ROOT"/current_tracer", "nop"))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +struct tracefs_cpu_map_desc {
> +	struct trace_buffer_meta	*meta;
> +	int				cpu_fd;
> +};
> +
> +int tracefs_cpu_map(struct tracefs_cpu_map_desc *desc, int cpu)
> +{
> +	int page_size = getpagesize();
> +	char *cpu_path;
> +	void *map;
> +
> +	if (asprintf(&cpu_path,
> +		     TRACEFS_ROOT"/per_cpu/cpu%d/trace_pipe_raw",
> +		     cpu) < 0)
> +		return -ENOMEM;
> +
> +	desc->cpu_fd = open(cpu_path, O_RDONLY | O_NONBLOCK);
> +	free(cpu_path);
> +	if (desc->cpu_fd < 0)
> +		return -ENODEV;
> +
> +	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
> +	if (map == MAP_FAILED)
> +		return -errno;
> +
> +	desc->meta = (struct trace_buffer_meta *)map;
> +
> +	return 0;
> +}
> +
> +void tracefs_cpu_unmap(struct tracefs_cpu_map_desc *desc)
> +{
> +	munmap(desc->meta, desc->meta->meta_page_size);
> +	close(desc->cpu_fd);
> +}
> +
> +FIXTURE(map) {
> +	struct tracefs_cpu_map_desc	map_desc;
> +	bool				umount;
> +};
> +
> +FIXTURE_VARIANT(map) {
> +	int	subbuf_size;
> +};
> +
> +FIXTURE_VARIANT_ADD(map, subbuf_size_4k) {
> +	.subbuf_size = 4,
> +};
> +
> +FIXTURE_VARIANT_ADD(map, subbuf_size_8k) {
> +	.subbuf_size = 8,
> +};
> +
> +FIXTURE_SETUP(map)
> +{
> +	int cpu = sched_getcpu();
> +	cpu_set_t cpu_mask;
> +	bool fail, umount;
> +	char *message;
> +
> +	if (!tracefs_enabled(&message, &fail, &umount)) {
> +		if (fail) {
> +			TH_LOG("Tracefs setup failed: %s", message);
> +			ASSERT_FALSE(fail);
> +		}
> +		SKIP(return, "Skipping: %s", message);
> +	}
> +
> +	self->umount = umount;
> +
> +	ASSERT_GE(cpu, 0);
> +
> +	ASSERT_EQ(tracefs_reset(), 0);
> +
> +	tracefs_write_int(TRACEFS_ROOT"/buffer_subbuf_size_kb", variant->subbuf_size);
> +
> +	ASSERT_EQ(tracefs_cpu_map(&self->map_desc, cpu), 0);
> +
> +	/*
> +	 * Ensure generated events will be found on this very same ring-buffer.
> +	 */
> +	CPU_ZERO(&cpu_mask);
> +	CPU_SET(cpu, &cpu_mask);
> +	ASSERT_EQ(sched_setaffinity(0, sizeof(cpu_mask), &cpu_mask), 0);
> +}
> +
> +FIXTURE_TEARDOWN(map)
> +{
> +	tracefs_reset();
> +
> +	if (self->umount)
> +		tracefs_unmount();
> +
> +	tracefs_cpu_unmap(&self->map_desc);
> +}
> +
> +TEST_F(map, meta_page_check)
> +{
> +	struct tracefs_cpu_map_desc *desc = &self->map_desc;
> +	int cnt = 0;
> +
> +	ASSERT_EQ(desc->meta->entries, 0);
> +	ASSERT_EQ(desc->meta->overrun, 0);
> +	ASSERT_EQ(desc->meta->read, 0);
> +
> +	ASSERT_EQ(desc->meta->reader.id, 0);
> +	ASSERT_EQ(desc->meta->reader.read, 0);
> +
> +	ASSERT_EQ(ioctl(desc->cpu_fd, TRACE_MMAP_IOCTL_GET_READER), 0);
> +	ASSERT_EQ(desc->meta->reader.id, 0);
> +
> +	tracefs_write_int(TRACEFS_ROOT"/tracing_on", 1);
> +	for (int i = 0; i < 16; i++)
> +		tracefs_write_int(TRACEFS_ROOT"/trace_marker", i);
> +again:
> +	ASSERT_EQ(ioctl(desc->cpu_fd, TRACE_MMAP_IOCTL_GET_READER), 0);
> +
> +	ASSERT_EQ(desc->meta->entries, 16);
> +	ASSERT_EQ(desc->meta->overrun, 0);
> +	ASSERT_EQ(desc->meta->read, 16);
> +
> +	ASSERT_EQ(desc->meta->reader.id, 1);
> +
> +	if (!(cnt++))
> +		goto again;
> +}
> +
> +TEST_F(map, data_mmap)
> +{
> +	struct tracefs_cpu_map_desc *desc = &self->map_desc;
> +	unsigned long meta_len, data_len;
> +	void *data;
> +
> +	meta_len = desc->meta->meta_page_size;
> +	data_len = desc->meta->subbuf_size * desc->meta->nr_subbufs;
> +
> +	/* Map all the available subbufs */
> +	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
> +		    desc->cpu_fd, meta_len);
> +	ASSERT_NE(data, MAP_FAILED);
> +	munmap(data, data_len);
> +
> +	/* Map all the available subbufs - 1 */
> +	data_len -= desc->meta->subbuf_size;
> +	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
> +		    desc->cpu_fd, meta_len);
> +	ASSERT_NE(data, MAP_FAILED);
> +	munmap(data, data_len);
> +
> +	/* Overflow the available subbufs by 1 */
> +	meta_len += desc->meta->subbuf_size * 2;
> +	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
> +		    desc->cpu_fd, meta_len);
> +	ASSERT_EQ(data, MAP_FAILED);
> +
> +	/* Verify meta-page padding */
> +	if (desc->meta->meta_page_size > getpagesize()) {
> +		void *addr;
> +
> +		data_len = desc->meta->meta_page_size;
> +		data = mmap(NULL, data_len,
> +			    PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
> +		ASSERT_NE(data, MAP_FAILED);
> +
> +		addr = (void *)((unsigned long)data + getpagesize());
> +		ASSERT_EQ(*((int *)addr), 0);
> +		munmap(data, data_len);
> +	}
> +}
> +
> +FIXTURE(snapshot) {
> +	bool	umount;
> +};
> +
> +FIXTURE_SETUP(snapshot)
> +{
> +	bool fail, umount;
> +	struct stat sb;
> +	char *message;
> +
> +	if (stat(TRACEFS_ROOT"/snapshot", &sb))
> +		SKIP(return, "Skipping: %s", "snapshot not available");
> +
> +	if (!tracefs_enabled(&message, &fail, &umount)) {
> +		if (fail) {
> +			TH_LOG("Tracefs setup failed: %s", message);
> +			ASSERT_FALSE(fail);
> +		}
> +		SKIP(return, "Skipping: %s", message);
> +	}
> +
> +	self->umount = umount;
> +}
> +
> +FIXTURE_TEARDOWN(snapshot)
> +{
> +	__tracefs_write(TRACEFS_ROOT"/events/sched/sched_switch/trigger",
> +			"!snapshot");
> +	tracefs_reset();
> +
> +	if (self->umount)
> +		tracefs_unmount();
> +}
> +
> +TEST_F(snapshot, excludes_map)
> +{
> +	struct tracefs_cpu_map_desc map_desc;
> +	int cpu = sched_getcpu();
> +
> +	ASSERT_GE(cpu, 0);
> +	tracefs_write(TRACEFS_ROOT"/events/sched/sched_switch/trigger",
> +		      "snapshot");
> +	ASSERT_EQ(tracefs_cpu_map(&map_desc, cpu), -EBUSY);
> +}
> +
> +TEST_F(snapshot, excluded_by_map)
> +{
> +	struct tracefs_cpu_map_desc map_desc;
> +	int cpu = sched_getcpu();
> +
> +	ASSERT_EQ(tracefs_cpu_map(&map_desc, cpu), 0);
> +
> +	ASSERT_EQ(__tracefs_write(TRACEFS_ROOT"/events/sched/sched_switch/trigger",
> +				  "snapshot"), -EBUSY);
> +	ASSERT_EQ(__tracefs_write(TRACEFS_ROOT"/snapshot",
> +				  "1"), -EBUSY);
> +}
> +
> +TEST_HARNESS_MAIN

-- 
BR,
Muhammad Usama Anjum

