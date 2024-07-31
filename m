Return-Path: <linux-kselftest+bounces-14503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 568CD9423DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 02:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844441C20CF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 00:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDADB4A31;
	Wed, 31 Jul 2024 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BFha4T4p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB12F41
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 00:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722386067; cv=none; b=Km3Hic5Fkc30yhPGtyy0f9uKKCvcWg0gKHGbhpWpTHRW5zhepKT5YbLLcRSO8/8T9wmI/V98BprQ3xedDe2I5CCVjq9GxwmDWw1zWxC3g/vX7yx8skVoDUcvW3My4CHxzYabcoaZQiIMEYG0WcK+BBqHKVxaRJIkvLwglqmc3Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722386067; c=relaxed/simple;
	bh=oO0sYFP8KYgyWJO7d7Q8XHXe2aWnhH0c8kHegbLWwbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMrhKSHqMi+SJKmcv/azQ09UvySh584FRjPEfJ/ruA0cWtXl2BiJ7hU9eyyitGDsGWsMbQ3x6CR7UIH88wP3wo0wyO/uIUIBFHAPR+QYsped0AerTSDXXy4HroCljMd4uLf462eK3DrYqUAYECB5edJQonZg7VcFExhXRU41L3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BFha4T4p; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <06f7a546-aec8-4804-8f80-1b7000229120@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722386063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZreUMd6oeolIpLcdZvUKPef6UMHZxU3coLJsdC21/4g=;
	b=BFha4T4pspnH8L8PrHa435pWeI5p7GX3oHGEwLbbVCLVhETCiGyTIiYnRjbnj2WavFkZpX
	cJ7I09F0nWAYQQsQpCRC6TsAleUtr962clrKqC4c6og0OyZAeAkCp4XUSVop5R10IMKTGD
	2I48zE5rmvPoKtKpBYR1RfJvSWWWbFs=
Date: Tue, 30 Jul 2024 17:34:10 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: convert test_dev_cgroup to
 test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240730-convert_dev_cgroup-v3-0-93e573b74357@bootlin.com>
 <20240730-convert_dev_cgroup-v3-2-93e573b74357@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240730-convert_dev_cgroup-v3-2-93e573b74357@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/30/24 4:59 AM, Alexis Lothoré (eBPF Foundation) wrote:
> +static void test_read(const char *path, char *buf, int buf_size,
> +		      int expected_ret)
> +{
> +	int ret, fd;
> +
> +	fd = open(path, O_RDONLY);
> +
> +	/* A bare open on unauthorized device should fail */
> +	if (expected_ret < 0) {
> +		ASSERT_EQ(fd, expected_ret, "open file for read");

One nit. expected_ret is actually expected_errno. It just happens -EPERM is -1, 
so testing fd against expected_errno works here but is confusing to read. How 
about separating the fd and errno test in the access rejected case. First test 
for fd == -1 and then test for errno == expected_errno.

Please also carry Stanislav's Ack in patch 1 and 3 in the next respin.

Thanks for helping to move this test to test_progs.

pw-bot: cr

> +		if (fd >= 0)
> +			close(fd);
> +		return;
> +	}
> +
> +	if (!ASSERT_OK_FD(fd, "open file for read"))
> +		return;
> +
> +	ret = read(fd, buf, buf_size);
> +	ASSERT_EQ(ret, expected_ret, "read");
> +
> +	close(fd);
> +}
> +
> +static void test_write(const char *path, char *buf, int buf_size,
> +		       int expected_ret)
> +{
> +	int ret, fd;
> +
> +	fd = open(path, O_WRONLY);
> +
> +	/* A bare open on unauthorized device should fail */
> +	if (expected_ret < 0) {
> +		ASSERT_EQ(fd, expected_ret, "open file for write");
> +		if (fd >= 0)
> +			close(fd);
> +		return;
> +	}
> +
> +	if (!ASSERT_OK_FD(fd, "open file for write"))
> +		return;
> +
> +	ret = write(fd, buf, buf_size);
> +	ASSERT_EQ(ret, expected_ret, "write");
> +
> +	close(fd);
> +}
> +
> +void test_cgroup_dev(void)
> +{
> +	char buf[TEST_BUFFER_SIZE] = "some random test data";
> +	struct dev_cgroup *skel;
> +	int cgroup_fd;
> +
> +	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
> +	if (!ASSERT_OK_FD(cgroup_fd, "cgroup switch"))
> +		return;
> +
> +	skel = dev_cgroup__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "load program"))
> +		goto cleanup_cgroup;
> +
> +	skel->links.bpf_prog1 =
> +		bpf_program__attach_cgroup(skel->progs.bpf_prog1, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.bpf_prog1, "attach_program"))
> +		goto cleanup_progs;
> +
> +	if (test__start_subtest("allow-mknod"))
> +		test_mknod("/dev/test_dev_cgroup_null", S_IFCHR, 1, 3, 0);
> +
> +	if (test__start_subtest("allow-read"))
> +		test_read("/dev/urandom", buf, TEST_BUFFER_SIZE,
> +			  TEST_BUFFER_SIZE);
> +
> +	if (test__start_subtest("allow-write"))
> +		test_write("/dev/null", buf, TEST_BUFFER_SIZE,
> +			   TEST_BUFFER_SIZE);
> +
> +	if (test__start_subtest("deny-mknod"))
> +		test_mknod("/dev/test_dev_cgroup_zero", S_IFCHR, 1, 5, -EPERM);
> +
> +	if (test__start_subtest("deny-read"))
> +		test_read("/dev/random", buf, TEST_BUFFER_SIZE, -EPERM);
> +
> +	if (test__start_subtest("deny-write"))
> +		test_write("/dev/zero", buf, TEST_BUFFER_SIZE, -EPERM);
> +
> +cleanup_progs:
> +	dev_cgroup__destroy(skel);
> +cleanup_cgroup:
> +	cleanup_cgroup_environment();
> +}



