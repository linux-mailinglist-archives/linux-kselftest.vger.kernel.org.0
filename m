Return-Path: <linux-kselftest+bounces-5016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C54F85B925
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 11:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DE728103A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 10:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2035FDA2;
	Tue, 20 Feb 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="SvvJrWuo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40FF9E0;
	Tue, 20 Feb 2024 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425284; cv=none; b=KT8+f9/ASp4991kOaTR7JEwNxtOsSmtlUM2/JCgez11Jnma/HF50XIgBJJkwsDkIB66a8zeKJu03a3+WB98UGnj9avYOJBRLmVzs5X1kHZ6B/ZZxZ17llUaZWOhtaAQlfqRZdkGe7YeI19rm5S+gScSkd0E2636ED6MchS11d2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425284; c=relaxed/simple;
	bh=NvmEbt2+xe0zS+g/bxMqUvthNju1NZ3eMn1PSIAudSg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KT8DabfkyHIFa2iXf6suNJ5becum75rFNxWSEWhhTz1yj32P7tIN9EObohKrCseCOYXpKYeN6xquFRsWQicJyk0CdshF3GwMqj2g8Efc7MztANPlwmW9M7uuA5eNOpNeG8QiYDjko41kQSeWv4EjcZ+ZX015gjThczjEEChF7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=SvvJrWuo; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=akU48QM/Cb/tDXkg58aY73lEoTVNV5/q/MB+qQc8Lh4=; b=SvvJrWuoDuJeZeNcha72o4vG5E
	VcVQM8bEf+wcs2uawT50jPcNHhWGNitkiLdEl7HEECkqDsxb20PwB4emeMLFCOWqfRqsWPL5ecqMl
	WedK1RfsnuR2fnnn2suaaHBnTRHWYcQfJJZhz5cKjL0TUBBHcu5i4+yHZQUN+ynCpCQeLLc9xde/i
	uTfUBGlnV4L6mE37sRgZvuJqlCvHaKJUI3J/NZRMFYSoeBs5cLtgu4ysFC9kt7m0i+Pk9AfkICw4Y
	pi7zcc9x6+crsLzspHJMSB6rDRrbq5009OkB1Y5fKwdYqE1TEB2n2XY2lHGKaTDJ+JsRAnAAvrvUZ
	e3bU7G9w==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcNDA-0004dT-Ug; Tue, 20 Feb 2024 11:18:52 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcNCz-000IKE-DA; Tue, 20 Feb 2024 11:18:41 +0100
Subject: Re: [PATCH v3] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
To: Kees Cook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
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
References: <20240219234121.make.373-kees@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4a4fadc5-5aac-3051-f1e6-c56d40350e35@iogearbox.net>
Date: Tue, 20 Feb 2024 11:18:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240219234121.make.373-kees@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27190/Mon Feb 19 10:24:27 2024)

On 2/20/24 12:41 AM, Kees Cook wrote:
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
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3- create a new pair of structs -- leave old struct alone
> v2- https://lore.kernel.org/lkml/20240216235536.it.234-kees@kernel.org/
> v1- https://lore.kernel.org/lkml/20230204183241.never.481-kees@kernel.org/
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
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
> ---
>   Documentation/bpf/map_lpm_trie.rst            |  2 +-
>   include/uapi/linux/bpf.h                      | 14 ++++++++++++-
>   kernel/bpf/lpm_trie.c                         | 20 +++++++++----------
>   samples/bpf/map_perf_test_user.c              |  2 +-
>   samples/bpf/xdp_router_ipv4_user.c            |  2 +-
>   tools/include/uapi/linux/bpf.h                | 14 ++++++++++++-
>   .../selftests/bpf/progs/map_ptr_kern.c        |  2 +-
>   tools/testing/selftests/bpf/test_lpm_map.c    | 18 ++++++++---------
>   8 files changed, 49 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/bpf/map_lpm_trie.rst b/Documentation/bpf/map_lpm_trie.rst
> index 74d64a30f500..f9cd579496c9 100644
> --- a/Documentation/bpf/map_lpm_trie.rst
> +++ b/Documentation/bpf/map_lpm_trie.rst
> @@ -17,7 +17,7 @@ significant byte.
>   
>   LPM tries may be created with a maximum prefix length that is a multiple
>   of 8, in the range from 8 to 2048. The key used for lookup and update
> -operations is a ``struct bpf_lpm_trie_key``, extended by
> +operations is a ``struct bpf_lpm_trie_key_u8``, extended by
>   ``max_prefixlen/8`` bytes.
>   
>   - For IPv4 addresses the data length is 4 bytes
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 754e68ca8744..c5a46d12076e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -77,12 +77,24 @@ struct bpf_insn {
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
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index b32be680da6c..050fe1ebf0f7 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -164,13 +164,13 @@ static inline int extract_bit(const u8 *data, size_t index)
>    */
>   static size_t longest_prefix_match(const struct lpm_trie *trie,
>   				   const struct lpm_trie_node *node,
> -				   const struct bpf_lpm_trie_key *key)
> +				   const struct bpf_lpm_trie_key_u8 *key)
>   {
>   	u32 limit = min(node->prefixlen, key->prefixlen);
>   	u32 prefixlen = 0, i = 0;
>   
>   	BUILD_BUG_ON(offsetof(struct lpm_trie_node, data) % sizeof(u32));
> -	BUILD_BUG_ON(offsetof(struct bpf_lpm_trie_key, data) % sizeof(u32));
> +	BUILD_BUG_ON(offsetof(struct bpf_lpm_trie_key_u8, data) % sizeof(u32));
>   
>   #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && defined(CONFIG_64BIT)
>   
> @@ -229,7 +229,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
>   {
>   	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
>   	struct lpm_trie_node *node, *found = NULL;
> -	struct bpf_lpm_trie_key *key = _key;
> +	struct bpf_lpm_trie_key_u8 *key = _key;
>   
>   	if (key->prefixlen > trie->max_prefixlen)
>   		return NULL;
> @@ -309,7 +309,7 @@ static long trie_update_elem(struct bpf_map *map,
>   	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
>   	struct lpm_trie_node *node, *im_node = NULL, *new_node = NULL;
>   	struct lpm_trie_node __rcu **slot;
> -	struct bpf_lpm_trie_key *key = _key;
> +	struct bpf_lpm_trie_key_u8 *key = _key;
>   	unsigned long irq_flags;
>   	unsigned int next_bit;
>   	size_t matchlen = 0;
> @@ -437,7 +437,7 @@ static long trie_update_elem(struct bpf_map *map,
>   static long trie_delete_elem(struct bpf_map *map, void *_key)
>   {
>   	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
> -	struct bpf_lpm_trie_key *key = _key;
> +	struct bpf_lpm_trie_key_u8 *key = _key;
>   	struct lpm_trie_node __rcu **trim, **trim2;
>   	struct lpm_trie_node *node, *parent;
>   	unsigned long irq_flags;
> @@ -536,7 +536,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
>   				 sizeof(struct lpm_trie_node))
>   #define LPM_VAL_SIZE_MIN	1
>   
> -#define LPM_KEY_SIZE(X)		(sizeof(struct bpf_lpm_trie_key) + (X))
> +#define LPM_KEY_SIZE(X)		(sizeof(struct bpf_lpm_trie_key_u8) + (X))
>   #define LPM_KEY_SIZE_MAX	LPM_KEY_SIZE(LPM_DATA_SIZE_MAX)
>   #define LPM_KEY_SIZE_MIN	LPM_KEY_SIZE(LPM_DATA_SIZE_MIN)
>   
> @@ -565,7 +565,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
>   	/* copy mandatory map attributes */
>   	bpf_map_init_from_attr(&trie->map, attr);
>   	trie->data_size = attr->key_size -
> -			  offsetof(struct bpf_lpm_trie_key, data);
> +			  offsetof(struct bpf_lpm_trie_key_u8, data);
>   	trie->max_prefixlen = trie->data_size * 8;
>   
>   	spin_lock_init(&trie->lock);
> @@ -616,7 +616,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
>   {
>   	struct lpm_trie_node *node, *next_node = NULL, *parent, *search_root;
>   	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
> -	struct bpf_lpm_trie_key *key = _key, *next_key = _next_key;
> +	struct bpf_lpm_trie_key_u8 *key = _key, *next_key = _next_key;
>   	struct lpm_trie_node **node_stack = NULL;
>   	int err = 0, stack_ptr = -1;
>   	unsigned int next_bit;
> @@ -703,7 +703,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
>   	}
>   do_copy:
>   	next_key->prefixlen = next_node->prefixlen;
> -	memcpy((void *)next_key + offsetof(struct bpf_lpm_trie_key, data),
> +	memcpy((void *)next_key + offsetof(struct bpf_lpm_trie_key_u8, data),
>   	       next_node->data, trie->data_size);
>   free_stack:
>   	kfree(node_stack);
> @@ -715,7 +715,7 @@ static int trie_check_btf(const struct bpf_map *map,
>   			  const struct btf_type *key_type,
>   			  const struct btf_type *value_type)
>   {
> -	/* Keys must have struct bpf_lpm_trie_key embedded. */
> +	/* Keys must have struct bpf_lpm_trie_key_u8 embedded. */
>   	return BTF_INFO_KIND(key_type->info) != BTF_KIND_STRUCT ?
>   	       -EINVAL : 0;
>   }
> diff --git a/samples/bpf/map_perf_test_user.c b/samples/bpf/map_perf_test_user.c
> index d2fbcf963cdf..07ff471ed6ae 100644
> --- a/samples/bpf/map_perf_test_user.c
> +++ b/samples/bpf/map_perf_test_user.c
> @@ -370,7 +370,7 @@ static void run_perf_test(int tasks)
>   
>   static void fill_lpm_trie(void)
>   {
> -	struct bpf_lpm_trie_key *key;
> +	struct bpf_lpm_trie_key_u8 *key;
>   	unsigned long value = 0;
>   	unsigned int i;
>   	int r;
> diff --git a/samples/bpf/xdp_router_ipv4_user.c b/samples/bpf/xdp_router_ipv4_user.c
> index 9d41db09c480..266fdd0b025d 100644
> --- a/samples/bpf/xdp_router_ipv4_user.c
> +++ b/samples/bpf/xdp_router_ipv4_user.c
> @@ -91,7 +91,7 @@ static int recv_msg(struct sockaddr_nl sock_addr, int sock)
>   static void read_route(struct nlmsghdr *nh, int nll)
>   {
>   	char dsts[24], gws[24], ifs[16], dsts_len[24], metrics[24];
> -	struct bpf_lpm_trie_key *prefix_key;
> +	struct bpf_lpm_trie_key_u8 *prefix_key;
>   	struct rtattr *rt_attr;
>   	struct rtmsg *rt_msg;
>   	int rtm_family;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 7f24d898efbb..c55244bf1a20 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -77,12 +77,24 @@ struct bpf_insn {
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

This fails the BPF CI :

   [...]
     INSTALL /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/skel_internal.h
     INSTALL /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/libbpf_version.h
     INSTALL /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/usdt.bpf.h
   In file included from urandom_read_lib1.c:7:
   In file included from /tmp/work/bpf/bpf/tools/lib/bpf/libbpf_internal.h:20:
   In file included from /tmp/work/bpf/bpf/tools/lib/bpf/relo_core.h:7:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: type name requires a specifier or qualifier
      91 |         __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |         ^
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:58: error: expected identifier
      91 |         __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |                                                                 ^
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:93:18: error: unexpected ';' before ')'
      93 |                 __u32   prefixlen;
         |                                  ^
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:95:7: error: flexible array member 'data' not allowed in otherwise empty struct
      95 |         __u8    data[];         /* Arbitrary size */
         |                 ^
     HOSTCC  /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/fixdep.o
   4 errors generated.
     GEN     /tmp/work/bpf/bpf/tools/testing/selftests/bpf/bpf-syscall.2
     HOSTLD  /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/fixdep-in.o
     LINK    /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/fixdep
   make: *** [Makefile:230: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/liburandom_read.so] Error 1
   make: *** Waiting for unfinished jobs....
     INSTALL /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/bpf_helper_defs.h
     INSTALL libbpf_headers
     GEN     /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.pc
     MKDIR   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/
     MKDIR   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/
     MKDIR   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/
     MKDIR   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/
     MKDIR   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/str_error.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/bpf.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/nlattr.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/btf.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/netlink.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/bpf_prog_linfo.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf_probes.o
   Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/hashmap.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf_errno.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/btf_dump.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/ringbuf.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/strset.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/linker.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/gen_loader.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/relo_core.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/usdt.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/zip.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/elf.o
     MKDIR   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/features.o
     MKDIR   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/
     MKDIR   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/
     MKDIR   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/
     MKDIR   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/
     MKDIR   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/netlink.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/bpf.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/nlattr.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/bpf_prog_linfo.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/btf.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf_errno.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/str_error.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf_probes.o
   In file included from /tmp/work/bpf/bpf/tools/include/linux/filter.h:8,
                    from features.c:4:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/hashmap.o
   In file included from bpf_prog_linfo.c:7:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from libbpf.h:18,
                    from libbpf_errno.c:14:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from /tmp/work/bpf/bpf/tools/include/linux/filter.h:8,
                    from gen_loader.c:7:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from bpf.c:30:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from libbpf.c:31:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from libbpf.h:18,
                    from relo_core.c:64:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from bpf_prog_linfo.c:7:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from libbpf.h:18,
                    from libbpf_errno.c:14:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from bpf.c:30:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from ringbuf.c:15:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from libbpf.h:18,
                    from btf_dump.c:22:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from relo_core.h:7,
                    from libbpf_internal.h:20,
                    from strset.c:9:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from bpf.h:26,
                    from usdt.c:18:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from relo_core.h:7,
                    from libbpf_internal.h:20,
                    from nlattr.c:14:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from relo_core.h:7,
                    from libbpf_internal.h:20,
                    from elf.c:11:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from libbpf.h:18,
                    from linker.c:19:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/btf_dump.o
   In file included from bpf.h:26,
                    from btf.c:20:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from libbpf.c:31:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from relo_core.h:7,
                    from libbpf_internal.h:20,
                    from zip.c:16:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from relo_core.h:7,
                    from libbpf_internal.h:20,
                    from nlattr.c:14:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/bpf_prog_linfo.o] Error 1
   make[3]: *** Waiting for unfinished jobs....
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/strset.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/nlattr.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf_errno.o] Error 1
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/ringbuf.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/strset.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/linker.o
     CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/gen_loader.o
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:106: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/bpf_prog_linfo.o] Error 1
   make[3]: *** Waiting for unfinished jobs....
   In file included from bpf.h:26,
                    from btf.c:20:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/elf.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:106: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf_errno.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/zip.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/features.o] Error 1
     GEN     /tmp/work/bpf/bpf/tools/testing/selftests/bpf/bpf-helpers.7
   In file included from libbpf.h:18,
                    from btf_dump.c:22:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/usdt.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:106: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/nlattr.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/ringbuf.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/relo_core.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/gen_loader.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/bpf.o] Error 1
   In file included from /tmp/work/bpf/bpf/tools/include/linux/filter.h:8,
                    from gen_loader.c:7:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from ringbuf.c:15:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:106: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/bpf.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/btf_dump.o] Error 1
   In file included from relo_core.h:7,
                    from libbpf_internal.h:20,
                    from strset.c:9:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   In file included from libbpf.h:18,
                    from linker.c:19:
   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:91:2: error: expected specifier-qualifier-list before ‘__struct_group’
      91 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
         |  ^~~~~~~~~~~~~~
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/linker.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/strset.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/btf_dump.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/ringbuf.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/gen_loader.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/btf.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/linker.o] Error 1
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/btf.o] Error 1
     GEN     /tmp/work/bpf/bpf/tools/testing/selftests/bpf/bpf-syscall.2
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf.o] Error 1
   make[2]: *** [Makefile:157: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf-in.o] Error 2
   make[2]: *** Waiting for unfinished jobs....
   make[3]: *** [/tmp/work/bpf/bpf/tools/build/Makefile.build:105: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf.o] Error 1
   make[2]: *** [Makefile:148: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf-in.o] Error 2
   make[1]: *** [Makefile:140: all] Error 2
   make: *** [Makefile:344: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a] Error 2
     GEN     /tmp/work/bpf/bpf/tools/testing/selftests/bpf/bpf-helpers.7
   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
   Error: Process completed with exit code 2.

