Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E1371F2CE
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 21:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjFATSZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 15:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjFATSZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 15:18:25 -0400
Received: from out-3.mta0.migadu.com (out-3.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FC318D
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Jun 2023 12:18:22 -0700 (PDT)
Message-ID: <95b5da7c-ee52-3ecb-0a4e-f6a7a114f269@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685647100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IgQZpjSw84vHYzWJzYdDrGuuO8eVETVsB+aIQNPgeJo=;
        b=T5TRCpFPEJWIYl7mNS9gOtoXuy3z/cFxsJM4qoVYA9XPtITZxRANGN4Ldk58dRi1mIrA3X
        6ADfH8TO+l/v9ZFMMpebcSUEey5zfCSEGLYrSu6Vp6oanVkUFdySPYHH37YcEdcTWD1x86
        qJHP6DVnwIpsrsOc/JPIJgNEj6W58Fw=
Date:   Thu, 1 Jun 2023 12:18:15 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix elem_size not being set for inner maps
Content-Language: en-US
To:     Rhys Rustad-Elliott <me@rhysre.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20230601000713.506358-1-me@rhysre.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230601000713.506358-1-me@rhysre.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/31/23 5:08 PM, Rhys Rustad-Elliott wrote:
> Commit d937bc3449fa ("bpf: make uniform use of array->elem_size
> everywhere in arraymap.c") changed array_map_gen_lookup to use
> array->elem_size instead of round_up(map->value_size, 8) as the element
> size when generating code to access a value in an array map.
> 
> array->elem_size, however, is not set by bpf_map_meta_alloc when
> initializing an BPF_MAP_TYPE_ARRAY_OF_MAPS or BPF_MAP_TYPE_HASH_OF_MAPS.
> This results in array_map_gen_lookup incorrectly outputting code that
> always accesses index 0 in the array (as the index will be calculated
> via a multiplication with the element size, which is incorrectly set to
> 0).
> 
> Set elem_size on the bpf_array object when allocating an array or hash
> of maps and add a selftest that accesses an inner map at a nonzero index
> to prevent regressions.
> 
> Fixes: d937bc3449fa ("bpf: make uniform use of array->elem_size everywhere in arraymap.c")
> Signed-off-by: Rhys Rustad-Elliott <me@rhysre.net>
> ---
>   kernel/bpf/map_in_map.c                       |  8 +++-
>   .../map_in_map_inner_array_lookup.c           | 33 ++++++++++++++
>   .../test_map_in_map_inner_array_lookup.c      | 45 +++++++++++++++++++
>   3 files changed, 84 insertions(+), 2 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/map_in_map_inner_array_lookup.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_map_in_map_inner_array_lookup.c
> 
> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index 2c5c64c2a53b..8d65b12e0834 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c
> @@ -69,9 +69,13 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>   	/* Misc members not needed in bpf_map_meta_equal() check. */
>   	inner_map_meta->ops = inner_map->ops;
>   	if (inner_map->ops == &array_map_ops) {
> +		struct bpf_array *inner_array_meta =
> +			container_of(inner_map_meta, struct bpf_array, map);
> +		struct bpf_array *inner_array = container_of(inner_map, struct bpf_array, map);
> +
> +		inner_array_meta->index_mask = inner_array->index_mask;
> +		inner_array_meta->elem_size = round_up(inner_map->value_size, 8);

How about directly use inner_array->elem_size instead of
"round_up(inner_map->value_size, 8)"?

>   		inner_map_meta->bypass_spec_v1 = inner_map->bypass_spec_v1;
> -		container_of(inner_map_meta, struct bpf_array, map)->index_mask =
> -		     container_of(inner_map, struct bpf_array, map)->index_mask;
>   	}
>   
>   	fdput(f);
> diff --git a/tools/testing/selftests/bpf/prog_tests/map_in_map_inner_array_lookup.c b/tools/testing/selftests/bpf/prog_tests/map_in_map_inner_array_lookup.c
> new file mode 100644
> index 000000000000..264d4788e5fd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/map_in_map_inner_array_lookup.c

Separate the selftests into another patch.

> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <test_progs.h>
> +
> +#include "test_map_in_map_inner_array_lookup.skel.h"
> +
> +static int duration;

Use the ASSERT_* macro instead of CHECK, then no need for
"static int duration;".

> +
> +void test_map_in_map_inner_array_lookup(void)

nit. A shorter name? may be test_inner_array_lookup().

> +{
> +	int map1_fd, err;
> +	int key = 3;
> +	int val = 1;
> +	struct test_map_in_map_inner_array_lookup *skel;
> +
> +	skel = test_map_in_map_inner_array_lookup__open_and_load();
> +	if (CHECK(!skel, "skel_open", "failed to open&load skeleton\n"))
> +		return;
> +
> +	err = test_map_in_map_inner_array_lookup__attach(skel);
> +	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
> +		goto cleanup;
> +
> +	map1_fd = bpf_map__fd(skel->maps.inner_map1);
> +	bpf_map_update_elem(map1_fd, &key, &val, 0);
> +	usleep(1);

Why usleep is needed?

> +	/* Probe should have set the element at index 3 to 2 */
> +	bpf_map_lookup_elem(map1_fd, &key, &val);
> +	CHECK(val != 2, "inner1", "got %d != exp %d\n", val, 2);
> +
> +cleanup:
> +	test_map_in_map_inner_array_lookup__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map_inner_array_lookup.c b/tools/testing/selftests/bpf/progs/test_map_in_map_inner_array_lookup.c
> new file mode 100644
> index 000000000000..c2c8f2fa451d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_map_in_map_inner_array_lookup.c

nit. A shorter name also, inner_array_lookup.c?

> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct inner_map {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 5);
> +	__type(key, int);
> +	__type(value, int);
> +} inner_map1 SEC(".maps");
> +
> +struct outer_map {
> +	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
> +	__uint(max_entries, 3);
> +	__type(key, int);
> +	__array(values, struct inner_map);
> +} outer_map1 SEC(".maps") = {
> +	.values = {
> +		[2] = &inner_map1,
> +	},
> +};
> +
> +SEC("raw_tp/sys_enter")
> +int handle__sys_enter(void *ctx)
> +{
> +	int outer_key = 2, inner_key = 3;
> +	int *val;
> +	void *map;
> +
> +	map = bpf_map_lookup_elem(&outer_map1, &outer_key);
> +	if (!map)
> +		return 1;
> +
> +	val = bpf_map_lookup_elem(map, &inner_key);
> +	if (!val)
> +		return 1;
> +
> +	if (*val == 1)
> +		*val = 2;
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";

