Return-Path: <linux-kselftest+bounces-12907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83D891B574
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 05:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2C3B21C05
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 03:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F501CA8A;
	Fri, 28 Jun 2024 03:29:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF371C6A4;
	Fri, 28 Jun 2024 03:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719545351; cv=none; b=JIaBNMnZt39NJE7M5YJlEhYDPO0V/miREM2sqOOai35VPHtupAZy2zxRS13LTezuofYL4wciyFBWC1dbDHMn1qIAwMBV74NEBiNlBqpLDCjJOisGv0HLgmJirabHXY7e/fvlboRQ/VSvuX+gDFo98DTxJvcmkOiyW3jIEdWA4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719545351; c=relaxed/simple;
	bh=JRku0fuRdBn/55x8f4gYTRRAiU8kk8ppkEP/hbX/ATE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=suLgc5g1Ivw5OUbuvA+SDj5VpSY1BEbKORNPJEo3rU7Qm4m34lod1oc11ZkgDEOmp7GTLj+Q18cDJYnNuy8xIi4597KBjFEM6unOmnROoQ/TvEFH9c1bo9xCeK+4w3rGDomSJ9/nDivaRkEE9sZk9O4AqW/fUX29GJ4z92vXaso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W9LQh0BxJzjZ1X;
	Fri, 28 Jun 2024 11:24:44 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id AB3D118006E;
	Fri, 28 Jun 2024 11:29:05 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Jun 2024 11:29:04 +0800
Subject: Re: [PATCH v6 3/4] selftest/mm: test enable_soft_offline behaviors
To: Jiaqi Yan <jiaqiyan@google.com>
CC: <jane.chu@oracle.com>, <rdunlap@infradead.org>, <ioworker0@gmail.com>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<corbet@lwn.net>, <osalvador@suse.de>, <rientjes@google.com>,
	<duenwen@google.com>, <fvdl@google.com>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>, Naoya
 Horiguchi <nao.horiguchi@gmail.com>
References: <20240626050818.2277273-1-jiaqiyan@google.com>
 <20240626050818.2277273-4-jiaqiyan@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0a28831c-b28e-6db5-0ef3-70940e75d4d2@huawei.com>
Date: Fri, 28 Jun 2024 11:29:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240626050818.2277273-4-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/6/26 13:08, Jiaqi Yan wrote:
> Add regression and new tests when hugepage has correctable memory
> errors, and how userspace wants to deal with it:
> * if enable_soft_offline=1, mapped hugepage is soft offlined
> * if enable_soft_offline=0, mapped hugepage is intact
> 
> Free hugepages case is not explicitly covered by the tests.
> 
> Hugepage having corrected memory errors is emulated with
> MADV_SOFT_OFFLINE.

Thanks for update.

> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  tools/testing/selftests/mm/.gitignore         |   1 +
>  tools/testing/selftests/mm/Makefile           |   1 +
>  .../selftests/mm/hugetlb-soft-offline.c       | 228 ++++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh     |   4 +
>  4 files changed, 234 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/hugetlb-soft-offline.c
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
> +	if (fd < 0)
> +		ksft_exit_fail_msg("Failed to create hugetlbfs file\n");
> +
> +	hugepagesize_kb = file_stat.f_bsize / 1024;
> +	ksft_print_msg("Hugepagesize is %ldkB\n", hugepagesize_kb);
> +
> +	if (set_enable_soft_offline(enable_soft_offline)) {

Nit: should this be written as if (set_enable_soft_offline(enable_soft_offline) != 0) to keep consistent with below code?

> +		close(fd);
> +		ksft_exit_fail_msg("Failed to set enable_soft_offline\n");
> +	}
> +
> +	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_before) != 0) {
> +		close(fd);
> +		ksft_exit_fail_msg("Failed to read nr_hugepages\n");
> +	}
> +
> +	ksft_print_msg("Before MADV_SOFT_OFFLINE nr_hugepages=%ld\n",
> +		       nr_hugepages_before);
> +
> +	ret = do_soft_offline(fd, 2 * file_stat.f_bsize, expect_errno);
> +
> +	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) != 0) {
> +		close(fd);
> +		ksft_exit_fail_msg("Failed to read nr_hugepages\n");
> +	}
> +
...
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 3157204b9047..781117fac1ba 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -331,6 +331,10 @@ CATEGORY="hugetlb" run_test ./thuge-gen
>  CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh -cgroup-v2
>  CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh -cgroup-v2
>  if $RUN_DESTRUCTIVE; then
> +nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
> +echo 8 > /proc/sys/vm/nr_hugepages
> +CATEGORY="hugetlb" run_test ./hugetlb-soft-offline
> +echo "$nr_hugepages_tmp" > /proc/sys/vm/nr_hugepages

Should we save and restore the value of /proc/sys/vm/enable_soft_offline too?

With above fixed, this patch looks good to me.
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

