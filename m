Return-Path: <linux-kselftest+bounces-42353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A1EBA0292
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645064E7B4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 15:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8E73126DA;
	Thu, 25 Sep 2025 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="rGKfUvhS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2E311C1E;
	Thu, 25 Sep 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812703; cv=none; b=Ot5dpMaCgVdW2ZhxzxqyJqLD3T/cpid+SHoD/zK5HvNeaht5unGFXf4IAYbcjfaEJe/hozA3jzigCPntJYyikZnFVI9lWcEwcDIjM7neajJAzC2PkmdRuD4KP0CBaMHeaWO7Hj2JyDlhZ5jiKe6X1yUX9AGKLjngr7U1E9+3Td4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812703; c=relaxed/simple;
	bh=ZUmA5g3BZdtkkQzAyxPcPgH/CExuKMSZgLOzO2vj6sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxV7JZRMBHsUM1OdSTEwr0mNJRlZv8qKFVFI2SfzxIfq/n25Xn5/n63kQxupWHMHlsElPLnnpRPijvi1nig49ECO7U2eu15VkxryWDhCe/MJii9MhQDENYRAjP3Din0elzd0MDoqmJTEOjbFtVBGyagMUDNbhXeeCZwz4gfVCak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=rGKfUvhS; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=qLwM3MlL3IIwt9UZSY1QYh/F3mEc/jCvsT/k+vTJVdE=; b=rGKfUvhSKTl+tneE8WdOVj2THv
	32mR6pFYzq6Ce/cYz+bzMSBJiU/M4X5clHaxw1O2/SECLxCBtgSYOcvTK+BDWSJBhNVJUcLxleFr6
	wBRocnBf+SdpO/2EHWlkkQdsh+nUkQ2kQbvfVZjaoavzTqRSW9S5A7GwzcT1JEeeAZr5JAonS4vo/
	LyV5Pdk7m8zn0ONtJeKhUGE0LF7mBoC/WpzriDLj7J2oyP9U2b+yMpFhAcnR40Zl+Kd/9TYfdZ2w5
	VUAgetqetQMf49l/gK+lyi1mvHsQ0ZCAzEXsKKwDLv8NACVWJ4hgDAuWLOSdr9WyVA9fKCZezQaNL
	Gx839A9Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v1nWc-00033c-0x;
	Thu, 25 Sep 2025 17:04:50 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1v1nWZ-000Cz3-0f;
	Thu, 25 Sep 2025 17:04:48 +0200
Message-ID: <5ad26663-a3cc-4bf4-9d6f-8213ac8e8ce6@iogearbox.net>
Date: Thu, 25 Sep 2025 17:04:46 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests/bpf: Prepare to add -Wsign-compare for
 bpf tests
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 linux@jordanrome.com, ameryhung@gmail.com, toke@redhat.com,
 houtao1@huawei.com, emil@etsalapatis.com, yatsenko@meta.com,
 isolodrai@meta.com, a.s.protopopov@gmail.com, dxu@dxuuu.xyz,
 memxor@gmail.com, vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org,
 gregkh@linuxfoundation.org, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
 mrpre@163.com, jakub@cloudflare.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel-mentees@lists.linuxfoundation.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com
References: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
 <20250925103559.14876-4-mehdi.benhadjkhelifa@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20250925103559.14876-4-mehdi.benhadjkhelifa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27773/Thu Sep 25 10:27:35 2025)

On 9/25/25 12:35 PM, Mehdi Ben Hadj Khelifa wrote:
> -Change only variable types for correct sign comparisons
> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>

Pls write some better commit messages and not just copy/paste the same $subj/
message every time; proper sentences w/o the weird " -" indent. Also say why
this is needed in the commit message, and add a reference to the commit which
initially added this as a TODO, i.e. 495d2d8133fd ("selftests/bpf: Attempt to
build BPF programs with -Wsign-compare"). If you group these, then maybe also
include the parts of the compiler-emitted warnings during build which are
relevant to the code changes you do here.

> ---
>   tools/testing/selftests/bpf/progs/test_xdp_dynptr.c          | 2 +-
>   tools/testing/selftests/bpf/progs/test_xdp_loop.c            | 2 +-
>   tools/testing/selftests/bpf/progs/test_xdp_noinline.c        | 4 ++--
>   tools/testing/selftests/bpf/progs/uprobe_multi.c             | 4 ++--
>   .../selftests/bpf/progs/uprobe_multi_session_recursive.c     | 5 +++--
>   .../selftests/bpf/progs/verifier_iterating_callbacks.c       | 2 +-
>   6 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
> index 67a77944ef29..12ad0ec91021 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
> @@ -89,7 +89,7 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp, struct bpf_dynptr *xd
>   	struct vip vip = {};
>   	int dport;
>   	__u32 csum = 0;
> -	int i;
> +	size_t i;
>   
>   	__builtin_memset(eth_buffer, 0, sizeof(eth_buffer));
>   	__builtin_memset(iph_buffer_tcp, 0, sizeof(iph_buffer_tcp));
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_loop.c b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
> index 93267a68825b..e9b7bbff5c23 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_loop.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
> @@ -85,7 +85,7 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
>   	struct vip vip = {};
>   	int dport;
>   	__u32 csum = 0;
> -	int i;
> +	size_t i;
>   
>   	if (iph + 1 > data_end)
>   		return XDP_DROP;
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> index fad94e41cef9..85ef3c0a3e20 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> @@ -372,7 +372,7 @@ bool encap_v4(struct xdp_md *xdp, struct ctl_value *cval,
>   
>   	next_iph_u16 = (__u16 *) iph;
>   	__pragma_loop_unroll_full
> -	for (int i = 0; i < sizeof(struct iphdr) >> 1; i++)
> +	for (size_t i = 0; i < sizeof(struct iphdr) >> 1; i++)
>   		csum += *next_iph_u16++;
>   	iph->check = ~((csum & 0xffff) + (csum >> 16));
>   	if (bpf_xdp_adjust_head(xdp, (int)sizeof(struct iphdr)))
> @@ -423,7 +423,7 @@ int send_icmp_reply(void *data, void *data_end)
>   	iph->check = 0;
>   	next_iph_u16 = (__u16 *) iph;
>   	__pragma_loop_unroll_full
> -	for (int i = 0; i < sizeof(struct iphdr) >> 1; i++)
> +	for (size_t i = 0; i < sizeof(struct iphdr) >> 1; i++)
>   		csum += *next_iph_u16++;
>   	iph->check = ~((csum & 0xffff) + (csum >> 16));
>   	return swap_mac_and_send(data, data_end);
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
> index 44190efcdba2..f99957773c3a 100644
> --- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
> +++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
> @@ -20,13 +20,13 @@ __u64 uretprobe_multi_func_3_result = 0;
>   
>   __u64 uprobe_multi_sleep_result = 0;
>   
> -int pid = 0;
> +__u32 pid = 0;
>   int child_pid = 0;
>   int child_tid = 0;
>   int child_pid_usdt = 0;
>   int child_tid_usdt = 0;
>   
> -int expect_pid = 0;
> +__u32 expect_pid = 0;
>   bool bad_pid_seen = false;
>   bool bad_pid_seen_usdt = false;
>   
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
> index 8fbcd69fae22..017f1859ebe8 100644
> --- a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
> +++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
> @@ -3,6 +3,7 @@
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_tracing.h>
>   #include <stdbool.h>
> +#include <stddef.h>
>   #include "bpf_kfuncs.h"
>   #include "bpf_misc.h"
>   
> @@ -10,8 +11,8 @@ char _license[] SEC("license") = "GPL";
>   
>   int pid = 0;
>   
> -int idx_entry = 0;
> -int idx_return = 0;
> +size_t idx_entry = 0;
> +size_t idx_return = 0;
>   
>   __u64 test_uprobe_cookie_entry[6];
>   __u64 test_uprobe_cookie_return[3];
> diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> index 75dd922e4e9f..72f9f8c23c93 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> @@ -593,7 +593,7 @@ int loop_inside_iter_volatile_limit(const void *ctx)
>   {
>   	struct bpf_iter_num it;
>   	int *v, sum = 0;
> -	__u64 i = 0;
> +	__s32 i = 0;
>   
>   	bpf_iter_num_new(&it, 0, ARR2_SZ);
>   	while ((v = bpf_iter_num_next(&it))) {


