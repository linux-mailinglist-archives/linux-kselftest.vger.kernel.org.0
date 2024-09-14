Return-Path: <linux-kselftest+bounces-17968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2EA978C0D
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 02:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A147B247BA
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 00:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26DC7FD;
	Sat, 14 Sep 2024 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wI2qoVS3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC55138E
	for <linux-kselftest@vger.kernel.org>; Sat, 14 Sep 2024 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726272692; cv=none; b=X9jg7iZGh3PuO7dMUtsisuxqnW/aHnVLdABcuYNj0eBEJ5/GdT2o5cWOkBU110lH4JuF7jznO+Ukj3uSomsiYdTa63J1rSYbFIWAuF2LjKeyHWZnt3+SUQZ3z/jK23Ibxm/6DFv4qhEgZgJOQVdrOjpvCdrxraaLbJxNjqRZ4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726272692; c=relaxed/simple;
	bh=k6AXiUShqFWnxWyumWyKNaJ9AtMfMG21fL87GVsnwjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUiUqEqNCxw9SPHzNbk56kMvEoH5A9jjpwuFpOy+OK7xkofyA4ET2rvD3SOFpO5TvgKNCqHMARekQMvGUae6uEu+/nJZLeNU9i21dfi2Lmv31sNgfVSXZYk72BGNUJ2cfS9uwd5uB1ZpDn7GY2nskZOtwZFx/wUBnjHL/A7zveI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wI2qoVS3; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <07c19c1a-a526-4307-be44-5abb312cc6d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726272687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=alJRYqj31UINifc+9zDFA1uwYd1fHAfT9abqylFnCv0=;
	b=wI2qoVS3horHkaIWfNWXFpS4fT0pUSGPNSNprNYeuMy/M8wezSxElBzI8+aDikwS+cLPCi
	QAo7N7m7k1gEvJJjt+SnSL5dKTQqjkx6H+mZ+rBKQXi/hRm0Djbv4kg0nRqJxm2VcPM9qM
	RoiQyyifYZRJeZ/SjnSnbi8d9quBwNc=
Date: Fri, 13 Sep 2024 17:11:17 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net v6 2/3] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240911-upstream-bpf-next-20240506-mptcp-subflow-test-v6-0-7872294c466b@kernel.org>
 <20240911-upstream-bpf-next-20240506-mptcp-subflow-test-v6-2-7872294c466b@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240911-upstream-bpf-next-20240506-mptcp-subflow-test-v6-2-7872294c466b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/11/24 8:16 AM, Matthieu Baerts (NGI0) wrote:
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> new file mode 100644
> index 000000000000..179b74c1205f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +#ifndef __MPTCP_BPF_H__
> +#define __MPTCP_BPF_H__
> +
> +#include "bpf_experimental.h"
> +
> +/* list helpers from include/linux/list.h */
> +static inline int list_is_head(const struct list_head *list,
> +			       const struct list_head *head)
> +{
> +	return list == head;
> +}
> +
> +#define list_entry(ptr, type, member)					\
> +	container_of(ptr, type, member)
> +
> +#define list_first_entry(ptr, type, member)				\
> +	list_entry((ptr)->next, type, member)
> +
> +#define list_next_entry(pos, member)					\
> +	list_entry((pos)->member.next, typeof(*(pos)), member)
> +
> +#define list_entry_is_head(pos, head, member)				\
> +	list_is_head(&pos->member, (head))
> +
> +/* small difference: 'cond_break' has been added in the conditions */
> +#define list_for_each_entry(pos, head, member)				\
> +	for (pos = list_first_entry(head, typeof(*pos), member);	\
> +	     cond_break, !list_entry_is_head(pos, head, member);	\

It probably should use can_loop.
See commit ba39486d2c43 ("bpf: make list_for_each_entry portable")


