Return-Path: <linux-kselftest+bounces-4891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF74858BDF
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 01:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE2F1C2295D
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 00:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAA63770E;
	Sat, 17 Feb 2024 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ZvI+7UlQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B68037707
	for <linux-kselftest@vger.kernel.org>; Sat, 17 Feb 2024 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129643; cv=none; b=rIfgQ0uwYt6S5kZUtkEaGIYylicjvC667bw/GUeNZYE7FA2RHN9LXjnOr1a7MpudfWqrZZm4gRZg+8MFX/XsD0lJ4ptXb9YRV3SsdWFjEsVO//cowp2MmSWvWdfSvUMzVvMl6SUkkaFRN1FgCcJSRVpUEL5qLS7dZOFS2YLIABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129643; c=relaxed/simple;
	bh=6qi5i2HZdurFWg68hISCVmuDEvRQ7/se82kz2njo5qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KuH21kGf+WaaiNw3P456DWIphjmUdACFgisjibVzS4Siqke4jnCE7jISZKHXHIgnDhH0qxSBMRA4xxAyqfMrSDnOVUKnHDHn7re0bjQ2vVdK8QyCUXwskrOShglkglNRt6mn5tKrBjbPU9I5bIPBqqbBeHRymGXNKNNXH2PI7qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ZvI+7UlQ; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id b2YbrXgnZpUFLb8XyrfxQE; Sat, 17 Feb 2024 00:27:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id b8Xxr2Bp1DuOob8XxriixY; Sat, 17 Feb 2024 00:27:14 +0000
X-Authority-Analysis: v=2.4 cv=UJ1+Hzfy c=1 sm=1 tr=0 ts=65cffd62
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=3_uRt0xjAAAA:8 a=cm27Pg_UAAAA:8 a=hWMQpYRtAAAA:8
 a=FOH2dFAWAAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=yjU-xTemAAAA:8
 a=EU4AEG8cihyboLecn_oA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=z1SuboXgGPGzQ8_2mWib:22 a=xmb-EsYY8bH0VWELuYED:22
 a=KCsI-UfzjElwHeZNREa_:22 a=i3VuKzQdj-NEYjvDI-p3:22 a=SwQY0DHxSCHDbjv2szoi:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wByDJQzTAShm7Gkyw4stFr/KXSxVitihfe54G/dVvfE=; b=ZvI+7UlQ3j/mAJ/+A1JIB2m0jL
	B9lbVrudd/U0viF7X6bD8UkKruJQvjyk+hcvIGQAUNI6MlvbTRREVimfouXeUJRLlvlMFmqpigGrO
	XibCe5LuLxruX6X8A/RZnkqgTnvIiE2JYnjjPul+PWnUHKQe4wNQsRBZlDqZje7xmHSLMagUhxpW/
	NGa18liFeIj8rFEFxmDUJ1sMT1XZMqT7eoaQ8VR0g/DYqB9krGTbUS+1VGgRE3fqV7rukR8ugpMq+
	orHqy9oZN8xnQwysXH6XWC0hJww9hcZP33W6ViBtYVAxCXrZrGqKaJr202Hpjp/CuA7b5aFKjN52h
	pQuh+e3Q==;
Received: from [201.172.172.225] (port=39390 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rb8Xv-002wqL-0B;
	Fri, 16 Feb 2024 18:27:11 -0600
Message-ID: <e58d035c-fb74-4d29-94d5-6c22542e7513@embeddedor.com>
Date: Fri, 16 Feb 2024 18:27:08 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Alexei Starovoitov <ast@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Haowen Bai <baihaowen@meizu.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
 Anton Protopopov <aspsk@isovalent.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240216235536.it.234-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240216235536.it.234-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rb8Xv-002wqL-0B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:39390
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNAu4CIX3QZ6QX0wB7ldAxgeZyHB2oyIFYBkSA7VmKknF6dtrm7hTl8S6wxL3S8QhomK18WDHYbFWHrp7ySjQmf+UmHEPhnCP3nwOFz/IYefwwIh3eZ2
 JpU5e50ZyesbwH1uhXygHh+qMtDsSRlL0d48vUGRO22AInivqdcTtwo2ouj/zcYZK5R0Fi28hRpEenPDRSnzfSMWXxndeAceQvNVEk6KsqCn1AlPJpgwRdMF



On 2/16/24 17:55, Kees Cook wrote:
> Replace deprecated 0-length array in struct bpf_lpm_trie_key with
> flexible array. Found with GCC 13:
> 
> ../kernel/bpf/lpm_trie.c:207:51: warning: array subscript i is outside array bounds of 'const __u8[0]' {aka 'const unsigned char[]'} [-Warray-bounds=]
>    207 |                                        *(__be16 *)&key->data[i]);
>        |                                                   ^~~~~~~~~~~~~
> ../include/uapi/linux/swab.h:102:54: note: in definition of macro '__swab16'
>    102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>        |                                                      ^
> ../include/linux/byteorder/generic.h:97:21: note: in expansion of macro '__be16_to_cpu'
>     97 | #define be16_to_cpu __be16_to_cpu
>        |                     ^~~~~~~~~~~~~
> ../kernel/bpf/lpm_trie.c:206:28: note: in expansion of macro 'be16_to_cpu'
>    206 |                 u16 diff = be16_to_cpu(*(__be16 *)&node->data[i]
> ^
>        |                            ^~~~~~~~~~~
> In file included from ../include/linux/bpf.h:7:
> ../include/uapi/linux/bpf.h:82:17: note: while referencing 'data'
>     82 |         __u8    data[0];        /* Arbitrary size */
>        |                 ^~~~
> 
> And found at run-time under CONFIG_FORTIFY_SOURCE:
> 
>    UBSAN: array-index-out-of-bounds in kernel/bpf/lpm_trie.c:218:49
>    index 0 is out of range for type '__u8 [*]'
> 
> This includes fixing the selftest which was incorrectly using a
> variable length struct as a header, identified earlier[1]. Avoid this
> by just explicitly including the prefixlen member instead of struct
> bpf_lpm_trie_key.
> 
> Note that it is not possible to simply remove the "data" member, as it
> is referenced by userspace
> 
> cilium:
>          struct egress_gw_policy_key in_key = {
>                  .lpm_key = { 32 + 24, {} },
>                  .saddr   = CLIENT_IP,
>                  .daddr   = EXTERNAL_SVC_IP & 0Xffffff,
>          };
> 
> systemd:
> 	ipv6_map_fd = bpf_map_new(
> 			BPF_MAP_TYPE_LPM_TRIE,
> 			offsetof(struct bpf_lpm_trie_key, data) + sizeof(uint32_t)*4,
> 			sizeof(uint64_t),
> 			...
> 
> The only risk to UAPI would be if sizeof() were used directly on the
> data member, which it does not seem to be. It is only used as a static
> initializer destination and to find its location via offsetof().
> 
> Link: https://lore.kernel.org/all/202206281009.4332AA33@keescook/ [1]
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Closes: https://paste.debian.net/hidden/ca500597/

mmh... this URL expires: 2024-05-15

> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mykola Lysenko <mykolal@fb.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Haowen Bai <baihaowen@meizu.com>
> Cc: bpf@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> 
> v2- clarify commit log, add more failure examples
> v1- https://lore.kernel.org/all/63e531e3.170a0220.3a46a.3262@mx.google.com/
> ---
>   include/uapi/linux/bpf.h                         | 2 +-
>   tools/testing/selftests/bpf/progs/map_ptr_kern.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 754e68ca8744..359dd8a429c1 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -80,7 +80,7 @@ struct bpf_insn {
>   /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
>   struct bpf_lpm_trie_key {
>   	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
> -	__u8	data[0];	/* Arbitrary size */
> +	__u8	data[];		/* Arbitrary size */
>   };
>   
>   struct bpf_cgroup_storage_key {
> diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> index 3325da17ec81..1d476c6ae284 100644
> --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> @@ -316,7 +316,7 @@ struct lpm_trie {
>   } __attribute__((preserve_access_index));
>   
>   struct lpm_key {
> -	struct bpf_lpm_trie_key trie_key;
> +	__u32 prefixlen;
>   	__u32 data;
>   };
>   

