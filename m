Return-Path: <linux-kselftest+bounces-7352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA70A89AD13
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 23:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D411F211A4
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 21:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237754AEF7;
	Sat,  6 Apr 2024 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TkXSICni"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C038389;
	Sat,  6 Apr 2024 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712439445; cv=none; b=rOOAqz1a9GmBKyrnApJPFEGTQ07+kMa2iKIlryGHDliDHWzKM793Y/21wrz+5BdVDIquR1w0PuhBLNKsajXYizJ2nz9zn5cz9ytw24c5miybeSzf5rqpkbzlqvYg3mSF8MAu9mnAccw81FCkYwkrwYKK6fPTGhv3Bcz51Mb34JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712439445; c=relaxed/simple;
	bh=EtEAijm9uw1TWIb7s9qNwCRb3mIKCqYyJPbwcSFUuAA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LNX2lHU7zQpVenbW5qSU4de5mSxEWWecX7ipc+NmtsxbYyEwE8HJfxFHGuaKvC949IMnP6qy2YkUCB94AbxpvjhWbAWuG3wzj0gwO7vILInAsHzZi9lo3HJelS8/NcjRYOXS74y7qeYgV89bzVCFogPYf//DxpCBasfy3bU+y1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TkXSICni; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712439441;
	bh=EtEAijm9uw1TWIb7s9qNwCRb3mIKCqYyJPbwcSFUuAA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=TkXSICniY6CWWM/OTWLRuNCDbbGcZsFf2LZBopnkGc1ZLw/nXCV7Us/RMrRyoGh2m
	 vyZw4qpT2hom2ufj1Ek9n3G6IQJvDdd1zxEYYpFTeYcT8/2ivwazjeh85KCXuXCJCH
	 M/m1EZyW4/ovbzoRj12A3vkQtTaBSRS9mKtK2E5SmqOb09ihQ6L4LIjY9564ej4+q2
	 QAkg2qPRPsbZqPs7daMA5cI38zsFBo4FrXFyAlre7biAjWtW9lCxveAj8XQt1c1pFx
	 50qb1bnom1P5OeMM4Sx+q88asJ9gy4bjXIgoi4KRLuGo2dXaERN9rPYyqwSL9kJPMA
	 CqVPmsSvKsN6Q==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 70F1E37809CE;
	Sat,  6 Apr 2024 21:37:13 +0000 (UTC)
Message-ID: <a45c2ece-acb4-4cff-9d53-f5c007c9b905@collabora.com>
Date: Sun, 7 Apr 2024 02:37:44 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH v3 6/9] selftests: cgroup: Add basic tests for pids
 controller
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240405170548.15234-1-mkoutny@suse.com>
 <20240405170548.15234-7-mkoutny@suse.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240405170548.15234-7-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/5/24 10:05 PM, Michal Koutný wrote:
> This commit adds (and wires in) new test program for checking basic pids
> controller functionality -- restricting tasks in a cgroup and correct
> event counting.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  tools/testing/selftests/cgroup/Makefile    |   2 +
>  tools/testing/selftests/cgroup/test_pids.c | 187 +++++++++++++++++++++
Please create/add test_pid to .gitignore file.

>  2 files changed, 189 insertions(+)
>  create mode 100644 tools/testing/selftests/cgroup/test_pids.c
> 
> diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
> index f3e1ef69e88d..f5f0886a2c4a 100644
> --- a/tools/testing/selftests/cgroup/Makefile
> +++ b/tools/testing/selftests/cgroup/Makefile
> @@ -15,6 +15,7 @@ TEST_GEN_PROGS += test_hugetlb_memcg
>  TEST_GEN_PROGS += test_kill
>  TEST_GEN_PROGS += test_kmem
>  TEST_GEN_PROGS += test_memcontrol
> +TEST_GEN_PROGS += test_pids
>  TEST_GEN_PROGS += test_zswap
>  
>  LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
> @@ -29,4 +30,5 @@ $(OUTPUT)/test_hugetlb_memcg: cgroup_util.c
>  $(OUTPUT)/test_kill: cgroup_util.c
>  $(OUTPUT)/test_kmem: cgroup_util.c
>  $(OUTPUT)/test_memcontrol: cgroup_util.c
> +$(OUTPUT)/test_pids: cgroup_util.c
>  $(OUTPUT)/test_zswap: cgroup_util.c
> diff --git a/tools/testing/selftests/cgroup/test_pids.c b/tools/testing/selftests/cgroup/test_pids.c
> new file mode 100644
> index 000000000000..c1c3a3965624
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/test_pids.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <linux/limits.h>
> +#include <signal.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#include "../kselftest.h"
> +#include "cgroup_util.h"
> +
> +static int run_success(const char *cgroup, void *arg)
> +{
> +	return 0;
> +}
> +
> +static int run_pause(const char *cgroup, void *arg)
> +{
> +	return pause();
> +}
> +
> +/*
> + * This test checks that pids.max prevents forking new children above the
> + * specified limit in the cgroup.
> + */
> +static int test_pids_max(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	char *cg_pids;
> +	int pid;
> +
> +
Please remove extra line.

> +	cg_pids = cg_name(root, "pids_test");
> +	if (!cg_pids)
> +		goto cleanup;
> +
> +	if (cg_create(cg_pids))
> +		goto cleanup;
> +
> +	if (cg_read_strcmp(cg_pids, "pids.max", "max\n"))
> +		goto cleanup;
> +
> +	if (cg_write(cg_pids, "pids.max", "2"))
> +		goto cleanup;
> +
> +	if (cg_enter_current(cg_pids))
> +		goto cleanup;
> +
> +	pid = cg_run_nowait(cg_pids, run_pause, NULL);
> +	if (pid < 0)
> +		goto cleanup;
> +
> +	if (cg_run_nowait(cg_pids, run_success, NULL) != -1 || errno != EAGAIN)
> +		goto cleanup;
> +
> +	if (kill(pid, SIGINT))
> +		goto cleanup;
> +
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	cg_enter_current(root);
> +	cg_destroy(cg_pids);
> +	free(cg_pids);
> +
> +	return ret;
> +}
> +
> +/*
> + * This test checks that pids.max prevents forking new children above the
> + * specified limit in the cgroup.
> + */
> +static int test_pids_events(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	char *cg_parent = NULL, *cg_child = NULL;
> +	int pid;
> +
> +
> +	cg_parent = cg_name(root, "pids_parent");
> +	cg_child = cg_name(cg_parent, "pids_child");
> +	if (!cg_parent || !cg_child)
> +		goto cleanup;
> +
> +	if (cg_create(cg_parent))
> +		goto cleanup;
> +	if (cg_write(cg_parent, "cgroup.subtree_control", "+pids"))
> +		goto cleanup;
> +	if (cg_create(cg_child))
> +		goto cleanup;
> +
> +	if (cg_write(cg_parent, "pids.max", "2"))
> +		goto cleanup;
> +
> +	if (cg_read_strcmp(cg_child, "pids.max", "max\n"))
> +		goto cleanup;
> +
> +	if (cg_enter_current(cg_child))
> +		goto cleanup;
> +
> +	pid = cg_run_nowait(cg_child, run_pause, NULL);
> +	if (pid < 0)
> +		goto cleanup;
> +
> +	if (cg_run_nowait(cg_child, run_success, NULL) != -1 || errno != EAGAIN)
> +		goto cleanup;
> +
> +	if (kill(pid, SIGINT))
> +		goto cleanup;
> +
> +
Remove extra line.

> +	if (cg_read_key_long(cg_child, "pids.events", "max ") != 0)
> +		goto cleanup;
> +	if (cg_read_key_long(cg_child, "pids.events", "max.imposed ") != 1)
> +		goto cleanup;
> +
> +	if (cg_read_key_long(cg_parent, "pids.events", "max ") != 1)
> +		goto cleanup;
> +	if (cg_read_key_long(cg_parent, "pids.events", "max.imposed ") != 1)
> +		goto cleanup;
> +
> +
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	cg_enter_current(root);
> +	if (cg_child)
> +		cg_destroy(cg_child);
> +	if (cg_parent)
> +		cg_destroy(cg_parent);
> +	free(cg_child);
> +	free(cg_parent);
> +
> +	return ret;
> +}
> +
> +
> +
> +#define T(x) { x, #x }
> +struct pids_test {
> +	int (*fn)(const char *root);
> +	const char *name;
> +} tests[] = {
> +	T(test_pids_max),
> +	T(test_pids_events),
> +};
> +#undef T
> +
> +int main(int argc, char **argv)
> +{
> +	char root[PATH_MAX];
> +	int i, ret = EXIT_SUCCESS;
The
	ksft_print_header();
	ksft_set_plan(total_number_of_tests);
are missing. Please use all of the ksft APIs to make the test TAP compliant.

> +
> +	if (cg_find_unified_root(root, sizeof(root)))
> +		ksft_exit_skip("cgroup v2 isn't mounted\n");
> +
> +	/*
> +	 * Check that pids controller is available:
> +	 * pids is listed in cgroup.controllers
> +	 */
> +	if (cg_read_strstr(root, "cgroup.controllers", "pids"))
> +		ksft_exit_skip("pids controller isn't available\n");
> +
> +	if (cg_read_strstr(root, "cgroup.subtree_control", "pids"))
> +		if (cg_write(root, "cgroup.subtree_control", "+pids"))
> +			ksft_exit_skip("Failed to set pids controller\n");
> +
> +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> +		switch (tests[i].fn(root)) {
> +		case KSFT_PASS:
> +			ksft_test_result_pass("%s\n", tests[i].name);
> +			break;
> +		case KSFT_SKIP:
> +			ksft_test_result_skip("%s\n", tests[i].name);
> +			break;
> +		default:
> +			ret = EXIT_FAILURE;
> +			ksft_test_result_fail("%s\n", tests[i].name);
> +			break;
Use ksft_test_result_report() instead of swith-case here.

> +		}
> +	}
> +
> +	return ret;
> +}

-- 
BR,
Muhammad Usama Anjum

