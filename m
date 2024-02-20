Return-Path: <linux-kselftest+bounces-5057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D2685C412
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 19:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D45E1C22C41
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 18:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FA613473D;
	Tue, 20 Feb 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OjrKQgNy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0377867A
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455271; cv=none; b=NbuOesLkICVrWf9P/H33M2Yztr1EDuRXn+Bb2rEj8tBjzmNL4RaPi05NTxAX56a0Oimk1J4iKQ0QjVJrXgM9ja1K1UkKfXNGYQjDy2GuCiaxIpMJdkv3xf6FTMDk/6nsvuNecHdDxgcmLkcUeLSK7wtkg+mKRnhTTLdBfQI2q8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455271; c=relaxed/simple;
	bh=tHSXQDGeUGKY1ei7MBnd4lSHO3RY5wrWqcB1/pAvCGA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aSDfNWJXx7TQoYIufMa+4qqZfQCN46M1VLquVMPQIZVq857gopcEFLdv4rbkWnwVDaRAwYEJjocFrwW6Hu5zkANeE7HJ0tTb6X3YtcLfxUr26iqwMBs9CTgrN1W9F2l0/yN/ffpRI0JTOeKjfFjMPieJLkPu16ttP1JDzso+vTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OjrKQgNy; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-595aa5b1fe0so3809456eaf.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 10:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708455267; x=1709060067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrTIjFyBXIkfw/jRB0s683DVSABd2UUki2texP2LjSw=;
        b=OjrKQgNywkty6uPScdXrkr6bwQzlChN3uesQIyCY3tOMfjxchE0QZ2P4EJvEirgDcF
         vkW075zNADZKkkAGghRyVKJi4kmEsUv5Drq7ue8LsPQfLjY+cEBJOCOMSFFSu8exzMD+
         izPckeSDArSdrUfk05mxi/yCb/r//PZLuEGw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708455267; x=1709060067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrTIjFyBXIkfw/jRB0s683DVSABd2UUki2texP2LjSw=;
        b=DdgJpjHJOqOfT96ZJbOFeGGnv/BHNHGrOenrPQ5tZUeHwQBuM6ntiiOlx5Dxk30woF
         rhCmDKbZJ/egD4H2DzdIuMVOa56Lw4z5ZlNgHu2It3CVvC5HjIxVT6afxlYGMVRVCweQ
         SmDLethIXr+Xu6OnV/yEH78C9WofWY8UO+vH+88SQb1aOLdJOk+3Fe6FyuSl/CwwSmx0
         LOd8M6mcwabbBQy27TxOqJrCWzmt3vHZOzXAegooOCqsieoBPy2qOoSsZmkfJxnP+dEW
         vJFjhfW3UpPaRHo7rAH7Oq3bELak5b+Gt5afpeNrNJy0cXNDdtK5rAYZaA7ewZHzgF0A
         yOGw==
X-Forwarded-Encrypted: i=1; AJvYcCUgwXhE7x1tTKyBm/p1t9d5asM3ZAZko/XGJ9cHzq/FzFwUUOe1Wire50hZfImYwpi/fZMN23nTLHmbh/li+fm/wJaNSOcmPRaA2iQz+Ala
X-Gm-Message-State: AOJu0Ywat8gDUg1bHQBv8/kE+1WSr879nSKbq/zJFIMNtu9tP63xCR6F
	WFkrt32gMwh4InZ2OFNtsx25nZ+gaDABxuK0W4j0X4eoUndrSfy80uLdr8231g==
X-Google-Smtp-Source: AGHT+IHECZsnI1s/QVei1woEBLq9unP1W/PE+wXWvUj1Odo4cM6bOKP16YhsQUnkvF6lOOJ6w8Wp0w==
X-Received: by 2002:a05:6358:4781:b0:178:7d98:f7ab with SMTP id i1-20020a056358478100b001787d98f7abmr21586919rwn.15.1708455267559;
        Tue, 20 Feb 2024 10:54:27 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p129-20020a625b87000000b006e4762b5f3bsm2669128pfb.172.2024.02.20.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:54:26 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Kees Cook <keescook@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Haowen Bai <baihaowen@meizu.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kui-Feng Lee <kuifeng@meta.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4] bpf: Replace bpf_lpm_trie_key 0-length array with flexible array
Date: Tue, 20 Feb 2024 10:54:25 -0800
Message-Id: <20240220185421.it.949-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15947; i=keescook@chromium.org;
 h=from:subject:message-id; bh=tHSXQDGeUGKY1ei7MBnd4lSHO3RY5wrWqcB1/pAvCGA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl1PVhwP4SxxHs9fj7m1JdEce4okvH/oWBrqdon
 aWsXsNXHCmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdT1YQAKCRCJcvTf3G3A
 JppUD/0aBjAouAErVwzdxNozRBK99TR6U4iOB0HQ9KOXTcYYBk05gsrNvN5sRa3mWznj/mj1SwO
 HF698pucar6hISrIU8n7rv9A+JdK8PcqHOHRHg4G0m7Vcgk+xQ4ewzK7deJ3svlFDRcrC00YXr9
 T/UviAsO6kyezbvvJDn/3PQGeRp+O1tuIY18Iqv4+97OmIIqAtcYEodoeKj2Vt6Ecd8TAPACuhH
 MbwzTby4e+bNnOQublyotYAIFpq/YX5Rg/QafN99QHZnEiNe/tWvIDwEz4SDFzx4SOympoSnZ1j
 KwGMpG61etv6XHAFqgIhIR4pMp4n8LS6dNzM7A+p/nz1AeSaSOVS1R3+o5FREyeqe9tvgrSfJjs
 H0RGOJ+059U+oU3Z72KZvwwqzjDNHnJvB/AjDO2tgRi1embs9fc4U1QDekN0qHKDF4k4hm44/7o
 RoBCOG5sxhRS92mqfU8wY6nBvmuYCelKXO6gY8NJ/jaVOKiwK6K1V3HDEDPdRHnJlo8YFAHoP+R
 p01t6Awy6ImxSzhPbuzkTdXqQfu/X4dXwdqnxF+zyY2srbNZUDhA0EJMsToH6UQ3qgRWIJWcGJ2
 NosGf5fgg/kxB1Zkwx2FizjY5Z2cTn6mGBr7EcpYrO96Yw4xH51/XGo3gJMUKD05uRNaEXjMv5c
 uWoPxK X5F4FvgDA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Replace deprecated 0-length array in struct bpf_lpm_trie_key with
flexible array. Found with GCC 13:

../kernel/bpf/lpm_trie.c:207:51: warning: array subscript i is outside array bounds of 'const __u8[0]' {aka 'const unsigned char[]'} [-Warray-bounds=]
  207 |                                        *(__be16 *)&key->data[i]);
      |                                                   ^~~~~~~~~~~~~
../include/uapi/linux/swab.h:102:54: note: in definition of macro '__swab16'
  102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
      |                                                      ^
../include/linux/byteorder/generic.h:97:21: note: in expansion of macro '__be16_to_cpu'
   97 | #define be16_to_cpu __be16_to_cpu
      |                     ^~~~~~~~~~~~~
../kernel/bpf/lpm_trie.c:206:28: note: in expansion of macro 'be16_to_cpu'
  206 |                 u16 diff = be16_to_cpu(*(__be16 *)&node->data[i]
^
      |                            ^~~~~~~~~~~
In file included from ../include/linux/bpf.h:7:
../include/uapi/linux/bpf.h:82:17: note: while referencing 'data'
   82 |         __u8    data[0];        /* Arbitrary size */
      |                 ^~~~

And found at run-time under CONFIG_FORTIFY_SOURCE:

  UBSAN: array-index-out-of-bounds in kernel/bpf/lpm_trie.c:218:49
  index 0 is out of range for type '__u8 [*]'

Changing struct bpf_lpm_trie_key is difficult since has been used by
userspace. For example, in Cilium:

	struct egress_gw_policy_key {
	        struct bpf_lpm_trie_key lpm_key;
	        __u32 saddr;
	        __u32 daddr;
	};

While direct references to the "data" member haven't been found, there
are static initializers what include the final member. For example,
the "{}" here:

        struct egress_gw_policy_key in_key = {
                .lpm_key = { 32 + 24, {} },
                .saddr   = CLIENT_IP,
                .daddr   = EXTERNAL_SVC_IP & 0Xffffff,
        };

To avoid the build time and run time warnings seen with a 0-sized
trailing array for struct bpf_lpm_trie_key, introduce a new struct
that correctly uses a flexible array for the trailing bytes,
struct bpf_lpm_trie_key_u8. As part of this, include the "header"
portion (which is just the "prefixlen" member), so it can be used
by anything building a bpf_lpr_trie_key that has trailing members that
aren't a u8 flexible array (like the self-test[1]), which is named
struct bpf_lpm_trie_key_hdr.

Adjust the kernel code to use struct bpf_lpm_trie_key_u8 through-out,
and for the selftest to use struct bpf_lpm_trie_key_hdr. Add a comment
to the UAPI header directing folks to the two new options.

Link: https://lore.kernel.org/all/202206281009.4332AA33@keescook/ [1]
Reported-by: Mark Rutland <mark.rutland@arm.com>
Closes: https://paste.debian.net/hidden/ca500597/
Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mykola Lysenko <mykolal@fb.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Haowen Bai <baihaowen@meizu.com>
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
v4- add missing stddef.h include
v3- https://lore.kernel.org/all/20240219234121.make.373-kees@kernel.org/
v2- https://lore.kernel.org/lkml/20240216235536.it.234-kees@kernel.org/
v1- https://lore.kernel.org/lkml/20230204183241.never.481-kees@kernel.org/
---
 Documentation/bpf/map_lpm_trie.rst            |  2 +-
 include/uapi/linux/bpf.h                      | 15 +++++++++++++-
 kernel/bpf/lpm_trie.c                         | 20 +++++++++----------
 samples/bpf/map_perf_test_user.c              |  2 +-
 samples/bpf/xdp_router_ipv4_user.c            |  2 +-
 tools/include/uapi/linux/bpf.h                | 15 +++++++++++++-
 .../selftests/bpf/progs/map_ptr_kern.c        |  2 +-
 tools/testing/selftests/bpf/test_lpm_map.c    | 18 ++++++++---------
 8 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/Documentation/bpf/map_lpm_trie.rst b/Documentation/bpf/map_lpm_trie.rst
index 74d64a30f500..f9cd579496c9 100644
--- a/Documentation/bpf/map_lpm_trie.rst
+++ b/Documentation/bpf/map_lpm_trie.rst
@@ -17,7 +17,7 @@ significant byte.
 
 LPM tries may be created with a maximum prefix length that is a multiple
 of 8, in the range from 8 to 2048. The key used for lookup and update
-operations is a ``struct bpf_lpm_trie_key``, extended by
+operations is a ``struct bpf_lpm_trie_key_u8``, extended by
 ``max_prefixlen/8`` bytes.
 
 - For IPv4 addresses the data length is 4 bytes
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 754e68ca8744..31e9bdd4641e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -8,6 +8,7 @@
 #ifndef _UAPI__LINUX_BPF_H__
 #define _UAPI__LINUX_BPF_H__
 
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/bpf_common.h>
 
@@ -77,12 +78,24 @@ struct bpf_insn {
 	__s32	imm;		/* signed immediate constant */
 };
 
-/* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
+/* Deprecated: use struct bpf_lpm_trie_key_u8 (when the "data" member is needed for
+ * byte access) or struct bpf_lpm_trie_key_hdr (when using an alternative type for
+ * the trailing flexible array member) instead.
+ */
 struct bpf_lpm_trie_key {
 	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
 	__u8	data[0];	/* Arbitrary size */
 };
 
+/* Key of an a BPF_MAP_TYPE_LPM_TRIE entry, with trailing byte array. */
+struct bpf_lpm_trie_key_u8 {
+	__struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
+		/* up to 32 for AF_INET, 128 for AF_INET6 */
+		__u32	prefixlen;
+	);
+	__u8	data[];		/* Arbitrary size */
+};
+
 struct bpf_cgroup_storage_key {
 	__u64	cgroup_inode_id;	/* cgroup inode id */
 	__u32	attach_type;		/* program attach type (enum bpf_attach_type) */
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index b32be680da6c..050fe1ebf0f7 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -164,13 +164,13 @@ static inline int extract_bit(const u8 *data, size_t index)
  */
 static size_t longest_prefix_match(const struct lpm_trie *trie,
 				   const struct lpm_trie_node *node,
-				   const struct bpf_lpm_trie_key *key)
+				   const struct bpf_lpm_trie_key_u8 *key)
 {
 	u32 limit = min(node->prefixlen, key->prefixlen);
 	u32 prefixlen = 0, i = 0;
 
 	BUILD_BUG_ON(offsetof(struct lpm_trie_node, data) % sizeof(u32));
-	BUILD_BUG_ON(offsetof(struct bpf_lpm_trie_key, data) % sizeof(u32));
+	BUILD_BUG_ON(offsetof(struct bpf_lpm_trie_key_u8, data) % sizeof(u32));
 
 #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && defined(CONFIG_64BIT)
 
@@ -229,7 +229,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
 	struct lpm_trie_node *node, *found = NULL;
-	struct bpf_lpm_trie_key *key = _key;
+	struct bpf_lpm_trie_key_u8 *key = _key;
 
 	if (key->prefixlen > trie->max_prefixlen)
 		return NULL;
@@ -309,7 +309,7 @@ static long trie_update_elem(struct bpf_map *map,
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
 	struct lpm_trie_node *node, *im_node = NULL, *new_node = NULL;
 	struct lpm_trie_node __rcu **slot;
-	struct bpf_lpm_trie_key *key = _key;
+	struct bpf_lpm_trie_key_u8 *key = _key;
 	unsigned long irq_flags;
 	unsigned int next_bit;
 	size_t matchlen = 0;
@@ -437,7 +437,7 @@ static long trie_update_elem(struct bpf_map *map,
 static long trie_delete_elem(struct bpf_map *map, void *_key)
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
-	struct bpf_lpm_trie_key *key = _key;
+	struct bpf_lpm_trie_key_u8 *key = _key;
 	struct lpm_trie_node __rcu **trim, **trim2;
 	struct lpm_trie_node *node, *parent;
 	unsigned long irq_flags;
@@ -536,7 +536,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 				 sizeof(struct lpm_trie_node))
 #define LPM_VAL_SIZE_MIN	1
 
-#define LPM_KEY_SIZE(X)		(sizeof(struct bpf_lpm_trie_key) + (X))
+#define LPM_KEY_SIZE(X)		(sizeof(struct bpf_lpm_trie_key_u8) + (X))
 #define LPM_KEY_SIZE_MAX	LPM_KEY_SIZE(LPM_DATA_SIZE_MAX)
 #define LPM_KEY_SIZE_MIN	LPM_KEY_SIZE(LPM_DATA_SIZE_MIN)
 
@@ -565,7 +565,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 	/* copy mandatory map attributes */
 	bpf_map_init_from_attr(&trie->map, attr);
 	trie->data_size = attr->key_size -
-			  offsetof(struct bpf_lpm_trie_key, data);
+			  offsetof(struct bpf_lpm_trie_key_u8, data);
 	trie->max_prefixlen = trie->data_size * 8;
 
 	spin_lock_init(&trie->lock);
@@ -616,7 +616,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
 {
 	struct lpm_trie_node *node, *next_node = NULL, *parent, *search_root;
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
-	struct bpf_lpm_trie_key *key = _key, *next_key = _next_key;
+	struct bpf_lpm_trie_key_u8 *key = _key, *next_key = _next_key;
 	struct lpm_trie_node **node_stack = NULL;
 	int err = 0, stack_ptr = -1;
 	unsigned int next_bit;
@@ -703,7 +703,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
 	}
 do_copy:
 	next_key->prefixlen = next_node->prefixlen;
-	memcpy((void *)next_key + offsetof(struct bpf_lpm_trie_key, data),
+	memcpy((void *)next_key + offsetof(struct bpf_lpm_trie_key_u8, data),
 	       next_node->data, trie->data_size);
 free_stack:
 	kfree(node_stack);
@@ -715,7 +715,7 @@ static int trie_check_btf(const struct bpf_map *map,
 			  const struct btf_type *key_type,
 			  const struct btf_type *value_type)
 {
-	/* Keys must have struct bpf_lpm_trie_key embedded. */
+	/* Keys must have struct bpf_lpm_trie_key_u8 embedded. */
 	return BTF_INFO_KIND(key_type->info) != BTF_KIND_STRUCT ?
 	       -EINVAL : 0;
 }
diff --git a/samples/bpf/map_perf_test_user.c b/samples/bpf/map_perf_test_user.c
index d2fbcf963cdf..07ff471ed6ae 100644
--- a/samples/bpf/map_perf_test_user.c
+++ b/samples/bpf/map_perf_test_user.c
@@ -370,7 +370,7 @@ static void run_perf_test(int tasks)
 
 static void fill_lpm_trie(void)
 {
-	struct bpf_lpm_trie_key *key;
+	struct bpf_lpm_trie_key_u8 *key;
 	unsigned long value = 0;
 	unsigned int i;
 	int r;
diff --git a/samples/bpf/xdp_router_ipv4_user.c b/samples/bpf/xdp_router_ipv4_user.c
index 9d41db09c480..266fdd0b025d 100644
--- a/samples/bpf/xdp_router_ipv4_user.c
+++ b/samples/bpf/xdp_router_ipv4_user.c
@@ -91,7 +91,7 @@ static int recv_msg(struct sockaddr_nl sock_addr, int sock)
 static void read_route(struct nlmsghdr *nh, int nll)
 {
 	char dsts[24], gws[24], ifs[16], dsts_len[24], metrics[24];
-	struct bpf_lpm_trie_key *prefix_key;
+	struct bpf_lpm_trie_key_u8 *prefix_key;
 	struct rtattr *rt_attr;
 	struct rtmsg *rt_msg;
 	int rtm_family;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7f24d898efbb..76b1b41c0dce 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -8,6 +8,7 @@
 #ifndef _UAPI__LINUX_BPF_H__
 #define _UAPI__LINUX_BPF_H__
 
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/bpf_common.h>
 
@@ -77,12 +78,24 @@ struct bpf_insn {
 	__s32	imm;		/* signed immediate constant */
 };
 
-/* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
+/* Deprecated: use struct bpf_lpm_trie_key_u8 (when the "data" member is needed for
+ * byte access) or struct bpf_lpm_trie_key_hdr (when using an alternative type for
+ * the trailing flexible array member) instead.
+ */
 struct bpf_lpm_trie_key {
 	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
 	__u8	data[0];	/* Arbitrary size */
 };
 
+/* Key of an a BPF_MAP_TYPE_LPM_TRIE entry, with trailing byte array. */
+struct bpf_lpm_trie_key_u8 {
+	__struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
+		/* up to 32 for AF_INET, 128 for AF_INET6 */
+		__u32	prefixlen;
+	);
+	__u8	data[];		/* Arbitrary size */
+};
+
 struct bpf_cgroup_storage_key {
 	__u64	cgroup_inode_id;	/* cgroup inode id */
 	__u32	attach_type;		/* program attach type (enum bpf_attach_type) */
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index 3325da17ec81..efaf622c28dd 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -316,7 +316,7 @@ struct lpm_trie {
 } __attribute__((preserve_access_index));
 
 struct lpm_key {
-	struct bpf_lpm_trie_key trie_key;
+	struct bpf_lpm_trie_key_hdr trie_key;
 	__u32 data;
 };
 
diff --git a/tools/testing/selftests/bpf/test_lpm_map.c b/tools/testing/selftests/bpf/test_lpm_map.c
index c028d621c744..d98c72dc563e 100644
--- a/tools/testing/selftests/bpf/test_lpm_map.c
+++ b/tools/testing/selftests/bpf/test_lpm_map.c
@@ -211,7 +211,7 @@ static void test_lpm_map(int keysize)
 	volatile size_t n_matches, n_matches_after_delete;
 	size_t i, j, n_nodes, n_lookups;
 	struct tlpm_node *t, *list = NULL;
-	struct bpf_lpm_trie_key *key;
+	struct bpf_lpm_trie_key_u8 *key;
 	uint8_t *data, *value;
 	int r, map;
 
@@ -331,8 +331,8 @@ static void test_lpm_map(int keysize)
 static void test_lpm_ipaddr(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC);
-	struct bpf_lpm_trie_key *key_ipv4;
-	struct bpf_lpm_trie_key *key_ipv6;
+	struct bpf_lpm_trie_key_u8 *key_ipv4;
+	struct bpf_lpm_trie_key_u8 *key_ipv6;
 	size_t key_size_ipv4;
 	size_t key_size_ipv6;
 	int map_fd_ipv4;
@@ -423,7 +423,7 @@ static void test_lpm_ipaddr(void)
 static void test_lpm_delete(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC);
-	struct bpf_lpm_trie_key *key;
+	struct bpf_lpm_trie_key_u8 *key;
 	size_t key_size;
 	int map_fd;
 	__u64 value;
@@ -532,7 +532,7 @@ static void test_lpm_delete(void)
 static void test_lpm_get_next_key(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC);
-	struct bpf_lpm_trie_key *key_p, *next_key_p;
+	struct bpf_lpm_trie_key_u8 *key_p, *next_key_p;
 	size_t key_size;
 	__u32 value = 0;
 	int map_fd;
@@ -693,9 +693,9 @@ static void *lpm_test_command(void *arg)
 {
 	int i, j, ret, iter, key_size;
 	struct lpm_mt_test_info *info = arg;
-	struct bpf_lpm_trie_key *key_p;
+	struct bpf_lpm_trie_key_u8 *key_p;
 
-	key_size = sizeof(struct bpf_lpm_trie_key) + sizeof(__u32);
+	key_size = sizeof(*key_p) + sizeof(__u32);
 	key_p = alloca(key_size);
 	for (iter = 0; iter < info->iter; iter++)
 		for (i = 0; i < MAX_TEST_KEYS; i++) {
@@ -717,7 +717,7 @@ static void *lpm_test_command(void *arg)
 				ret = bpf_map_lookup_elem(info->map_fd, key_p, &value);
 				assert(ret == 0 || errno == ENOENT);
 			} else {
-				struct bpf_lpm_trie_key *next_key_p = alloca(key_size);
+				struct bpf_lpm_trie_key_u8 *next_key_p = alloca(key_size);
 				ret = bpf_map_get_next_key(info->map_fd, key_p, next_key_p);
 				assert(ret == 0 || errno == ENOENT || errno == ENOMEM);
 			}
@@ -752,7 +752,7 @@ static void test_lpm_multi_thread(void)
 
 	/* create a trie */
 	value_size = sizeof(__u32);
-	key_size = sizeof(struct bpf_lpm_trie_key) + value_size;
+	key_size = sizeof(struct bpf_lpm_trie_key_hdr) + value_size;
 	map_fd = bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, NULL, key_size, value_size, 100, &opts);
 
 	/* create 4 threads to test update, delete, lookup and get_next_key */
-- 
2.34.1


