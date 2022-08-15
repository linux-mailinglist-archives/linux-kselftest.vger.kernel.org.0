Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F1C59336F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiHOQqw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 12:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHOQqY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 12:46:24 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9347DF78;
        Mon, 15 Aug 2022 09:46:21 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oNdE1-0003Ln-I4; Mon, 15 Aug 2022 18:46:01 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oNdE0-000T0a-SI; Mon, 15 Aug 2022 18:46:00 +0200
Subject: Re: [PATCH v11 2/9] btf: Handle dynamic pointer parameter in kfuncs
To:     Roberto Sassu <roberto.sassu@huawei.com>, ast@kernel.org,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, corbet@lwn.net, dhowells@redhat.com,
        jarkko@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
References: <20220812101902.2846182-1-roberto.sassu@huawei.com>
 <20220812101902.2846182-3-roberto.sassu@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <43277fc1-f03e-38a0-0d07-64892a67ac1d@iogearbox.net>
Date:   Mon, 15 Aug 2022 18:45:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220812101902.2846182-3-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26628/Mon Aug 15 09:51:41 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/12/22 12:18 PM, Roberto Sassu wrote:
> Allow the bpf_dynptr_kern parameter to be specified in kfuncs. Also, ensure
> that the dynamic pointer is valid and initialized.
> 
> Cc: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   include/linux/bpf_verifier.h |  3 +++
>   kernel/bpf/btf.c             | 22 ++++++++++++++++++++++
>   kernel/bpf/verifier.c        |  4 ++--
>   3 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 2e3bad8640dc..55876fbdbae2 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -560,6 +560,9 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
>   			     u32 regno);
>   int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>   		   u32 regno, u32 mem_size);
> +bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> +			      struct bpf_reg_state *reg,
> +			      enum bpf_arg_type arg_type);
>   
>   /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
>   static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index e49b3b6d48ad..86e63f2ee5da 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -195,6 +195,10 @@
>   	     i < btf_type_vlen(struct_type);					\
>   	     i++, member++)
>   
> +#define stringify_struct(x)			\
> +	({ BUILD_BUG_ON(sizeof(struct x) < 0);	\
> +	   __stringify(x); })
> +

I'd say lets move this to include/linux/btf.h with a comment explaining the BUILD_BUG_ON()
which ensures the struct actually exits.

If there's ever use outside of BTF, it could be relocated to include/linux/stringify.h.

>   DEFINE_IDR(btf_idr);
>   DEFINE_SPINLOCK(btf_idr_lock);
>   
