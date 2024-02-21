Return-Path: <linux-kselftest+bounces-5200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9370785E385
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADBC1C21BC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3858A82D9F;
	Wed, 21 Feb 2024 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="nxtdSMGu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8636E1C20;
	Wed, 21 Feb 2024 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533631; cv=none; b=RNCWtSRif23ZoZTN/nzgxHWUVMF2SC7dCdohrXb7SXUuwdilFhb9cRepdaGgF1k2wHw4vy2IIRGBHIMXO6F0iZov1S61WasAo4sawDAUMr0RG5ZoLhlo0u88GpeUr5R19VW+3oRSEueP0VHQLn3lqmBuNjaMIdZdRROIlCegLh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533631; c=relaxed/simple;
	bh=45I0J5biXwYLiUaf/PmqF1jvW/5x55RLPKwzjIKpH4I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cv1d4b7OiKxi8I++gZCzaLjaVyNnVOiHssqAUoJZSw8KH0AqrrY4AX+rpZvd+WMvVOspuyottxqI8e8lLaOwdnFFyhFsHtcMqQe0Nn0wBM94lFZ4sKnqt0d7YNK4bdDzNVjjkwb3F2m4TSQtpUwoZyHyXMY6fevY5zccHkuR/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=nxtdSMGu; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=iE/w7zcXxXdaU9PL76g2DzI65P5Qvx6HEpMubn6cjls=; b=nxtdSMGuBsIvBlcGsFV4q/QyMF
	TgOVPrStsVJMCkxFJBEqMlQSHAzM+REezZFM0xOLRHPRXVSajD7AuVxjN89Gx8zV8VfQaROCuWJ9A
	hsKvkN0wOOFwEAN6pFc8y73S6NAYPyvKNlCWQfSndtOWsQDCCadb/MAydty5bhz/Zq3BFJxoh0CIR
	a2Ne48t1iTcE2roNaY1NWfiRbYJf8DdWNP79eI3L97P88sN1qdZL9NnF8z2INf8oE+Saj3QB2dpB0
	ENlP8JXP2KoHERxkPQL1sRIBscnF0jK0so1z2Qi3PdIX6N417a9CoXAIjTLRVkK9YA2p0bewcxPbd
	9aLoNtDA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcpdW-0007PB-Iw; Wed, 21 Feb 2024 17:39:58 +0100
Received: from [178.197.249.13] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcpdU-0005ll-2a;
	Wed, 21 Feb 2024 17:39:56 +0100
Subject: Re: [PATCH v4] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
To: Kees Cook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Haowen Bai <baihaowen@meizu.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>, Yafang Shao <laoar.shao@gmail.com>,
 Kui-Feng Lee <kuifeng@meta.com>, Anton Protopopov <aspsk@isovalent.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240220185421.it.949-kees@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <da75b2bf-0d14-6ed5-91c2-dfeba9ad55c4@iogearbox.net>
Date: Wed, 21 Feb 2024 17:39:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240220185421.it.949-kees@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27192/Wed Feb 21 10:23:23 2024)

On 2/20/24 7:54 PM, Kees Cook wrote:
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
> Changing struct bpf_lpm_trie_key is difficult since has been used by
> userspace. For example, in Cilium:
> 
> 	struct egress_gw_policy_key {
> 	        struct bpf_lpm_trie_key lpm_key;
> 	        __u32 saddr;
> 	        __u32 daddr;
> 	};
> 
> While direct references to the "data" member haven't been found, there
> are static initializers what include the final member. For example,
> the "{}" here:
> 
>          struct egress_gw_policy_key in_key = {
>                  .lpm_key = { 32 + 24, {} },
>                  .saddr   = CLIENT_IP,
>                  .daddr   = EXTERNAL_SVC_IP & 0Xffffff,
>          };
> 
> To avoid the build time and run time warnings seen with a 0-sized
> trailing array for struct bpf_lpm_trie_key, introduce a new struct
> that correctly uses a flexible array for the trailing bytes,
> struct bpf_lpm_trie_key_u8. As part of this, include the "header"
> portion (which is just the "prefixlen" member), so it can be used
> by anything building a bpf_lpr_trie_key that has trailing members that
> aren't a u8 flexible array (like the self-test[1]), which is named
> struct bpf_lpm_trie_key_hdr.
> 
> Adjust the kernel code to use struct bpf_lpm_trie_key_u8 through-out,
> and for the selftest to use struct bpf_lpm_trie_key_hdr. Add a comment
> to the UAPI header directing folks to the two new options.
> 
> Link: https://lore.kernel.org/all/202206281009.4332AA33@keescook/ [1]
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Closes: https://paste.debian.net/hidden/ca500597/
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
[...]

The build in BPF CI is still broken, did you try to build selftests?

   https://github.com/kernel-patches/bpf/actions/runs/7978647641

   [...]
     GEN-SKEL [test_progs] linked_funcs.skel.h
     LINK-BPF [test_progs] test_usdt.bpf.o
     GEN-SKEL [test_progs-no_alu32] profiler1.skel.h
     GEN-SKEL [test_progs] test_usdt.skel.h
   In file included from /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:11,
                    from test_cpp.cpp:4:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:92:17: error: ‘struct bpf_lpm_trie_key_u8::<unnamed union>::bpf_lpm_trie_key_hdr’ invalid; an anonymous union may only have public non-static data members [-fpermissive]
      92 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |                 ^~~~~~~~~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/include/uapi/linux/stddef.h:29:10: note: in definition of macro ‘__struct_group’
      29 |   struct TAG { MEMBERS } ATTRS NAME; \
         |          ^~~
     BINARY   bench
   make: *** [Makefile:703: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/test_cpp] Error 1
   make: *** Waiting for unfinished jobs....
   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
   Error: Process completed with exit code 2.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 754e68ca8744..31e9bdd4641e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -8,6 +8,7 @@
>   #ifndef _UAPI__LINUX_BPF_H__
>   #define _UAPI__LINUX_BPF_H__
>   
> +#include <linux/stddef.h>
>   #include <linux/types.h>
>   #include <linux/bpf_common.h>
>   
> @@ -77,12 +78,24 @@ struct bpf_insn {
>   	__s32	imm;		/* signed immediate constant */
>   };
>   
> -/* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
> +/* Deprecated: use struct bpf_lpm_trie_key_u8 (when the "data" member is needed for
> + * byte access) or struct bpf_lpm_trie_key_hdr (when using an alternative type for
> + * the trailing flexible array member) instead.
> + */
>   struct bpf_lpm_trie_key {
>   	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
>   	__u8	data[0];	/* Arbitrary size */
>   };
>   
> +/* Key of an a BPF_MAP_TYPE_LPM_TRIE entry, with trailing byte array. */
> +struct bpf_lpm_trie_key_u8 {
> +	__struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
> +		/* up to 32 for AF_INET, 128 for AF_INET6 */
> +		__u32	prefixlen;
> +	);
> +	__u8	data[];		/* Arbitrary size */
> +};
> +
>   struct bpf_cgroup_storage_key {
>   	__u64	cgroup_inode_id;	/* cgroup inode id */
>   	__u32	attach_type;		/* program attach type (enum bpf_attach_type) */

