Return-Path: <linux-kselftest+bounces-12619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A934915F50
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 09:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7651C210E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 07:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63901465A4;
	Tue, 25 Jun 2024 07:05:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6C2802;
	Tue, 25 Jun 2024 07:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299156; cv=none; b=l5kphOoE/XR/49QereYtCjWhwr3pWyUNbbisq2qip4pBhzoJUANb1vr909FUWUao05xZif/XmZBNeiyjFf4iplJFA5P/NO9Mbvnt1bw6bXdP+cqHLvJf19GiCFYYXDLLhhoc5RCraxsjhXs797vAuBB1KZcEwieBaFR6l2euODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299156; c=relaxed/simple;
	bh=eaMXFyYaZklXT+kuzNqeJ4XKpw8Q7P27GVG8U9ob3dA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nAcS0fXjKrRHSUSnEmYCp4h1ws1mG+eG3yIwa+jM6qkB/vfRScvOOVVd1ZH8ZeKEPK71R2pNrbUcypVyX/7hau/Cytk6KZsQls76yiXhUfWCP/cdN/duep3hp6GRkPRAxvOZI8fvTEl9nxa7ze8Mp67YfdWvWJ6zf66NEmdKM/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W7bT60ChMznXYr;
	Tue, 25 Jun 2024 15:05:46 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 73B731402DE;
	Tue, 25 Jun 2024 15:05:50 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Jun 2024 15:05:49 +0800
Subject: Re: [PATCH v5 3/4] selftest/mm: test enable_soft_offline behaviors
To: Jiaqi Yan <jiaqiyan@google.com>
CC: <muchun.song@linux.dev>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<corbet@lwn.net>, <osalvador@suse.de>, <rientjes@google.com>,
	<duenwen@google.com>, <fvdl@google.com>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nao.horiguchi@gmail.com>, <jane.chu@oracle.com>, <ioworker0@gmail.com>
References: <20240624163348.1751454-1-jiaqiyan@google.com>
 <20240624163348.1751454-4-jiaqiyan@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <609062d2-977c-4229-8c66-d15bb8e47eb8@huawei.com>
Date: Tue, 25 Jun 2024 15:05:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240624163348.1751454-4-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/6/25 0:33, Jiaqi Yan wrote:
> Add regression and new tests when hugepage has correctable memory
...
> diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> new file mode 100644
> index 000000000000..16fe52f972e2
> --- /dev/null
> +++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test soft offline behavior for HugeTLB pages:
> + * - if enable_soft_offline = 0, hugepages should stay intact and soft
> + *   offlining failed with EINVAL.

s/failed with EINVAL/failed with EOPNOTSUPP/g

> + * - if enable_soft_offline = 1, a hugepage should be dissolved and
> + *   nr_hugepages/free_hugepages should be reduced by 1.
> + *
> + * Before running, make sure more than 2 hugepages of default_hugepagesz
> + * are allocated. For example, if /proc/meminfo/Hugepagesize is 2048kB:
> + *   echo 8 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> + */
> +
...
> +static void test_soft_offline_common(int enable_soft_offline)
> +{
> +	int fd;
> +	int expect_errno = enable_soft_offline ? 0 : EOPNOTSUPP;
> +	struct statfs file_stat;
> +	unsigned long hugepagesize_kb = 0;
> +	unsigned long nr_hugepages_before = 0;
> +	unsigned long nr_hugepages_after = 0;
> +	int ret;
> +
> +	ksft_print_msg("Test soft-offline when enabled_soft_offline=%d\n",
> +		       enable_soft_offline);
> +
> +	fd = create_hugetlbfs_file(&file_stat);
> +	if (fd < 0) {
> +		ksft_exit_fail_msg("Failed to create hugetlbfs file\n");
> +		return;
> +	}
> +
> +	hugepagesize_kb = file_stat.f_bsize / 1024;
> +	ksft_print_msg("Hugepagesize is %ldkB\n", hugepagesize_kb);
> +
> +	if (set_enable_soft_offline(enable_soft_offline)) {
> +		ksft_exit_fail_msg("Failed to set enable_soft_offline\n");

Call destroy_hugetlbfs_file() in error path?

> +		return;
> +	}
> +
> +	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_before) != 0) {
> +		ksft_exit_fail_msg("Failed to read nr_hugepages\n");
> +		return;
> +	}
> +
> +	ksft_print_msg("Before MADV_SOFT_OFFLINE nr_hugepages=%ld\n",
> +		       nr_hugepages_before);
> +
> +	ret = do_soft_offline(fd, 2 * file_stat.f_bsize, expect_errno);
> +
> +	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) != 0) {
> +		ksft_exit_fail_msg("Failed to read nr_hugepages\n");
> +		return;
> +	}
> +
> +	ksft_print_msg("After MADV_SOFT_OFFLINE nr_hugepages=%ld\n",
> +		nr_hugepages_after);
> +
> +	if (enable_soft_offline) {
> +		if (nr_hugepages_before != nr_hugepages_after + 1) {
> +			ksft_test_result_fail("MADV_SOFT_OFFLINE should reduced 1 hugepage\n");
> +			return;
> +		}
> +	} else {
> +		if (nr_hugepages_before != nr_hugepages_after) {
> +			ksft_test_result_fail("MADV_SOFT_OFFLINE reduced %lu hugepages\n",
> +				nr_hugepages_before - nr_hugepages_after);
> +			return;
> +		}
> +	}
> +
> +	ksft_test_result(ret == 0,
> +			 "Test soft-offline when enabled_soft_offline=%d\n",
> +			 enable_soft_offline);

Call destroy_hugetlbfs_file() when test finished ?

Thanks.
.



