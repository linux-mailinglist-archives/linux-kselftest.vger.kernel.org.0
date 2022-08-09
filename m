Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8857258DC8D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 18:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbiHIQzF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 12:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243307AbiHIQzE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 12:55:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A083522B17;
        Tue,  9 Aug 2022 09:55:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28D58B81658;
        Tue,  9 Aug 2022 16:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C91DC433C1;
        Tue,  9 Aug 2022 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660064100;
        bh=K8o8qgPrj5J9A6+GrMQpiR8pTGn1sY02He1mKx0vTq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jTE0oYw3+67b/0pE6Q41QON9uh/4DdFmcAh9hJFZg3bMY9/1Kl1xs0LFPJQr+3N8b
         +gIQzRv3kpEAnXPAAdSLldfDCRa/+1QhAeNhUoQpcZLzIhfEGBmVL5BMxbmzXDPZQf
         M8ip9LZjsDdy6ctxu3aQJ6k/4528n7KDv1LEqijhySaVGHZ0rfIRwl1j8p/HUvXZPC
         /E4vdgoZmfCFaVP1DV1ud0izZgkUbzDvzzt12eYtn3N/N265upkq2E5hi3GJ4c/iq8
         J23vH4L3LZEbnN0fPWVDvsMdx6Ae95pEZHxPirBzvzPLwUFeZy/D/KxWuklsuxmVuu
         ALjVGxmDAJWWA==
Date:   Tue, 9 Aug 2022 19:54:57 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
        dhowells@redhat.com, rostedt@goodmis.org, mingo@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v9 01/10] btf: Add a new kfunc flag which allows to mark
 a function to be sleepable
Message-ID: <YvKRYRjJdXbAWL6Y@kernel.org>
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
 <20220809134603.1769279-2-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809134603.1769279-2-roberto.sassu@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 09, 2022 at 03:45:54PM +0200, Roberto Sassu wrote:
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> This allows to declare a kfunc as sleepable and prevents its use in
> a non sleepable program.

Nit: "Declare a kfunc as sleepable and prevent its use in a
non-sleepable program."

It's missing the part *how* the patch accomplishes its goals.

> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Co-developed-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  Documentation/bpf/kfuncs.rst | 6 ++++++
>  include/linux/btf.h          | 1 +
>  kernel/bpf/btf.c             | 9 +++++++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index c0b7dae6dbf5..c8b21de1c772 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -146,6 +146,12 @@ that operate (change some property, perform some operation) on an object that
>  was obtained using an acquire kfunc. Such kfuncs need an unchanged pointer to
>  ensure the integrity of the operation being performed on the expected object.
>  
> +2.4.6 KF_SLEEPABLE flag
> +-----------------------
> +
> +The KF_SLEEPABLE flag is used for kfuncs that may sleep. Such kfuncs can only
> +be called by sleepable BPF programs (BPF_F_SLEEPABLE).
> +
>  2.5 Registering the kfuncs
>  --------------------------
>  
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index cdb376d53238..976cbdd2981f 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -49,6 +49,7 @@
>   * for this case.
>   */
>  #define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arguments */
> +#define KF_SLEEPABLE   (1 << 5) /* kfunc may sleep */
>  
>  struct btf;
>  struct btf_member;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 7e64447659f3..d3e4c86b8fcd 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6175,6 +6175,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  {
>  	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>  	bool rel = false, kptr_get = false, trusted_arg = false;
> +	bool sleepable = false;
>  	struct bpf_verifier_log *log = &env->log;
>  	u32 i, nargs, ref_id, ref_obj_id = 0;
>  	bool is_kfunc = btf_is_kernel(btf);
> @@ -6212,6 +6213,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  		rel = kfunc_flags & KF_RELEASE;
>  		kptr_get = kfunc_flags & KF_KPTR_GET;
>  		trusted_arg = kfunc_flags & KF_TRUSTED_ARGS;
> +		sleepable = kfunc_flags & KF_SLEEPABLE;
>  	}
>  
>  	/* check that BTF function arguments match actual types that the
> @@ -6419,6 +6421,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  			func_name);
>  		return -EINVAL;
>  	}
> +
> +	if (sleepable && !env->prog->aux->sleepable) {
> +		bpf_log(log, "kernel function %s is sleepable but the program is not\n",
> +			func_name);
> +		return -EINVAL;
> +	}
> +
>  	/* returns argument register number > 0 in case of reference release kfunc */
>  	return rel ? ref_regno : 0;
>  }
> -- 
> 2.25.1
> 

BR, Jarkko
