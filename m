Return-Path: <linux-kselftest+bounces-24909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0607A18C47
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 07:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D4A163ED4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 06:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2891BC099;
	Wed, 22 Jan 2025 06:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sPkwIaxR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CC11B0F1E;
	Wed, 22 Jan 2025 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737528437; cv=none; b=IJ4fJv15EcVaCRymU6+2o8Gi0fFAOV6xgwvXbAxgwzCa7mt2Efjha6KSMPySY2SahoU0mB+YgvT1pHhjPgzfw/KtBqMT/MMavV7J/mDUrMOrQ/ZQooMrpHCuk1ZC9EgzhpXrZM3Ly1xprDZFU27UyP6Obe66kkag4jukyhymyFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737528437; c=relaxed/simple;
	bh=hFUXKiiQ1x1vkuqDJpsOVL2cZoyb+yhyKKlxXRN0Xgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVxEEO8bcvVYEUkbfYByMp8JuuZnaNETcmVaL837qMEhYPGZ223Ej2C/mPkkdsBdhA5uVyjcG3eGziREiG1fPxF2/3IuSP90/s7xKNcdaNWx0P21deubQAUXnYHL6Aky2nGEyIPyqSqOJ5BCkBWmXOLLypQBt95+4625Yx0wsE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sPkwIaxR; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737528427; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Yj/kRrfdeQuFUnIqHOTSK2NEbqA0lq2zs119rYyDO1k=;
	b=sPkwIaxRgHVFTUue0xXg19BtWA8p3faUM3rIOpTsiLP/sDGThUosIY/L9c/+gpDJ+ZwvHI8MIBnteJXC5glYUqOa/iNQUYtdK2HngzTpyKKCJG+0uFyFiMj6TahiHWg7QJwLW0WQp76QB8jDVUeq5j/kdzMztKky50fXE93PcHs=
Received: from 30.74.144.123(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WO7Ulvn_1737528425 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Jan 2025 14:47:05 +0800
Message-ID: <b556f0c9-9190-4834-8586-02a71337ee9d@linux.alibaba.com>
Date: Wed, 22 Jan 2025 14:47:05 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] selftests/mm: test splitting file-backed THP to
 any lower order.
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
 <20250116211042.741543-4-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250116211042.741543-4-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/17 05:10, Zi Yan wrote:
> Now split_huge_page*() supports shmem THP split to any lower order.
> Test it.
> 
> The test now reads file content out after split to check if the split
> corrupts the file data.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   .../selftests/mm/split_huge_page_test.c       | 30 ++++++++++++++-----
>   1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index eccaa347140b..766c1f3a1d78 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -261,14 +261,16 @@ void split_pte_mapped_thp(void)
>   	close(kpageflags_fd);
>   }
>   
> -void split_file_backed_thp(void)
> +void split_file_backed_thp(int order)
>   {
>   	int status;
>   	int fd, shmem_sysctl_fd;
>   	ssize_t num_written, num_read;
>   	char tmpfs_template[] = "/tmp/thp_split_XXXXXX";
>   	const char *tmpfs_loc = mkdtemp(tmpfs_template);
> -	char testfile[INPUT_MAX], sysctl_buf[INPUT_MAX] = {0};
> +	char testfile[INPUT_MAX];
> +	char sysctl_buf[INPUT_MAX] = {0};
> +	char file_buf[INPUT_MAX] = {0};
>   	uint64_t pgoff_start = 0, pgoff_end = 1024;
>   	const char *shmem_sysctl = "/sys/kernel/mm/transparent_hugepage/shmem_enabled";
>   	char *opt1, *opt2;
> @@ -314,7 +316,7 @@ void split_file_backed_thp(void)
>   		ksft_exit_fail_msg("Fail to create file-backed THP split testing file\n");
>   	}
>   
> -	fd = open(testfile, O_CREAT|O_WRONLY, 0664);
> +	fd = open(testfile, O_CREAT|O_RDWR, 0664);
>   	if (fd == -1) {
>   		ksft_perror("Cannot open testing file");
>   		goto cleanup;
> @@ -322,7 +324,6 @@ void split_file_backed_thp(void)
>   
>   	/* write something to the file, so a file-backed THP can be allocated */
>   	num_written = write(fd, tmpfs_loc, strlen(tmpfs_loc) + 1);
> -	close(fd);
>   
>   	if (num_written < 1) {
>   		ksft_perror("Fail to write data to testing file");
> @@ -330,8 +331,22 @@ void split_file_backed_thp(void)
>   	}
>   
>   	/* split the file-backed THP */
> -	write_debugfs(PATH_FMT, testfile, pgoff_start, pgoff_end, 0);
> +	write_debugfs(PATH_FMT, testfile, pgoff_start, pgoff_end, order);
> +
> +	/* check file content after split */
> +	num_read = lseek(fd, 0, SEEK_SET);
> +	if (num_read == -1) {
> +		ksft_perror("Cannot lseek file");
> +		goto cleanup;
> +	}
>   
> +	num_read = read(fd, file_buf, num_written);
> +	if (num_read < 1 || strncmp(file_buf, tmpfs_loc, num_read)) {
> +		ksft_print_msg("File content changed, origin: %s, now: %s\n", tmpfs_loc, file_buf);
> +		goto cleanup;
> +	}
> +
> +	close(fd);
>   	status = unlink(testfile);
>   	if (status) {
>   		ksft_perror("Cannot remove testing file");
> @@ -520,7 +535,7 @@ int main(int argc, char **argv)
>   	if (argc > 1)
>   		optional_xfs_path = argv[1];
>   
> -	ksft_set_plan(1+8+2+9);
> +	ksft_set_plan(1+8+1+9+9);
>   
>   	pagesize = getpagesize();
>   	pageshift = ffs(pagesize) - 1;
> @@ -537,7 +552,8 @@ int main(int argc, char **argv)
>   			split_pmd_thp_to_order(i);
>   
>   	split_pte_mapped_thp();
> -	split_file_backed_thp();
> +	for (i = 0; i < 9; i++)
> +		split_file_backed_thp(i);
>   
>   	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
>   			&fs_loc);

