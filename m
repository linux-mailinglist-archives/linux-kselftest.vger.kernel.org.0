Return-Path: <linux-kselftest+bounces-40269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F213B3B92C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 12:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9D9567520
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4801330F80C;
	Fri, 29 Aug 2025 10:50:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388A530F540;
	Fri, 29 Aug 2025 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464622; cv=none; b=tlX0ZusirxTuxYENOmPxi/u0riJ2tlUxK44W4E5tKUkDrd/GEqKMod858EunUyc0r166RvWmmOWcg7oadGkDtPW2f5gYNfslgiIje2nhfc/hmOBkEY456INE+nJWnk55aNGoQr6CGpNj4mLUpOFW8FulReLwGIvbxIj4XO0RRxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464622; c=relaxed/simple;
	bh=1BczQsxcdw5u5DicFj+XZw2B5I3E7eTLYKVJXZR59a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKgIcG0Zonv+wbw+sNDKDF9A/ueFgjbhEfmIBduJKDoDqA33Viclc7JqsDLW2BwPjRu9YOrzYtr0VXM/tsmv0YKjJ1wzeMrIA8wzXFgxLgERCBiQD9XzcD4zFieReu+J8mI9GCCTqF42XnnjQiSPNfAYNs4QP7Qykudw1a78B7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42D1C19F0;
	Fri, 29 Aug 2025 03:50:11 -0700 (PDT)
Received: from [10.57.92.164] (unknown [10.57.92.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C53B13F694;
	Fri, 29 Aug 2025 03:50:16 -0700 (PDT)
Message-ID: <04b3603b-c432-45b1-883a-806b3375335b@arm.com>
Date: Fri, 29 Aug 2025 11:50:15 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] selftests/bpf: Add selftests
To: Lin Yikai <yikai.lin@vivo.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-pm@vger.kernel.org,
 bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc: zhaofuyu@vivo.com
References: <20250829101137.9507-1-yikai.lin@vivo.com>
 <20250829101137.9507-3-yikai.lin@vivo.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250829101137.9507-3-yikai.lin@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 11:11, Lin Yikai wrote:
> Add test to verify cpuidle governor ext's load, attach, and kfuncs.
> 
> This patch also provides a simple demonstration of `cpuidle_gov_ext_ops` usage:
> - In `ops.init()`, we set the "rating" value to 60 - significantly exceeding other governors' ratings - to activate `cpuidle_gov_ext`.
> - For specific scenarios (e.g., screen-off music playback on mobile devices), we can enable "expect_deeper" to transition to deeper idle states.
> 
> This implementation serves as a foundation, not a final solution.
> We can explore further exploration of cpuidle strategies optimized for various usage scenarios.

This is the example cpuidle BPF governor I guess, just some very first comments.

patch title should mention "cpuidle governor" somehow.

> 
> Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
> ---
>  .../bpf/prog_tests/test_cpuidle_gov_ext.c     |  28 +++
>  .../selftests/bpf/progs/cpuidle_gov_ext.c     | 208 ++++++++++++++++++
>  2 files changed, 236 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cpuidle_gov_ext.c
>  create mode 100644 tools/testing/selftests/bpf/progs/cpuidle_gov_ext.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_cpuidle_gov_ext.c b/tools/testing/selftests/bpf/prog_tests/test_cpuidle_gov_ext.c
> new file mode 100644
> index 000000000000..8b35771ada44
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_cpuidle_gov_ext.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * test_cpuidle_gov_ext.c - test cpuidle governor ext's load, attach and kfuncs
> + *
> + * Copyright (C) Yikai Lin <yikai.lin@vivo.com>
> + */
> +
> +#include <test_progs.h>
> +#include "cpuidle_gov_ext.skel.h"
> +
> +void test_test_cpuidle_gov_ext(void)
> +{
> +	struct cpuidle_gov_ext *skel;
> +	int err;
> +
> +	skel = cpuidle_gov_ext__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "cpuidle_gov_ext__open_and_load"))
> +		return;
> +
> +	skel->bss->expect_deeper = 1;
> +	err = cpuidle_gov_ext__attach(skel);
> +	if (!ASSERT_OK(err, "cpuidle_gov_ext__attach"))
> +		goto cleanup;
> +
> +cleanup:
> +	cpuidle_gov_ext__destroy(skel);
> +}
> +
> diff --git a/tools/testing/selftests/bpf/progs/cpuidle_gov_ext.c b/tools/testing/selftests/bpf/progs/cpuidle_gov_ext.c
> new file mode 100644
> index 000000000000..62d5a9bc8cb3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/cpuidle_gov_ext.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * cpuidle_gov_ext.c - test to use cpuidle governor ext by bpf
> + *
> + * Copyright (C) Yikai Lin <yikai.lin@vivo.com>
> + */
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +
> +char LICENSE[] SEC("license") = "GPL";
> +
> +#ifndef ARRAY_SIZE
> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> +#endif
> +#ifndef max
> +#define max(a, b) ((a) > (b) ? (a) : (b))
> +#endif
> +#ifndef min
> +#define min(a, b) ((a) < (b) ? (a) : (b))
> +#endif
> +
> +#define ALPHA 10
> +#define ALPHA_SCALE 100
> +#define FIT_FACTOR 90
> +
> +/*
> + * For some low-power scenarios,
> + * such as the screen off scenario of mobile devices
> + * (which will be determined by the user-space BPF program),
> + * we aim to choose a deeper state
> + * At this point, we will somewhat disregard the impact on CPU performance.
> + */
> +int expect_deeper = 0;
> +
> +int bpf_cpuidle_ext_gov_update_rating(unsigned int rating) __ksym __weak;
> +s64 bpf_cpuidle_ext_gov_latency_req(unsigned int cpu) __ksym __weak;
> +s64 bpf_tick_nohz_get_sleep_length(void) __ksym __weak;

These would need proper headers, every BPF cpuidle governor would need them, no?

> +
> +struct cpuidle_gov_data {
> +	int cpu;
> +	int last_idx;
> +	u64 last_pred;
> +	u64 last_duration;
> +	u64 next_pred;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, u32);
> +	__type(value, struct cpuidle_gov_data);
> +} cpuidle_gov_data_map SEC(".maps");
> +
> +static u64 calculate_ewma(u64 last, u64 new, u32 alpha, u32 alpha_scale)
> +{
> +	return (alpha * new + (alpha_scale - alpha) * last) / alpha_scale;
> +}
> +
> +static void update_predict_duration(struct cpuidle_gov_data *data,
> +			struct cpuidle_driver *drv, struct cpuidle_device *dev)
> +{
> +	int idx;
> +	struct cpuidle_state target;
> +
> +	if (!data || !drv || !dev)
> +		return;
> +	idx = data->last_idx;
> +	data->last_duration = dev->last_residency_ns;
> +	if (idx > 0) {
> +		bpf_core_read(&target, sizeof(target), &drv->states[idx]);
> +		if (data->last_duration > target.exit_latency)
> +			data->last_duration -= target.exit_latency;
> +	}
> +	data->last_pred = data->next_pred;
> +	data->next_pred = calculate_ewma(data->next_pred,
> +		data->last_duration, ALPHA, ALPHA_SCALE);
> +}
> +
> +/* Enable the cpuidle governor */
> +SEC("struct_ops.s/enable")
> +int BPF_PROG(bpf_cpuidle_enable, struct cpuidle_driver *drv, struct cpuidle_device *dev)
> +{
> +	u32 key = 0;
> +	struct cpuidle_gov_data *data;
> +
> +	bpf_printk("cpuidle_gov_ext: enabled");
> +	data = bpf_map_lookup_percpu_elem(&cpuidle_gov_data_map, &key, dev->cpu);
> +	if (!data)
> +		return 0;
> +
> +	__builtin_memset(data, 0, sizeof(struct cpuidle_gov_data));
> +	data->cpu = dev->cpu;
> +	return 0;
> +}
> +
> +/* Disable the cpuidle governor */
> +SEC("struct_ops.s/disable")
> +void BPF_PROG(bpf_cpuidle_disable, struct cpuidle_driver *drv, struct cpuidle_device *dev)
> +{
> +	bpf_printk("cpuidle_gov_ext: disabled");
> +}
> +
> +/* Select the next idle state */
> +SEC("struct_ops.s/select")
> +int BPF_PROG(bpf_cpuidle_select, struct cpuidle_driver *drv, struct cpuidle_device *dev)
> +{
> +	u32 key = 0;
> +	s64 delta, latency_req, residency_ns;
> +	int i, selected;
> +	unsigned long long disable = 0;
> +	struct cpuidle_gov_data *data;
> +	struct cpuidle_state cs;
> +
> +	data = bpf_map_lookup_percpu_elem(&cpuidle_gov_data_map, &key, dev->cpu);
> +	if (!data) {
> +		bpf_printk("cpuidle_gov_ext: [%s] cpuidle_gov_data_map is NULL\n", __func__);
> +		return 0;
> +	}
> +	latency_req = bpf_cpuidle_ext_gov_latency_req(dev->cpu);
> +	delta = bpf_tick_nohz_get_sleep_length();
> +
> +	update_predict_duration(data, drv, dev);
> +
> +	for (i = ARRAY_SIZE(drv->states)-1; i > 0; i--) {
> +		if (i > drv->state_count-1)
> +			continue;

When is this true?

> +		bpf_core_read(&cs, sizeof(cs), &drv->states[i]);
> +		bpf_core_read(&disable, sizeof(disable), &dev->states_usage[i]);

Is there no nicer way of doing this than reading it every select() call?

> +
> +		if (disable)
> +			continue;
> +
> +		if (latency_req < cs.exit_latency_ns)
> +			continue;
> +
> +		if (delta < cs.target_residency_ns)
> +			continue;
> +
> +		if (data->next_pred / FIT_FACTOR * ALPHA_SCALE < cs.target_residency_ns)
> +			continue;
> +
> +		break;
> +	}
> +	residency_ns = drv->states[i].target_residency_ns;
> +	if (expect_deeper &&
> +		i < drv->state_count - 1 &&
> +		data->last_pred >= residency_ns &&
> +		data->next_pred < residency_ns &&
> +		data->next_pred / FIT_FACTOR * ALPHA_SCALE >= residency_ns &&
> +		data->next_pred / FIT_FACTOR * ALPHA_SCALE >= data->last_duration &&
> +		delta > residency_ns) {
> +		i++;

i++ might be disabled though.

> +	}
> +
> +	selected = i;

Just return i?

> +	return selected;
> +}
> +
> +//enable or disable scheduling tick after selecting cpuidle state
> +SEC("struct_ops.s/set_stop_tick")
> +bool BPF_PROG(bpf_cpuidle_set_stop_tick)
> +{
> +	return false;
> +}
> +
> +/* Reflect function called after entering an idle state */
> +SEC("struct_ops.s/reflect")
> +void BPF_PROG(bpf_cpuidle_reflect, struct cpuidle_device *dev, int index)
> +{
> +	u32 key = 0;
> +	struct cpuidle_gov_data *data;
> +
> +	data = bpf_map_lookup_percpu_elem(&cpuidle_gov_data_map, &key, dev->cpu);
> +	if (!data) {
> +		bpf_printk("cpuidle_gov_ext: [%s] cpuidle_gov_data_map is NULL\n", __func__);
> +		return;
> +	}
> +	data->last_idx = index;
> +}
> +
> +/* Initialize the BPF cpuidle governor */
> +SEC("struct_ops.s/init")
> +int BPF_PROG(bpf_cpuidle_init)
> +{
> +	int ret = bpf_cpuidle_ext_gov_update_rating(60);
> +	return ret;

unnecessary ret.

> +}
> +
> +/* Cleanup after the BPF cpuidle governor */
> +SEC("struct_ops.s/exit")
> +void BPF_PROG(bpf_cpuidle_exit) { }
> +
> +/* Struct_ops linkage for cpuidle governor */
> +SEC(".struct_ops.link")
> +struct cpuidle_gov_ext_ops ops = {
> +	.enable  = (void *)bpf_cpuidle_enable,
> +	.disable = (void *)bpf_cpuidle_disable,
> +	.select  = (void *)bpf_cpuidle_select,
> +	.set_stop_tick = (void *)bpf_cpuidle_set_stop_tick,
> +	.reflect = (void *)bpf_cpuidle_reflect,
> +	.init	= (void *)bpf_cpuidle_init,
> +	.exit	= (void *)bpf_cpuidle_exit,
> +	.name	= "BPF_cpuidle_gov"
> +};


