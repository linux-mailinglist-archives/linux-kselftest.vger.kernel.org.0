Return-Path: <linux-kselftest+bounces-6902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D54892523
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 21:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E722A1C20CCE
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762E013AA54;
	Fri, 29 Mar 2024 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N22rtauF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F291DDEA;
	Fri, 29 Mar 2024 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711743586; cv=none; b=qnXEe1EYigl/K65We6SvcODXKCB+IpBocFIYyAS6qKIQOdYnSNPI4EDUExcju3TrsLQVOTxPy6VVGNu/AMK41YUnWuWfSK3J4VIHZKSPkHC/A3xpjkT8TlV15oD7OVbVH9stU10/4j5Ldaw+LG1bYZCsAEbiKdFUc6YK/bUjLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711743586; c=relaxed/simple;
	bh=LxBnhveT9wJc5Gb452ltbRcCzBPRzEznzVbAaylCB0E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eEnnbZUbfwnbTLA0M3xwe3LeK91G1tMIC8oTD9hUVw6DPyVZVDtH36Q2M5FZEH/q2la/kLSc6JE+pyR0SaQmFBEhduFFqPUnmNJwGDdFkV38PPSM84vKhA2yJKGLtXfKsEfCKTNTfKey+WXIcuqZ6o6xoBZd5Wxb+AMn2hSYoao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N22rtauF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711743583;
	bh=LxBnhveT9wJc5Gb452ltbRcCzBPRzEznzVbAaylCB0E=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=N22rtauFy6Yed3RlP3fQ/dTIfwik75IoPKQjcVgRbkiFg7QiykyVwd2zm32mOkipp
	 Esb9Yh2EfNtA2yQbFTtVRptVkASaCOdvvrtZQcqarYgLcmSerT2TBMJen8ay3Dudjr
	 TFeYPrtKCL/z7mshKEWWmqe2K5+ZDb9H6u2w0/7zfQfZFKF0hJzBSpFH5/9tnBKjJ4
	 as9YQgHNNGLj7TMjLbaolgGXgRveBZ7n21Zc57OtMrB5H566pAxgJcOcycKJevqxGb
	 ErOQwIp1Hkja1wuJ8ZbI5n54c+ILtHPgUc+K0GZBNQt+5g16w4mXus8PItGHuyDKjS
	 3lrHUSuxwR+vw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E2413378211A;
	Fri, 29 Mar 2024 20:19:39 +0000 (UTC)
Message-ID: <ca7a1547-5bb0-40d7-a77a-9ca6c14fd6f2@collabora.com>
Date: Sat, 30 Mar 2024 01:20:10 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: cgroup: skip test_cgcore_lesser_ns_open when
 cgroup2 mounted without nsdelegate
To: Tianchen Ding <dtcccc@linux.alibaba.com>, linux-kernel@vger.kernel.org
References: <20240327024437.3196-1-dtcccc@linux.alibaba.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240327024437.3196-1-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/24 7:44 AM, Tianchen Ding wrote:
> The test case test_cgcore_lesser_ns_open only tasks effect when cgroup2
> is mounted with "nsdelegate" mount option. If it misses this option, or
> is remounted without "nsdelegate", the test case will fail. For example,
> running bpf/test_cgroup_storage first, and then run cgroup/test_core will
> fail on test_cgcore_lesser_ns_open. Skip it if "nsdelegate" is not
> detected in cgroup2 mount options.
> 
> Fixes: bf35a7879f1d ("selftests: cgroup: Test open-time cgroup namespace usage for migration checks")
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/cgroup/cgroup_util.c        | 8 +++++---
>  tools/testing/selftests/cgroup/cgroup_util.h        | 2 +-
>  tools/testing/selftests/cgroup/test_core.c          | 7 ++++++-
>  tools/testing/selftests/cgroup/test_cpu.c           | 2 +-
>  tools/testing/selftests/cgroup/test_cpuset.c        | 2 +-
>  tools/testing/selftests/cgroup/test_freezer.c       | 2 +-
>  tools/testing/selftests/cgroup/test_hugetlb_memcg.c | 2 +-
>  tools/testing/selftests/cgroup/test_kill.c          | 2 +-
>  tools/testing/selftests/cgroup/test_kmem.c          | 2 +-
>  tools/testing/selftests/cgroup/test_memcontrol.c    | 2 +-
>  tools/testing/selftests/cgroup/test_zswap.c         | 2 +-
>  11 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index 0340d4ca8f51..432db923bced 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -195,10 +195,10 @@ int cg_write_numeric(const char *cgroup, const char *control, long value)
>  	return cg_write(cgroup, control, buf);
>  }
>  
> -int cg_find_unified_root(char *root, size_t len)
> +int cg_find_unified_root(char *root, size_t len, bool *nsdelegate)
>  {
>  	char buf[10 * PAGE_SIZE];
> -	char *fs, *mount, *type;
> +	char *fs, *mount, *type, *options;
>  	const char delim[] = "\n\t ";
>  
>  	if (read_text("/proc/self/mounts", buf, sizeof(buf)) <= 0)
> @@ -211,12 +211,14 @@ int cg_find_unified_root(char *root, size_t len)
>  	for (fs = strtok(buf, delim); fs; fs = strtok(NULL, delim)) {
>  		mount = strtok(NULL, delim);
>  		type = strtok(NULL, delim);
> -		strtok(NULL, delim);
> +		options = strtok(NULL, delim);
>  		strtok(NULL, delim);
>  		strtok(NULL, delim);
>  
>  		if (strcmp(type, "cgroup2") == 0) {
>  			strncpy(root, mount, len);
> +			if (nsdelegate)
> +				*nsdelegate = !!strstr(options, "nsdelegate");
>  			return 0;
>  		}
>  	}
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
> index 1df7f202214a..89e8519fb271 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.h
> +++ b/tools/testing/selftests/cgroup/cgroup_util.h
> @@ -21,7 +21,7 @@ static inline int values_close(long a, long b, int err)
>  	return abs(a - b) <= (a + b) / 100 * err;
>  }
>  
> -extern int cg_find_unified_root(char *root, size_t len);
> +extern int cg_find_unified_root(char *root, size_t len, bool *nsdelegate);
>  extern char *cg_name(const char *root, const char *name);
>  extern char *cg_name_indexed(const char *root, const char *name, int index);
>  extern char *cg_control(const char *cgroup, const char *control);
> diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
> index 80aa6b2373b9..a5672a91d273 100644
> --- a/tools/testing/selftests/cgroup/test_core.c
> +++ b/tools/testing/selftests/cgroup/test_core.c
> @@ -18,6 +18,8 @@
>  #include "../kselftest.h"
>  #include "cgroup_util.h"
>  
> +static bool nsdelegate;
> +
>  static int touch_anon(char *buf, size_t size)
>  {
>  	int fd;
> @@ -775,6 +777,9 @@ static int test_cgcore_lesser_ns_open(const char *root)
>  	pid_t pid;
>  	int status;
>  
> +	if (!nsdelegate)
> +		return KSFT_SKIP;
> +
>  	cg_test_a = cg_name(root, "cg_test_a");
>  	cg_test_b = cg_name(root, "cg_test_b");
>  
> @@ -862,7 +867,7 @@ int main(int argc, char *argv[])
>  	char root[PATH_MAX];
>  	int i, ret = EXIT_SUCCESS;
>  
> -	if (cg_find_unified_root(root, sizeof(root)))
> +	if (cg_find_unified_root(root, sizeof(root), &nsdelegate))
>  		ksft_exit_skip("cgroup v2 isn't mounted\n");
>  
>  	if (cg_read_strstr(root, "cgroup.subtree_control", "memory"))
> diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
> index 24020a2c68dc..186bf96f6a28 100644
> --- a/tools/testing/selftests/cgroup/test_cpu.c
> +++ b/tools/testing/selftests/cgroup/test_cpu.c
> @@ -700,7 +700,7 @@ int main(int argc, char *argv[])
>  	char root[PATH_MAX];
>  	int i, ret = EXIT_SUCCESS;
>  
> -	if (cg_find_unified_root(root, sizeof(root)))
> +	if (cg_find_unified_root(root, sizeof(root), NULL))
>  		ksft_exit_skip("cgroup v2 isn't mounted\n");
>  
>  	if (cg_read_strstr(root, "cgroup.subtree_control", "cpu"))
> diff --git a/tools/testing/selftests/cgroup/test_cpuset.c b/tools/testing/selftests/cgroup/test_cpuset.c
> index b061ed1e05b4..4034d14ba69a 100644
> --- a/tools/testing/selftests/cgroup/test_cpuset.c
> +++ b/tools/testing/selftests/cgroup/test_cpuset.c
> @@ -249,7 +249,7 @@ int main(int argc, char *argv[])
>  	char root[PATH_MAX];
>  	int i, ret = EXIT_SUCCESS;
>  
> -	if (cg_find_unified_root(root, sizeof(root)))
> +	if (cg_find_unified_root(root, sizeof(root), NULL))
>  		ksft_exit_skip("cgroup v2 isn't mounted\n");
>  
>  	if (cg_read_strstr(root, "cgroup.subtree_control", "cpuset"))
> diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
> index 8845353aca53..8730645d363a 100644
> --- a/tools/testing/selftests/cgroup/test_freezer.c
> +++ b/tools/testing/selftests/cgroup/test_freezer.c
> @@ -827,7 +827,7 @@ int main(int argc, char *argv[])
>  	char root[PATH_MAX];
>  	int i, ret = EXIT_SUCCESS;
>  
> -	if (cg_find_unified_root(root, sizeof(root)))
> +	if (cg_find_unified_root(root, sizeof(root), NULL))
>  		ksft_exit_skip("cgroup v2 isn't mounted\n");
>  	for (i = 0; i < ARRAY_SIZE(tests); i++) {
>  		switch (tests[i].fn(root)) {
> diff --git a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
> index f0fefeb4cc24..856f9508ea56 100644
> --- a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
> +++ b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
> @@ -214,7 +214,7 @@ int main(int argc, char **argv)
>  		return ret;
>  	}
>  
> -	if (cg_find_unified_root(root, sizeof(root)))
> +	if (cg_find_unified_root(root, sizeof(root), NULL))
>  		ksft_exit_skip("cgroup v2 isn't mounted\n");
>  
>  	switch (test_hugetlb_memcg(root)) {
> diff --git a/tools/testing/selftests/cgroup/test_kill.c b/tools/testing/selftests/cgroup/test_kill.c
> index 6153690319c9..0e5bb6c7307a 100644
> --- a/tools/testing/selftests/cgroup/test_kill.c
> +++ b/tools/testing/selftests/cgroup/test_kill.c
> @@ -276,7 +276,7 @@ int main(int argc, char *argv[])
>  	char root[PATH_MAX];
>  	int i, ret = EXIT_SUCCESS;
>  
> -	if (cg_find_unified_root(root, sizeof(root)))
> +	if (cg_find_unified_root(root, sizeof(root), NULL))
>  		ksft_exit_skip("cgroup v2 isn't mounted\n");
>  	for (i = 0; i < ARRAY_SIZE(tests); i++) {
>  		switch (tests[i].fn(root)) {
> diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> index c82f974b85c9..137506db0312 100644
> --- a/tools/testing/selftests/cgroup/test_kmem.c
> +++ b/tools/testing/selftests/cgroup/test_kmem.c
> @@ -420,7 +420,7 @@ int main(int argc, char **argv)
>  	char root[PATH_MAX];
>  	int i, ret = EXIT_SUCCESS;
>  
> -	if (cg_find_unified_root(root, sizeof(root)))
> +	if (cg_find_unified_root(root, sizeof(root), NULL))
>  		ksft_exit_skip("cgroup v2 isn't mounted\n");
>  
>  	/*
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index c7c9572003a8..b462416b3806 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -1314,7 +1314,7 @@ int main(int argc, char **argv)
>  	char root[PATH_MAX];
>  	int i, proc_status, ret = EXIT_SUCCESS;
>  
> -	if (cg_find_unified_root(root, sizeof(root)))
> +	if (cg_find_unified_root(root, sizeof(root), NULL))
>  		ksft_exit_skip("cgroup v2 isn't mounted\n");
>  
>  	/*
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
> index f0e488ed90d8..ef7f39545317 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -440,7 +440,7 @@ int main(int argc, char **argv)
>  	char root[PATH_MAX];
>  	int i, ret = EXIT_SUCCESS;
>  
> -	if (cg_find_unified_root(root, sizeof(root)))
> +	if (cg_find_unified_root(root, sizeof(root), NULL))
>  		ksft_exit_skip("cgroup v2 isn't mounted\n");
>  
>  	if (!zswap_configured())

-- 
BR,
Muhammad Usama Anjum

