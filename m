Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CA658E397
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 01:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiHIXKJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 19:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiHIXKI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 19:10:08 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1F96D563;
        Tue,  9 Aug 2022 16:10:07 -0700 (PDT)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLYMC-0001nA-An; Wed, 10 Aug 2022 01:09:52 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLYMB-0004DM-M1; Wed, 10 Aug 2022 01:09:51 +0200
Subject: Re: [PATCH v9 07/10] bpf: Add bpf_verify_pkcs7_signature() kfunc
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
 <20220809134603.1769279-8-roberto.sassu@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6526d645-3a3e-fa4a-91a5-7da1e76a4b1d@iogearbox.net>
Date:   Wed, 10 Aug 2022 01:09:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220809134603.1769279-8-roberto.sassu@huawei.com>
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

On 8/9/22 3:46 PM, Roberto Sassu wrote:
[...]
> For bpf_key structures obtained from the former lookup function,
> bpf_verify_pkcs7_signature() completes the permission check deferred by
> that function by calling key_validate(). key_task_permission() is already
> called by the PKCS#7 code.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   kernel/trace/bpf_trace.c | 56 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 33ca4cfe6e26..79ba8c96735a 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -21,6 +21,7 @@
>   #include <linux/bsearch.h>
>   #include <linux/sort.h>
>   #include <linux/key.h>
> +#include <linux/verification.h>
>   
>   #include <net/bpf_sk_storage.h>
>   
> @@ -1290,6 +1291,47 @@ noinline __weak void bpf_key_put(struct bpf_key *bkey)
>   	kfree(bkey);
>   }
>   
> +#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> +/**
> + * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
> + * @data_ptr: data to verify
> + * @sig_ptr: signature of the data
> + * @trusted_keyring: keyring with keys trusted for signature verification
> + *
> + * Verify the PKCS#7 signature *sig_ptr* against the supplied *data_ptr*
> + * with keys in a keyring referenced by *trusted_keyring*.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +noinline __weak int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,

nit: see comment on prev patch for noinline and __weak

> +					       struct bpf_dynptr_kern *sig_ptr,
> +					       struct bpf_key *trusted_keyring)
> +{
> +	int ret;
> +
> +	if (trusted_keyring->valid_ptr) {
> +		/*
> +		 * Do the permission check deferred in bpf_lookup_user_key().
> +		 *
> +		 * A call to key_task_permission() here would be redundant, as
> +		 * it is already done by keyring_search() called by
> +		 * find_asymmetric_key().
> +		 */

In this patch and previous one, you describe that calling key_validate() is
deferred, but you should also provide the actual rationale for readers on
"why" we need to do it.

> +		ret = key_validate(trusted_keyring->key);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return verify_pkcs7_signature(data_ptr->data,
> +				      bpf_dynptr_get_size(data_ptr),
> +				      sig_ptr->data,
> +				      bpf_dynptr_get_size(sig_ptr),
> +				      trusted_keyring->key,
> +				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
> +				      NULL);
> +}
> +#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
> +
>   __diag_pop();
>   
>   BTF_SET8_START(key_kfunc_set)
> @@ -1303,11 +1345,25 @@ static const struct btf_kfunc_id_set bpf_key_kfunc_set = {
>   	.owner = THIS_MODULE,
>   	.set = &key_kfunc_set,
>   };
