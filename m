Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9728720C9C
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 02:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbjFCA2A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 20:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbjFCA2A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 20:28:00 -0400
Received: from out-18.mta0.migadu.com (out-18.mta0.migadu.com [IPv6:2001:41d0:1004:224b::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B39E41
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 17:27:56 -0700 (PDT)
Message-ID: <e405a055-6c7e-8570-3589-d8dc88f9bb26@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685752074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4larMbLDjPB5zY+Hl1WGzpUn9KW3h0MNQ6Pn1zc0n9o=;
        b=GJ5HfWJba1vqIm+YsJ5YRmZ+PpjqE5ixg5WEiiuXTNdJHZ6nZJ402LbpdtcprZimZR5QiH
        Q127UJYqwrlCTlUHciMpKUNh0xA1MTMWXewMT+ljkp0f6Gr/T3kzcVMdhFVVjHQmkotMU8
        KF5CCDRf/erCStYdbZMmDQ+5i2CSE/U=
Date:   Fri, 2 Jun 2023 17:27:49 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add access_inner_map selftest
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
References: <20230602190110.47068-1-me@rhysre.net>
 <20230602190110.47068-3-me@rhysre.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230602190110.47068-3-me@rhysre.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/2/23 12:02 PM, Rhys Rustad-Elliott wrote:
> Add a selftest that accesses a BPF_MAP_TYPE_ARRAY (at a nonzero index)
> nested within a BPF_MAP_TYPE_HASH_OF_MAPS to flex a previously buggy
> case.
> 
> Signed-off-by: Rhys Rustad-Elliott <me@rhysre.net>
> ---
>   .../bpf/prog_tests/inner_array_lookup.c       | 31 +++++++++++++
>   .../bpf/progs/test_inner_array_lookup.c       | 45 +++++++++++++++++++
>   2 files changed, 76 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/inner_array_lookup.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_inner_array_lookup.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/inner_array_lookup.c b/tools/testing/selftests/bpf/prog_tests/inner_array_lookup.c
> new file mode 100644
> index 000000000000..29d4d0067c60
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/inner_array_lookup.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <test_progs.h>
> +
> +#include "test_inner_array_lookup.skel.h"
> +
> +void test_inner_array_lookup(void)
> +{
> +	int map1_fd, err;
> +	int key = 3;
> +	int val = 1;
> +	struct test_inner_array_lookup *skel;
> +
> +	skel = test_inner_array_lookup__open_and_load();
> +	if (!ASSERT_TRUE(skel != NULL, "open_load_skeleton"))

Changed to ASSERT_OK_PTR. Similar changes to the ASSERT_TRUE below.

> +		return;
> +
> +	err = test_inner_array_lookup__attach(skel);
> +	if (!ASSERT_TRUE(err == 0, "skeleton_attach"))
> +		goto cleanup;
> +
> +	map1_fd = bpf_map__fd(skel->maps.inner_map1);
> +	bpf_map_update_elem(map1_fd, &key, &val, 0);
> +
> +	/* Probe should have set the element at index 3 to 2 */
> +	bpf_map_lookup_elem(map1_fd, &key, &val);
> +	ASSERT_TRUE(val == 2, "value_is_2");
> +
> +cleanup:
> +	test_inner_array_lookup__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_inner_array_lookup.c b/tools/testing/selftests/bpf/progs/test_inner_array_lookup.c
> new file mode 100644
> index 000000000000..c2c8f2fa451d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_inner_array_lookup.c

Removed 'test_' from the filename, already mentioned in v1.

Applied. Thanks for the fix.

