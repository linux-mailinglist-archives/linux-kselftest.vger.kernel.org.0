Return-Path: <linux-kselftest+bounces-2943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAA682CCD4
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 14:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56211F221C6
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE2721103;
	Sat, 13 Jan 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTaV2lm3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918621340;
	Sat, 13 Jan 2024 13:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D21C433F1;
	Sat, 13 Jan 2024 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705153190;
	bh=30UFseJtYbMgi4KrTjNXLIsc4Cc9xJPODHdnxx2gh5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XTaV2lm3LjFhAt0Ms15Stx6/GnWmCr7ucgwy+FwbIvaxdLEnwk3UocGwtmNKx89+a
	 oADt0PKz7O7XRP/aDMAveYlOrSeRavFBGs4oYvxY2MQoPt50cHgRcaLvEAsq6q+KRP
	 ZPvgNGqliehp24+L9tZ/DS8EsJCIPc5IIaFviDzdQSyy9gWZAkBqi+ysarE71QjFpc
	 ++mJVpSN2l4ZYuk0BeM30jK3imXb0M8WiPfi4auZrlZbD4xYlPQsDOo9kWRr2n+zvQ
	 zG6Ftmvl5q+brLLCTRX+JSewmU+4xoXY3tWGVYrCLZvWLu6RYkkvgvggkbwNHQepCd
	 OCjXblZsWrCFg==
Date: Sat, 13 Jan 2024 22:39:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, Shuah Khan <shuah@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 5/5] ring-buffer/selftest: Add ring-buffer mapping
 test
Message-Id: <20240113223946.9c463c5a4787dc0261789e65@kernel.org>
In-Reply-To: <20240111161712.1480333-6-vdonnefort@google.com>
References: <20240111161712.1480333-1-vdonnefort@google.com>
	<20240111161712.1480333-6-vdonnefort@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jan 2024 16:17:12 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> This test maps a ring-buffer and validate the meta-page after reset and
> after emitting few events.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Looks good to me and tested.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

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
> diff --git a/tools/testing/selftests/ring-buffer/config b/tools/testing/selftests/ring-buffer/config
> new file mode 100644
> index 000000000000..ef8214661612
> --- /dev/null
> +++ b/tools/testing/selftests/ring-buffer/config
> @@ -0,0 +1 @@
> +CONFIG_FTRACE=y
> diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
> new file mode 100644
> index 000000000000..49107e8da5e9
> --- /dev/null
> +++ b/tools/testing/selftests/ring-buffer/map_test.c
> @@ -0,0 +1,188 @@
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
> +	FILE *file;
> +
> +	file = fopen(path, "w");
> +	if (!file)
> +		return -1;
> +
> +	fputs(value, file);
> +	fclose(file);
> +
> +	return 0;
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
> +static int tracefs_reset(void)
> +{
> +	if (__tracefs_write_int(TRACEFS_ROOT"/tracing_on", 0))
> +		return -1;
> +	if (__tracefs_write_int(TRACEFS_ROOT"/trace", 0))
> +		return -1;
> +	if (__tracefs_write(TRACEFS_ROOT"/set_event", ""))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +FIXTURE(map) {
> +	struct trace_buffer_meta	*meta;
> +	void				*data;
> +	int				cpu_fd;
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
> +	int cpu = sched_getcpu(), page_size = getpagesize();
> +	unsigned long meta_len, data_len;
> +	char *cpu_path, *message;
> +	bool fail, umount;
> +	cpu_set_t cpu_mask;
> +	void *map;
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
> +	ASSERT_GE(asprintf(&cpu_path,
> +			   TRACEFS_ROOT"/per_cpu/cpu%d/trace_pipe_raw",
> +			   cpu), 0);
> +
> +	self->cpu_fd = open(cpu_path, O_RDONLY | O_NONBLOCK);
> +	ASSERT_GE(self->cpu_fd, 0);
> +	free(cpu_path);
> +
> +	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, self->cpu_fd, 0);
> +	ASSERT_NE(map, MAP_FAILED);
> +	self->meta = (struct trace_buffer_meta *)map;
> +
> +	meta_len = self->meta->meta_page_size;
> +	data_len = self->meta->subbuf_size * self->meta->nr_subbufs;
> +
> +	map = mmap(NULL, data_len, PROT_READ, MAP_SHARED, self->cpu_fd, meta_len);
> +	ASSERT_NE(map, MAP_FAILED);
> +	self->data = map;
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
> +	munmap(self->data, self->meta->subbuf_size * self->meta->nr_subbufs);
> +	munmap(self->meta, self->meta->meta_page_size);
> +	close(self->cpu_fd);
> +}
> +
> +TEST_F(map, meta_page_check)
> +{
> +	int cnt = 0;
> +
> +	ASSERT_EQ(self->meta->entries, 0);
> +	ASSERT_EQ(self->meta->overrun, 0);
> +	ASSERT_EQ(self->meta->read, 0);
> +	ASSERT_EQ(self->meta->subbufs_touched, 0);
> +	ASSERT_EQ(self->meta->subbufs_lost, 0);
> +	ASSERT_EQ(self->meta->subbufs_read, 0);
> +
> +	ASSERT_EQ(self->meta->reader.id, 0);
> +	ASSERT_EQ(self->meta->reader.read, 0);
> +
> +	ASSERT_EQ(ioctl(self->cpu_fd, TRACE_MMAP_IOCTL_GET_READER), 0);
> +	ASSERT_EQ(self->meta->reader.id, 0);
> +
> +	tracefs_write_int(TRACEFS_ROOT"/tracing_on", 1);
> +	for (int i = 0; i < 16; i++)
> +		tracefs_write_int(TRACEFS_ROOT"/trace_marker", i);
> +again:
> +	ASSERT_EQ(ioctl(self->cpu_fd, TRACE_MMAP_IOCTL_GET_READER), 0);
> +
> +	ASSERT_EQ(self->meta->entries, 16);
> +	ASSERT_EQ(self->meta->overrun, 0);
> +	ASSERT_EQ(self->meta->read, 16);
> +	/* subbufs_touched doesn't take into account the commit page */
> +	ASSERT_EQ(self->meta->subbufs_touched, 0);
> +	ASSERT_EQ(self->meta->subbufs_lost, 0);
> +	ASSERT_EQ(self->meta->subbufs_read, 1);
> +
> +	ASSERT_EQ(self->meta->reader.id, 1);
> +
> +	if (!(cnt++))
> +		goto again;
> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.43.0.275.g3460e3d667-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

