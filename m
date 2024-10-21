Return-Path: <linux-kselftest+bounces-20324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9169A9208
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 23:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBE51C21E25
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 21:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB41E231B;
	Mon, 21 Oct 2024 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RMCqk/iT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D11E2313
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729546086; cv=none; b=m4LUIJi3RKDzumSf2I8ITi1ZMJCK9436Y3RbRbrNJVJqilOvY7pEiHSMYDGCibevkHzFlI/itEIUqIZhom9kQRdBlPSnIfysTYBrdo4yBLCAYlN0XuU/LUiZlkVgoYRe1zYFI5Fci8zYhvCVKtElTyyX6wMVvHms6nEE98+Hwq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729546086; c=relaxed/simple;
	bh=Ezkb7V5yDBL10B/MghUyv8s418fW11sQrXwFD5XtniY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5u1CWYf/FYAVjf6bVmS5Q+d5C3j5v6oU0GLfLhYGWabEE+bfPMD89mt9/OuRci8q8eiBMyLoUplJ5GDn9wOPqyFFXyvJk7K9IHm1xHUtVn9KYw/Y+u9oKxzILPRFqQst2btuGIayI0gfoz8YW3n9STSd+ZHWtollxWBkcAS0gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RMCqk/iT; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fb910573-41d8-47b5-8ab9-ecbc8df7a56b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729546079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qg9sfkG14X0Ob3YRJZL5hxNGFFr1KSlczKqvms3yYbM=;
	b=RMCqk/iTsXzth7yss61lk6PCXnYH+QJu8WFAwiQrlaVCE2CLbWuWFP1MgZnBTkbiBwvfvP
	b2PcXMmAggLe5esO+viMj8IbPSF3XZbK8+rxq1NCxzlDOpGarrFJxv8RIVOkiUAOLDAWUr
	14a66/5+rqpDT1JgNpe2v/3+js3WpVI=
Date: Mon, 21 Oct 2024 14:27:48 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/4] selftests/bpf: Migrate *_POST_BIND test
 cases to prog_tests
To: Jordan Rife <jrife@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 "Daniel T. Lee" <danieltimlee@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241017225031.2448426-1-jrife@google.com>
 <20241017225031.2448426-2-jrife@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241017225031.2448426-2-jrife@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/17/24 3:49 PM, Jordan Rife wrote:
> Move all BPF_CGROUP_INET6_POST_BIND and BPF_CGROUP_INET4_POST_BIND test
> cases to a new prog_test, prog_tests/sock_post_bind.c, except for
> LOAD_REJECT test cases.
> 
> Signed-off-by: Jordan Rife <jrife@google.com>
> ---
>   .../selftests/bpf/prog_tests/sock_post_bind.c | 417 ++++++++++++++++++
>   tools/testing/selftests/bpf/test_sock.c       | 245 ----------
>   2 files changed, 417 insertions(+), 245 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_post_bind.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_post_bind.c b/tools/testing/selftests/bpf/prog_tests/sock_post_bind.c
> new file mode 100644
> index 000000000000..c46537e3b9d4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_post_bind.c
> @@ -0,0 +1,417 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <test_progs.h>
> +#include "cgroup_helpers.h"
> +
> +static char bpf_log_buf[4096];
> +static bool verbose;

How is verbose used and is it still needed?

[ ... ]

> +	if (bind(sockfd, (const struct sockaddr *)&addr, len) == -1) {
> +		/* sys_bind() may fail for different reasons, errno has to be
> +		 * checked to confirm that BPF program rejected it.
> +		 */
> +		if (errno != EPERM)
> +			goto err;
> +		if (port_retry)
> +			goto retry;
> +		res = BIND_REJECT;
> +		goto out;
> +	}

[ ... ]

> +void test_sock_post_bind(void)
> +{
> +	int cgroup_fd, i;
> +
> +	cgroup_fd = test__join_cgroup("/post_bind");
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))

nit. ASSERT_OK_FD().

Since the test binds to a specific ip/port, please run it in its own netns. It 
is easy to do with netns_new and netns_free, a recent example:

https://lore.kernel.org/bpf/20241020-syncookie-v2-1-2db240225fed@bootlin.com/

The same netns can be reused for different subtests of this "sock_post_bind" test.

Others look good. Thanks for moving the test to test_progs.

pw-bot: cr


