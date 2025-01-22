Return-Path: <linux-kselftest+bounces-24908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D9FA18C10
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 07:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96720188384E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 06:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3A714F115;
	Wed, 22 Jan 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XKEHulR5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BDBF9FE;
	Wed, 22 Jan 2025 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527543; cv=none; b=QmfnfUUeWNQv8wzBPUBMOv9pPY8DPWOlC0LUSoI93QR5LJ4alrfomogP4d5XjMG1H+DqggRmbNthGGbDpG1vOI2Tbott3U4AnvMGPEuQLPfG6t2VIsJEYIyu3PjpoaxWHxgz8ty74a8pGu4+QQz35yO9nrskC61A7ANdPmpjae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527543; c=relaxed/simple;
	bh=MuHHKULVvu+jpV6iSLqJiQjYGJdlWYs0iJnZGdItftA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1W+E09imCIg9lcssCeOdD++z1n08YSAdMOGodUx/ZKxhzwur7A8AI4m9P8uPUv4sdatlEY7jzeDAB47JRAaUB97KrdhUISRpfeTokZgpBQ0wC7T9jTJ+VYQw2rr4R0FvpAJJ2PJihbmqNBNp48gT7qo657loWFbWTx2vc6TpHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XKEHulR5; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737527531; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Nh3Emg3EEMHyq0FczvMV27qF7dWzF6PzFwLWVJM/rnA=;
	b=XKEHulR5UjZoIIr6OxIncg/x+WzzCLYZO6zsl+3LWo4TTrYXG7OKr+/r3sRssMKCu/lVvqxoFEPm5pN7mTQ7ClvSJzV+NbUsAF7SR0CpEIChSRf6K/ZZhwkm1hjmMLS3csuTD+8ieKjGpkoXPGPkjxv/tqZxz6LA6lTJL+bgD6A=
Received: from 30.74.144.123(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WO7Z32P_1737527528 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Jan 2025 14:32:09 +0800
Message-ID: <d1a5f942-0c43-475d-854a-9e4a34d04556@linux.alibaba.com>
Date: Wed, 22 Jan 2025 14:32:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] selftests/mm: make file-backed THP split work by
 setting force option
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi
 <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250116211042.741543-1-ziy@nvidia.com>
 <20250116211042.741543-2-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250116211042.741543-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/17 05:10, Zi Yan wrote:
> Commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
> changes huge=always to allocate THP/mTHP based on write size and
> split_huge_page_test does not write PMD size data, so file-back THP is not
> created during the test.
> 
> Set /sys/kernel/mm/transparent_hugepage/shmem_enabled to "force" to force
> THP allocation.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   .../selftests/mm/split_huge_page_test.c       | 47 +++++++++++++++++--
>   1 file changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 3f353f3d070f..eccaa347140b 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -264,15 +264,46 @@ void split_pte_mapped_thp(void)
>   void split_file_backed_thp(void)
>   {
>   	int status;
> -	int fd;
> -	ssize_t num_written;
> +	int fd, shmem_sysctl_fd;
> +	ssize_t num_written, num_read;
>   	char tmpfs_template[] = "/tmp/thp_split_XXXXXX";
>   	const char *tmpfs_loc = mkdtemp(tmpfs_template);
> -	char testfile[INPUT_MAX];
> +	char testfile[INPUT_MAX], sysctl_buf[INPUT_MAX] = {0};
>   	uint64_t pgoff_start = 0, pgoff_end = 1024;
> +	const char *shmem_sysctl = "/sys/kernel/mm/transparent_hugepage/shmem_enabled";
> +	char *opt1, *opt2;
>   
>   	ksft_print_msg("Please enable pr_debug in split_huge_pages_in_file() for more info.\n");
>   
> +	shmem_sysctl_fd = open(shmem_sysctl, O_RDWR);
> +	if (shmem_sysctl_fd == -1) {
> +		ksft_perror("cannot open shmem sysctl");
> +		goto out;
> +	}
> +
> +	num_read = read(shmem_sysctl_fd, sysctl_buf, INPUT_MAX);
> +	if (num_read < 1) {
> +		ksft_perror("Failed to read shmem sysctl");

You should close() shmem_sysctl_fd before returning.

> +		goto out;
> +	}
> +
> +	opt1 = strchr(sysctl_buf, '[');
> +	opt2 = strchr(sysctl_buf, ']');
> +	if (!opt1 || !opt2) {

Ditto.

> +		ksft_perror("cannot read shmem sysctl config");
> +		goto out;
> +	}
> +
> +	/* get existing shmem sysctl config into sysctl_buf */
> +	strncpy(sysctl_buf, opt1 + 1, opt2 - opt1 - 1);
> +	memset(sysctl_buf + (opt2 - opt1 - 1), 0, INPUT_MAX);
> +
> +	num_written = write(shmem_sysctl_fd, "force", sizeof("force"));
> +	if (num_written < 1) {
> +		ksft_perror("Fail to write force to shmem sysctl");
> +		goto out;
> +	}
> +
>   	status = mount("tmpfs", tmpfs_loc, "tmpfs", 0, "huge=always,size=4m");
>   
>   	if (status)
> @@ -317,13 +348,21 @@ void split_file_backed_thp(void)
>   	if (status)
>   		ksft_exit_fail_msg("cannot remove tmp dir: %s\n", strerror(errno));
>   
> +	num_written = write(shmem_sysctl_fd, sysctl_buf, strlen(sysctl_buf) + 1);
> +	if (num_written < 1)
> +		ksft_perror("Fail to restore shmem sysctl");
> +
>   	ksft_print_msg("Please check dmesg for more information\n");
> -	ksft_test_result_pass("File-backed THP split test done\n");
> +	ksft_test_result_pass("File-backed THP split to order %d test done\n", order);

Seems the patch set split has issues. No 'order' variable in this patch.

Anyway, I've fixed these issues in my local tree, and it works well. If 
you fix them in the next version, please feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>


>   	return;
>   
>   cleanup:
> +	num_written = write(shmem_sysctl_fd, sysctl_buf, strlen(sysctl_buf) + 1);
> +	if (num_written < 1)
> +		ksft_perror("Fail to restore shmem sysctl");
>   	umount(tmpfs_loc);
>   	rmdir(tmpfs_loc);
> +out:
>   	ksft_exit_fail_msg("Error occurred\n");
>   }
>   

