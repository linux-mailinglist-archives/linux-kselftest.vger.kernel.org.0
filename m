Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14C958E4ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 04:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiHJCl5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 22:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiHJCl4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 22:41:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D2CB7C8;
        Tue,  9 Aug 2022 19:41:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d16so13010980pll.11;
        Tue, 09 Aug 2022 19:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=nj31zRAcKvVnp3PgbO4ukzFmFeztnmbSMQraO9gq1VE=;
        b=GlVlmgaXgKkOszzcjWlNMF0Brvnp8/3rYUyIKZ77MkT4tssDCq5itH57hGBSs9hpPp
         2f42P8MA6+VIE46i9QP4m3KDP/ZcVgQV8HCHeJ7L+bFYjWA1ug5ppTYJIR2GVKABiayX
         r5x17WWVy2F54aDwr65loSQkzk4k5EgWOpUH7ohAhm+8l6DW9/HVvVX47xdkvf1UbNT6
         b4mDp5WO9vukyNKydz85F+bDa6OfYadtBALQwrzSG4KxHByOeFU0q9Q3Yx3mews61JNt
         /QBMq/vmDT1koH9LHdKmQCPBCBLR9LI0MjRxqCumxs+f2geqSKvbhhoO10soNiVau0TO
         +vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=nj31zRAcKvVnp3PgbO4ukzFmFeztnmbSMQraO9gq1VE=;
        b=hyWOV9DBRgH/Oa54dgZrppyKxokhpDdHDTyvJXne08k5MnZsygNODrBmG9Kljz06V/
         do77+cAhK8bKykuH7YUFM2uPvmbMUHgl3RDk5vvEtzOUPLrXVvtYe43ep8pCa0UujORx
         pYO6Yk4W0VZVDrbk8xt3QXMo6CEl5TbpEwTHoPpvOZ78PuBkPmBFAW/arOwSNQrE1xNu
         raAXOSf3YoyzLvVzEils21BpMcyaMO67oSB+hNMQN1YTGeYI3maB8Z/jyx4YtTQLA0eb
         wbJdQ1AjhT4F5MGUndIMxvIt7w6ZACmW7Z7qzBoErksYPr8k4T1BxOCm/OOoUz7YpNc2
         4Lyg==
X-Gm-Message-State: ACgBeo3jTYwDNLfzBl+hBwIpR4jKABOCXGQIdKkxR7t7vnlYp1fKqwRM
        QZgqDTZjT0VFXpS8exAgrs8=
X-Google-Smtp-Source: AA6agR64j1huylvw0Y1mqBNgafi4nxg6R9Vq19nYKoI4ywCsIOrdnjlJxQpjBCzqlb3H+tfPUYSxPg==
X-Received: by 2002:a17:90a:de8a:b0:1f4:f1ef:816d with SMTP id n10-20020a17090ade8a00b001f4f1ef816dmr1399941pjv.104.1660099313565;
        Tue, 09 Aug 2022 19:41:53 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:3fd1])
        by smtp.gmail.com with ESMTPSA id b3-20020a62a103000000b0052e6854e665sm596286pff.109.2022.08.09.19.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 19:41:52 -0700 (PDT)
Date:   Tue, 9 Aug 2022 19:41:48 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 07/10] bpf: Add bpf_verify_pkcs7_signature() kfunc
Message-ID: <20220810024148.e73df6dyurwt5d4u@macbook-pro-3.dhcp.thefacebook.com>
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
 <20220809134603.1769279-8-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809134603.1769279-8-roberto.sassu@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 09, 2022 at 03:46:00PM +0200, Roberto Sassu wrote:
> Add the bpf_verify_pkcs7_signature() kfunc, to give eBPF security modules
> the ability to check the validity of a signature against supplied data, by
> using user-provided or system-provided keys as trust anchor.
> 
> The new kfunc makes it possible to enforce mandatory policies, as eBPF
> programs might be allowed to make security decisions only based on data
> sources the system administrator approves.
> 
> The caller should provide the data to be verified and the signature as eBPF
> dynamic pointers (to minimize the number of parameters) and a bpf_key
> structure containing a reference to the keyring with keys trusted for
> signature verification, obtained from bpf_lookup_user_key() or
> bpf_lookup_system_key().
> 
> For bpf_key structures obtained from the former lookup function,
> bpf_verify_pkcs7_signature() completes the permission check deferred by
> that function by calling key_validate(). key_task_permission() is already
> called by the PKCS#7 code.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  kernel/trace/bpf_trace.c | 56 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 33ca4cfe6e26..79ba8c96735a 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -21,6 +21,7 @@
>  #include <linux/bsearch.h>
>  #include <linux/sort.h>
>  #include <linux/key.h>
> +#include <linux/verification.h>
>  
>  #include <net/bpf_sk_storage.h>
>  
> @@ -1290,6 +1291,47 @@ noinline __weak void bpf_key_put(struct bpf_key *bkey)
>  	kfree(bkey);
>  }
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
>  __diag_pop();
>  
>  BTF_SET8_START(key_kfunc_set)
> @@ -1303,11 +1345,25 @@ static const struct btf_kfunc_id_set bpf_key_kfunc_set = {
>  	.owner = THIS_MODULE,
>  	.set = &key_kfunc_set,
>  };
> +
> +#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> +BTF_SET8_START(verify_sig_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
> +BTF_SET8_END(verify_sig_kfunc_set)
> +
> +static const struct btf_kfunc_id_set bpf_verify_sig_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set = &verify_sig_kfunc_set,
> +};
> +#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
>  #endif /* CONFIG_KEYS */
>  
>  const struct btf_kfunc_id_set *kfunc_sets[] = {
>  #ifdef CONFIG_KEYS
>  	&bpf_key_kfunc_set,
> +#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> +	&bpf_verify_sig_kfunc_set,
> +#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
>  #endif /* CONFIG_KEYS */
>  };

Why different sets?
The loop over the set from the previous patch can be removed if it's just one set.
Each kfunc can be ifdef-ed independently.
