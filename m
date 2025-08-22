Return-Path: <linux-kselftest+bounces-39720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5ABB3226A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 20:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD03688393
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 18:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54CE2BF015;
	Fri, 22 Aug 2025 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3gNFLLIx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F42BD5B3
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755888662; cv=none; b=gkMWnniC7prK2pvR5dX+/7ffITo4mE42KsKa8H8Ls+1ownt+KxASTzT31BA6dxVHlCv9Nk1Ymh0QGM4omy3mkO5rDelIk+nG2WLmWmB/IFeteNR10VJPK5AStWOTQUXonhKURiz8bbeaWarFgk5vUkPoXCLvQsr3rw9C26+12dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755888662; c=relaxed/simple;
	bh=62RHWmEFghr2hDCfzymeVlhMTE2zu2Szcc94M5ovaIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rk1S4b6MXgIvdky7dNhoDddVtr6xZv8H0Z5MkdCTKMW0+uUm7VEc5B6GwTBvt+tjsXwDOLhxg91HokapraPkLDOHqv3qTVH0cyefWqvzq0Gh9xackGQ7ysHd56pStp4j+rc+sH80fnwmmOF3hOKUGljUYCnJrau2o0WH9yNKdA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3gNFLLIx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b49c1c40e12so719726a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755888660; x=1756493460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RNJVbyMASg6OaHdYKLJRD6s++8dLw9B8FspS4kM0ZvA=;
        b=3gNFLLIxR2FVDvYs5oa4r9pjzVZgeoK3aZD0oarQ4YtBFsjwb5j+2o4MePlfHFHTKm
         vtFdB/utxcG3YSQUf8hh1n0EjyZCxoQaR7l10u8IRF2YR+zwmrfacRr/gpcM6EbQYUYu
         LMIpbe+c3ZwNLp/At3REHqtVjZsZWl+9Swt3unOwn2XnB7vkvwBrdEjD+7iXhxmjgPS2
         +xzi5K+WQmhuNDzVAopHCyT6JQtcWz/SXBMj0wBqGwB13pWcuQnJpREyZ1CpeEbfsJV1
         vIiLQLGdDcog9SHUNV3vL8QncOIWodYeeq0dGysY3EeVikgMzXT/L1MeAIbVGT/4fUQL
         WtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755888660; x=1756493460;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNJVbyMASg6OaHdYKLJRD6s++8dLw9B8FspS4kM0ZvA=;
        b=rjOpGH3fzUuzs6mWqN2xCMtLWxi9N4Gn/UEVbtpdvdLzk635Wa1pM4rnFHK9aFj2mA
         bkWoVSyDcu5l2T4dyK41e/cmdTi1mhUFCVCK/5wdjfXapb03P8yTE4Zkd5xkfnMue67t
         x6x9Xgz4k5qjoRwsQgej5ICbMKGBzW9xwKMoEB6fiRmFAppHnxIrHxExwBgmpS9QhirC
         XY6cUwZ2DCAl3L14U/w91fSZWsyQC2jGewk2NQcoVWdmzMAa0qfwxQidLRlcx+NAYEZE
         aqwadDxsLDYHcAhIQSo6PxxYgtsvMdkHeihtIvNFZih0TBErOhuOwRXKebqFQPOt6x2S
         HLAA==
X-Forwarded-Encrypted: i=1; AJvYcCUlhh/bp72np8iNZwvnhiy55pojSTqNtXjpKPXA7or/BzFCcEVQLl1+5dwnyu53tFLS4OnNBGpzmMuW9yun9ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIGimIxDd3ErFYuEy7/+WY4LLGxpFOwgio43Fv9cMc9yH9kHo8
	yb0qgDN9pPzw/XWaUyPEaOKROQkyawajXHRamM/ENTlMKgg9eODmhVJh/0t/mw4gB7p+5LZSeDC
	UvRuArYwjGA==
X-Google-Smtp-Source: AGHT+IE/KR/xuGrSTbpJUep5kLn83DL4hYVCuTHtTK7xSj3aHgOzXeIVcRC0hElos+5tRp1/t7TC/LfMb1/9
X-Received: from plrx6.prod.google.com ([2002:a17:902:b406:b0:240:229f:5b97])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2d1:b0:240:48f4:40f7
 with SMTP id d9443c01a7336-2462ef423e2mr53447575ad.39.1755888659925; Fri, 22
 Aug 2025 11:50:59 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:50:58 -0700
In-Reply-To: <bad4609b-4427-48ff-80e9-70cb3066253e@huaweicloud.com> (Chen
 Ridong's message of "Fri, 22 Aug 2025 15:19:26 +0800")
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822013749.3268080-6-ynaffit@google.com> <20250822013749.3268080-8-ynaffit@google.com>
 <bad4609b-4427-48ff-80e9-70cb3066253e@huaweicloud.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8sehj8a25.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH v4 2/2] cgroup: selftests: Add tests for freezer time
From: Tiffany Yang <ynaffit@google.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Thanks for taking the time to look at these patches!

Chen Ridong <chenridong@huaweicloud.com> writes:

> On 2025/8/22 9:37, Tiffany Yang wrote:
>> Test cgroup v2 freezer time stat. Freezer time accounting should
>> be independent of other cgroups in the hierarchy and should increase
>> iff a cgroup is CGRP_FREEZE (regardless of whether it reaches
>> CGRP_FROZEN).

...
>> +	if (curr < 0) {
>> +		ret = KSFT_SKIP;
>> +		goto cleanup;
>> +	}
>> +	if (curr > 0) {
>> +		debug("Expect time (%ld) to be 0\n", curr);
>> +		goto cleanup;
>> +	}
>> +

> Perhaps we can simply use if (curr != 0) for the condition?


Here we have 2 separate conditions because in the case where curr < 0,
it means that the interface is not available and we should skip this
test instead of failing it. In the case where curr > 0, the feature is
not working correctly, and the test should fail as a result.

>> +	if (cg_freeze_nowait(cgroup, true))
>> +		goto cleanup;
>> +
>> +	/*
>> +	 * 2) Sleep for 1000 us. Check that the freeze time is at
>> +	 *    least 1000 us.
>> +	 */
>> +	usleep(1000);
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr < 1000) {
>> +		debug("Expect time (%ld) to be at least 1000 us\n",
>> +		      curr);
>> +		goto cleanup;
>> +	}
>> +
>> +	/*
>> +	 * 3) Unfreeze the cgroup. Check that the freeze time is
>> +	 *    larger than at 2).
>> +	 */
>> +	if (cg_freeze_nowait(cgroup, false))
>> +		goto cleanup;
>> +	prev = curr;
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr <= prev) {
>> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
>> +		      curr, prev);
>> +		goto cleanup;
>> +	}
>> +
>> +	/*
>> +	 * 4) Check the freeze time again to ensure that it has not
>> +	 *    changed.
>> +	 */
>> +	prev = curr;
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr != prev) {
>> +		debug("Expect time (%ld) to be unchanged from previous check (%ld)\n",
>> +		      curr, prev);
>> +		goto cleanup;
>> +	}
>> +
>> +	ret = KSFT_PASS;
>> +
>> +cleanup:
>> +	if (cgroup)
>> +		cg_destroy(cgroup);
>> +	free(cgroup);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * A simple test for cgroup freezer time accounting. This test follows
>> + * the same flow as test_cgfreezer_time_empty, but with a single process
>> + * in the cgroup.
>> + */
>> +static int test_cgfreezer_time_simple(const char *root)
>> +{
>> +	int ret = KSFT_FAIL;
>> +	char *cgroup = NULL;
>> +	long prev, curr;
>> +
>> +	cgroup = cg_name(root, "cg_time_test_simple");
>> +	if (!cgroup)
>> +		goto cleanup;
>> +
>> +	/*
>> +	 * 1) Create a cgroup and check that its freeze time is 0.
>> +	 */
>> +	if (cg_create(cgroup))
>> +		goto cleanup;
>> +
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr < 0) {
>> +		ret = KSFT_SKIP;
>> +		goto cleanup;
>> +	}
>> +	if (curr > 0) {
>> +		debug("Expect time (%ld) to be 0\n", curr);
>> +		goto cleanup;
>> +	}
>> +
>> +	/*
>> +	 * 2) Populate the cgroup with one child and check that the
>> +	 *    freeze time is still 0.
>> +	 */
>> +	cg_run_nowait(cgroup, child_fn, NULL);
>> +	prev = curr;
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr > prev) {
>> +		debug("Expect time (%ld) to be 0\n", curr);
>> +		goto cleanup;
>> +	}
>> +
>> +	if (cg_freeze_nowait(cgroup, true))
>> +		goto cleanup;
>> +
>> +	/*
>> +	 * 3) Sleep for 1000 us. Check that the freeze time is at
>> +	 *    least 1000 us.
>> +	 */
>> +	usleep(1000);
>> +	prev = curr;
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr < 1000) {
>> +		debug("Expect time (%ld) to be at least 1000 us\n",
>> +		      curr);
>> +		goto cleanup;
>> +	}
>> +
>> +	/*
>> +	 * 4) Unfreeze the cgroup. Check that the freeze time is
>> +	 *    larger than at 3).
>> +	 */
>> +	if (cg_freeze_nowait(cgroup, false))
>> +		goto cleanup;
>> +	prev = curr;
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr <= prev) {
>> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
>> +		      curr, prev);
>> +		goto cleanup;
>> +	}
>> +
>> +	/*
>> +	 * 5) Sleep for 1000 us. Check that the freeze time is the
>> +	 *    same as at 4).
>> +	 */
>> +	usleep(1000);
>> +	prev = curr;
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr != prev) {
>> +		debug("Expect time (%ld) to be unchanged from previous check (%ld)\n",
>> +		      curr, prev);
>> +		goto cleanup;
>> +	}
>> +
>> +	ret = KSFT_PASS;
>> +
>> +cleanup:
>> +	if (cgroup)
>> +		cg_destroy(cgroup);
>> +	free(cgroup);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * Test that freezer time accounting works as expected, even while we're
>> + * populating a cgroup with processes.
>> + */
>> +static int test_cgfreezer_time_populate(const char *root)
>> +{
>> +	int ret = KSFT_FAIL;
>> +	char *cgroup = NULL;
>> +	long prev, curr;
>> +	int i;
>> +
>> +	cgroup = cg_name(root, "cg_time_test_populate");
>> +	if (!cgroup)
>> +		goto cleanup;
>> +
>> +	if (cg_create(cgroup))
>> +		goto cleanup;
>> +
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr < 0) {
>> +		ret = KSFT_SKIP;
>> +		goto cleanup;
>> +	}
>> +	if (curr > 0) {
>> +		debug("Expect time (%ld) to be 0\n", curr);
>> +		goto cleanup;
>> +	}
>> +
>> +	/*
>> +	 * 1) Populate the cgroup with 100 processes. Check that
>> +	 *    the freeze time is 0.
>> +	 */
>> +	for (i = 0; i < 100; i++)
>> +		cg_run_nowait(cgroup, child_fn, NULL);
>> +	prev = curr;
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr != prev) {
>> +		debug("Expect time (%ld) to be 0\n", curr);
>> +		goto cleanup;
>> +	}
>> +
>> +	/*
>> +	 * 2) Wait for the group to become fully populated. Check
>> +	 *    that the freeze time is 0.
>> +	 */
>> +	if (cg_wait_for_proc_count(cgroup, 100))
>> +		goto cleanup;
>> +	prev = curr;
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr != prev) {
>> +		debug("Expect time (%ld) to be 0\n", curr);
>> +		goto cleanup;
>> +	}
>> +
>> +	/*
>> +	 * 3) Freeze the cgroup and then populate it with 100 more
>> +	 *    processes. Check that the freeze time continues to grow.
>> +	 */
>> +	if (cg_freeze_nowait(cgroup, true))
>> +		goto cleanup;
>> +	prev = curr;
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr <= prev) {
>> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
>> +		      curr, prev);
>> +		goto cleanup;
>> +	}
>> +
>> +	for (i = 0; i < 100; i++)
>> +		cg_run_nowait(cgroup, child_fn, NULL);
>> +	prev = curr;
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr <= prev) {
>> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
>> +		      curr, prev);
>> +		goto cleanup;
>> +	}
>> +
>> +	/*
>> +	 * 4) Wait for the group to become fully populated. Check
>> +	 *    that the freeze time is larger than at 3).
>> +	 */
>> +	if (cg_wait_for_proc_count(cgroup, 200))
>> +		goto cleanup;
>> +	prev = curr;
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr <= prev) {
>> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
>> +		      curr, prev);
>> +		goto cleanup;
>> +	}
>> +
>> +	/*
>> +	 * 5) Unfreeze the cgroup. Check that the freeze time is
>> +	 *    larger than at 4).
>> +	 */
>> +	if (cg_freeze_nowait(cgroup, false))
>> +		goto cleanup;
>> +	prev = curr;
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr <= prev) {
>> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
>> +		      curr, prev);
>> +		goto cleanup;
>> +	}
>> +
>> +	/*
>> +	 * 6) Kill the processes. Check that the freeze time is the
>> +	 *    same as it was at 5).
>> +	 */
>> +	if (cg_killall(cgroup))
>> +		goto cleanup;
>> +	prev = curr;
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr != prev) {
>> +		debug("Expect time (%ld) to be unchanged from previous check (%ld)\n",
>> +		      curr, prev);
>> +		goto cleanup;
>> +	}
>> +
>> +	/*
>> +	 * 7) Freeze and unfreeze the cgroup. Check that the freeze
>> +	 *    time is larger than it was at 6).
>> +	 */
>> +	if (cg_freeze_nowait(cgroup, true))
>> +		goto cleanup;
>> +	if (cg_freeze_nowait(cgroup, false))
>> +		goto cleanup;
>> +	prev = curr;
>> +	curr = cg_check_freezetime(cgroup);
>> +	if (curr <= prev) {
>> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
>> +		      curr, prev);
>> +		goto cleanup;
>> +	}
>> +
>> +	ret = KSFT_PASS;
>> +
>> +cleanup:
>> +	if (cgroup)
>> +		cg_destroy(cgroup);
>> +	free(cgroup);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * Test that frozen time for a cgroup continues to work as expected,
>> + * even as processes are migrated. Frozen cgroup A's freeze time should
>> + * continue to increase and running cgroup B's should stay 0.
>> + */
>> +static int test_cgfreezer_time_migrate(const char *root)
>> +{
>> +	long prev_A, curr_A, curr_B;
>> +	char *cgroup[2] = {0};
>> +	int ret = KSFT_FAIL;
>> +	int pid;
>> +
>> +	cgroup[0] = cg_name(root, "cg_time_test_migrate_A");
>> +	if (!cgroup[0])
>> +		goto cleanup;
>> +
>> +	cgroup[1] = cg_name(root, "cg_time_test_migrate_B");
>> +	if (!cgroup[1])
>> +		goto cleanup;
>> +
>> +	if (cg_create(cgroup[0]))
>> +		goto cleanup;
>> +
>> +	if (cg_check_freezetime(cgroup[0]) < 0) {
>> +		ret = KSFT_SKIP;
>> +		goto cleanup;
>> +	}
>> +
>> +	if (cg_create(cgroup[1]))
>> +		goto cleanup;
>> +
>> +	pid = cg_run_nowait(cgroup[0], child_fn, NULL);
>> +	if (pid < 0)
>> +		goto cleanup;
>> +
>> +	if (cg_wait_for_proc_count(cgroup[0], 1))
>> +		goto cleanup;
>> +
>> +	curr_A = cg_check_freezetime(cgroup[0]);
>> +	if (curr_A) {
>> +		debug("Expect time (%ld) to be 0\n", curr_A);
>> +		goto cleanup;
>> +	}
>> +	curr_B = cg_check_freezetime(cgroup[1]);
>> +	if (curr_B) {
>> +		debug("Expect time (%ld) to be 0\n", curr_B);
>> +		goto cleanup;
>> +	}
>> +
>> +	/*
>> +	 * Freeze cgroup A.
>> +	 */
>> +	if (cg_freeze_wait(cgroup[0], true))
>> +		goto cleanup;
>> +	prev_A = curr_A;
>> +	curr_A = cg_check_freezetime(cgroup[0]);
>> +	if (curr_A <= prev_A) {
>> +		debug("Expect time (%ld) to be > 0\n", curr_A);
>> +		goto cleanup;
>> +	}
>> +
>> +	/*
>> +	 * Migrate from A (frozen) to B (running).
>> +	 */
>> +	if (cg_enter(cgroup[1], pid))
>> +		goto cleanup;
>> +
>> +	usleep(1000);
>> +	curr_B = cg_check_freezetime(cgroup[1]);
>> +	if (curr_B) {
>> +		debug("Expect time (%ld) to be 0\n", curr_B);
>> +		goto cleanup;
>> +	}
>> +
>> +	prev_A = curr_A;
>> +	curr_A = cg_check_freezetime(cgroup[0]);
>> +	if (curr_A <= prev_A) {
>> +		debug("Expect time (%ld) to be more than previous check (%ld)\n",
>> +		      curr_A, prev_A);
>> +		goto cleanup;
>> +	}
>> +
>> +	ret = KSFT_PASS;
>> +
>> +cleanup:
>> +	if (cgroup[0])
>> +		cg_destroy(cgroup[0]);
>> +	free(cgroup[0]);
>> +	if (cgroup[1])
>> +		cg_destroy(cgroup[1]);
>> +	free(cgroup[1]);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * The test creates a cgroup and freezes it. Then it creates a child  
>> cgroup.
>> + * After that it checks that the child cgroup has a non-zero freeze time
>> + * that is less than the parent's. Next, it freezes the child, unfreezes
>> + * the parent, and sleeps. Finally, it checks that the child's freeze
>> + * time has grown larger than the parent's.
>> + */
>> +static int test_cgfreezer_time_parent(const char *root)
>> +{
>> +	char *parent, *child = NULL;
>> +	int ret = KSFT_FAIL;
>> +	long ptime, ctime;
>> +
>> +	parent = cg_name(root, "cg_test_parent_A");
>> +	if (!parent)
>> +		goto cleanup;
>> +
>> +	child = cg_name(parent, "cg_test_parent_B");
>> +	if (!child)
>> +		goto cleanup;
>> +
>> +	if (cg_create(parent))
>> +		goto cleanup;
>> +
>> +	if (cg_check_freezetime(parent) < 0) {
>> +		ret = KSFT_SKIP;
>> +		goto cleanup;
>> +	}
>> +
>> +	if (cg_freeze_wait(parent, true))
>> +		goto cleanup;
>> +
>> +	usleep(1000);
>> +	if (cg_create(child))
>> +		goto cleanup;
>> +
>> +	if (cg_check_frozen(child, true))
>> +		goto cleanup;
>> +
>> +	/*
>> +	 * Since the parent was frozen the entire time the child cgroup
>> +	 * was being created, we expect the parent's freeze time to be
>> +	 * larger than the child's.
>> +	 *
>> +	 * Ideally, we would be able to check both times simultaneously,
>> +	 * but here we get the child's after we get the parent's.
>> +	 */
>> +	ptime = cg_check_freezetime(parent);
>> +	ctime = cg_check_freezetime(child);
>> +	if (ptime <= ctime) {
>> +		debug("Expect ptime (%ld) > ctime (%ld)\n", ptime, ctime);
>> +		goto cleanup;
>> +	}
>> +
>> +	if (cg_freeze_nowait(child, true))
>> +		goto cleanup;
>> +
>> +	if (cg_freeze_wait(parent, false))
>> +		goto cleanup;
>> +
>> +	if (cg_check_frozen(child, true))
>> +		goto cleanup;
>> +
>> +	usleep(100000);
>> +
>> +	ctime = cg_check_freezetime(child);
>> +	ptime = cg_check_freezetime(parent);
>> +
>> +	if (ctime <= ptime) {
>> +		debug("Expect ctime (%ld) > ptime (%ld)\n", ctime, ptime);
>> +		goto cleanup;
>> +	}
>> +
>> +	ret = KSFT_PASS;
>> +
>> +cleanup:
>> +	if (child)
>> +		cg_destroy(child);
>> +	free(child);
>> +	if (parent)
>> +		cg_destroy(parent);
>> +	free(parent);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * The test creates a parent cgroup and a child cgroup. Then, it freezes
>> + * the child and checks that the child's freeze time is greater than the
>> + * parent's, which should be zero.
>> + */
>> +static int test_cgfreezer_time_child(const char *root)
>> +{
>> +	char *parent, *child = NULL;
>> +	int ret = KSFT_FAIL;
>> +	long ptime, ctime;
>> +
>> +	parent = cg_name(root, "cg_test_child_A");
>> +	if (!parent)
>> +		goto cleanup;
>> +
>> +	child = cg_name(parent, "cg_test_child_B");
>> +	if (!child)
>> +		goto cleanup;
>> +
>> +	if (cg_create(parent))
>> +		goto cleanup;
>> +
>> +	if (cg_check_freezetime(parent) < 0) {
>> +		ret = KSFT_SKIP;
>> +		goto cleanup;
>> +	}
>> +
>> +	if (cg_create(child))
>> +		goto cleanup;
>> +
>> +	if (cg_freeze_wait(child, true))
>> +		goto cleanup;
>> +
>> +	ctime = cg_check_freezetime(child);
>> +	ptime = cg_check_freezetime(parent);
>> +	if (ptime != 0) {
>> +		debug("Expect ptime (%ld) to be 0\n", ptime);
>> +		goto cleanup;
>> +	}
>> +
>> +	if (ctime <= ptime) {
>> +		debug("Expect ctime (%ld) <= ptime (%ld)\n", ctime, ptime);
>> +		goto cleanup;
>> +	}
>> +
>> +	ret = KSFT_PASS;
>> +
>> +cleanup:
>> +	if (child)
>> +		cg_destroy(child);
>> +	free(child);
>> +	if (parent)
>> +		cg_destroy(parent);
>> +	free(parent);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * The test creates the following hierarchy:
>> + *    A
>> + *    |
>> + *    B
>> + *    |
>> + *    C
>> + *
>> + * Then it freezes the cgroups in the order C, B, A.
>> + * Then it unfreezes the cgroups in the order A, B, C.
>> + * Then it checks that C's freeze time is larger than B's and
>> + * that B's is larger than A's.
>> + */
>> +static int test_cgfreezer_time_nested(const char *root)
>> +{
>> +	char *cgroup[3] = {0};
>> +	int ret = KSFT_FAIL;
>> +	long time[3] = {0};
>> +	int i;
>> +
>> +	cgroup[0] = cg_name(root, "cg_test_time_A");
>> +	if (!cgroup[0])
>> +		goto cleanup;
>> +
>> +	cgroup[1] = cg_name(cgroup[0], "B");
>> +	if (!cgroup[1])
>> +		goto cleanup;
>> +
>> +	cgroup[2] = cg_name(cgroup[1], "C");
>> +	if (!cgroup[2])
>> +		goto cleanup;
>> +
>> +	if (cg_create(cgroup[0]))
>> +		goto cleanup;
>> +
>> +	if (cg_check_freezetime(cgroup[0]) < 0) {
>> +		ret = KSFT_SKIP;
>> +		goto cleanup;
>> +	}
>> +
>> +	if (cg_create(cgroup[1]))
>> +		goto cleanup;
>> +
>> +	if (cg_create(cgroup[2]))
>> +		goto cleanup;
>> +
>> +	if (cg_freeze_nowait(cgroup[2], true))
>> +		goto cleanup;
>> +
>> +	if (cg_freeze_nowait(cgroup[1], true))
>> +		goto cleanup;
>> +
>> +	if (cg_freeze_nowait(cgroup[0], true))
>> +		goto cleanup;
>> +
>> +	usleep(1000);
>> +
>> +	if (cg_freeze_nowait(cgroup[0], false))
>> +		goto cleanup;
>> +
>> +	if (cg_freeze_nowait(cgroup[1], false))
>> +		goto cleanup;
>> +
>> +	if (cg_freeze_nowait(cgroup[2], false))
>> +		goto cleanup;
>> +
>> +	time[2] = cg_check_freezetime(cgroup[2]);
>> +	time[1] = cg_check_freezetime(cgroup[1]);
>> +	time[0] = cg_check_freezetime(cgroup[0]);
>> +
>> +	if (time[2] <= time[1]) {
>> +		debug("Expect C's time (%ld) > B's time (%ld)", time[2], time[1]);
>> +		goto cleanup;
>> +	}
>> +
>> +	if (time[1] <= time[0]) {
>> +		debug("Expect B's time (%ld) > A's time (%ld)", time[1], time[0]);
>> +		goto cleanup;
>> +	}
>> +
>> +	ret = KSFT_PASS;
>> +
>> +cleanup:
>> +	for (i = 2; i >= 0 && cgroup[i]; i--) {
>> +		cg_destroy(cgroup[i]);
>> +		free(cgroup[i]);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   #define T(x) { x, #x }
>>   struct cgfreezer_test {
>>   	int (*fn)(const char *root);
>> @@ -819,6 +1475,13 @@ struct cgfreezer_test {
>>   	T(test_cgfreezer_stopped),
>>   	T(test_cgfreezer_ptraced),
>>   	T(test_cgfreezer_vfork),
>> +	T(test_cgfreezer_time_empty),
>> +	T(test_cgfreezer_time_simple),
>> +	T(test_cgfreezer_time_populate),
>> +	T(test_cgfreezer_time_migrate),
>> +	T(test_cgfreezer_time_parent),
>> +	T(test_cgfreezer_time_child),
>> +	T(test_cgfreezer_time_nested),
>>   };
>>   #undef T


-- 
Tiffany Y. Yang

