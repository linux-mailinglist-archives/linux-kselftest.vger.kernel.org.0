Return-Path: <linux-kselftest+bounces-7012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E8A895FF8
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 01:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EFE2835D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 23:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3194446B6;
	Tue,  2 Apr 2024 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rKUqR04r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB421340
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Apr 2024 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712099658; cv=none; b=jXwKSx8dE8Ejz4DMqzbwEoS030s+MBLzpTPmyPtftDZhBxYa7t50OhxAMirKFxJ0Kus2Y+1vH75AIGIYccdxGBBpU4BLz2YqO5VhmJes/1UUPWQpFxmKSeFpavJP8srgZiqaxaX9+kx7QqH+dWNaqzlDzXI2W2prjrXSDWK0pbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712099658; c=relaxed/simple;
	bh=O3GU0ImMOgJ4zCTROn++wcjJOQttinam+xM4irRp15Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDlw8EMWZSKHehtux33F4JtI9Obguuj5g1WwXVbVw81KClntAGAgNdp5qgYIyjJwKsDitT05aI2ub+S2TmPIskAn027KStEhywoICPswixc8Oy407dUMVda++3ogO1Tl8dkLBju6lT/kjL/B3lp0VKK638Mbf7gLMT2pQbjudkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rKUqR04r; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <59c52263-edd2-4585-b4f0-28c8d92d572c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712099652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsDOn4cgXYJbdNcryG8nZVgiiWs/27lyOYNlotPhh28=;
	b=rKUqR04rZPve86OMI/qFw9AtOtWykNdWAVEqV6pgPLJRhJ+catFBQiOu1vcwrbagmOAZv/
	ew0Epa+dO02Cj6qGG+gw7n7m9opvbfUIdWHa50oYUqxASe33q3a3+mjysDun3T4EGoGX11
	8k2HAjNBiuEY5SMSjse2PyrRO45IaQA=
Date: Tue, 2 Apr 2024 16:14:02 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 5/8] selftests/bpf: Factor out load_path and
 defines from test_sock_addr
To: Jordan Rife <jrife@google.com>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
References: <20240329191907.1808635-1-jrife@google.com>
 <20240329191907.1808635-6-jrife@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240329191907.1808635-6-jrife@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/29/24 12:18 PM, Jordan Rife wrote:
> diff --git a/tools/testing/selftests/bpf/sock_addr_helpers.c b/tools/testing/selftests/bpf/sock_addr_helpers.c
> new file mode 100644
> index 0000000000000..ff2eb09870f16
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/sock_addr_helpers.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#include <bpf/bpf.h>
> +#include <bpf/libbpf.h>
> +
> +#include "cgroup_helpers.h"
> +#include "sock_addr_helpers.h"
> +#include "testing_helpers.h"
> +
> +int load_path(const char *path, enum bpf_attach_type attach_type,
> +	      bool expect_reject)
> +{
> +	struct bpf_object *obj;
> +	struct bpf_program *prog;
> +	int err;
> +
> +	obj = bpf_object__open_file(path, NULL);

Although it works, it is heading to the opposite direction by reusing things 
from the older test_sock_addr.c.

test_sock_addr.c should have been moved to the test_progs. It is not run by bpf 
CI and bits get rotten [e.g. the bug fix in patch 8]. There is also old practice 
like bpf_object__open_file() should have been replaced with the skeleton 
__open_and_load() instead of refactoring it out to create new use cases.

The newer prog_tests/sock_addr.c was created when adding AF_UNIX support. It has 
a very similar setup as the older test_sock_addr.c and the intention was to 
finally retire test_sock_addr.c. e.g. It also has "load_fn loadfn" but is done 
with skeleton, the program is also attached to cgroup...etc.

Instead of adding a new sock_addr_kern.c in patch 7, it probably will be easier 
to add the kernel socket tests into the existing prog_tests/sock_addr.c.

Also setup the netns and veth in the prog_tests/sock_addr.c instead of calling 
out the test_sock_addr.sh (which should also go away eventually), there are 
examples in prog_tests/ (e.g. mptcp.c).

> +	err = libbpf_get_error(obj);
> +	if (err) {
> +		log_err(">>> Opening BPF object (%s) error.\n", path);
> +		return -1;
> +	}
> +
> +	prog = bpf_object__next_program(obj, NULL);
> +	if (!prog)
> +		goto err_out;
> +
> +	bpf_program__set_type(prog, BPF_PROG_TYPE_CGROUP_SOCK_ADDR);
> +	bpf_program__set_expected_attach_type(prog, attach_type);
> +	bpf_program__set_flags(prog, testing_prog_flags());
> +
> +	err = bpf_object__load(obj);
> +	if (err) {
> +		if (!expect_reject)
> +			log_err(">>> Loading program (%s) error.\n", path);
> +		goto err_out;
> +	}
> +
> +	return bpf_program__fd(prog);
> +err_out:
> +	bpf_object__close(obj);
> +	return -1;
> +}


