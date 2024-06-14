Return-Path: <linux-kselftest+bounces-11916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 121519082AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 05:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4EF1F24D95
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 03:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD532146A6C;
	Fri, 14 Jun 2024 03:50:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD73D64;
	Fri, 14 Jun 2024 03:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718337044; cv=none; b=OaArcNq2v90pierOCl+unQI5gUmEQROTLSAoy/GzxgrZ9nxD47vO7hZVt2Xm4IHaK+rdbmH5UGDWhyfvQIDElkWki7CgNuxMshOn2T/DKJ+igHjMmtZc8syt2p+28OQr0ZPwOuJcoJs3TxFj4jFjEYKStl8FALX/w2FTuj778f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718337044; c=relaxed/simple;
	bh=a4G2K9dnn4BkfGzzojRfXscBjwl/kloUIHJHaL037VU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JcJ/04uY4J91MnVgpyT2q1XvUmrZdk/hP1dqajiPnViCshgj9XCoXnF2YLuRxBd3hVjdndLVr3XRDeMnjYwXtvWxOlDotY7xNovyVUQSvd61J8B5IV7Zg2NJjPjxmLnDC/GDbPuZ9y5kyOjErPZAkUBq4wI5fRhs2RwI7CRQk/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W0lZG4wZvzwQ3H;
	Fri, 14 Jun 2024 11:46:30 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id C189418007C;
	Fri, 14 Jun 2024 11:50:38 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 11:50:38 +0800
Subject: Re: [PATCH v2 2/3] selftest/mm: test enable_soft_offline behaviors
To: Jiaqi Yan <jiaqiyan@google.com>
CC: <muchun.song@linux.dev>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<corbet@lwn.net>, <osalvador@suse.de>, <rientjes@google.com>,
	<duenwen@google.com>, <fvdl@google.com>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nao.horiguchi@gmail.com>, <jane.chu@oracle.com>
References: <20240611215544.2105970-1-jiaqiyan@google.com>
 <20240611215544.2105970-3-jiaqiyan@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5c97ee26-754f-c94c-6888-952b45b43558@huawei.com>
Date: Fri, 14 Jun 2024 11:50:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240611215544.2105970-3-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/6/12 5:55, Jiaqi Yan wrote:
> Add regression and new tests when hugepage has correctable memory
> errors, and how userspace wants to deal with it:
> * if enable_soft_offline=0, mapped hugepage is soft offlined
> * if enable_soft_offline=1, mapped hugepage is intact

This shoule be something like below ?
 if enable_soft_offline=0, mapped hugepage is intact
 if enable_soft_offline=1, mapped hugepage is soft offlined

> 
> Free hugepages case is not explicitly covered by the tests.
> 
> Hugepage having corrected memory errors is emulated with
> MADV_SOFT_OFFLINE.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  tools/testing/selftests/mm/.gitignore         |   1 +
>  tools/testing/selftests/mm/Makefile           |   1 +
>  .../selftests/mm/hugetlb-soft-offline.c       | 258 ++++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh     |   4 +
>  4 files changed, 264 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/hugetlb-soft-offline.c
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 0b9ab987601c..064e7b125643 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -6,6 +6,7 @@ hugepage-shm
>  hugepage-vmemmap
>  hugetlb-madvise
>  hugetlb-read-hwpoison
> +hugetlb-soft-offline
>  khugepaged
>  map_hugetlb
>  map_populate
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 3b49bc3d0a3b..d166067d75ef 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -42,6 +42,7 @@ TEST_GEN_FILES += gup_test
>  TEST_GEN_FILES += hmm-tests
>  TEST_GEN_FILES += hugetlb-madvise
>  TEST_GEN_FILES += hugetlb-read-hwpoison
> +TEST_GEN_FILES += hugetlb-soft-offline
>  TEST_GEN_FILES += hugepage-mmap
>  TEST_GEN_FILES += hugepage-mremap
>  TEST_GEN_FILES += hugepage-shm
> diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> new file mode 100644
> index 000000000000..d37d68a433e7
> --- /dev/null
> +++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test soft offline behavior for HugeTLB pages:
> + * - if enable_soft_offline = 0, hugepages should stay intact and soft
> + *   offlining failed with EINVAL.
> + * - if enable_soft_offline = 1, a hugepage should be dissolved and
> + *   nr_hugepages/free_hugepages should be reduced by 1.
> + *
> + * Before running, make sure more than 2 hugepages of default_hugepagesz
> + * are allocated. For example, if /proc/meminfo/Hugepagesize is 2048kB:
> + *   echo 8 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include <linux/magic.h>
> +#include <linux/memfd.h>
> +#include <sys/mman.h>
> +#include <sys/statfs.h>
> +#include <sys/types.h>
> +
> +#ifndef MADV_SOFT_OFFLINE
> +#define MADV_SOFT_OFFLINE 101
> +#endif
> +
> +#define PREFIX " ... "
> +#define EPREFIX " !!! "
> +
> +enum test_status {
> +	TEST_PASS = 0,
> +	TEST_FAILED = 1,
> +	// From ${ksft_skip} in run_vmtests.sh.
> +	TEST_SKIPPED = 4,
> +};
> +
> +static enum test_status do_soft_offline(int fd, size_t len, int expect_ret)
> +{
> +	char *filemap = NULL;
> +	char *hwp_addr = NULL;
> +	const unsigned long pagesize = getpagesize();
> +	int ret = 0;
> +	enum test_status status = TEST_SKIPPED;
> +
> +	if (ftruncate(fd, len) < 0) {
> +		perror(EPREFIX "ftruncate to len failed");
> +		return status;
> +	}
> +
> +	filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
> +		       MAP_SHARED | MAP_POPULATE, fd, 0);
> +	if (filemap == MAP_FAILED) {
> +		perror(EPREFIX "mmap failed");
> +		goto untruncate;
> +	}
> +
> +	memset(filemap, 0xab, len);
> +	printf(PREFIX "Allocated %#lx bytes of hugetlb pages\n", len);
> +
> +	hwp_addr = filemap + len / 2;
> +	ret = madvise(hwp_addr, pagesize, MADV_SOFT_OFFLINE);
> +	printf(PREFIX "MADV_SOFT_OFFLINE %p ret=%d, errno=%d\n",
> +	       hwp_addr, ret, errno);
> +	if (ret != 0)
> +		perror(EPREFIX "madvise failed");
> +
> +	if (errno == expect_ret)
> +		status = TEST_PASS;
> +	else {
> +		printf(EPREFIX "MADV_SOFT_OFFLINE should ret %d\n", expect_ret);
> +		status = TEST_FAILED;
> +	}
> +
> +	munmap(filemap, len);
> +untruncate:
> +	if (ftruncate(fd, 0) < 0)
> +		perror(EPREFIX "ftruncate back to 0 failed");
> +
> +	return status;
> +}
> +
> +static int set_enable_soft_offline(int value)
> +{
> +	char cmd[256] = {0};
> +	FILE *cmdfile = NULL;
> +
> +	if (value != 0 && value != 1)
> +		return -EINVAL;
> +
> +	sprintf(cmd, "echo %d > /proc/sys/vm/enable_soft_offline", value);
> +	cmdfile = popen(cmd, "r");
> +
> +	if (cmdfile == NULL)
> +		perror(EPREFIX "failed to set enable_soft_offline");

If fails to set enable_soft_offline, should we return errno here?

> +	else
> +		printf(PREFIX "enable_soft_offline => %d\n", value);
> +
> +	pclose(cmdfile);
> +	return 0;
> +}
> +
> +static int read_nr_hugepages(unsigned long hugepage_size,
> +			     unsigned long *nr_hugepages)
> +{
> +	char buffer[256] = {0};
> +	char cmd[256] = {0};
> +
> +	sprintf(cmd, "cat /sys/kernel/mm/hugepages/hugepages-%ldkB/nr_hugepages",
> +		hugepage_size);
> +	FILE *cmdfile = popen(cmd, "r");

Check cmdfile against NULL?

> +
> +	if (!fgets(buffer, sizeof(buffer), cmdfile)) {
> +		perror(EPREFIX "failed to read nr_hugepages");
> +		pclose(cmdfile);
> +		return -1;
> +	}
> +
> +	*nr_hugepages = atoll(buffer);
> +	pclose(cmdfile);
> +	return 0;
> +}
> +
> +static int create_hugetlbfs_file(struct statfs *file_stat)
> +{
> +	int fd;
> +
> +	fd = memfd_create("hugetlb_tmp", MFD_HUGETLB);
> +	if (fd < 0) {
> +		perror(EPREFIX "could not open hugetlbfs file");
> +		return -1;
> +	}
> +
> +	memset(file_stat, 0, sizeof(*file_stat));
> +	if (fstatfs(fd, file_stat)) {
> +		perror(EPREFIX "fstatfs failed");
> +		goto close;
> +	}
> +	if (file_stat->f_type != HUGETLBFS_MAGIC) {
> +		printf(EPREFIX "not hugetlbfs file\n");
> +		goto close;
> +	}
> +
> +	return fd;
> +close:
> +	close(fd);
> +	return -1;
> +}
> +
> +static enum test_status test_soft_offline(void)
> +{
> +	int fd;
> +	struct statfs file_stat;
> +	unsigned long hugepagesize_kb = 0;
> +	unsigned long nr_hugepages_before = 0;
> +	unsigned long nr_hugepages_after = 0;
> +	enum test_status status = TEST_SKIPPED;
> +
> +	printf("Test Soft Offline When softoffline_corrected_errors=1\n");
> +
> +	fd = create_hugetlbfs_file(&file_stat);
> +	if (fd < 0) {
> +		printf(EPREFIX "Failed to create hugetlbfs file\n");
> +		return status;
> +	}
> +
> +	hugepagesize_kb = file_stat.f_bsize / 1024;
> +	printf(PREFIX "Hugepagesize is %ldkB\n", hugepagesize_kb);
> +
> +	if (set_enable_soft_offline(1))
> +		return TEST_FAILED;
> +
> +	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_before) != 0)
> +		return TEST_FAILED;
> +
> +	printf(PREFIX "Before MADV_SOFT_OFFLINE nr_hugepages=%ld\n",
> +		nr_hugepages_before);
> +
> +	status = do_soft_offline(fd, 2 * file_stat.f_bsize, /*expect_ret=*/0);
> +
> +	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) != 0)
> +		return TEST_FAILED;
> +
> +	printf(PREFIX "After MADV_SOFT_OFFLINE nr_hugepages=%ld\n",
> +		nr_hugepages_after);
> +
> +	if (nr_hugepages_before != nr_hugepages_after + 1) {
> +		printf(EPREFIX "MADV_SOFT_OFFLINE should reduced 1 hugepage\n");
> +		return TEST_FAILED;
> +	}
> +
> +	return status;
> +}
> +
> +static enum test_status test_disable_soft_offline(void)
> +{
> +	int fd;
> +	struct statfs file_stat;
> +	unsigned long hugepagesize_kb = 0;
> +	unsigned long nr_hugepages_before = 0;
> +	unsigned long nr_hugepages_after = 0;
> +	enum test_status status = TEST_SKIPPED;
> +
> +	printf("Test Soft Offline When softoffline_corrected_errors=0\n");
> +
> +	fd = create_hugetlbfs_file(&file_stat);
> +	if (fd < 0) {
> +		printf(EPREFIX "Failed to create hugetlbfs file\n");
> +		return status;
> +	}
> +
> +	hugepagesize_kb = file_stat.f_bsize / 1024;
> +	printf(PREFIX "Hugepagesize is %ldkB\n", hugepagesize_kb);
> +
> +	if (set_enable_soft_offline(0))
> +		return TEST_FAILED;
> +
> +	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_before) != 0)
> +		return TEST_FAILED;
> +
> +	printf(PREFIX "Before MADV_SOFT_OFFLINE nr_hugepages=%ld\n",
> +		nr_hugepages_before);
> +
> +	status = do_soft_offline(fd, 2 * file_stat.f_bsize, /*expect_ret=*/EINVAL);
> +
> +	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) != 0)
> +		return TEST_FAILED;
> +
> +	printf(PREFIX "After MADV_SOFT_OFFLINE nr_hugepages=%ld\n",
> +		nr_hugepages_after);
> +
> +	if (nr_hugepages_before != nr_hugepages_after) {
> +		printf(EPREFIX "MADV_SOFT_OFFLINE reduced %lu hugepages\n",
> +			nr_hugepages_before - nr_hugepages_after);
> +		return TEST_FAILED;
> +	}
> +
> +	return status;
> +}

test_disable_soft_offline is almost same with test_soft_offline. Shall we extract the common pattern?

Thanks.
.



