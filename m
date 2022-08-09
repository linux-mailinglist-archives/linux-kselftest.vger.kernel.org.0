Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ED758E368
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 00:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiHIWxo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 18:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHIWxn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 18:53:43 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E8A6612C;
        Tue,  9 Aug 2022 15:53:41 -0700 (PDT)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLY6F-000BWl-D5; Wed, 10 Aug 2022 00:53:23 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLY6E-000IAn-NK; Wed, 10 Aug 2022 00:53:22 +0200
Subject: Re: [PATCH v9 06/10] bpf: Add bpf_lookup_*_key() and bpf_key_put()
 kfuncs
To:     Roberto Sassu <roberto.sassu@huawei.com>, ast@kernel.org,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        corbet@lwn.net, dhowells@redhat.com, jarkko@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
 <20220809134603.1769279-7-roberto.sassu@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2b1d62ad-af4b-4694-ecc8-639fbd821a05@iogearbox.net>
Date:   Wed, 10 Aug 2022 00:53:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220809134603.1769279-7-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26622/Tue Aug  9 09:53:52 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/9/22 3:45 PM, Roberto Sassu wrote:
> Add the bpf_lookup_user_key(), bpf_lookup_system_key() and bpf_key_put()
> kfuncs, to respectively search a key with a given serial and flags, obtain
> a key from a pre-determined ID defined in include/linux/verification.h, and
> cleanup.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   include/linux/bpf.h      |   6 ++
>   kernel/trace/bpf_trace.c | 151 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 157 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 0d56c23cc504..564b9e0b8c16 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2572,4 +2572,10 @@ static inline void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype) {}
>   static inline void bpf_cgroup_atype_put(int cgroup_atype) {}
>   #endif /* CONFIG_BPF_LSM */
>   
> +#ifdef CONFIG_KEYS
> +struct bpf_key {
> +	struct key *key;
> +	bool valid_ptr;
> +};
> +#endif /* CONFIG_KEYS */
>   #endif /* _LINUX_BPF_H */
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 68e5cdd24cef..33ca4cfe6e26 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -20,6 +20,7 @@
>   #include <linux/fprobe.h>
>   #include <linux/bsearch.h>
>   #include <linux/sort.h>
> +#include <linux/key.h>
>   
>   #include <net/bpf_sk_storage.h>
>   
> @@ -1181,6 +1182,156 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
>   	.arg1_type	= ARG_PTR_TO_CTX,
>   };
>   
> +#ifdef CONFIG_KEYS
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "kfuncs which will be used in BPF programs");
> +
> +/**
> + * bpf_lookup_user_key - lookup a key by its serial
> + * @serial: key serial
> + * @flags: lookup-specific flags
> + *
> + * Search a key with a given *serial* and the provided *flags*. The
> + * returned key, if found, has the reference count incremented by
> + * one, and is stored in a bpf_key structure, returned to the caller.
> + * The bpf_key structure must be passed to bpf_key_put() when done
> + * with it, so that the key reference count is decremented and the
> + * bpf_key structure is freed.
> + *
> + * Permission checks are deferred to the time the key is used by
> + * one of the available key-specific kfuncs.
> + *
> + * Set *flags* with 1, to attempt creating a requested special
> + * keyring (e.g. session keyring), if it doesn't yet exist. Set
> + * *flags* with 2 to lookup a key without waiting for the key
> + * construction, and to retrieve uninstantiated keys (keys without
> + * data attached to them).
> + *
> + * Return: a bpf_key pointer with a valid key pointer if the key is found, a
> + *         NULL pointer otherwise.
> + */
> +noinline __weak struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)

Why the need for noinline and the __weak here and below? (If indeed needed this
should probably be explained in the commit desc.)

> +{
> +	key_ref_t key_ref;
> +	struct bpf_key *bkey;
> +
> +	/* Keep in sync with include/linux/key.h. */
> +	if (flags > (KEY_LOOKUP_PARTIAL << 1) - 1)

Can't we just simplify and test flags & ~(KEY_LOOKUP_CREATE|KEY_LOOKUP_PARTIAL)?

> +		return NULL;
> +
> +	/* Permission check is deferred until actual kfunc using the key. */
> +	key_ref = lookup_user_key(serial, flags, KEY_DEFER_PERM_CHECK);
> +	if (IS_ERR(key_ref))
> +		return NULL;
> +
> +	bkey = kmalloc(sizeof(*bkey), GFP_KERNEL);
> +	if (!bkey) {
> +		key_put(key_ref_to_ptr(key_ref));
> +		return bkey;

nit: just return NULL probably cleaner

> +	}
> +
> +	bkey->key = key_ref_to_ptr(key_ref);
> +	bkey->valid_ptr = true;

nit: I'd probably rename s/valid_ptr/has_ref/.

> +	return bkey;
> +}
> +
> +/**
> + * bpf_lookup_system_key - lookup a key by a system-defined ID
> + * @id: key ID
> + *
> + * Obtain a bpf_key structure with a key pointer set to the passed key ID.
> + * The key pointer is marked as invalid, to prevent bpf_key_put() from
> + * attempting to decrement the key reference count on that pointer. The key
> + * pointer set in such way is currently understood only by
> + * verify_pkcs7_signature().
> + *
> + * Set *id* to one of the values defined in include/linux/verification.h:
> + * 0 for the primary keyring (immutable keyring of system keys); 1 for both
> + * the primary and secondary keyring (where keys can be added only if they
> + * are vouched for by existing keys in those keyrings); 2 for the platform
> + * keyring (primarily used by the integrity subsystem to verify a kexec'ed
> + * kerned image and, possibly, the initramfs signature).
> + *
> + * Return: a bpf_key pointer with an invalid key pointer set from the
> + *         pre-determined ID on success, a NULL pointer otherwise
> + */
> +noinline __weak struct bpf_key *bpf_lookup_system_key(u64 id)
> +{
> +	struct bpf_key *bkey;
> +
> +	/* Keep in sync with defs in include/linux/verification.h. */
> +	if (id > (unsigned long)VERIFY_USE_PLATFORM_KEYRING)
> +		return NULL;
> +
> +	bkey = kmalloc(sizeof(*bkey), GFP_KERNEL);

nit: Can't this be GFP_ATOMIC? Then bpf_lookup_system_key doesn't need KF_SLEEPABLE
attribute, fwiw. Overall, the bpf_lookup_{system,user}_key() look reasonable.

> +	if (!bkey)
> +		return bkey;
> +
> +	bkey->key = (struct key *)(unsigned long)id;
> +	bkey->valid_ptr = false;
> +
> +	return bkey;
> +}
> +
> +/**
> + * bpf_key_put - decrement key reference count if key is valid and free bpf_key
> + * @bkey: bpf_key structure
> + *
> + * Decrement the reference count of the key inside *bkey*, if the pointer
> + * is valid, and free *bkey*.
> + */
> +noinline __weak void bpf_key_put(struct bpf_key *bkey)
> +{
> +	if (bkey->valid_ptr)
> +		key_put(bkey->key);
> +
> +	kfree(bkey);
> +}
> +
> +__diag_pop();
> +
> +BTF_SET8_START(key_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_lookup_system_key,
> +	     KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
> +BTF_SET8_END(key_kfunc_set)
> +
> +static const struct btf_kfunc_id_set bpf_key_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set = &key_kfunc_set,
> +};
> +#endif /* CONFIG_KEYS */
> +
> +const struct btf_kfunc_id_set *kfunc_sets[] = {
> +#ifdef CONFIG_KEYS
> +	&bpf_key_kfunc_set,
> +#endif /* CONFIG_KEYS */
> +};
