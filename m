Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5969393B48
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 May 2021 04:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhE1CIS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 May 2021 22:08:18 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2382 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhE1CIS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 May 2021 22:08:18 -0400
Received: from dggeml709-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Frnyb5bgcz66QC;
        Fri, 28 May 2021 10:03:03 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggeml709-chm.china.huawei.com (10.3.17.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 10:06:42 +0800
Received: from [10.174.177.231] (10.174.177.231) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 10:06:41 +0800
Subject: Re: [PATCH -next] khugepaged: selftests: remove debug_cow
To:     <shuah@kernel.org>, <sfr@canb.auug.org.au>,
        <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <kirill.shutemov@linux.intel.com>,
        <yang.shi@linux.alibaba.com>, <wangkefeng.wang@huawei.com>,
        <linux-kselftest@vger.kernel.org>
References: <20210430051117.400189-1-sunnanyong@huawei.com>
From:   "Sunnanyong (Nanyong Sun, Intelligent Computing Solution Development
        Dep)" <sunnanyong@huawei.com>
Message-ID: <30666493-ad8a-67a3-9ee4-310466bcff7e@huawei.com>
Date:   Fri, 28 May 2021 10:06:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210430051117.400189-1-sunnanyong@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.231]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2021/4/30 13:11, Nanyong Sun wrote:

> The debug_cow attribute had been removed since commit 4958e4d86ecb01
> ("mm: thp: remove debug_cow switch"), so remove it in selftest code too,
> otherwise the khugepaged test will fail.
>
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>   tools/testing/selftests/vm/khugepaged.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
> index 8b7582130..155120b67 100644
> --- a/tools/testing/selftests/vm/khugepaged.c
> +++ b/tools/testing/selftests/vm/khugepaged.c
> @@ -86,7 +86,6 @@ struct settings {
>   	enum thp_enabled thp_enabled;
>   	enum thp_defrag thp_defrag;
>   	enum shmem_enabled shmem_enabled;
> -	bool debug_cow;
>   	bool use_zero_page;
>   	struct khugepaged_settings khugepaged;
>   };
> @@ -95,7 +94,6 @@ static struct settings default_settings = {
>   	.thp_enabled = THP_MADVISE,
>   	.thp_defrag = THP_DEFRAG_ALWAYS,
>   	.shmem_enabled = SHMEM_NEVER,
> -	.debug_cow = 0,
>   	.use_zero_page = 0,
>   	.khugepaged = {
>   		.defrag = 1,
> @@ -268,7 +266,6 @@ static void write_settings(struct settings *settings)
>   	write_string("defrag", thp_defrag_strings[settings->thp_defrag]);
>   	write_string("shmem_enabled",
>   			shmem_enabled_strings[settings->shmem_enabled]);
> -	write_num("debug_cow", settings->debug_cow);
>   	write_num("use_zero_page", settings->use_zero_page);
>   
>   	write_num("khugepaged/defrag", khugepaged->defrag);
> @@ -304,7 +301,6 @@ static void save_settings(void)
>   		.thp_defrag = read_string("defrag", thp_defrag_strings),
>   		.shmem_enabled =
>   			read_string("shmem_enabled", shmem_enabled_strings),
> -		.debug_cow = read_num("debug_cow"),
>   		.use_zero_page = read_num("use_zero_page"),
>   	};
>   	saved_settings.khugepaged = (struct khugepaged_settings) {

This patch has not been responded for a long time.

Could someone please help to deal with it ?

