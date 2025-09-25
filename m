Return-Path: <linux-kselftest+bounces-42316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28E4B9F0CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 13:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8F6384741
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 11:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA032FC027;
	Thu, 25 Sep 2025 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="lO9k8AfL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7C25B67D;
	Thu, 25 Sep 2025 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801543; cv=none; b=mIF55fjHFjCY2yFyXtEzJPO8CE6TX/8iHaSr81VHp/GCSsYMJOr2Xa95gs6Sna+kCa3xZ4gjhR8LqUhTou9rWdh3rIZWDXY2TB7dsw+0KyqObX3VdFt8kImWVdk7f0NxLARvOAOYqBuRWD4C/wjIzN/hWY1RiPECn/aCmqZFRKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801543; c=relaxed/simple;
	bh=+IY2OXXnsRKbkGAIpo4vaVP6VC/er3FaJDr3rMxY6QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMvg+XHNM8FcklpuSJ8oOmCns8nGjjuDh7EKcifzJDwLiqsl39Eo37JX8cfgjzFRFiGvf+jkgHwqicHjCLOHg4SmxTPECPoKHpGPS6wj2CftmDUAV0amHCw2c5FNUgR8wwIDTgyMYYuMRYJmcTOYSJcsDVRHbAfPARbcvFcg67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=lO9k8AfL; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/1G5FUDQpvZvuASdzQAKejgHTSFRJSHzx2wHymQgnpA=; b=lO9k8AfLGlZrBE2HyV1pQtekmf
	s/tGoCLfQi2HkmQX5fwM/N2UaaXYnIVqwzWi4Co9VA2pU6G/q81Qkp9SUV835YkljwvcLOGsng4+G
	OVCLDKRLG5W2OtDRKnXOD+Tld9KPwKXXjCLZkcQpPTJSnp+8IdK8yS0GscZcH2ARxglAuZthsenff
	TZ6HOW61qfz20F89bGipaW6+XZ2QIm5d/xl5JkSslv/CWbsPy1pvDj62FTM6gVCD2lv1idNmsXJx5
	ty+NThmAgXFIY7GQLR3EYuKdmn436FLRhZDYO+nsb3Qgo3RdUy8ofmoZikdpStqY2P50WtotTwe+W
	G8LHcp9w==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v1kcW-000MhS-1u;
	Thu, 25 Sep 2025 13:58:44 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1v1kcU-000ICJ-1m;
	Thu, 25 Sep 2025 13:58:42 +0200
Message-ID: <b05e5979-2c62-4de5-ba29-e3b9e9167da8@iogearbox.net>
Date: Thu, 25 Sep 2025 13:58:41 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Add -Wsign-compare C
 compilation flag
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
References: <20250924195731.6374-1-mehdi.benhadjkhelifa@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20250924195731.6374-1-mehdi.benhadjkhelifa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27773/Thu Sep 25 10:27:35 2025)

On 9/24/25 9:57 PM, Mehdi Ben Hadj Khelifa wrote:
> -Change all the source files and the corresponding headers
> to having matching sign comparisons.
> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
> Changelog:
> 
> Changes since v1:
> - Fix CI failed builds where it failed due to do missing .c and
> .h files in my patch for working in mainline.
> https://lore.kernel.org/bpf/20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com/T/#u
> ---
>   tools/lib/bpf/usdt.bpf.h                         |  4 ++--
>   tools/testing/selftests/bpf/Makefile             |  4 ++--
>   tools/testing/selftests/bpf/bpf_arena_htab.h     |  2 +-
>   tools/testing/selftests/bpf/progs/arena_list.c   |  2 +-
>   .../bpf/progs/bench_local_storage_create.c       |  2 +-
>   tools/testing/selftests/bpf/progs/bind_perm.c    |  2 +-
>   tools/testing/selftests/bpf/progs/bpf_cc_cubic.c |  2 +-
>   tools/testing/selftests/bpf/progs/bpf_cubic.c    |  8 ++++----
>   .../bpf/progs/bpf_iter_bpf_percpu_array_map.c    |  2 +-
>   .../selftests/bpf/progs/bpf_iter_task_stack.c    |  2 +-
>   .../testing/selftests/bpf/progs/bpf_iter_tasks.c |  3 ++-
>   .../selftests/bpf/progs/bpf_iter_vma_offset.c    |  4 ++--
>   .../testing/selftests/bpf/progs/bpf_qdisc_fifo.c |  2 +-
>   tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c |  4 ++--
>   .../bpf/progs/cgroup_getset_retval_getsockopt.c  |  6 +++---
>   .../selftests/bpf/progs/connect4_dropper.c       |  2 +-
>   .../selftests/bpf/progs/cpumask_success.c        |  4 ++--
>   .../testing/selftests/bpf/progs/dynptr_success.c |  8 ++++----
>   tools/testing/selftests/bpf/progs/iters.c        | 16 ++++++++--------
>   .../selftests/bpf/progs/kfunc_call_test.c        |  2 +-
>   tools/testing/selftests/bpf/progs/linked_list.c  | 10 +++++-----
>   tools/testing/selftests/bpf/progs/lsm.c          |  2 +-
>   .../testing/selftests/bpf/progs/map_in_map_btf.c |  2 +-
>   tools/testing/selftests/bpf/progs/map_ptr_kern.c |  2 +-
>   .../selftests/bpf/progs/mmap_inner_array.c       |  2 +-
>   .../testing/selftests/bpf/progs/mptcp_subflow.c  |  2 +-
>   .../selftests/bpf/progs/netif_receive_skb.c      |  4 ++--
>   tools/testing/selftests/bpf/progs/profiler.inc.h |  6 +++---
>   .../testing/selftests/bpf/progs/rcu_read_lock.c  |  4 ++--
>   .../bpf/progs/sk_storage_omem_uncharge.c         |  6 +++---
>   .../selftests/bpf/progs/sockopt_inherit.c        |  4 ++--
>   tools/testing/selftests/bpf/progs/sockopt_sk.c   |  4 ++--
>   tools/testing/selftests/bpf/progs/strobemeta.h   |  2 +-
>   .../selftests/bpf/progs/task_local_data.bpf.h    |  6 +++---
>   .../selftests/bpf/progs/test_bpf_cookie.c        |  2 +-
>   .../testing/selftests/bpf/progs/test_check_mtu.c |  4 ++--
>   .../selftests/bpf/progs/test_core_extern.c       |  2 +-
>   .../testing/selftests/bpf/progs/test_get_xattr.c |  4 ++--
>   .../selftests/bpf/progs/test_global_func11.c     |  2 +-
>   .../selftests/bpf/progs/test_global_func12.c     |  2 +-
>   .../selftests/bpf/progs/test_global_func13.c     |  2 +-
>   .../selftests/bpf/progs/test_global_func14.c     |  2 +-
>   .../selftests/bpf/progs/test_global_func9.c      |  2 +-
>   .../selftests/bpf/progs/test_lwt_seg6local.c     |  4 ++--
>   .../testing/selftests/bpf/progs/test_map_init.c  |  2 +-
>   .../selftests/bpf/progs/test_parse_tcp_hdr_opt.c |  2 +-
>   .../bpf/progs/test_parse_tcp_hdr_opt_dynptr.c    |  2 +-
>   .../selftests/bpf/progs/test_pkt_access.c        |  6 +++---
>   .../testing/selftests/bpf/progs/test_seg6_loop.c |  4 ++--
>   tools/testing/selftests/bpf/progs/test_skb_ctx.c |  2 +-
>   .../testing/selftests/bpf/progs/test_snprintf.c  |  2 +-
>   .../selftests/bpf/progs/test_sockmap_kern.h      |  2 +-
>   .../selftests/bpf/progs/test_sockmap_strp.c      |  2 +-
>   .../testing/selftests/bpf/progs/test_tc_tunnel.c |  2 +-
>   tools/testing/selftests/bpf/progs/test_xdp.c     |  2 +-
>   .../selftests/bpf/progs/test_xdp_dynptr.c        |  2 +-
>   .../testing/selftests/bpf/progs/test_xdp_loop.c  |  2 +-
>   .../selftests/bpf/progs/test_xdp_noinline.c      |  4 ++--
>   tools/testing/selftests/bpf/progs/udp_limit.c    |  2 +-
>   tools/testing/selftests/bpf/progs/uprobe_multi.c |  4 ++--
>   .../bpf/progs/uprobe_multi_session_recursive.c   |  5 +++--
>   .../selftests/bpf/progs/verifier_arena_large.c   |  4 ++--
>   .../bpf/progs/verifier_iterating_callbacks.c     |  2 +-
>   63 files changed, 109 insertions(+), 107 deletions(-)

Big churn all over the place :/ Either way, it looks like you haven't run
the tests locally before submitting, some are failing:

https://github.com/kernel-patches/bpf/actions/runs/17993782331

