Return-Path: <linux-kselftest+bounces-39658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FEDB3101C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 09:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3813F1CE09E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5482E7646;
	Fri, 22 Aug 2025 07:19:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166DE222587;
	Fri, 22 Aug 2025 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847173; cv=none; b=JrAlTMPL3LOebIs+/ZI9IRTcSP3oIhoQixZ9uClK+QKl8OZlqncaC44VRQ13htiImOQ/h0pD1u3s9K3WMIOVG3AB02VI7Ptqkey8yCPgdt6ECNaOW1oaQrZQzHE7N5bjqfeUzzIOyPwTC5HdHRfyC5mqvsk38d7Rf12fbwPnKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847173; c=relaxed/simple;
	bh=86bYby/1AL0BQg9gD2HmflxZ5C5NTWT37EGL27zKS2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFwsQ1ra5afY1mIVucBZoiJ65jK9NXKYgvC/OtfW0jujoelTT3/Vt/IltD5zhTlqZ/y1B/zmkq8nreIgDsBfd2fuLjhCmG0PDC4g2JScZRReYOg029LxQr6hZIZF/SMpZQbbPZNwhw91TtPIkl4s9YsM9DqmEROUuPeYsB51oEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c7Wlj3nbszYQw11;
	Fri, 22 Aug 2025 15:19:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 142CA1A0B3B;
	Fri, 22 Aug 2025 15:19:28 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgAnMrT+GahoIsXWEQ--.36670S2;
	Fri, 22 Aug 2025 15:19:27 +0800 (CST)
Message-ID: <bad4609b-4427-48ff-80e9-70cb3066253e@huaweicloud.com>
Date: Fri, 22 Aug 2025 15:19:26 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] cgroup: selftests: Add tests for freezer time
To: Tiffany Yang <ynaffit@google.com>, linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Chen Ridong <chenridong@huawei.com>, kernel-team@android.com,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250822013749.3268080-6-ynaffit@google.com>
 <20250822013749.3268080-8-ynaffit@google.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250822013749.3268080-8-ynaffit@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnMrT+GahoIsXWEQ--.36670S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tr4DKF18Jw43tw4ruw1rJFb_yoW8WrWkKo
	Wvqry3A3s5Xw17Zr48Z3srK3yjgF48J347XFWxWF1fGFy8Z3sFy34UWF4xZ3y8tr1Ik34q
	ya97Wa9rKF4Dtw15n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/22 9:37, Tiffany Yang wrote:
> Test cgroup v2 freezer time stat. Freezer time accounting should
> be independent of other cgroups in the hierarchy and should increase
> iff a cgroup is CGRP_FREEZE (regardless of whether it reaches
> CGRP_FROZEN).
> 
> Skip these tests on systems without freeze time accounting.
> 
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> Cc: Michal Koutný <mkoutny@suse.com>
> ---
> v3 -> v4:
> * Clean up logic around skipping selftests and decrease granularity of
>   sleep times, as suggested by Michal.
> ---
>  tools/testing/selftests/cgroup/test_freezer.c | 663 ++++++++++++++++++
>  1 file changed, 663 insertions(+)
> 
> diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
> index 8730645d363a..dfb763819581 100644
> --- a/tools/testing/selftests/cgroup/test_freezer.c
> +++ b/tools/testing/selftests/cgroup/test_freezer.c
> @@ -804,6 +804,662 @@ static int test_cgfreezer_vfork(const char *root)
>  	return ret;
>  }
>  
> +/*
> + * Get the current frozen_usec for the cgroup.
> + */
> +static long cg_check_freezetime(const char *cgroup)
> +{
> +	return cg_read_key_long(cgroup, "cgroup.stat.local",
> +				"frozen_usec ");
> +}
> +
> +/*
> + * Test that the freeze time will behave as expected for an empty cgroup.
> + */
> +static int test_cgfreezer_time_empty(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	char *cgroup = NULL;
> +	long prev, curr;
> +
> +	cgroup = cg_name(root, "cg_time_test_empty");
> +	if (!cgroup)
> +		goto cleanup;
> +
> +	/*
> +	 * 1) Create an empty cgroup and check that its freeze time
> +	 *    is 0.
> +	 */
> +	if (cg_create(cgroup))
> +		goto cleanup;
> +
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr < 0) {
> +		ret = KSFT_SKIP;
> +		goto cleanup;
> +	}
> +	if (curr > 0) {
> +		debug("Expect time (%ld) to be 0\n", curr);
> +		goto cleanup;
> +	}
> +

Perhaps we can simply use if (curr != 0) for the condition?

> +	if (cg_freeze_nowait(cgroup, true))
> +		goto cleanup;
> +
> +	/*
> +	 * 2) Sleep for 1000 us. Check that the freeze time is at
> +	 *    least 1000 us.
> +	 */
> +	usleep(1000);
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr < 1000) {
> +		debug("Expect time (%ld) to be at least 1000 us\n",
> +		      curr);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * 3) Unfreeze the cgroup. Check that the freeze time is
> +	 *    larger than at 2).
> +	 */
> +	if (cg_freeze_nowait(cgroup, false))
> +		goto cleanup;
> +	prev = curr;
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr <= prev) {
> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
> +		      curr, prev);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * 4) Check the freeze time again to ensure that it has not
> +	 *    changed.
> +	 */
> +	prev = curr;
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr != prev) {
> +		debug("Expect time (%ld) to be unchanged from previous check (%ld)\n",
> +		      curr, prev);
> +		goto cleanup;
> +	}
> +
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	if (cgroup)
> +		cg_destroy(cgroup);
> +	free(cgroup);
> +	return ret;
> +}
> +
> +/*
> + * A simple test for cgroup freezer time accounting. This test follows
> + * the same flow as test_cgfreezer_time_empty, but with a single process
> + * in the cgroup.
> + */
> +static int test_cgfreezer_time_simple(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	char *cgroup = NULL;
> +	long prev, curr;
> +
> +	cgroup = cg_name(root, "cg_time_test_simple");
> +	if (!cgroup)
> +		goto cleanup;
> +
> +	/*
> +	 * 1) Create a cgroup and check that its freeze time is 0.
> +	 */
> +	if (cg_create(cgroup))
> +		goto cleanup;
> +
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr < 0) {
> +		ret = KSFT_SKIP;
> +		goto cleanup;
> +	}
> +	if (curr > 0) {
> +		debug("Expect time (%ld) to be 0\n", curr);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * 2) Populate the cgroup with one child and check that the
> +	 *    freeze time is still 0.
> +	 */
> +	cg_run_nowait(cgroup, child_fn, NULL);
> +	prev = curr;
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr > prev) {
> +		debug("Expect time (%ld) to be 0\n", curr);
> +		goto cleanup;
> +	}
> +
> +	if (cg_freeze_nowait(cgroup, true))
> +		goto cleanup;
> +
> +	/*
> +	 * 3) Sleep for 1000 us. Check that the freeze time is at
> +	 *    least 1000 us.
> +	 */
> +	usleep(1000);
> +	prev = curr;
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr < 1000) {
> +		debug("Expect time (%ld) to be at least 1000 us\n",
> +		      curr);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * 4) Unfreeze the cgroup. Check that the freeze time is
> +	 *    larger than at 3).
> +	 */
> +	if (cg_freeze_nowait(cgroup, false))
> +		goto cleanup;
> +	prev = curr;
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr <= prev) {
> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
> +		      curr, prev);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * 5) Sleep for 1000 us. Check that the freeze time is the
> +	 *    same as at 4).
> +	 */
> +	usleep(1000);
> +	prev = curr;
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr != prev) {
> +		debug("Expect time (%ld) to be unchanged from previous check (%ld)\n",
> +		      curr, prev);
> +		goto cleanup;
> +	}
> +
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	if (cgroup)
> +		cg_destroy(cgroup);
> +	free(cgroup);
> +	return ret;
> +}
> +
> +/*
> + * Test that freezer time accounting works as expected, even while we're
> + * populating a cgroup with processes.
> + */
> +static int test_cgfreezer_time_populate(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	char *cgroup = NULL;
> +	long prev, curr;
> +	int i;
> +
> +	cgroup = cg_name(root, "cg_time_test_populate");
> +	if (!cgroup)
> +		goto cleanup;
> +
> +	if (cg_create(cgroup))
> +		goto cleanup;
> +
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr < 0) {
> +		ret = KSFT_SKIP;
> +		goto cleanup;
> +	}
> +	if (curr > 0) {
> +		debug("Expect time (%ld) to be 0\n", curr);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * 1) Populate the cgroup with 100 processes. Check that
> +	 *    the freeze time is 0.
> +	 */
> +	for (i = 0; i < 100; i++)
> +		cg_run_nowait(cgroup, child_fn, NULL);
> +	prev = curr;
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr != prev) {
> +		debug("Expect time (%ld) to be 0\n", curr);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * 2) Wait for the group to become fully populated. Check
> +	 *    that the freeze time is 0.
> +	 */
> +	if (cg_wait_for_proc_count(cgroup, 100))
> +		goto cleanup;
> +	prev = curr;
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr != prev) {
> +		debug("Expect time (%ld) to be 0\n", curr);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * 3) Freeze the cgroup and then populate it with 100 more
> +	 *    processes. Check that the freeze time continues to grow.
> +	 */
> +	if (cg_freeze_nowait(cgroup, true))
> +		goto cleanup;
> +	prev = curr;
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr <= prev) {
> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
> +		      curr, prev);
> +		goto cleanup;
> +	}
> +
> +	for (i = 0; i < 100; i++)
> +		cg_run_nowait(cgroup, child_fn, NULL);
> +	prev = curr;
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr <= prev) {
> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
> +		      curr, prev);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * 4) Wait for the group to become fully populated. Check
> +	 *    that the freeze time is larger than at 3).
> +	 */
> +	if (cg_wait_for_proc_count(cgroup, 200))
> +		goto cleanup;
> +	prev = curr;
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr <= prev) {
> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
> +		      curr, prev);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * 5) Unfreeze the cgroup. Check that the freeze time is
> +	 *    larger than at 4).
> +	 */
> +	if (cg_freeze_nowait(cgroup, false))
> +		goto cleanup;
> +	prev = curr;
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr <= prev) {
> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
> +		      curr, prev);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * 6) Kill the processes. Check that the freeze time is the
> +	 *    same as it was at 5).
> +	 */
> +	if (cg_killall(cgroup))
> +		goto cleanup;
> +	prev = curr;
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr != prev) {
> +		debug("Expect time (%ld) to be unchanged from previous check (%ld)\n",
> +		      curr, prev);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * 7) Freeze and unfreeze the cgroup. Check that the freeze
> +	 *    time is larger than it was at 6).
> +	 */
> +	if (cg_freeze_nowait(cgroup, true))
> +		goto cleanup;
> +	if (cg_freeze_nowait(cgroup, false))
> +		goto cleanup;
> +	prev = curr;
> +	curr = cg_check_freezetime(cgroup);
> +	if (curr <= prev) {
> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
> +		      curr, prev);
> +		goto cleanup;
> +	}
> +
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	if (cgroup)
> +		cg_destroy(cgroup);
> +	free(cgroup);
> +	return ret;
> +}
> +
> +/*
> + * Test that frozen time for a cgroup continues to work as expected,
> + * even as processes are migrated. Frozen cgroup A's freeze time should
> + * continue to increase and running cgroup B's should stay 0.
> + */
> +static int test_cgfreezer_time_migrate(const char *root)
> +{
> +	long prev_A, curr_A, curr_B;
> +	char *cgroup[2] = {0};
> +	int ret = KSFT_FAIL;
> +	int pid;
> +
> +	cgroup[0] = cg_name(root, "cg_time_test_migrate_A");
> +	if (!cgroup[0])
> +		goto cleanup;
> +
> +	cgroup[1] = cg_name(root, "cg_time_test_migrate_B");
> +	if (!cgroup[1])
> +		goto cleanup;
> +
> +	if (cg_create(cgroup[0]))
> +		goto cleanup;
> +
> +	if (cg_check_freezetime(cgroup[0]) < 0) {
> +		ret = KSFT_SKIP;
> +		goto cleanup;
> +	}
> +
> +	if (cg_create(cgroup[1]))
> +		goto cleanup;
> +
> +	pid = cg_run_nowait(cgroup[0], child_fn, NULL);
> +	if (pid < 0)
> +		goto cleanup;
> +
> +	if (cg_wait_for_proc_count(cgroup[0], 1))
> +		goto cleanup;
> +
> +	curr_A = cg_check_freezetime(cgroup[0]);
> +	if (curr_A) {
> +		debug("Expect time (%ld) to be 0\n", curr_A);
> +		goto cleanup;
> +	}
> +	curr_B = cg_check_freezetime(cgroup[1]);
> +	if (curr_B) {
> +		debug("Expect time (%ld) to be 0\n", curr_B);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * Freeze cgroup A.
> +	 */
> +	if (cg_freeze_wait(cgroup[0], true))
> +		goto cleanup;
> +	prev_A = curr_A;
> +	curr_A = cg_check_freezetime(cgroup[0]);
> +	if (curr_A <= prev_A) {
> +		debug("Expect time (%ld) to be > 0\n", curr_A);
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * Migrate from A (frozen) to B (running).
> +	 */
> +	if (cg_enter(cgroup[1], pid))
> +		goto cleanup;
> +
> +	usleep(1000);
> +	curr_B = cg_check_freezetime(cgroup[1]);
> +	if (curr_B) {
> +		debug("Expect time (%ld) to be 0\n", curr_B);
> +		goto cleanup;
> +	}
> +
> +	prev_A = curr_A;
> +	curr_A = cg_check_freezetime(cgroup[0]);
> +	if (curr_A <= prev_A) {
> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
> +		      curr_A, prev_A);
> +		goto cleanup;
> +	}
> +
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	if (cgroup[0])
> +		cg_destroy(cgroup[0]);
> +	free(cgroup[0]);
> +	if (cgroup[1])
> +		cg_destroy(cgroup[1]);
> +	free(cgroup[1]);
> +	return ret;
> +}
> +
> +/*
> + * The test creates a cgroup and freezes it. Then it creates a child cgroup.
> + * After that it checks that the child cgroup has a non-zero freeze time
> + * that is less than the parent's. Next, it freezes the child, unfreezes
> + * the parent, and sleeps. Finally, it checks that the child's freeze
> + * time has grown larger than the parent's.
> + */
> +static int test_cgfreezer_time_parent(const char *root)
> +{
> +	char *parent, *child = NULL;
> +	int ret = KSFT_FAIL;
> +	long ptime, ctime;
> +
> +	parent = cg_name(root, "cg_test_parent_A");
> +	if (!parent)
> +		goto cleanup;
> +
> +	child = cg_name(parent, "cg_test_parent_B");
> +	if (!child)
> +		goto cleanup;
> +
> +	if (cg_create(parent))
> +		goto cleanup;
> +
> +	if (cg_check_freezetime(parent) < 0) {
> +		ret = KSFT_SKIP;
> +		goto cleanup;
> +	}
> +
> +	if (cg_freeze_wait(parent, true))
> +		goto cleanup;
> +
> +	usleep(1000);
> +	if (cg_create(child))
> +		goto cleanup;
> +
> +	if (cg_check_frozen(child, true))
> +		goto cleanup;
> +
> +	/*
> +	 * Since the parent was frozen the entire time the child cgroup
> +	 * was being created, we expect the parent's freeze time to be
> +	 * larger than the child's.
> +	 *
> +	 * Ideally, we would be able to check both times simultaneously,
> +	 * but here we get the child's after we get the parent's.
> +	 */
> +	ptime = cg_check_freezetime(parent);
> +	ctime = cg_check_freezetime(child);
> +	if (ptime <= ctime) {
> +		debug("Expect ptime (%ld) > ctime (%ld)\n", ptime, ctime);
> +		goto cleanup;
> +	}
> +
> +	if (cg_freeze_nowait(child, true))
> +		goto cleanup;
> +
> +	if (cg_freeze_wait(parent, false))
> +		goto cleanup;
> +
> +	if (cg_check_frozen(child, true))
> +		goto cleanup;
> +
> +	usleep(100000);
> +
> +	ctime = cg_check_freezetime(child);
> +	ptime = cg_check_freezetime(parent);
> +
> +	if (ctime <= ptime) {
> +		debug("Expect ctime (%ld) > ptime (%ld)\n", ctime, ptime);
> +		goto cleanup;
> +	}
> +
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	if (child)
> +		cg_destroy(child);
> +	free(child);
> +	if (parent)
> +		cg_destroy(parent);
> +	free(parent);
> +	return ret;
> +}
> +
> +/*
> + * The test creates a parent cgroup and a child cgroup. Then, it freezes
> + * the child and checks that the child's freeze time is greater than the
> + * parent's, which should be zero.
> + */
> +static int test_cgfreezer_time_child(const char *root)
> +{
> +	char *parent, *child = NULL;
> +	int ret = KSFT_FAIL;
> +	long ptime, ctime;
> +
> +	parent = cg_name(root, "cg_test_child_A");
> +	if (!parent)
> +		goto cleanup;
> +
> +	child = cg_name(parent, "cg_test_child_B");
> +	if (!child)
> +		goto cleanup;
> +
> +	if (cg_create(parent))
> +		goto cleanup;
> +
> +	if (cg_check_freezetime(parent) < 0) {
> +		ret = KSFT_SKIP;
> +		goto cleanup;
> +	}
> +
> +	if (cg_create(child))
> +		goto cleanup;
> +
> +	if (cg_freeze_wait(child, true))
> +		goto cleanup;
> +
> +	ctime = cg_check_freezetime(child);
> +	ptime = cg_check_freezetime(parent);
> +	if (ptime != 0) {
> +		debug("Expect ptime (%ld) to be 0\n", ptime);
> +		goto cleanup;
> +	}
> +
> +	if (ctime <= ptime) {
> +		debug("Expect ctime (%ld) <= ptime (%ld)\n", ctime, ptime);
> +		goto cleanup;
> +	}
> +
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	if (child)
> +		cg_destroy(child);
> +	free(child);
> +	if (parent)
> +		cg_destroy(parent);
> +	free(parent);
> +	return ret;
> +}
> +
> +/*
> + * The test creates the following hierarchy:
> + *    A
> + *    |
> + *    B
> + *    |
> + *    C
> + *
> + * Then it freezes the cgroups in the order C, B, A.
> + * Then it unfreezes the cgroups in the order A, B, C.
> + * Then it checks that C's freeze time is larger than B's and
> + * that B's is larger than A's.
> + */
> +static int test_cgfreezer_time_nested(const char *root)
> +{
> +	char *cgroup[3] = {0};
> +	int ret = KSFT_FAIL;
> +	long time[3] = {0};
> +	int i;
> +
> +	cgroup[0] = cg_name(root, "cg_test_time_A");
> +	if (!cgroup[0])
> +		goto cleanup;
> +
> +	cgroup[1] = cg_name(cgroup[0], "B");
> +	if (!cgroup[1])
> +		goto cleanup;
> +
> +	cgroup[2] = cg_name(cgroup[1], "C");
> +	if (!cgroup[2])
> +		goto cleanup;
> +
> +	if (cg_create(cgroup[0]))
> +		goto cleanup;
> +
> +	if (cg_check_freezetime(cgroup[0]) < 0) {
> +		ret = KSFT_SKIP;
> +		goto cleanup;
> +	}
> +
> +	if (cg_create(cgroup[1]))
> +		goto cleanup;
> +
> +	if (cg_create(cgroup[2]))
> +		goto cleanup;
> +
> +	if (cg_freeze_nowait(cgroup[2], true))
> +		goto cleanup;
> +
> +	if (cg_freeze_nowait(cgroup[1], true))
> +		goto cleanup;
> +
> +	if (cg_freeze_nowait(cgroup[0], true))
> +		goto cleanup;
> +
> +	usleep(1000);
> +
> +	if (cg_freeze_nowait(cgroup[0], false))
> +		goto cleanup;
> +
> +	if (cg_freeze_nowait(cgroup[1], false))
> +		goto cleanup;
> +
> +	if (cg_freeze_nowait(cgroup[2], false))
> +		goto cleanup;
> +
> +	time[2] = cg_check_freezetime(cgroup[2]);
> +	time[1] = cg_check_freezetime(cgroup[1]);
> +	time[0] = cg_check_freezetime(cgroup[0]);
> +
> +	if (time[2] <= time[1]) {
> +		debug("Expect C's time (%ld) > B's time (%ld)", time[2], time[1]);
> +		goto cleanup;
> +	}
> +
> +	if (time[1] <= time[0]) {
> +		debug("Expect B's time (%ld) > A's time (%ld)", time[1], time[0]);
> +		goto cleanup;
> +	}
> +
> +	ret = KSFT_PASS;
> +
> +cleanup:
> +	for (i = 2; i >= 0 && cgroup[i]; i--) {
> +		cg_destroy(cgroup[i]);
> +		free(cgroup[i]);
> +	}
> +
> +	return ret;
> +}
> +
>  #define T(x) { x, #x }
>  struct cgfreezer_test {
>  	int (*fn)(const char *root);
> @@ -819,6 +1475,13 @@ struct cgfreezer_test {
>  	T(test_cgfreezer_stopped),
>  	T(test_cgfreezer_ptraced),
>  	T(test_cgfreezer_vfork),
> +	T(test_cgfreezer_time_empty),
> +	T(test_cgfreezer_time_simple),
> +	T(test_cgfreezer_time_populate),
> +	T(test_cgfreezer_time_migrate),
> +	T(test_cgfreezer_time_parent),
> +	T(test_cgfreezer_time_child),
> +	T(test_cgfreezer_time_nested),
>  };
>  #undef T
>  

-- 
Best regards,
Ridong


