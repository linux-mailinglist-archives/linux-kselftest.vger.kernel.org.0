Return-Path: <linux-kselftest+bounces-30600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 276BFA85E4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 15:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A333A798F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7106D29CE1;
	Fri, 11 Apr 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WBTw0Qfn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354BC2367A7;
	Fri, 11 Apr 2025 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376877; cv=none; b=MyjHinhaGqBUqAj3Vo+c8DdvCL+k4FZ7EFlb0cmhyQdswp4LzXVFyUAbTFrt4iksxt3nxluV9cZzLOsEFQY6+dKiIfGZsUcnFgIUSXkJhSN8mgl6NkfzL1AbHdUjo/V+z2KLsJDVWxckaUjI5+5KPwLpUciCrMXcxjRay4Gt334=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376877; c=relaxed/simple;
	bh=I8a9dN6aHQZms/YtghSSJ1hw1q/pOboZ1oI3gg8yojA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWceN87XBmUlE36cgX3gvBiZ2YjLOSr3opdDKxe+SUWhVIFnUy1JpNd1+XncHAxfT1rfUlR19BnDs4Dgsnf8rGTEqXCdXqxNsh9XAglgPbOXQU29ubGnNlRC2mO9KFRYa5+9KdKVMFeqzm0lMwbstJ7P0jGAtpnj9mf+AAUk8hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WBTw0Qfn; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=lyZXs2Zi6ekjJ4FW1SSFkba/dKS2ypdHY1EDXydc9FY=;
	b=WBTw0QfnbMMZ5lGVGzxWAKb6PenYP1x8fkL2XRfhbE5DseqQ2A8jmcACuffw2a
	KWe0OO/sZ0UcO6XF7fmbU0ynBLC9sV1XW2LoCw25b0c9L6s5k2MKqe8lSPi8Ol4O
	309F2KhpoJVXGzulzJHcm9COUBJjV5XY3PsX/DYKa/WDo=
Received: from iZj6c3ewsy61ybpk7hrb16Z (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC3t1nPE_lncFMNFg--.46424S2;
	Fri, 11 Apr 2025 21:06:26 +0800 (CST)
Date: Fri, 11 Apr 2025 21:06:23 +0800
From: Jiayuan Chen <mrpre@163.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 0/9] selftests/bpf: Test sockmap/sockhash
 redirection
Message-ID: <sgdbbkc2nzbnvkchrs23nss4c7cohebn2qwbfdxtyupbmxunqu@afosvfyylrdg>
References: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
X-CM-TRANSID:_____wC3t1nPE_lncFMNFg--.46424S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF47tF1DAr43tw18tF4DCFg_yoW5Xr1fpa
	93A3W3KFWxJFWIgw43WFWI9F4rKF48Jw15G3Wjgw1rZwnFkryxtr1Sg3yrW3Z8JrW5ZF15
	u3y7KF93Gw1UCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcTmhUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWxcsp2f5DlK-YAAAsa

On Fri, Apr 11, 2025 at 01:32:36PM +0200, Michal Luczaj wrote:
> The idea behind this series is to comprehensively test the BPF redirection:
> 
> BPF_MAP_TYPE_SOCKMAP,
> BPF_MAP_TYPE_SOCKHASH
> 	x
> sk_msg-to-egress,
> sk_msg-to-ingress,
> sk_skb-to-egress,
> sk_skb-to-ingress
> 	x
> AF_INET, SOCK_STREAM,
> AF_INET6, SOCK_STREAM,
> AF_INET, SOCK_DGRAM,
> AF_INET6, SOCK_DGRAM,
> AF_UNIX, SOCK_STREAM,
> AF_UNIX, SOCK_DGRAM,
> AF_VSOCK, SOCK_STREAM,
> AF_VSOCK, SOCK_SEQPACKET
> 
> New module is introduced, sockmap_redir: all supported and unsupported
> redirect combinations are tested for success and failure respectively. Code
> is pretty much stolen/adapted from Jakub Sitnicki's sockmap_redir_matrix.c
> [1].
> 
> Usage:
> $ cd tools/testing/selftests/bpf
> $ make
> $ sudo ./test_progs -t sockmap_redir
> ...
> Summary: 1/576 PASSED, 0 SKIPPED, 0 FAILED
> 
> [1]: https://github.com/jsitnicki/sockmap-redir-matrix/blob/main/sockmap_redir_matrix.c

This is exactly what we need, thanks.
> 
> Changes in v2:
> - Verify that the unsupported redirect combos do fail [Jakub]
> - Dedup tests in sockmap_listen
> - Cosmetic changes and code reordering
> - Link to v1: https://lore.kernel.org/bpf/42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co/
> 
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Michal Luczaj (9):
>       selftests/bpf: Support af_unix SOCK_DGRAM socket pair creation
>       selftests/bpf: Add socket_kind_to_str() to socket_helpers
>       selftests/bpf: Add u32()/u64() to sockmap_helpers
>       selftests/bpf: Allow setting BPF_F_INGRESS in prog_msg_verdict()
>       selftests/bpf: Add selftest for sockmap/hashmap redirection
>       selftests/bpf: sockmap_listen cleanup: Drop af_vsock redir tests
>       selftests/bpf: sockmap_listen cleanup: Drop af_unix redir tests
>       selftests/bpf: sockmap_listen cleanup: Drop af_inet SOCK_DGRAM redir tests
>       docs/bpf: sockmap: Add a missing comma
> 
>  Documentation/bpf/map_sockmap.rst                  |   2 +-
>  .../selftests/bpf/prog_tests/socket_helpers.h      |  84 +++-
>  .../selftests/bpf/prog_tests/sockmap_helpers.h     |  25 +-
>  .../selftests/bpf/prog_tests/sockmap_listen.c      | 459 +-------------------
>  .../selftests/bpf/prog_tests/sockmap_redir.c       | 461 +++++++++++++++++++++
>  .../selftests/bpf/progs/test_sockmap_listen.c      |   6 +-
>  6 files changed, 558 insertions(+), 479 deletions(-)
> ---
> base-commit: a27a97f713947b20ba91b23a3ef77fa92d74171b
> change-id: 20240922-selftests-sockmap-redir-5d839396c75e
> 
> Best regards,
> -- 
> Michal Luczaj <mhal@rbox.co>
> 


