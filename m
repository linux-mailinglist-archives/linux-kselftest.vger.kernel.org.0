Return-Path: <linux-kselftest+bounces-8025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9A48A5B55
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 21:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539BC2882B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55AC15664E;
	Mon, 15 Apr 2024 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfx3ucTG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8F015624B;
	Mon, 15 Apr 2024 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209799; cv=none; b=s8iZ6KjcezRkH/RJdWI41pHG6JfqdDvSX6CwsAKNql65zrAuqFuPrJLSWE65lBg5kR1BCHp1ysPTDbtnyZSQnvfDAOtg23ZVE1ZPgD5681Yxm8P56/3aFZvFeCdgr1lvRTJYFjlsrUAda67Fvd6whwiKjuRXlnsdEcWmpc/SEYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209799; c=relaxed/simple;
	bh=5C/llpeNEkzzHAtRPM9Y08mKmxzjzK3Sawz80BrLe4E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jXTCxZrWI8UZvOY7H4DYuvDEwaaMI/89r4HnNnL00e3qblD0R1uhsRpyZd4cP0+qkFVwqF4L37kyDMTp4j+HIiPP1jZJs5engELB2oOFFSQnH2RWmeHIEKmzD636GDbQzqs9ew9+63FRh+w3Ans1wuCts9+nBhWL2jXdEzN9C9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfx3ucTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDF8C113CC;
	Mon, 15 Apr 2024 19:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713209799;
	bh=5C/llpeNEkzzHAtRPM9Y08mKmxzjzK3Sawz80BrLe4E=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=rfx3ucTGbCWOSce9lbxZ9QRZ/PUyl0PKpHQUPhL191FxZJQcwQnvDl8jmqqPMifOJ
	 zFjXfr7ztjjQuEUWxxMdcsQi2+E4KYufKsVe2cZBivGxXS2U9PLJtmUPNix63r5Btr
	 gA1OjhZT0xbAa7hZouQrXA67roJkovxfoLf8/o1xSGC31vkPAM4XzXOqRjy3G3rhS0
	 xfew5F9r+w0bx9VeOxf8UvXJghKpaq1+yevQxZ8WG8efKotQDsS8OEjHg2UVCEYXdv
	 zVt4b/GfnB2Ybw13GjGcZ4xrTUoBUUEkeSukeFjECZGuTydx/4UaUqF7UGTOhAXN5k
	 qZ1QQjkrbqQoQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Apr 2024 22:36:30 +0300
Message-Id: <D0KY6ORXBNXP.1EVHFHMS89OK6@kernel.org>
Cc: <linux-security-module@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <bpf@vger.kernel.org>, <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
 <linux-integrity@vger.kernel.org>, <wufan@linux.microsoft.com>,
 <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>, <hch@lst.de>,
 <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>, <jannh@google.com>,
 <dhowells@redhat.com>, <jikos@kernel.org>, <mkoutny@suse.com>,
 <ppavlu@suse.com>, <petr.vorel@gmail.com>, <mzerqung@0pointer.de>,
 <kgold@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v4 04/14] digest_cache: Add hash tables and operations
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <corbet@lwn.net>,
 <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <akpm@linux-foundation.org>, <shuah@kernel.org>,
 <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
 <mic@digikod.net>
X-Mailer: aerc 0.17.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <20240415142436.2545003-5-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240415142436.2545003-5-roberto.sassu@huaweicloud.com>

On Mon Apr 15, 2024 at 5:24 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add a linked list of hash tables to the digest cache, one per algorithm,
> containing the digests extracted from digest lists.
>
> The number of hash table slots is determined by dividing the number of
> digests to add to the average depth of the collision list defined with
> CONFIG_DIGEST_CACHE_HTABLE_DEPTH (currently set to 30). It can be changed
> in the kernel configuration.
>
> Add digest_cache_htable_init() and digest_cache_htable_add(), to be calle=
d
> by digest list parsers, in order to allocate the hash tables and to add
> extracted digests.
>
> Add digest_cache_htable_free(), to let the digest_cache LSM free the hash
> tables at the time a digest cache is freed.
>
> Add digest_cache_htable_lookup() to search a digest in the hash table of =
a
> digest cache for a given algorithm.
>
> Add digest_cache_lookup() to the public API, to let users of the
> digest_cache LSM search a digest in a digest cache and, in a subsequent
> patch, to search it in the digest caches for each directory entry.
>
> Return the digest cache containing the digest, as a different type,
> digest_cache_found_t to avoid it being accidentally put. Also, introduce
> digest_cache_from_found_t() to explicitly convert it back to a digest cac=
he
> for further use (e.g. retrieving verification data, introduced later).
>
> Finally, add digest_cache_hash_key() to compute the hash table key from t=
he
> first two bytes of the digest (modulo the number of slots).
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/digest_cache.h     |  34 +++++
>  security/digest_cache/Kconfig    |  11 ++
>  security/digest_cache/Makefile   |   2 +-
>  security/digest_cache/htable.c   | 250 +++++++++++++++++++++++++++++++
>  security/digest_cache/internal.h |  43 ++++++
>  security/digest_cache/main.c     |   3 +
>  6 files changed, 342 insertions(+), 1 deletion(-)
>  create mode 100644 security/digest_cache/htable.c
>
> diff --git a/include/linux/digest_cache.h b/include/linux/digest_cache.h
> index e79f94a60b0f..4872700ac205 100644
> --- a/include/linux/digest_cache.h
> +++ b/include/linux/digest_cache.h
> @@ -11,12 +11,39 @@
>  #define _LINUX_DIGEST_CACHE_H
> =20
>  #include <linux/fs.h>
> +#include <crypto/hash_info.h>
> =20
>  struct digest_cache;
> =20
> +/**
> + * typedef digest_cache_found_t - Digest cache reference as numeric valu=
e
> + *
> + * This new type represents a digest cache reference that should not be =
put.
> + */
> +typedef unsigned long digest_cache_found_t;
> +
> +/**
> + * digest_cache_from_found_t - Convert digest_cache_found_t to digest ca=
che ptr
> + * @found: digest_cache_found_t value
> + *
> + * Convert the digest_cache_found_t returned by digest_cache_lookup() to=
 a
> + * digest cache pointer, so that it can be passed to the other functions=
 of the
> + * API.
> + *
> + * Return: Digest cache pointer.
> + */
> +static inline struct digest_cache *
> +digest_cache_from_found_t(digest_cache_found_t found)
> +{
> +	return (struct digest_cache *)found;
> +}
> +
>  #ifdef CONFIG_SECURITY_DIGEST_CACHE
>  struct digest_cache *digest_cache_get(struct dentry *dentry);
>  void digest_cache_put(struct digest_cache *digest_cache);
> +digest_cache_found_t digest_cache_lookup(struct dentry *dentry,
> +					 struct digest_cache *digest_cache,
> +					 u8 *digest, enum hash_algo algo);
> =20
>  #else
>  static inline struct digest_cache *digest_cache_get(struct dentry *dentr=
y)
> @@ -28,5 +55,12 @@ static inline void digest_cache_put(struct digest_cach=
e *digest_cache)
>  {
>  }
> =20
> +static inline digest_cache_found_t
> +digest_cache_lookup(struct dentry *dentry, struct digest_cache *digest_c=
ache,
> +		    u8 *digest, enum hash_algo algo)
> +{
> +	return 0UL;
> +}
> +
>  #endif /* CONFIG_SECURITY_DIGEST_CACHE */
>  #endif /* _LINUX_DIGEST_CACHE_H */
> diff --git a/security/digest_cache/Kconfig b/security/digest_cache/Kconfi=
g
> index dfabe5d6e3ca..71017954e5c5 100644
> --- a/security/digest_cache/Kconfig
> +++ b/security/digest_cache/Kconfig
> @@ -18,3 +18,14 @@ config DIGEST_LIST_DEFAULT_PATH
>  	  It can be changed at run-time, by writing the new path to the
>  	  securityfs interface. Digest caches created with the old path are
>  	  not affected by the change.
> +
> +config DIGEST_CACHE_HTABLE_DEPTH
> +	int
> +	default 30
> +	help
> +	  Desired average depth of the collision list in the digest cache
> +	  hash tables.
> +
> +	  A smaller number will increase the amount of hash table slots, and
> +	  make the search faster. A bigger number will decrease the number of
> +	  hash table slots, but make the search slower.
> diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makef=
ile
> index 1330655e33b1..7e00c53d8f55 100644
> --- a/security/digest_cache/Makefile
> +++ b/security/digest_cache/Makefile
> @@ -4,4 +4,4 @@
> =20
>  obj-$(CONFIG_SECURITY_DIGEST_CACHE) +=3D digest_cache.o
> =20
> -digest_cache-y :=3D main.o secfs.o
> +digest_cache-y :=3D main.o secfs.o htable.o
> diff --git a/security/digest_cache/htable.c b/security/digest_cache/htabl=
e.c
> new file mode 100644
> index 000000000000..d2d5d8f5e5b1
> --- /dev/null
> +++ b/security/digest_cache/htable.c
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * Implement hash table operations for the digest cache.
> + */
> +
> +#define pr_fmt(fmt) "DIGEST CACHE: "fmt

For easier grepping from kernel tree i'd suggest to name this accordingly i=
.e.
just "digest_cache".

> +#include "internal.h"
> +
> +/**
> + * digest_cache_hash_key - Compute hash key
> + * @digest: Digest cache
> + * @num_slots: Number of slots in the hash table
> + *
> + * This function computes a hash key based on the first two bytes of the
> + * digest and the number of slots of the hash table.
> + *
> + * Return: Hash key.
> + */
> +static inline unsigned int digest_cache_hash_key(u8 *digest,
> +						 unsigned int num_slots)
> +{
> +	/* Same as ima_hash_key() but parametrized. */
> +	return (digest[0] | digest[1] << 8) % num_slots;
> +}
> +
> +/**
> + * lookup_htable - Lookup a hash table
> + * @digest_cache: Digest cache
> + * @algo: Algorithm of the desired hash table
> + *
> + * This function searches the hash table for a given algorithm in the di=
gest
> + * cache.
> + *
> + * Return: A hash table if found, NULL otherwise.
> + */
> +static struct htable *lookup_htable(struct digest_cache *digest_cache,
> +				    enum hash_algo algo)
> +{
> +	struct htable *h;
> +
> +	list_for_each_entry(h, &digest_cache->htables, next)
> +		if (h->algo =3D=3D algo)
> +			return h;
> +
> +	return NULL;
> +}
> +
> +/**
> + * digest_cache_htable_init - Allocate and initialize the hash table
> + * @digest_cache: Digest cache
> + * @num_digests: Number of digests to add to the digest cache
> + * @algo: Algorithm of the digests
> + *
> + * This function allocates and initializes the hash table for a given al=
gorithm.
> + * The number of slots depends on the number of digests to add to the di=
gest
> + * cache, and the constant CONFIG_DIGEST_CACHE_HTABLE_DEPTH stating the =
desired
> + * average depth of the collision list.
> + *
> + * Return: Zero on success, a POSIX error code otherwise.
> + */
> +int digest_cache_htable_init(struct digest_cache *digest_cache, u64 num_=
digests,
> +			     enum hash_algo algo)
> +{
> +	struct htable *h;
> +	int i;
> +
> +	h =3D lookup_htable(digest_cache, algo);
> +	if (h)
> +		return 0;
> +
> +	h =3D kmalloc(sizeof(*h), GFP_KERNEL);
> +	if (!h)
> +		return -ENOMEM;
> +
> +	h->num_slots =3D DIV_ROUND_UP(num_digests,
> +				    CONFIG_DIGEST_CACHE_HTABLE_DEPTH);
> +	h->slots =3D kmalloc_array(h->num_slots, sizeof(*h->slots), GFP_KERNEL)=
;
> +	if (!h->slots) {
> +		kfree(h);
> +		return -ENOMEM;
> +	}
> +
> +	for (i =3D 0; i < h->num_slots; i++)
> +		INIT_HLIST_HEAD(&h->slots[i]);
> +
> +	h->num_digests =3D 0;
> +	h->algo =3D algo;
> +
> +	list_add_tail(&h->next, &digest_cache->htables);
> +
> +	pr_debug("Initialized hash table for digest list %s, digests: %llu, slo=
ts: %u, algo: %s\n",
> +		 digest_cache->path_str, num_digests, h->num_slots,
> +		 hash_algo_name[algo]);
> +	return 0;
> +}
> +
> +/**
> + * digest_cache_htable_add - Add a new digest to the digest cache
> + * @digest_cache: Digest cache
> + * @digest: Digest to add
> + * @algo: Algorithm of digest
> + *
> + * This function, invoked by a digest list parser, adds a digest extract=
ed
> + * from a digest list to the digest cache.
> + *
> + * Return: Zero on success, a POSIX error code otherwise.
> + */
> +int digest_cache_htable_add(struct digest_cache *digest_cache, u8 *diges=
t,
> +			    enum hash_algo algo)
> +{
> +	struct htable *h;
> +	struct digest_cache_entry *entry;
> +	unsigned int key;
> +	int digest_len;
> +
> +	h =3D lookup_htable(digest_cache, algo);
> +	if (!h) {
> +		pr_debug("No hash table for algorithm %s was found in digest cache %s,=
 initialize one\n",
> +			 hash_algo_name[algo], digest_cache->path_str);
> +		return -ENOENT;
> +	}
> +
> +	digest_len =3D hash_digest_size[algo];
> +
> +	entry =3D kmalloc(sizeof(*entry) + digest_len, GFP_KERNEL);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	memcpy(entry->digest, digest, digest_len);
> +
> +	key =3D digest_cache_hash_key(digest, h->num_slots);
> +	hlist_add_head(&entry->hnext, &h->slots[key]);
> +	h->num_digests++;
> +	pr_debug("Added digest %s:%*phN to digest cache %s, num of %s digests: =
%llu\n",
> +		 hash_algo_name[algo], digest_len, digest,
> +		 digest_cache->path_str, hash_algo_name[algo], h->num_digests);
> +	return 0;
> +}
> +
> +/**
> + * digest_cache_htable_lookup - Search a digest in the digest cache
> + * @dentry: Dentry of the file whose digest is looked up
> + * @digest_cache: Digest cache
> + * @digest: Digest to search
> + * @algo: Algorithm of the digest to search
> + *
> + * This function searches the passed digest and algorithm in the passed =
digest
> + * cache.
> + *
> + * Return: Zero if the digest is found, -ENOENT if not.
> + */
> +int digest_cache_htable_lookup(struct dentry *dentry,
> +			       struct digest_cache *digest_cache, u8 *digest,
> +			       enum hash_algo algo)
> +{
> +	struct digest_cache_entry *entry;
> +	struct htable *h;
> +	unsigned int key;
> +	int digest_len;
> +	int search_depth =3D 0;
> +
> +	h =3D lookup_htable(digest_cache, algo);
> +	if (!h)
> +		return -ENOENT;
> +
> +	digest_len =3D hash_digest_size[algo];
> +	key =3D digest_cache_hash_key(digest, h->num_slots);
> +
> +	hlist_for_each_entry(entry, &h->slots[key], hnext) {
> +		if (!memcmp(entry->digest, digest, digest_len)) {
> +			pr_debug("Cache hit at depth %d for file %s, digest %s:%*phN in diges=
t cache %s\n",
> +				 search_depth, dentry->d_name.name,
> +				 hash_algo_name[algo], digest_len, digest,
> +				 digest_cache->path_str);
> +
> +			return 0;
> +		}
> +
> +		search_depth++;
> +	}
> +
> +	pr_debug("Cache miss for file %s, digest %s:%*phN in digest cache %s\n"=
,
> +		 dentry->d_name.name, hash_algo_name[algo], digest_len, digest,
> +		 digest_cache->path_str);
> +	return -ENOENT;
> +}
> +
> +/**
> + * digest_cache_lookup - Search a digest in the digest cache
> + * @dentry: Dentry of the file whose digest is looked up
> + * @digest_cache: Digest cache
> + * @digest: Digest to search
> + * @algo: Algorithm of the digest to search
> + *
> + * This function calls digest_cache_htable_lookup() to search a digest i=
n the
> + * passed digest cache, obtained with digest_cache_get().
> + *
> + * It returns the digest cache reference as the digest_cache_found_t typ=
e, to
> + * avoid that the digest cache is accidentally put. The digest_cache_fou=
nd_t
> + * type can be converted back to a digest cache pointer, by
> + * calling digest_cache_from_found_t().
> + *
> + * Return: A positive digest_cache_found_t if the digest is found, zero =
if not.
> + */
> +digest_cache_found_t digest_cache_lookup(struct dentry *dentry,
> +					 struct digest_cache *digest_cache,
> +					 u8 *digest, enum hash_algo algo)
> +{
> +	int ret;
> +
> +	ret =3D digest_cache_htable_lookup(dentry, digest_cache, digest, algo);
> +	return (!ret) ? (digest_cache_found_t)digest_cache : 0UL;
> +}
> +EXPORT_SYMBOL_GPL(digest_cache_lookup);
> +
> +/**
> + * digest_cache_htable_free - Free the hash tables
> + * @digest_cache: Digest cache
> + *
> + * This function removes all digests from all hash tables in the digest =
cache,
> + * and frees the memory.
> + */
> +void digest_cache_htable_free(struct digest_cache *digest_cache)
> +{
> +	struct htable *h, *h_tmp;
> +	struct digest_cache_entry *p;
> +	struct hlist_node *q;
> +	int i;
> +
> +	list_for_each_entry_safe(h, h_tmp, &digest_cache->htables, next) {
> +		for (i =3D 0; i < h->num_slots; i++) {
> +			hlist_for_each_entry_safe(p, q, &h->slots[i], hnext) {
> +				hlist_del(&p->hnext);
> +				pr_debug("Removed digest %s:%*phN from digest cache %s\n",
> +					 hash_algo_name[h->algo],
> +					 hash_digest_size[h->algo], p->digest,
> +					 digest_cache->path_str);
> +				kfree(p);
> +			}
> +		}
> +
> +		list_del(&h->next);
> +		kfree(h->slots);
> +		kfree(h);
> +	}
> +}
> diff --git a/security/digest_cache/internal.h b/security/digest_cache/int=
ernal.h
> index bbf5eefe5c82..f6ffeaa25288 100644
> --- a/security/digest_cache/internal.h
> +++ b/security/digest_cache/internal.h
> @@ -16,8 +16,40 @@
>  /* Digest cache bits in flags. */
>  #define INIT_IN_PROGRESS	0	/* Digest cache being initialized. */
> =20
> +/**
> + * struct digest_cache_entry - Entry of a digest cache hash table
> + * @hnext: Pointer to the next element in the collision list
> + * @digest: Stored digest
> + *
> + * This structure represents an entry of a digest cache hash table, stor=
ing a
> + * digest.
> + */
> +struct digest_cache_entry {
> +	struct hlist_node hnext;
> +	u8 digest[];
> +} __packed;

Please correct me if I'm wrong but I don't think __packed has any use
here as the definition of hlist_node is:


struct hlist_node {
	struct hlist_node *next, **pprev;
};

It is naturally aligned to begin with.


> +
> +/**
> + * struct htable - Hash table
> + * @next: Next hash table in the linked list
> + * @slots: Hash table slots
> + * @num_slots: Number of slots
> + * @num_digests: Number of digests stored in the hash table
> + * @algo: Algorithm of the digests
> + *
> + * This structure is a hash table storing digests of file data or metada=
ta.
> + */
> +struct htable {
> +	struct list_head next;
> +	struct hlist_head *slots;
> +	unsigned int num_slots;
> +	u64 num_digests;
> +	enum hash_algo algo;
> +};
> +
>  /**
>   * struct digest_cache - Digest cache
> + * @htables: Hash tables (one per algorithm)
>   * @ref_count: Number of references to the digest cache
>   * @path_str: Path of the digest list the digest cache was created from
>   * @flags: Control flags
> @@ -25,6 +57,7 @@
>   * This structure represents a cache of digests extracted from a digest =
list.
>   */
>  struct digest_cache {
> +	struct list_head htables;
>  	atomic_t ref_count;
>  	char *path_str;
>  	unsigned long flags;
> @@ -84,4 +117,14 @@ struct digest_cache *digest_cache_create(struct dentr=
y *dentry,
>  					 struct path *digest_list_path,
>  					 char *path_str, char *filename);
> =20
> +/* htable.c */
> +int digest_cache_htable_init(struct digest_cache *digest_cache, u64 num_=
digests,
> +			     enum hash_algo algo);
> +int digest_cache_htable_add(struct digest_cache *digest_cache, u8 *diges=
t,
> +			    enum hash_algo algo);
> +int digest_cache_htable_lookup(struct dentry *dentry,
> +			       struct digest_cache *digest_cache, u8 *digest,
> +			       enum hash_algo algo);
> +void digest_cache_htable_free(struct digest_cache *digest_cache);
> +
>  #endif /* _DIGEST_CACHE_INTERNAL_H */
> diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
> index 661c8d106791..0b201af6432c 100644
> --- a/security/digest_cache/main.c
> +++ b/security/digest_cache/main.c
> @@ -48,6 +48,7 @@ static struct digest_cache *digest_cache_alloc_init(cha=
r *path_str,
> =20
>  	atomic_set(&digest_cache->ref_count, 1);
>  	digest_cache->flags =3D 0UL;
> +	INIT_LIST_HEAD(&digest_cache->htables);
> =20
>  	pr_debug("New digest cache %s (ref count: %d)\n",
>  		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
> @@ -63,6 +64,8 @@ static struct digest_cache *digest_cache_alloc_init(cha=
r *path_str,
>   */
>  static void digest_cache_free(struct digest_cache *digest_cache)
>  {
> +	digest_cache_htable_free(digest_cache);
> +
>  	pr_debug("Freed digest cache %s\n", digest_cache->path_str);
>  	kfree(digest_cache->path_str);
>  	kmem_cache_free(digest_cache_cache, digest_cache);


BR, Jarkko

