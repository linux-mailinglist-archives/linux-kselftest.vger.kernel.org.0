Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5E858E333
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 00:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiHIW3r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 18:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHIW3p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 18:29:45 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC88B61DAA;
        Tue,  9 Aug 2022 15:29:44 -0700 (PDT)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLXj7-0000cV-RM; Wed, 10 Aug 2022 00:29:29 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLXj7-000JS6-3F; Wed, 10 Aug 2022 00:29:29 +0200
Subject: Re: [PATCH v9 03/10] btf: Handle dynamic pointer parameter in kfuncs
To:     Roberto Sassu <roberto.sassu@huawei.com>, ast@kernel.org,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        corbet@lwn.net, dhowells@redhat.com, jarkko@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
 <20220809134603.1769279-4-roberto.sassu@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6fca828f-9117-2a1a-b386-6167fc3384aa@iogearbox.net>
Date:   Wed, 10 Aug 2022 00:29:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220809134603.1769279-4-roberto.sassu@huawei.com>
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
[...]
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 67dfc728fbf8..17cca396c89f 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6363,6 +6363,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>   
>   			if (is_kfunc) {
>   				bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
> +				bool arg_dynptr = btf_type_is_struct(ref_t) &&
> +						  !strcmp(ref_tname, "bpf_dynptr_kern");
>   
>   				/* Permit pointer to mem, but only when argument
>   				 * type is pointer to scalar, or struct composed
> @@ -6372,6 +6374,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>   				 */
>   				if (!btf_type_is_scalar(ref_t) &&
>   				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
> +				    !arg_dynptr &&
>   				    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
>   					bpf_log(log,
>   						"arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
> @@ -6379,6 +6382,20 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>   					return -EINVAL;
>   				}
>   
> +				/* Assume initialized dynptr. */

This comment is a bit misleading, too, given we don't assume but enforce it. I'd probably
just fold this into above one where we permit pointer to mem given the test there gets
extended anyway, so the comment should be in line with the tests.

> +				if (arg_dynptr) {
> +					if (!is_dynptr_reg_valid_init(env, reg,
> +							ARG_PTR_TO_DYNPTR)) {
> +						bpf_log(log,
> +							"arg#%d pointer type %s %s must be initialized\n",
> +							i, btf_type_str(ref_t),
> +							ref_tname);
> +						return -EINVAL;
> +					}
> +
> +					continue;
> +				}
> +
>   				/* Check for mem, len pair */
>   				if (arg_mem_size) {
>   					if (check_kfunc_mem_size_reg(env, &regs[regno + 1], regno + 1)) {

