Return-Path: <linux-kselftest+bounces-6894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FA6892469
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB45284F28
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 19:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAC2139CE7;
	Fri, 29 Mar 2024 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n7z5twiI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE8E1E529;
	Fri, 29 Mar 2024 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741382; cv=none; b=X+fgX4MavXA24Oc2o1vvWWbW4OvDfp+C5qjQ0sKj000SQrLm57IfHn/L9q5PrAZ//ZMy0jXvMZsR1tvgEc4lDowAVsoWwg+EPHJnxiabU7i2yzsa9I0yxtORLoMEm9BPC9KmI/1k40dGhKwoN8MxOS/yFl6TJt4C8g9+B5A0fno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741382; c=relaxed/simple;
	bh=80xtOevugz6QWOrvG2hJVhtRvl7HXBsF0obq3zGA5Ns=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dfgdhbltml/OBZvFrT5nZDnYkf13kMPuDRlf2rR4SmDVeQKbSgieKORPJv9RJWiltC0ziWr39qbZXBll86tjJ6Dkmby3V8ovtLpvC7yt8uYqbKsPGAtBNBghEq5A9pL5M3+HPlsEAz7YxfP0ytxz+gDWZiVSMel/4p23l6IWg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n7z5twiI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711741377;
	bh=80xtOevugz6QWOrvG2hJVhtRvl7HXBsF0obq3zGA5Ns=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=n7z5twiIe1daBip1hOJr1mSl7C47SSbGLlsOc28ILMWSs272LtgdF68IQPncU38n8
	 2QhBwafpZ3ArUm5rcINRw1qIk6FBT8YYQ4qIxO9l2IIj8ALEYL7SAevl/JqVUw6aMK
	 dqY8f+Hy4ly+2WwBj4qlAEMtF7ktByyzhz5ZlzbH3kMiIbaay7cXqEjywPCHlc/30j
	 whPZ0S7QIgw2pznMgTOv4hUaCORevyvf3patp2jQ3rrV9wyHju2sDUG82R6RBdGHXk
	 fjm7lOjBWCQGJK26IQScFUqtsDNbSLD5Vt2DPDJdW1s+WCmvqJlrFSQirpfbwE5/1E
	 jGMhrI2G3Memw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 500303781FCE;
	Fri, 29 Mar 2024 19:42:46 +0000 (UTC)
Message-ID: <e85f049f-8b49-4656-adfd-f91b7706f4d6@collabora.com>
Date: Sat, 30 Mar 2024 00:43:17 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Yosry Ahmed <yosryahmed@google.com>, Matthew Wilcox <willy@infradead.org>,
 Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
 Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Abel Wu <wuyun.abel@bytedance.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v3 8/8] mm: test system-wide workingset reporting
To: Yuanchu Xie <yuanchu@google.com>, David Hildenbrand <david@redhat.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>,
 Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>
References: <20240327213108.2384666-1-yuanchu@google.com>
 <20240327213108.2384666-9-yuanchu@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240327213108.2384666-9-yuanchu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Please add selftest tag in the subject in selftest patches.

On 3/28/24 2:31 AM, Yuanchu Xie wrote:
> A basic test that verifies the working set size of a simple memory
> accessor. It should work with or without the aging thread.
> 
> Question: I don't know how to best test file memory in selftests. Is
> there a place where I should put the temporary file? /tmp can be tmpfs
> mounted in many distros.
> 
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
Thanks for writing most of the test in TAP compliant format. Only replace
printing directly to strerr to ksft_exit_fail_msg() instead.

> ---
>  tools/testing/selftests/mm/.gitignore         |   1 +
>  tools/testing/selftests/mm/Makefile           |   3 +
>  .../testing/selftests/mm/workingset_report.c  | 315 +++++++++++++++++
>  .../testing/selftests/mm/workingset_report.h  |  37 ++
>  .../selftests/mm/workingset_report_test.c     | 328 ++++++++++++++++++
>  5 files changed, 684 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/workingset_report.c
>  create mode 100644 tools/testing/selftests/mm/workingset_report.h
>  create mode 100644 tools/testing/selftests/mm/workingset_report_test.c
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 4ff10ea61461..14a2412c8257 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -46,3 +46,4 @@ gup_longterm
>  mkdirty
>  va_high_addr_switch
>  hugetlb_fault_after_madv
> +workingset_report_test
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 2453add65d12..c0869bf07e99 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -70,6 +70,7 @@ TEST_GEN_FILES += ksm_tests
>  TEST_GEN_FILES += ksm_functional_tests
>  TEST_GEN_FILES += mdwe_test
>  TEST_GEN_FILES += hugetlb_fault_after_madv
> +TEST_GEN_FILES += workingset_report_test
>  
>  ifneq ($(ARCH),arm64)
>  TEST_GEN_FILES += soft-dirty
> @@ -123,6 +124,8 @@ $(TEST_GEN_FILES): vm_util.c thp_settings.c
>  $(OUTPUT)/uffd-stress: uffd-common.c
>  $(OUTPUT)/uffd-unit-tests: uffd-common.c
>  
> +$(OUTPUT)/workingset_report_test: workingset_report.c
> +
>  ifeq ($(ARCH),x86_64)
>  BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
>  BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
> diff --git a/tools/testing/selftests/mm/workingset_report.c b/tools/testing/selftests/mm/workingset_report.c
> new file mode 100644
> index 000000000000..93387f0f30ee
> --- /dev/null
> +++ b/tools/testing/selftests/mm/workingset_report.c
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "workingset_report.h"
> +
> +#include <stddef.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <stdbool.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +
> +#define SYSFS_NODE_ONLINE "/sys/devices/system/node/online"
> +#define PROC_DROP_CACHES "/proc/sys/vm/drop_caches"
> +
> +/* Returns read len on success, or -errno on failure. */
> +static ssize_t read_text(const char *path, char *buf, size_t max_len)
> +{
> +	ssize_t len;
> +	int fd, err;
> +	size_t bytes_read = 0;
> +
> +	if (!max_len)
> +		return -EINVAL;
> +
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		return -errno;
> +
> +	while (bytes_read < max_len - 1) {
> +		len = read(fd, buf + bytes_read, max_len - 1 - bytes_read);
> +
> +		if (len <= 0)
> +			break;
> +		bytes_read += len;
> +	}
> +
> +	buf[bytes_read] = '\0';
> +
> +	err = -errno;
> +	close(fd);
> +	return len < 0 ? err : bytes_read;
> +}
> +
> +/* Returns written len on success, or -errno on failure. */
> +static ssize_t write_text(const char *path, const char *buf, ssize_t max_len)
> +{
> +	int fd, len, err;
> +	size_t bytes_written = 0;
> +
> +	fd = open(path, O_WRONLY | O_APPEND);
> +	if (fd < 0)
> +		return -errno;
> +
> +	while (bytes_written < max_len) {
> +		len = write(fd, buf + bytes_written, max_len - bytes_written);
> +
> +		if (len < 0)
> +			break;
> +		bytes_written += len;
> +	}
> +
> +	err = -errno;
> +	close(fd);
> +	return len < 0 ? err : bytes_written;
> +}
> +
> +static long read_num(const char *path)
> +{
> +	char buf[21];
> +
> +	if (read_text(path, buf, sizeof(buf)) <= 0)
> +		return -1;
> +	return (long)strtoul(buf, NULL, 10);
> +}
> +
> +static int write_num(const char *path, unsigned long n)
> +{
> +	char buf[21];
> +
> +	sprintf(buf, "%lu", n);
> +	if (write_text(path, buf, strlen(buf)) < 0)
> +		return -1;
> +	return 0;
> +}
> +
> +long sysfs_get_refresh_interval(int nid)
> +{
> +	char file[128];
> +
> +	snprintf(
> +		file,
> +		sizeof(file),
> +		"/sys/devices/system/node/node%d/workingset_report/refresh_interval",
> +		nid);
> +	return read_num(file);
> +}
> +
> +int sysfs_set_refresh_interval(int nid, long interval)
> +{
> +	char file[128];
> +
> +	snprintf(
> +		file,
> +		sizeof(file),
> +		"/sys/devices/system/node/node%d/workingset_report/refresh_interval",
> +		nid);
> +	return write_num(file, interval);
> +}
> +
> +int sysfs_get_page_age_intervals_str(int nid, char *buf, int len)
> +{
> +	char path[128];
> +
> +	snprintf(
> +		path,
> +		sizeof(path),
> +		"/sys/devices/system/node/node%d/workingset_report/page_age_intervals",
> +		nid);
> +	return read_text(path, buf, len);
> +
> +}
> +
> +int sysfs_set_page_age_intervals_str(int nid, const char *buf, int len)
> +{
> +	char path[128];
> +
> +	snprintf(
> +		path,
> +		sizeof(path),
> +		"/sys/devices/system/node/node%d/workingset_report/page_age_intervals",
> +		nid);
> +	return write_text(path, buf, len);
> +}
> +
> +int sysfs_set_page_age_intervals(int nid, const char *intervals[],
> +				 int nr_intervals)
> +{
> +	char file[128];
> +	char buf[1024];
> +	int i;
> +	int err, len = 0;
> +
> +	for (i = 0; i < nr_intervals; ++i) {
> +		err = snprintf(buf + len, sizeof(buf) - len, "%s", intervals[i]);
> +
> +		if (err < 0)
> +			return err;
> +		len += err;
> +
> +		if (i < nr_intervals - 1) {
> +			err = snprintf(buf + len, sizeof(buf) - len, ",");
> +			if (err < 0)
> +				return err;
> +			len += err;
> +		}
> +	}
> +
> +	snprintf(
> +		file,
> +		sizeof(file),
> +		"/sys/devices/system/node/node%d/workingset_report/page_age_intervals",
> +		nid);
> +	return write_text(file, buf, len);
> +}
> +
> +int get_nr_nodes(void)
> +{
> +	char buf[22];
> +	char *found;
> +
> +	if (read_text(SYSFS_NODE_ONLINE, buf, sizeof(buf)) <= 0)
> +		return -1;
> +	found = strstr(buf, "-");
> +	if (found)
> +		return (int)strtoul(found + 1, NULL, 10) + 1;
> +	return (long)strtoul(buf, NULL, 10) + 1;
> +}
> +
> +int drop_pagecache(void)
> +{
> +	return write_num(PROC_DROP_CACHES, 1);
> +}
> +
> +ssize_t sysfs_page_age_read(int nid, char *buf, size_t len)
> +
> +{
> +	char file[128];
> +
> +	snprintf(file,
> +		sizeof(file),
> +		 "/sys/devices/system/node/node%d/workingset_report/page_age",
> +		 nid);
> +	return read_text(file, buf, len);
> +}
> +
> +/*
> + * Finds the first occurrence of "N<nid>\n"
> + * Modifies buf to terminate before the next occurrence of "N".
> + * Returns a substring of buf starting after "N<nid>\n"
> + */
> +char *page_age_split_node(char *buf, int nid, char **next)
> +{
> +	char node_str[5];
> +	char *found;
> +	int node_str_len;
> +
> +	node_str_len = snprintf(node_str, sizeof(node_str), "N%u\n", nid);
> +
> +	/* find the node prefix first */
> +	found = strstr(buf, node_str);
> +	if (!found) {
> +		fprintf(stderr, "cannot find '%s' in page_idle_age", node_str);
> +		return NULL;
> +	}
> +	found += node_str_len;
> +
> +	*next = strchr(found, 'N');
> +	if (*next)
> +		*(*next - 1) = '\0';
> +
> +	return found;
> +}
> +
> +ssize_t page_age_read(const char *buf, const char *interval, int pagetype)
> +{
> +	static const char * const type[ANON_AND_FILE] = { "anon=", "file=" };
> +	char *found;
> +
> +	found = strstr(buf, interval);
> +	if (!found) {
> +		fprintf(stderr, "cannot find %s in page_age", interval);
> +		return -1;
> +	}
> +	found = strstr(found, type[pagetype]);
> +	if (!found) {
> +		fprintf(stderr, "cannot find %s in page_age", type[pagetype]);
> +		return -1;
> +	}
> +	found += strlen(type[pagetype]);
> +	return (long)strtoul(found, NULL, 10);
> +}
> +
> +static const char *TEMP_FILE = "/tmp/workingset_selftest";
> +void cleanup_file_workingset(void)
> +{
> +	remove(TEMP_FILE);
> +}
> +
> +int alloc_file_workingset(void *arg)
> +{
> +	int err = 0;
> +	char *ptr;
> +	int fd;
> +	int ppid;
> +	char *mapped;
> +	size_t size = (size_t)arg;
> +	size_t page_size = getpagesize();
> +
> +	ppid = getppid();
> +
> +	fd = open(TEMP_FILE, O_RDWR | O_CREAT);
> +	if (fd < 0) {
> +		err = -errno;
> +		perror("failed to open temp file\n");
> +		goto cleanup;
> +	}
> +
> +	if (fallocate(fd, 0, 0, size) < 0) {
> +		err = -errno;
> +		perror("fallocate");
> +		goto cleanup;
> +	}
> +
> +	mapped = (char *)mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED,
> +			      fd, 0);
> +	if (mapped == NULL) {
> +		err = -errno;
> +		perror("mmap");
> +		goto cleanup;
> +	}
> +
> +	while (getppid() == ppid) {
> +		sync();
> +		for (ptr = mapped; ptr < mapped + size; ptr += page_size)
> +			*ptr = *ptr ^ 0xFF;
> +	}
> +
> +cleanup:
> +	cleanup_file_workingset();
> +	return err;
> +}
> +
> +int alloc_anon_workingset(void *arg)
> +{
> +	char *buf, *ptr;
> +	int ppid = getppid();
> +	size_t size = (size_t)arg;
> +	size_t page_size = getpagesize();
> +
> +	buf = malloc(size);
> +
> +	if (!buf) {
> +		fprintf(stderr, "cannot allocate anon workingset");
> +		exit(1);
> +	}
> +
> +	while (getppid() == ppid) {
> +		for (ptr = buf; ptr < buf + size; ptr += page_size)
> +			*ptr = *ptr ^ 0xFF;
> +	}
> +
> +	free(buf);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/mm/workingset_report.h b/tools/testing/selftests/mm/workingset_report.h
> new file mode 100644
> index 000000000000..f72a931298e0
> --- /dev/null
> +++ b/tools/testing/selftests/mm/workingset_report.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef WORKINGSET_REPORT_H_
> +#define WORKINGSET_REPORT_H_
> +
> +#define _GNU_SOURCE
> +
> +#include <fcntl.h>
> +#include <sys/stat.h>
> +#include <errno.h>
> +#include <stdint.h>
> +#include <sys/types.h>
> +
> +#define PAGETYPE_ANON 0
> +#define PAGETYPE_FILE 1
> +#define ANON_AND_FILE 2
> +
> +int get_nr_nodes(void);
> +int drop_pagecache(void);
> +
> +long sysfs_get_refresh_interval(int nid);
> +int sysfs_set_refresh_interval(int nid, long interval);
> +
> +int sysfs_get_page_age_intervals_str(int nid, char *buf, int len);
> +int sysfs_set_page_age_intervals_str(int nid, const char *buf, int len);
> +
> +int sysfs_set_page_age_intervals(int nid, const char *intervals[],
> +				 int nr_intervals);
> +
> +char *page_age_split_node(char *buf, int nid, char **next);
> +ssize_t sysfs_page_age_read(int nid, char *buf, size_t len);
> +ssize_t page_age_read(const char *buf, const char *interval, int pagetype);
> +
> +int alloc_file_workingset(void *arg);
> +void cleanup_file_workingset(void);
> +int alloc_anon_workingset(void *arg);
> +
> +#endif /* WORKINGSET_REPORT_H_ */
> diff --git a/tools/testing/selftests/mm/workingset_report_test.c b/tools/testing/selftests/mm/workingset_report_test.c
> new file mode 100644
> index 000000000000..e6e857d8fe35
> --- /dev/null
> +++ b/tools/testing/selftests/mm/workingset_report_test.c
> @@ -0,0 +1,328 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "workingset_report.h"
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <signal.h>
> +#include <time.h>
> +
> +#include "../clone3/clone3_selftests.h"
> +
> +#define REFRESH_INTERVAL 5000
> +#define MB(x) (x << 20)
> +
> +static void sleep_ms(int milliseconds)
> +{
> +	struct timespec ts;
> +
> +	ts.tv_sec = milliseconds / 1000;
> +	ts.tv_nsec = (milliseconds % 1000) * 1000000;
> +	nanosleep(&ts, NULL);
> +}
> +
> +/*
> + * Checks if two given values differ by less than err% of their sum.
> + */
> +static inline int values_close(long a, long b, int err)
> +{
> +	return abs(a - b) <= (a + b) / 100 * err;
> +}
> +
> +static const char * const PAGE_AGE_INTERVALS[] = {
> +	"6000", "10000", "15000", "18446744073709551615",
> +};
> +#define NR_PAGE_AGE_INTERVALS (ARRAY_SIZE(PAGE_AGE_INTERVALS))
> +/* add one for the catch all last interval */
> +
> +static int set_page_age_intervals_all_nodes(const char *intervals, int nr_nodes)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_nodes; ++i) {
> +		int err = sysfs_set_page_age_intervals_str(
> +			i, &intervals[i * 1024], strlen(&intervals[i * 1024]));
> +
> +		if (err < 0)
> +			return err;
> +	}
> +	return 0;
> +}
> +
> +static int get_page_age_intervals_all_nodes(char *intervals, int nr_nodes)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_nodes; ++i) {
> +		int err = sysfs_get_page_age_intervals_str(
> +			i, &intervals[i * 1024], 1024);
> +
> +		if (err < 0)
> +			return err;
> +	}
> +	return 0;
> +}
> +
> +static int set_refresh_interval_all_nodes(const long *interval, int nr_nodes)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_nodes; ++i) {
> +		int err = sysfs_set_refresh_interval(i, interval[i]);
> +
> +		if (err < 0)
> +			return err;
> +	}
> +	return 0;
> +}
> +
> +static int get_refresh_interval_all_nodes(long *interval, int nr_nodes)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_nodes; ++i) {
> +		long val = sysfs_get_refresh_interval(i);
> +
> +		if (val < 0)
> +			return val;
> +		interval[i] = val;
> +	}
> +	return 0;
> +}
> +
> +static pid_t clone_and_run(int fn(void *arg), void *arg)
> +{
> +	pid_t pid;
> +
> +	struct __clone_args args = {
> +		.exit_signal = SIGCHLD,
> +	};
> +
> +	pid = sys_clone3(&args, sizeof(struct __clone_args));
> +
> +	if (pid == 0)
> +		exit(fn(arg));
> +
> +	return pid;
> +}
> +
> +static int read_workingset(int pagetype, int nid,
> +			   unsigned long page_age[NR_PAGE_AGE_INTERVALS])
> +{
> +	int i, err;
> +	char buf[4096];
> +
> +	err = sysfs_page_age_read(nid, buf, sizeof(buf));
> +	if (err < 0)
> +		return err;
> +
> +	for (i = 0; i < NR_PAGE_AGE_INTERVALS; ++i) {
> +		err = page_age_read(buf, PAGE_AGE_INTERVALS[i], pagetype);
> +		if (err < 0)
> +			return err;
> +		page_age[i] = err;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t read_interval_all_nodes(int pagetype, int interval)
> +{
> +	int i, err;
> +	unsigned long page_age[NR_PAGE_AGE_INTERVALS];
> +	ssize_t ret = 0;
> +	int nr_nodes = get_nr_nodes();
> +
> +	for (i = 0; i < nr_nodes; ++i) {
> +		err = read_workingset(pagetype, i, page_age);
> +		if (err < 0)
> +			return err;
> +
> +		ret += page_age[interval];
> +	}
> +
> +	return ret;
> +}
> +
> +#define TEST_SIZE MB(500l)
> +
> +static int run_test(int f(void))
> +{
> +	int i, err, test_result;
> +	long *old_refresh_intervals;
> +	long *new_refresh_intervals;
> +	char *old_page_age_intervals;
> +	int nr_nodes = get_nr_nodes();
> +
> +	if (nr_nodes <= 0) {
> +		fprintf(stderr, "failed to get nr_nodes\n");
> +		return KSFT_FAIL;
> +	}
> +
> +	old_refresh_intervals = calloc(nr_nodes, sizeof(long));
> +	new_refresh_intervals = calloc(nr_nodes, sizeof(long));
> +	old_page_age_intervals = calloc(nr_nodes, 1024);
> +
> +	if (!(old_refresh_intervals && new_refresh_intervals &&
> +	      old_page_age_intervals)) {
> +		fprintf(stderr, "failed to allocate memory for intervals\n");
> +		return KSFT_FAIL;
> +	}
> +
> +	err = get_refresh_interval_all_nodes(old_refresh_intervals, nr_nodes);
> +	if (err < 0) {
> +		fprintf(stderr, "failed to read refresh interval\n");
> +		return KSFT_FAIL;
> +	}
> +
> +	err = get_page_age_intervals_all_nodes(old_page_age_intervals, nr_nodes);
> +	if (err < 0) {
> +		fprintf(stderr, "failed to read page age interval\n");
> +		return KSFT_FAIL;
> +	}
> +
> +	for (i = 0; i < nr_nodes; ++i)
> +		new_refresh_intervals[i] = REFRESH_INTERVAL;
> +	err = set_refresh_interval_all_nodes(new_refresh_intervals, nr_nodes);
> +	if (err < 0) {
> +		fprintf(stderr, "failed to set refresh interval\n");
> +		test_result = KSFT_FAIL;
> +		goto fail;
> +	}
> +
> +	for (i = 0; i < nr_nodes; ++i) {
> +		err = sysfs_set_page_age_intervals(i, PAGE_AGE_INTERVALS,
> +						   NR_PAGE_AGE_INTERVALS - 1);
> +		if (err < 0) {
> +			fprintf(stderr, "failed to set page age interval\n");
> +			test_result = KSFT_FAIL;
> +			goto fail;
> +		}
> +	}
> +
> +	sync();
> +	drop_pagecache();
> +
> +	test_result = f();
> +
> +fail:
> +	err = set_refresh_interval_all_nodes(old_refresh_intervals, nr_nodes);
> +	if (err < 0) {
> +		fprintf(stderr, "failed to restore refresh interval\n");
> +		test_result = KSFT_FAIL;
> +	}
> +	err = set_page_age_intervals_all_nodes(old_page_age_intervals, nr_nodes);
> +	if (err < 0) {
> +		fprintf(stderr, "failed to restore page age interval\n");
> +		test_result = KSFT_FAIL;
> +	}
> +	return test_result;
> +}
> +
> +static int test_file(void)
> +{
> +	ssize_t ws_size_ref, ws_size_test;
> +	int ret = KSFT_FAIL, i;
> +	pid_t pid = 0;
> +
> +	ws_size_ref = read_interval_all_nodes(PAGETYPE_FILE, 0);
> +	if (ws_size_ref < 0)
> +		goto cleanup;
> +
> +	pid = clone_and_run(alloc_file_workingset, (void *)TEST_SIZE);
> +	if (pid < 0)
> +		goto cleanup;
> +
> +	read_interval_all_nodes(PAGETYPE_FILE, 0);
> +	sleep_ms(REFRESH_INTERVAL);
> +
> +	for (i = 0; i < 3; ++i) {
> +		sleep_ms(REFRESH_INTERVAL);
> +		ws_size_test = read_interval_all_nodes(PAGETYPE_FILE, 0);
> +
> +		if (!values_close(ws_size_test - ws_size_ref, TEST_SIZE, 10)) {
> +			fprintf(stderr,
> +				"file working set size difference too large: actual=%ld, expected=%ld\n",
> +				ws_size_test - ws_size_ref, TEST_SIZE);
> +			goto cleanup;
> +		}
> +	}
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	if (pid > 0)
> +		kill(pid, SIGKILL);
> +	cleanup_file_workingset();
> +	return ret;
> +}
> +
> +static int test_anon(void)
> +{
> +	ssize_t ws_size_ref, ws_size_test;
> +	pid_t pid = 0;
> +	int ret = KSFT_FAIL, i;
> +
> +	ws_size_ref = read_interval_all_nodes(PAGETYPE_ANON, 0);
> +	if (ws_size_ref < 0)
> +		goto cleanup;
> +
> +	pid = clone_and_run(alloc_anon_workingset, (void *)TEST_SIZE);
> +	if (pid < 0)
> +		goto cleanup;
> +
> +	sleep_ms(REFRESH_INTERVAL);
> +	read_interval_all_nodes(PAGETYPE_ANON, 0);
> +
> +	for (i = 0; i < 5; ++i) {
> +		sleep_ms(REFRESH_INTERVAL);
> +		ws_size_test = read_interval_all_nodes(PAGETYPE_ANON, 0);
> +		if (ws_size_test < 0)
> +			goto cleanup;
> +
> +		if (!values_close(ws_size_test - ws_size_ref, TEST_SIZE, 10)) {
> +			fprintf(stderr,
> +				"anon working set size difference too large: actual=%ld, expected=%ld\n",
> +				ws_size_test - ws_size_ref, TEST_SIZE);
> +			/* goto cleanup; */
> +		}
> +	}
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	if (pid > 0)
> +		kill(pid, SIGKILL);
> +	return ret;
> +}
> +
> +
> +#define T(x) { x, #x }
> +struct workingset_test {
> +	int (*fn)(void);
> +	const char *name;
> +} tests[] = {
> +	T(test_anon),
> +	T(test_file),
> +};
> +#undef T
> +
> +int main(int argc, char **argv)
> +{
> +	int ret = EXIT_SUCCESS, i, err;
> +
> +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> +		err = run_test(tests[i].fn);
> +		switch (err) {
> +		case KSFT_PASS:
> +			ksft_test_result_pass("%s\n", tests[i].name);
> +			break;
> +		case KSFT_SKIP:
> +			ksft_test_result_skip("%s\n", tests[i].name);
> +			break;
> +		default:
> +			ret = EXIT_FAILURE;
> +			ksft_test_result_fail("%s with error %d\n",
> +					      tests[i].name, err);
> +			break;
> +		}
> +	}
> +	return ret;
> +}

-- 
BR,
Muhammad Usama Anjum

